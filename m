Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7038DC4338F
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508D360F36
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGWU0E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhGWU0E (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671189"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436129"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:36 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 07/23] cxl/pci: Ignore unknown register block types
Date:   Fri, 23 Jul 2021 14:06:07 -0700
Message-Id: <20210723210623.114073-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
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

