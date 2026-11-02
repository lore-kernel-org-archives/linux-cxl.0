Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650575;
	b=m984qPrD940AQ8Kps0d8YOudzQ9CjwSewCOplsCvdUGPpyL13Ykdw+qMdPd629DUyMbV
	 Hq58Hgkt4SSvgMsIWu1JtR3F/WQah1ZoNERWd2hi+OSB5G8p/Ez6VTk8Q11eXWlcedcKt
	 +w0Ci/7xOqw5XTr/MtYrwh7JT6KCM7XSWJlMKBDl5LIgmhoy7Dl6ELMfQxWzEJNWyyguW
	 1+pPOmE36dtzH1odFdzQHND3WTgBrL9BojOSlo9EzB9zB5C+cJHcYVPLGCaYE6DTyuzNM
	 fDP3y9RNvwlNFy1D985U8VoMXPhpEu0ZEGQ/SB6aSoAYirVP/HvG+LbNieIzwgciQuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650575;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B0x6VLDiSv9avk/31Wz3Ew4xsBWxU1OrCoitnrG2Mls=;
	b=JvwkV6EmUfoWNqEWLun3tyPPvxPJTouqFip7wnmVyVXbFvfYCQUj4APA+xpRA3pKbek8
	 bKaj2p/7L3Qhd/GzrareoUytiqKtu1kZn2IGKkL2oDQlh3lsaJ1UXOJW72K7q/ZrPrPAC
	 mxR3jFM+5lXzxpRYcv6Ejgywcaq+zYZNL97d+1e+p/hhTmblCuFLvIEnreyINyfE+V0p1
	 6w7xOkz3EnmLMT0YhPhXNLYxjhfarmnq4QUuDC9Ssc97w5CrEulQpbOqgHuXzxSwgezXU
	 9/Efqzt7+23f3D8jMAeF6BAFLLZy36Zs5T5eVJFqfNsNHj4DViGhxNfcfkMQgoy+Eyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4uAAQRY;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AC606A32F
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732AC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i4uAAQRY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650574; x=1825186574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGGmuvIWX2ZOz0+PVYjYDVVtqwiz9EOy1byVxxvSWS0=;
  b=i4uAAQRYN0Sq4/39y/qO2EqSq4j7xw7B7UNsgtBPvweGnw8V7P1GJnk1
   qP/Q9n9K445R7rUVylY/zNbusSZhPVPeIqI6lddbSVxdcxa2xJmEiPUDf
   U29Npv+RiQxEYDjeuhLz/J03TWzk3CLsVpI2Rj7flMFml0oKcvLBlcpJ4
   uq7LxxOQMghTtB5Ud4fVwUKELBbqVLqkuxCanmm49OvLgWrjS2X+5RdZ/
   +2KsOvu/9Ji6BcE8rky0iwGvop4K6uGggEcJychyGVoYDg2iUvAZBRITV
   mMf3zw8ihRGp9bFWleG4DNwFuEXDkCVFURAciPyZj+vmVOBPlbgYUsxi2
   w==;
X-CSE-ConnectionGUID: gk+aD7nJSiOPWOTbs4XhbQ==
X-CSE-MsgGUID: ckag4cgWS4WwcRaO7XQFcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464031"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464031"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:13 -0800
X-CSE-ConnectionGUID: gea5RATFRn2uTYm6l7WvSA==
X-CSE-MsgGUID: CxEk5m4JQnabZb6AwphWFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215620"
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
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 6/9] cxl/region: Factor out cxl_port_calc_interleave()
Date: Mon,  2 Nov 2026 12:16:01 -0800
Message-ID: <cefd25ee5b9d600779a2dac442bd02110f571ff2.1793649898.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() calculates the interleave ways and
granularity of a port's decoder from the parent interleave and the number
of targets below the port, then validates the result. That calculation and
its checks are open coded between the target search and the decoder setup.

Move the calculation and its checks to a new helper,
cxl_port_calc_interleave(), so that the interleave for the port's decoder
is calculated and validated in one place.

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cdf90fb6ea64..d25df041e922 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1517,13 +1517,60 @@ static int cxl_port_parent_interleave(struct cxl_port *port,
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
 static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 					 struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = to_cxl_port(cxlsd->cxld.dev.parent);
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
-	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int iw, ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
@@ -1555,38 +1602,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
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

