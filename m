Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6440C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiCaB0p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiCaB0p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088642A32
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689899; x=1680225899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3euXn1TImaU/zhh5z1AGZChuL87hoCSnNb4DzwCQ2Y=;
  b=DEAMUGN6l3UiECu9P3lUoDRydJhwbTkAzmR4S7kMDs40I1RsioaVyYWl
   3kk0TLajk81jqY1pY/hdl88pB3R8zFnLvtqETszF0ym4nX6uabEdr9Kp9
   koy7S4CSxaJKYYd/Yggddrra6JbJFRpLIPKd02DI1Xv89yjbXQ6u9nXEg
   zsa65uvLr2u495F7Nv+pbbafvG7PnJGXdJwW3fImnZc6CMIUay3ivGmeG
   y/hY5yUbljRsUHGEn0tVD8dnF/39nxWUD1giQbvmS2tKmykvc2NYiHSta
   j0a4rj9gHM+enXiw6+n7SlHG4f6r946IMAi29B9DnZn8bS7B9qU60J/st
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186021"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186021"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664509"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:58 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 1/9] cxl/mbox: Move cxl_mem_command construction to helper funcs
Date:   Wed, 30 Mar 2022 18:27:11 -0700
Message-Id: <7d9b826f29262e3a484cb4bb7b63872134d60bd7.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 155 +++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 75 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index be61a0d8016b..1f2175f0f687 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -207,6 +207,81 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
 	return true;
 }
 
+static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
+			      const struct cxl_send_command *send_cmd,
+			      struct cxl_dev_state *cxlds)
+{
+	if (send_cmd->raw.rsvd)
+		return -EINVAL;
+
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
+	*mem_cmd = (struct cxl_mem_command) {
+		.info = {
+			.id = CXL_MEM_COMMAND_ID_RAW,
+			.size_in = send_cmd->in.size,
+			.size_out = send_cmd->out.size,
+		},
+		.opcode = send_cmd->raw.opcode
+	};
+
+	return 0;
+}
+
+static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
+			  const struct cxl_send_command *send_cmd,
+			  struct cxl_dev_state *cxlds)
+{
+	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
+	const struct cxl_command_info *info = &c->info;
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
+	*mem_cmd = (struct cxl_mem_command) {
+		.info = {
+			.id = info->id,
+			.flags = info->flags,
+			.size_in = send_cmd->in.size,
+			.size_out = send_cmd->out.size,
+		},
+		.opcode = c->opcode
+	};
+
+	return 0;
+}
+
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @cxlds: The device data for the operation
@@ -230,9 +305,6 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
 				      struct cxl_mem_command *out_cmd)
 {
-	const struct cxl_command_info *info;
-	struct cxl_mem_command *c;
-
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
 		return -ENOTTY;
 
@@ -244,78 +316,11 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
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
-
-		if (send_cmd->raw.rsvd)
-			return -EINVAL;
-
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
-	out_cmd->info.size_in = send_cmd->in.size;
-	/*
-	 * XXX: out_cmd->info.size_out will be controlled by the driver, and the
-	 * specified number of bytes @send_cmd->out.size will be copied back out
-	 * to userspace.
-	 */
-
-	return 0;
+	/* Sanitize and construct a cxl_mem_command */
+	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
+		return cxl_to_mem_cmd_raw(out_cmd, send_cmd, cxlds);
+	else
+		return cxl_to_mem_cmd(out_cmd, send_cmd, cxlds);
 }
 
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
-- 
2.31.1

