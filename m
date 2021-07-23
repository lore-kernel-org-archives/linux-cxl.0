Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067EC19F32
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA98360F42
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhGWU0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671215"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671215"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436175"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 18/23] cxl/region: Only allow CXL capable targets
Date:   Fri, 23 Jul 2021 14:06:18 -0700
Message-Id: <20210723210623.114073-19-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A cxl_memdev exists for all CXL endpoints that support the CXL.io
protocol. If that device cannot participate in CXL.mem protocol, then it
cannot be part of a region's interleave set.

The ABI allows setting a target which is currently not CXL.mem capable
and only will fail when the binding to the region driver occurs. This is
in line with the other configuration parameters which are only strictly
validated when the driver gets bound to the region.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.h    | 5 +++++
 drivers/cxl/region.c | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 4f3ac1ccee0a..27e142cb0c55 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -93,4 +93,9 @@ struct cxl_mem {
 	struct range ram_range;
 };
 
+static inline bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
+{
+	return false;
+}
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 1e996ffc0f22..d625dd81c13a 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -63,11 +63,17 @@ static int bind_region(struct cxl_region *region)
 		return -ENXIO;
 	}
 
-	for (i = 0; i < region->eniw; i++)
+	for (i = 0; i < region->eniw; i++) {
 		if (!region->targets[i]) {
 			trace_cxl_region_bind(region, "Missing memory device target");
 			return -ENXIO;
 		}
+		if (!is_cxl_mem_capable(region->targets[i])) {
+			trace_cxl_region_bind(region,
+					      "Target isn't CXL.mem capable");
+			return -ENODEV;
+		}
+	}
 
 	rc = allocate_region_addr(region);
 	if (rc)
-- 
2.32.0

