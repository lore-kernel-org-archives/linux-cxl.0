Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002239;
	b=NqbZHcfTvk3wTD6jdGz7Ousn6Iq0x83bXNGUHfe6sPMwes1JlHc32uYkMnekDTNOcgEJ
	 ys6oyR1d8NlGxn/d1dbxJuz+MkmfJqfJacimxMpWwHW+p1tn79gJpCwJjYMzsfJtqxrM6
	 0cQ8mSo1nI9wy+gNmuugRBvdoVr8mL4lrWPfCVWyzPigpzX9513bBzeFXjvfjENnQRc+l
	 1Q8cP2vAuugNqMy7RMQ2ucLpdzVDgzRzRFceqZ7C4Zp5RB3QhvWqfjREE6Zqap9ti24Ww
	 bQFlOGBcoX+jmWM8QcXvTorJBbE785j6FH7fs5SYYTl6EOwk8NJCG5GZ0RKIMa0C21w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p6RZK5GmyhiBl25iNhrxT/sgAGZhxdM4DS9d9XrmaGo=;
	b=w35sCbSuIuhygAfSdv12jV7LJgIdJp4yOmGfnNRfKracLYXbTscPEOT07mEVDPHH6lvL
	 RuIts+kSLZ4NnzD/l0AqnLXmCXDzXVhDjZCbHGDfyr6M2nG/4kqH5/2R7X8KXbdyFZcbF
	 XlSNxKkL5GB9QnkGarrn8/jQZRvacekDaIKlBs14OIeRFB+psCdvb5WbRgqsWQRBZPO2U
	 ZuqgyXT41TdhP0iHKu8r/kaJzvqNUf/R2lhi+YPVF1AEQDCTWryGVIR4a1rI7egylFZaF
	 R5lRaG9wZsHldBVebMrFUtsauuPWx6mBdzWCjmg94QcSKHSd5yEZCjnQvGPfPn/29Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4UhYMZI;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9E606A32C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 21:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A9E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4UhYMZI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002239; x=1825538239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrtqvlIl1DMzxsTMmzhO8CzD226p+TqKA3ZURgWC/Gs=;
  b=k4UhYMZIuSfONow526VdPNvnp2sxEYkCC8UULNk6aUjZdRKehctzAlq1
   /62gS/ev8THA4Rxr5eS7e1esBG+qFsIs4pLF4cAVUxJCS95fFQxRwKjwM
   myKGmTofc9yUDgxQy0yIfymnz1j5ApB7xuzEWRlWhkcoMyWcolpb5DAU8
   fctY5QcRpCsXnuyRcKSOZCtbabyW2O4z755dvPwdJBBL7KzYG0DfDe6eN
   IS3NFG3qDHuDJNrCsnSFZ0fDT0EBVLuZ2luiCZLi543PNTYHlS1zI10nI
   WJhDXglFJu3eDnt048tGhu150Sk4TTsbCMHzawtCoem5caX3cxqAjwx5S
   A==;
X-CSE-ConnectionGUID: ZnzDFi6vT4+IY0o1JuVIJQ==
X-CSE-MsgGUID: 1M4v8mjbQc6axwqpWFIT0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2812915"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2812915"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:18 -0800
X-CSE-ConnectionGUID: f0gnEUr1Sqek4ZnMooJBew==
X-CSE-MsgGUID: MJ8i9RtFSnCiIKLFkWxTVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147235"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:17 -0800
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
Subject: [PATCH v7 2/5] cxl/region: Generalize endpoint position mapping
Date: Fri,  6 Nov 2026 13:57:09 -0800
Message-ID: <dc192d9d8b214a371a57cabc440a6b42572ca98f.1794000806.git.alison.schofield@intel.com>
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

Endpoint position calculation assumes an interleaving root has the same
granularity as the region. Auto region assembly multiplies by each parent
decoder's ways, and user region creation selects the root target with
'pos % ways'. A region granularity finer than the root breaks that
assumption, since decoder granularity then changes between levels of the
hierarchy.

Weight each decoder level by its granularity in region-granularity units:

    position += parent_pos * (parent_granularity / region_granularity)

and use the same relationship to select the root target for user regions.
Pass the region to cxl_calc_interleave_pos() for the granularity and HPA
range it needs.

For currently supported regions the result is unchanged, except for a
region wider than a same-granularity Mod3 root, which the root span check
added with finer-than-root support rejects.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 104 +++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d6a5dbe65d26..1594bec3930b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1867,9 +1867,20 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
+	int root_pos = pos;
 	int rc;
 
-	if (dport != cxlrd->cxlsd.target[pos % iw]) {
+	/*
+	 * Root target selection advances once per root-granularity chunk, so
+	 * convert the region position to root-granularity units. A
+	 * non-interleaving root does not contribute to the region interleave,
+	 * so its advertised granularity must not scale the position.
+	 */
+	if (iw > 1)
+		root_pos = pos * cxlr->params.interleave_granularity /
+			   cxld->interleave_granularity;
+
+	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
@@ -1970,11 +1981,22 @@ static int match_switch_decoder_by_range(struct device *dev,
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
-static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+/*
+ * Return the region position offset that @port's slot in its parent decoder
+ * target list contributes: the slot index weighted by the parent decoder's
+ * granularity in region-granularity units.
+ *
+ * Returns the non-negative offset on success, or a negative errno if the parent
+ * decoder or @port's slot in its target list cannot be found.
+ */
+static int cxl_port_interleave_pos(struct cxl_port *port,
+				   struct cxl_region *cxlr)
 {
+	int region_gran = cxlr->params.interleave_granularity;
+	struct range *range = &cxlr->hpa_range;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
+	int ways, gran, pos;
 	int rc = -ENXIO;
 
 	parent = parent_port_of(port);
@@ -1990,46 +2012,61 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 		return rc;
 	}
 	cxlsd = to_cxl_switch_decoder(dev);
-	*ways = cxlsd->cxld.interleave_ways;
+	ways = cxlsd->cxld.interleave_ways;
+	gran = cxlsd->cxld.interleave_granularity;
 
-	for (int i = 0; i < *ways; i++) {
+	for (int i = 0; i < ways; i++) {
 		if (cxlsd->target[i] == port->parent_dport) {
-			*pos = i;
+			pos = i;
 			rc = 0;
 			break;
 		}
 	}
-	if (rc)
+	if (rc) {
 		dev_err(port->uport_dev,
 			"failed to find %s:%s in target list of %s\n",
 			dev_name(&port->dev),
 			dev_name(port->parent_dport->dport_dev), dev_name(dev));
+		return rc;
+	}
 
-	return rc;
+	return pos * (gran / region_gran);
 }
 
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
- * @cxled: endpoint decoder member of given region
- * @hpa_range: translated HPA range of the endpoint
+ * @cxled: endpoint decoder member of @cxlr
+ * @cxlr: region providing the translated HPA range and interleave granularity
  *
- * The endpoint position is calculated by traversing the topology from
- * the endpoint to the root decoder and iteratively applying this
- * calculation:
+ * An endpoint's region position is the interleave position that address
+ * translation applies at the region granularity. cxl_calculate_hpa_offset()
+ * combines it with a DPA offset to form the HPA offset, and
+ * cxl_calculate_position() recovers it from that HPA offset. It is also the
+ * index of the endpoint's region-granularity chunk within one full pass of the
+ * region interleave.
  *
- *    position = position * parent_ways + parent_pos;
+ * Each decoder level above the endpoint contributes the index of the target
+ * it routes the endpoint through, scaled by the weight of that level: how many
+ * region positions pass between successive advances of its target index. The
+ * position is calculated by traversing the topology from the endpoint to the
+ * root decoder and accumulating those contributions:
  *
- * ...where @position is inferred from switch and root decoder target lists.
+ *    position += parent_pos * (parent_granularity / region_granularity);
+ *
+ * ...where @parent_pos is the index of the endpoint's path in a switch or root
+ * decoder target list. A level that selects a single target contributes
+ * nothing.
  *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
 static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
-				   struct range *hpa_range)
+				   struct cxl_region *cxlr)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	struct range *hpa_range = &cxlr->hpa_range;
+	int pos = 0;
 	int rc;
 
 	/*
@@ -2042,36 +2079,35 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
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
 	 */
 
-	/* Iterate from endpoint to root_port refining the position */
+	/* Iterate from endpoint to root_port accumulating the position */
 	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
-				       &parent_ways);
-		if (rc)
+		rc = cxl_port_interleave_pos(iter, cxlr);
+		if (rc < 0)
 			return rc;
 
-		pos = pos * parent_ways + parent_pos;
+		pos += rc;
 	}
 
 	dev_dbg(&cxlmd->dev,
@@ -2090,7 +2126,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
+		cxled->pos = cxl_calc_interleave_pos(cxled, cxlr);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that cxl_calc_interleave_pos() emits its
@@ -2275,7 +2311,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *target = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
+		test_pos = cxl_calc_interleave_pos(target, cxlr);
 		if (test_pos != target->pos)
 			dev_warn(&cxlr->dev,
 				 "%s: position mismatch: calculated:%d assigned:%d\n",
-- 
2.37.3

