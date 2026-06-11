Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6134252C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200061; cv=none; b=ZwBXP0MYz6IjDkaYAhnhYDEUQ+TXQJkzFZbMdSMhclZOJtMoiBTJMrQOQD9rPgbnjfJaQN/nX8ttSzu/cNifQ33ZiYmW7m7KizzLTwMg5SXT8OZ0wRGN0N89OlR2h0cudU1Mcvpg5mTYhAip2K6A8e8quKgWphJnh1PSvG+/W8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200061; c=relaxed/simple;
	bh=nZ3fH5ZF5FgRRWZgQqn477H3d9GEL40jPYb8YgTcqB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An37PHuqvI32bvJk1dN/cVEzj9fCovC9QvzucvcOg2oAgUMd01GA/z95m1XZr8wVMYduUbOglODKE64lmoic7EDcH4nLhxf9SV8O2ouXyn7aTFG5sPiv++ss4ch8+7YSVp+1hlJGuPzmjb5O0eHQiGNDLTX1UkjNsVxWUwIevdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljAlzGkQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljAlzGkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200060; x=1812736060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZ3fH5ZF5FgRRWZgQqn477H3d9GEL40jPYb8YgTcqB0=;
  b=ljAlzGkQgKCJSr1xaVnNMRH4ioU89IGWshqeevyy4mtK9oE9FQNWSz8z
   P9HUQi41vgTEB8VoZDhKHVS8TkNqYNJlmCobMk2w0nOYEBl7Eix4kHFng
   YLG+YBu5tlNoJQWWUCZnGvGZ+2r78yVCgDrCBfTgGALQx4jSs4LDxz+4o
   TbK22hDWt2QYCVYvFSNWWeyjJDV+TqbilVzFzZztiejDMw6S+lIPF6o0Q
   9ar/duOGRu5mGTCHZyWYRpjZQDz78+03u2PztrTtFzykfQE2Wl/hIfN9Y
   g/tqCHuCD7W8u83hH1bPxGNFLMPMIpld83YR0JNJICZ2WavVUK7JmBC2C
   A==;
X-CSE-ConnectionGUID: uCkM2svuRpyxcSnUIqGOOA==
X-CSE-MsgGUID: gs9emOPOSe+I5q0wQAhRxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99598806"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99598806"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:40 -0700
X-CSE-ConnectionGUID: iuvOWpmcQiCnvUS/a6j1Bg==
X-CSE-MsgGUID: Z1eh0mQvS8qL4/TLwgOt9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246441007"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:39 -0700
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
Subject: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in position calculations
Date: Thu, 11 Jun 2026 10:47:27 -0700
Message-ID: <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
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

Mixed-granularity regions place the root decoder at outer HPA bits.
A root target then owns root_gran / region_gran inner positions
before the root advances to the next target. That ratio becomes the
root target stride in region positions.

Account for that stride in endpoint placement, position calculation,
and peer-distance checks.

Remove the temporary mixed-granularity attach reject now that position
arithmetic matches the selector layout.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d5d19ed62171..9fff538a9ce1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1444,12 +1444,34 @@ static inline u64 get_selector(int ways, int gran)
 	return (u64)(ways - 1) * gran;
 }
 
+/**
+ * root_pos_stride() - Return root target stride in region positions
+ * @cxlr: region
+ *
+ * Return: root_gran / region_gran when the root granularity is larger
+ * than the region granularity, or 1 otherwise.
+ */
+static inline int root_pos_stride(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
+	int region_gran = cxlr->params.interleave_granularity;
+
+	if (cxlrd->cxlsd.cxld.interleave_ways <= 1)
+		return 1;
+
+	if (region_gran == 0 || root_gran <= region_gran)
+		return 1;
+
+	return root_gran / region_gran;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int distance, parent_distance;
+	int sel_distance, pos_distance, stride;
 	int ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1490,10 +1512,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				cxlrd->cxlsd.cxld.interleave_granularity);
 
 	/* Track distances used in passthrough granularity and peer checks */
-	parent_distance = cxlrd->cxlsd.cxld.interleave_ways;
-	if (!is_power_of_2(parent_distance))
-		parent_distance /= 3;
-	distance = cxlrd->cxlsd.cxld.interleave_ways;
+	stride = root_pos_stride(cxlr);
+	sel_distance = cxlrd->cxlsd.cxld.interleave_ways;
+	if (!is_power_of_2(sel_distance))
+		sel_distance /= 3;
+	pos_distance = stride > 1 ? 1 : cxlrd->cxlsd.cxld.interleave_ways;
 
 	for (iter = parent_port; !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent)) {
@@ -1517,11 +1540,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 		selector |= cxld_sel;
 
-		parent_distance *= cxl_rr_iter->nr_targets;
-		distance *= cxl_rr_iter->nr_targets;
+		sel_distance *= cxl_rr_iter->nr_targets;
+		pos_distance *= cxl_rr_iter->nr_targets;
 	}
 
-	distance *= iw;
+	pos_distance *= iw;
 
 	/* Accumulated bits must fit within the region selector */
 	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
@@ -1540,7 +1563,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
-						     distance);
+						     pos_distance);
 				if (rc)
 					return rc;
 				goto out_target_set;
@@ -1556,7 +1579,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		ig = cxld->interleave_granularity;
 	} else if (iw == 1) {
-		ig = p->interleave_granularity * parent_distance;
+		ig = p->interleave_granularity * sel_distance;
 	} else if (selector) {
 		ig = 1ULL << __ffs64(selector);
 	} else {
@@ -1813,14 +1836,17 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int stride = root_pos_stride(cxlr);
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (dport != cxlrd->cxlsd.target[pos % iw]) {
-		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
+	/* Mixed-granularity roots advance every stride positions */
+	if (dport != cxlrd->cxlsd.target[pos / stride % iw]) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s invalid target position for %s (stride %d, check root/region gran ratio)\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			dev_name(&cxlrd->cxlsd.cxld.dev));
+			dev_name(&cxlrd->cxlsd.cxld.dev), stride);
 		return -ENXIO;
 	}
 
@@ -1951,6 +1977,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
  * @hpa_range: translated HPA range of the endpoint
+ * @stride: root target stride in region positions
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1960,11 +1987,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  *
  * ...where @position is inferred from switch and root decoder target lists.
  *
+ * For mixed-granularity regions the root contributes outer position
+ * bits, so the root step is:
+ *
+ *    position = position + stride * parent_pos
+ *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
 static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
-				   struct range *hpa_range)
+				   struct range *hpa_range, int stride)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -2010,6 +2042,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 		if (rc)
 			return rc;
 
+		if (stride > 1 && is_cxl_root(parent_port_of(iter))) {
+			pos = pos + stride * parent_pos;
+			break;
+		}
+
 		pos = pos * parent_ways + parent_pos;
 	}
 
@@ -2024,12 +2061,14 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 static int cxl_region_sort_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
+	int stride = root_pos_stride(cxlr);
 	int i, rc = 0;
 
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
+						     stride);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2056,6 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_port *ep_port, *root_port;
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
+	int stride;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
 				  p->interleave_granularity);
@@ -2088,11 +2128,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	/* Keep this patch bisectable until position arithmetic is updated */
-	if (cxlrd->cxlsd.cxld.interleave_granularity >
-	    p->interleave_granularity)
-		return -ENXIO;
-
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
@@ -2214,11 +2249,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	 * A fail message here means that this interleave config
 	 * will fail when presented as CXL_REGION_F_AUTO.
 	 */
+	stride = root_pos_stride(cxlr);
 	for (int i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
+						   stride);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.37.3

