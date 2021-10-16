Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69078C433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569FA60D42
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhJPFR4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:31055 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243705AbhJPFRy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214961680"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="214961680"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743355"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 27/27] dont-merge: My QEMU CFMWS is wrong
Date:   Fri, 15 Oct 2021 22:15:31 -0700
Message-Id: <20211016051531.622613-28-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It seems to only be me... Use this at your own risk.
---
 drivers/cxl/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index a861001ced5b..6e4d79b32e41 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -404,8 +404,10 @@ static bool cfmws_valid(const struct cxl_region *region,
 	if (!qtg_match(cfmws, endpoint))
 		return false;
 
+#if 0
 	if (!cxl_is_pmem_t3(cfmws->flags))
 		return false;
+#endif
 
 	if (!region_xhb_config_valid(region, cfmws))
 		return false;
-- 
2.33.1

