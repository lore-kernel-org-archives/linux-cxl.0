Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC114756DA
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866688; cv=none; b=Rj6hiyXosnCuVeZ7i7lPnCxl/ZL3c6+ZuEl5vCL9ow1YGuqKTiWodESKiZ4VQl0yGyut4VngTyESvaMR0ILim0+nM+JbIq91XL3N+uipjPnhxYxgSyOKnyYdn+OawRQsrwyaQ3fkI/sBQKVlwwwvR9S6VVawLsv1jJDcIYKpd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866688; c=relaxed/simple;
	bh=MkSUsC+j5cOqNXqoUxjovTpXqig8hOushMzinf9Odtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp4Nftx3BAfGRQtKuss5ZwNCBnDDT2T1kGzw4GRwEqL0ZTg7NR5ICQA+yHfyu5+ZEZm5E2zjTgVpUvhK5UPqwgSONzcgE+FW4Oa1ZZs6SKPuWkD4faSiSYb8xiZ1w0svwSdw8H7/G1Fw46vaP4IZrjauKIwkiM+BiQkaGjb3bz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5LSYDFV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5LSYDFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791866687; x=1823402687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MkSUsC+j5cOqNXqoUxjovTpXqig8hOushMzinf9Odtc=;
  b=g5LSYDFVIUsad451lJ9B+HPMRFhoTkQYDko7CIxuU9Vz/5NCAKnbE4EQ
   L5xiDu1xD+TNO5JmV74qmwO4XsMLF+bd3u7Zy/mq8/HwpGVwnkMJAFFM+
   bpcnLlngneXidiSQVjg/7jzxIswrRMfynfjmLIft7e4gA+mJgZRot/eVd
   ymIWldqq8ql3Ouf7BSFy5nrTEPv9miUVYfcVzBT1rhw2cq3d4RKGBY3Sv
   y8sKkLUYPwwB6ficKhsoKkDZDk+aSLieO/sKSu0Ls/P6eAzW4yMzq/O/d
   VlL0yN2oveJvTEC4Kgdcu+QWKpSe3jPSwENEjaxV/kpGhCVnyP1QDlnIb
   Q==;
X-CSE-ConnectionGUID: 7WbNmqZgT7W++X5NAwccuA==
X-CSE-MsgGUID: Rw+ipl7pRl6HjQ8kR0cHuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="482808"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="482808"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:35 -0700
X-CSE-ConnectionGUID: Bxxm6C9CT0W4xRhBpCVTQw==
X-CSE-MsgGUID: s9ROW2K9SMacH4eFZks+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1170838"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 3/5] cxl/region: Support auto region granularity finer than the root
Date: Mon, 12 Oct 2026 21:44:25 -0700
Message-ID: <2b6b4fc7525eb37b76dead620e6880d2d88aaa04.1791863201.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791863201.git.alison.schofield@intel.com>
References: <cover.1791863201.git.alison.schofield@intel.com>
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
coarser toward the endpoints. The driver cannot assemble a region whose
interleave granularity is finer than the granularity of its interleaving
root decoder.

Support auto regions with a granularity finer than the root, restricted to
configurations whose granularity refines monotonically toward the
endpoints. Derive each interleaving decoder's granularity from its parent:

        ig = parent_ig / iw

A same-granularity region keeps the existing derivation, which coarsens
toward the endpoints:

        ig = parent_ig * parent_iw

The topology determines each decoder's interleave ways, so the parent
granularity and the decoder's ways determine its granularity. Use that
relationship to validate the decoder geometry while assembling an auto
region. Only the interleaving levels are compared; a passthrough level,
iw == 1, keeps its granularity exemption.

Refuse a derived granularity finer than the region granularity. Each
interleaving level consumes part of the region interleave, and the deepest
interleaving level must not refine beyond the region granularity.

For the layouts Linux supports, require the root and region to interleave
over the same span, the address range in which the interleave pattern
completes one full pass:

        root_iw * root_ig == region_iw * region_ig

The same span relationship covers the CXL Specification's Mod3
configurations. For example, a 6-way region at IGB across three host
bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave at
IGB below it, as described in CXL 4.0 Section 9.13.1.1.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 102 +++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 35fefc33206d..ee450704af2c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,6 +1432,52 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static int check_root_interleave(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p = &cxlr->params;
+	int root_ig = cxld->interleave_granularity;
+	int root_iw = cxld->interleave_ways;
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
+	 * A same-granularity region below a power-of-two root may repeat
+	 * the root targets, spanning a multiple of the root span.
+	 */
+	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)
+		return 0;
+
+	/* Span is one complete pass through the interleave pattern */
+	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"region span %d (%d ways at %d) does not match root span %d (%d ways at %d)\n",
+			p->interleave_ways * p->interleave_granularity,
+			p->interleave_ways, p->interleave_granularity,
+			root_iw * root_ig, root_iw, root_ig);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+/* Region IG is finer than the IG of its interleaving root decoder */
+static bool cxl_region_is_finer_than_root(struct cxl_region *cxlr)
+{
+	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
+
+	return cxld->interleave_ways > 1 &&
+	       cxld->interleave_granularity > cxlr->params.interleave_granularity;
+}
+
 /*
  * The "distance" between peer downstream ports represents which
  * endpoint positions in the region interleave a given port can
@@ -1449,6 +1495,14 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	struct cxl_port *iter = port;
 	int distance = 1;
 
+	/*
+	 * A finer-than-root region refines toward the endpoints, so peer
+	 * targets at the finest interleaving level occupy consecutive region
+	 * positions.
+	 */
+	if (cxl_region_is_finer_than_root(cxlr))
+		return 1;
+
 	do {
 		cxl_rr_iter = cxl_rr_load(iter, cxlr);
 		distance *= cxl_rr_iter->nr_targets;
@@ -1468,15 +1522,17 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
 	int parent_iw, parent_ig;
 
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
+		if (parent_iw > 1) {
+			parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
+		} else {
+			/*
+			 * A single-way root does not interleave, so its
+			 * granularity does not constrain the region interleave.
+			 * Use the region granularity instead.
+			 */
+			parent_ig = p->interleave_granularity;
+		}
 		/*
 		 * For purposes of address bit routing, use power-of-2 math for
 		 * switch ports.
@@ -1517,7 +1573,7 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 				    struct cxl_region_ref *cxl_rr, int *out_iw,
 				    int *out_ig)
 {
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	int parent_iw, parent_ig, iw, ig, rc;
 	struct cxl_switch_decoder *cxlsd;
@@ -1533,16 +1589,24 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 		return -EINVAL;
 	}
 
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	ig = parent_ig * parent_iw;
+	/* Finer-than-root regions refine granularity toward the endpoints */
+	if (cxl_region_is_finer_than_root(cxlr)) {
+		ig = parent_ig / iw;
+
+		if (ig < p->interleave_granularity) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s: granularity %d is finer than region granularity %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				ig, p->interleave_granularity);
+			return -ENXIO;
+		}
+	} else {
+		ig = parent_ig * parent_iw;
+	}
 
 	if (!granularity_valid(ig)) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
+		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), ig);
 		return -EINVAL;
 	}
 
@@ -2183,6 +2247,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	rc = check_root_interleave(cxlr);
+	if (rc)
+		return rc;
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

