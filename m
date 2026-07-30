Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C60395D98
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450063; cv=none; b=u//vSoG4vKrvJeu8D4umoowU4KyVGjQ7I0qrccH+BTnP329E+yptDiu+BAH8ePeB3FiDGFlgSEmHKnbN5IOfQfL5B/7pRtFVrLEIG880qlLy1PBNG2PWbvmnwy2GrAE8LWnVNYvxnFapwzthAD+v4eTdoLghjS1QTqmSKacdLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450063; c=relaxed/simple;
	bh=v8cjlw6s7f2G91GSCtAqf2Mg1qZuS8b50Xl82Bj0ReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZpnkd11ZWL++IZ5Rh/hiq/DRNZjJ5259wzYTi6BF2GB4ZFdu80gkJNlXI44BKhSzvoxBdCKbJaP+p2a/dHbbc/lzQtcCqoc5yhL2DGc0+te6KBSmOGVUFh2KUwOHPGANLpWg2Q8WYQ5ZSCFBCG+/Y5Dc8aN2/xvsE0FkYypy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dac4R056; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dac4R056"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450061; x=1816986061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8cjlw6s7f2G91GSCtAqf2Mg1qZuS8b50Xl82Bj0ReU=;
  b=Dac4R056fFbX3tCW5pqIjMn3esEymDOtal96jte4Z5pESkAczE540sop
   UdBAq5T2R2VipHS4f2tllq1OZGk7vKEO6mCB+yLiEAwWtf1sbg9x+iBIY
   fhYeeQyeDWmVmxOBH3ToRTYH8e15mD+FuDcCrStuBnBiPG00epZ40rKQn
   k3CEMZrpZxK6NGP3QxpaDypKE6N3aQ7BjZJ+IUxnnMhDYluK3cYdBCJ9H
   SOZZvzD9FRLJwZPFJR75pgbC9fZJFKxSkZ8vfzX6Of29UrW+T51/pe53E
   UQ36HX1vxWS8NUknhW4hwenGbyGPtsFm/3fejSrdYV9QGEoqfPHbO7xGb
   A==;
X-CSE-ConnectionGUID: J8045YzTQ6q3T634SztwHw==
X-CSE-MsgGUID: JWJG+i4ERsWNaj7vmEiG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665374"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665374"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:44 -0700
X-CSE-ConnectionGUID: US4aEdaXQgyPvpnA5jW24Q==
X-CSE-MsgGUID: 9D4z2/BfQ6Gdw1qlmmZdtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482244"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:43 -0700
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
Subject: [PATCH v3 3/9] cxl/region: Derive port granularity from selector bits
Date: Thu, 30 Jul 2026 15:20:23 -0700
Message-ID: <efef416440a89a44dfddb13ef390285a98c69cd4.1785444498.git.alison.schofield@intel.com>
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

A user-created region currently derives each port decoder granularity
from the parent granularity and ways. That recurrence assumes the
selector bits follow the existing same-granularity ordering and cannot
derive the decoder settings for a mixed-granularity region.

Add cxl_region_is_mixed_gran() as the common predicate for regions
whose granularity is finer than an interleaving root decoder.

Update derive_port_granularity() to choose each port decoder's
granularity from the selector bits not already used by its ancestors.
For auto regions, compare the firmware-programmed granularity with the
derived value and reject a mismatch.

Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 90 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b0061f03892a..871dedd37cc8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1552,32 +1552,94 @@ static bool region_selectors_fit(struct cxl_port *port,
 	return true;
 }
 
+/**
+ * cxl_region_is_mixed_gran() - Test for a mixed-granularity region
+ * @cxlr: region
+ *
+ * A region is mixed-granularity when an interleaving root decoder uses a
+ * larger granularity than the region.
+ *
+ * Return: true for a mixed-granularity region.
+ */
+static inline bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+
+	return cxld->interleave_ways > 1 &&
+	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
+}
+
 /**
  * derive_port_granularity() - Calculate the granularity for a port decoder
+ * @port: port being configured
  * @cxlr: region under construction
+ * @accum: selectors used by the ancestor decoders
  * @fanout: product of the ancestor switch ways
- * @ig: filled with the port decoder granularity
+ * @iw: port decoder interleave ways
+ * @ig: filled with the derived granularity
  *
- * Preserve the existing parent-granularity times parent-ways recurrence in
- * terms of the region granularity and the fan-out above this port.
+ * Select the decoder granularity from the region selector bits not already
+ * used by its ancestors. Same-granularity regions allocate the lowest
+ * available selector bits first. Mixed-granularity regions allocate the
+ * highest available selector bits first so decoder granularities decrease
+ * from the root toward the endpoints.
  *
- * Return: 0 on success.
+ * A passthrough decoder uses no selector bits and retains the granularity
+ * implied by the ancestor fan-out.
+ *
+ * Return: 0 on success, -ENXIO when no valid selector remains.
  */
-static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
-				   int *ig)
+static int derive_port_granularity(struct cxl_port *port,
+				   struct cxl_region *cxlr, u64 accum,
+				   int fanout, int iw, int *ig)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
 	struct cxl_region_params *p = &cxlr->params;
+	u64 selector;
 	int sel_distance;
 
-	sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
-	sel_distance *= fanout;
-	*ig = p->interleave_granularity * sel_distance;
+	selector = get_selector(p->interleave_ways,
+				p->interleave_granularity) & ~accum;
+
+	if (iw == 1) {
+		sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
+		sel_distance *= fanout;
+		*ig = p->interleave_granularity * sel_distance;
+	} else if (selector && cxl_region_is_mixed_gran(cxlr)) {
+		*ig = (1ULL << fls64(selector)) / iw;
+	} else if (selector) {
+		*ig = 1ULL << __ffs64(selector);
+	} else {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: no selector bits available for iw %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
+		return -ENXIO;
+	}
+
+	if (iw > 1 && (~selector & get_selector(iw, *ig))) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			get_selector(iw, *ig), selector, iw, *ig);
+		return -ENXIO;
+	}
 
 	return 0;
 }
 
+/**
+ * cxl_port_setup_targets() - Validate and program a port decoder
+ * @port: port being configured
+ * @cxlr: region under construction
+ * @cxled: endpoint decoder being attached
+ *
+ * Validate the decoder's selector placement and derive its interleave
+ * geometry. User-created regions program the derived values; auto regions
+ * validate the firmware-programmed values.
+ *
+ * Return: 0 on success, negative errno on invalid interleave geometry.
+ */
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1635,7 +1697,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		goto add_target;
 	}
 
-	rc = derive_port_granularity(cxlr, fanout, &ig);
+	rc = derive_port_granularity(port, cxlr, accum, fanout, iw, &ig);
 	if (rc)
 		return rc;
 
@@ -1650,8 +1712,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		if (iw > 1 && cxld->interleave_granularity != ig) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: firmware ig %d != derived ig %d (iw %d)\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				cxld->interleave_granularity, ig, iw);
+			return -ENXIO;
+		}
 		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
-- 
2.37.3

