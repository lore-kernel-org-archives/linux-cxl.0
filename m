Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D977156661
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099256; cv=none; b=iMpNWUnKRVrEIuR5+oYWrEI3c2MdSEM4/NwcVTKSCCPK6/kG5JdrDkc2nLXAAn+xBCn57rTwgs9pmlxuKyuJ5oyIpn3yhfzC0yWuZBDcdLgIGyRCJVXN15+9LvyXsGGh0YVo8oQA2LzjbKcwdcDiE1B3NdhNDYrKn3iru4kF+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099256; c=relaxed/simple;
	bh=p+164Vrd4tjePMfgK82D/zGHA5Iw9zDzNiqw8h2m5r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAxdbQ3j1HNA7PJjH71DWPMb8o6760JqSzlhKfBEGX2K7hiFwZjx0iUQipu+LNSbWC7Rubc3cTea8Ro0LnqUNHAeHcLDZYMyeRNJd9Uq/9tX5n/RCdVUdjvQF7JfV4iTr38LtXhaCPFFtFCL/CeczvJH3XBM7fV6oNEJDFCizEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHqyabDR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHqyabDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780099255; x=1811635255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+164Vrd4tjePMfgK82D/zGHA5Iw9zDzNiqw8h2m5r8=;
  b=hHqyabDR7kpMygz0vecq0eI03EltNKeDfgI9mkzLtvKScN++87mCz9wf
   jGNziBpF7vJP6fj1t3IXNnBKMWbI/ZDUdT6HFDMz0lccWmAYkTFXid78R
   cgaiFwEMFOmZvC7jmChDBQ4IKD/MlroP1OhBQlw3IJ0QE1y8q6g+i/3+H
   iOLmp1yYAKiV/8aszpacMjnjrXszJm73V+wJx0kHNTNNv6wHfxIjuEL/6
   fvuzLG9Sp/suZhRg3cC3ix8wa3kGOVPtZcxG77DxUfN6x/jd5FkNyXnuF
   GHOdWzrXfGOfFVPkv113n8Ksrmh/IhbDx0xI2StLNL0SaJ4WBQUNZIxaA
   Q==;
X-CSE-ConnectionGUID: QfLMF7gGRs22l3TPQbilwQ==
X-CSE-MsgGUID: bZtpDPKPTE2bfqlwuHgYAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91530540"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="91530540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:55 -0700
X-CSE-ConnectionGUID: pDrQGKQGSZm9+sZVrT8OiQ==
X-CSE-MsgGUID: B1kYwIXLQiutme5V7P/tjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="238804361"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:54 -0700
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
Subject: [PATCH 2/6] cxl/region: Derive port granularity from selector bits
Date: Fri, 29 May 2026 17:00:41 -0700
Message-ID: <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1780095671.git.alison.schofield@intel.com>
References: <cover.1780095671.git.alison.schofield@intel.com>
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

Originally-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 87fb1a9f2683..9d310287d48d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1548,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1560,6 +1576,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
-- 
2.37.3

