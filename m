Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3813DF008
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264812; cv=none; b=ucPwcOYKFGMZWPfJRztp6ZNNvAvkhxXgMmcAtWjyPzj0GZkALeGaO/eGf7q8sxrYOCUzhwYF+Wu4k0j72pyD49coRYprVgwx6tgXO2I82Gbuz5ULvzzU6T9WL4UgM8dQ6VmC/vhKkBXOUGEiaq/45AMijE1H6KkJzBG7D36+c3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264812; c=relaxed/simple;
	bh=CGGmuvIWX2ZOz0+PVYjYDVVtqwiz9EOy1byVxxvSWS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5s75W5YINQ4eTDD7s3u2U+/Al6DJZCb4i4uZHYgL+KCOsHQaWVsWJEnWravAElcfdwupwSoIZBp1qxP+4wCShF4IoX/qZb+SNlB7Axx48caGzlL+ngKtr+eaxxQfVHbyEap47CHV61Aem6+3sT/xuk4607QbF/3ATbCyW/7i2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccwYm3WM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccwYm3WM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264811; x=1823800811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGGmuvIWX2ZOz0+PVYjYDVVtqwiz9EOy1byVxxvSWS0=;
  b=ccwYm3WMRZbDpGUywpCUsLjDzhzucRJHNai0ibtNcyxLkddjJDDs643X
   IykofGJ8mLl9Gi6ur1SQjGwsWKguY3vSovYi6eT3b48dTAnWBxXH0JxIG
   Ta64vPQzxmS269VRAwo9OaAYsG15Znivi+5jEs2Fk0nPtPKUJPLWs8XiM
   taiggPBgQf482vHRG0eNnhd3u8q8Kr6BpDo82KTHSP4oh3shFgf9zgKFX
   lY/r/mWOfBosCPl4qyV4HerIkOvXHY0S+lh+ffedGbiF56QoA/eAy5j5Z
   dlK41gp54FwXwfFeDZ/pTJBuDMkDEldtaZYKNkdJptKJnPmOOQSRgjtSr
   w==;
X-CSE-ConnectionGUID: D6xwTTWoQLq9U95hzMw4EQ==
X-CSE-MsgGUID: Pu5jcNUMRgGfQNeM9gL4ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034693"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:11 -0700
X-CSE-ConnectionGUID: XPeaXwSJRteqs2YXjIjGLw==
X-CSE-MsgGUID: KOc3y1vTRDODGkaXM87oGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282235"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:10 -0700
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
Subject: [PATCH v4 6/9] cxl/region: Factor out cxl_port_calc_interleave()
Date: Sat, 17 Oct 2026 12:19:51 -0700
Message-ID: <e51a52f39cb32497bb0c32e7b4024cf00bec809c.1792263750.git.alison.schofield@intel.com>
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

