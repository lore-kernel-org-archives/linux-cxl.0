Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002241;
	b=3/vTt56j9HMavro22rCRBvtocDcoO+D5D/Ybqpjtk3MG5zAy/DXX2Dz0zoO2sqUJDmc5
	 gJ4GaW/o44wxh5gH/IEbvVkakKY+oTuVTDpehgl6pWBAUlgi1h1QAEjgJvIMw2OxXxr3w
	 yVC9eOehzvLmN7NMDzDugyadpq/bNGMEoMjJr8r0CJeu0df9FTRX0yV1SOwD1WVJVZNF7
	 +riKmHoQ8a6nS+hIJplJhiCQ6eDNqp8oXD0KcS82G2coB3K3VdaXSxWRHRDZwbnwDwnmm
	 vWWjIer74PdbBk5wCnZ9uJKaONc/dwTUbib1xardRS5iq5oa3RSnja2Jr/Nr4oXhBXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002241;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SdfqBEu5pXKRJLvJm0LuJkwuw/kjXM14L+bib3wEYNQ=;
	b=u8nxfXCUho7h12NBN0Kzmoa8bQ22o67pLuozvTwSwCHmg+A+3XCetg4qGKrDsyRUaobX
	 cNNyumkijtMiddIel7yi8YcET57hGoFnE6xI/LesKfzmD6n19PIy2Rmzxyu/ZJJYSKigZ
	 apvczXQyRwIIXjTmNkhXwqiQ5Dh3kKJd3mNfOgF30HNeMpqjMpuH+H28+CmeqCm2QeX6d
	 OZdMc+A7RFAp4R9yMNdTb1zh552dCCdghMkVxHkDg9ZI3kA+wybWpb/BI2uETjrnRP6+5
	 ahYcdGx6Yc6LIlsK9FfWqIoFz6CDji0HuqJhu1/U4pZxQXHUHUphw81iceAyAqijNsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kezDCjH2;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E0606A32D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 21:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E9E0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kezDCjH2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002240; x=1825538240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PigV5WQsYMRER1oqPdeT1NzfHZ7U0X9lcD4hEObjFY=;
  b=kezDCjH2tj8NONDsmcoPQRM0Iu6i74PqJihIUihuTWuAiZD/IPOHmB+v
   /6zMnfufm3Omri3j4VAUZ4Nkgy76ZsPlcZpIihQd2RLQ9NKx8WmMHNQNf
   kYzkXigeJ6TysuyhBMRBHbYvGD1gAEKaPwvUUAiHrEZwFNTdISeByKuZr
   dP+XljFMZq55LbfFVJIC8PwxO1XOkZvbjoKMckVZxoHnsvM6J6vkveKnp
   plsN4Mg2gBvnJlcYlx4qo1YwUf6D4hShVhc7Tj7k9nQLW5Be1+lMBPVMR
   MPmaSMlwDS2jkAN+3i/7uLZP6fbUys4ybAdqnBbLgCVstfC2B50AxdtKH
   g==;
X-CSE-ConnectionGUID: pZBpKCcKTQiG6y3NOtwIKw==
X-CSE-MsgGUID: cwwKddOQTUWudWckh7sYMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2812927"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2812927"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:19 -0800
X-CSE-ConnectionGUID: nlyu/qS2Qty3Yq+xm2TIbg==
X-CSE-MsgGUID: yfe2o/nPTt286BZT73ZJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147239"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:19 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v7 3/5] cxl/region: Support auto region granularity finer than the root
Date: Fri,  6 Nov 2026 13:57:10 -0800
Message-ID: <15338cf5f174c87f414e4518b24edb3c1f8371bd.1794000806.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794000806.git.alison.schofield@intel.com>
References: <cover.1794000806.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Specification permits a region's interleave granularity to differ
between levels of the decoder hierarchy. For an auto region, the CXL driver
reconstructs that hierarchy from the decoder configuration programmed by
platform firmware.

The CXL driver currently requires the interleaving root to have the same
granularity as the region, with each successive interleaving level becoming
coarser toward the endpoints. The driver cannot assemble a region whose
interleave granularity is finer than the granularity of its interleaving
root decoder.

Support auto regions with a granularity finer than the root, restricted to
configurations whose granularity refines monotonically toward the
endpoints. Derive each interleaving decoder's granularity from its parent:

        ig = parent_ig / iw

A same-granularity region keeps the existing derivation, which coarsens
toward the endpoints:

        ig = parent_ig * parent_iw

The topology determines each decoder's interleave ways, so the parent
granularity and the decoder's ways determine its granularity. Use that
relationship to validate the decoder geometry while assembling an auto
region. Only the interleaving levels are compared; a passthrough level,
iw == 1, keeps its granularity exemption.

Refuse a derived granularity finer than the region granularity. Each
interleaving level consumes part of the region interleave, and the deepest
interleaving level must not refine beyond the region granularity.

For the layouts Linux supports, require the root and region to interleave
over the same span, the address range in which the interleave pattern
completes one full pass:

        root_iw * root_ig == region_iw * region_ig

The same span relationship covers the CXL Specification's Mod3
configurations. For example, a 6-way region at IGB across three host
bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave at
IGB below it, as described in CXL 4.0 Section 9.13.1.1.

Use the region granularity and ways when translating unaligned region
offsets to DPA, so poison injection and clearing work with the new layouts.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 106 +++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1594bec3930b..0a39e634b4b0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,6 +1432,52 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static int check_root_interleave(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p = &cxlr->params;
+	int root_ig = cxld->interleave_granularity;
+	int root_iw = cxld->interleave_ways;
+
+	if (root_iw == 1)
+		return 0;
+
+	if (p->interleave_granularity > root_ig) {
+		dev_dbg(&cxlr->dev,
+			"granularity %d exceeds root decoder granularity %d\n",
+			p->interleave_granularity, root_ig);
+		return -ENXIO;
+	}
+
+	/*
+	 * A same-granularity region below a power-of-two root may repeat
+	 * the root targets, spanning a multiple of the root span.
+	 */
+	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
+		return 0;
+
+	/* Span is one complete pass through the interleave pattern */
+	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"region span %d (%d ways at %d) does not match root span %d (%d ways at %d)\n",
+			p->interleave_ways * p->interleave_granularity,
+			p->interleave_ways, p->interleave_granularity,
+			root_iw * root_ig, root_iw, root_ig);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+/* Region IG is finer than the IG of its interleaving root decoder */
+static bool cxl_region_is_finer_than_root(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+
+	return cxld->interleave_ways > 1 &&
+	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
+}
+
 /*
  * The "distance" between peer downstream ports represents which
  * endpoint positions in the region interleave a given port can
@@ -1449,6 +1495,14 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	struct cxl_port *iter = port;
 	int distance = 1;
 
+	/*
+	 * A finer-than-root region refines toward the endpoints, so peer
+	 * targets at the finest interleaving level occupy consecutive region
+	 * positions.
+	 */
+	if (cxl_region_is_finer_than_root(cxlr))
+		return 1;
+
 	do {
 		cxl_rr_iter = cxl_rr_load(iter, cxlr);
 		distance *= cxl_rr_iter->nr_targets;
@@ -1476,15 +1530,17 @@ static int cxl_port_parent_interleave(struct cxl_port *port,
 	int parent_iw, parent_ig;
 
 	if (is_cxl_root(parent_port)) {
-		/*
-		 * Root decoder IG is always set to value in CFMWS which
-		 * may be different than this region's IG.  We can use the
-		 * region's IG here since interleave_granularity_store()
-		 * does not allow interleaved host-bridges with
-		 * root IG != region IG.
-		 */
-		parent_ig = p->interleave_granularity;
 		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
+		if (parent_iw > 1) {
+			parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
+		} else {
+			/*
+			 * A single-way root does not interleave, so its
+			 * granularity does not constrain the region interleave.
+			 * Use the region granularity instead.
+			 */
+			parent_ig = p->interleave_granularity;
+		}
 		if (!is_power_of_2(parent_iw))
 			parent_iw /= 3;
 	} else {
@@ -1521,7 +1577,7 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 				    struct cxl_region_ref *cxl_rr, int *out_iw,
 				    int *out_ig)
 {
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	int parent_iw, parent_ig, iw, ig, rc;
 	struct cxl_switch_decoder *cxlsd;
@@ -1537,16 +1593,24 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 		return -EINVAL;
 	}
 
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	ig = parent_ig * parent_iw;
+	/* Finer-than-root regions refine granularity toward the endpoints */
+	if (cxl_region_is_finer_than_root(cxlr)) {
+		ig = parent_ig / iw;
+
+		if (ig < p->interleave_granularity) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: granularity %d is finer than region granularity %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				ig, p->interleave_granularity);
+			return -ENXIO;
+		}
+	} else {
+		ig = parent_ig * parent_iw;
+	}
 
 	if (!granularity_valid(ig)) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
+		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), ig);
 		return -EINVAL;
 	}
 
@@ -2186,6 +2250,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	rc = check_root_interleave(cxlr);
+	if (rc)
+		return rc;
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
@@ -3590,8 +3658,8 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
 	 * a dpa_offset independent of the target device and then enumerate
 	 * and test that dpa_offset against each candidate endpoint decoder.
 	 */
-	gran = cxld->interleave_granularity;
-	interleave_width = gran * cxld->interleave_ways;
+	gran = p->interleave_granularity;
+	interleave_width = gran * p->interleave_ways;
 	interleave_index = div64_u64(offset, interleave_width);
 	gran_offset = do_div(tmp, gran);
 
-- 
2.37.3

