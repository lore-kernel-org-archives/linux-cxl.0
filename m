Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Apr 2022 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiDAVpH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbiDAVpG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Apr 2022 17:45:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DAF2662F1
        for <linux-cxl@vger.kernel.org>; Fri,  1 Apr 2022 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648849395; x=1680385395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vPZeXZLQtdp4RQO6zcefGXyEtYMwmC1IBJcPYDEsFa0=;
  b=dDIkDGtIR0FcZ5jaUaRFsGmwy9ODwVBqm3/ncLwXnCTdN7I5AGeJ7MG9
   3QLdxTd0bA1wgRHMR2Bpam3+74xMvhiac8+ryDfe5dcpIRWBbIDqjpIzK
   D/6VMPiIvk7MHQX8+TTIL978vg/cspmW+fVxiFKJg0bS4/o1EAvEdphLU
   k1CD49AgAAZb6k/3Eq4RIlDgxWQpY6rrZBOk34x//Fl6UQMy0uEh0ZcD3
   0jngmX1gd4pEbCwT1/KyA6tWBNCnwxf8/uBf38h99+mC5nwBrktfytlSJ
   AluWtIrbU5p9pGgrZGYe33eYIFeTgbd8V2UZTKRsxCpIdF5YXgB4NnRHC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346675729"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="346675729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:43:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="656049493"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:43:15 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/core: Rename functions that handle mbox commands
Date:   Fri,  1 Apr 2022 14:45:30 -0700
Message-Id: <20220401214530.1188359-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Mailbox commands are sent to the hardware either on behalf of
userspace (IOCTLs) or by internal kernel users. Update the
naming scheme to delineate the IOCTL versus internal pathways
and to more accurately reflect the work each function performs.

IOCTL pathway functions:
cxl_ioctl_query()		prev: cxl_query_cmd()
cxl_ioctl_send()		prev: cxl_send_cmd()
cxl_ioctl_send_checks()		prev: cxl_validate_cmd_from_user()
cxl_ioctl_send_to_kbuf()	prev: handle_mailbox_cmd_from_user()

Internal pathway functions:
cxl_internal_cmd_send()		prev: cxl_mbox_send_cmd()
cxl_pci_mbox_send()		prev: cxl_pci_mbox_send() (no change)

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Dan - I can rebase on top of cxl/preview next week if that is
preferable. Let me know. Meanwhile, let's see how folks like 
the new names.


 drivers/cxl/core/core.h   |  6 ++---
 drivers/cxl/core/mbox.c   | 55 +++++++++++++++++++--------------------
 drivers/cxl/core/memdev.c |  4 +--
 drivers/cxl/cxlmem.h      |  4 +--
 drivers/cxl/pmem.c        | 11 ++++----
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index d345c76373f1..2f5dbaca832e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -15,9 +15,9 @@ extern struct device_attribute dev_attr_delete_region;
 
 struct cxl_send_command;
 struct cxl_mem_query_commands;
-int cxl_query_cmd(struct cxl_memdev *cxlmd,
-		  struct cxl_mem_query_commands __user *q);
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
+int cxl_ioctl_query(struct cxl_memdev *cxlmd,
+		    struct cxl_mem_query_commands __user *q);
+int cxl_ioctl_send(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 839207b627a8..4c779e9444d2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -139,7 +139,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 }
 
 /**
- * cxl_mbox_send_cmd() - Send a mailbox command to a device.
+ * cxl_internal_cmd_send() - Send a mailbox command to a device.
  * @cxlds: The device data for the operation
  * @opcode: Opcode for the mailbox command.
  * @in: The input payload for the mailbox command.
@@ -160,8 +160,8 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size)
+int cxl_internal_cmd_send(struct cxl_dev_state *cxlds, u16 opcode, void *in,
+			  size_t in_size, void *out, size_t out_size)
 {
 	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 	struct cxl_mbox_cmd mbox_cmd = {
@@ -193,7 +193,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_internal_cmd_send, CXL);
 
 static bool cxl_mem_raw_command_allowed(u16 opcode)
 {
@@ -375,7 +375,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 }
 
 /**
- * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * cxl_ioctl_send_checks() - Check userspace send request
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
@@ -391,9 +391,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  * The result of this command is a fully validated command in @mbox_cmd that is
  * safe to send to the hardware.
  */
-static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
-				      struct cxl_dev_state *cxlds,
-				      const struct cxl_send_command *send_cmd)
+static int cxl_ioctl_send_checks(struct cxl_mbox_cmd *mbox_cmd,
+				 struct cxl_dev_state *cxlds,
+				 const struct cxl_send_command *send_cmd)
 {
 	struct cxl_mem_command mem_cmd;
 	int rc;
@@ -424,8 +424,8 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 				 send_cmd->in.payload);
 }
 
-int cxl_query_cmd(struct cxl_memdev *cxlmd,
-		  struct cxl_mem_query_commands __user *q)
+int cxl_ioctl_query(struct cxl_memdev *cxlmd,
+		    struct cxl_mem_query_commands __user *q)
 {
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
@@ -459,7 +459,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 }
 
 /**
- * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
+ * cxl_ioctl_send_to_kbuf() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
  * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
@@ -479,12 +479,11 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
  * Dispatches a mailbox command on behalf of a userspace request.
  * The output payload is copied to userspace.
  *
- * See cxl_send_cmd().
+ * See cxl_ioctl_send().
  */
-static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
-					struct cxl_mbox_cmd *mbox_cmd,
-					u64 out_payload, s32 *size_out,
-					u32 *retval)
+static int cxl_ioctl_send_to_kbuf(struct cxl_dev_state *cxlds,
+				  struct cxl_mbox_cmd *mbox_cmd,
+				  u64 out_payload, s32 *size_out, u32 *retval)
 {
 	struct device *dev = cxlds->dev;
 	int rc;
@@ -523,7 +522,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+int cxl_ioctl_send(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxlmd->dev;
@@ -536,12 +535,12 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
+	rc = cxl_ioctl_send_checks(&mbox_cmd, cxlmd->cxlds, &send);
 	if (rc)
 		return rc;
 
-	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
-					  &send.out.size, &send.retval);
+	rc = cxl_ioctl_send_to_kbuf(cxlds, &mbox_cmd, send.out.payload,
+				    &send.out.size, &send.retval);
 	if (rc)
 		return rc;
 
@@ -565,8 +564,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		};
 		int rc;
 
-		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
-				       out, xfer_size);
+		rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_GET_LOG, &log,
+					   sizeof(log), out, xfer_size);
 		if (rc < 0)
 			return rc;
 
@@ -618,8 +617,8 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
-			       cxlds->payload_size);
+	rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL,
+				   0, ret, cxlds->payload_size);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -723,8 +722,8 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
 	} __packed pi;
 	int rc;
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
-			       &pi, sizeof(pi));
+	rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL,
+				   0, &pi, sizeof(pi));
 
 	if (rc)
 		return rc;
@@ -756,8 +755,8 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	struct cxl_mbox_identify id;
 	int rc;
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
-			       sizeof(id));
+	rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
+				   sizeof(id));
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ad8c9f61c38a..1962511df769 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -268,9 +268,9 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 {
 	switch (cmd) {
 	case CXL_MEM_QUERY_COMMANDS:
-		return cxl_query_cmd(cxlmd, (void __user *)arg);
+		return cxl_ioctl_query(cxlmd, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxlmd, (void __user *)arg);
+		return cxl_ioctl_send(cxlmd, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index dee574527e50..2719c0430440 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -296,8 +296,8 @@ struct cxl_mem_command {
 #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
 };
 
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size);
+int cxl_internal_cmd_send(struct cxl_dev_state *cxlds, u16 opcode, void *in,
+		size_t in_size, void *out, size_t out_size);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
 int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 35c6f3af18f2..4c19defa77ff 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -112,8 +112,9 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 		.length = cmd->in_length,
 	};
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
-			       sizeof(get_lsa), cmd->out_buf, cmd->in_length);
+	rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
+				   sizeof(get_lsa), cmd->out_buf,
+				   cmd->in_length);
 	cmd->status = 0;
 
 	return rc;
@@ -143,9 +144,9 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 	};
 	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
-			       struct_size(set_lsa, data, cmd->in_length),
-			       NULL, 0);
+	rc = cxl_internal_cmd_send(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
+				   struct_size(set_lsa, data, cmd->in_length),
+				   NULL, 0);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input

base-commit: 9b688fc651b9d2b633e8d959454670aba1c39162
prerequisite-patch-id: 2b66d88f7526f26eb5fb1a42721d3fbde4da20ad
prerequisite-patch-id: cfd4e0a4c852002789432c11abbebfa8b21616a3
prerequisite-patch-id: dbf2fd54ad4926ccd3b1910a534dba7c01c85af6
prerequisite-patch-id: e875aafbd5c11ca5abdba3e4a81122fd034007a6
prerequisite-patch-id: 5dfa246306ae578c294eafb19381658d54497137
prerequisite-patch-id: 0339fd1db77bf0c090ce0aac9481fab439b205c5
prerequisite-patch-id: b4fefc6fb780e7b1cd830f6702012f61f88f5496
prerequisite-patch-id: 74d6bf0328e6452120751b69e84aabca3fecdd0a
prerequisite-patch-id: ece44797d2d18194a9d34b93bba88e5358ffe782
-- 
2.31.1

