Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE95C18E7B
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D060F50
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhJVSjl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhJVSjh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528977"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854732"
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
Subject: [RFC PATCH v2 25/28] cxl/region: Record host bridge target list
Date:   Fri, 22 Oct 2021 11:37:06 -0700
Message-Id: <20211022183709.1199701-26-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Part of host bridge verification in the CXL Type 3 Memory Device
Software Guide calculates the host bridge interleave target list (6th
step in the flow chart). With host bridge verification already done, it
is trivial to store away the configuration information.

TODO: Needs support for switches (7th step in the flow chart).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 41 ++++++++++++++++++++++++++++++-----------
 drivers/cxl/region.h | 12 ++++++++++++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index ecf453fd3257..3276c7243c2a 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -294,14 +294,17 @@ static int get_num_root_ports(const struct cxl_region *region)
  * region_hb_rp_config_valid() - determine root port ordering is correct
  * @cfmws: CFMWS decoder for this @region
  * @region: Region to validate
+ * @p: HDM decoder programming state. Populated if non-NULL.
  *
  * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
  * sequence" of the CXL Memory Device SW Guide (Rev1p0).
  *
- * Returns true if the configuration is valid.
+ * Returns true if the configuration is valid, the configuration state is
+ * updated for later programming.
  */
 static bool region_hb_rp_config_valid(const struct cxl_region *region,
-				      const struct cxl_decoder *cfmws)
+				      const struct cxl_decoder *cfmws,
+				      struct decoder_programming *p)
 {
 	const int num_root_ports = get_num_root_ports(region);
 	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
@@ -309,18 +312,29 @@ static bool region_hb_rp_config_valid(const struct cxl_region *region,
 
 	hb_count = get_unique_hostbridges(region, hbs);
 
+	if (p)
+		p->hb_count = hb_count;
+
 	/*
 	 * Are all devices in this region on the same CXL Host Bridge
 	 * Root Port?
 	 */
-	if (num_root_ports == 1)
+	if (num_root_ports == 1) {
+		if (p) {
+			p->hbs[0].rp_target_list[0] = region->targets[0]->root_port;
+			p->hbs[0].rp_count = 1;
+		}
 		return true;
+	}
 
 	for (i = 0; i < hb_count; i++) {
+		struct cxl_dport *rp, **targets;
 		struct cxl_port *hb = hbs[i];
-		struct cxl_dport *rp;
 		int position_mask;
-		int idx;
+		int idx, *rp_count;
+
+		targets = &p->hbs[i].rp_target_list[0];
+		rp_count = &p->hbs[i].rp_count;
 
 		/*
 		 * Calculate the position mask: NumRootPorts = 2^PositionMask
@@ -343,9 +357,12 @@ static bool region_hb_rp_config_valid(const struct cxl_region *region,
 				if (ep->root_port != rp)
 					continue;
 
-				if (port_grouping == -1) {
+				if (port_grouping == -1)
 					port_grouping = idx & position_mask;
-					continue;
+
+				if (p) {
+					(*rp_count)++;
+					targets[port_grouping] = ep->root_port;
 				}
 
 				/*
@@ -379,7 +396,8 @@ static bool cfmws_contains(const struct cxl_region *region,
 }
 
 static bool cfmws_valid(const struct cxl_region *region,
-			const struct cxl_decoder *cfmws)
+			const struct cxl_decoder *cfmws,
+			struct decoder_programming *p)
 {
 	const struct cxl_memdev *endpoint = region->targets[0];
 
@@ -392,7 +410,7 @@ static bool cfmws_valid(const struct cxl_region *region,
 	if (!region_xhb_config_valid(region, cfmws))
 		return false;
 
-	if (!region_hb_rp_config_valid(region, cfmws))
+	if (!region_hb_rp_config_valid(region, cfmws, p))
 		return false;
 
 	if (!cfmws_contains(region, cfmws))
@@ -409,7 +427,7 @@ static int cfmws_match(struct device *dev, void *data)
 	if (!is_root_decoder(dev))
 		return 0;
 
-	return !!cfmws_valid(region, to_cxl_decoder(dev));
+	return !!cfmws_valid(region, to_cxl_decoder(dev), NULL);
 }
 
 /*
@@ -484,7 +502,8 @@ static int cxl_region_probe(struct device *dev)
 		return -ENXIO;
 
 	cfmws = cxld_from_region(region);
-	if (!cfmws_valid(region, cfmws)) {
+	if (!cfmws_valid(region, cfmws,
+			 (struct decoder_programming *)&region->state)) {
 		dev_err(dev, "Picked invalid cfmws\n");
 		return -ENXIO;
 	}
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index 5df417324cab..51f442636364 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -19,6 +19,10 @@
  * @eniw: Number of interleave ways this region is configured for.
  * @ig: Interleave granularity of region
  * @targets: The memory devices comprising the region.
+ * @state: Configuration state for host bridges, switches, and endpoints.
+ * @state.hbs: Host bridge state. One per hostbridge in the interleave set.
+ * @state.hbs.rp_count: Count of root ports for this region
+ * @state.hbs.rp_target_list: Ordered list of downstream root ports.
  */
 struct cxl_region {
 	struct device dev;
@@ -34,6 +38,14 @@ struct cxl_region {
 		int ig;
 		struct cxl_memdev *targets[CXL_DECODER_MAX_INTERLEAVE];
 	};
+
+	struct decoder_programming {
+		int hb_count;
+		struct {
+			int rp_count;
+			struct cxl_dport *rp_target_list[CXL_DECODER_MAX_INTERLEAVE];
+		} hbs[CXL_DECODER_MAX_INTERLEAVE];
+	} state;
 };
 
 bool is_cxl_region_configured(const struct cxl_region *region);
-- 
2.33.1

