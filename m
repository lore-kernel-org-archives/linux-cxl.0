Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267E379C24
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268693; cv=none; b=coMDPPgbCi1KEreo6/bct8HIs/U+IU0aMWC/Ij6TzeAKibpXFbWAFXY7vrGv1KuiluMkkXMYs5buu4LMoBcU7JPdQVjDF4pD0Dew0s1MRpUOW10tAP2SibjbdY1wW4rFKx18EwJPaNuDBb2omMDlZc2pKnLtJqcuyrNQJuJVwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268693; c=relaxed/simple;
	bh=XvWJl9jWd6mL0f/5ErF05vim6VDHelrN1ebeFCe7ZKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ina6+T0SmvUT9Mmtl+phit7k+ZBerbyhYXT6TaZ/ElmOMxCLLNRGOUq4k6gNBlvf6H5CkA+JsDL9/AxW8YXGGa0oIag8TqJ3qsDO+PC9CqL558ULDLwuUOJCNfiwXSf0JV3idGTRsXbjFDvCfxadS39eEo9/li+bbu9TCF6Yqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f38MW975; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f38MW975"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268692; x=1818804692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XvWJl9jWd6mL0f/5ErF05vim6VDHelrN1ebeFCe7ZKI=;
  b=f38MW975ApQPqHG8lRWc1kwIYb+2AQp6LBw0X03WWuiHvuo/7EmLsNTW
   F5iVTuW7gu+qEN1iIbdwyv20uLRE8tC/Av7XC1O4wTTWq1eJWyDWnNu7Q
   XL5u3p9LwqTNZU5iewTgsW7N6yF7l3LO+WvPOl9UPCJOoFPbVb0XU1Noi
   Jr+51k+GZdc0wLW5BcpNKId1QEGye9aW/PF+HvgKd+7wT7i0fwwz9+zG/
   AkMQ5O7OqQn96QCf7/GcIHxvwJ3fLUzWs+dbM+ckdBrA9uoyD8OA86yop
   1VBlljMluKl87S+2lC2rxGo4susq9k9OjYuooHr22e1NjXy8blIVsjnxr
   Q==;
X-CSE-ConnectionGUID: Li583L9pRumgf+bRYH3I3A==
X-CSE-MsgGUID: wJU1HCiURiCxizIbI2psJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483425"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:32 -0700
X-CSE-ConnectionGUID: t2/FMzN8S/SZeSdX4XS3MA==
X-CSE-MsgGUID: jH4zLigCQui/6VwGzG+tHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261905999"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto regions
Date: Thu, 20 Aug 2026 16:31:21 -0700
Message-ID: <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Specification permits a region's interleave granularity to
differ between levels of the decoder hierarchy. For an auto region,
the CXL driver reconstructs that hierarchy from the decoder
configuration programmed by platform firmware.

The CXL driver currently assumes the interleaving root has the same
granularity as the region, with each successive interleaving level
becoming coarser toward the endpoints. This prevents the driver from
assembling an auto region where the root granularity is coarser than
the region granularity.

Support mixed-granularity auto regions in the CXL driver, restricted
to coarse-to-fine layouts. Derive each interleaving decoder's
granularity from its parent:

        child_ig = parent_ig / child_iw

The topology determines each decoder's interleave ways, so the parent
granularity and child ways determine the child granularity. Use that
relationship to validate the decoder geometry while assembling an auto
region.

Require the root and region to describe the same interleave span:

        root_iw * root_ig == region_iw * region_ig

The same span relationship covers the CXL Specification's Mod3
configurations. For example, a 6-way region at IGB across three host
bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave
at IGB below it, as described in CXL 4.0 Section 9.13.1.1.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 114 ++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4f367feaf6c8..637d1b60a570 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1434,6 +1434,16 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/* Mixed granularity has a region IG finer than the interleaving root IG */
+static bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+
+	return cxld->interleave_ways > 1 &&
+	       cxld->interleave_granularity >
+		       cxlr->params.interleave_granularity;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1447,7 +1457,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -1463,26 +1472,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	iw = cxl_rr->nr_targets;
+
 	if (cxl_rr->nr_targets_set) {
-		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
+		int i, distance;
 
 		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
+		 * @distance is the spacing between region positions sharing
+		 * this dport. Mixed-granularity regions place those positions
+		 * contiguously.
 		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+		if (cxl_region_is_mixed_gran(cxlr))
+			distance = 1;
+		else
+			distance = cxld->interleave_granularity * iw /
+				   p->interleave_granularity;
 
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
@@ -1496,15 +1500,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
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
+		/*
+		 * A non-interleaving root does not contribute to the region
+		 * interleave.
+		 */
+		if (parent_iw > 1)
+			parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
+		else
+			parent_ig = p->interleave_granularity;
 		/*
 		 * For purposes of address bit routing, use power-of-2 math for
 		 * switch ports.
@@ -1537,7 +1541,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	iw = cxl_rr->nr_targets;
 	rc = ways_to_eiw(iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
@@ -1545,23 +1548,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
+	if (cxl_region_is_mixed_gran(cxlr))
+		ig = parent_ig / iw;
+	else
+		ig = parent_ig * parent_iw;
 
-	rc = eig_to_granularity(eig, &ig);
+	rc = granularity_to_eig(ig, &eig);
 	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
+		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), ig);
 		return rc;
 	}
 
@@ -2058,6 +2053,39 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static int cxl_region_validate_interleave(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p = &cxlr->params;
+	int root_iw = cxld->interleave_ways;
+	int root_ig = cxld->interleave_granularity;
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
+	/* Same-gran power-of-two regions may span multiple root targets */
+	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
+		return 0;
+
+	/* Mixed-gran regions must span exactly one root interleave */
+	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"%d ways at %d does not span root decoder %d ways at %d\n",
+			p->interleave_ways, p->interleave_granularity, root_iw,
+			root_ig);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2100,6 +2128,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	rc = cxl_region_validate_interleave(cxlr);
+	if (rc)
+		return rc;
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

