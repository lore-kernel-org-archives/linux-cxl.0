Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443D390CA9
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577493; cv=none; b=GhLXRLjqyc7dtBrnDr8MXqXXD85JVWk1WNO9m3gFXT8ieT9ncyR+JulME3m8Ub8Gbg+ebYZLTFCCa9kCyfPMpbwoft6w5uos0Cb331u/OQuTlbL2wkgWReFNAo42LZqMmwqSSGky8Z/hQmEBGwYTvA+IHvZ+JICBcIBfW9CQma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577493; c=relaxed/simple;
	bh=u7eY3F143jGpcAL0vjKwbUokXHH06fXqrtdd6z0tdao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWbX5ceHFihCR6XeELygEaxEf/h0bQQnhtQv0sB+UJnLnmcQpLTDEP/GxsHsgy4iFr6niMfb6k5zrJsox0CeyiwnqDvr1G3eMqTPxMmnUJ1Luglkn5Fwhx5oSkXN/PNkRBGkDgojeDyjo8qEDiL1b8MnSrTK+g9pBlvDdm9ZsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGHg1BVg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGHg1BVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577493; x=1823113493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7eY3F143jGpcAL0vjKwbUokXHH06fXqrtdd6z0tdao=;
  b=PGHg1BVgwEZWyMKjW66h+/vWmHzUY7qkdXoGdDlUo2ZGZfFG3UM0p45C
   IadVc0EljGKapck0n+q543ESjYukF2M6I1gUp1Wy97C8391AcoR/yKeDC
   e4tU9VdrFkUUypvDr91bd/kkXdkZiwz1CipeQrB0SZJiTguojdZyhPds8
   Ptya7oeffRMt9Ih3PNueKcqjwpGjDbSWV8l3bBYWAAPBiMl2i2/nAIG/w
   F/i1FUv9OeBAIku9zXjsqNXGifJXENxTUI1VkRUga0Z+Iy+YwVNzT3XZn
   UYmy9QIZ/HlMv0DAJYHTPRaYP/QhKpA1CX1YeT1t7m5Or/PZQkaHe6wBG
   w==;
X-CSE-ConnectionGUID: so/28JMLTlW2HdUtt7TfeQ==
X-CSE-MsgGUID: OLdeBg+fQgyenBRrYS2ozg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="377033"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="377033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:44 -0700
X-CSE-ConnectionGUID: i0nhxcIEQ0mRdIXigX83ag==
X-CSE-MsgGUID: pprhiBF0T9aQHQSkV2O5bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743034"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:42 -0700
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
Subject: [PATCH 6/7] cxl/region: Factor out cxl_port_setup_decoder()
Date: Fri,  9 Oct 2026 13:24:06 -0700
Message-ID: <0ded5beebbcf283885a0e5876dc7d8dd758827a2.1791575481.git.alison.schofield@intel.com>
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

Once cxl_port_setup_targets() has calculated the interleave for a port's
decoder, it either checks that interleave against the decoder settings
found for an auto region, or checks the decoder's interleave capabilities
and programs the decoder for a user created region. Both paths are open
coded in cxl_port_setup_targets().

Move both paths to a new helper, cxl_port_setup_decoder().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 43f1ffbe64c0..4e9b0880663d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 	return 0;
 }
 
-static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled)
+static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_decoder *cxld, int child_iw, int child_ig)
 {
-	int child_iw, child_ig, rc, pos = cxled->pos;
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
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
-	if (rc)
-		return rc;
+	int rc;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != child_iw ||
@@ -1639,6 +1604,53 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
 	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
 		dev_name(&port->dev), child_iw, child_ig);
+
+	return 0;
+}
+
+static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled)
+{
+	int child_iw, child_ig, rc, pos = cxled->pos;
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
+	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
+	if (rc)
+		return rc;
+
+	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
+	if (rc)
+		return rc;
 add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
-- 
2.37.3

