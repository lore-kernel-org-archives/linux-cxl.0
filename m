Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09E4FDA78
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577484; cv=none; b=SVVFNpoTUlv8x3W4JgQcX1CpT1LOOIRgnqyvk05DXwTKZNqpXV29J6sPgX0UfGLqygtaEgGJ1ghGoYFrLdyGphqBjuzBIWSXdeLFPQlAnvOsu0ExqhcpzCipl6wECg3L2eKFK0j8XisawbSNwYgOAaXGLeBNN+E6Z8oVQZm9oKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577484; c=relaxed/simple;
	bh=Jm7m6qXSiRmY2V81JYHH8e2NMrk759eOTQwuzky+D+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4uvJhy+ygOUyHSQD3o1RgX7KBuOxhXEdcqnGvOCWFVwOkrZPDd6jxC4cS2rlzCTk1SHFgdzDqE7Acveov65KFxZdJF7CFsh39Mngmi7CtmqXkSdLIxhM589pgUPao82fOkoBE325pWXBejmaoC7F01oqmgASwCugMg/VcslKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXwLZV3x; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXwLZV3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577484; x=1823113484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jm7m6qXSiRmY2V81JYHH8e2NMrk759eOTQwuzky+D+E=;
  b=NXwLZV3xKdKp3OBAUT2N2b7q7l2EfTKwD42n227Kq+cFjcaEfHPowgXR
   QUdaO2gz08HFwMQL7uL2Q5g+N2mw4XCv4WSeVTKsphhKPKf0Ye4scdW7+
   XDyjjfmjPE42jn2d98roLlyQ1Yk+/4jtvNc9Yb0EiNbAO67JEQ36r2ybr
   Y0drOT6vVXsJJBgVSyMQhEu3EslvmtjPngxep9vF5LH1XT82n3CCcwORM
   MRdf4Lo5lEopEpjJkl0B4mA0dARzagp65BOhxKSLuNHI593gM2zD9Lqdc
   av2AxB98J9Il3sIFcMnl85vjoZBlqdKgzZ7KS/dNmfRNZKbVEERo/MOfg
   Q==;
X-CSE-ConnectionGUID: d/ZBGQ83SYmLq07BC6GZrw==
X-CSE-MsgGUID: l7NoL1GtTjOdCrS3kJIqhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="376958"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="376958"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:41 -0700
X-CSE-ConnectionGUID: epjQEA5mRU25IKRkiUmbmQ==
X-CSE-MsgGUID: NqqNubwMTzyRvOGpRJecRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743023"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:40 -0700
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
Subject: [PATCH 3/7] cxl/region: Factor out cxl_port_peer_distance()
Date: Fri,  9 Oct 2026 13:24:03 -0700
Message-ID: <2a4d99ac07511575950f6cd83df39742d1747861.1791575481.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791575481.git.alison.schofield@intel.com>
References: <cover.1791575481.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() is nearly 200 lines long and open codes each step
of adding an endpoint to a port's decoder. One of those steps calculates
the distance between region positions that share a downstream port.

Move that calculation to a new helper, cxl_port_peer_distance().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1a42753fda48..80c40716c368 100644
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
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1445,7 +1472,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *iter = port;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1460,27 +1486,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
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

