Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA635C6B7
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492103; cv=none; b=bU3nKyqD7AZbNYngzfQZfSQ5VJKvi8Lt/pLBbcliHuyH9lUq8yCJLeRwiyBqurHMvOHH3SsF25TmMtiEojeRtKatGqZ+XJ8ecsPl+LOqzHaoShoSpGCxnymXotkOaQfdfl/vwWPg9sgazmhGuw8Q5kI2dOUx9/mufe6oPUMTboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492103; c=relaxed/simple;
	bh=9tIuxcrki7Z19WHhfN9gaqfCwR9RmbxbjLjmWMO3lZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rd+43ip/0DdJlYO+Y9kT39VNTrGQ77TCVy9eE7ZrLXwT21/bQsJ+fuDjw6P40ENJ3ifHPDXE9spEV7hfZ7nVl2PjaJWNnXakw1vLR1qpX+8RQKPyNalEWE8nHYdq7gVUkcvnZaXlVPdpIHLjpSuyN0H/KjPUC/olREIPtpzHwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvHCuvcX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvHCuvcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788492101; x=1820028101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tIuxcrki7Z19WHhfN9gaqfCwR9RmbxbjLjmWMO3lZE=;
  b=PvHCuvcX95NdWPSbsk7xXgFbSanSG5k8dUo7wm1XqpVfnP52af/lS6Vy
   45c8Ey0dZbhd4ewoflgnkGlhVaI6gEqAjhPAPg2lSzjsfsnxj2oXthAQG
   XuTSjaF+b6OedYRnKYJOAhFMl8+IAl+XpJILiG+A4rAiBQmpA8Zzh7pb7
   +L6ixOhSTzbHdFQWfaXPNjpAUTd+SaQiPpBSzOmOggGPbKhoEiKDO8CSP
   YwA51RrotpERedT2pbj6d2WFANx0MHJHFi+wcAy08BrAnKmqLFyJY5YYh
   RpbU0udjSA5WJd9PBt03+O+wWNzKqDTFWPqMvjB0Xv+vHFVt1msRM94m7
   g==;
X-CSE-ConnectionGUID: xChAmx56RdChn9XjrI3POQ==
X-CSE-MsgGUID: fzJqpShpRJGJnGjuKpkFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100149501"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100149501"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:40 -0700
X-CSE-ConnectionGUID: u6YCYChGT1GFG6MFcNMAbw==
X-CSE-MsgGUID: cJeJP5RCTd+fp6+T23VQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268606604"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 1/2] cxl/region: Allow regions with an unencodable passthrough granularity
Date: Thu,  3 Sep 2026 20:21:32 -0700
Message-ID: <35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788487020.git.alison.schofield@intel.com>
References: <cover.1788487020.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region creation fails when the interleave granularity accumulated below the
root decoder exceeds 16K, the maximum encodable in the HDM Decoder Control
IG field, even when the decoder that computes it does not interleave.

For example, a 2-way root decoder at 16K granularity with a single endpoint
below each host bridge. Neither host bridge decoder interleaves, yet the
32K granularity computed for them is rejected and the region fails to
attach an endpoint:

  cxl region3: root0: invalid granularity calculation (16384 * 2)
  cxl_port endpoint16: failed to attach decoder16.0 to region3: -22

A non-interleaving decoder does not consume the IG field, so region setup
is rejecting a value hardware never reads.

Only require the granularity to be encodable for interleaving decoders,
both where it is inherited from the parent and where it is computed for the
current decoder. Keep the computed value for passthrough decoders so it can
seed descendant decoder setup.

Accumulating the granularity below a passthrough decoder is not being
undone: a descendant that does interleave must see the accumulated value or
it would interleave on an address bit an ancestor already used. That
descendant inherits a granularity above 16K, so it is still rejected on its
own turn and a real overflow cannot be masked.

When committing a non-interleaving decoder, still program the granularity
if it is encodable; use a don't-care IG encoding only when it is not. This
preserves an encodable passthrough granularity across re-enumeration, so
descendants do not inherit a stale value.

As a consequence, the interleave_granularity attribute of a decoder whose
interleave_ways is 1 may report a value above 16K. Document that the
reported granularity for non-interleaving decoders is a don't-care value
that may exceed the maximum encodable in hardware.

Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
Assisted-by: Claude:Opus-4-8
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  5 +++-
 drivers/cxl/core/hdm.c                  |  8 +++++-
 drivers/cxl/core/region.c               | 34 ++++++++++++++-----------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..6abfd792f07e 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -412,7 +412,10 @@ Description:
 		space this decoder claims at address N before the decode rotates
 		to the next target in the interleave at address N +
 		interleave_granularity (assuming N is aligned to
-		interleave_granularity).
+		interleave_granularity). When 'interleave_ways' is 1, the
+		decoder does not interleave and the reported granularity is
+		a don't-care value that may exceed the maximum encodable in
+		hardware.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..5ff1a75124cc 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -691,7 +691,13 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+
+	/*
+	 * A non-interleaving decoder ignores the IG field, so an unencodable
+	 * granularity is a don't-care rather than a failure.
+	 */
+	if (granularity_to_eig(cxld->interleave_granularity, &eig) &&
+	    WARN_ONCE(cxld->interleave_ways > 1,
 		      "invalid interleave_granularity: %d\n",
 		      cxld->interleave_granularity))
 		return;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..89693f0181dd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1435,6 +1435,20 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/*
+ * Hardware only consults the IG field of a decoder that interleaves, so a
+ * granularity the field cannot encode only matters when @ways exceeds one.
+ */
+static bool granularity_is_valid(int ways, int granularity)
+{
+	u16 eig;
+
+	if (ways <= 1)
+		return true;
+
+	return granularity_to_eig(granularity, &eig) == 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1449,7 +1463,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *iter = port;
-	u16 eig, peig;
 	u8 eiw, peiw;
 
 	/*
@@ -1522,12 +1535,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
+	if (!granularity_is_valid(parent_iw, parent_ig)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_ig);
-		return rc;
+		return -EINVAL;
 	}
 
 	rc = ways_to_eiw(parent_iw, &peiw);
@@ -1550,20 +1562,12 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	 * Interleave granularity is a multiple of @parent_port granularity.
 	 * Multiplier is the parent port interleave ways.
 	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
+	ig = parent_ig * parent_iw;
+	if (!granularity_is_valid(iw, ig)) {
 		dev_dbg(&cxlr->dev,
 			"%s: invalid granularity calculation (%d * %d)\n",
 			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
-
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
+		return -EINVAL;
 	}
 
 	if (iw > 8 || iw > cxlsd->nr_targets) {
-- 
2.37.3

