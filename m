Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDA3FB7EB
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200060; cv=none; b=PJbrBgUn5Qn1d0p3vtJnBRUYUqDIrrzytDiNj0VaXR7dy3VHYE34Uy6GLb3XiAr+v1Nua1MaiX3xGeyN8+sRcyrga2s6h6VtOoP7mH+s28mcg9szI3LqYSLKGkmvloVuXADgyn3qOtAlHsolqq3dQUpyk5yv5BmNiZpg2gFRhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200060; c=relaxed/simple;
	bh=HZTQsKicixNfJmvcvtoI2C4a3K2SHT7oL28LSUPRnMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqVOplwBCI67WtNmHfg2mWJihQpjO2ShqFWuJMMblahSSmN/eINQKhXNYmV3rbrBf4agsbrfO/HWcyguZW76Mb8HVr4vQwLiZUuW6rAtzzKpBIE7mtncJ5rHbXhGxJz40bW7AgVgJpCFnG/y3qBwoQujM5viHuD33A6anJM8T+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IH/oT1wP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IH/oT1wP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200059; x=1812736059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZTQsKicixNfJmvcvtoI2C4a3K2SHT7oL28LSUPRnMc=;
  b=IH/oT1wPFZZ2vleKh8/9KM/tYVt5lcCTASw4zyRt61UHhz1URejcUtM7
   x8zjDg+B67KAtcCVmbzIx5wYaK5lIIXuObxAU+/aKS7+JzaEbDIEWkRCh
   2NFVureV7S7DOOzfwunXQZ6Z6kUqcvI/kBXIZsPSbWiLdu2Fw453WBLMa
   HuWx2HT5Q2hyc5Kw3N1vuBO4snRRz4IoozqkUE5Q4J6CXjqsOuuUgY2DU
   gcR2TVKQ1IORxqu/JCEoQq63rfO5UozNH5hFx1fyFoWU8ALugK/E+3JaC
   jy1oTFR+fsR8vf6gkl80HEhG4pdX89igGPPF/BxUtF+eLczU34WCL+tza
   A==;
X-CSE-ConnectionGUID: zxrUb/OhR1Gxj7twea151w==
X-CSE-MsgGUID: Ma3gWcR5RbOwTOoGjmubXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99598800"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99598800"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:39 -0700
X-CSE-ConnectionGUID: qtTfaSgFT/2deSouIwWeZw==
X-CSE-MsgGUID: 4UnCSdZzT4G5Ut4DEPY76Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246441003"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/6] cxl/region: Derive port granularity from selector bits
Date: Thu, 11 Jun 2026 10:47:26 -0700
Message-ID: <8958317c8d2a02f021f34712b69846a709f702f8.1781199122.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1781199122.git.alison.schofield@intel.com>
References: <cover.1781199122.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Selector-bit validation uses a single same-granularity formula
for user-created regions. Mixed-granularity layouts need the
programmed granularity to depend on the type of decoder being
configured.

Derive port granularity from the selector state:

  AUTO:    keep the firmware-programmed value; the walk validated it.
  iw == 1: passthrough; consume no selector bits and span the parent
           stride.
  iw > 1:  claim the lowest selector bit still available to this
           level.

This lets an interleaving switch beneath a mixed-granularity root
claim an inner selector bit instead of colliding with the outer bit
already owned by the root.

Add a final check that the derived selector fits within the
remaining selector bits.

Remove the auto-region granularity equality check that duplicated
the old ordering rule. The selector walk now validates auto region
granularities.

Originally-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c859c8661281..d5d19ed62171 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1533,6 +1533,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return -ENXIO;
 	}
 
+	/* Selector bits still available to this port. */
+	selector = cxlr_sel & ~selector;
+
 	if (cxl_rr->nr_targets_set) {
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
@@ -1545,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		goto add_target;
 	}
 
-	ig = p->interleave_granularity * parent_distance;
+	/*
+	 * Auto regions keep the firmware value, passthrough decoders consume
+	 * no selector bits, interleaving decoders claim the lowest available
+	 * selector bit.
+	 */
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		ig = cxld->interleave_granularity;
+	} else if (iw == 1) {
+		ig = p->interleave_granularity * parent_distance;
+	} else if (selector) {
+		ig = 1ULL << __ffs64(selector);
+	} else {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: no selector bits available for iw %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
+		return -ENXIO;
+	}
 
 	rc = ways_to_eiw(iw, &eiw);
 	if (!rc)
@@ -1557,9 +1576,16 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	if (iw > 1 && (~selector & get_selector(iw, ig))) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			get_selector(iw, ig), selector, iw, ig);
+		return -ENXIO;
+	}
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
-- 
2.37.3

