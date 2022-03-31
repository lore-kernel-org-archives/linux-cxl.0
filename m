Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E243C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348518AbiCaB0r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347820AbiCaB0q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE042A37
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689900; x=1680225900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPCBtFddZB4XDLw6AdbfILEKBhgdnIH+Sf3VUHisQTM=;
  b=L1Y/S4HRJXgh6aE8iPw24qAgIpRWok8tWET9fh0tTYY7zW+J+AySuivX
   QomVefH/T9b66GOpCtcqEOVgXLcJYXO2ZrL63B3kUrUTL+NmGL1Y6BrK5
   j2zuQuRBusbmDjycyeiISYer7SnO7t+IS2f1VXwTIiS+OMz8snuZf+zSc
   BSBOyV8Q4lYuViclODAqQqdm5BlAvHJeGyUCaMCqlBca08NtPH0qlX+H4
   bPZ5E4QKAKDArPfTXjGqwSLVDH26lliOmE2fGEJ1MPlnNmUUsJWddulii
   ndmWU66ZXoHWBvLjnAPQ3xg+Byzo5rguaAntcfSS+OZkc7xCmGPveCHok
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186023"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186023"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664553"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:59 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 3/9] cxl/mbox: Move build of user mailbox cmd to a helper functions
Date:   Wed, 30 Mar 2022 18:27:13 -0700
Message-Id: <493d7618a846d787c3ae28778935ca35e2b85eed.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

In preparation for moving the construction of a mailbox command
to the validation path, extract the work into a helper functions.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 70 ++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 39c8f6ded175..99b933fb2d9b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -207,6 +207,44 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
 	return true;
 }
 
+static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
+			     struct cxl_dev_state *cxlds, u16 opcode,
+			     size_t in_size, size_t out_size, u64 in_payload)
+{
+	*mbox = (struct cxl_mbox_cmd) {
+		.opcode = opcode,
+		.size_in = in_size,
+	};
+
+	if (in_size) {
+		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
+						in_size);
+		if (!mbox->payload_in)
+			return PTR_ERR(mbox->payload_in);
+	}
+
+	/* Prepare to handle a full payload for variable sized output */
+	if (out_size < 0)
+		mbox->size_out = cxlds->payload_size;
+	else
+		mbox->size_out = out_size;
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
+static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
+{
+	kvfree(mbox->payload_in);
+	kvfree(mbox->payload_out);
+}
+
 static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 			      const struct cxl_send_command *send_cmd,
 			      struct cxl_dev_state *cxlds)
@@ -390,27 +428,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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
+	rc = cxl_mbox_cmd_ctor(&mbox_cmd, cxlds, cmd->opcode,
+			       cmd->info.size_in, cmd->info.size_out,
+			       in_payload);
+	if (rc)
+		return rc;
 
 	dev_dbg(dev,
 		"Submitting %s command for user\n"
@@ -442,8 +467,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	*retval = mbox_cmd.return_code;
 
 out:
-	kvfree(mbox_cmd.payload_in);
-	kvfree(mbox_cmd.payload_out);
+	cxl_mbox_cmd_dtor(&mbox_cmd);
 	return rc;
 }
 
@@ -464,10 +488,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
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

