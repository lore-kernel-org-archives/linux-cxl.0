Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4F472F7D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865574; cv=none; b=dSvd1j0WLZx9LbkmAUImzhYnwvt1ocIP9Jd8SNDMkmiKNePbBsV2ZsNpcdIqK0w3S9k7Gehad487Xkzl2rmlN64RF/Rz2fbBf8IENzUamYZDXJJNEGBoGvaycASMZNDDPC4yjOBuWytzdTzG8rY6OBOFyH/T2k38fmCD04NtrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865574; c=relaxed/simple;
	bh=V5Z7phAqQRogi5v8VDpUlfNPRWtH+w5457aL8Ugm45w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEBPHEZG3Ibibyqo2cdWCFLZV4ZUN/moblK4MzsBDMfsyQQVOZLM7puLDLz40ZLLtGBNMeKHr4hu/ZTozMsC9wLC4gaeOnysOK3lC66IKgxdU+CHXMSqSh7lamm9ZxJQGRNxeBFMMy4EhvwjavK/C0O13E2Ai2PVrExWjpbs1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxCMi2cQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxCMi2cQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865574; x=1823401574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5Z7phAqQRogi5v8VDpUlfNPRWtH+w5457aL8Ugm45w=;
  b=YxCMi2cQNXks/34FIxrBh7d4b+QoqqhkU061zhfp4eg2v4M5T/BO1yiW
   POiCpzUdRfN+iyj9bClJx4C3ZNPcQbqN3LtRAW8CePOZIJpRF44SHKOYR
   +Ll0KxT0Q2zfj6yDCzzg8hHkK+MxoG/f+XsS77VyAhnfERpmE1AlItfdz
   LRCkkfiHgSmA/NqtWb0TPUMaQIVj69WWkGa770+5RhDmgfbZkaUZTh+h6
   swpmGSjAVOt32W0tDrfRKf7I2fHeabsn/yRahzRwzIstInDV/yxwHFs4R
   0043pJ5nZtPYF8r8M5SnKW7Zg2Rf2b3UE9jZDQXNrfpn3QnLLvDXVA4e/
   Q==;
X-CSE-ConnectionGUID: Y5VRuieST9KII3atMGidNg==
X-CSE-MsgGUID: vru2fPr9T9SMXCtohBR8UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455489"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455489"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:14 -0700
X-CSE-ConnectionGUID: tS/VAD6RTq6tQf0BPSsTuA==
X-CSE-MsgGUID: Who87tW1SzWmhNoKknlOFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391093"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:13 -0700
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
Subject: [PATCH v3 5/7] cxl/region: Factor out cxl_port_calc_interleave()
Date: Mon, 12 Oct 2026 21:26:01 -0700
Message-ID: <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
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
index c14ac041c4ac..ee9e615a9a4c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1513,11 +1513,58 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
 	return 0;
 }
 
+static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cxlr,
+				    struct cxl_region_ref *cxl_rr, int *out_iw,
+				    int *out_ig)
+{
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	int parent_iw, parent_ig, iw, ig, rc;
+	struct cxl_switch_decoder *cxlsd;
+
+	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	if (rc)
+		return rc;
+
+	iw = cxl_rr->nr_targets;
+	if (!ways_valid(iw)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
+		return -EINVAL;
+	}
+
+	/*
+	 * Interleave granularity is a multiple of @parent_port granularity.
+	 * Multiplier is the parent port interleave ways.
+	 */
+	ig = parent_ig * parent_iw;
+
+	if (!granularity_valid(ig)) {
+		dev_dbg(&cxlr->dev,
+			"%s: invalid granularity calculation (%d * %d)\n",
+			dev_name(&parent_port->dev), parent_ig, parent_iw);
+		return -EINVAL;
+	}
+
+	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
+
+	*out_iw = iw;
+	*out_ig = ig;
+
+	return 0;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
 {
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int iw, ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
@@ -1551,38 +1598,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 		goto add_target;
 	}
 
-	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
 	if (rc)
 		return rc;
 
-	iw = cxl_rr->nr_targets;
-	if (!ways_valid(iw)) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return -EINVAL;
-	}
-
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	ig = parent_ig * parent_iw;
-
-	if (!granularity_valid(ig)) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return -EINVAL;
-	}
-
-	if (iw > 8 || iw > cxlsd->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s:%s: ways: %d overflows targets: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
-		return -ENXIO;
-	}
-
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    (iw > 1 && cxld->interleave_granularity != ig) ||
-- 
2.37.3

