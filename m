Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011709;
	b=tAkr9hCQDqePWg+MD0S5aXfQBmPjqprJ/bpGAOcKYa3C2c42uBlw4aT53R/mGjluBRs/
	 z78tIMMUSet8IHTswkiAFrtId4KlPtzPyuHvROIn2u3WovdEzpFfjpSoRt+espJ928kre
	 /1QcpS9dl8uPg/xi1ywq/JTYvZN11LNsJ3sFQ5SC+Ohe6WEzOGYoMf/ERSWMq/BVohfip
	 jb1R2JofoqCsBZ4zuacQwbw1iYygjAu5jrSsJlNlYac8HSrHBkXIw9zWfezRNns1S/ts6
	 Mqrh9ngXQ6tHm3N9y5pu/LHPrHgwEl6Vbza4gVP6EQDtksxvZk3ZyhmURAbsl3HMmnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011709;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XxKOjqupQZ3bqTaM59fevcns8I8X5lLzjwJ/4YTTQIE=;
	b=PgxfMpPyqRzvSNJCGLR9IhHMew717VDdm+drKn/pFMjtm+flGlHKy/ViOw4xMvBM9O2Y
	 T9Q8QjJaEtma9QyZZXJMSLbHmWEPFh+MxA+kdS5GOZod83vEU+zDfugDd9sGFQ40pWiAn
	 QM+zFUeyRPV+DWFLHjCgaOjtbmmQLhMdRze6+1DQNI7YWimzPMM8bUaVo0h/ONopFJix1
	 ogD0s77TSy5PEBZDD4Iy9JoOvNaOB856AomoFrwcW4Bi6RcVBE1oUVQmurvHXOIBD09aP
	 JzJD6LwweqrCbACltWoKDgkIT0t2BsZ43jL+iKn/TU7REc01qB2pvP+iz6xckDCjd2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WCNsWnRB;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D3606A32C
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4D3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WCNsWnRB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794011708; x=1825547708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ROkhowphasp43lWXIt94+lMX6cN6xH1NZ25zAn9c98=;
  b=WCNsWnRBoZvJBQtfZHbVGjKvGkIR16WlM96THFJnVUSXrX3XoYubBvSO
   0nHu/Sajxw0GO5/2Ey5NiyP1HkDg7Ep8tcugVXvBj2u9UjaX+o/b7R8GA
   B/D1vkZIykSy22p1+lcC4nBQqNsBcpwSO5sj7FQbAaRCwxyt7ogmXRKBj
   tHdkB6nzQIsEwZn+TIFlbjCSGF0JEW3fEm3xcrXAK6LKweExIpq3YqHJZ
   508MaLLYEGh9Lb6sB1bl+a3wyeuLjaNmnMRF37xMUiV+ed0bTJVfMf6Hw
   fBpAYx/voKthA9O5wBnI2v9StTAO+xfPNSZdvUQ/5A4L9sKek/gnbjNtR
   A==;
X-CSE-ConnectionGUID: R37Ip2uqQlOeswmJf6YPMQ==
X-CSE-MsgGUID: 72KX0JrlR8a0Wqku4+/tJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710311"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2710311"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:07 -0800
X-CSE-ConnectionGUID: TLAgkKp0RzGIyQNnDgZXWA==
X-CSE-MsgGUID: B/kN1sEfQCGQ8valcS4IYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176227"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 1/3] cxl/region: Carry the effective interleave state through target setup
Date: Fri,  6 Nov 2026 16:35:00 -0800
Message-ID: <e99646b0692e6e01b2f71c6a80cc664b0066db57.1794010889.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
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

Switch decoder setup derives interleave settings from the parent decoder.
A passthrough decoder's granularity is a hardware don't-care, so using it
can cause auto region assembly to reject a downstream decoder whose
programmed granularity differs from the calculated value.

User-created regions instead store the calculated granularity in the
passthrough decoder. Below a 2-way 16K root, that calculation produces
32K, exceeding the hardware limit even though the decoder does not
interleave.

Carry the effective interleave state in each port's region reference.
Interleaving decoders establish that state and passthrough decoders
preserve it for descendants. Store the state because a later endpoint
may be the first to reach a descendant of an already configured port.

In both paths, passthrough decoders report the effective granularity
inherited from above. Their interleave_granularity ABI permits this
because a single-target decoder never rotates.

Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
Fixes: ce32b0c9c522 ("cxl: core/region - ignore interleave granularity when ways=1")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Suggested-by: Richard Cheng <icheng@nvidia.com>
Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

The Suggested-by's come from this discussion (also linked in cover letter)
https://lore.kernel.org/linux-cxl/aqnWLH-nrXk6BYqM@aschofie-mobl2.lan/


 drivers/cxl/core/region.c | 28 ++++++++++++++++++++++------
 drivers/cxl/cxl.h         |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d6a5dbe65d26..b81a142108e5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1489,12 +1489,15 @@ static int cxl_port_parent_interleave(struct cxl_port *port,
 			parent_iw /= 3;
 	} else {
 		struct cxl_region_ref *parent_rr;
-		struct cxl_decoder *parent_cxld;
 
+		/*
+		 * The granularity of a passthrough (iw == 1) decoder is a
+		 * hardware don't-care, so use the parent port's effective
+		 * interleave state rather than the parent decoder's settings.
+		 */
 		parent_rr = cxl_rr_load(parent_port, cxlr);
-		parent_cxld = parent_rr->decoder;
-		parent_ig = parent_cxld->interleave_granularity;
-		parent_iw = parent_cxld->interleave_ways;
+		parent_ig = parent_rr->eff_ig;
+		parent_iw = parent_rr->eff_iw;
 	}
 
 	if (!granularity_valid(parent_ig)) {
@@ -1539,9 +1542,13 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 
 	/*
 	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
+	 * Multiplier is the parent port interleave ways. A passthrough
+	 * decoder does not interleave, so it takes the parent granularity.
 	 */
-	ig = parent_ig * parent_iw;
+	if (iw == 1)
+		ig = parent_ig;
+	else
+		ig = parent_ig * parent_iw;
 
 	if (!granularity_valid(ig)) {
 		dev_dbg(&cxlr->dev,
@@ -1559,6 +1566,12 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 		return -ENXIO;
 	}
 
+	if (iw == 1)
+		cxl_rr->eff_iw = parent_iw;
+	else
+		cxl_rr->eff_iw = iw;
+	cxl_rr->eff_ig = ig;
+
 	*out_iw = iw;
 	*out_ig = ig;
 
@@ -1589,6 +1602,9 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
 				cxld->hpa_range.start, cxld->hpa_range.end);
 			return -ENXIO;
 		}
+		/* Report the effective granularity, not the firmware value */
+		if (iw == 1)
+			cxld->interleave_granularity = ig;
 	} else {
 		rc = check_interleave_cap(cxld, iw, ig);
 		if (rc) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 11688d17d09f..aeb7704869ed 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -716,6 +716,9 @@ struct cxl_ep {
  * @nr_targets_set: track how many targets have been programmed during setup
  * @nr_eps: number of endpoints beneath @port
  * @nr_targets: number of distinct targets needed to reach @nr_eps
+ * @eff_iw: effective interleave ways at @port, set by the nearest
+ *	    interleaving decoder at or above @port
+ * @eff_ig: effective interleave granularity at @port, set as for @eff_iw
  */
 struct cxl_region_ref {
 	struct cxl_port *port;
@@ -725,6 +728,8 @@ struct cxl_region_ref {
 	int nr_targets_set;
 	int nr_eps;
 	int nr_targets;
+	int eff_iw;
+	int eff_ig;
 };
 
 /*
-- 
2.37.3

