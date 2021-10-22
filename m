Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E316C001B6
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15B660E8C
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhJVSjl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhJVSjh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528971"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854724"
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
Subject: [RFC PATCH v2 23/28] cxl/region: Implement XHB verification
Date:   Fri, 22 Oct 2021 11:37:04 -0700
Message-Id: <20211022183709.1199701-24-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Cross host bridge verification primarily determines if the requested
interleave ordering can be achieved by the root decoder, which isn't as
programmable as other decoders.

The algorithm implemented here is based on the CXL Type 3 Memory Device
Software Guide, chapter 2.13.14

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format        |  1 +
 drivers/cxl/region.c | 81 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/trace.h  |  3 ++
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index cb7c46371465..55f628f21722 100644
--- a/.clang-format
+++ b/.clang-format
@@ -169,6 +169,7 @@ ForEachMacros:
   - 'for_each_cpu_and'
   - 'for_each_cpu_not'
   - 'for_each_cpu_wrap'
+  - 'for_each_cxl_decoder_target'
   - 'for_each_cxl_endpoint'
   - 'for_each_dapm_widgets'
   - 'for_each_dev_addr'
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index d127c9c69eef..53442de33d11 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -30,6 +30,11 @@
 	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
 	     idx++, ep = (region)->targets[idx])
 
+#define for_each_cxl_decoder_target(target, decoder, idx)                      \
+	for (idx = 0, target = (decoder)->target[idx];                         \
+	     idx < (decoder)->nr_targets;                                      \
+	     idx++, target = (decoder)->target[idx])
+
 #define region_ways(region) ((region)->eniw)
 #define region_ig(region) (ilog2((region)->ig))
 
@@ -165,6 +170,28 @@ static bool qtg_match(const struct cxl_decoder *cfmws,
 	return true;
 }
 
+static int get_unique_hostbridges(const struct cxl_region *region,
+				  struct cxl_port **hbs)
+{
+	struct cxl_memdev *ep;
+	int i, hb_count = 0;
+
+	for_each_cxl_endpoint(ep, region, i) {
+		struct cxl_port *hb = get_hostbridge(ep);
+		bool found = false;
+		int j;
+
+		for (j = 0; j < hb_count; j++) {
+			if (hbs[j] == hb)
+				found = true;
+		}
+		if (!found)
+			hbs[hb_count++] = hb;
+	}
+
+	return hb_count;
+}
+
 /**
  * region_xhb_config_valid() - determine cross host bridge validity
  * @cfmws: The CFMWS to check against
@@ -178,7 +205,59 @@ static bool qtg_match(const struct cxl_decoder *cfmws,
 static bool region_xhb_config_valid(const struct cxl_region *region,
 				    const struct cxl_decoder *cfmws)
 {
-	/* TODO: */
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int cfmws_ig, i;
+	struct cxl_dport *target;
+
+	/* Are all devices in this region on the same CXL host bridge */
+	if (get_unique_hostbridges(region, hbs) == 1)
+		return true;
+
+	cfmws_ig = cfmws->interleave_granularity;
+
+	/* CFMWS.HBIG >= Device.Label.IG */
+	if (cfmws_ig < region_ig(region)) {
+		trace_xhb_valid(region,
+				"granularity does not support the region interleave granularity\n");
+		return false;
+	}
+
+	/* ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel) */
+	if (1 << (cfmws_ig - region_ig(region)) * (1 << cfmws->interleave_ways) >
+	    region_ways(region)) {
+		trace_xhb_valid(region,
+				"granularity to device granularity ratio requires a larger number of devices than currently configured");
+		return false;
+	}
+
+	/* Check that endpoints are hooked up in the correct order */
+	for_each_cxl_decoder_target(target, cfmws, i) {
+		struct cxl_memdev *endpoint = region->targets[i];
+
+		if (get_hostbridge(endpoint) != target->port) {
+			trace_xhb_valid(region, "device ordering bad\n");
+			return false;
+		}
+	}
+
+	/*
+	 * CFMWS.InterleaveTargetList[n] must contain all devices, x where:
+	 *	(Device[x],RegionLabel.Position >> (CFMWS.HBIG -
+	 *	Device[x].RegionLabel.InterleaveGranularity)) &
+	 *	((2^CFMWS.ENIW) - 1) = n
+	 *
+	 * Linux notes: All devices are known to have the same interleave
+	 * granularity at this point.
+	 */
+	for_each_cxl_decoder_target(target, cfmws, i) {
+		if (((i >> (cfmws_ig - region_ig(region)))) &
+		    (((1 << cfmws->interleave_ways) - 1) != target->port_id)) {
+			trace_xhb_valid(region,
+					"One or more devices are not connected to the correct hostbridge.");
+			return false;
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index a53f00ba5d0e..4de47d1111ac 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -38,6 +38,9 @@ DEFINE_EVENT(cxl_region_template, sanitize_failed,
 DEFINE_EVENT(cxl_region_template, allocation_failed,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, xhb_valid,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.33.1

