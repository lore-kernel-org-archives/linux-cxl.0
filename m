Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C436CC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B056661050
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBUbm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:31:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:35267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhKBUbl (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Nov 2021 16:31:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="292198216"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="292198216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 13:29:05 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="500743996"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 13:29:05 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [INTERNAL PATCH 1/2] cxl/mbox: Remove bad comment
Date:   Tue,  2 Nov 2021 13:29:00 -0700
Message-Id: <20211102202901.3675568-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20211102202901.3675568-1-ira.weiny@intel.com>
References: <20211102202901.3675568-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

__cxl_mem_mbox_send_cmd() no longer exists.  Remove the reference.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 576796a5d9f3..79bb64218339 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -148,8 +148,6 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
  * Mailbox commands may execute successfully yet the device itself reported an
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
- *
- * See __cxl_mem_mbox_send_cmd()
  */
 int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, void *in,
 			  size_t in_size, void *out, size_t out_size)
-- 
2.28.0.rc0.12.gb6a658bd00c9

