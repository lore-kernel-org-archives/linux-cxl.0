Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143FC4338F
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20C460F25
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhGWU0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671213"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671213"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436170"
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
Subject: [PATCH 17/23] cxl/region: Handle region's address space allocation
Date:   Fri, 23 Jul 2021 14:06:17 -0700
Message-Id: <20210723210623.114073-18-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Regions are carved out of an addresses space which is claimed by top
level decoders, and subsequently their children decoders. Regions are
created with a size and therefore must fit, with proper alignment, in
that address space. The support for doing this fitting is handled by the
driver automatically.

As an example, a platform might configure a top level decoder to claim
1TB of address space @ 0x800000000 -> 0x10800000000; it would be
possible to create M regions with appropriate alignment to occupy that
address space. Each of those regions would have a host physical address
somewhere in the range between 32G and 1.3TB, and the location will be
determined by the logic added here.

The request_region() usage is not strictly mandatory at this point as
the actual handling of the address space is done with genpools. It is
highly likely however that the resource/region APIs will become useful
in the not too distant future.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 19 +++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/region.c   | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 888586768631..baf4d4308ae5 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -637,6 +638,24 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 	rc = devm_add_action_or_reset(host, unregister_cxl_dev, dev);
 	if (rc)
 		return ERR_PTR(rc);
+
+	if (dev->type == &cxl_decoder_root_type) {
+		struct gen_pool *pool;
+		int order = ilog2(SZ_256M * cxld->interleave_ways);
+
+		pool = devm_gen_pool_create(dev, order, NUMA_NO_NODE,
+					    dev_name(dev));
+		if (IS_ERR(pool))
+			return ERR_CAST(pool);
+
+		cxld->address_space = pool;
+
+		rc = gen_pool_add(cxld->address_space, cxld->res.start,
+				  resource_size(&cxld->res), NUMA_NO_NODE);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	return cxld;
 
 err:
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 217619616d95..9975b4ecf78b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -194,6 +194,7 @@ enum cxl_decoder_type {
  * @region_ida: allocator for region ids.
  * @regions: List of regions mapped (may be disabled) by this decoder.
  * @youngest: Last region created for this decoder.
+ * @address_space: Used/free address space for regions.
  * @target: active ordered target list in current decoder configuration
  */
 struct cxl_decoder {
@@ -207,6 +208,7 @@ struct cxl_decoder {
 	struct ida region_ida;
 	struct list_head regions;
 	struct cxl_region *youngest;
+	struct gen_pool *address_space;
 	struct cxl_dport *target[];
 };
 
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 71efe7f29a35..1e996ffc0f22 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include "region.h"
@@ -23,9 +24,34 @@
  * relationship between decoder and region when the region is interleaved.
  */
 
+static int allocate_region_addr(struct cxl_region *region)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(region->dev.parent);
+	unsigned long start;
+
+	start = gen_pool_alloc(cxld->address_space, region->requested_size);
+	if (!start) {
+		trace_cxl_region_bind(region,
+				      "Couldn't allocate address space");
+		return -ENOMEM;
+	}
+
+	region->res =
+		__request_region(&cxld->res, start, region->requested_size,
+				 dev_name(&region->dev), IORESOURCE_EXCLUSIVE);
+	if (IS_ERR(region->res)) {
+		trace_cxl_region_bind(region, "Couldn't obtain region");
+		gen_pool_free(cxld->address_space, start,
+			      region->requested_size);
+		return PTR_ERR(region->res);
+	}
+
+	return 0;
+}
+
 static int bind_region(struct cxl_region *region)
 {
-	int i;
+	int i, rc;
 
 	if (dev_WARN_ONCE(&region->dev, !is_cxl_region_configured(region),
 			  "unconfigured regions can't be probed (race?)\n")) {
@@ -43,7 +69,9 @@ static int bind_region(struct cxl_region *region)
 			return -ENXIO;
 		}
 
-	/* TODO: Allocate from decoder's address space */
+	rc = allocate_region_addr(region);
+	if (rc)
+		return rc;
 
 	/* TODO: program HDM decoders */
 
-- 
2.32.0

