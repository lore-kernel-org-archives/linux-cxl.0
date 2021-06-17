Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAF9C2B9F4
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029B2613E1
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhFQRjQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:39:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:2462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhFQRjQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:16 -0400
IronPort-SDR: wmdlpS29Tx+r/3vnk5otrcFFOU3xxXheoJ4jLXcO9b5SU6fy7M/a9JTWSaTGrzvh/O9mgwvEpf
 BJL3z8k2itkA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732197"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732197"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:04 -0700
IronPort-SDR: yeUHDNOQ9KOxTKnn06j04LRP4L7kEHHcC+P0zxUNqIxKqUKmxbkC3NUCgH6T2HEa17NXEFT1Cl
 ofJsrCdPDYtA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944117"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 5/6] cxl/core: Convert decoder range to resource
Date:   Thu, 17 Jun 2021 10:36:54 -0700
Message-Id: <20210617173655.430424-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617173655.430424-1-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
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
 drivers/cxl/core.c   | 9 +++------
 drivers/cxl/cxl.h    | 4 ++--
 drivers/cxl/region.c | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 44f982f4f247..0e598a18e95f 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -40,7 +40,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start);
 }
 static DEVICE_ATTR_RO(start);
 
@@ -49,7 +49,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
 }
 static DEVICE_ATTR_RO(size);
 
@@ -543,10 +543,7 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 90107b21125b..b08f0969abeb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -185,7 +185,7 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @res: address space resources considered by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -198,7 +198,7 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	struct resource res;
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 616b47903d69..62bca8b30349 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -59,7 +59,7 @@ static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
 	if (!region->res)
 		return sysfs_emit(buf, "\n");
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start - region->res->start);
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start - region->res->start);
 }
 static DEVICE_ATTR_RO(offset);
 
-- 
2.32.0

