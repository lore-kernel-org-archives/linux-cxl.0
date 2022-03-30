Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A752BC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbiC3B3s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiC3B3r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45824BBE0E
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603684; x=1680139684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JA27QawdBD+udV4jh3b0FBp9N1PB7VITMRZvcNK3Jx0=;
  b=cb6hkNrbCXpj2FcK0IOPa0pvUsIPbP9qj49C5/5tHyDOMgAV7mjZlQCH
   nsiNjJnlTStxFNKW73+t3b/uvk5W2yM8Sx/vOnLfkA68phO0OaeZdeZ1I
   t8Ryn0am+1eY9F1xUOcdeTk0qYenXQu2O1MxQTJd1EAfcBXZ8t1iawrD0
   ZanAcpcW5X46hS87/cZOrE9Jqe4LNxy6c05tKpwLy8hAaoVZ2St2pMSUc
   PH38MQjtzy1eVWD+n67euFJfRoTSI0CTa1KZaltSwn6K5eu2LkfchMeWh
   5dnM4Mrt5eUudV2RO7yvi0iaQVB2rBpGsgksOJwY44Wwq5BoVodmWyypf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601858"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601858"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776945"
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
Subject: [PATCH v4 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
Date:   Tue, 29 Mar 2022 18:30:19 -0700
Message-Id: <281bb6c00baa93c29a9f05162a274bd6140fea39.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

This is a step in refactoring the handling of user space mailbox
commands. The intent is to have all the validation work originate
in cxl_validate_cmd_from_user().

Move the construction and validation of a mailbox command to the
validation path. Continue to pass both the out_cmd and the mbox_cmd
until handle_mbox_cmd_from_user() learns how to use a mbox_cmd param.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a19365075cae..95882ab9f87b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -321,6 +321,7 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
  * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  *
  * Return:
  *  * %0	- @out_cmd is ready to send.
@@ -337,8 +338,11 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  */
 static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
-				      struct cxl_mem_command *out_cmd)
+				      struct cxl_mem_command *out_cmd,
+				      struct cxl_mbox_cmd *mbox_cmd)
 {
+	int rc;
+
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
 		return -ENOTTY;
 
@@ -352,9 +356,17 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		return cxl_to_mem_cmd_raw(cxlds, send_cmd, out_cmd);
+		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, out_cmd);
 	else
-		return cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
+		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
+
+	if (rc)
+		return rc;
+
+	/* Sanitize and construct a cxl_mbox_cmd */
+	return cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
+			       out_cmd->info.size_in, out_cmd->info.size_out,
+			       send_cmd->in.payload);
 }
 
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
@@ -471,6 +483,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mem_command c;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	dev_dbg(dev, "Send IOCTL\n");
@@ -478,7 +491,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
 	if (rc)
 		return rc;
 
-- 
2.31.1

