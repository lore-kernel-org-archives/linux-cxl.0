Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862933AD526
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264809; cv=none; b=eqWHA632GfOXwBf0WFJrLBf24hrAKJfT1Ufa3JvnrIqzHm0H9qlzmR3iRUHSoU3VEIOCkSeV3lPT0Fkz+/xgn0SRCuYLQzmlsE7nLzhjktOTC7UuV7zHX62+BXfVbaJUwWkkPCaJxd9bhC3HLGd4Za2u4kKWaD6czUpACsvVlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264809; c=relaxed/simple;
	bh=xdxPrjV6cdT9sNpOtqD77QuSkkidRSzWbxwyz1sQPtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOb1ia5DNUatii8vgQfGnVwObkY1bG15mOgWvBWV1KiIQYzvFenuUxy82OAP2PVS2ikMGkj5lKeecaS/qsWVti4rr/LZSy8J/pqpIVjVYWwsgLG0GF/YyDH7atHGJqcmJ+rnduPEx7hNFhf1NhXzA/Lxl5qAcBze6NpenBfTnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7EnTlYI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7EnTlYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264807; x=1823800807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xdxPrjV6cdT9sNpOtqD77QuSkkidRSzWbxwyz1sQPtA=;
  b=d7EnTlYIX3SN5IrpALIHCz+tEvTLQ/bcgOxCLYYU6fiixcFBj0PTPTdz
   tmhl51CvfeR9O+uX5Fy+J/ypNDvXEieKX0yR8ccguSP4MlaOB02YTUzg5
   oGM8ZE25gVqDQCvmUOofid9mrzv4tLqnZ4Nk3Qh2r+RbtlLwK4q3F5BGW
   M9nng8rzkubeDxLaKn5gBj96AB+8mYB+D3B7mCJ0/qA+QS9o8LxokCjzK
   Usu2ItiXn45nlgDc4FjIQ2fbfazm9AUuA8vIVPQdwX0EZ6e2QC49XrhJT
   P/JXdIjNI2mkvtPykrnzgvcvcMm3VAfK/12qfS3qvkSM4x6yDM4033mwy
   g==;
X-CSE-ConnectionGUID: qvWNMEI9QVuBHYGoQQTR5g==
X-CSE-MsgGUID: mAos1sscRNqg+hBxD757jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034675"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034675"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:07 -0700
X-CSE-ConnectionGUID: BH+hzkf0S3K0DuqnDpQZWw==
X-CSE-MsgGUID: lzlOb7rmTIq0etH05nOYNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282217"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:07 -0700
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
Subject: [PATCH v4 3/9] cxl/region: Factor out cxl_port_peer_distance()
Date: Sat, 17 Oct 2026 12:19:48 -0700
Message-ID: <f89b93bf2c2eeed7fddf729521928d7c03b063d6.1792263750.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
each step of adding an endpoint to a port's decoder. One of those steps
calculates the distance between region positions that share a downstream
port.

Move that calculation to a new helper, cxl_port_peer_distance().

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6ce27b8b63be..4ab5a1d025a9 100644
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
 static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 					 struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
@@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
-	struct cxl_port *iter = port;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1459,27 +1485,9 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	}
 
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

