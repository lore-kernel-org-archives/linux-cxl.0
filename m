Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B69233721
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678034; cv=none; b=JlJwHPcQZ+DSlkAuQgaJbjg163DcNC49lRLVoerKsx7hay5Xp6+Al8FqklqYaR7g/vviK3g9uRapB5jPsq+UmBLIwZsubAGxGNPfaF4tbYsKlf1XlV9Gs/UYogUedR6KaFu9eG1LN6GXg+O1lxbPmUT4GDcP9X3Qz6J8e8AsKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678034; c=relaxed/simple;
	bh=/ALjmsZhGm5qgRh1cjtuEzswv7yUduzuV/qQopdhnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjHVLG72aiFIV1fn6cRtaWx6Xk7AzNeTjplXdhPsZGIqC5Gzs7NzH8EOkmh26S0+1/1nKJW0wxI8NZs+mUZy0FzWCS/rFBjBYDPKrBmy3dBNl5ymGqFTC0SjyOahU6Tyk32C6D5KcapuUrxY9xXwaCb6H/0fNUrsZ+WrHv41uuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEodRBKx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEodRBKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678034; x=1823214034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ALjmsZhGm5qgRh1cjtuEzswv7yUduzuV/qQopdhnlU=;
  b=bEodRBKxEyPSzYNg9aYUxoiwo1P9Neip5fEpuGCcPcWApVkFOu+Z+Me7
   x1sH+mxsQ/uc5v5OtPs3UH6VDUpq0IoPUq1yNOqhtMJEQgx3wgHn26bzh
   rKtmn4Tk48/1kgq9yeUePtR5hKQ1wIvxdxP02Plpt8pMf+SaeimaehSCK
   DxDReUxZc1uvszjr5QYv3Nx5RdU/NTjEw2eMAoCMkyMHPQu0I84Q69kTK
   NCv99wJKxsoUg56CLOUNF320A3wmQJUFa2sOvlIM4yDd6g+OhSdS8OgEH
   BOQPrIrc4fWBxRz0uTYVWdnNgfggUY5JlRD1FxK9f1IKz7fetfLM9RIcz
   Q==;
X-CSE-ConnectionGUID: upSbMzWOQPOe3awcYvgv5A==
X-CSE-MsgGUID: KeE76+TvRBqF/5wG+HXtFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459340"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:33 -0700
X-CSE-ConnectionGUID: NGcMUCDNQ6m5lxGhBL8oWg==
X-CSE-MsgGUID: 60Ym54yPSOie7i9KRh3YVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679061"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:32 -0700
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
Subject: [PATCH v2 5/8] cxl/region: Factor out cxl_port_parent_interleave()
Date: Sat, 10 Oct 2026 17:20:20 -0700
Message-ID: <8c6a814ae214bee5d0fd4345dbd6c52dc23930db.1791676454.git.alison.schofield@intel.com>
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
index b288421203a9..a4688c6b54cb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
 	return distance;
 }
 
-static int cxl_switch_port_setup_targets(struct cxl_port *port,
-					 struct cxl_region *cxlr,
-					 struct cxl_endpoint_decoder *cxled)
+static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
+				      int *iw, int *ig)
 {
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
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
 
+	*iw = parent_iw;
+	*ig = parent_ig;
+
+	return 0;
+}
+
+static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
+{
+	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
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
 	child_iw = cxl_rr->nr_targets;
 	if (!ways_valid(child_iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-- 
2.37.3

