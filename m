Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36EC433DB
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 03:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900F64F00
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhBUD7b (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 Feb 2021 22:59:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:62641 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233533AbhBUD7b (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 20 Feb 2021 22:59:31 -0500
IronPort-SDR: KIe2sliZ/zCQRXauhu06uAcUF4hMZ3/084XWPKhHa3ZMAisQH+nlpOr1zmlyB7TXnUyo+nwx2n
 QMTKDoT4UY2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="203533296"
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="203533296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:58:50 -0800
IronPort-SDR: 26YawLk9aCNCA2oAW2ukf+beWUX0Mi6MOgxq+H9lUnamBmO63IO4vwC1DfgvJCYVTlO6QWEq/1
 tYDILTd7PHVA==
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="595424370"
Received: from aevangel-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:58:50 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v2] cxl/mem: Fix potential memory leak
Date:   Sat, 20 Feb 2021 19:58:46 -0800
Message-Id: <20210221035846.680145-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210220215641.604535-1-ben.widawsky@intel.com>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When submitting a command for userspace, input and output payload bounce
buffers are allocated. For a given command, both input and output
buffers may exist and so when allocation of the input buffer fails, the
output buffer must be freed too.

As far as I can tell, userspace can't easily exploit the leak to OOM a
machine unless the machine was already near OOM state.

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index df895bcca63a..244cb7d89678 100644
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
-- 
2.30.1

