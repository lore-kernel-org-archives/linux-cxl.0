Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE41225A38
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678034; cv=none; b=KGvUaV2/q2is9nUubgR7gt0P63iW3e2eFw9OIZN3DDqqCDW3y1qInBm1yjo8yihGCZIyTDukEBOcNWn3G8qfehx8NaND7n3dfnjjnlU9XzJFv4c2ex6R8f1HNrvPUr+6Ng0ZX+cx8UM0f8Za7ldZDtsNHjwA5KwWsziKnQGGLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678034; c=relaxed/simple;
	bh=PwLSyMznIRF1B1Mfu232mRSUktOumPBm6cjJRb/BnxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGVc2BpJAq4AerlchMY+GbyUsi0Shfb7w49eOon5CvqWVDDGcNdIL66QAhh7Ngq8daOnyNGnssy05xsH6vNCmmrGVqs6NomwBmctn037lPxtHqzuwX9qjOv+vABauuCTMyApf/U3859sLLIV93ZTu98jUoQ7q3i7GlpswA/jUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4hsFX/A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4hsFX/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678033; x=1823214033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PwLSyMznIRF1B1Mfu232mRSUktOumPBm6cjJRb/BnxM=;
  b=I4hsFX/Abddh+oL/ZHEv61Bg/LM/F7RcEfSy3ujOAlkqb+uBAnwyngWP
   AaL1KIYpJoabTpJerWegIIuh90WQAvmnaAOLPKvAWlr/QK8cv/+RpOQVa
   4W8CuQk3SbjXPEAjM/3VOgWfX4I1nKHi+l58yoNnDOqU4rjXGOsqDmMVc
   +eILSoZXGv7h90ndGmyADjwAStndrBuLYRKhJ5SnP1A+K3PGfRU6ywumV
   lNJU/IYLKGXBLbRAnjWyXu07ksb75oWKaJniQo+GzhSIpOQNGdLK/3udH
   Ojg7nePIBrleNUaymQlEhIplv1aoXEaatyFjuMYSM+fPGxIiEc12pC2AS
   Q==;
X-CSE-ConnectionGUID: f3KwdqkuQ8GB14hcHXQkMg==
X-CSE-MsgGUID: +2msiPINTkioIxBN8MclSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459331"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459331"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:32 -0700
X-CSE-ConnectionGUID: mFumgKf4SGCIVW0Q3GtqJA==
X-CSE-MsgGUID: 50+bk8t2RI6Gv1XrQAhcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679056"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:31 -0700
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
Subject: [PATCH v2 4/8] cxl/region: Factor out cxl_port_peer_distance()
Date: Sat, 10 Oct 2026 17:20:19 -0700
Message-ID: <dcbd67bd2059beccba1aaa92ea099ac35dec9026.1791676454.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
each step of adding an endpoint to a port's decoder. One of those steps
calculates the distance between region positions that share a downstream
port.

Move that calculation to a new helper, cxl_port_peer_distance().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d564443a1d39..b288421203a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_region_ref *cxl_rr_iter;
+	struct cxl_port *iter = port;
+	int distance = 1;
+
+	/*
+	 * The "distance" between peer downstream ports represents which
+	 * endpoint positions in the region interleave a given port can
+	 * host.
+	 *
+	 * For example, at the root of a hierarchy the distance is
+	 * always 1 as every index targets a different host-bridge. At
+	 * each subsequent switch level those ports map every Nth region
+	 * position where N is the width of the switch == distance.
+	 */
+	do {
+		cxl_rr_iter = cxl_rr_load(iter, cxlr);
+		distance *= cxl_rr_iter->nr_targets;
+		iter = to_cxl_port(iter->dev.parent);
+	} while (!is_cxl_root(iter));
+	distance *= cxlrd->cxlsd.cxld.interleave_ways;
+
+	return distance;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_port *port,
 					 struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
@@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
+		int distance = cxl_port_peer_distance(port, cxlr);
 
-		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
-		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
-
-		for (i = 0; i < cxl_rr->nr_targets_set; i++)
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
-- 
2.37.3

