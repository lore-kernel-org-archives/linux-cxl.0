Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC347F2CC
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865573; cv=none; b=efhxNrCSmsmfnVElNTUWnJKJRW1IDzj9ancPqZPteupqggzEEFJJ5BYiWgrtOrG+PZlEmteVh3hXxHN2AxzMk2Ax4r7JR4LrIZSzuny43BLKKL84i5IZ7Hp1tC06o28NnKmATEyoWB8XKy3zfS9OpyVN6+7t28fsH/W2e041PzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865573; c=relaxed/simple;
	bh=GPj6+wS8XF5P9hf9VxQVAQjg2kOHhGezdTJApc/DHaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7MDlAI05wMuLggLyakBBjK7L2SGXMdcZqhNbbE8objcV1V3GYyOVrt5J3wU1TXquW/qxL2dMpNTRPnMXPUbvwmIBexjMSKFrirvRaIkCSFmrc1t7eGRkD2bGJ4Weh4F/qeV2LnOd++jkFtnBdtPSWtHxvoNYcirElMux/tRPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXZDZYP6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXZDZYP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865573; x=1823401573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPj6+wS8XF5P9hf9VxQVAQjg2kOHhGezdTJApc/DHaQ=;
  b=HXZDZYP69uYD4Mkzq4SdfmuzPFKUgHuSgBeBVvNLl2OAlr9KG9b57zeO
   7nvPMkAKND5jIPYijvJEdJPgp5I9Fsc9ty8yqpv9utGfmpSDxkfPSNrIy
   ghXoXyr/BTjZ6rsG9PJcyObdhWrTGmpsHS2adD3smyo7XMYwWKl874S75
   ujTNasnEYAXXBeKRV6dN4o8gW2IXmARb1ahciR1zgg2V0bZy0bbpx4M9N
   koB1maywhYrl9S0YNu54ikurpZPYxSj9v2wyDqX5opsdD9Kh/p0XNRn6T
   3Mx5Tr4FcMlWLa9/INdLIIjYFOzcARPnyG/3rSTySq/7OpqYtSSy3RgxD
   w==;
X-CSE-ConnectionGUID: wwqfW32dTBC5ZNWgehzVwA==
X-CSE-MsgGUID: qjt6OmdeRH+L/Kq8nWA48A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455485"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455485"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:13 -0700
X-CSE-ConnectionGUID: GWIfnIIgQn+b51Ky6VgRFQ==
X-CSE-MsgGUID: GT3HQ57ATd6B2LudofsJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391089"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 4/7] cxl/region: Factor out cxl_port_parent_interleave()
Date: Mon, 12 Oct 2026 21:26:00 -0700
Message-ID: <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() derives a decoder's interleave from the
interleave of the decoder above it. That parent interleave comes from
either the root decoder or a switch decoder, and each case is open coded
along with the parent validity checks.

Move the parent interleave lookup and validation to a new helper,
cxl_port_parent_interleave().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ea281ce4ec49..c14ac041c4ac 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	return distance;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_port *port,
-					 struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
+				      int *out_iw, int *out_ig)
 {
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
-
-	/*
-	 * While root level decoders support x3, x6, x12, switch level
-	 * decoders only support powers of 2 up to x16.
-	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
-		return -EINVAL;
-	}
-
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
-	if (cxl_rr->nr_targets_set) {
-		int distance = cxl_port_peer_distance(port, cxlr);
-
-		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
-			if (ep->dport == cxlsd->target[i]) {
-				rc = check_last_peer(cxled, ep, cxl_rr,
-						     distance);
-				if (rc)
-					return rc;
-				goto out_target_set;
-			}
-		goto add_target;
-	}
+	int parent_iw, parent_ig;
 
 	if (is_cxl_root(parent_port)) {
 		/*
@@ -1539,6 +1507,54 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
 		return -EINVAL;
 	}
 
+	*out_iw = parent_iw;
+	*out_ig = parent_ig;
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	struct cxl_switch_decoder *cxlsd;
+
+	/*
+	 * While root level decoders support x3, x6, x12, switch level
+	 * decoders only support powers of 2 up to x16.
+	 */
+	if (!is_power_of_2(cxl_rr->nr_targets)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			cxl_rr->nr_targets);
+		return -EINVAL;
+	}
+
+	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (cxl_rr->nr_targets_set) {
+		int distance = cxl_port_peer_distance(port, cxlr);
+
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
+			if (ep->dport == cxlsd->target[i]) {
+				rc = check_last_peer(cxled, ep, cxl_rr,
+						     distance);
+				if (rc)
+					return rc;
+				goto out_target_set;
+			}
+		goto add_target;
+	}
+
+	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
+	if (rc)
+		return rc;
+
 	iw = cxl_rr->nr_targets;
 	if (!ways_valid(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-- 
2.37.3

