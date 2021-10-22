Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE02C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC061181
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhJVSjk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233975AbhJVSjg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528967"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528967"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854712"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:18 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 21/28] cxl/acpi: Handle address space allocation
Date:   Fri, 22 Oct 2021 11:37:02 -0700
Message-Id: <20211022183709.1199701-22-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
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

All decoders manage a host physical address space while active. Only the
root decoder has constraints on location and size. As a result, it makes
most sense for the root decoder to be responsible for managing the
entire address space, and mid-level decoders and endpoints can ask the
root decoder for suballocations.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h  |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 23afb3b8f5cc..65219b18f3bc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/platform_device.h>
+#include <linux/genalloc.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -75,6 +76,27 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	return 0;
 }
 
+/*
+ * Every decoder while active has an address space that it is decoding. However,
+ * only the root level decoders have fixed host physical address space ranges.
+ */
+static int cxl_create_cfmws_address_space(struct cxl_decoder *cxld,
+					  struct acpi_cedt_cfmws *cfmws)
+{
+	const int order = ilog2(SZ_256M * cxld->interleave_ways);
+	struct device *dev = &cxld->dev;
+	struct gen_pool *pool;
+
+	pool = devm_gen_pool_create(dev, order, NUMA_NO_NODE, dev_name(dev));
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	cxld->address_space = pool;
+
+	return gen_pool_add(cxld->address_space, cfmws->base_hpa,
+			    cfmws->window_size, NUMA_NO_NODE);
+}
+
 static void cxl_add_cfmws_decoders(struct device *dev,
 				   struct cxl_port *root_port)
 {
@@ -133,6 +155,14 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 		cxld->interleave_granularity =
 			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
+		rc = cxl_create_cfmws_address_space(cxld, cfmws);
+		if (rc) {
+			dev_err(dev,
+				"Failed to create CFMWS address space for decoder\n");
+			put_device(&cxld->dev);
+			goto next;
+		}
+
 		rc = cxl_decoder_add(cxld, target_map);
 		if (rc)
 			put_device(&cxld->dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 430de5ab805a..509b20375e0e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -225,6 +225,7 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
  * @region_ida: allocator for region ids.
+ * @address_space: Used/free address space for regions.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -237,6 +238,7 @@ struct cxl_decoder {
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
 	struct ida region_ida;
+	struct gen_pool *address_space;
 	const int nr_targets;
 	struct cxl_dport *target[];
 };
-- 
2.33.1

