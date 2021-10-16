Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2BC4321E
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A6D60D42
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhJPFRr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:1736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhJPFRq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489594"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743249"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 05/27] cxl/core: Convert decoder range to resource
Date:   Fri, 15 Oct 2021 22:15:09 -0700
Message-Id: <20211016051531.622613-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
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

