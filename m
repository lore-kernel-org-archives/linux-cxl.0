Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5725C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347079AbiCXBKZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347076AbiCXBKX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB952E68
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084133; x=1679620133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jIUAbCqeFIKZNFORDp25eZ+qdeofRhmRmeNOU5tEPO4=;
  b=Y/aQYYj32QUCQBHeHsygQhHhtNa5NYXvY+QpeCdD3mOa84zYW9qz1MAB
   Y/q0rlS3VBasuZ7Df5nG4pYNFa899mb0/AX/CsyqS6uO9OLltUJrqF0qL
   fwSvN0Z1sqWdWH7k6lF3UBVCmPszzfnLpAOs/4bfxu2e7jo5MWw5Qbf8W
   tOBo+vzdOk9G2TvJm0aDvZcvBxjiiB3/SC+EMI5xGvxhreAQFVYUTWGpU
   NeBvJpVau/q+yXg/RUPOFm+Nvf+P/B9lIw9cp5ZBan3fMNzfTwH2LTytc
   yihpE4bajCsiteW0cndOzdFYiOP7z4uWlMswwvzp4QCHuf8FkwAVyIb3w
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215004"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215004"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142828"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:52 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 5/9] cxl/mbox: Remove dependency on cxl_mem_command for a debug msg
Date:   Wed, 23 Mar 2022 18:11:22 -0700
Message-Id: <20220324011126.1144504-6-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 205e671307c3..d6d582baa1ee 100644
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
+	if (c)
+		return cxl_command_names[c->info.id].name;
+
+	return NULL;
+}
+
 /**
  * cxl_mbox_send_cmd() - Send a mailbox command to a device.
  * @cxlds: The device data for the operation
@@ -450,9 +461,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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

