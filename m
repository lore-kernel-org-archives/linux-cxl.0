Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043AC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiC3B3t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiC3B3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C4524CEE1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603685; x=1680139685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cp+nQ4xe1SSMncV0Inn/HzB4ZxixrXKR7z4scY0mpNw=;
  b=CyYVkzVVcpEn0uQfijgInqNteV0gLJsF661dsoC/YW3C/6yjgfQDYTxU
   iOgfk8TUUc/ANUHxkYTX1ivQGobSpsHaphllRB91wEt7dOAJXONdgm5nW
   gmI0nYQc1RL+29sfDDzhbrUDj0hSw1du6nbZGLxZjzHikm58y05RWojsH
   XG7QaiC5YE7CnSP0z1Lh8G0YKv+vX+Tgjsz+EQcrn45sznONAVhQ+ZMfa
   fdIFlf4X00Bj3+6XI5/rra9Zop2OPUx1ReNCd3YSah2huT3qSLbkM83bd
   KFYjlMQUS0YKy3gw91X/i3eSD1wWuY4RiRbAMeqX/C3VP2+p7DNTQ3kyK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601860"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601860"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776951"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
Date:   Tue, 29 Mar 2022 18:30:21 -0700
Message-Id: <265c48b1ae2d6ebfed21f41bc1bfd2c2b98a1257.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 54 +++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 654e61a77eb3..b0abda67d7da 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -417,8 +417,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
- * @cmd: The validated command.
- * @in_payload: Pointer to userspace's input payload.
+ * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
  *            (Output) Payload size hardware generated.
@@ -433,59 +432,48 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
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
 
-	rc = cxl_to_mbox_cmd(cxlds, &mbox_cmd, cmd->opcode, cmd->info.size_in,
-			     cmd->info.size_out, in_payload);
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
-		goto out;
+		return rc;
 
 	/*
 	 * @size_out contains the max size that's allowed to be written back out
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
-			rc = -EFAULT;
-			goto out;
+				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
+			return -EFAULT;
 		}
 	}
 
-	*size_out = mbox_cmd.size_out;
-	*retval = mbox_cmd.return_code;
+	*size_out = mbox_cmd->size_out;
+	*retval = mbox_cmd->return_code;
 
-out:
-	kvfree(mbox_cmd.payload_in);
-	kvfree(mbox_cmd.payload_out);
-	return rc;
+	return 0;
 }
 
 int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
@@ -506,9 +494,11 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (rc)
 		return rc;
 
-	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
-					  send.out.payload, &send.out.size,
-					  &send.retval);
+	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
+					  &send.out.size, &send.retval);
+
+	kvfree(mbox_cmd.payload_in);
+	kvfree(mbox_cmd.payload_out);
 	if (rc)
 		return rc;
 
-- 
2.31.1

