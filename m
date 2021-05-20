Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E9C433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16BB61355
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhETUu0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 16:50:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:59682 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhETUuZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 16:50:25 -0400
IronPort-SDR: cpTet1BaSoVxgFcCyfXfWUQqdzdTOrlxfKUtS40cDL+LbIlxXTAN4aqtNpaS+CGn7kStDypm9b
 4xco7yvUS4hQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188735692"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188735692"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:49:03 -0700
IronPort-SDR: 3gZSGTnvz0DotmT8HPxUnPPHGk1nPfDWT1OktQH8bkaqbsFD7MX6R/+5q1OjiVzSitb732jUP0
 tuoUlQjBUGrw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631546604"
Received: from santoshi-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:49:02 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH] cxl/mem: Demarcate vendor specific capability IDs
Date:   Thu, 20 May 2021 13:48:52 -0700
Message-Id: <20210520204852.1070780-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
spec, they are allowed and not "unknown". Call this detail out in the
logs to let users easily distinguish the difference.

This patch is a squash of two earlier patches and take in some minor
suggestions from both Vishal and Dan.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 84b90db57420..38979c97158d 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -60,7 +60,10 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 			regs->memdev = register_block;
 			break;
 		default:
-			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
+			if (cap_id >= 0x8000)
+				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
+			else
+				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
 			break;
 		}
 	}
-- 
2.31.1

