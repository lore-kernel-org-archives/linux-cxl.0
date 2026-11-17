Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942888;
	b=R1K4jaP7Lgt6P1hpbkAtY8WxggqXC/fA9Q4FOAJJaRNkzSw1ipDAeNWANwHjkzGQRhwe
	 A25cDBSXzUKOMn2zLsS7FOA7yztREyUk5hn2g6iomoXXTbLHZjlFHDepmDPpxogb2t6mU
	 J6ce5YYgnirzMEQ/oVZtuwyfyHWoX/eswoLtzEpjCrZRna7XXpOG4gU2MzCg5XPuIeZ1P
	 UgYvROoYTAE3IN3Xb+9IH8yyL81pEHM2q6CD6c/u03EdU25l0m6lG5025dFFkq2Ghvm5k
	 y1WpQi51/mguZ0+xJdsGls6oGWq0RxML2ZsXdc+J2d8NBTf0/gzpFsAb5S6+N9jzElQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rjXGyV8Tfu1uTtKcmkENdSJfyJEGvrU7gnhieKlWSfw=;
	b=Tmt2b9ikweusFIace0tDt/Rzu+M+9Fz3Bi7PcHoeJ5A3jpYHTB0dyZhsyCaXnKHi2aVi
	 c2VviXF1J3yddSKkFPdbD+Uk/hmsYWmA3Owb8CQN64P+MPoZrBBHSHTxxsyl8Jpf0xtfb
	 2rnox/oTZU8ZRoWdbuh62XG0WGL+oHfOFFE0MVte1ix14i7mMSbiuhFh0B8FQko2fN7zZ
	 fiOzTgOVeHKySFe3WFxV2a202mvzBjEEr3QJ5wmzgxVDav6exlIz2BdTvl0p3LPvf7yc1
	 Fud/DE1ExG07DQ2rAeDNmcA5ob28r58tsFxAxiexObgbp67hdMWZ/SS2QLckIPC823A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7A7hTFR;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923D606A32A
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7923D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7A7hTFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942888; x=1826478888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pF01iEQP8+MIOKY78AN2g/6ue5MH+m8IhRT5Ib3Nq+E=;
  b=P7A7hTFRa3BH/3Hc8e4OMtGfiiO0TQphu5E+YZ2fBg6yakrRIShCyDED
   Dtt0eiD7Odngg2Zif37wryrF6+LPzEozQJhNRrAFbsf5EU+xqOT94z2vA
   7fPpCebRTxUlKn3u/BCYd2mINNFl0HEGJc+YcLLfm6PFfTAYQlATQJ3eT
   x58UwU3n8eVG2JEpmlQkEJeLKZ3kOKb9ubalWUA9OKN3quAyJX7g63Gcr
   3TGW6YSP/C1Uj6QIfMv3nRv3Xyit7btnqKUtsEpEREwUY9SA75ZtLgEOn
   7KI5XmUdziGRPbxvoackNcnPTvEQYHgXzNLLfE4MbCDtxbNXSMKOJYFcY
   w==;
X-CSE-ConnectionGUID: 4f7NTstzRl2UbCcT0zJHug==
X-CSE-MsgGUID: aiSjpd0KSESqmuREP7AVSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3612795"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3612795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:47 -0800
X-CSE-ConnectionGUID: X0MAnMZqRr6UhdjoK4W+1A==
X-CSE-MsgGUID: 97f0CEgsRCaTn5tFKcoplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9764362"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:47 -0800
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
Subject: [PATCH v2 1/3] cxl/region: Carry the effective interleave state through target setup
Date: Tue, 17 Nov 2026 11:14:40 -0800
Message-ID: <81d46e0701a8485625688ff3d52486077639067c.1794942093.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794942093.git.alison.schofield@intel.com>
References: <cover.1794942093.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 28 ++++++++++++++++++++++------
 drivers/cxl/cxl.h         |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d6a5dbe65d26..c877638d5389 100644
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
+		/* Report the effective granularity, not the register value */
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

