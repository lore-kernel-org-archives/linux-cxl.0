Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA547F3A5
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865577; cv=none; b=RMZlhUSd8YpAahMMOzBIyvCzxISRbK/NgpZkdtYv1L6KboS32wcPhNsxEYFCylnFRTIeng0Zoo41Mhx0v1TLznHyrkdxQbPnvAV5LSAlkTLCQ4xXyHdc3XY/iYQ2B3QSYfg4+a6s6OkeyajVCF4R58JRdMagL0FpxPJsacjqbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865577; c=relaxed/simple;
	bh=1glTCfZrqSgwOy9qbyQUYhH3JJxGDyHt6Q2o01pVP5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow/sC+T6/Y8ErwxMnVyFMPVSENrSOTLcsdE61fxlsBFjBNLzBIUzfzDsJ+j+WZ76GgZwYwMUOn84J80Wa8OEYdigf7p40zHy7Z/kLC9APdcnLUCMAf3ORLpPM7fDDT0kUWeg7rnwSfkbOOGQORVlUnb2cQMgusA+Gf3kyzEkAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTpda9se; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTpda9se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865576; x=1823401576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1glTCfZrqSgwOy9qbyQUYhH3JJxGDyHt6Q2o01pVP5E=;
  b=OTpda9selbmdvfxLaj+FNAnVKrk6+gNxZAlB94wayF2kMi1skhmUvHBc
   lvOq+zENQ6vulCHgVr2OhBn2wbXOG/CkdiKjlV0Caqp8zIOisf/pYsNV7
   yDqh2xTUwjHZtAcR5OgTdCsZhgTtSkMi+10Cb9lhDWSyUx1tD+Zmk5im/
   3+o9E8rCO10lczwvv+n8FSyOwNPoLvEBaXlfx1tzcX60Ba0qO/biRbjWO
   Pr+a6EmlI5o0bd1i9YyI4SKD/hYCAwkVztNG5ZcZiOoD15QqdBVL03z0Z
   Tn3goO0VCCw7B7e3cPE28N1ATsen/WfZ7zj+te/khZYsDsSfCx2jeKS5A
   A==;
X-CSE-ConnectionGUID: ZgIHMT76SqO9mj3DVp+zxA==
X-CSE-MsgGUID: 0rRoup7eQOS3dKkNOndxNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455495"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:16 -0700
X-CSE-ConnectionGUID: s/MfqiFASPmxC1LhB5A9Fg==
X-CSE-MsgGUID: 9OMG/1UyRfaS0+jPtihZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391106"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 7/7] cxl/region: Factor out cxl_switch_port_add_target()
Date: Mon, 12 Oct 2026 21:26:03 -0700
Message-ID: <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
port's decoder target list. For an auto region it checks that the decoder
already targets that downstream port at the next position. For a user
created region it programs the downstream port at that position. That step
is open coded behind an add_target label that the target search jumps to.

Move that step to a new helper, cxl_switch_port_add_target(). The helper
takes the switch decoder whose target list it updates, rather than the
port, which makes its scope explicit. With the decoder setup and the
target add now in helpers, the path for the first endpoint to reach a port
becomes an else branch of the target search, so the add_target label is
no longer needed.

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 229372123271..50f4830c225d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
 	return 0;
 }
 
+static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
+				      struct cxl_region *cxlr,
+				      struct cxl_region_ref *cxl_rr,
+				      struct cxl_endpoint_decoder *cxled,
+				      struct cxl_ep *ep)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxl_rr->port;
+	int pos = cxled->pos;
+
+	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: targets full trying to add %s:%s at %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
+		return -ENXIO;
+	}
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
+			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				dev_name(&cxlsd->cxld.dev),
+				dev_name(ep->dport->dport_dev),
+				cxl_rr->nr_targets_set);
+			return -ENXIO;
+		}
+	} else {
+		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
+		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
+	}
+	cxl_rr->nr_targets_set++;
+
+	return 0;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
 {
-	int iw, ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	int rc, pos = cxled->pos;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1641,38 +1676,21 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 					return rc;
 				goto out_target_set;
 			}
-		goto add_target;
-	}
-
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
-	if (rc)
-		return rc;
-
-	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
-	if (rc)
-		return rc;
-add_target:
-	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s: targets full trying to add %s:%s at %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
-		return -ENXIO;
-	}
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
-			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
-				dev_name(port->uport_dev), dev_name(&port->dev),
-				dev_name(&cxlsd->cxld.dev),
-				dev_name(ep->dport->dport_dev),
-				cxl_rr->nr_targets_set);
-			return -ENXIO;
-		}
 	} else {
-		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
-		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
+		int iw, ig;
+
+		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
+		if (rc)
+			return rc;
+
+		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
+		if (rc)
+			return rc;
 	}
-	cxl_rr->nr_targets_set++;
+
+	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
+	if (rc)
+		return rc;
 out_target_set:
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
-- 
2.37.3

