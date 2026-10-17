Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6C3C09E0
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265349; cv=none; b=TPlsVGZfgSR+/BrR3u6A5fOT9uUnO87ricFI8+R+BxfTd8GZ5rF9Y+5Z9TIW1XeustFMhdF/wWfifGIPvLrVxoerRU7NCq9l10ydrGjdw5baqIpN0pQB7l0ZPCzrlOtMy+1GEF3NLliQ3PXztbeYAB32AwwrOaDBhOVkKuxXI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265349; c=relaxed/simple;
	bh=NoVfHk57W+5PZ7pdLcq+lXu8jJ5my+RAaSw2wAc0T94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZKmxt8uOdB+vZHIxPxGOx0qRb9Lc0jRQw9bAvqt4UI7s2x9pVkTYqCJF/Gk1BfvGZasvURORMyO2pox2p1YUEt7IpNwv50BfQdfOq9zr5IFA0T50JlExLkEBKvqkSpbgteTi+VmTKkeWC8PuOD+F9Y+k5ONz7KX98iTed3Ilvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbIp/r6E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbIp/r6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792265343; x=1823801343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoVfHk57W+5PZ7pdLcq+lXu8jJ5my+RAaSw2wAc0T94=;
  b=bbIp/r6E/OEvD4C6ThYTbpDLVvWjM5eOu4bgYzCwhGeV6DTyZOO1ihfB
   RqRd8g7p27oibVNaRD5GnZWYF0JYeU5PdKOV5beNHAC0NOM/MAVfmvbsh
   UbwH+rYpuhq3sDAaYvydsXrFfHQNnCS/2q6aHCq5uoPB0nI9bKjwbdqXl
   KaKTJVmjwq/8A0PacGwDJK5+TNITFftrp4uCyO3ctL0xCVzmBnvCTLz6K
   A+B/JlYRo3i/rNjbsXBC9pY3NoUbYx3fa+q4hFmB61KoiwJAHe4whY+IA
   XOLYZsQt2OKJDHj9MuZSxG9uLW0ZWbVh0EPXw+kd4W3vkr/E9iE48VNJG
   w==;
X-CSE-ConnectionGUID: bNB2l/+JR+yZVtnvUfbt+g==
X-CSE-MsgGUID: JVODcln5ROa6heVEcDkdAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1011827"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1011827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:02 -0700
X-CSE-ConnectionGUID: Rswx5nXuSZS/qN1MgAKBSQ==
X-CSE-MsgGUID: XDnqwV1nQ1aWEhfOGVdBKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2663055"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 7/9] cxl/region: Factor out cxl_port_setup_decoder()
Date: Sat, 17 Oct 2026 12:28:53 -0700
Message-ID: <77d38f529a6fdb26cad5e52ac8116854e2d62a7c.1792263750.git.alison.schofield@intel.com>
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

Once cxl_switch_port_setup_targets() has calculated the interleave for a
port's decoder, it either checks that interleave against the decoder
settings found for an auto region, or checks the decoder's interleave
capabilities and programs the decoder for a user created region. Both paths
are open coded in cxl_switch_port_setup_targets().

Move both paths to a new helper, cxl_port_setup_decoder().

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d25df041e922..025cf21adfa9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1565,46 +1565,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 	return 0;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
-					 struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_decoder *cxld, int iw, int ig)
 {
-	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
-	int iw, ig, rc, pos = cxled->pos;
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
-
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
-	if (rc)
-		return rc;
+	int rc;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
@@ -1643,6 +1608,53 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
 		dev_name(&port->dev), iw, ig);
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
+	int iw, ig, rc, pos = cxled->pos;
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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

