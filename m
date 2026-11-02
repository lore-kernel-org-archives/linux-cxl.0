Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650575;
	b=z2/885xe0EyLt9ULabvTLpkxthkk97vulEi8TfAR1dQhqeROeIgTkXWdOzLMBNdCcf94
	 YrQlsMHtV8qJaj+Fv4r3ZNn2Js+w2NLIWCqHEE2LMS6+tOlkmcI1gi2cnlYunno9AS7cW
	 ZRh+CMbGlglpUn2j1PjKHYDpIR4YINSWPDeZ14QWG8NndfvXeGOamHZhwHJw1i8cZ2CMe
	 i7kyYY3vsf09mM56PKcfVt2V15fxZxqItVkeuB8isMeQuAN905m+TfU4kGNiDygvRfO6o
	 0A7QTzymibypQ+rIWoruwm1PigjNhPctFJuxIeJDFXNd3FQcX+xfphAUv8vB8KP8+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jLxJTCybwMEcrUMXDKiNaIrE3ag1EFWjREUFfOXqYv4=;
	b=RRarGNqluTflQn+j3CVjwhLek+GZbGh73PTWYvOOaOUXsz4EOVbZ/PNokpMzN8MGT2GM
	 XAmKSvlY86o0AdGi9LYy1Yqba66/s1dx7hmeYtFRPBGiZWPVYZfWhTBt9+vAJqnuN3CR0
	 9ZA8VX+qA0xoQwGYRuL3JKs0fYQkOR2ma7vo7fHbX+WQU8jXga/nm6mq2H3aT0LPEVIqB
	 qKQ6WNbHfIvbh/iQRKmLLYfJqDUFoK8qNzzN9LIAaaEPQCg+Bg0eOYsaqUnFoK4S2/t6a
	 feQ9fyxiSAjIkydccdovYtqDnP4HOBUYLwRewbTbrXmIrk68zaVXfd7V8e7YJWkUAuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z8eVDzgN;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D582606A334
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D582606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z8eVDzgN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650575; x=1825186575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoVfHk57W+5PZ7pdLcq+lXu8jJ5my+RAaSw2wAc0T94=;
  b=Z8eVDzgNYpgcvsjlv19ldf0qH6GAz+3mbzQkch3aP+Zpb1LwFzjFhgQD
   blYvVY32uDzgMQvO9OOtcnilNtq/EjRJOgbsh/AjeKWItto7gThRuHQ+h
   +ygp0ETpoye88FsMd+SaOwlB6Pj0CPo35gH2ADjelUR+FuvgKRD1xAhjq
   i/68UK/ujxSWDxZcgjRbxUUr6TAlB8qer+yj5SLTnovh5drf12Z/HB+2z
   3890BzH501JOtCec2qHyzmUnLM8MJgSLCrh/Xbaq4ERG95JAsKRVL5IfN
   ls08fH1SocCWIh/C7kGUS8i2egHowsgPKKWAcJUjG/DU6qE5p9cTIbcgL
   g==;
X-CSE-ConnectionGUID: hCrQQR/mRC2E+icdeAwhCQ==
X-CSE-MsgGUID: 69T+US1+QjqtVHSPv/RNUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464040"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464040"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:14 -0800
X-CSE-ConnectionGUID: fiPAS8amTrGOClf/m5JWpQ==
X-CSE-MsgGUID: 8Gur54E/TY6utjcz0znXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215625"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:13 -0800
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
Subject: [PATCH v5 7/9] cxl/region: Factor out cxl_port_setup_decoder()
Date: Mon,  2 Nov 2026 12:16:02 -0800
Message-ID: <b7591ef1790f21b3e3168778e25eadcf7cd2c4e6.1793649898.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793649898.git.alison.schofield@intel.com>
References: <cover.1793649898.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
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

