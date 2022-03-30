Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257EEC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiC3B3v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiC3B3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74CBBE0E
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603685; x=1680139685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYGXXTWBPZRg4Uxnr2zsQm1Mv/C90lXoqUQ4yV92dsA=;
  b=UPU655UdTXMt3DcET5EjBQPsuLDDLXWgMTEZ3IOdgTU/wAjMESb1WEAg
   YMfHbx36jvqahVKRU5i9hF7ucgqYeKjH3zC37iszcmRydWJtE+eBVRW7h
   nvDCnEdyoONQbK/bi7MWF7LTvcxoOoeAHB6T/fLDnVoW7s8thYXa12BHa
   9XbpUS5mJZwVD+67XMc09+jn9ri9jNOyQqrss5gxoM4j9U2SYQWOrBFXc
   98EgLuJoFEGZGFW1hXt7gnMvTs9lB0OUrXJkZR7c36J3M/okcm/V8r6IG
   AfaqREtYA7Jx1SIeyoX6WIazypcFKCC7C0HAOowmHk1k46eg0EtXjdY6t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601862"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601862"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776955"
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
Subject: [PATCH v4 7/9] cxl/mbox: Move cxl_mem_command param to a local variable
Date:   Tue, 29 Mar 2022 18:30:22 -0700
Message-Id: <4c8239075b201923a49d00c7b18d9dda6c9059b7.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
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
index b0abda67d7da..1b50e335d62b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -328,10 +328,9 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
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
@@ -342,16 +341,14 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
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
@@ -367,16 +364,16 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 
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
-	return cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
-			       out_cmd->info.size_in, out_cmd->info.size_out,
+	return cxl_to_mbox_cmd(cxlds, mbox_cmd, mem_cmd.opcode,
+			       mem_cmd.info.size_in, mem_cmd.info.size_out,
 			       send_cmd->in.payload);
 }
 
@@ -481,7 +478,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
-	struct cxl_mem_command c;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
@@ -490,7 +486,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &mbox_cmd);
 	if (rc)
 		return rc;
 
-- 
2.31.1

