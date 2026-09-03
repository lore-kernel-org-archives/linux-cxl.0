Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADA35C19F
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477853; cv=none; b=YINR+JyyhQvHR+MRRS/5K4ggfrAvEJBe2Az/rpATIiAvUHdrkVx+ZbNLEYu/zd8JriGlIp/2CocuYs0LighGY9NO7vK+Vwtv1z66HWRyQISE65Hv2hw2R7jsYUjE9F3XmCxmUQwgxs2ixYO/X4jFbdIxwY7yDIedo1XHxRp9uPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477853; c=relaxed/simple;
	bh=IKy4CYLOmI5lNByTQQfx5bwuZPtAePuUW51PuhZNtHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0SpTOa7ZhLs6VD7J/M8fMfJd1Ueq8Gs/OnaNbn7wae8K+SK+kZlMtq8YfUUiwFUEBaRk5UBY1ZW11ZmUfrOBedLFkDE4KbtvBKCJUy0F2uIc6zEBiyr93wrh2d6KFRQxOP57lp5tCmaQ/Wk9JPs/hxhBrBEt/9H1GNPfm6LJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMbSwVGw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMbSwVGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477851; x=1820013851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKy4CYLOmI5lNByTQQfx5bwuZPtAePuUW51PuhZNtHk=;
  b=mMbSwVGwjCqykx/WJISP5RfpDJUkGjFNwKCmNn8dBY2JRR57ztzlEP7F
   OSG+ZM5IN7Z79RcPHl7j6bM96xt8LYLuYPJPYtXCndRQr6A3UAdsRy3py
   MMK6sstzUm8Oko8ruMATAtf8hCr3Jo0uNTpGNgdsYhcDoZCnrhH0loYWG
   KC/k+mp2YSeyt5W1YixtlzJo5AnqRQUR9hbdRjOefdqgGSTCLR37mdEAB
   NdDYe460//s7omKna5FXrLAYsUEH93Lpu1fVucj0HJTYXjJGKyz3WIMSD
   SyWmL7NBOlmhaxjCu1QkNxqr/8eQf53ESzMBBQPP95kGY1UBo2w9/ia1a
   g==;
X-CSE-ConnectionGUID: QtgoMNWWSdedGAmTm1bhSw==
X-CSE-MsgGUID: eGFBE9W4Rbm9IbeAvM06vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847683"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:11 -0700
X-CSE-ConnectionGUID: 97Km2EnQQfC+TPm5Y2z+dQ==
X-CSE-MsgGUID: HJ4sqo4TTWiqtIMbxCT3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129497"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 4/7] cxl/region: Name the interleave locals in cxl_port_setup_targets()
Date: Thu,  3 Sep 2026 16:23:46 -0700
Message-ID: <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() derives the interleave granularity of one decoder
from the granularity and ways of the decoder above it, and takes that
decoder's own ways from the topology below it. The values from the level
above are named parent_iw and parent_ig, but the values being derived are
the bare iw and ig, so the reader has to work out which level each one
describes.

Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
for the level above.

No functional change.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 506b1cba1a92..116f84bb0745 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1440,7 +1440,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1538,11 +1538,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	iw = cxl_rr->nr_targets;
-	rc = ways_to_eiw(iw, &eiw);
+	child_iw = cxl_rr->nr_targets;
+	rc = ways_to_eiw(child_iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
+			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
 		return rc;
 	}
 
@@ -1558,7 +1558,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	rc = eig_to_granularity(eig, &ig);
+	rc = eig_to_granularity(eig, &child_ig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
 			dev_name(port->uport_dev), dev_name(&port->dev),
@@ -1566,23 +1566,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	if (iw > 8 || iw > cxlsd->nr_targets) {
+	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s:%s: ways: %d overflows targets: %d\n",
 			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
 		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
+		if (cxld->interleave_ways != child_iw ||
+		    (child_iw > 1 && cxld->interleave_granularity != child_ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
-				__func__, iw, ig, p->res);
+				__func__, child_iw, child_ig, p->res);
 			dev_err(&cxlr->dev,
 				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
@@ -1593,24 +1593,24 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			return -ENXIO;
 		}
 	} else {
-		rc = check_interleave_cap(cxld, iw, ig);
+		rc = check_interleave_cap(cxld, child_iw, child_ig);
 		if (rc) {
 			dev_dbg(&cxlr->dev,
 				"%s:%s iw: %d ig: %d is not supported\n",
 				dev_name(port->uport_dev),
-				dev_name(&port->dev), iw, ig);
+				dev_name(&port->dev), child_iw, child_ig);
 			return rc;
 		}
 
-		cxld->interleave_ways = iw;
-		cxld->interleave_granularity = ig;
+		cxld->interleave_ways = child_iw;
+		cxld->interleave_granularity = child_ig;
 		cxld->hpa_range = (struct range) {
 			.start = p->res->start,
 			.end = p->res->end,
 		};
 	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
-		dev_name(&port->dev), iw, ig);
+		dev_name(&port->dev), child_iw, child_ig);
 add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
-- 
2.37.3

