Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00B3D8901
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450043; cv=none; b=rVT6eDuuNwosCIU1ThE6hyjt7W6ximJiYtLsw+ZmsYF6r/Kj0d89zrqj65FmQYbn6T223gXmLhnS0bTi4OUUplghgY++BKdb/yU4gWCYtXqybN3hVzKtL9r6Em3gb2/yelbYdxbWg1DwDw1P1SFltfhNdNLg6HxCY+ob93u+SDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450043; c=relaxed/simple;
	bh=/HQDsLuVxhRmCdYABxXzzPbST1c7aDWKCMV01wzCTsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYJA3XEHGHeUXg9a8xWxenLVT+bJEs0lovD7xZPVwlNZ9HY02iR0PNVtwvAPcmvC+PcCG1SM0CtF6QnuR1fY319x7nzQw81z1Dxb6EtYZtBBNQ3Wu2dz3Yv/Cqgx7+jx+nXzWJ9UbwAGQS6vp00LR7yUUQoX6D84Vba/lAeIB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAru1auX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAru1auX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450042; x=1816986042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/HQDsLuVxhRmCdYABxXzzPbST1c7aDWKCMV01wzCTsE=;
  b=FAru1auXj3jqFSCn9KEruqB+b6JQE99nxBmcRkyHRsbhy7CL9SrnSBLl
   AjmPQXT22GVbrr8gn6Ova1Vs6xoPFq1vbmXezynEu1YCBhk7kaZMEsLjS
   Jf50iJk89OcAmaQreqsnxJ1ha/Zi0BWhcgAUMC9+aGpm5+Io//COnSzzV
   7nimAU4IY4z3wf2/0JgcHGFTFPwJ125rWCmE7JWPflbjUNvkacg8utxiw
   5rQqW+l4XPuAhuIy+mx5oJH8yGZyzONpVSNSuJscLk5St22EyTry+ppsR
   7CIz7aOPvr/qSHW6Myw+Z1jpvF9SW/VdbH4/o+uMG+rY0vhMPNC6ghdBi
   g==;
X-CSE-ConnectionGUID: BIKUoPoVQUuPvumTU9w5lA==
X-CSE-MsgGUID: dXJ3Ym8lRS2EVYlGH5A7aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89890906"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89890906"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:41 -0700
X-CSE-ConnectionGUID: D5R/LZLST9K2H21CyxbMhw==
X-CSE-MsgGUID: +BhMN4AZQO+5PYSEInvRZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="264224212"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:40 -0700
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
Subject: [PATCH v3 1/9] cxl/region: Factor port target calculations
Date: Thu, 30 Jul 2026 15:20:21 -0700
Message-ID: <3fe2719ce4e5ab79d842107c575d326c5658b9a6.1785444498.git.alison.schofield@intel.com>
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

cxl_port_setup_targets() calculates the interleave fan-out above a
port, the port decoder granularity, and the distance between
endpoints routed through the same downstream port.

Factor those calculations into helpers so the target setup path can
be extended. Validation of parent decoder values is dropped since
those values are validated where they are set, before this port's
setup runs. A configuration that is invalid in more than one way may
report a different error first.

Suggested-by: Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 197 +++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 101 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..1082db7b2cca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1350,6 +1350,19 @@ static void cxl_port_detach_region(struct cxl_port *port,
 		free_region_ref(cxl_rr);
 }
 
+/**
+ * check_last_peer() - Verify the previous endpoint routed to this dport
+ * @cxled: endpoint decoder being placed
+ * @ep: this endpoint's entry for the port
+ * @cxl_rr: region reference for the port
+ * @distance: distance to the previous endpoint routed to this dport
+ *
+ * Endpoints routed through the same dport recur at @distance intervals in
+ * region-position order. Verify that the endpoint at ``pos - distance`` used
+ * the same dport.
+ *
+ * Return: 0 on success, -ENXIO on a routing mismatch.
+ */
 static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr,
 			   int distance)
@@ -1434,60 +1447,106 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/**
+ * get_parent_fanout() - Calculate the switch fan-out above a port
+ * @parent_port: first ancestor port
+ * @cxlr: region under construction
+ * @fanout: filled with the product of the ancestor switch ways
+ *
+ * Walk from @parent_port to the root and multiply the interleave ways of
+ * each switch decoder. Root decoder ways are not included.
+ *
+ * Return: 0 on success.
+ */
+static int get_parent_fanout(struct cxl_port *parent_port,
+			     struct cxl_region *cxlr, int *fanout)
+{
+	int distance = 1;
+	struct cxl_port *iter;
+
+	for (iter = parent_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
+
+		distance *= cxl_rr_iter->nr_targets;
+	}
+
+	*fanout = distance;
+	return 0;
+}
+
+/**
+ * derive_port_granularity() - Calculate the granularity for a port decoder
+ * @cxlr: region under construction
+ * @fanout: product of the ancestor switch ways
+ * @ig: filled with the port decoder granularity
+ *
+ * Preserve the existing parent-granularity times parent-ways recurrence in
+ * terms of the region granularity and the fan-out above this port.
+ *
+ * Return: 0 on success.
+ */
+static int derive_port_granularity(struct cxl_region *cxlr, int fanout,
+				   int *ig)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
+	struct cxl_region_params *p = &cxlr->params;
+	int sel_distance;
+
+	sel_distance = is_power_of_2(root_iw) ? root_iw : root_iw / 3;
+	sel_distance *= fanout;
+	*ig = p->interleave_granularity * sel_distance;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	int root_iw = cxlrd->cxlsd.cxld.interleave_ways;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	int ig, iw = cxl_rr->nr_targets;
+	int fanout, rc;
+	int pos = cxled->pos;
+	u16 eig;
+	u8 eiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
 	 * decoders only support powers of 2 up to x16.
 	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
+	if (!is_power_of_2(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
 		return -EINVAL;
 	}
 
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
+	rc = get_parent_fanout(parent_port, cxlr, &fanout);
+	if (rc)
+		return rc;
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
-						     distance);
+						     root_iw * fanout * iw);
 				if (rc)
 					return rc;
 				goto out_target_set;
@@ -1495,84 +1554,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
-
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
+	rc = derive_port_granularity(cxlr, fanout, &ig);
+	if (rc)
 		return rc;
-	}
 
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
-- 
2.37.3

