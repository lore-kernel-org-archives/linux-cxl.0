Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650571;
	b=Nd6Ffks3/birndjRg/1UPLwGZnMS9l0SPfSty+DK/d1sUDMVARnEQsFpYnDvbID6w817
	 vNcLARteMO+MM9aBnqrl4IIf/gTnqgOpxFmEDq3ioM0snpF6anqR9IpqojcbExAZ+lclu
	 jPV1nGaxNmDBAU4AZaQAcYZAr4ikV7JyQLaBv9Sb05zYHXvjr6zeOS5M6L/NuLKH0gewK
	 SIBp2eCNjBYmBScGrVnmX24ce+L6QNrOpdLpfhOue01b+t4kr2TXgi8D15wDqNzhhcoQP
	 RONEb78c+/2sKbPrKIf8f9A6FnhPx/aEmAWPGlK9RK/9CbGsDxZqF2a9Epx6Mih7ZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4r1Eci967+0dGsHsWmTgfMjKVd0p2R9pqSfGn5GGsgg=;
	b=djd14BoeRatYh0fdb9DL4m8wkkgkpgC/BPABf3XCbVD4OGC35GFQ8fzpxX68Cybvhhax
	 iPft8iHWlT+DnTNI1ncKJ4hLW5iccqLT4uRiSIx4O2Hv6aXrVTVg47TKthf8sFVGRe4gJ
	 mP23WA5DbWTMbbUY+VgElmQuoZfUCF/7taluWPOG12InY2voiu5IF7tjeN0jNLJIE+JbN
	 IMkmuMdIJzsRxwvsAhFlksBDERgeB8FQir0ZAPVILhIjfc86bjTD31MJZgI2Ip05kxxST
	 N5o7JlYj1cRaek3n8IhuK4f7ITgVugWmiyp5U6y6jnhF0ZL/sb6HNLba1+7ehJRn4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XmooJ6Ol;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB53606A327
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB53606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XmooJ6Ol
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650572; x=1825186572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xdxPrjV6cdT9sNpOtqD77QuSkkidRSzWbxwyz1sQPtA=;
  b=XmooJ6Ol4UpYWJTVjGF5A0st432oh82A078SmoMOT6fSnwxAJQo+1CCQ
   jDrVhiHunhMwyUqCqRlA7qp+8L3AAiswB6ru6/0MqU27vFLfbWahc0o1c
   /njnC0TFVF/7XlQ9gcicgRKb4Pp8zpaxlB5PsDFzJqqx21SJHzx8MV60I
   a9drOGiUMke05iH9PRd7qlIEcEb8hpoyvDUbufbrfRuU410yPrcYaPafo
   6NrwTkVjDsOzweVJrNSoEzNFoaQwy4YpjBYHWV582ugEn0Hq1Di89zHza
   CP8JSVBo2iSxBUYDwgyfLKxKtzsFQE9yKvGkGiIubk1zf0erMwa6lLgnw
   Q==;
X-CSE-ConnectionGUID: Xfixt+o9SpCLdlfoOlr7rg==
X-CSE-MsgGUID: Jm1eQJGXQ0Ca1ClfkKMbMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464008"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464008"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:11 -0800
X-CSE-ConnectionGUID: 535pQ2ZcTSKJGP3YTACr/Q==
X-CSE-MsgGUID: Gt1TYHK9R7K5tt+Px0/AWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215604"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:10 -0800
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
Subject: [PATCH v5 3/9] cxl/region: Factor out cxl_port_peer_distance()
Date: Mon,  2 Nov 2026 12:15:58 -0800
Message-ID: <2e8fe982c9bd23ebfa1429dee8d593f028660db7.1793649898.git.alison.schofield@intel.com>
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

