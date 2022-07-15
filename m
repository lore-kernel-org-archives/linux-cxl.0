Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0825AC43334
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGOVI6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGOVI5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:08:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E673B94F
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919336; x=1689455336;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTg2OVhCAgGBjenPtHjfpLVSV12FtAaPcU6oPUV5O/U=;
  b=j2OHczIEoD5NrG2HX7+30X6qgmZN98LCbjOxCYfMBF/6plp8DinlwWw1
   23vz6c3+M4+HH8eK2a2jiu6ad4dJPuc5uuhNJ8P+ZC2hNLU7r0he/t1/l
   pXlK9he3Fg8PyU0oKLt6Dd5VtgzWRnIfYxslmKMSjE+O/MHM2tmFSQk0c
   3vfDguaeRWe32WYrWUblGJ2NaH/921DFJ0hUzJAkv17R/HGqtlS1zZnh5
   1lR+NQ4BV6TYgsTulDzXUePmLb7ThNBQtY9e/gVmBII7NOCY4j4QM3xgL
   TZSrF7pkb8FavJG/54O2WbxBjf6jC9VA0FX8wUq9ijEOdF21wrn9P0lE1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="285927319"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="285927319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="593873333"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:55 -0700
Subject: [PATCH RFC 04/15] cxl/pmem: Add "Set Passphrase" security command
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:08:55 -0700
Message-ID: <165791933557.2491387.2141316283759403219.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create callback function to support the nvdimm_security_ops ->change_key()
callback. Translate the operation to send "Set Passphrase" security command
for CXL memory device. The operation supports setting a passphrase for the
CXL persistent memory device. It also supports the changing of the
currently set passphrase. The operation allows manipulation of a user
passphrase or a master passphrase.

See CXL 2.0 spec section 8.2.9.5.6.2 for reference.

However, the spec leaves a gap WRT master passphrase usages. The spec does
not define any ways to retrieve the status of if the support of master
passphrase is available for the device, nor does the commands that utilize
master passphrase will return a specific error that indicates master
passphrase is not supported. If using a device does not support master
passphrase and a command is issued with a master passphrase, the error
message returned by the device will be ambiguos.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h   |   14 ++++++++++++++
 drivers/cxl/security.c |   27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 35de2889aac3..1e76d22f4fd2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -251,6 +251,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
+	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -350,6 +351,19 @@ struct cxl_mem_command {
 #define CXL_PMEM_SEC_STATE_USER_PLIMIT		0x10
 #define CXL_PMEM_SEC_STATE_MASTER_PLIMIT	0x20
 
+/* set passphrase input payload */
+struct cxl_set_pass {
+	u8 type;
+	u8 reserved[31];
+	u8 old_pass[NVDIMM_PASSPHRASE_LEN];
+	u8 new_pass[NVDIMM_PASSPHRASE_LEN];
+} __packed;
+
+enum {
+	CXL_PMEM_SEC_PASS_MASTER = 0,
+	CXL_PMEM_SEC_PASS_USER,
+};
+
 int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		      size_t in_size, void *out, size_t out_size);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 5b830ae621db..76ec5087f966 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -50,8 +50,35 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	return security_flags;
 }
 
+static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
+					const struct nvdimm_key_data *old_data,
+					const struct nvdimm_key_data *new_data,
+					enum nvdimm_passphrase_type ptype)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_set_pass *set_pass;
+	int rc;
+
+	set_pass = kzalloc(sizeof(*set_pass), GFP_KERNEL);
+	if (!set_pass)
+		return -ENOMEM;
+
+	set_pass->type = ptype == NVDIMM_MASTER ?
+		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	memcpy(set_pass->old_pass, old_data->data, NVDIMM_PASSPHRASE_LEN);
+	memcpy(set_pass->new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
+			       set_pass, sizeof(*set_pass), NULL, 0);
+	kfree(set_pass);
+	return rc;
+}
+
 static const struct nvdimm_security_ops __cxl_security_ops = {
 	.get_flags = cxl_pmem_get_security_flags,
+	.change_key = cxl_pmem_security_change_key,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;


