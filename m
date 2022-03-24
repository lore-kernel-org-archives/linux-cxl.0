Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E120C43217
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiCXBKY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbiCXBKX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2C527D3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084133; x=1679620133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFvw6CF0Hn3KGO/Oeoc1gAUfRtf14K/mtfwDtHQOtOo=;
  b=U6Exj52RlkqxV73OOOOuZfjP4F9VojiOsX47F1x6YSkZ95/xsV3yklWj
   dKi4MPuPS1FwaAsxDGyW3SLJQNXo5d73PZFZ8VFt1VuCmc1zWxt4MoYNj
   USh3T9gcWY1DZTiHfXo/59TxBy/tRdbPsZEOe+TEID/kzbSfQauUchN67
   a3KvX2p2wSLbTXkqJMKq0YcBk2CRT9wtVAOTMPa/CpepK/iRxdMjEjoVI
   6L8QmAE03FLuZ+dyuYwf7SRW1NIBt3JPVUgJQJva+XOx3hBuwRtc/DgPO
   y8jdS2MIqwc30bLkC1FlFy/ppb89MtoFrV4MwTpH8zc7E2142/ODn8R+7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215003"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142821"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:51 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the validation path
Date:   Wed, 23 Mar 2022 18:11:21 -0700
Message-Id: <20220324011126.1144504-5-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Since the validation of a mailbox command is done as it is built,
move that work out of the dispatch path and into the validation
path.

This is a step in refactoring the handling of user space mailbox
commands. The intent is to have all the validation work originate
in cxl_validate_cmd_from_user().

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d4233cfb2f99..205e671307c3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -324,6 +324,7 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  * @cxlds: The device data for the operation
  * @send_cmd: &struct cxl_send_command copied in from userspace.
  * @out_cmd: Sanitized and populated &struct cxl_mem_command.
+ * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
  *
  * Return:
  *  * %0	- @out_cmd is ready to send.
@@ -340,7 +341,8 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
  */
 static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 				      const struct cxl_send_command *send_cmd,
-				      struct cxl_mem_command *out_cmd)
+				      struct cxl_mem_command *out_cmd,
+				      struct cxl_mbox_cmd *mbox_cmd)
 {
 	int rc;
 
@@ -361,6 +363,14 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 	else
 		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
 
+	if (rc)
+		return rc;
+
+	/* Sanitize and construct a cxl_mbox_cmd */
+	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
+			     out_cmd->info.size_in, out_cmd->info.size_out,
+			     send_cmd->in.payload);
+
 	return rc;
 }
 
@@ -478,6 +488,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mem_command c;
+	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
 	dev_dbg(dev, "Send IOCTL\n");
@@ -485,7 +496,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
+	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
 	if (rc)
 		return rc;
 
-- 
2.31.1

