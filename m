Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB874C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhK2WB7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:01:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:46994 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhK2V77 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:59:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968510"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596109"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 9/9] cxl/core: Convert decoder range to resource
Date:   Mon, 29 Nov 2021 13:47:21 -0800
Message-Id: <20211129214721.1668325-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL decoders manage address ranges in a hierarchical fashion whereby a
leaf is a unique subregion of its parent decoder (midlevel or root). It
therefore makes sense to use the resource API for handling this.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
- Use %pr for resource formatting (Dan)
- Drop unnecessary zero initialization (Dan)
- Add comment about root decoder resource naming (Dan)
---
 drivers/cxl/acpi.c     | 22 ++++++++--------------
 drivers/cxl/core/bus.c | 23 +++++++++++++++++++++--
 drivers/cxl/cxl.h      |  8 ++++++--
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index c656a49a11a9..da70f1836db6 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -108,10 +108,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->range = (struct range){
-		.start = cfmws->base_hpa,
-		.end = cfmws->base_hpa + cfmws->window_size - 1,
-	};
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
+							     cfmws->window_size);
 	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
 	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
@@ -121,14 +119,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
-			cfmws->base_hpa,
-			cfmws->base_hpa + cfmws->window_size - 1);
+		dev_err(dev, "Failed to add decoder for %pr\n",
+			&cxld->platform_res);
 		return 0;
 	}
-	dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
-		dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
-		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
+	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
+		phys_to_target_node(cxld->platform_res.start),
+		&cxld->platform_res);
 
 	return 0;
 }
@@ -270,10 +267,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->range = (struct range) {
-		.start = 0,
-		.end = -1,
-	};
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
 	device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 17a4fff029f8..ab756a53a983 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -46,8 +46,14 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 start;
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	if (is_root_decoder(dev))
+		start = cxld->platform_res.start;
+	else
+		start = cxld->decoder_range.start;
+
+	return sysfs_emit(buf, "%#llx\n", start);
 }
 static DEVICE_ATTR_RO(start);
 
@@ -55,8 +61,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 size;
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	if (is_root_decoder(dev))
+		size = resource_size(&cxld->platform_res);
+	else
+		size = range_len(&cxld->decoder_range);
+
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -548,6 +560,13 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	if (rc)
 		return rc;
 
+	/*
+	 * Platform decoder resources should show up with a reasonable name. All
+	 * other resources are just sub ranges within the main decoder resource.
+	 */
+	if (is_root_decoder(dev))
+		cxld->platform_res.name = dev_name(dev);
+
 	return device_add(dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d39d45f4a770..ad816fb5bdcc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -179,7 +179,8 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @platform_res: address space resources considered by root decoder
+ * @decoder_range: address space resources considered by midlevel decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -190,7 +191,10 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	union {
+		struct resource platform_res;
+		struct range decoder_range;
+	};
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
-- 
2.34.1

