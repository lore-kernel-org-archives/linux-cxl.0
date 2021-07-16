Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E79C12002
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E838613D4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhGPXS6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:18:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:65193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237401AbhGPXS5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Jul 2021 19:18:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="190479025"
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="190479025"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="431362189"
Received: from jhiga-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] cxl/pci: Ignore unknown register block types
Date:   Fri, 16 Jul 2021 16:15:46 -0700
Message-Id: <20210716231548.174778-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716231548.174778-1-ben.widawsky@intel.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In an effort to explicit avoid supporting vendor specific register
blocks (which can happily be mapped from userspace), entirely skip
probing unknown types. The secondary benefit of this will be revealed
in the future with code simplification.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d7da18ebba81..dd0ac89fbdf4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1106,14 +1106,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		u64 offset;
 		u8 bar;
 
-		map = kzalloc(sizeof(*map), GFP_KERNEL);
-		if (!map) {
-			ret = -ENOMEM;
-			goto free_maps;
-		}
-
-		list_add(&map->list, &register_maps);
-
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
@@ -1123,6 +1115,18 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
 			bar, offset, reg_type);
 
+		/* Ignore unknown register block types */
+		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
+			continue;
+
+		map = kzalloc(sizeof(*map), GFP_KERNEL);
+		if (!map) {
+			ret = -ENOMEM;
+			goto free_maps;
+		}
+
+		list_add(&map->list, &register_maps);
+
 		base = cxl_mem_map_regblock(cxlm, bar, offset);
 		if (!base) {
 			ret = -ENOMEM;
-- 
2.32.0

