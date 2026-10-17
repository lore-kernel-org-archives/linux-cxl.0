Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756953A5449
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264812; cv=none; b=PYpoc7qgYoFbB94m3eWu12QBmytjJTXKAdl2dC57843m7YsDnjfmXf44jbwtAgxkKpuAJV80b1FdxweOv9vP4dP9CFcQFWG1049TGq4Zt0bzbJUc/P66n+2LKt8Biu7OS390iwKQMmg77M/KZ2TMH6+VZ3tr2Tnd9rgUSCGj+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264812; c=relaxed/simple;
	bh=ymR+04y2EwtWx2rbv774L4WjlSkRdOQHsZMDo3Gu2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqC3S1eCXi5GIj7qzWFN/NTfwgj3p8whCFlIbZvwynh9v/ZAeIAm+lbTJWK/2EysPIX7dIUMwaQ/5Sd98cJ834RS6ZRkuN5KpN7fVyN5V9uSRayX3V6Y4XJBevSueGmfd57/JeFANKwr2vtkAOMLjQGVypIFbMkii7j/g7e/MdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cudl9G8s; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cudl9G8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264810; x=1823800810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ymR+04y2EwtWx2rbv774L4WjlSkRdOQHsZMDo3Gu2mU=;
  b=cudl9G8s10ZnPWk/TxSlCRlw/zqozhBlMpxBQfEH6kJ2pLsnuDsGtfdo
   8KIlHa0ykX77BCEvLFZ4l2iKMbS1dKoivu1weft6Lf9s5/6it/PryT41y
   QI0/Gs3qvNZg2T8O5EoLEsrgOTbkJzN+PuR0PAfyl/1gxzYgnqjDYF04T
   eV/kyMBteOnmRTedMk8QTwUh+kFwDftBPwRPRFn3tDs9Sk4PJgQwXBv3W
   /MbsoA5hlz7MuW5vW7/Jf2FepaL6z7ktKROpqTXb6WKahDB/7+eYxCC2M
   Fwof19AJ+ELjaEwF/ib1nF3OlylxLG2mqlWUY/X5jssvuUSTVSMwAxkAH
   w==;
X-CSE-ConnectionGUID: PetPl4JNSgC5sCsqak5kcA==
X-CSE-MsgGUID: rKgx08qGRnOkcwiPJpoujw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034687"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:09 -0700
X-CSE-ConnectionGUID: QxH4Q60cSMGgTnu9Z8jCbQ==
X-CSE-MsgGUID: g6iTJewvSw2OyuvMdl0uYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282230"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 5/9] cxl/region: Factor out cxl_port_parent_interleave()
Date: Sat, 17 Oct 2026 12:19:50 -0700
Message-ID: <0529d454284e61e346e1e1860445fb4da3376fd9.1792263750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_switch_port_setup_targets() derives a decoder's interleave from the
interleave of the decoder above it. That parent interleave comes from
either the root decoder or a switch decoder, and each case is open coded
along with the parent validity checks.

Move the parent interleave lookup and validation to a new helper,
cxl_port_parent_interleave().

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 99 ++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8bfebe3e1025..cdf90fb6ea64 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1459,44 +1459,21 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	return distance;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
-					 struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+/*
+ * Get the parent interleave ways and granularity.
+ *
+ * For address bit routing, use power-of-2 math for switch ports.
+ * Root interleave ways of 3, 6, or 12 are normalized to 1, 2, or 4
+ * in @out_iw.
+ */
+static int cxl_port_parent_interleave(struct cxl_port *port,
+				      struct cxl_region *cxlr,
+				      int *out_iw, int *out_ig)
 {
-	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = &cxlsd->cxld;
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
-	if (cxl_rr->nr_targets_set) {
-		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
-			if (ep->dport == cxlsd->target[i]) {
-				int distance = cxl_port_peer_distance(port, cxlr);
-
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
@@ -1508,10 +1485,6 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 		 */
 		parent_ig = p->interleave_granularity;
 		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
-		/*
-		 * For purposes of address bit routing, use power-of-2 math for
-		 * switch ports.
-		 */
 		if (!is_power_of_2(parent_iw))
 			parent_iw /= 3;
 	} else {
@@ -1538,6 +1511,54 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 		return -EINVAL;
 	}
 
+	*out_iw = parent_iw;
+	*out_ig = parent_ig;
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
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
+	if (cxl_rr->nr_targets_set) {
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
+			if (ep->dport == cxlsd->target[i]) {
+				int distance = cxl_port_peer_distance(port, cxlr);
+
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
 	iw = cxl_rr->nr_targets;
 	if (!ways_valid(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-- 
2.37.3

