Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD11CAA92
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678036; cv=none; b=jzQxcS9V35gsLH8zPgPaigvYP/r7ah+i/R2ztY9387NhohKEhI/cEVDA2h3TBNtGo90eVjN0YVdVipSxOWtsbeOuBYtlD/4mIRKi1wqqAY/khF3yGP7YWzymc9vIr31IjdtVT3rj6XUU0S2NCsEVqd6HnJbDvGmDrv+VNBGpSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678036; c=relaxed/simple;
	bh=jUTN1wTmjKNT9KkhuJxkL3NIMl0dXcwwYxTSPgPv8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3RU0RANanp+lyqloKAdfovxRhARKWZDEFiYvLN3HWh20mcRTs/B/scNOAVpFyWFTT2PaBNOy/1DSWMqvxNC8l+keOoet4NDw0SqDiBr+Cgl7QSXcUcIRaSYECrxvuwYdGMPK+A09Z9pJQLDzCtN8NHLlmZJRTxZaESH6iLT1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctLlobJ1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctLlobJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678035; x=1823214035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUTN1wTmjKNT9KkhuJxkL3NIMl0dXcwwYxTSPgPv8C4=;
  b=ctLlobJ13SigS7Cvpghmq7JZ9dah2z7N9JtzYKgJINWnGPXYq2m84yJM
   8U+Dc5vew6cEg9N6faHR+42BpkEBULNLB0TsnliJacdxj/3/N9FfkbdO6
   0K916yGBSJT/VFk9JLjf4zUtNvzS/ugEixmBrO1WpQw6fbJXzIHru9jOv
   wS50stw31OEQ087k5lJ/DIhqIC7mXKgNj+M0c2hcXsKvn4ft11R3lsxvg
   eESMGbhxSrJbLtCHo1TwQEEkrQGoI0sBAW3zrl6brHTGiT/YrZciUqTzA
   C8djq35pZgmg8hACrF3KlfytyHVeQwHhh+qzjfcMrjvu23fD/Dm/7Y2WA
   Q==;
X-CSE-ConnectionGUID: oFKb6uuxQmCT3ywdpTUWtw==
X-CSE-MsgGUID: VDoO/53lRPCi7bc4yHb/Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459352"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:35 -0700
X-CSE-ConnectionGUID: ZHT6VZHNQQSLM9pTb4NG8w==
X-CSE-MsgGUID: F5sbhYb1St2zhNuImiL7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679069"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:34 -0700
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
Subject: [PATCH v2 7/8] cxl/region: Factor out cxl_port_setup_decoder()
Date: Sat, 10 Oct 2026 17:20:22 -0700
Message-ID: <6401d24cc5af18432766469cc0b074f71ffcb194.1791676454.git.alison.schofield@intel.com>
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

Once cxl_switch_port_setup_targets() has calculated the interleave for a
port's decoder, it either checks that interleave against the decoder
settings found for an auto region, or checks the decoder's interleave
capabilities and programs the decoder for a user created region. Both paths
are open coded in cxl_switch_port_setup_targets().

Move both paths to a new helper, cxl_port_setup_decoder().

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42daa69a40eb..98aef1d5a4dd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
 	return 0;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				  struct cxl_decoder *cxld, int child_iw, int child_ig)
 {
-	int child_iw, child_ig, rc, pos = cxled->pos;
-	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
-
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
-	if (rc)
-		return rc;
+	int rc;
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != child_iw ||
@@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 	}
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
 		dev_name(&port->dev), child_iw, child_ig);
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	int child_iw, child_ig, rc, pos = cxled->pos;
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
+	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
+	if (rc)
+		return rc;
+
+	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
+	if (rc)
+		return rc;
 add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
-- 
2.37.3

