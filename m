Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44E3A0B38
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265348; cv=none; b=D8NOEfQVc0KAskHbvPYDpHCjvDmk95BbP/HaoXB/DCIumSUi0KpJuiGsfyQeHhlAIlSUqycl7C6Q0g2w5PpzXYOzvyqB7XPEq0gEE1gh3Fd9cZNkahMQrgUMAcTmpEnTGwloCwLv1OIlHoU/OLeIlRAgiSGVtzToibO3VbakT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265348; c=relaxed/simple;
	bh=E6OUD8oDsfB1Bexj9r3yuhToNjIIS4B7Z28j/1m4yuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcKU5oXhLf5HNvI0gAzU9IwKJSydjsdBcjETqkKQOyHd9jOWmczzsYn37Nm/AZfndDbegZaLv8oRWLxRaHadFIXH1E/vZ5GgAjZOIKECqQB9N2nTEPOV7cdlsAXvYm7n0pQ3rFpPZr+FOqzwXZEOXztKWrPRcXgsRa5JwHLeDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvuwgENF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvuwgENF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792265345; x=1823801345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6OUD8oDsfB1Bexj9r3yuhToNjIIS4B7Z28j/1m4yuA=;
  b=cvuwgENFMw0wrRtAeuEQOYD8dn8WLKinmqJjb52ScVTNMz0zwtQD4LcY
   BpK6ZATMkdn3rR1bVfWr9bs6SmmcU0uAuVF/0EZq43X+WziANCkgsCj8T
   pCgqhrOleTItOGY5GQnlyj9bwbe9dnBeOHfLb1AzF2wX9MNpudMFrjXXR
   VIX3anTCpzVyZSar4kLRVR22fJQDm748Dwuk86jvnbJzdmfq5LHY7jJTf
   icMbuaoDFiEZGa0OC4zXE0M0JLcD5D5AVP5BU4ZKdlq/mLEJgjTf5Mkfs
   YYqr/smx2zrjzxTbVHoGBCAdg228cImBJ8z8o4yfle7SDZyxicGq50UTx
   w==;
X-CSE-ConnectionGUID: ivGoKpAmRv+eme4muP/K0Q==
X-CSE-MsgGUID: vxj6a3paSH29MuKyDSdOkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1011839"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1011839"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:04 -0700
X-CSE-ConnectionGUID: 3T+COgzlTGma/G0BDo3RnA==
X-CSE-MsgGUID: +M9t9uNaTV2g4OVbeTglcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2663068"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 9/9] cxl/region: Factor out cxl_switch_port_add_target()
Date: Sat, 17 Oct 2026 12:28:55 -0700
Message-ID: <c9206012afa920281f0145554a13b555cf835fd5.1792263750.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
port's decoder target list. For an auto region it checks that the decoder
already targets that downstream port at the next position. For a user
created region it programs the downstream port at that position. That step
is open coded.

Move that step to a new helper, cxl_switch_port_add_target(). The helper
takes the switch decoder whose target list it updates, which makes the
scope explicit.

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 59 +++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2a64ecf656b7..d6a5dbe65d26 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1612,6 +1612,41 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
 	return 0;
 }
 
+static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
+				      struct cxl_region *cxlr,
+				      struct cxl_region_ref *cxl_rr,
+				      struct cxl_endpoint_decoder *cxled,
+				      struct cxl_ep *ep)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxl_rr->port;
+	int pos = cxled->pos;
+
+	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: targets full trying to add %s:%s at %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
+		return -ENXIO;
+	}
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
+			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				dev_name(&cxlsd->cxld.dev),
+				dev_name(ep->dport->dport_dev),
+				cxl_rr->nr_targets_set);
+			return -ENXIO;
+		}
+	} else {
+		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
+		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
+	}
+	cxl_rr->nr_targets_set++;
+
+	return 0;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 					 struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
@@ -1652,27 +1687,9 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 			return rc;
 	}
 
-	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s: targets full trying to add %s:%s at %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
-		return -ENXIO;
-	}
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
-			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
-				dev_name(port->uport_dev), dev_name(&port->dev),
-				dev_name(&cxlsd->cxld.dev),
-				dev_name(ep->dport->dport_dev),
-				cxl_rr->nr_targets_set);
-			return -ENXIO;
-		}
-	} else {
-		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
-		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
-	}
-	cxl_rr->nr_targets_set++;
+	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
+	if (rc)
+		return rc;
 
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
-- 
2.37.3

