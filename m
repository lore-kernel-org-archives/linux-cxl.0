Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7D6C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLFEWj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiLFEWg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:22:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F6305
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300554; x=1701836554;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LX7wW52m0r3M4yqXvX1ht/xN8wei+csK75c/kXYmTg0=;
  b=S0WcdK37X8cfTaKpNuhcHxHAy2j56q8D/iHRhd62a+P8lJXqB4QFUuun
   yAugJwFFSd6y4UTQZOkgb7Xufb7EUHNNR5ak509FnQvOnfGc+aAaj2own
   vVaLpfgebTBPksUz9dgSJaklWHyOtbWbya2U705cSJdrv6VhaQhuJ+leF
   ACA7u6YM7umv3fqVeeF/CW1Tmkru405CPcoR6zO1iCVrUhrV7W6ZMOvzm
   OLVy8ZiyASHIePqcvjMGfsxlDEXwKyCBKXnZHpncvw1ByHm53rJZRwJAY
   6m2XFLMekGtLytPKOuxUTac5UGVlzT5FDy9kKKyB+5dfLnWnFNxk7hrm9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315238658"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315238658"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639733729"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="639733729"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:33 -0800
Subject: [PATCH 2/4] cxl/mbox: Enable cxl_mbox_send_cmd() users to validate
 output size
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.jiang@intel.com, ira.weiny@intel.com
Date:   Mon, 05 Dec 2022 20:22:33 -0800
Message-ID: <167030055370.4044561.17788093375112783036.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Internally cxl_mbox_send_cmd() converts all passed-in parameters to a
'struct cxl_mbox_cmd' instance and sends that to cxlds->mbox_send(). It
then teases the possibilty that the caller can validate the output size.
However, they cannot since the resulting output size is not conveyed to
the called. Fix that by making the caller pass in a constructed 'struct
cxl_mbox_cmd'. This prepares for a future patch to add output size
validation on a per-command basis.

Given the change in signature, also change the name to differentiate it
from the user command submission path that performs more validation
before generating the 'struct cxl_mbox_cmd' instance to execute.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |   86 ++++++++++++++++++++++++++++-------------------
 drivers/cxl/cxlmem.h    |    4 +-
 drivers/cxl/pmem.c      |   21 +++++++++--
 drivers/cxl/security.c  |   77 +++++++++++++++++++++++++++++++-----------
 4 files changed, 126 insertions(+), 62 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 35dd889f1d3a..ed451ca60ce5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -146,13 +146,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 }
 
 /**
- * cxl_mbox_send_cmd() - Send a mailbox command to a device.
+ * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
  * @cxlds: The device data for the operation
- * @opcode: Opcode for the mailbox command.
- * @in: The input payload for the mailbox command.
- * @in_size: The length of the input payload
- * @out: Caller allocated buffer for the output.
- * @out_size: Expected size of output.
+ * @mbox_cmd: initialized command to execute
  *
  * Context: Any context.
  * Return:
@@ -167,40 +163,37 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size)
+int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
+			  struct cxl_mbox_cmd *mbox_cmd)
 {
-	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
-	struct cxl_mbox_cmd mbox_cmd = {
-		.opcode = opcode,
-		.payload_in = in,
-		.size_in = in_size,
-		.size_out = out_size,
-		.payload_out = out,
-	};
+	const struct cxl_mem_command *cmd =
+		cxl_mem_find_command(mbox_cmd->opcode);
+	size_t out_size;
 	int rc;
 
-	if (in_size > cxlds->payload_size || out_size > cxlds->payload_size)
+	if (mbox_cmd->size_in > cxlds->payload_size ||
+	    mbox_cmd->size_out > cxlds->payload_size)
 		return -E2BIG;
 
-	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+	out_size = mbox_cmd->size_out;
+	rc = cxlds->mbox_send(cxlds, mbox_cmd);
 	if (rc)
 		return rc;
 
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
-		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
+		return cxl_mbox_cmd_rc2errno(mbox_cmd);
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
 	 * caller to do that if they wish.
 	 */
 	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
-		if (mbox_cmd.size_out != out_size)
+		if (mbox_cmd->size_out != out_size)
 			return -EIO;
 	}
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
 
 static bool cxl_mem_raw_command_allowed(u16 opcode)
 {
@@ -567,15 +560,25 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 
 	while (remaining) {
 		u32 xfer_size = min_t(u32, remaining, cxlds->payload_size);
-		struct cxl_mbox_get_log log = {
+		struct cxl_mbox_cmd mbox_cmd;
+		struct cxl_mbox_get_log log;
+		int rc;
+
+		log = (struct cxl_mbox_get_log) {
 			.uuid = *uuid,
 			.offset = cpu_to_le32(offset),
-			.length = cpu_to_le32(xfer_size)
+			.length = cpu_to_le32(xfer_size),
+		};
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_LOG,
+			.size_in = sizeof(log),
+			.payload_in = &log,
+			.size_out = xfer_size,
+			.payload_out = out,
 		};
-		int rc;
 
-		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
-				       out, xfer_size);
+		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 		if (rc < 0)
 			return rc;
 
@@ -621,19 +624,25 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxlds)
 {
 	struct cxl_mbox_get_supported_logs *ret;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	ret = kvmalloc(cxlds->payload_size, GFP_KERNEL);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
-			       cxlds->payload_size);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
+		.size_out = cxlds->payload_size,
+		.payload_out = ret,
+	};
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
 	}
 
+
 	return ret;
 }
 
@@ -735,11 +744,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
 {
 	struct cxl_mbox_get_partition_info pi;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
-			       &pi, sizeof(pi));
-
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_PARTITION_INFO,
+		.size_out = sizeof(pi),
+		.payload_out = &pi,
+	};
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc)
 		return rc;
 
@@ -768,10 +781,15 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 {
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
-			       sizeof(id));
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_IDENTIFY,
+		.size_out = sizeof(id),
+		.payload_out = &id,
+	};
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 785c6c12515d..c447577f5ad5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -430,8 +430,8 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size);
+int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
+			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 2fc8070b6a17..eedefebc4283 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -119,6 +119,7 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 				    unsigned int buf_len)
 {
 	struct cxl_mbox_get_lsa get_lsa;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	if (sizeof(*cmd) > buf_len)
@@ -130,9 +131,15 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 		.offset = cpu_to_le32(cmd->in_offset),
 		.length = cpu_to_le32(cmd->in_length),
 	};
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_LSA,
+		.payload_in = &get_lsa,
+		.size_in = sizeof(get_lsa),
+		.size_out = cmd->in_length,
+		.payload_out = cmd->out_buf,
+	};
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
-			       sizeof(get_lsa), cmd->out_buf, cmd->in_length);
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	cmd->status = 0;
 
 	return rc;
@@ -143,6 +150,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 				    unsigned int buf_len)
 {
 	struct cxl_mbox_set_lsa *set_lsa;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	if (sizeof(*cmd) > buf_len)
@@ -161,10 +169,13 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 		.offset = cpu_to_le32(cmd->in_offset),
 	};
 	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_LSA,
+		.payload_in = set_lsa,
+		.size_in = struct_size(set_lsa, data, cmd->in_length),
+	};
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
-			       struct_size(set_lsa, data, cmd->in_length),
-			       NULL, 0);
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index ebb78b8944f5..4ad4bda2d18e 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -19,11 +19,17 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	struct cxl_get_security_output {
 		__le32 flags;
 	} out;
+	struct cxl_mbox_cmd mbox_cmd;
 	u32 sec_out;
 	int rc;
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
-			       &out, sizeof(out));
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
+		.size_out = sizeof(out),
+		.payload_out = &out,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0)
 		return 0;
 
@@ -62,17 +68,23 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_set_pass set_pass;
-	int rc;
 
-	set_pass.type = ptype == NVDIMM_MASTER ?
-		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	set_pass = (struct cxl_set_pass) {
+		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
+						 CXL_PMEM_SEC_PASS_USER,
+	};
 	memcpy(set_pass.old_pass, old_data->data, NVDIMM_PASSPHRASE_LEN);
 	memcpy(set_pass.new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
-			       &set_pass, sizeof(set_pass), NULL, 0);
-	return rc;
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_PASSPHRASE,
+		.size_in = sizeof(set_pass),
+		.payload_in = &set_pass,
+	};
+
+	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
 }
 
 static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -83,15 +95,21 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_disable_pass dis_pass;
-	int rc;
+	struct cxl_mbox_cmd mbox_cmd;
 
-	dis_pass.type = ptype == NVDIMM_MASTER ?
-		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	dis_pass = (struct cxl_disable_pass) {
+		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
+						 CXL_PMEM_SEC_PASS_USER,
+	};
 	memcpy(dis_pass.pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
-			       &dis_pass, sizeof(dis_pass), NULL, 0);
-	return rc;
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_DISABLE_PASSPHRASE,
+		.size_in = sizeof(dis_pass),
+		.payload_in = &dis_pass,
+	};
+
+	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
 }
 
 static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -111,8 +129,11 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_cmd mbox_cmd = {
+		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
+	};
 
-	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY, NULL, 0, NULL, 0);
+	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -122,11 +143,17 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	u8 pass[NVDIMM_PASSPHRASE_LEN];
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	memcpy(pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_UNLOCK,
-			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_UNLOCK,
+		.size_in = NVDIMM_PASSPHRASE_LEN,
+		.payload_in = pass,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -140,14 +167,22 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_pass_erase erase;
 	int rc;
 
-	erase.type = ptype == NVDIMM_MASTER ?
-		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	erase = (struct cxl_pass_erase) {
+		.type = ptype == NVDIMM_MASTER ? CXL_PMEM_SEC_PASS_MASTER :
+						 CXL_PMEM_SEC_PASS_USER,
+	};
 	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
-	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
-			       &erase, sizeof(erase), NULL, 0);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
+		.size_in = sizeof(erase),
+		.payload_in = &erase,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 

