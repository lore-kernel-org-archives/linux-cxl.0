Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A3C433E0
	for <linux-cxl@archiver.kernel.org>; Sat, 20 Feb 2021 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0F364ECA
	for <linux-cxl@archiver.kernel.org>; Sat, 20 Feb 2021 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTV5h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 Feb 2021 16:57:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:37143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBTV5h (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 20 Feb 2021 16:57:37 -0500
IronPort-SDR: htzOEaZeRpgZj8bXDuJq+lVcL0d1SNsb9t0956pZDwj0qPC67K8KM7Yv4E4I1v8VVQD212/1FJ
 iBacw6ZZdXsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="248196601"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="248196601"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 13:56:56 -0800
IronPort-SDR: ikalQYO+NUG6LwPKxGUsVz2zehEYdZR8tpl7eBur99Bat7zOpmrK1Nv8jo4zm7iE2GYSTCnpYi
 Y1RHgj88+DOg==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="379397680"
Received: from aevangel-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 13:56:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] cxl/mem: Fixes to IOCTL interface
Date:   Sat, 20 Feb 2021 13:56:41 -0800
Message-Id: <20210220215641.604535-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When submitting a command for userspace, input and output payload bounce
buffers are allocated. For a given command, both input and output
buffers may exist and so when allocation of the input buffer fails, the
output buffer must be freed. As far as I can tell, userspace can't
easily exploit the leak to OOM a machine unless the machine was already
near OOM state.

This bug was introduced in v5 of the patch and did not exist in prior
revisions.

While here, adjust the variable 'j' found in patch review by Konrad.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/mem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index df895bcca63a..626fd7066f4f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -514,8 +514,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
 	if (cmd->info.size_in) {
 		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
 						   cmd->info.size_in);
-		if (IS_ERR(mbox_cmd.payload_in))
+		if (IS_ERR(mbox_cmd.payload_in)) {
+			kvfree(mbox_cmd.payload_out);
 			return PTR_ERR(mbox_cmd.payload_in);
+		}
 	}
 
 	rc = cxl_mem_mbox_get(cxlm);
@@ -696,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
-	int j = 0;
+	int cmds = 0;
 
 	dev_dbg(dev, "Query IOCTL\n");
 
@@ -714,10 +716,10 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		const struct cxl_command_info *info = &cmd->info;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+		if (copy_to_user(&q->commands[cmds++], info, sizeof(*info)))
 			return -EFAULT;
 
-		if (j == n_commands)
+		if (cmds == n_commands)
 			break;
 	}
 
-- 
2.30.1

