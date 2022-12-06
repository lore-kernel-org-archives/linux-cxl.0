Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331FDC352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLFEWn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiLFEWl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:22:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29E1115
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300559; x=1701836559;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1wsyPflUNXkyD4TFxvZT7C8vWqE6R+TZbyHta73BM5Y=;
  b=eMw/7JJCOaGkVDLiDu/Y5WTHYU6WSq63jNCJmaAi1U+Y6F6Yz7RDWMJs
   JkgueU0dW752dCf2unxVAD/sEiON2ePV2BSi5EVGd5bQcB6iHUL+Z+Mi9
   bP7GgDM3+8iR0cynwsB9SQq3EmYJCK1k7Ae+4YKnFBQVD1B7ferTrxtU+
   9SQt0rE7fqVRUN/Udn++B6q59wCLEvmMbvp7+9qZWVLCgzs5P+mnDqlLY
   Ormycr54lmDRvX9FSTNvwo91b/6rwWVUEWchaHz/okTyTd8Z0BmQnahKx
   ERl0U8/ugknFIaHBPv9mZBGpcu3lff9m/W2+doYkGNSspOKwWS2mvBVvZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315238679"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315238679"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639733751"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="639733751"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:39 -0800
Subject: [PATCH 3/4] cxl/mbox: Add variable output size validation for
 internal commands
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.jiang@intel.com, ira.weiny@intel.com
Date:   Mon, 05 Dec 2022 20:22:39 -0800
Message-ID: <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_internal_send_cmd() skips output size validation for variable output
commands which is not ideal. Most of the time internal usages want to
fail if the output size does not match what was requested. For other
commands where the caller cannot predict the size there is usually a
a header that conveys how much vaild data is in the payload. For those
cases add @min_out as a parameter to specify what the minimum response
payload needs to be for the caller to parse the rest of the payload.

In this patch only Get Supported Logs has that behavior, but going
forward records retrieval commands like Get Poison List and Get Event
Records can use @min_out to retrieve a variable amount of records.

Critically, this validation scheme skips the needs to interrogate the
cxl_mem_commands array which in turn frees up the implementation to
support internal command enabling without also enabling external / user
commands.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |   23 ++++++++++++++---------
 drivers/cxl/cxlmem.h    |    2 ++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ed451ca60ce5..c36a3589377a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -166,9 +166,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 			  struct cxl_mbox_cmd *mbox_cmd)
 {
-	const struct cxl_mem_command *cmd =
-		cxl_mem_find_command(mbox_cmd->opcode);
-	size_t out_size;
+	size_t out_size, min_out;
 	int rc;
 
 	if (mbox_cmd->size_in > cxlds->payload_size ||
@@ -176,6 +174,7 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 		return -E2BIG;
 
 	out_size = mbox_cmd->size_out;
+	min_out = mbox_cmd->min_out;
 	rc = cxlds->mbox_send(cxlds, mbox_cmd);
 	if (rc)
 		return rc;
@@ -183,14 +182,18 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
 		return cxl_mbox_cmd_rc2errno(mbox_cmd);
 
+	if (!out_size)
+		return 0;
+
 	/*
-	 * Variable sized commands can't be validated and so it's up to the
-	 * caller to do that if they wish.
+	 * Variable sized output needs to at least satisfy the caller's
+	 * minimum if not the fully requested size.
 	 */
-	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
-		if (mbox_cmd->size_out != out_size)
-			return -EIO;
-	}
+	if (min_out == 0)
+		min_out = out_size;
+
+	if (mbox_cmd->size_out < min_out)
+		return -EIO;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
@@ -635,6 +638,8 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
 		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
 		.size_out = cxlds->payload_size,
 		.payload_out = ret,
+		/* At least the record number field must be valid */
+		.min_out = 2,
 	};
 	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c447577f5ad5..ab138004f644 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -101,6 +101,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            outputs commands this is always expected to be deterministic. For
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
+ * @min_out: (input) internal command output payload size validation
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -115,6 +116,7 @@ struct cxl_mbox_cmd {
 	void *payload_out;
 	size_t size_in;
 	size_t size_out;
+	size_t min_out;
 	u16 return_code;
 };
 

