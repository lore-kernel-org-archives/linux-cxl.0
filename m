Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5CF314B73
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200059; cv=none; b=CxtKM4aaFVLUN6+WyB0p+G2RMMmFMr3zk49HwNkZLi7xq43sy4lNdkkDK0D2zthahuDcXAmP4J4+akNdIL6r+akycg/pW8uU0VaPCQ4SzvM/mgEZKZ1yQ/ieJ0dDRtzTl0O640qmx1tCLCkfv53RB63LoXE3RB/vrCijwx3920o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200059; c=relaxed/simple;
	bh=wci69hWKEHh2XmydlourPMZnAs3HN6k/sKDD+HT3uUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMNtL4zR1EVGMtJocNJArNpRFTfKM4eG6Mafjx7edej1PlyiqkLvavHK11v9wpCo9wMoLEHJvmm+8Oy7a5LfrFuzpZ+MNvMt42cpJD96OAOl6k0F2IsNuDMHbeyGQTJwwGDg4yrk5n9V+9QDltJ0jzg6cBhGzp/IwUorJcNQtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZg0kJZl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZg0kJZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200058; x=1812736058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wci69hWKEHh2XmydlourPMZnAs3HN6k/sKDD+HT3uUA=;
  b=hZg0kJZlQEG/mad6c18B0NJHRN1+iE1wtaD+mPRJoEzJGY+8LNC2jtI1
   yIKcH5zlbdQJ1GDm8YCMI8qSgkt/ag59lx1pnd+AAG15WD+vDBX292Wzs
   AXv+iVYMjjhJMEj5RnzLPztOxuJUqPPNamqNi47qe6cllIAyLJYosAkn4
   ZTDEaVejd8rIYVrHDwusT+QrrVsT3l7fAc7nGgD5zz22/rrWhiF0HChi2
   D2yiFvYSkwaPMPPzc8Km/FY/D6gFb4wRVQX16HJtJEFnufgngiJiWXvtd
   STSimBGsT9PLiX9Zq+FM2jtU57bwpVVtzUR6bJuefmSlj2knhHJq5mSC6
   w==;
X-CSE-ConnectionGUID: tUdz7kozSk2vxDx6h0F/Mg==
X-CSE-MsgGUID: oBFgik1JRymSvU8ecOioiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99598795"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99598795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:37 -0700
X-CSE-ConnectionGUID: cUx3cmD0SQSbG476cj2seA==
X-CSE-MsgGUID: I/CgYV5MQsiLuUdYcueUxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246440997"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:36 -0700
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
Subject: [PATCH v2 1/6] cxl/region: Validate interleave selector bits
Date: Thu, 11 Jun 2026 10:47:25 -0700
Message-ID: <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1781199122.git.alison.schofield@intel.com>
References: <cover.1781199122.git.alison.schofield@intel.com>
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

Block mixed-granularity attachments until position arithmetic is
updated by a later patch.

Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 192 +++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..c859c8661281 100644
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
+static inline u64 get_selector(int ways, int gran)
+{
+	if (!is_power_of_2(ways))
+		ways /= 3;
+
+	if (!is_power_of_2(ways) || !is_power_of_2(gran))
+		return 0;
+
+	return (u64)(ways - 1) * gran;
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
@@ -1452,28 +1475,66 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1484,84 +1545,18 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
 		    (iw > 1 && cxld->interleave_granularity != ig) ||
@@ -2067,6 +2062,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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

