Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F4CC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiBYU2L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbiBYU2G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 15:28:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43F5D5C0
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820852; x=1677356852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwoGnQnrgGEepytCDoXSrxL6wHnt/wNvN0osXu4J7b0=;
  b=g1Ra8uXNWw+VVe51TqQqSinxtNtjfP7/56Vx3K/Jgd7ETrBwEdTpQVxN
   85+zmOxk971DQnhYdPC3K7Z/MAzCXOjiUHczlkp4Jb78jx6gitRQ/86l/
   /aCxtwZqRBqbyv62UTjY0X4d9dfSrfSWuHNS6S16fB3iFaSRe1ZdaN2pp
   qfBOyKEUhtzx+UuyptR2yF7hlW4ZmzHAK+lOYbb7XFMoSET6Ju0DmyNvU
   6/DnhrkvIh595rOt79GfJ34C6Q3s3wqv1yW3RLDuGy/SKBbHOJONm57Tl
   PVBZsPpoW3jDD3IB1ImHSOlTwyFh/hSyCeAyOk89G4fcsV4gHuhHS7VlO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232546067"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="232546067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="607868805"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:31 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/4] cxl/mbox: Centralize the validation of user commands
Date:   Fri, 25 Feb 2022 12:30:59 -0800
Message-Id: <a09a998991c7041655adc75acd6b9fcf57974c93.1645817416.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645817416.git.alison.schofield@intel.com>
References: <cover.1645817416.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The validation of a user command is primarily, but not exclusively,
performed in cxl_validate_cmd_from_user(). Other functions in the
send path perform checks as the command is prepared for submission
to the device.

Centralize the command validation work in cxl_validate_cmd_from_user().
Make it return a valid cxl_mbox_cmd that is subsequently consumed by
handle_mailbox_cmd_from_user().

This reorganization is in preparation for performing additional
validation on user commands.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 127 ++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 69 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 06fbe6d079ba..e0140864a9fd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -277,10 +277,11 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
 }
 
 /**
- * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * cxl_validate_cmd_from_user() - Construct a valid cxl_mbox_cmd from
+ *                                the users cxl_send_command.
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
- * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  *
  * Return:
  *  * %0	- @out_cmd is ready to send.
@@ -290,14 +291,14 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  *  * %-EPERM	- Attempted to use a protected command.
  *  * %-EBUSY	- Kernel has claimed exclusive access to this opcode
  *
- * The result of this command is a fully validated command in @out_cmd that is
+ * The result of this command is a fully validated mailbox command that is
  * safe to send to the hardware.
  *
  * See handle_mailbox_cmd_from_user()
  */
 static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
-				      struct cxl_mem_command *out_cmd)
+				      struct cxl_mbox_cmd *mbox_cmd)
 {
 	struct cxl_mem_command mem_cmd;
 	int rc;
@@ -322,13 +323,34 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 	if (rc)
 		return rc;
 
-	memcpy(out_cmd, &mem_cmd, sizeof(mem_cmd));
-	out_cmd->info.size_in = send_cmd->in.size;
-	/*
-	 * XXX: out_cmd->info.size_out will be controlled by the driver, and the
-	 * specified number of bytes @send_cmd->out.size will be copied back out
-	 * to userspace.
-	 */
+	/* Construct the cxl_mbox_cmd */
+	memset(mbox_cmd, 0, sizeof(*mbox_cmd));
+	mbox_cmd->opcode = mem_cmd.opcode;
+	mbox_cmd->size_in = mem_cmd.info.size_in;
+
+	if (!mbox_cmd->size_in)
+		goto size_out;
+
+	mbox_cmd->payload_in = vmemdup_user(u64_to_user_ptr(send_cmd->in.payload),
+					    mbox_cmd->size_in);
+	if (IS_ERR(mbox_cmd->payload_in))
+		return PTR_ERR(mbox_cmd->payload_in);
+
+size_out:
+	/* Prepare to handle a full payload for variable sized output */
+	if (mem_cmd.info.size_out < 0)
+		mbox_cmd->size_out = cxlds->payload_size;
+	else
+		mbox_cmd->size_out = mem_cmd.info.size_out;
+
+	if (mbox_cmd->size_out) {
+		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out,
+						 GFP_KERNEL);
+		if (!mbox_cmd->payload_out) {
+			kvfree(mbox_cmd->payload_in);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
@@ -370,67 +392,33 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
- * @cmd: The validated command.
- * @in_payload: Pointer to userspace's input payload.
+ * @mbox_cmd: The validated mailbox command ready to send.
  * @out_payload: Pointer to userspace's output payload.
- * @size_out: (Input) Max payload size to copy out.
- *            (Output) Payload size hardware generated.
+ * @size_out: (Output) Payload size hardware generated.
  * @retval: Hardware generated return code from the operation.
  *
  * Return:
  *  * %0	- Mailbox transaction succeeded. This implies the mailbox
  *		  protocol completed successfully not that the operation itself
  *		  was successful.
- *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
  *  * %-EFAULT	- Something happened with copy_to/from_user.
  *  * %-EINTR	- Mailbox acquisition interrupted.
  *  * %-EXXX	- Transaction level failures.
  *
- * Creates the appropriate mailbox command and dispatches it on behalf of a
- * userspace request. The input and output payloads are copied between
- * userspace.
+ * Dispatches the mailbox command on behalf of a userspace request.
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
-	struct cxl_mbox_cmd mbox_cmd = {
-		.opcode = cmd->opcode,
-		.size_in = cmd->info.size_in,
-		.size_out = cmd->info.size_out,
-	};
 	int rc;
 
-	if (cmd->info.size_out) {
-		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
-		if (!mbox_cmd.payload_out)
-			return -ENOMEM;
-	}
-
-	if (cmd->info.size_in) {
-		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
-						   cmd->info.size_in);
-		if (IS_ERR(mbox_cmd.payload_in)) {
-			kvfree(mbox_cmd.payload_out);
-			return PTR_ERR(mbox_cmd.payload_in);
-		}
-	}
-
-	dev_dbg(dev,
-		"Submitting %s command for user\n"
-		"\topcode: %x\n"
-		"\tsize: %ub\n",
-		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
-		cmd->info.size_in);
-
-	dev_WARN_ONCE(dev, cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
-		      "raw command path used\n");
-
-	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+	rc = cxlds->mbox_send(cxlds, mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -439,22 +427,21 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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
-
+	*size_out = mbox_cmd->size_out;
+	*retval = mbox_cmd->return_code;
 out:
-	kvfree(mbox_cmd.payload_in);
-	kvfree(mbox_cmd.payload_out);
+	kvfree(mbox_cmd->payload_in);
+	kvfree(mbox_cmd->payload_out);
 	return rc;
 }
 
@@ -463,7 +450,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
-	struct cxl_mem_command c;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	dev_dbg(dev, "Send IOCTL\n");
@@ -471,17 +458,19 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &mbox_cmd);
 	if (rc)
 		return rc;
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (c.info.size_out < 0)
-		c.info.size_out = cxlds->payload_size;
+	dev_dbg(dev,
+		"Submitting %s command for user\n"
+		"\topcode: %x\n"
+		"\tsize: %zx\n",
+		cxl_command_names[send.id].name,
+		mbox_cmd.opcode, mbox_cmd.size_in);
 
-	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
-					  send.out.payload, &send.out.size,
-					  &send.retval);
+	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
+					  &send.out.size, &send.retval);
 	if (rc)
 		return rc;
 
-- 
2.31.1

