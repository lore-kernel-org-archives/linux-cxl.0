Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A1355F57
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477855; cv=none; b=BBptbhXqY2a1HClmVcM6ALKRVBP9QEMDQBSSUEuQYzd5kmsnKf+e+qlFrL0SFVB99g8d8RKah953OvnxKEprvLUYsLTW4sv7Niek4a49w3haofP1h+vFabaNP53Zrz7mxgn6Dax7sWtDtnNvRKJnNiX/OeteZaDgPq9sET+eY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477855; c=relaxed/simple;
	bh=QdurHz2OfFURpQfzWhD+F1RBF6xwnxQSa2yF2MLrmj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKCdjtbGwwvLMn1kD+cWFdNMyUpLQ//Oc5MID4Xb1tfDjEfzfp50814Zt4a+EFG9y5RLaxGsszGYmL9zv+U+Nu/ocH2cTMkcxZUdlrzCn9wE7Z0zEu12mo7akCE1aYnX8OWrDqLin1rzVgTqKwq0x02PElovX/yYqp/J7CARkjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Afk+zs3B; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Afk+zs3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477852; x=1820013852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdurHz2OfFURpQfzWhD+F1RBF6xwnxQSa2yF2MLrmj4=;
  b=Afk+zs3BhqUtP0LxajpXddf7J7XT/MtZlc2z3/Ugjj8Ga7S9TUGd6cPO
   hsFfmD2Rv1lmoJOFJbURouyrDpM4ALjhvrUAE/tAJxcXDNHzdGsLuyELi
   rPoBfptxsxIYn0Azv9kQ2XEVedOmY69Ov/hJa1zZ2hMqiNhvTxbhyRiLt
   Qyyfbnk2ShI1hAXVYkFgRq3N7F6u7hdXbPqGCgmVIRloUr88AACNEbXeJ
   ARpkTlqR/2j+ANT7F7O1j4oNWzmWFnc5PMnWegWNE8HBvKYyw0Ue41IBX
   /bq19EEu//QfXkm1SyA9BgD0Rn1yCLSHy4ZO6JwZ2+fi20g1KGKEb/LRf
   g==;
X-CSE-ConnectionGUID: KsfXZ0ewS8aAdrmt+jD0nw==
X-CSE-MsgGUID: vvA9oWLJTsW4aFd4LJyMCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847690"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847690"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:12 -0700
X-CSE-ConnectionGUID: AFgaTWOQSSqRyyWQrqHc3Q==
X-CSE-MsgGUID: R07lReeaT1aoTGwk6lhFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129507"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:12 -0700
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
Subject: [PATCH v5 5/7] cxl/region: Support mixed-granularity auto regions
Date: Thu,  3 Sep 2026 16:23:47 -0700
Message-ID: <4ff59676f6db40e86749ebc810ead8ddfd3d3366.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Specification permits a region's interleave granularity to differ
between levels of the decoder hierarchy. For an auto region, the CXL driver
reconstructs that hierarchy from the decoder configuration programmed by
platform firmware.

The CXL driver currently requires the interleaving root to have the same
granularity as the region, with each successive interleaving level becoming
coarser toward the endpoints. A mixed-granularity region lifts that
requirement: its interleave granularity is finer than the granularity of
its interleaving root decoder. The driver cannot assemble such a region
today.

Support mixed-granularity auto regions in the CXL driver, restricted to
coarse-to-fine layouts. Derive each interleaving decoder's granularity from
its parent:

        child_ig = parent_ig / child_iw

A same-granularity region keeps the existing derivation, which coarsens
toward the endpoints:

        child_ig = parent_ig * parent_iw

The topology determines each decoder's interleave ways, so the parent
granularity and child ways determine the child granularity. Use that
relationship to validate the decoder geometry while assembling an auto
region. Only the interleaving levels are compared; a passthrough level,
child_iw == 1, keeps its granularity exemption.

Refuse a derived granularity finer than the region granularity. Dividing at
every level lands the deepest interleaving level exactly on the region
granularity, so a finer value means the topology below one port is deeper
than the region interleave has positions for, which happens only when
another branch is too shallow to cover its share. That is what rejects an
unbalanced tree below the interleaving root.

Require the root and region to interleave over the same span, the address
range in which the interleave pattern completes one full pass:

        root_iw * root_ig == region_iw * region_ig

The same span relationship covers the CXL Specification's Mod3
configurations. For example, a 6-way region at IGB across three host
bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave at
IGB below it, as described in CXL 4.0 Section 9.13.1.1.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 128 ++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 116f84bb0745..5b7104a55fdd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1435,6 +1435,15 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/* Mixed granularity has a region IG finer than the interleaving root IG */
+static bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+
+	return cxld->interleave_ways > 1 &&
+	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1448,7 +1457,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -1464,26 +1472,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	child_iw = cxl_rr->nr_targets;
+
 	if (cxl_rr->nr_targets_set) {
 		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
+		 * @distance is the spacing between region positions sharing this
+		 * dport. Mixed-granularity regions place them contiguously.
 		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+		if (!cxl_region_is_mixed_gran(cxlr)) {
+			struct cxl_region_ref *cxl_rr_iter;
+			struct cxl_port *iter = port;
+
+			do {
+				cxl_rr_iter = cxl_rr_load(iter, cxlr);
+				distance *= cxl_rr_iter->nr_targets;
+				iter = to_cxl_port(iter->dev.parent);
+			} while (!is_cxl_root(iter));
+			distance *= cxlrd->cxlsd.cxld.interleave_ways;
+		}
 
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
@@ -1497,15 +1505,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1538,7 +1546,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	child_iw = cxl_rr->nr_targets;
 	rc = ways_to_eiw(child_iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
@@ -1546,23 +1553,25 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
+	/* Only mixed-gran regions refine granularity toward the endpoints */
+	if (cxl_region_is_mixed_gran(cxlr)) {
+		child_ig = parent_ig / child_iw;
+
+		if (child_ig < p->interleave_granularity) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: granularity %d is finer than region granularity %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				child_ig, p->interleave_granularity);
+			return -ENXIO;
+		}
+	} else {
+		child_ig = parent_ig * parent_iw;
 	}
 
-	rc = eig_to_granularity(eig, &child_ig);
+	rc = granularity_to_eig(child_ig, &eig);
 	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
+		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), child_ig);
 		return rc;
 	}
 
@@ -2061,6 +2070,43 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
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
+	/*
+	 * Same-granularity regions below a power-of-two root may span multiple root
+	 * interleaves. Mod3 roots are width-matched instead.
+	 */
+	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
+		return 0;
+
+	/* Span is one complete pass through the interleave pattern. */
+	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"region span %d (%d ways at %d) must equal root span %d (%d ways at %d)\n",
+			p->interleave_ways * p->interleave_granularity,
+			p->interleave_ways, p->interleave_granularity,
+			root_iw * root_ig, root_iw, root_ig);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2103,6 +2149,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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

