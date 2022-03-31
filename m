Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C25C43217
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352307AbiCaB0u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352309AbiCaB0s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C342ED0
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689902; x=1680225902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0omQn1eSlnQJrB5NEraUGojKZGOJx2SsKwLQpROersg=;
  b=S5qivVYtzcSoAg2uWncreT3KRuEKKGlKd+jxucddZTTTK/aDuOuM4PHT
   XCwjxY9deRqE3i6oamsmmqcEPZCfaDM0n3Y7vrJus/8qKMX8tYSVcVtPy
   6qYHK5TLU9qaupqk9t5eJKM+GRbnv37vmAe1kqvewk/KnViuyoqDbbbi5
   6Hk0+pHNqHyFQpbgPf2ANj8eB65tMy92QjP7SmclUP7l20OKM4sklJnu/
   XyqshHczY7cv5PyAckgozfQquvq+5bm5+JPBGtjWkqb+SDCdtpFhl0VW2
   kceK1J2Bd0XT0+W+f8uehtAqLr69ydQaFGkr7apN8Nyd157lLYaMSMAgI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186035"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664646"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:01 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 7/9] cxl/mbox: Move cxl_mem_command param to a local variable
Date:   Wed, 30 Mar 2022 18:27:17 -0700
Message-Id: <c11a437896d914daf36f5ac8ec62f999c5ec2da7.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

cxl_validate_command_from_user() is now the single point of validation
for mailbox commands coming from user space. Previously, it returned a
a cxl_mem_command, but that was not sufficient when validation of the
actual mailbox command became a requirement. Now, it returns a fully
validated cxl_mbox_cmd.

Remove the extraneous cxl_mem_command parameter. Define and use a
local version only.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b4bef3c50ee3..704d6b313144 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -338,7 +338,6 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
- * @out_cmd: Sanitized and populated &struct cxl_mem_command.
  *
  * Return:
  *  * %0	- @out_cmd is ready to send.
@@ -348,16 +347,14 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  *  * %-EPERM	- Attempted to use a protected command.
  *  * %-EBUSY	- Kernel has claimed exclusive access to this opcode
  *
- * The result of this command is a fully validated command in @out_cmd that is
+ * The result of this command is a fully validated command in @mbox_cmd that is
  * safe to send to the hardware.
- *
- * See handle_mailbox_cmd_from_user()
  */
 static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 				      struct cxl_dev_state *cxlds,
-				      const struct cxl_send_command *send_cmd,
-				      struct cxl_mem_command *out_cmd)
+				      const struct cxl_send_command *send_cmd)
 {
+	struct cxl_mem_command mem_cmd;
 	int rc;
 
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
@@ -373,16 +370,16 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		rc = cxl_to_mem_cmd_raw(out_cmd, send_cmd, cxlds);
+		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, cxlds);
 	else
-		rc = cxl_to_mem_cmd(out_cmd, send_cmd, cxlds);
+		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, cxlds);
 
 	if (rc)
 		return rc;
 
 	/* Sanitize and construct a cxl_mbox_cmd */
-	return cxl_mbox_cmd_ctor(mbox_cmd, cxlds, out_cmd->opcode,
-				 out_cmd->info.size_in, out_cmd->info.size_out,
+	return cxl_mbox_cmd_ctor(mbox_cmd, cxlds, mem_cmd.opcode,
+				 mem_cmd.info.size_in, mem_cmd.info.size_out,
 				 send_cmd->in.payload);
 }
 
@@ -490,7 +487,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
-	struct cxl_mem_command c;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
@@ -499,7 +495,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send, &c);
+	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
 	if (rc)
 		return rc;
 
-- 
2.31.1

