Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4D36897F
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450064; cv=none; b=M6dfphVjin24ZK+oCfjWujGGcENs4331Ju0h5hTQp5IAoZhpNYAdyKzHYy9TF8MnNWsX3gK/mC/3Ae+J1kzpmTLPB0r06mmILm31oNBijiNt9Q4kCAkr7fjaH9O08eS5PkkNFVrzSkyGK04Z4vbuCOX0wktTaO7iuj4FQcD3RqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450064; c=relaxed/simple;
	bh=lxRA+a/bxfSsr8eqh5asljBEOEuTpU/B5VTpHFZZ5pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoyptI3W3MilQEvteg68d401TpL+RYiAD+GksFOGUfyEOmGPf604CL2FuXAKp4kIapTLBiLsMLDsLepptqDq6qAy/Ej7A20w/RTo4SVMfOO6LYmygyFr3VPsesmSbo381dPPIkmJLT/ui5SppRWCDxuQ0hH30zxq/SrhAFQr5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dx0aBaNQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx0aBaNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450063; x=1816986063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lxRA+a/bxfSsr8eqh5asljBEOEuTpU/B5VTpHFZZ5pw=;
  b=dx0aBaNQXE9pA76zutJFIQKBY+WFtVbSXhfGfL41K0xRat5CpVlOe12g
   JOLOoPs6/GYYPy5FbudxaQYKMNWr0qRCGa5qFAx9/npdAIXsA5nFeI33v
   joRq6dzBh9YxJzJwwWIPhyndORIwcGQAaTYnOpT0r6Op0N/tI5ist2t6l
   CB3Kjh6sWOc5FZjqtPdhFdo9RXohDfV/V19Og4aN92ox5ozT7RK7/+2JO
   Eez8ARSghyJM+X6OkUD3rTZGNjtL4v/h1bPz7adbKRG3pyIHGKxZZawUQ
   LOEu/dtBNkCP6OZoxjgrYsS9wtkJHTzvYsxtWc/lz8VEJC+jrixGAyHsQ
   Q==;
X-CSE-ConnectionGUID: FoAgVHE5Sy+/JnwNgWtNIA==
X-CSE-MsgGUID: hYXM/sIWR3idyTAZh5+lyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665390"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:50 -0700
X-CSE-ConnectionGUID: in8wUV8ZQ5eN75t1RM7+zQ==
X-CSE-MsgGUID: 2ktttVAdTHKTeOO2gQkj6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482254"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:45 -0700
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
Subject: [PATCH v3 5/9] cxl/region: Allow mixed-granularity regions
Date: Thu, 30 Jul 2026 15:20:25 -0700
Message-ID: <93bd16e6a327fcd037b5f1206c7bc15f5aa9b305.1785444498.git.alison.schofield@intel.com>
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

The sysfs granularity rule required region_gran == root_gran whenever
the root decoder interleaves. That blocked the legal mixed-granularity
layouts permitted by CXL Spec 4.0 Section 9.13.1 and made every 6-way
and 12-way configuration in Tables 9-6, 9-7, and 9-8 impossible to
create. Auto regions skipped the sysfs path entirely and so had no
equivalent gate.

Replace the equality rule with is_ig_allowed(), which permits any
region granularity not greater than the root's, and apply it at attach
time so auto regions get the same rule. Add a ways*gran span identity
check for 3-way-family roots: a 3-way interleave consumes no HPA
selector bits, so selector containment cannot prove that the root and
region cover the same address span, and the identity restores that
constraint. Power-of-2 roots get the equivalent constraint from
selector containment for free.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 53 +++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 938781c9bc5c..3919f64e2467 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,10 +559,27 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
+/**
+ * is_ig_allowed() - Check region granularity against the root decoder
+ * @cxlrd: root decoder
+ * @ig: proposed region granularity
+ *
+ * Return: true when the root does not interleave or @ig is no greater than
+ * the root decoder granularity.
+ */
+static inline bool is_ig_allowed(struct cxl_root_decoder *cxlrd, int ig)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+
+	if (cxld->interleave_ways <= 1)
+		return true;
+
+	return ig <= cxld->interleave_granularity;
+}
+
 static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 	u16 ig;
@@ -571,15 +588,7 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
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
+	if (!is_ig_allowed(cxlrd, val))
 		return -EINVAL;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
@@ -2278,6 +2287,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 	int root_pos_per_target;
+	int root_ways = cxlrd->cxlsd.cxld.interleave_ways;
+	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
 				  p->interleave_granularity);
@@ -2310,6 +2321,28 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	if (!is_ig_allowed(cxlrd, p->interleave_granularity)) {
+		dev_dbg(&cxlr->dev,
+			"ig %d incompatible with root ways %d ig %d\n",
+			p->interleave_granularity, root_ways, root_gran);
+		return -ENXIO;
+	}
+
+	/*
+	 * A 3-way-family root contributes no selector bits, so selector
+	 * validation cannot confirm that the root and region cover the same
+	 * interleave span. Check the span explicitly.
+	 */
+	if (!is_power_of_2(root_ways) &&
+	    (u64)p->interleave_ways * p->interleave_granularity !=
+	    (u64)root_ways * root_gran) {
+		dev_dbg(&cxlr->dev,
+			"region ways*gran (%d*%d) != root ways*gran (%d*%d)\n",
+			p->interleave_ways, p->interleave_granularity,
+			root_ways, root_gran);
+		return -ENXIO;
+	}
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

