Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73B17B418
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303365; cv=none; b=PpHoJC/QW5VcqdXjeb3WtXKaMCcDSiiCplmvlfRaGA3bfb5ClAEG5OMoW7c0TvBpiqDXT6htY0OucOMLhLJ4VdQX+fR+BFU1GPRffJtzV6DnB/PYhapyvJELgw+vpFlNlK8+v76J+sZZhWnqh1o6hxBWnO7pBQfO3isMud/ib5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303365; c=relaxed/simple;
	bh=nG4+q8N7+lrnS6fuL0Wn6pOnBRVadjiXIK+7gWNY8cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR85fwUAfVumUc05GClVhBLaPaBlWi8uMc5SmRODLz5WmI+1Fsa3VW+jtobenKgJLRv406P4J4avyGpdxPgct9qzWjRerSK1GAAuvD/FyFH+RzWdXpEgj1DL8gO/wRbbtxAfFDX06tg+sNeJOx691bPw7cPbO9hSLPnkxrufogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXPIwm2E; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXPIwm2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741303362; x=1772839362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nG4+q8N7+lrnS6fuL0Wn6pOnBRVadjiXIK+7gWNY8cQ=;
  b=dXPIwm2EPUg7N4ptLUgOsuLW+kwJzORoZET8vlvgHMXdHQT79cSKzE6S
   NVZAia1T6CybNGJGQyIrvMqlrNAKtqpq8dT0RY+xf8Nfqgk1vgHWTPowt
   +ZbsPF9lCj7tm1tobVTs6qaMq35vVZHo+izJJg7sZS9wVZnHPhgFH9yjt
   eHBC9SGLqNCgOlgGH/SOuUAlyN9QdI4QFyhPo6nxiwRBXfAePm6yuUrz3
   xbqFVuv5PJ/q1A1h9ExYT65ctcxeq2/5orMZFUU4uWaZK9kyBubuq23wZ
   Wo6E36+IBNzhpiNn7YjBhhXxY93kozzUcFyrU0JM6Xr5dhrtdhnvP0cqc
   Q==;
X-CSE-ConnectionGUID: vWONz2NLTqCEu02R/SWj2g==
X-CSE-MsgGUID: fnbzUA77R16A+SU7Nh6UXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52547039"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52547039"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 15:22:41 -0800
X-CSE-ConnectionGUID: te1vC3DeTX+wA/GDfU7wfg==
X-CSE-MsgGUID: tcIuVf42SymWbjn2+p35RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119857180"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.63])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 15:22:41 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB interleaves
Date: Thu,  6 Mar 2025 15:22:37 -0800
Message-ID: <20250306232239.2609017-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL driver requires the granularity of a region and its root
decoder to be the same. This is particularly restrictive for 3-way
host bridge interleaves where the only spec defined interleave
configurations for creating 6-way and 12-way regions on a 3-way HB
interleave require mixed granularities.

CXL 3.2 Specification 9.13.1.1:
Legal Interleaving Configurations: 12-way, 6-way, and 3-way

Adding support for these new interleaves touches these areas:

1) User created regions employing "cxl create-region" fail when the
CXL CLI tool gets a mixed granularity request. That is addressed in
a patch to the ndctl tool.

2) User created regions employing sysfs directly fail at the sysfs
store of the non-matching region granularity. That restriction is
lifted here. Note that the driver immediately allows any reasonable
3-way HB granularity, but the region config may still fail later
if the ways/gran between region and root decoder are incompatible.

3) Auto created regions, in which the drivers role is to reflect
the BIOS created region and provide RAS support, basically sneak on
by. The driver ignores the root decoders granularity and assumes it
is the same as the regions. The impact being that endpoint devices
appear out of order and DPA to HPA address translations that depend
on that order are invalid. Here the driver stops making that same
granularity assumption and checks for an allowable granularity.

A new helper, interleave_granularity_allow(), is used in both the
user and auto creation path to allow the newly supported configs.

Another new helper, gran_multiple(), is used in sorting, target
list searching, and distance calculations, supporting the new
root granularity to region granularity multiples.

And, as noted in 2), there's an added check to see if the
selected sysfs ways/gran make sense when considered together.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Allow exactly 2*ig or 4*ig in interleave_granularity_allow()(DaveJ)
- Remove needless !root_decoder_gran check in gran_multiple()(Ming)
- Update spec references to 3.2 (DaveJ)
- Commit log grammar cleanup (DaveJ)
- Describe param 'multiple' in cxl_calc_interleave_pos() (lkp)


 drivers/cxl/core/region.c | 104 +++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..cc2687407a3e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -532,6 +532,31 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
 }
 
+static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
+{
+	/*
+	 * When the host-bridge is interleaved, disallow region granularity
+	 * != root granularity with the exception of 3-way HB interleaves.
+	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
+	 * configured when host-bridge interleave is greater that the
+	 * region interleave. (CXL 3.2 Specification 9.13.1.1)
+	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
+	 *	 4+4+4 interleave where HB gran is 4 * region granularity
+	 *
+	 * Regions with a granularity greater than the root interleave result
+	 * in invalid DPA translations (invalid to support).
+	 */
+	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
+		if (cxld->interleave_ways != 3)
+			return false;
+
+		if (cxld->interleave_granularity != 2 * ig &&
+		    cxld->interleave_granularity != 4 * ig)
+			return false;
+	}
+	return true;
+}
+
 static ssize_t interleave_granularity_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
@@ -551,15 +576,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	/*
-	 * When the host-bridge is interleaved, disallow region granularity !=
-	 * root granularity. Regions with a granularity less than the root
-	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to support in the future). Regions
-	 * with a granularity greater than the root interleave result in invalid
-	 * DPA translations (invalid to support).
-	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	if (!interleave_granularity_allow(cxld, val))
 		return -EINVAL;
 
 	rc = down_write_killable(&cxl_region_rwsem);
@@ -1305,6 +1322,23 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static int gran_multiple(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	int root_decoder_gran = cxlrd->cxlsd.cxld.interleave_granularity;
+	int region_gran = cxlr->params.interleave_granularity;
+
+	/*
+	 * In regions built upon 3-way HB interleaves, the root decoder
+	 * granularity can be a multiple of the region granularity. The
+	 * multiple value is used in sorting and distance calculations.
+	 */
+	if (cxlrd->cxlsd.cxld.interleave_ways != 3)
+		return 1;
+
+	return root_decoder_gran / region_gran;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1336,6 +1370,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
 		int i, distance = 1;
+		int multiple = gran_multiple(cxlr);
 		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
@@ -1347,12 +1382,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		 * always 1 as every index targets a different host-bridge. At
 		 * each subsequent switch level those ports map every Nth region
 		 * position where N is the width of the switch == distance.
+		 *
+		 * With the introduction of mixed granularities in 3-way HB
+		 * interleaves, divide N by a multiple that represents the root
+		 * decoder to region granularity.
 		 */
 		do {
 			cxl_rr_iter = cxl_rr_load(iter, cxlr);
 			distance *= cxl_rr_iter->nr_targets;
 			iter = to_cxl_port(iter->dev.parent);
 		} while (!is_cxl_root(iter));
+		distance /= multiple;
 		distance *= cxlrd->cxlsd.cxld.interleave_ways;
 
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
@@ -1369,12 +1409,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (is_cxl_root(parent_port)) {
 		/*
 		 * Root decoder IG is always set to value in CFMWS which
-		 * may be different than this region's IG.  We can use the
-		 * region's IG here since interleave_granularity_store()
-		 * does not allow interleaved host-bridges with
-		 * root IG != region IG.
+		 * may be different than this region's IG.
 		 */
-		parent_ig = p->interleave_granularity;
+		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
 		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
 		/*
 		 * For purposes of address bit routing, use power-of-2 math for
@@ -1446,7 +1483,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    cxld->interleave_granularity != ig ||
+		    !interleave_granularity_allow(cxld, ig) ||
 		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
@@ -1675,11 +1712,12 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int multiple = gran_multiple(cxlr);
 	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (dport != cxlrd->cxlsd.target[pos % iw]) {
+	if (dport != cxlrd->cxlsd.target[pos / multiple % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
@@ -1811,6 +1849,9 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @multiple: the root decoder gran as a multiple of region gran
+ *	      Typically enforced as 1 except in 3-way HB interleaves
+ *	      See gran_multiple()
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1823,7 +1864,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   int multiple)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1869,6 +1911,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (rc)
 			return rc;
 
+		if (multiple > 1 && is_cxl_root(next_port(iter))) {
+			pos = pos + multiple * parent_pos;
+			break;
+		}
+
 		pos = pos * parent_ways + parent_pos;
 	}
 
@@ -1883,12 +1930,13 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 static int cxl_region_sort_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
+	int multiple = gran_multiple(cxlr);
 	int i, rc = 0;
 
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, multiple);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -1916,6 +1964,23 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	/*
+	 * Protect against improper gran mixes on 3-way HB interleave
+	 * Expect decoder gran*ways == region gran*ways
+	 */
+	if (cxlrd->cxlsd.cxld.interleave_ways == 3) {
+		if ((cxlrd->cxlsd.cxld.interleave_granularity * 3) !=
+		    (p->interleave_ways * p->interleave_granularity)) {
+			dev_dbg(&cxlr->dev,
+				"invalid config region:%d/%d decoder %d/%d\n",
+				p->interleave_ways, p->interleave_granularity,
+				cxlrd->cxlsd.cxld.interleave_ways,
+				cxlrd->cxlsd.cxld.interleave_granularity);
+
+			return rc;
+		}
+	}
+
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
 				  p->interleave_granularity);
 	if (rc) {
@@ -2069,9 +2134,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	 */
 	for (int i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		int multiple = gran_multiple(cxlr);
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, multiple);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",

base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
-- 
2.37.3

