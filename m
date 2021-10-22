Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57CC4167E
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC8260E8C
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhJVSjk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:5584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233951AbhJVSjh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528969"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854719"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:19 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 22/28] cxl/region: Address space allocation
Date:   Fri, 22 Oct 2021 11:37:03 -0700
Message-Id: <20211022183709.1199701-23-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When a region is not assigned a host physical address, one is picked by
the driver. As the address will determine which CFMWS contains the
region, it's usually a better idea to let the driver make this
determination.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 35 +++++++++++++++++++++++++++++++++--
 drivers/cxl/trace.h  |  3 +++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index da4f91b48743..d127c9c69eef 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/platform_device.h>
+#include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -55,6 +56,17 @@ static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
 	return NULL;
 }
 
+static void release_cxl_region(void *r)
+{
+	struct cxl_region *region = (struct cxl_region *)r;
+	struct cxl_decoder *cxld = cxld_from_region(region);
+	struct resource *parent_res = &cxld->res;
+	const struct resource *res = region->res;
+
+	gen_pool_free(cxld->address_space, res->start, resource_size(res));
+	__release_region(parent_res, res->start, resource_size(res));
+}
+
 /**
  * sanitize_region() - Check is region is reasonably configured
  * @region: The region to check
@@ -104,8 +116,27 @@ static int sanitize_region(const struct cxl_region *region)
  */
 static int allocate_address_space(struct cxl_region *region)
 {
-	/* TODO */
-	return 0;
+	struct cxl_decoder *cxld = cxld_from_region(region);
+	unsigned long start;
+
+	start = gen_pool_alloc(cxld->address_space, region->size);
+	if (!start) {
+		trace_allocation_failed(region,
+					"Couldn't allocate address space");
+		return -ENOMEM;
+	}
+	region->res =
+		__request_region(&cxld->res, start, region->size,
+				 dev_name(&region->dev), IORESOURCE_EXCLUSIVE);
+
+	if (IS_ERR(region->res)) {
+		trace_allocation_failed(region, "Couldn't obtain region");
+		gen_pool_free(cxld->address_space, start, region->size);
+		return PTR_ERR(region->res);
+	}
+
+	return devm_add_action_or_reset(&region->dev, release_cxl_region,
+					region);
 }
 
 /**
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index 8f7f471e15b8..a53f00ba5d0e 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -35,6 +35,9 @@ DEFINE_EVENT(cxl_region_template, region_activated,
 DEFINE_EVENT(cxl_region_template, sanitize_failed,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, allocation_failed,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.33.1

