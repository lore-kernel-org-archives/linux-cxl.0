Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4A4FC351
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577484; cv=none; b=HN8vOR5ZXpkxCzRc510ay3XD+dP0QjZHd+d0AP3XmDZNbtQoNnZubJL90bX6CBScqKWhS9E2hffW3OL8rt+4yYW0WS/HE4aam8RsWxsXjTWjjyt4cj7bAUARrqUPq2IIXHCRZSCcnKUxFQvX2sLy7eSt3C2yCJwJhUDstatgmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577484; c=relaxed/simple;
	bh=d2EtfEmqRF5KWFRBQNk5RksO95wTEjzO0ThqfzBwR4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO8lO5/TRqEQ0W14vBIkwSxQHNgdjo23FA4UK122tw0A7iyC++HbhF6X6AY1tYOyl3MP7PqRfTOnEsi8+1SE8ZNmPONV6Gsfas+X8BTWfxamDFgmfVHkHGtFFMwSaDpJC3TuyhcGu8dLgsYgaVn7P0QRFmo670BKf2OsjeeB/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Csjlggme; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Csjlggme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577483; x=1823113483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d2EtfEmqRF5KWFRBQNk5RksO95wTEjzO0ThqfzBwR4k=;
  b=CsjlggmeSDi+rBZR7qqmLAyYBJHBzWZH0dcsdUXrU7vTfQM1Ab/W7KoR
   wgsEONQ5ZJmKH0zVKCh5Iv0/phuT/az1NS6VPUTfM7LFgA0meUdRlckCB
   38GwIG9dpJF7V/MO8FTO10dwO6gw1eqZGtcNlFc4rYX5h4TVUpNTvszfT
   wp+3hHSfxbF4k02WPZyDcOng2U/SELdHgMx+zzQRJR1cvZZpJjvdahpxx
   Hjo17SlMmmWoyv2k7nNLpYm3V2XDqHk76SYqxX0KX7mImb63ZmqVN04NO
   k6U5OU8SY/BswnHifcPbXU6M+f4J+Nk1cwbmjdjjVl6iDuG1xBa7WfSHd
   w==;
X-CSE-ConnectionGUID: gekerN8eTwiVlUABa2Og+A==
X-CSE-MsgGUID: 07vO7DBeRbqDM7wQaWCqVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="376951"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="376951"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:40 -0700
X-CSE-ConnectionGUID: JJXSAiTFSD2Aek4EOH1itg==
X-CSE-MsgGUID: p/yzYsoqRSu0yrONifgQXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743020"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:39 -0700
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
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 2/7] cxl/region: Name the interleave locals in cxl_port_setup_targets()
Date: Fri,  9 Oct 2026 13:24:02 -0700
Message-ID: <c3ed0302abf8206225d2482caa63bbb1dd0b9a07.1791575481.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bc087ca63946..1a42753fda48 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1437,7 +1437,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1531,10 +1531,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -EINVAL;
 	}
 
-	iw = cxl_rr->nr_targets;
-	if (!ways_valid(iw)) {
+	child_iw = cxl_rr->nr_targets;
+	if (!ways_valid(child_iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
+			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
 		return -EINVAL;
 	}
 
@@ -1542,32 +1542,32 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	 * Interleave granularity is a multiple of @parent_port granularity.
 	 * Multiplier is the parent port interleave ways.
 	 */
-	ig = parent_ig * parent_iw;
+	child_ig = parent_ig * parent_iw;
 
-	if (!granularity_valid(ig)) {
+	if (!granularity_valid(child_ig)) {
 		dev_dbg(&cxlr->dev,
 			"%s: invalid granularity calculation (%d * %d)\n",
 			dev_name(&parent_port->dev), parent_ig, parent_iw);
 		return -EINVAL;
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
@@ -1578,24 +1578,24 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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

