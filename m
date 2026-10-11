Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F23D2B1
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678036; cv=none; b=oqlB8PFYJ7JEMryIMXJIOz9Dw25ChzqzX0+DRoYTpd+JKfSocCaXFFTuwIbMUA2T4eQ+sQtPQKtPPDoWViIKjv0gmanrenwqyqqB9oZpx1w8G9v9cqo9zCtbva0w5eVey4uit+9X9jzL3XTomCAKiiwKqCb3FXZ2FkhTj6cpqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678036; c=relaxed/simple;
	bh=hzApZS9dh6k3RdwiprsCintBApQuqjVN84eZP4ZMkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxfIh6vFUaZ/e/8t5/Pi62pzMC52QgHbP1biHnC/4abajuAXj/8t5NhO2Lu0h8aJjlSuwzOXm33TKWmHwfa+l6z5mdRGq4rOuU529sKN+BkEUCIm7bfDudXbTDWB6RAeQ8bQcTDbl4PGSE/n2Pn54rCv+BBMnYDpA7eYiZ1rIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3QP+XKb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3QP+XKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678034; x=1823214034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzApZS9dh6k3RdwiprsCintBApQuqjVN84eZP4ZMkUE=;
  b=I3QP+XKboR5eESDq+bJfp1SgHuCK9Qo6+b1CbZlBffGDebvWS96BwHEc
   r5YLMczL0wAcgI9I3W+/Ifi6pXeWrgoeAenxc85XDV+/MHGs27kFn5crg
   jFcd6yCEI4DPSZIjJPBy2PzaN17EXHQGJrBjFdqVHazhAbbBG6zKWOeje
   E0Q3/rkghr+ulIzP/GqM/HcISOhIKBs207rCksZ3QfVWKsqQCX0CxWL/A
   JInepnffJRrtnrHRgcIVSQ04Ix50y6h3lKbYB94OKIA3RoLOCHBWCRdtA
   MzsXaMpL0layQQ4lLZ4klgloVS4TpjAB6/wJb0L9R5D+9+DmvVMAmdShI
   g==;
X-CSE-ConnectionGUID: 7n2rOZQJS56bACh5JctGEA==
X-CSE-MsgGUID: ldYQ56a5R8W3UY9Sneo50A==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459346"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:34 -0700
X-CSE-ConnectionGUID: ZBnjMnEHTnKLiU7NZY/9eA==
X-CSE-MsgGUID: zLYELiaMQUi16/pbqZNcnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679065"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:33 -0700
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
Subject: [PATCH v2 6/8] cxl/region: Factor out cxl_port_calc_interleave()
Date: Sat, 10 Oct 2026 17:20:21 -0700
Message-ID: <d8e445773534f0f9472dcdb6feba31c27c9699b4.1791676454.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_switch_port_setup_targets() calculates the interleave ways and
granularity of a port's decoder from the parent interleave and the number
of targets below the port, then validates the result. That calculation and
its checks are open coded between the target search and the decoder setup.

Move the calculation and its checks to a new helper,
cxl_port_calc_interleave(), so that the interleave for the port's decoder
is calculated and validated in one place.

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a4688c6b54cb..42daa69a40eb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1513,11 +1513,58 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
 	return 0;
 }
 
+static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cxlr,
+				    struct cxl_region_ref *cxl_rr, int *iw, int *ig)
+{
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int parent_iw, parent_ig, child_iw, child_ig, rc;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	struct cxl_switch_decoder *cxlsd;
+
+	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	if (rc)
+		return rc;
+
+	child_iw = cxl_rr->nr_targets;
+	if (!ways_valid(child_iw)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			child_iw);
+		return -EINVAL;
+	}
+
+	/*
+	 * Interleave granularity is a multiple of @parent_port granularity.
+	 * Multiplier is the parent port interleave ways.
+	 */
+	child_ig = parent_ig * parent_iw;
+
+	if (!granularity_valid(child_ig)) {
+		dev_dbg(&cxlr->dev,
+			"%s: invalid granularity calculation (%d * %d)\n",
+			dev_name(&parent_port->dev), parent_ig, parent_iw);
+		return -EINVAL;
+	}
+
+	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
+	*iw = child_iw;
+	*ig = child_ig;
+
+	return 0;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
 {
-	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
@@ -1551,38 +1598,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 		goto add_target;
 	}
 
-	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
 	if (rc)
 		return rc;
 
-	child_iw = cxl_rr->nr_targets;
-	if (!ways_valid(child_iw)) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
-		return -EINVAL;
-	}
-
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	child_ig = parent_ig * parent_iw;
-
-	if (!granularity_valid(child_ig)) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return -EINVAL;
-	}
-
-	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s:%s: ways: %d overflows targets: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
-		return -ENXIO;
-	}
-
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != child_iw ||
 		    (child_iw > 1 && cxld->interleave_granularity != child_ig) ||
-- 
2.37.3

