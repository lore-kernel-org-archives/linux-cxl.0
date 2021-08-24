Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2214C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73F76135F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhHXQIp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:08:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:10587 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232206AbhHXQIo (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:08:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="278355967"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="278355967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="473541669"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:18 -0700
Subject: [PATCH v3 21/28] cxl/pmem: Translate NVDIMM label commands to CXL
 label commands
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:07:18 -0700
Message-ID: <162982123813.1124374.3721946437291753388.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The LIBNVDIMM IOCTL UAPI calls back to the nvdimm-bus-provider to
translate the Linux command payload to the device native command format.
The LIBNVDIMM commands get-config-size, get-config-data, and
set-config-data, map to the CXL memory device commands device-identify,
get-lsa, and set-lsa. Recall that the label-storage-area (LSA) on an
NVDIMM device arranges for the provisioning of namespaces. Additionally
for CXL the LSA is used for provisioning regions as well.

The data from device-identify is already cached in the 'struct cxl_mem'
instance associated with @cxl_nvd, so that payload return is simply
crafted and no CXL command is issued. The conversion for get-lsa is
straightforward, but the conversion for set-lsa requires an allocation
to append the set-lsa header in front of the payload.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pmem.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 469b984176a2..6cc76302c8f8 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -52,10 +52,10 @@ static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	unsigned long flags = 0, cmd_mask = 0;
 	struct cxl_mem *cxlm = cxlmd->cxlm;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct nvdimm *nvdimm = NULL;
-	unsigned long flags = 0;
 	int rc = -ENXIO;
 
 	cxl_nvb = cxl_find_nvdimm_bridge();
@@ -69,8 +69,11 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_exclusive_cxl_commands(cxlm, exclusive_cmds);
 
 	set_bit(NDD_LABELING, &flags);
-	nvdimm = nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags, 0, 0,
-			       NULL);
+	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
+	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
+	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
+	nvdimm = nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags,
+			       cmd_mask, 0, NULL);
 	dev_set_drvdata(dev, nvdimm);
 	rc = devm_add_action_or_reset(dev, unregister_nvdimm, cxl_nvd);
 out:
@@ -89,11 +92,121 @@ static struct cxl_driver cxl_nvdimm_driver = {
 	.id = CXL_DEVICE_NVDIMM,
 };
 
+static int cxl_pmem_get_config_size(struct cxl_mem *cxlm,
+				    struct nd_cmd_get_config_size *cmd,
+				    unsigned int buf_len, int *cmd_rc)
+{
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+
+	*cmd = (struct nd_cmd_get_config_size) {
+		 .config_size = cxlm->lsa_size,
+		 .max_xfer = cxlm->payload_size,
+	};
+	*cmd_rc = 0;
+
+	return 0;
+}
+
+static int cxl_pmem_get_config_data(struct cxl_mem *cxlm,
+				    struct nd_cmd_get_config_data_hdr *cmd,
+				    unsigned int buf_len, int *cmd_rc)
+{
+	struct cxl_mbox_get_lsa {
+		u32 offset;
+		u32 length;
+	} get_lsa;
+	int rc;
+
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+	if (struct_size(cmd, out_buf, cmd->in_length) > buf_len)
+		return -EINVAL;
+
+	get_lsa = (struct cxl_mbox_get_lsa) {
+		.offset = cmd->in_offset,
+		.length = cmd->in_length,
+	};
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_LSA, &get_lsa,
+				   sizeof(get_lsa), cmd->out_buf,
+				   cmd->in_length);
+	cmd->status = 0;
+	*cmd_rc = 0;
+
+	return rc;
+}
+
+static int cxl_pmem_set_config_data(struct cxl_mem *cxlm,
+				    struct nd_cmd_set_config_hdr *cmd,
+				    unsigned int buf_len, int *cmd_rc)
+{
+	struct cxl_mbox_set_lsa {
+		u32 offset;
+		u32 reserved;
+		u8 data[];
+	} *set_lsa;
+	int rc;
+
+	if (sizeof(*cmd) > buf_len)
+		return -EINVAL;
+
+	/* 4-byte status follows the input data in the payload */
+	if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
+		return -EINVAL;
+
+	set_lsa =
+		kvzalloc(struct_size(set_lsa, data, cmd->in_length), GFP_KERNEL);
+	if (!set_lsa)
+		return -ENOMEM;
+
+	*set_lsa = (struct cxl_mbox_set_lsa) {
+		.offset = cmd->in_offset,
+	};
+	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_SET_LSA, set_lsa,
+				   struct_size(set_lsa, data, cmd->in_length),
+				   NULL, 0);
+
+	/* set "firmware" status */
+	*(u32 *) &cmd->in_buf[cmd->in_length] = 0;
+	*cmd_rc = 0;
+	kvfree(set_lsa);
+
+	return rc;
+}
+
+static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
+			       void *buf, unsigned int buf_len, int *cmd_rc)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	if (!test_bit(cmd, &cmd_mask))
+		return -ENOTTY;
+
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		return cxl_pmem_get_config_size(cxlm, buf, buf_len, cmd_rc);
+	case ND_CMD_GET_CONFIG_DATA:
+		return cxl_pmem_get_config_data(cxlm, buf, buf_len, cmd_rc);
+	case ND_CMD_SET_CONFIG_DATA:
+		return cxl_pmem_set_config_data(cxlm, buf, buf_len, cmd_rc);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
 			struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 			unsigned int buf_len, int *cmd_rc)
 {
-	return -ENOTTY;
+	if (!nvdimm)
+		return -ENOTTY;
+	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len, cmd_rc);
 }
 
 static bool online_nvdimm_bus(struct cxl_nvdimm_bridge *cxl_nvb)

