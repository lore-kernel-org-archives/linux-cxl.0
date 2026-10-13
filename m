Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24147DF8E
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865575; cv=none; b=Plwzuoq1DstkSqrsVuS5F3Ts67Bs8xo7Wkqdga88eulqTS04eIMM3ou+LySw4f6RTvzo/nacAKTqZmF2iA9BfAK58BRi4W7WBBfk4tKoDef7+nD1wNapXXY2FKuYNi8do7TXVAHNalTSTj+3BZgH30Crqx2gliDt80gMt0M0cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865575; c=relaxed/simple;
	bh=D0v49bJT2ALTuPgWEkwf1xY6FK5qdJwl3b7yzQUZMNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvI610ogm+SBuqjIt5XH0jIXImm0YCAXUWy+TroBI4CBmxSGWhuvs2clPfRDrWSKD3s1XitiXb+RDCKOUbZliW//oSU67s4CQ6Sx0UXWQc3rHz05PuujP2m5ul9uSKytUivyuOUMi0/2oYzTMq8L15L5X3NqZTu9GP1Z/h1GYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCXtIzOc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCXtIzOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865575; x=1823401575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0v49bJT2ALTuPgWEkwf1xY6FK5qdJwl3b7yzQUZMNA=;
  b=hCXtIzOcF+tdNJwTWamBPp5t8B5n1tqnMBFygRqUjqr+tOyK8njQ4PVd
   EuIMHlHSgvZlO7tX0V+hK30Z4XEQ1ZrFub5qq5e+Y4oFMA6BCpsaK1Vv7
   FNe7kS8QCOdI8Kz1YIWNxsalr5ejsy/ik7tLpgCACYItKf9acGCUPtRAx
   DvXSEVE99htqPbHgNainF5CmXhFxoxzhkSS6Sk99YS1qISf0K7Bxlz+B2
   AhIwBkx5Gj6b0cnExwn7tllWG3ynGhn6wkAWJ4n10JC6FpUm1WSHj6Fzh
   ZaGOc09jDtpw7BHMzkDcmqAcZcKHGgdOcO7WZAZVgUQedWsEJPD1e6zEe
   Q==;
X-CSE-ConnectionGUID: 4d19N4iTTpa82joeIIc/Ug==
X-CSE-MsgGUID: ZfRf4saSTC2AWhndquqPcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455492"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455492"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:15 -0700
X-CSE-ConnectionGUID: xLrd4vqXT0WWeZ+r4jrTlg==
X-CSE-MsgGUID: skj6nnrXQ3iywuAp6+E+ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391103"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:14 -0700
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
Subject: [PATCH v3 6/7] cxl/region: Factor out cxl_port_setup_decoder()
Date: Mon, 12 Oct 2026 21:26:02 -0700
Message-ID: <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
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

Once cxl_switch_port_setup_targets() has calculated the interleave for a
port's decoder, it either checks that interleave against the decoder
settings found for an auto region, or checks the decoder's interleave
capabilities and programs the decoder for a user created region. Both paths
are open coded in cxl_switch_port_setup_targets().

Move both paths to a new helper, cxl_port_setup_decoder().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ee9e615a9a4c..229372123271 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 	return 0;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_decoder *cxld, int iw, int ig)
 {
-	int iw, ig, rc, pos = cxled->pos;
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
-
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
-	if (rc)
-		return rc;
+	int rc;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
@@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
 		dev_name(&port->dev), iw, ig);
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	int iw, ig, rc, pos = cxled->pos;
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
+	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
+	if (rc)
+		return rc;
+
+	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
+	if (rc)
+		return rc;
 add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
-- 
2.37.3

