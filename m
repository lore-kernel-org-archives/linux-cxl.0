Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152AC43217
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D573A60F93
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhJVSje (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:5582 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhJVSje (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528930"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854613"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:15 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
Date:   Fri, 22 Oct 2021 11:36:46 -0700
Message-Id: <20211022183709.1199701-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Regions will use the resource API in order to help manage allocated
space. As regions are children of the decoder, it makes sense that the
parent host the main resource to be suballocated by the region.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     | 12 ++++--------
 drivers/cxl/core/bus.c |  4 ++--
 drivers/cxl/cxl.h      |  4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7d13e7f0aefc..b972abc9f6ef 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -126,10 +126,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 
 		cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 		cxld->target_type = CXL_DECODER_EXPANDER;
-		cxld->range = (struct range) {
-			.start = cfmws->base_hpa,
-			.end = cfmws->base_hpa + cfmws->window_size - 1,
-		};
+		cxld->res = (struct resource)DEFINE_RES_MEM_NAMED(cfmws->base_hpa,
+								  cfmws->window_size,
+								  "cfmws");
 		cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
 		cxld->interleave_granularity =
 			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
@@ -339,10 +338,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->range = (struct range) {
-		.start = 0,
-		.end = -1,
-	};
+	cxld->res = (struct resource)DEFINE_RES_MEM(0, 0);
 
 	device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index ebd061d03950..454d4d846eb2 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -47,7 +47,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start);
 }
 static DEVICE_ATTR_RO(start);
 
@@ -56,7 +56,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
 }
 static DEVICE_ATTR_RO(size);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4483e1a39fc3..7f2e2bdc7883 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -195,7 +195,7 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @res: address space resources considered by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -206,7 +206,7 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	struct resource res;
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
-- 
2.33.1

