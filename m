Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA9C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbiCXBK0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbiCXBKY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B702B532CC
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084133; x=1679620133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2+QcL9RrLy1+UG4suIImRbMeSEb6qq+pIsY0VK1A+Q=;
  b=l7S1RjnXlWBLggAlBhL/88pcjAwDmfGMwhKaS5GECiY3ZwJeNOexTUtF
   Z0c26mmGzeqFBQ/mZAvqwwc128qAzwGIEm3vkU92R8IFx5SB1TiN0r5Ol
   zauEAioP6jkXd4qcMAeELUmOLbFqerA4Omp949xo1ZiOLAwde1aYKwY5p
   Dyf8QG0pd0eYnnO1Dl6t1gqza283WkjyHo4eVqXfR36fWyh2zTqo/4VpE
   y/1GJMUFOznrRZ7k69Jat7Pd3IMK0Zdf4+C1XcovdCVtmgKrYZ5Loj2Jg
   EUmfxH9smK6GVK82qPZTuto36l7HNfonAUsjzgGwpMooC04fE9TBcI07Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215006"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142831"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:53 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user() use a mbox param
Date:   Wed, 23 Mar 2022 18:11:23 -0700
Message-Id: <20220324011126.1144504-7-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 45 +++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d582baa1ee..0340399c7029 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -422,8 +422,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
- * @cmd: The validated command.
- * @in_payload: Pointer to userspace's input payload.
+ * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
  *            (Output) Payload size hardware generated.
@@ -438,34 +437,27 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
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
 		goto out;
 
@@ -474,22 +466,22 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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
-	kvfree(mbox_cmd.payload_in);
-	kvfree(mbox_cmd.payload_out);
+	kvfree(mbox_cmd->payload_in);
+	kvfree(mbox_cmd->payload_out);
 	return rc;
 }
 
@@ -511,9 +503,8 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
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

