Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069723E171A
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200063; cv=none; b=kUI5zH3ltsrOR70L/p35osSVIbpc6kD2TBff1gE0wcp9o3YIqxl9TEawyfiHwr1qPhEevaqw4YyvgPV6rYQceJYFK3gwKabCUyqwihpOUP7A7s7qGf4eT3pW2y8K++Sn+WYM2DJ7r/SWmKcts6ErRCZ+oM8WeZrLoVY3UdupriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200063; c=relaxed/simple;
	bh=DqBVtmItbQP0hx/rIpi5Sm2doLVweQMRtkP3MTNhXh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyc/3rq8lH+uWA9pPBB6sA1nYleuxz51CDJ4W/scL4Z4aJjIa8aT8vNffGIVIsYm5InBGhh4eM/68oy6vx37cut2YzyMCaFhJsOQXUI3SWjnc4sgzSMdUTBPIKp8+SxWkU7/325j/BCoVwr0RIV0IN9RCKUBPtp2chzZW7kzWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIyJw/EF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIyJw/EF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200062; x=1812736062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqBVtmItbQP0hx/rIpi5Sm2doLVweQMRtkP3MTNhXh0=;
  b=gIyJw/EFLtVi+V8o+Z5Cmmu49ZAkOnH+4twAZ/q3k2yHqoksl3olTY3k
   B7wKvtxJZGR/lBOXwSvJv6uaTN5fap5G0E5mE6ZItaA7dOAZaqMPR6l0+
   nth9lEvpyeVRo3KDFK+/10K7wWSMLvVc+nhgAufsHxItY18jvz535CZM1
   jdovZ0ViiQxNjbtjRsUnJ5yiwqZ8V5jeoyysP3pP499ybqci1bp9BbNoT
   cR9KUCbcO9K4B3U7u2LfakBr/aAqfgM9ve7NMerNPJCK2ZnfOSio8i63d
   dK4UDVYeMQ2lCNfeMkS0RuuuNXFmzWzhVjJs3lFRVWo/S99TehvLvcw9I
   A==;
X-CSE-ConnectionGUID: GM2JOHeRTvenpbU+LB4erw==
X-CSE-MsgGUID: uxHUr15WQFqtcQXt4y5HlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82006762"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82006762"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:42 -0700
X-CSE-ConnectionGUID: BHhWlODESDCBJ8N5aPnyIw==
X-CSE-MsgGUID: Pg8aDcv7TaqLu+IInp7BBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245671618"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.154])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:41 -0700
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
Subject: [PATCH v2 4/6] cxl/region: Validate mixed-granularity at sysfs and attach gates
Date: Thu, 11 Jun 2026 10:47:28 -0700
Message-ID: <42da0b69d39207b712d7c27f1af6186febbeaa6f.1781199122.git.alison.schofield@intel.com>
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

User-created regions are validated at sysfs write through
set_interleave_granularity(). Auto regions skip that path. Both
need the same mixed-granularity rule applied before the per-port
selector walk runs.

Replace the same-granularity sysfs check with is_ig_allowed(),
which permits any region granularity not greater than the root
granularity. Call the same helper at attach time so auto regions
get the same rule.

3-way-family roots (3, 6, and 12 ways) need an additional check.
A 3-way interleave consumes no selector bits, so selector containment
alone cannot prove that the root and region cover the same address
span. Add an explicit ways*gran span equality check in
cxl_region_attach() for these roots.

Endpoint decoder capability is still checked at attach time by
check_interleave_cap().

The new gates reference the root decoder ways and granularity
several times through the verbose cxlrd->cxlsd.cxld.interleave_*
dereference. Lift those into root_ways and root_gran locals to keep
the checks readable.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9fff538a9ce1..311b5052bbc8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,10 +559,29 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
+/**
+ * is_ig_allowed() - Validate region interleave granularity
+ * @cxlrd: root decoder
+ * @ig: proposed region interleave granularity in bytes
+ *
+ * Callers must have validated @ig through granularity_to_eig() first.
+ *
+ * Return: true for a non-interleaving root or any region granularity
+ * not larger than the root granularity.
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
@@ -571,15 +590,7 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
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
@@ -2096,6 +2107,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 	int stride;
+	int root_ways = cxlrd->cxlsd.cxld.interleave_ways;
+	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
 				  p->interleave_granularity);
@@ -2128,6 +2141,28 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/* Apply the sysfs granularity rule to auto regions too. */
+	if (!is_ig_allowed(cxlrd, p->interleave_granularity)) {
+		dev_dbg(&cxlr->dev,
+			"ig %d incompatible with root ways %d ig %d\n",
+			p->interleave_granularity, root_ways, root_gran);
+		return -ENXIO;
+	}
+
+	/*
+	 * Selector containment cannot prove span equality for 3-way family
+	 * roots because a 3-way interleave consumes no selector bits.
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

