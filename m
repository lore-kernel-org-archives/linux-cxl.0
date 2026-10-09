Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF84F7CA2
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577490; cv=none; b=ExkzdZ4zomuUv7s9xtyvEQy8rsUHQ75rWDhlQ19hRX4JDdkdzZowY1/pwxKDXq00FoEZxfSUfQ/NNV0RwfSjPQpnzeXXJirnbjOjyolRrXx/rNjw2Jlt/ezJdh2xXdvtr9jYFQKY+fbP19dVnFLOA+LFkKCop3H03AwLPtPUEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577490; c=relaxed/simple;
	bh=5F06TQHdrfOtRIv8fNqPaoahbjPn7SwPXIMZB76DyFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqamuxcWB9NglF4OKt8toaGQT++hNcrirUkNgiibKwNxaxNFGALuJQncdVV4+TfSL2GNm14KCG32FWdUxvwsfuAxlioadS4JBq7suDqUhQeqD+PknHn3G/vUXHEt2AeD8A/r/xvM/HLJVmIBXPAVGwRA42M0x7YdQVfc0DzLV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7d6bmgX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7d6bmgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577490; x=1823113490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5F06TQHdrfOtRIv8fNqPaoahbjPn7SwPXIMZB76DyFU=;
  b=m7d6bmgXu5u0VnhWF18Mlx8dRGtJbECrKJm1Qc7t7LwUFp3gRN0Ecgsg
   5XQgCx7urrffVNycaoIIkfC6/JJKcNL/cw6alRKsZppYweIZufMclwXLf
   Km18XKf6LEowSjRDqPM9bax60PW4PX0ltSLMEXcK1ovqKx/OEQSDdVzAY
   ANqsAGjvciHOYF35cR+WdfIGQCrrf7COPFTWi/SAwR0PThhRDTWyULGFP
   8Yt0D7ZW2O3oRcxQr4LdXBAPpPHU+ZVidK2Y2FRsX/m5RoCCz326T3mG7
   nSs2QZu0ar/xXJ3NB6KPfRk30v0N7ggZI4cmBla6iyOkP9qUwaUk/50lj
   g==;
X-CSE-ConnectionGUID: /j8aHuI1QKmE7W987pvTJA==
X-CSE-MsgGUID: X5mP/+PUQl6kjQSt3Gv4Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="377003"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="377003"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:43 -0700
X-CSE-ConnectionGUID: GgWRDTBqQsCvkt9LdHjYTg==
X-CSE-MsgGUID: aJ6V9iDGSTi01wJE8dtDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743030"
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
Subject: [PATCH 5/7] cxl/region: Factor out cxl_port_calc_interleave()
Date: Fri,  9 Oct 2026 13:24:05 -0700
Message-ID: <107a6e3685ecfd9287bf8983b999281e6e2716d2.1791575481.git.alison.schofield@intel.com>
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

cxl_port_setup_targets() calculates the interleave ways and granularity of
a port's decoder from the parent interleave and the number of targets below
the port, then validates the result. That calculation and its checks are
open coded between the target search and the decoder setup.

Move the calculation and its checks to a new helper,
cxl_port_calc_interleave(), so that the interleave for the port's decoder
is calculated and validated in one place.

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c1866b7b089b..43f1ffbe64c0 100644
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
 static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
@@ -1551,38 +1598,10 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
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

