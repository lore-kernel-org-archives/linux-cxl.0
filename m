Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056F17555
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099256; cv=none; b=h4UhMouPJxf3koVDFo2e13p9G5K08Jpm1SmAwU9zZEPYdSsRD8Bobt9RBUCFt1CLp7DYsRAmx1lB0rAjHyD05p+vUhEIbaafn+siuyqyrRooy9XkLHdcliG4tsJ9X4cZzGw4yvDT2C+YWy/oDerVDtcTwxPCfLSahD4jC9CCJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099256; c=relaxed/simple;
	bh=YE3Slb3Te26l2ESfE1/ShUNjpDuWXjKJ9xKlj9+GB8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y89bR6Libo7aS96L9qe6HTjvQmyuUPm1x+N6SKYu8Ut0mY9fBvOYsAq8OKy83VA8waz5urRZ65dKLO7f/KpEskRz7tko5Y66nYJouwOMONXPuQNoXLw4Ust6PvhE9JCsGx5FIHzq3XeG6jwZ1tgbAPq++FmpOBsSB7C3MzUiny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl8RjreH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl8RjreH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780099254; x=1811635254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YE3Slb3Te26l2ESfE1/ShUNjpDuWXjKJ9xKlj9+GB8c=;
  b=Pl8RjreHgs4F4kupLsBPXLejzuli9FMXfhHiNA0igely7uZ0sEHfU5my
   x07ow0hDwGiRzWtX9J8KFkhUq6c0TnobsKvos8aLZlv+dULtoIZebfxe5
   qzg8IcQckA9pSAIL0kPGEnok/RNnxykd1nwwL/qPrK4f4UGsi++47U5F9
   7bQmrhuoe22YZa8A6+RmCNVN3Et73KVQqn+nK9NxDPi8KFM08hk1YCGcC
   1kA6xoABxsb8Msyafhd/ZhOMUEmNn11v1BPdE3z4ijZjIaZ+DXo4grc7A
   RH5EfZpRIu8qyzZ/odfDv99Svav12EqhoVeti2MNfeMWl8lNLqQm2TjKb
   w==;
X-CSE-ConnectionGUID: PEpeAbXyQy+wSF5nQrv0Aw==
X-CSE-MsgGUID: 7TpkDRh/SSS/NjyjKdjqNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91530535"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="91530535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:54 -0700
X-CSE-ConnectionGUID: kUtUJ1aBRsmY/jPyEYGxyA==
X-CSE-MsgGUID: 6EW/X8FFQeWfuWiMbvuG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="238804356"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/6] cxl/region: Validate interleave selector bits
Date: Fri, 29 May 2026 17:00:40 -0700
Message-ID: <1a8a115cee9eddf5511e4a75f6dcb86783f0fa1e.1780095671.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1780095671.git.alison.schofield@intel.com>
References: <cover.1780095671.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-level interleaves are valid when each decoder level claims a
distinct portion of the region HPA selector. The existing setup is
too restrictive as it requires that each level's granularity must
equal the parent granularity multiplied by the parent ways. That
forces the root to sit at the innermost selector bit and rejects
legal layouts where the root claims an outer bit.

Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
selector bits from the root toward the current port, reject overlap,
and reject any accumulated selector that does not fit within the
region selector.

Preserve the existing same-granularity behavior using values derived
from the selector walk.

Remove the auto-region granularity equality check that duplicates
the old ordering rule. The selector walk now validates auto region
granularities.

Block mixed-granularity attachments until position arithmetic is
updated by a later patch.

Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 196 +++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 97 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..87fb1a9f2683 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1423,12 +1423,34 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/**
+ * get_selector() - Return the HPA selector mask for one level
+ * @ways: interleave ways
+ * @gran: interleave granularity in bytes
+ *
+ * Return: ``(ways - 1) * gran`` for power-of-2 interleaves, or the
+ * selector for the power-of-2 component of a 6-way or 12-way interleave.
+ *
+ * A 3-way interleave consumes no HPA selector bits.
+ */
+static inline u64 get_selector(u64 ways, u64 gran)
+{
+	if (!is_power_of_2(ways))
+		ways /= 3;
+
+	if (!is_power_of_2(ways) || !is_power_of_2(gran))
+		return 0;
+
+	return (ways - 1) * gran;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	int distance, parent_distance;
+	int ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1436,9 +1458,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
+	u64 selector, cxlr_sel;
+	struct cxl_port *iter;
+	u16 eig;
+	u8 eiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1452,28 +1475,69 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	iw = cxl_rr->nr_targets;
+
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
+	/* Track selector bits already claimed by ancestor decoders */
+	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
+				cxlrd->cxlsd.cxld.interleave_granularity);
+
+	/* Track distances used in passthrough granularity and peer checks */
+	parent_distance = cxlrd->cxlsd.cxld.interleave_ways;
+	if (!is_power_of_2(parent_distance))
+		parent_distance /= 3;
+	distance = cxlrd->cxlsd.cxld.interleave_ways;
+
+	for (iter = parent_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
+		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
+		u64 cxld_sel;
+
+		if (cxld_iter->interleave_ways == 1)
+			continue;
+
+		cxld_sel = get_selector(cxld_iter->interleave_ways,
+					cxld_iter->interleave_granularity);
+
+		if (cxld_sel & selector) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: overlapping selectors: %#llx:%#llx\n",
+				dev_name(iter->uport_dev),
+				dev_name(&iter->dev), cxld_sel, selector);
+			return -ENXIO;
+		}
+
+		selector |= cxld_sel;
+
+		parent_distance *= cxl_rr_iter->nr_targets;
+		distance *= cxl_rr_iter->nr_targets;
+	}
+
+	distance *= iw;
+
+	/* Accumulated bits must fit within the region selector */
+	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
+	if ((cxlr_sel & selector) != selector) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			cxlr_sel, selector);
+		return -ENXIO;
+	}
+
+	/* Selector bits still available to this port. */
+	selector = cxlr_sel & ~selector;
+
 	if (cxl_rr->nr_targets_set) {
-		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
-
-		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
-		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
-
-		for (i = 0; i < cxl_rr->nr_targets_set; i++)
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
@@ -1484,87 +1548,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		goto add_target;
 	}
 
-	if (is_cxl_root(parent_port)) {
-		/*
-		 * Root decoder IG is always set to value in CFMWS which
-		 * may be different than this region's IG.  We can use the
-		 * region's IG here since interleave_granularity_store()
-		 * does not allow interleaved host-bridges with
-		 * root IG != region IG.
-		 */
-		parent_ig = p->interleave_granularity;
-		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
-		/*
-		 * For purposes of address bit routing, use power-of-2 math for
-		 * switch ports.
-		 */
-		if (!is_power_of_2(parent_iw))
-			parent_iw /= 3;
-	} else {
-		struct cxl_region_ref *parent_rr;
-		struct cxl_decoder *parent_cxld;
+	ig = p->interleave_granularity * parent_distance;
 
-		parent_rr = cxl_rr_load(parent_port, cxlr);
-		parent_cxld = parent_rr->decoder;
-		parent_ig = parent_cxld->interleave_granularity;
-		parent_iw = parent_cxld->interleave_ways;
-	}
-
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_ig);
-		return rc;
-	}
-
-	rc = ways_to_eiw(parent_iw, &peiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_iw);
-		return rc;
-	}
-
-	iw = cxl_rr->nr_targets;
 	rc = ways_to_eiw(iw, &eiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return rc;
-	}
-
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
+	if (!rc)
+		rc = granularity_to_eig(ig, &eig);
 	if (rc) {
 		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
+			"%s:%s: derived ig %d not a valid granularity (iw %d)\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), ig, iw);
 		return rc;
 	}
 
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
-	}
-
-	if (iw > 8 || iw > cxlsd->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s:%s: ways: %d overflows targets: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
-		return -ENXIO;
-	}
-
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
@@ -2067,6 +2064,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/* Keep this patch bisectable until position arithmetic is updated */
+	if (cxlrd->cxlsd.cxld.interleave_granularity >
+	    p->interleave_granularity)
+		return -ENXIO;
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

