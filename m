Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D25C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbiC3B3r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiC3B3r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9624B5F1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603683; x=1680139683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyxA8XV+sjPHpxd+pmg0vKtjEwuuIpoxPAwINPzgKIk=;
  b=kbrz9pvRBrqmRWfcHS0Q7fb/XRvvQJP0NkXT4c7kxsq66V+YSr7S7DWg
   Ng/qzeTWjlzoHUbr8ZviDHVr1MUfRRWBsf82YE+fKw6dw3rRmT36pHV4i
   eeByOwlSK+ODOxFLJTMv+AGuh24mtWbW2Bc6xc5WndXbK+z4PxXMwWe0x
   J9yg+4uZGQkEMFQ2OsWedncXR08CDzYnGqW/4OPV/HclR9DMZtnMSjmct
   frqJrsHi1A2T0YnzXDKs7PM+bG247OTl321CmXuoZFa8zwwLN7LvKW9vy
   SKrTPsfUevv1TvGXOxRwMtaGOnyXeTcDYlPp6ShoApwUCPjiU7U44CSyq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601857"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601857"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776940"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 3/9] cxl/mbox: Move build of user mailbox cmd to a helper function
Date:   Tue, 29 Mar 2022 18:30:18 -0700
Message-Id: <1ede5d9b049ef8e87c352b23c6e86441dee55bbd.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
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
index ae9aeb6c20f7..a19365075cae 100644
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
 static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
 			      const struct cxl_send_command *send_cmd,
 			      struct cxl_mem_command *mem_cmd)
@@ -390,27 +422,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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
@@ -464,10 +482,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
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

