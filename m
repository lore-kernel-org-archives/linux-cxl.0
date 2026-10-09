Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295B390CA9
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577484; cv=none; b=jxHGo7vDEoN4JJrcNWHIbWP/rZ6jqDeJ1zgz8n/S+3JGFd39GCQc1rOigNglwCDG3SMKNtFDeT3hFKoNyADGBei7emPzC4JTjdBtL12gvgYb4XfXclWvECgHm/mt2uM3S/ervlPplsSjz49VZ/O1i3Z072HPQJki6f/1FWKROh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577484; c=relaxed/simple;
	bh=M4yScbnda4rxAJaRcNNQ3dFV5WIWlCuD6UdvbW3/xKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5mB1w6ChfB6p9UYzYarb7VG2UPDSHqfzfiu6x0ct8Rf1AxnMNdh5mlbTZPVu8DHCdPsPg7+QklFrKMOKfEtlWwcvpPesku181V3nqf5OdrknMXHyPHy24//udgSVFnT1d3zgH2mVN5w2FzrHNHGvQChpeoysNTtABj7+Q1zaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS4JIV6k; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS4JIV6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577484; x=1823113484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4yScbnda4rxAJaRcNNQ3dFV5WIWlCuD6UdvbW3/xKA=;
  b=VS4JIV6kC3m88p83R0m8IrtUjyP8CZb639Vz0UClHWiyrw1956ImBOtE
   HJmuF5J4FP6da1exAHMl+oqwtTwRFUTmPo99lSb0lHq7vvsapvuEHWT06
   2L9CkWIXNj3NrClYFLtbFl78gZ17+fUZjvHxAh839U//EKJfGzKgUAMwY
   4ZXXKTDQLia0fmJknZUYkCfDOiIh1CrIyBZ6ul7vJczYfupbfQdULGV3K
   XDorMUO3kEiMcqydcKbEDaKnpr0zLoTNf1W1milfwCN879jKle9tAHQ+Z
   FRGMEdYhaBUSnPAquk/Upv8xQ21WRIwUWDXu01w6VEEJvanU1DDGwnQdL
   g==;
X-CSE-ConnectionGUID: NXD0BKCvRJuWfyzWjVhyHg==
X-CSE-MsgGUID: mX3FzuDsQC2K1G+2PvBsgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="376976"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="376976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:42 -0700
X-CSE-ConnectionGUID: n5p7jgbdSXiohk0emLCobg==
X-CSE-MsgGUID: pnfp+RlIRq60PdP+BjsH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743026"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:41 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 4/7] cxl/region: Factor out cxl_port_parent_interleave()
Date: Fri,  9 Oct 2026 13:24:04 -0700
Message-ID: <e0d73b783d15ef9bc39481934c86bd915be9c98f.1791575481.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791575481.git.alison.schofield@intel.com>
References: <cover.1791575481.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() derives a decoder's interleave from the interleave
of the decoder above it. That parent interleave comes from either the root
decoder or a switch decoder, and each case is open coded along with the
parent validity checks.

Move the parent interleave lookup and validation to a new helper,
cxl_port_parent_interleave().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 80c40716c368..c1866b7b089b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	return distance;
 }
 
-static int cxl_port_setup_targets(struct cxl_port *port,
-				  struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled)
+static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
+				      int *iw, int *ig)
 {
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
-
-	/*
-	 * While root level decoders support x3, x6, x12, switch level
-	 * decoders only support powers of 2 up to x16.
-	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
-		return -EINVAL;
-	}
-
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
-	if (cxl_rr->nr_targets_set) {
-		int distance = cxl_port_peer_distance(port, cxlr);
-
-		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
-			if (ep->dport == cxlsd->target[i]) {
-				rc = check_last_peer(cxled, ep, cxl_rr,
-						     distance);
-				if (rc)
-					return rc;
-				goto out_target_set;
-			}
-		goto add_target;
-	}
+	int parent_iw, parent_ig;
 
 	if (is_cxl_root(parent_port)) {
 		/*
@@ -1539,6 +1507,54 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -EINVAL;
 	}
 
+	*iw = parent_iw;
+	*ig = parent_ig;
+
+	return 0;
+}
+
+static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled)
+{
+	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	struct cxl_switch_decoder *cxlsd;
+
+	/*
+	 * While root level decoders support x3, x6, x12, switch level
+	 * decoders only support powers of 2 up to x16.
+	 */
+	if (!is_power_of_2(cxl_rr->nr_targets)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			cxl_rr->nr_targets);
+		return -EINVAL;
+	}
+
+	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (cxl_rr->nr_targets_set) {
+		int distance = cxl_port_peer_distance(port, cxlr);
+
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
+			if (ep->dport == cxlsd->target[i]) {
+				rc = check_last_peer(cxled, ep, cxl_rr,
+						     distance);
+				if (rc)
+					return rc;
+				goto out_target_set;
+			}
+		goto add_target;
+	}
+
+	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	if (rc)
+		return rc;
+
 	child_iw = cxl_rr->nr_targets;
 	if (!ways_valid(child_iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-- 
2.37.3

