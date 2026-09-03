Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088474CCDC5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477852; cv=none; b=sudhlAgB5yaaLOEqY0VJzLku/pI/WPPEHb5nMM7Oi4IEAVRReT37NAa5l8HVJy135TDFMHI1TP/fomOx21IXn7hzAUuzDLTizeJIK+xKdR+U41GSLkT2SXRc8/dI36qqabNinKqhQjoYOkjxZxzfvSzOxNgwTawfR7Yg1R5V9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477852; c=relaxed/simple;
	bh=7LROs9o7OGKNbYZVHJ4RKJuH7n+Xp4EGfaVsqGw1w7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlmiLRbKMRjjcC1XMCq82KdgW3dyPHJfmbv0z1zrP4Vrw7eYtns43fjwhQgx9+P31HhsFVBkowOU9Olf3mGd5x2cFNnYQZ7lZDhIUJlyWV818Ekuxo0g86vUyVIqypMgQ3+pM3ttrOyAiDfZ8eMBfRrA+CIG913ZmySXd/IpoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3y5alOQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3y5alOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477850; x=1820013850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7LROs9o7OGKNbYZVHJ4RKJuH7n+Xp4EGfaVsqGw1w7k=;
  b=h3y5alOQeLWRMtbBM+0NIQWk1DtHLvWOR8vYcJPPiGPtkH0jDf0uRiqT
   UZZm77Md16TaM4Eam3UuZq1h3v9GIGBSpSqFLXDNrBKsRCxLar5goZFa1
   CUz+7B7P4r+fe5jJkGqU6+eu5DxyXoMjnBx3e/jr15iPyPBF2eBlsS16x
   0aMS7azn6HvUmDum6IMfCqemANtFgVJR5+wr8Oyp/6i8jQv9vvX4vCboA
   I+ZwRwcSzfV0G0a37cwiHUfHu80lL5sInnYsEC+ClUrO8Kha7isXSjYie
   d5HMjQxmB0JpiEDSJKO+ia05YSNE0uU3ITQ5ZLyB+ZU+deb8sv+eiS0XZ
   Q==;
X-CSE-ConnectionGUID: bH3sgAbdQ2OtqzwZOOi1Uw==
X-CSE-MsgGUID: ExOSBwFoRXGaP1dAFs9Z3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847678"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847678"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:09 -0700
X-CSE-ConnectionGUID: V254SSa2Rsiu6N5gLLv3tg==
X-CSE-MsgGUID: gRvcZBEmS3i7hCxSZ9Ahug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129486"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:08 -0700
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
Subject: [PATCH v5 3/7] cxl/region: Generalize endpoint position mapping
Date: Thu,  3 Sep 2026 16:23:45 -0700
Message-ID: <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
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

Endpoint position calculation currently relies on the requirement that an
interleaving root have the same granularity as the region. Auto region
creation builds the position by multiplying by the parent decoders' ways,
while user region creation selects the root target with 'pos % ways'. Those
calculations are sufficient under the current granularity restriction.

In order to support mixed-granularity regions, that granularity restriction
will need to be removed so decoder granularity can change between levels of
the interleave hierarchy. The position calculation needs to account for
those changes to produce the correct endpoint ordering.

Change the position calculation so each decoder's contribution is weighted
by its granularity relative to the region granularity:

    position += target_pos *
                (decoder_granularity / region_granularity)

Use the same relationship to select the root target during user region
creation.

Weight each level by the region granularity, passed in by the caller,
rather than by the granularity programmed in the endpoint decoder. The two
are equal for most configurations, but not when Normalized Addressing
leaves the endpoint decoder programmed passthrough while the region
interleaves.

For currently supported regions, the new weighted calculation reduces to
the existing position calculation and produces identical endpoint
positions. The exception is a region wider than a same-granularity Mod3
root, where address bit routing programs the level below the root at the
region granularity, so the ratio derives a weight of one rather than three.
A later patch in this series rejects that layout.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 69 ++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6a698f36aa6d..506b1cba1a92 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1806,9 +1806,15 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
+	int root_pos = pos;
 	int rc;
 
-	if (dport != cxlrd->cxlsd.target[pos % iw]) {
+	/* Root target selection advances at root-granularity intervals */
+	if (iw > 1)
+		root_pos = pos * cxlr->params.interleave_granularity /
+			   cxld->interleave_granularity;
+
+	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
@@ -1909,12 +1915,13 @@ static int match_switch_decoder_by_range(struct device *dev,
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
-static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+static int find_pos_and_gran(struct cxl_port *port, struct range *range,
+			     int *pos, int *gran)
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
 	int rc = -ENXIO;
+	int ways;
 
 	parent = parent_port_of(port);
 	if (!parent)
@@ -1929,9 +1936,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 		return rc;
 	}
 	cxlsd = to_cxl_switch_decoder(dev);
-	*ways = cxlsd->cxld.interleave_ways;
+	ways = cxlsd->cxld.interleave_ways;
+	*gran = cxlsd->cxld.interleave_granularity;
 
-	for (int i = 0; i < *ways; i++) {
+	for (int i = 0; i < ways; i++) {
 		if (cxlsd->target[i] == port->parent_dport) {
 			*pos = i;
 			rc = 0;
@@ -1951,24 +1959,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
  * @hpa_range: translated HPA range of the endpoint
+ * @region_gran: interleave granularity of the region
  *
- * The endpoint position is calculated by traversing the topology from
- * the endpoint to the root decoder and iteratively applying this
- * calculation:
+ * A region position is the index of a region-granularity chunk within one full
+ * pass of the region interleave. The position is calculated by traversing the
+ * topology from the endpoint to the root decoder and accumulating the
+ * contribution of each decoder level:
  *
- *    position = position * parent_ways + parent_pos;
+ *    position += parent_pos * (parent_granularity / region_gran);
  *
- * ...where @position is inferred from switch and root decoder target lists.
+ * ...where @parent_pos is inferred from switch and root decoder target lists.
+ * The multiplier is the weight of that level: how many region positions pass
+ * between successive advances of the level's target index. A level that selects
+ * a single target contributes nothing.
  *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
 static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
-				   struct range *hpa_range)
+				   struct range *hpa_range, int region_gran)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int parent_gran = 0, parent_pos = 0, pos = 0;
 	int rc;
 
 	/*
@@ -1981,20 +1994,20 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 	 *        |    |           |    |
 	 *       mem0 mem1        mem2 mem3
 	 *
-	 * In the example the calculator will iterate twice. The first iteration
-	 * uses the mem position in the host-bridge and the ways of the host-
-	 * bridge to generate the first, or local, position. The second
-	 * iteration uses the host-bridge position in the root_port and the ways
-	 * of the root_port to refine the position.
+	 * The region and the root decoder interleave at the region
+	 * granularity, so each host-bridge decoder interleaves at twice that.
+	 * The host-bridge decoders advance one target every two region
+	 * positions, weight 2, and the root decoder advances one target every
+	 * region position, weight 1.
 	 *
 	 * A trace of the calculation per endpoint looks like this:
-	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
-	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
+	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
+	 *       pos += 0 * 1             pos += 1 * 1
 	 *       pos: 0                   pos: 1
 	 *
-	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
-	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
-	 *       pos: 2                   pos = 3
+	 * mem1: pos += 1 * 2       mem3: pos += 1 * 2
+	 *       pos += 0 * 1             pos += 1 * 1
+	 *       pos: 2                   pos: 3
 	 *
 	 * Note that while this example is simple, the method applies to more
 	 * complex topologies, including those with switches.
@@ -2005,12 +2018,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
-				       &parent_ways);
+		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
+				       &parent_gran);
 		if (rc)
 			return rc;
 
-		pos = pos * parent_ways + parent_pos;
+		pos += parent_pos * (parent_gran / region_gran);
 	}
 
 	dev_dbg(&cxlmd->dev,
@@ -2029,7 +2042,8 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
+						     p->interleave_granularity);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that cxl_calc_interleave_pos() emits its
@@ -2214,7 +2228,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *target = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
+		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range,
+						   p->interleave_granularity);
 		if (test_pos != target->pos)
 			dev_warn(&cxlr->dev,
 				 "%s: position mismatch: calculated:%d assigned:%d\n",
-- 
2.37.3

