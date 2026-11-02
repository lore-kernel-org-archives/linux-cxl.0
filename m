Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650576;
	b=sbh2IDnMKyoKy22cbf09kOx8XzZywhpj1ScARaM+gZo9a4vgdhcKe4Pimewce7uz8gAv
	 3MXyZqIw5exossJq1cRB2shLjGaxMpg6C5mGymOqkcXgXivWKie5wLwpgMOMpDqL9l3SG
	 84t4MZ0EUdb7f6YX45BlLG4AHmVqcVqg47bgpmqGuNiQzif5650GRgtuNp19GfzzOhj5s
	 QNYGZuM0HiAI6AvaVgQ5HIlnpYE6BaPIksFGsSB7hKOAGAa4NhcLNFTX8XiXs/Kvdvuy4
	 MQE5d+Lb1bedI+0GzXXHUX1j17be+/AuZvHzKyLR2GMrVACj5HF3mXqfdyg1c92yYkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650576;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XB3cbY11/mxKmJEofajCrEzjmdgx4eqkqHOfw8K+pgY=;
	b=5gmckdjz50ubWdzwNxxL3MTKwh8cptRd7IObDf6J9n+6gMX77+GxWvZvbKjia8vGLP4P
	 pgmykNZqMjgo0QOq/W4t/n67pX2ANst3Hss2uuvGP4MXYTzeAvKOfzcF6jSsVl3WZ/2FC
	 PhgEH51fzOr0+/i1EH+eza6whpDzWqh8juTH2UmbNhMAN4mkrWrXRO+pGsu6ABDgUWTCB
	 GcOHY9thP83338uhJlGLQIMsrZIm1fUvlrM9/Epr4zE7XkgRicKea2Ne8jo0g2rUjmTSb
	 sSCyAUG5Eq6t5ItKUAURDVxKdtrG4P4G3KRClAGU0nDA5alP9ehW0CjB6J62Eetmo8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QcniTRls;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA987606A324
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA987606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QcniTRls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650576; x=1825186576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZgCgwIijH1v5dke/g4bm6KtQP7Rkui7UgCR39PX8lE=;
  b=QcniTRlsYBY6ifOEkNoeGgPfq9l1KHy/78n7FQ/MQjUuC69O66SVm2Ol
   beAtIe5WBq3WWDD2++O5okv0DhBLaETkQsG04UEqGxctddFxCJkL9HyBe
   mE3r0/dzgEkFXJ4fnj1A9TnGpQFJI0LGCCMqkgK7NXpAm13IfdEIim6bL
   feDEoOXKWg7J0tvYeMnCSD7x9yN7BU0rgF8KPTEdll9YzMzE9TXZ22s0L
   nWbNTFj78oH74z1E+Rb3dZ5LCO6X87lLwdBEMVEEZXvZVcWjJRuCJbpbC
   iLB3YdGShVygXzne/rA95TDDRhOrgySvIMw84fiLZAzALvnnrwgK2sxeZ
   w==;
X-CSE-ConnectionGUID: qW3HpR8VQhS4XB/9B83x2A==
X-CSE-MsgGUID: +ujvSdGNQTqBhlbbxBJUtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464048"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464048"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:15 -0800
X-CSE-ConnectionGUID: gxWdx2SqQwm1TjzQ2afeGQ==
X-CSE-MsgGUID: +0RII5xhQZWyBTToje0OrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215632"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:14 -0800
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
Subject: [PATCH v5 8/9] cxl/region: Simplify switch port target setup control flow
Date: Mon,  2 Nov 2026 12:16:03 -0800
Message-ID: <901d24894022720ac56aed9c172d7a4682a26cd7.1793649898.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() searches the decoder's existing targets
for the endpoint's downstream port. On a match it checks the peer position
and jumps to an out_target_set label to log the target. Otherwise it jumps
to an add_target label, skipping the interleave calculation and decoder
setup that only the first endpoint to reach a port needs.

Return the peer check result directly when the downstream port is already
a target, and make the first endpoint's decoder setup the else branch of
the target search. Both labels go away.

Returning directly after peer validation also removes a misleading debug
message that reported a reused target as a new assignment, with a bad
index.

Suggested-by: Li Ming <ming.li@zohomail.com>
Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 025cf21adfa9..2a64ecf656b7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1635,27 +1635,23 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	}
 
 	if (cxl_rr->nr_targets_set) {
-		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
-			if (ep->dport == cxlsd->target[i]) {
-				int distance = cxl_port_peer_distance(port, cxlr);
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++) {
+			if (ep->dport != cxlsd->target[i])
+				continue;
 
-				rc = check_last_peer(cxled, ep, cxl_rr,
-						     distance);
-				if (rc)
-					return rc;
-				goto out_target_set;
-			}
-		goto add_target;
+			return check_last_peer(cxled, ep, cxl_rr,
+					       cxl_port_peer_distance(port, cxlr));
+		}
+	} else {
+		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
+		if (rc)
+			return rc;
+
+		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
+		if (rc)
+			return rc;
 	}
 
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
-	if (rc)
-		return rc;
-
-	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
-	if (rc)
-		return rc;
-add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: targets full trying to add %s:%s at %d\n",
@@ -1677,7 +1673,7 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
 	cxl_rr->nr_targets_set++;
-out_target_set:
+
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.37.3

