Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD4EC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiCaB0v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352308AbiCaB0s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6642A37
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689902; x=1680225902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmXJkSelGResA5UnNP5AtBFbAeicbmzfF/R7Z1KLEnE=;
  b=XbC/1yMddH9V5oc5wJQlwlgr6AsT9ZK9RCFzk6CHGjebPYj34IZhHxuF
   QUqW2koKAL5uneSuGHignS0v9g9huWkpjM3GxibcgL26UzxwZTItUOvRg
   08ETAcS6ut6v3kIFtEn6g7I5rpZve8hWx5xcR3DI2PXblldKLY78bkhOI
   BHa5FwqvcXgXAvYeD9VTrMTm7Lh2sEOLbnJw11I5vNQwJfmUedXWPtq4n
   dsTxc7nKtNRbRrpCUYUIRPp5V+qNBTLKYaNN9lvCbD+7UmIBMesaV5ZGs
   QLsu4XmPcuVzJgiy2fj3XA1aLAaMFQKKX5pOG2alqgHZkgl4fUStYIJ0l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186032"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186032"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664603"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:00 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 5/9] cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
Date:   Wed, 30 Mar 2022 18:27:15 -0700
Message-Id: <57265751d336a6e95f5ca31a9c77189408b05742.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

In preparation for removing access to struct cxl_mem_command,
change this debug message to use cxl_mbox_cmd fields instead.
Retrieve the pretty command name from cxl_mbox_cmd using a new
opcode to command name helper.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 47f39c6131c4..8c59c6959c15 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -127,6 +127,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
+static const char *cxl_mem_opcode_to_name(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	c = cxl_mem_find_command(opcode);
+	if (!c)
+		return NULL;
+
+	return cxl_command_names[c->info.id].name;
+}
+
 /**
  * cxl_mbox_send_cmd() - Send a mailbox command to a device.
  * @cxlds: The device data for the operation
@@ -452,9 +463,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	dev_dbg(dev,
 		"Submitting %s command for user\n"
 		"\topcode: %x\n"
-		"\tsize: %ub\n",
-		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
-		cmd->info.size_in);
+		"\tsize: %zx\n",
+		cxl_mem_opcode_to_name(mbox_cmd.opcode),
+		mbox_cmd.opcode, mbox_cmd.size_in);
 
 	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
 	if (rc)
-- 
2.31.1

