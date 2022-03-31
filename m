Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A013C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352306AbiCaB0u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352307AbiCaB0s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA742EE3
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689901; x=1680225901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3JnkEWOsl9bfrD8jk1xfGxfZwmvj+ZVL3w/6j0Hcu4=;
  b=OsmRa9hHeauiiTO7da0tvyjJxyyU2vwB5UQ72RwT9QPIxlgR386QO+Qz
   FJieQK4FwM3LLmnFMc5iPEUdw10xLFMNiIXXXUP/hHkcjlKKhA7BNDuPP
   YCLKTgpxYYTkNUsJrfJJ3z7iTd4+RuyaMtohzX7brUyCwJE47QM2eev7R
   F/jM92w+ctPL4gWm3RN/ZDOZCah7NDLl5U/N+Pv8C0z1o0wlAseJeDTyx
   oSfNcqcL/mLJCC/BjreRZH82lpp4r0bEb3vKjw9+vCWZSIS6TAKgMBl8Q
   2oNfXETxsLohWH0VQyWwMJELofx23zfTUi3u7DuL3tT0AHLOEhTMYE7aG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186034"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186034"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664621"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:00 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
Date:   Wed, 30 Mar 2022 18:27:16 -0700
Message-Id: <77050ba512d6c30eccf7505467509e460dd325a0.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Previously, handle_mailbox_cmd_from_user(), constructed the mailbox
command and dispatched it to the hardware. The construction work
has moved to the validation path.

handle_mailbox_cmd_from_user() now expects a fully validated
mbox param. Make it's caller, cxl_send_cmd(), deliver it. Update
the comments and dereferencing of the new mbox parameter.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 44 ++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8c59c6959c15..b4bef3c50ee3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -423,8 +423,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
- * @cmd: The validated command.
- * @in_payload: Pointer to userspace's input payload.
+ * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
  *            (Output) Payload size hardware generated.
@@ -439,35 +438,27 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
  *  * %-EINTR	- Mailbox acquisition interrupted.
  *  * %-EXXX	- Transaction level failures.
  *
- * Creates the appropriate mailbox command and dispatches it on behalf of a
- * userspace request. The input and output payloads are copied between
- * userspace.
+ * Dispatches a mailbox command on behalf of a userspace request.
+ * The output payload is copied to userspace.
  *
  * See cxl_send_cmd().
  */
 static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
-					const struct cxl_mem_command *cmd,
-					u64 in_payload, u64 out_payload,
-					s32 *size_out, u32 *retval)
+					struct cxl_mbox_cmd *mbox_cmd,
+					u64 out_payload, s32 *size_out,
+					u32 *retval)
 {
 	struct device *dev = cxlds->dev;
-	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	rc = cxl_mbox_cmd_ctor(&mbox_cmd, cxlds, cmd->opcode,
-			       cmd->info.size_in, cmd->info.size_out,
-			       in_payload);
-	if (rc)
-		return rc;
-
 	dev_dbg(dev,
 		"Submitting %s command for user\n"
 		"\topcode: %x\n"
 		"\tsize: %zx\n",
-		cxl_mem_opcode_to_name(mbox_cmd.opcode),
-		mbox_cmd.opcode, mbox_cmd.size_in);
+		cxl_mem_opcode_to_name(mbox_cmd->opcode),
+		mbox_cmd->opcode, mbox_cmd->size_in);
 
-	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+	rc = cxlds->mbox_send(cxlds, mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -476,21 +467,21 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	 * to userspace. While the payload may have written more output than
 	 * this it will have to be ignored.
 	 */
-	if (mbox_cmd.size_out) {
-		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
+	if (mbox_cmd->size_out) {
+		dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
 			      "Invalid return size\n");
 		if (copy_to_user(u64_to_user_ptr(out_payload),
-				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
+				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
 			rc = -EFAULT;
 			goto out;
 		}
 	}
 
-	*size_out = mbox_cmd.size_out;
-	*retval = mbox_cmd.return_code;
+	*size_out = mbox_cmd->size_out;
+	*retval = mbox_cmd->return_code;
 
 out:
-	cxl_mbox_cmd_dtor(&mbox_cmd);
+	cxl_mbox_cmd_dtor(mbox_cmd);
 	return rc;
 }
 
@@ -512,9 +503,8 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (rc)
 		return rc;
 
-	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
-					  send.out.payload, &send.out.size,
-					  &send.retval);
+	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
+					  &send.out.size, &send.retval);
 	if (rc)
 		return rc;
 
-- 
2.31.1

