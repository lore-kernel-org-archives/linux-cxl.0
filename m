Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7972C11F66
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 03:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6A360720
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 03:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhGNDYB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jul 2021 23:24:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:42996 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237436AbhGNDYA (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 13 Jul 2021 23:24:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197551548"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="197551548"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:21:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="430274531"
Received: from nhabayar-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.130.181])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:21:09 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] cxl/pci: Fix debug message
Date:   Tue, 13 Jul 2021 20:20:54 -0700
Message-Id: <20210714032054.293737-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When mapping a register, the debug message should use the verb 'map' not
'probe'.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4cf351a3cf99..fe240e1504d5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1048,7 +1048,7 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
-		dev_dbg(dev, "Probing device registers...\n");
+		dev_dbg(dev, "Mapping device registers...\n");
 		break;
 	default:
 		break;
-- 
2.32.0

