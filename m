Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A5C43219
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55E5610CF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347413AbhIBTve (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:41967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347403AbhIBTvb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778211"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451652"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:27 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 11/13] cxl/core: Convert decoder range to resource
Date:   Thu,  2 Sep 2021 12:50:15 -0700
Message-Id: <20210902195017.2516472-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
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
index fd14094bdb3f..26691313d716 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -125,10 +125,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 
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
@@ -318,10 +317,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
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
index 01b6fa8373e4..d056dbd794a4 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -48,7 +48,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start);
 }
 static DEVICE_ATTR_RO(start);
 
@@ -57,7 +57,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
 }
 static DEVICE_ATTR_RO(size);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4585d03a0a67..e610fa9dd6c8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -192,7 +192,7 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @res: address space resources considered by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -203,7 +203,7 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	struct resource res;
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
-- 
2.33.0

