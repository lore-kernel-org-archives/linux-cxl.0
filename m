Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3765AC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 20:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiBYU2M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiBYU2G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 15:28:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A95AA77
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820851; x=1677356851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJfU25va0XVUT6gerN2Bla++OyHA+pqT0COiXXp8kuw=;
  b=TjkxWxNgTQJCF+4bSHGxY2aR+HnogEB9CYH2T09gDdGV/wg4WLWT4Y5K
   e0czY8s16IDOHoGoikEgGF4iglQgOpAbWOD00euKw7O3ARto7j6KqFKex
   6kKrWf4mHPtNiA9JGX12JhdRCh39Q0uA9GiiK6gajytzUlawMYIyvT9iq
   p3AgSUqS9RAZcwPP0W7WWaAlHihrY5bIzpbl9F18oGAC5Ahane/pXNe2e
   5q8gIFXwC24rZk+9prXASFATol/t1rdQN21YMqRjm4JjotIVbCuCrZ6vH
   kWkMhZLvdqT0nbQjE/bIfOpuLhHEXMM8bfu5kfrU4/A8R8TXh4W9IrKWq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232546066"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="232546066"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="607868802"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:31 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/4] cxl/mbox: Move cxl_mem_command construction to helper funcs
Date:   Fri, 25 Feb 2022 12:30:58 -0800
Message-Id: <84c0ddda79331bbbc37a6237e980b53735c29c77.1645817416.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645817416.git.alison.schofield@intel.com>
References: <cover.1645817416.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Sanitizing and constructing a cxl_mem_command from a userspace
command is part of the validation process prior to submitting
the command to a CXL device. Move this work to helper functions:
cxl_to_mem_cmd(), cxl_to_mem_cmd_raw().

This declutters cxl_validate_cmd_from_user() in preparation for
adding new validation steps.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 143 ++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 64 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index be61a0d8016b..06fbe6d079ba 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -207,6 +207,75 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
 	return true;
 }
 
+static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
+			      const struct cxl_send_command *send_cmd,
+			      struct cxl_mem_command *mem_cmd)
+{
+	if (send_cmd->raw.rsvd)
+		return -EINVAL;
+	/*
+	 * Unlike supported commands, the output size of RAW commands
+	 * gets passed along without further checking, so it must be
+	 * validated here.
+	 */
+	if (send_cmd->out.size > cxlds->payload_size)
+		return -EINVAL;
+
+	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
+		return -EPERM;
+
+	dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
+
+	mem_cmd->info.id = CXL_MEM_COMMAND_ID_RAW;
+	mem_cmd->info.flags = 0;
+	mem_cmd->info.size_in = send_cmd->in.size;
+	mem_cmd->info.size_out = send_cmd->out.size;
+	mem_cmd->opcode = send_cmd->raw.opcode;
+
+	return 0;
+}
+
+static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
+			  const struct cxl_send_command *send_cmd,
+			  struct cxl_mem_command *mem_cmd)
+{
+	const struct cxl_command_info *info;
+	struct cxl_mem_command *c;
+
+	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
+		return -EINVAL;
+
+	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
+		return -EINVAL;
+
+	/* Convert user's command into the internal representation */
+	c = &cxl_mem_commands[send_cmd->id];
+	info = &c->info;
+
+	/* Check that the command is enabled for hardware */
+	if (!test_bit(info->id, cxlds->enabled_cmds))
+		return -ENOTTY;
+
+	/* Check that the command is not claimed for exclusive kernel use */
+	if (test_bit(info->id, cxlds->exclusive_cmds))
+		return -EBUSY;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
+		return -ENOMEM;
+
+	memcpy(mem_cmd, c, sizeof(*c));
+	mem_cmd->info.size_in = send_cmd->in.size;
+	return 0;
+}
+
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @cxlds: The device data for the operation
@@ -230,8 +299,8 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
 				      struct cxl_mem_command *out_cmd)
 {
-	const struct cxl_command_info *info;
-	struct cxl_mem_command *c;
+	struct cxl_mem_command mem_cmd;
+	int rc;
 
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
 		return -ENOTTY;
@@ -244,70 +313,16 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 	if (send_cmd->in.size > cxlds->payload_size)
 		return -EINVAL;
 
-	/*
-	 * Checks are bypassed for raw commands but a WARN/taint will occur
-	 * later in the callchain
-	 */
-	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
-		const struct cxl_mem_command temp = {
-			.info = {
-				.id = CXL_MEM_COMMAND_ID_RAW,
-				.flags = 0,
-				.size_in = send_cmd->in.size,
-				.size_out = send_cmd->out.size,
-			},
-			.opcode = send_cmd->raw.opcode
-		};
+	/* Sanitize and construct a cxl_mem_command */
+	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
+		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, &mem_cmd);
+	else
+		rc = cxl_to_mem_cmd(cxlds, send_cmd, &mem_cmd);
 
-		if (send_cmd->raw.rsvd)
-			return -EINVAL;
+	if (rc)
+		return rc;
 
-		/*
-		 * Unlike supported commands, the output size of RAW commands
-		 * gets passed along without further checking, so it must be
-		 * validated here.
-		 */
-		if (send_cmd->out.size > cxlds->payload_size)
-			return -EINVAL;
-
-		if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
-			return -EPERM;
-
-		memcpy(out_cmd, &temp, sizeof(temp));
-
-		return 0;
-	}
-
-	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
-		return -EINVAL;
-
-	if (send_cmd->rsvd)
-		return -EINVAL;
-
-	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
-		return -EINVAL;
-
-	/* Convert user's command into the internal representation */
-	c = &cxl_mem_commands[send_cmd->id];
-	info = &c->info;
-
-	/* Check that the command is enabled for hardware */
-	if (!test_bit(info->id, cxlds->enabled_cmds))
-		return -ENOTTY;
-
-	/* Check that the command is not claimed for exclusive kernel use */
-	if (test_bit(info->id, cxlds->exclusive_cmds))
-		return -EBUSY;
-
-	/* Check the input buffer is the expected size */
-	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
-		return -ENOMEM;
-
-	/* Check the output buffer is at least large enough */
-	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
-		return -ENOMEM;
-
-	memcpy(out_cmd, c, sizeof(*c));
+	memcpy(out_cmd, &mem_cmd, sizeof(mem_cmd));
 	out_cmd->info.size_in = send_cmd->in.size;
 	/*
 	 * XXX: out_cmd->info.size_out will be controlled by the driver, and the
-- 
2.31.1

