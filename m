Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE6C19F31
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751CA60F25
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhGWU0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:34290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671212"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436166"
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
Subject: [PATCH 16/23] cxl/core: Convert decoder range to resource
Date:   Fri, 23 Jul 2021 14:06:16 -0700
Message-Id: <20210723210623.114073-17-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
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
 drivers/cxl/core/bus.c    | 9 +++------
 drivers/cxl/core/region.c | 3 +--
 drivers/cxl/cxl.h         | 4 ++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index b3f2d19ab01f..888586768631 100644
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
 
@@ -575,10 +575,7 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 
 	*cxld = (struct cxl_decoder) {
 		.id = rc,
-		.range = {
-			.start = base,
-			.end = base + len - 1,
-		},
+		.res = DEFINE_RES_MEM_NAMED(base, len, "cxl-decoder"),
 		.flags = flags,
 		.interleave_ways = interleave_ways,
 		.interleave_granularity = interleave_granularity,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d5a52091ae2..e9b6549d152a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -45,8 +45,7 @@ static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
 	if (!region->res)
 		return sysfs_emit(buf, "\n");
 
-	return sysfs_emit(buf, "%#llx\n",
-			  cxld->range.start - region->res->start);
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start - region->res->start);
 }
 static DEVICE_ATTR_RO(offset);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c516182eb7bc..217619616d95 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -186,7 +186,7 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @res: address space resources considered by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -199,7 +199,7 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	struct resource res;
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
-- 
2.32.0

