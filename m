Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138FAC4321E
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbiCXBK1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbiCXBKZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E052B38
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084134; x=1679620134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5kCdZ00+Xv0k2kihXNLrjkuIVv6uA0kk1MVxqcS7Y8=;
  b=P/vijkHs/B5my7kLX95OFpct8nZGTqU5crTc0iyvDTZ9H1vAvrc8zMCR
   l1M7e1lu+Pr7jp1r/+YmXgUxU7JywWh7x7Wu3wsJd5qANcBSw5zsgE0DT
   DihC8bwe9fy1TFj7OrqGlsog2VBDEtCEN5H+Dsauj+a2IAs6f66UXI6dj
   VN1h+87+05HBdRuyOew7baJfNDE7km9su8YrF6U+LFQyS59OZzb/FsbQV
   pBoLwgHwRdMzLDoqoZS9dooZiIcnSVcpCl5bH5T6bxK6OqsryvUeeteZQ
   KnVkUtLjUnkEBtgidQ+CsCwYKiEaTzi7e6zg/tyLT9m1xGWWKuJ7Cztgk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215007"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142834"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:53 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 7/9] cxl/mbox: Move cxl_mem_command param to a local variable
Date:   Wed, 23 Mar 2022 18:11:24 -0700
Message-Id: <20220324011126.1144504-8-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0340399c7029..c323d6792405 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -331,10 +331,9 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
 }
 
 /**
- * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
+ * cxl_validate_cmd_from_user() - Construct a valid cxl_mbox_cmd
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
- * @out_cmd: Sanitized and populated &struct cxl_mem_command.
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  *
  * Return:
@@ -345,16 +344,14 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  *  * %-EPERM	- Attempted to use a protected command.
  *  * %-EBUSY	- Kernel has claimed exclusive access to this opcode
  *
- * The result of this command is a fully validated command in @out_cmd that is
+ * The result of this command is a fully validated command in @mbox_cmd that is
  * safe to send to the hardware.
- *
- * See handle_mailbox_cmd_from_user()
  */
 static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
-				      struct cxl_mem_command *out_cmd,
 				      struct cxl_mbox_cmd *mbox_cmd)
 {
+	struct cxl_mem_command mem_cmd;
 	int rc;
 
 	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
@@ -370,16 +367,16 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, out_cmd);
+		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, &mem_cmd);
 	else
-		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
+		rc = cxl_to_mem_cmd(cxlds, send_cmd, &mem_cmd);
 
 	if (rc)
 		return rc;
 
 	/* Sanitize and construct a cxl_mbox_cmd */
-	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
-			     out_cmd->info.size_in, out_cmd->info.size_out,
+	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, mem_cmd.opcode,
+			     mem_cmd.info.size_in, mem_cmd.info.size_out,
 			     send_cmd->in.payload);
 
 	return rc;
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
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &mbox_cmd);
 	if (rc)
 		return rc;
 
-- 
2.31.1

