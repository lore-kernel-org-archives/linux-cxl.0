Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C50C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiC3B3u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbiC3B3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2524B5F1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603684; x=1680139684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IzcwRhG16/Hc0yD0nr15NwG3pIQIS7YKOLXS0bkK1lo=;
  b=R9Bvif8veOiUjgE8WsigShr5KXcs9dfS0ZALwlacAQK8AoV0YkUIQbQ1
   gx+whrSWaQQYTM7vYottlH6A6Q3B2STNtgRFnfADrkmu5jKThxLYcb0O/
   pnyUTwuRhVLJfvj5jClrdUfmuITmcXW9ZIGNCQQHE1ANHArKYXT1rcyPQ
   C635+NDZ9lKA5/a07GyT3m+WuZKJ6tiV8JVfBDjW0RuIaRnFDnjOi5xsj
   9Jb23VEvlhAZaFOI2tTw8wjPQSkrTgRoKMgMzCvdtUGsZVzdH2PvCUr3T
   kKL4v1Tcahmb9YfnW+d26R+MYVJiEfqDDRYUeJZLuvuRo1kBjK7pGsUlL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601859"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601859"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776948"
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
Subject: [PATCH v4 5/9] cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
Date:   Tue, 29 Mar 2022 18:30:20 -0700
Message-Id: <1a1ebb7181b8be9fb746da48b41c02e54bee513e.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 95882ab9f87b..654e61a77eb3 100644
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
@@ -445,9 +456,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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

