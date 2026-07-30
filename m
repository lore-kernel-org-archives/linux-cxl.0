Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317113DA7DC
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450044; cv=none; b=BfXY/V6td+qpYea8CS9pf4RQTWTWwdLO7xi7o4tTVLEOSCPI4SEJVxYcdUIxLpdU1MURKGJEtAHQC8LYB1WIibpjT6kRuo8yeAuPb5CdfyT6yI2CI52REhsiuX6WI1BRHEkzzODb6TUvzXKVFFA6zEAOBA45x93y2xA5PkXduko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450044; c=relaxed/simple;
	bh=pI01B8nYcvV2UmCxqziW4hD78whTKELCLaBAv4S5glE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLPmoPGmidbK6ZnVq6ff6jwIMAvNKLoMyd4MpJvaK0yvdp54VsJ35jgeIondnRR4b0YfUw8tHlH1dQfmeI7WTG02prPX/yuJq9VbCQ87tsoWR7jTEYOQooKtRCE1ixU2yGk2S5PJDGpkpaFJESluzv8OjW9Vhx3Or7i4EM0/XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuJB8VUy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuJB8VUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450043; x=1816986043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pI01B8nYcvV2UmCxqziW4hD78whTKELCLaBAv4S5glE=;
  b=iuJB8VUypyRkZL0yS8ULFDeUfm20xho/x4om23yKFbdzQdjfFq/4awLZ
   EBSInAJO7RoOCIn9xQlHV6gSBNSH/gCY6Y8F5/v5kL6g3vgyVjmTMy1rH
   IUENvNRSlzv1ABR1bJIjknuq1BKian6ECnA4OY3hp5lFZzhRlOyVm+4Ok
   SS9y4CpTzp8PvRMfRhT1hUengANi5ORLXoa+9C7bNjEDa0px7JF6fZU1T
   Z0BAvqfkJ7CxLwpxv2Upli+xyq9rnIOoifknNQwhudiZrT1G8m1qp7IQY
   V8mYwhFDaJD673lLvf6+LSYXo5apJszAH8Udo+ULW9+efdAg1b+zR1Rag
   Q==;
X-CSE-ConnectionGUID: 2rRn79UFTuidehM0dTe65w==
X-CSE-MsgGUID: x4MVU3eYS9uYG88TvJ0hJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89890923"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89890923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:42 -0700
X-CSE-ConnectionGUID: K8mL+W9FQFK+OkdDtAjspA==
X-CSE-MsgGUID: 0LK7UIm+SJedPEF2Ut/jmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="264224225"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:42 -0700
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
Subject: [PATCH v3 2/9] cxl/region: Validate interleave selector bits
Date: Thu, 30 Jul 2026 15:20:22 -0700
Message-ID: <67cfafacefffabb7db34f9d261ba47c0edc7dc67.1785444498.git.alison.schofield@intel.com>
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

Each decoder level in an interleave uses a field of host physical
address (HPA) bits, called a selector, to choose which of its
downstream targets a given address routes to. In a multi-level
interleave the selectors of the root, the switches, and the endpoints
must occupy distinct address bits so that every level makes an
independent routing decision.

The existing setup does not check the selectors directly. It instead
requires each level's granularity to equal the parent granularity
multiplied by the parent ways, which only holds for a subset of the
legal selector layouts. Layouts that place non-overlapping selectors
in a different order, as mixed-granularity regions do, are rejected
even though they are valid.

Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
the selector of each level from the root toward the current port,
reject any selector that overlaps a bit already claimed by another
level, and reject an accumulated selector that does not fit within
the region selector. The root decoder's selector is walked alongside
the switch levels rather than tracked separately.

This patch adds selector validation but does not yet enable the
mixed-granularity layouts. A temporary gate rejects region granularity
finer than the root granularity until the position arithmetic is
updated.

Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 103 +++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1082db7b2cca..b0061f03892a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1448,33 +1448,110 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 }
 
 /**
- * get_parent_fanout() - Calculate the switch fan-out above a port
+ * get_selector() - Build the HPA selector mask for an interleave
+ * @ways: interleave ways
+ * @gran: interleave granularity in bytes
+ *
+ * Power-of-2 interleaves select targets with contiguous HPA bits beginning
+ * at @gran. For 6-way and 12-way interleaves, only the power-of-2 factor
+ * contributes selector bits. A 3-way interleave contributes no selector
+ * bits.
+ *
+ * Return: the HPA selector mask, or 0 when no selector bits are used.
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
+/**
+ * get_parent_selectors() - Collect selectors and fan-out above a port
  * @parent_port: first ancestor port
  * @cxlr: region under construction
+ * @cxlrd: region root decoder
+ * @accum: filled with the selectors claimed by the ancestors
  * @fanout: filled with the product of the ancestor switch ways
  *
- * Walk from @parent_port to the root and multiply the interleave ways of
- * each switch decoder. Root decoder ways are not included.
+ * Start with the root decoder selector and walk the ancestor switch
+ * decoders. Reject selectors that overlap. Passthrough decoders contribute
+ * neither selector bits nor fan-out.
  *
- * Return: 0 on success.
+ * Root decoder ways are not included in @fanout.
+ *
+ * Return: 0 on success, -ENXIO on selector overlap.
  */
-static int get_parent_fanout(struct cxl_port *parent_port,
-			     struct cxl_region *cxlr, int *fanout)
+static int get_parent_selectors(struct cxl_port *parent_port,
+				struct cxl_region *cxlr,
+				struct cxl_root_decoder *cxlrd, u64 *accum,
+				int *fanout)
 {
+	u64 selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
+				    cxlrd->cxlsd.cxld.interleave_granularity);
 	int distance = 1;
 	struct cxl_port *iter;
 
 	for (iter = parent_port; !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
+		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
+		u64 cxld_sel;
 
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
 		distance *= cxl_rr_iter->nr_targets;
 	}
 
+	*accum = selector;
 	*fanout = distance;
 	return 0;
 }
 
+/**
+ * region_selectors_fit() - Check ancestor selectors against the region
+ * @port: port being configured
+ * @cxlr: region under construction
+ * @accum: selectors used by the ancestor decoders
+ *
+ * Return: true when every accumulated selector bit is present in the region
+ * selector.
+ */
+static bool region_selectors_fit(struct cxl_port *port,
+				 struct cxl_region *cxlr, u64 accum)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	u64 cxlr_sel = get_selector(p->interleave_ways,
+				    p->interleave_granularity);
+
+	if ((cxlr_sel & accum) != accum) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			cxlr_sel, accum);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * derive_port_granularity() - Calculate the granularity for a port decoder
  * @cxlr: region under construction
@@ -1517,6 +1594,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	int ig, iw = cxl_rr->nr_targets;
 	int fanout, rc;
 	int pos = cxled->pos;
+	u64 accum;
 	u16 eig;
 	u8 eiw;
 
@@ -1538,10 +1616,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -ENXIO;
 	}
 
-	rc = get_parent_fanout(parent_port, cxlr, &fanout);
+	rc = get_parent_selectors(parent_port, cxlr, cxlrd, &accum, &fanout);
 	if (rc)
 		return rc;
 
+	if (!region_selectors_fit(port, cxlr, accum))
+		return -ENXIO;
+
 	if (cxl_rr->nr_targets_set) {
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
@@ -2087,6 +2168,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/*
+	 * Mixed-granularity position calculation is added by the next patch.
+	 * Reject it until then so this intermediate state remains bisectable.
+	 */
+	if (cxlrd->cxlsd.cxld.interleave_granularity >
+	    p->interleave_granularity)
+		return -ENXIO;
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

