Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBC5C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347072AbiCXBKY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbiCXBKW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C53852B38
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084132; x=1679620132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ooZxQR4TyYK04NtlVpuuQ/CIkPS6yHGlyccZHwa+Fc=;
  b=kK7EEpCu66kKJ9IuSGNdQMMShyACNLH2crAV6NeVk7iR7UoNdpXH6Ftf
   fvblcmkvwZG2KK/V2YvqpjSz58hwvly+KT0m/da33XpCrQMOp5FY4mD1g
   JNm2Fzb3sX0YYzL4QmUkHlGiD0UruUPEm4pn7zXv7mWCy6vKAaEgj64+O
   gvgBuv3W6vZROd+dt3p4VLvlC+6sqxXssf4SEGu8ejEzvZHDfyWLmkzaA
   sonIQYMtXn63M1bFptLwSh3zTZ4ErjsoXUs+ApBGI6j8NnDYNrHqni/6o
   s2qqj5N4/S0Q9k/CVpkr2cUdjKOpCUCcS8B3gPZ+1LLyr3X0HQp6uW5Ah
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215002"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215002"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142817"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:51 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 3/9] cxl/mbox: Move build of user mailbox cmd to a helper function
Date:   Wed, 23 Mar 2022 18:11:20 -0700
Message-Id: <20220324011126.1144504-4-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

In preparation for moving the construction of a mailbox command
to the validation path, extract the work into a helper function.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 60 +++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 28131c6f7fcf..d4233cfb2f99 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -207,6 +207,38 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
 	return true;
 }
 
+static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
+			   struct cxl_mbox_cmd *mbox, u16 opcode,
+			   size_t in_size, size_t out_size, u64 in_payload)
+{
+	*mbox = (struct cxl_mbox_cmd) {
+		.opcode = opcode,
+		.size_in = in_size,
+		.size_out = out_size,
+	};
+
+	if (!in_size)
+		goto size_out;
+
+	mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload), in_size);
+	if (!mbox->payload_in)
+		return PTR_ERR(mbox->payload_in);
+
+size_out:
+	/* Prepare to handle a full payload for variable sized output */
+	if (out_size < 0)
+		mbox->size_out = cxlds->payload_size;
+
+	if (mbox->size_out) {
+		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
+		if (!mbox->payload_out) {
+			kvfree(mbox->payload_in);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
 static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
 			      const struct cxl_send_command *send_cmd,
 			      struct cxl_mem_command *mem_cmd)
@@ -397,27 +429,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 					s32 *size_out, u32 *retval)
 {
 	struct device *dev = cxlds->dev;
-	struct cxl_mbox_cmd mbox_cmd = {
-		.opcode = cmd->opcode,
-		.size_in = cmd->info.size_in,
-		.size_out = cmd->info.size_out,
-	};
+	struct cxl_mbox_cmd mbox_cmd;
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
+	rc = cxl_to_mbox_cmd(cxlds, &mbox_cmd, cmd->opcode, cmd->info.size_in,
+			     cmd->info.size_out, in_payload);
+	if (rc)
+		return rc;
 
 	dev_dbg(dev,
 		"Submitting %s command for user\n"
@@ -471,10 +489,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (rc)
 		return rc;
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (c.info.size_out < 0)
-		c.info.size_out = cxlds->payload_size;
-
 	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
 					  send.out.payload, &send.out.size,
 					  &send.retval);
-- 
2.31.1

