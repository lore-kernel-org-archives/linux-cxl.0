Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C1472F7D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865572; cv=none; b=R/A/g/9shLajM/HUM+SHc0lJ8ZGPweGqf0f0FsQs/Fg3prj8YRsKtxiSrNefZXsMLAxEvJtM0txqSgmXhRu7Bm+hkgZGhD+uM1TpfDYRu+25houzVOMyM6bj/bR/WpLaDJXafV0YS009N6RToKKJQv1nc+xwwLzcpL9roao9viU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865572; c=relaxed/simple;
	bh=zRVRG9N18n+EtdScJ1soRCTgg1LWAsEtoX3+icc1cpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhACDVBq1sLQFcxNcYs1wnpbm6qmxNJiNoOYgq2rohyrHvXKAdSEAg5jPV2xBy073xazHvPw8Qow7gjzISLZLvJ4kN87Q641wqopUgQnm4AxZh7BT3+TRWprzJdkD3wYV+BsthMa02CigDoqEJdthbVOTYe0b8wpn7YyNcuw5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jvkg9TZc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jvkg9TZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865572; x=1823401572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRVRG9N18n+EtdScJ1soRCTgg1LWAsEtoX3+icc1cpg=;
  b=Jvkg9TZcbdswXIkQjVy1OsHDK2nrs/DBgEBoX+Gxorx2d9IEy0DA4Y8k
   zewBFwWQKAxgGtw3i27xX1Ns/m7coWzCEyxiyzLRGjaQ4SdHWRJZjlbow
   7iHFVYEeQrf9tN//2CMZiL6fUaPqhQZpicdr0BpcyN8NBiRdV8uxa0h5W
   3Axuho2vbNu/djsAUT/1C+Wz1lTb2EwjAolapPGcDqPFUozYTUX3BtS0S
   kn7Kc/cBAu4mQ4p8qnYnpH02QCGJ/2bwWcpd+ysIKY580WBGvT/ftWD1q
   gtZC9zzTpZW5k53xO25dGm7ixHyyp1PtoXVCwSEVWOAkEkURLoF328amb
   Q==;
X-CSE-ConnectionGUID: osgYQrigQa+hC6dVsp4PAg==
X-CSE-MsgGUID: 5UqUtnz2Q1O0w9AY0Ujesg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455479"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:12 -0700
X-CSE-ConnectionGUID: OaSP0biPT8y7vFyCg2Vl4g==
X-CSE-MsgGUID: VELvv8bcSNuYPzMe0cbSQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391084"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:10 -0700
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
Subject: [PATCH v3 3/7] cxl/region: Factor out cxl_port_peer_distance()
Date: Mon, 12 Oct 2026 21:25:59 -0700
Message-ID: <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9b0e2f195d1f..ea281ce4ec49 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+/*
+ * The "distance" between peer downstream ports represents which
+ * endpoint positions in the region interleave a given port can
+ * host.
+ *
+ * For example, at the root of a hierarchy the distance is
+ * always 1 as every index targets a different host-bridge. At
+ * each subsequent switch level those ports map every Nth region
+ * position where N is the width of the switch == distance.
+ */
+static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_region_ref *cxl_rr_iter;
+	struct cxl_port *iter = port;
+	int distance = 1;
+
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

