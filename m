Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B833AB26A
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450063; cv=none; b=HcQtwp1SKJxZjIOKymr22Km6auy3Er9mJ8GyhgrbVD5QjwbY6f7Qbo2zBolsflCgRRSrJattkaMf0/yDHe725VXe7AgAhcUL517fLqwa6Ky86tZ31PRjF6SHMEUkjZ4o+0qUq8602rc6O7zlYSsZey2QnVbUMfPODRDZt9Gu0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450063; c=relaxed/simple;
	bh=F3bl87RoQiaS73IjXzugU52nA28elaJZKwBRXA4tnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfD/JCXsutWzoi70UkPOc0IfGttuFbAsy6/iGEzD8sz0ty5+PWDjEsZXDBVBL1utuuEtzPhpdAko5WT2t2469PR0FKr5XjWz5kEukj2nsnPTVhsw7BvAZjFCyXJrZldYcxbzBw8ruv5mq/LfmoDABzJDUV0vmXwdmCcyY5qh7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8o7Y2zx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8o7Y2zx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450062; x=1816986062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3bl87RoQiaS73IjXzugU52nA28elaJZKwBRXA4tnPw=;
  b=l8o7Y2zxuboDOTbppj1xcn+/FySXLoD9mKnWImrHyIgJADcWbpAn+UQG
   aJaiow6fuNs02reptmc0yWOn3lx4WNbFWTNLDYpl/+njcGNWR0Yk3kvWn
   HkCPJyNddaykEahaA04xrJeobhozr0AdPu7TEyXTv1cgHiVp9Mc3J9WFP
   eWUvZDH2NIfnLDwcoV9liSR89FUs+fLFxLBscsmchHMfrcWhE9TuJBTxB
   h6vf+5JDC8tpqOsiBKhWTzFJf36F9+SsB9TAq6WXukRWM7bgSdny2JsdI
   MPz6IvN9tjA2ldb+kaD+waW/40++w5Xw1/I3BL/nimF7EE8B7Jh6CFhBi
   g==;
X-CSE-ConnectionGUID: F3xOcJPfSjOVXqd3hrbnfA==
X-CSE-MsgGUID: eZdv0ZhNS2CFGS7TtS/reQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665379"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665379"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:49 -0700
X-CSE-ConnectionGUID: DYiQYEvzTpqY9K0Rg2ON6w==
X-CSE-MsgGUID: TOE5sPhkSA6/GlD8IgzoPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482250"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:44 -0700
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
Subject: [PATCH v3 4/9] cxl/region: Account for mixed-granularity in position calculations
Date: Thu, 30 Jul 2026 15:20:24 -0700
Message-ID: <05d8d1f002757c53bdb61175e937e42991c3f465.1785444498.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Endpoint positions identify the order in which a region routes
addresses to its endpoint decoders. The existing calculation assumes
the root target changes at every region position. In a
mixed-granularity region, one root target instead covers multiple
positions before the next root target is selected.

Add root_positions_per_target() to express that ratio and use it when
validating root targets, checking peer distance, and calculating
endpoint positions. Keep the existing position recurrence for
same-granularity regions and use each decoder level's granularity when
calculating positions for mixed-granularity regions.

Remove the temporary mixed-granularity reject now that endpoint
positions match the selector layout.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 109 +++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 871dedd37cc8..938781c9bc5c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1569,6 +1569,49 @@ static inline bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
 	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
 }
 
+/**
+ * root_positions_per_target() - Count positions covered by a root target
+ * @cxlr: region
+ *
+ * In a mixed-granularity region, a root target covers
+ * ``root_granularity / region_granularity`` consecutive region positions.
+ * A same-granularity root covers one position.
+ *
+ * Return: the number of region positions covered by one root target.
+ */
+static inline int root_positions_per_target(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+
+	if (!cxl_region_is_mixed_gran(cxlr))
+		return 1;
+
+	return cxlrd->cxlsd.cxld.interleave_granularity /
+	       cxlr->params.interleave_granularity;
+}
+
+/**
+ * peer_pos_distance() - Calculate the distance between same-dport endpoints
+ * @cxlr: region under construction
+ * @fanout: product of the ancestor switch ways
+ * @iw: port decoder interleave ways
+ *
+ * Mixed-granularity routing groups the endpoints below a dport into
+ * consecutive region positions. Same-granularity routing spaces them by
+ * the root ways and the switch fan-out above the port.
+ *
+ * Return: the distance in region positions.
+ */
+static int peer_pos_distance(struct cxl_region *cxlr, int fanout, int iw)
+{
+	int root_iw = cxlr->cxlrd->cxlsd.cxld.interleave_ways;
+
+	if (cxl_region_is_mixed_gran(cxlr))
+		return 1;
+
+	return root_iw * fanout * iw;
+}
+
 /**
  * derive_port_granularity() - Calculate the granularity for a port decoder
  * @port: port being configured
@@ -1645,7 +1688,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1689,7 +1731,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
-						     root_iw * fanout * iw);
+						     peer_pos_distance(cxlr, fanout, iw));
 				if (rc)
 					return rc;
 				goto out_target_set;
@@ -1947,14 +1989,16 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int root_pos_per_target = root_positions_per_target(cxlr);
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (dport != cxlrd->cxlsd.target[pos % iw]) {
-		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
+	if (dport != cxlrd->cxlsd.target[pos / root_pos_per_target % iw]) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s invalid target position for %s (positions per target %d)\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			dev_name(&cxlrd->cxlsd.cxld.dev));
+			dev_name(&cxlrd->cxlsd.cxld.dev), root_pos_per_target);
 		return -ENXIO;
 	}
 
@@ -2053,7 +2097,7 @@ static int match_switch_decoder_by_range(struct device *dev,
 }
 
 static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+			     int *pos, int *ways, int *gran)
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
@@ -2074,6 +2118,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	cxlsd = to_cxl_switch_decoder(dev);
 	*ways = cxlsd->cxld.interleave_ways;
+	*gran = cxlsd->cxld.interleave_granularity;
 
 	for (int i = 0; i < *ways; i++) {
 		if (cxlsd->target[i] == port->parent_dport) {
@@ -2098,6 +2143,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
  * @hpa_range: translated HPA range of the endpoint
+ * @root_pos_per_target: region positions under one root target
+ * @region_gran: region interleave granularity
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -2107,15 +2154,25 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  *
  * ...where @position is inferred from switch and root decoder target lists.
  *
+ * For a mixed-granularity region, each interleaving level contributes its
+ * target index at the number of region positions covered by one of its
+ * targets:
+ *
+ *    position += positions_per_target * target_index
+ *
+ * Switch positions-per-target is ``parent_gran / region_gran``. The root
+ * uses @root_pos_per_target.
+ *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
 static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
-				   struct range *hpa_range)
+				   struct range *hpa_range,
+				   int root_pos_per_target, int region_gran)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int parent_ways = 0, parent_pos = 0, parent_gran = 0, pos = 0;
 	int rc;
 
 	/*
@@ -2153,11 +2210,24 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 			break;
 
 		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
-				       &parent_ways);
+				       &parent_ways, &parent_gran);
 		if (rc)
 			return rc;
 
-		pos = pos * parent_ways + parent_pos;
+		if (root_pos_per_target > 1 &&
+		    is_cxl_root(parent_port_of(iter))) {
+			pos = pos + root_pos_per_target * parent_pos;
+			break;
+		}
+
+		/*
+		 * Passthrough levels do not select a target and therefore do
+		 * not contribute to the region position.
+		 */
+		if (root_pos_per_target > 1)
+			pos = pos + (parent_gran / region_gran) * parent_pos;
+		else
+			pos = pos * parent_ways + parent_pos;
 	}
 
 	dev_dbg(&cxlmd->dev,
@@ -2171,12 +2241,15 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 static int cxl_region_sort_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
+	int root_pos_per_target = root_positions_per_target(cxlr);
 	int i, rc = 0;
 
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
+						     root_pos_per_target,
+						     p->interleave_granularity);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that cxl_calc_interleave_pos() emits its
@@ -2204,6 +2277,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_port *ep_port, *root_port;
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
+	int root_pos_per_target;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
 				  p->interleave_granularity);
@@ -2236,14 +2310,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	/*
-	 * Mixed-granularity position calculation is added by the next patch.
-	 * Reject it until then so this intermediate state remains bisectable.
-	 */
-	if (cxlrd->cxlsd.cxld.interleave_granularity >
-	    p->interleave_granularity)
-		return -ENXIO;
-
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
@@ -2365,11 +2431,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	 * A fail message here means that this interleave config
 	 * will fail when presented as CXL_REGION_F_AUTO.
 	 */
+	root_pos_per_target = root_positions_per_target(cxlr);
 	for (int i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *target = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
+		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range,
+						   root_pos_per_target,
+						   p->interleave_granularity);
 		dev_dbg(&target->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
 			(test_pos == target->pos) ? "success" : "fail",
-- 
2.37.3

