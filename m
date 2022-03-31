Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20ABC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiCaB0t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiCaB0q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D1242ED0
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689900; x=1680225900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z3t/aN0vysBG2RrfuzvyovH++WijFO1fBIZc8ZKa5bk=;
  b=J61DVzz6JnrhPxuIZetJfriHiTkzH1m4XmsN5Gaa2i8l/sEHB7xZfKdQ
   wfN5rTQfPDCMgAmeiU0POD2uuVlI0iRrlA6tDLBd9YEqERUzNzeL1ttcV
   5GfMAwZF1XDy8GNsJcfS8jfru4M+dObgA0xDVrU1nFyq1w6WwD9tbRC4w
   6eHQEANwPegrMyxyXNG8deVux0m3cg29r/NGIlS+Z8hFZxGnIZYGxlM9s
   bCqJnsFzLxMLnJAvefkbMbT//L33eZzTQC4BmgnHWJjo8Lr7eTtPHFklq
   Hrh8/4bMr79hJ2A616TRqoVDcZrHaHbEo3VmtiixKhkLzQ7Tbdqg+LQI/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186024"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664581"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:59 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
Date:   Wed, 30 Mar 2022 18:27:14 -0700
Message-Id: <c9fbdad968a2b619f9108bb6c37cef1a853cdf5a.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 99b933fb2d9b..47f39c6131c4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -324,6 +324,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
  * @out_cmd: Sanitized and populated &struct cxl_mem_command.
@@ -341,10 +342,13 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  *
  * See handle_mailbox_cmd_from_user()
  */
-static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
+static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
+				      struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
 				      struct cxl_mem_command *out_cmd)
 {
+	int rc;
+
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
 		return -ENOTTY;
 
@@ -358,9 +362,17 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		return cxl_to_mem_cmd_raw(out_cmd, send_cmd, cxlds);
+		rc = cxl_to_mem_cmd_raw(out_cmd, send_cmd, cxlds);
 	else
-		return cxl_to_mem_cmd(out_cmd, send_cmd, cxlds);
+		rc = cxl_to_mem_cmd(out_cmd, send_cmd, cxlds);
+
+	if (rc)
+		return rc;
+
+	/* Sanitize and construct a cxl_mbox_cmd */
+	return cxl_mbox_cmd_ctor(mbox_cmd, cxlds, out_cmd->opcode,
+				 out_cmd->info.size_in, out_cmd->info.size_out,
+				 send_cmd->in.payload);
 }
 
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
@@ -477,6 +489,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mem_command c;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	dev_dbg(dev, "Send IOCTL\n");
@@ -484,7 +497,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
+	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send, &c);
 	if (rc)
 		return rc;
 
-- 
2.31.1

