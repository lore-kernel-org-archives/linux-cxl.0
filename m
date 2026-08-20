Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A531A9FBC
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268693; cv=none; b=bBM7Khsx6V3zkvkXwcX7vGKxyJtYqy7/N9Ug/pHfq5AQ578sPtS1Wc5hC3V+z27yUGYFwbW/oij/m0YH4LF7Ze/mj7x07Z3TgkZPR5h+tkQvCiAj1Ow8ccvxgY8v1HYhLDipSZoTSyzlpSbCex+DyRO3s0L5jkykobn4S0zVsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268693; c=relaxed/simple;
	bh=dbE+IDIiSyirS8u2nbmgOxbxm6MTzEekNaRxnGLO+3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfqk1W0o21+mnKhXhT9elBAuQxLYo9kTjkczBub81xLhDMqs3iInJcVaOpIuJWpjZ+9meEr1E2TuzKEN66G4xnJZJgpcdSzin9VsxYWESpgYjjbSFXhqFfYV1vZwP4MgLUoxWgbqh6I7ryLVO8GUKne9V+4hieGha7/v1x3FglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRRqnGkR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRRqnGkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268691; x=1818804691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbE+IDIiSyirS8u2nbmgOxbxm6MTzEekNaRxnGLO+3Y=;
  b=aRRqnGkRO62M+w7aoAg2EIlYa5ZY+zRPKptvgDNHcate8WTWCbWYsXHI
   /dEgssIS/mn2hEEVPte0oschCvFNvdVImq2U9n3P+JeJv8eKFzmg0UFFy
   MphcLyRVnKe1aaWu1n+TGjClYz9XJqFoz4aDU1IS/n9c4aQOG3aYb3d7k
   TK92n0A5zjuxZBHxO83wfatBuFAASj0nmhgjiFWUk3ZuRdjGg8km81NuL
   eIqjh6UoVRfMBf5i3LrCFVOda8KbI2ERVWuIFST8Z7givzP0J1S9/xrMZ
   2nvFf14zHpgtHxhSn3jMcoM4jsIKb7M32QlNcErfdC5+lVrbq9utSI2kY
   A==;
X-CSE-ConnectionGUID: uEcJjQ5LTOKNT0sCMXhN7Q==
X-CSE-MsgGUID: Oqs716OlQxiJRqctv6riJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483420"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:31 -0700
X-CSE-ConnectionGUID: l0l04yJvTVutd4Rdd/rCzA==
X-CSE-MsgGUID: 6LEKwwxoRuqB/89CnGUMrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261905993"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:30 -0700
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
Subject: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Date: Thu, 20 Aug 2026 16:31:20 -0700
Message-ID: <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
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

Endpoint position calculation currently relies on the requirement that
an interleaving root have the same granularity as the region. Auto
region creation builds the position by multiplying by each parent
decoder's ways, while user region creation selects the root target
with 'pos % ways'. Those calculations are sufficient under the current
granularity restriction.

In order to support mixed-granularity regions, that granularity
restriction will need to be removed so decoder granularity can change
between levels of the interleave hierarchy. The position calculation
needs to account for those changes to produce the correct endpoint
ordering.

Change the position calculation so each decoder's contribution is
weighted by its granularity relative to the region granularity:

    position += target_pos *
                (decoder_granularity / region_granularity)

Use the same relationship to select the root target during user region
creation.

For currently supported regions, the new weighted calculation reduces
to the existing position calculation and produces identical endpoint
positions.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 60 ++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3b640c9ba5a0..4f367feaf6c8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1805,9 +1805,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
-	int rc;
+	int root_pos = pos, rc;
 
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
@@ -1908,13 +1913,13 @@ static int match_switch_decoder_by_range(struct device *dev,
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
-static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+static int find_pos_and_gran(struct cxl_port *port, struct range *range,
+			     int *pos, int *gran)
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
 	struct device *dev;
-	int rc = -ENXIO;
+	int ways, rc = -ENXIO;
 
 	parent = parent_port_of(port);
 	if (!parent)
@@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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
@@ -1955,13 +1961,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * @cxled: endpoint decoder member of given region
  * @hpa_range: translated HPA range of the endpoint
  *
- * The endpoint position is calculated by traversing the topology from
- * the endpoint to the root decoder and iteratively applying this
- * calculation:
+ * The endpoint position is calculated by traversing the topology from the
+ * endpoint to the root decoder and accumulating the contribution of each
+ * decoder level:
  *
- *    position = position * parent_ways + parent_pos;
+ *    position += parent_pos * (parent_granularity / region_granularity);
  *
- * ...where @position is inferred from switch and root decoder target lists.
+ * ...where @parent_pos is inferred from switch and root decoder target
+ * lists, and the multiplier is the number of region positions that the
+ * level's granularity spans. A level that selects a single target
+ * contributes nothing.
  *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
@@ -1971,7 +1980,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int gran = cxled->cxld.interleave_granularity;
+	int parent_gran = 0, parent_pos = 0, pos = 0;
 	int rc;
 
 	/*
@@ -1984,20 +1994,18 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 	 *        |    |           |    |
 	 *       mem0 mem1        mem2 mem3
 	 *
-	 * In the example the calculator will iterate twice. The first iteration
-	 * uses the mem position in the host-bridge and the ways of the host-
-	 * bridge to generate the first, or local, position. The second
-	 * iteration uses the host-bridge position in the root_port and the ways
-	 * of the root_port to refine the position.
+	 * The region and the root decoder interleave at granularity g, so
+	 * each host-bridge decoder interleaves at 2g and spans two region
+	 * positions while the root decoder spans one.
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
@@ -2008,12 +2016,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
-				       &parent_ways);
+		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
+				       &parent_gran);
 		if (rc)
 			return rc;
 
-		pos = pos * parent_ways + parent_pos;
+		pos += parent_pos * (parent_gran / gran);
 	}
 
 	dev_dbg(&cxlmd->dev,
-- 
2.37.3

