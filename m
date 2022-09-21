Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF611C6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIUPhH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiIUPgu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:36:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7519C27
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774394; x=1695310394;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=07ZPPtjNGRRPAeJ6ByCNlodiwJ32TN9ANhK8apa+2uY=;
  b=QYaUGei7tOr6+/7V+UGcH+Va9SQfZefyT3qT5lJUFDaZ0PHo3a1FzDwd
   cJtca/HIKktqFjZDPgVFJS45Tg1FUqyvnLbPw5nfk1Zh+JbyNkRuBZtlW
   CHK/T60Dp7jMi/OZWs+YbRdxwtPw0qmCZ2ziwpPN1jrrROSeC4osHdGOw
   pyu4A18iur+hViMBi+GRu61MT5Mv4D+JWo4wEXCR8SeMePONE/n9pluXO
   cuUdt2FnEC/ZiT5EEy4PplzH49pNcOlqyejFkrpDyluURyqgn748ylycO
   cxZwYyV9eEuKIeXZ4UiLE91Y5q7UiHQcpXHChPJAcQfKoY3B7rEoO912/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300022067"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300022067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:31:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="652579051"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:31:51 -0700
Subject: [PATCH v2 04/19] cxl/pmem: Add "Set Passphrase" security command
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:31:51 -0700
Message-ID: <166377431129.430546.9754430497259586325.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      |    1 +
 drivers/cxl/cxlmem.h         |   15 +++++++++++++++
 drivers/cxl/security.c       |   22 ++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |    1 +
 4 files changed, 39 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8f4be61a76b5..cc08383499e6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -66,6 +66,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
+	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 25d1d8fa7d1e..725b08148524 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -274,6 +274,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
+	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -380,6 +381,20 @@ struct cxl_mem_command {
 #define CXL_PMEM_SEC_STATE_USER_PLIMIT		0x10
 #define CXL_PMEM_SEC_STATE_MASTER_PLIMIT	0x20
 
+/* set passphrase input payload */
+struct cxl_set_pass {
+	u8 type;
+	u8 reserved[31];
+	/* CXL field using NVDIMM define, same length */
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
index 806173084216..5365646230c3 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -49,8 +49,30 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
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
+	struct cxl_set_pass set_pass;
+	int rc;
+
+	set_pass.type = ptype == NVDIMM_MASTER ?
+		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	memcpy(set_pass.old_pass, old_data->data, NVDIMM_PASSPHRASE_LEN);
+	memcpy(set_pass.new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
+			       &set_pass, sizeof(set_pass), NULL, 0);
+	return rc;
+}
+
 static const struct nvdimm_security_ops __cxl_security_ops = {
 	.get_flags = cxl_pmem_get_security_flags,
+	.change_key = cxl_pmem_security_change_key,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index cdc6049683ce..9da047e9b038 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -42,6 +42,7 @@
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(GET_SECURITY_STATE, "Get Security State"),			  \
+	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a


