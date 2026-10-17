Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212B3D902D
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265346; cv=none; b=b3P0uhlIdtRg0o8SxF91BOghMuiy/K9zHL2ILPC9CnsLjojnElXqc2yilYRp1DBMAZfj470d2Wzz8NKCVnUMT/PGLc/+f3zoB+0mUcfKWg4NyZRe3ua0LECGGI14yO0GaA4MNmbSlRYdrf5sWQNof6d/NbMQQRFOmIHUY7wvar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265346; c=relaxed/simple;
	bh=4ZgCgwIijH1v5dke/g4bm6KtQP7Rkui7UgCR39PX8lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKeOOG/aarAyvSRxe0Sb7jgrYADUE4PoXg8sFLDoRSytJcaStRWnwYVYua66CPaB79TQfiG25OcrrOmmyBKKRspd4PcJpVZH+5cYxmHZu6KPcwLPou6HZsVzoP3BHhAynM0a3BVwv4Mi4XwrJkCgCpKMgQxLzLmYFEu1Pdw4x+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2sXe1Kr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2sXe1Kr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792265344; x=1823801344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZgCgwIijH1v5dke/g4bm6KtQP7Rkui7UgCR39PX8lE=;
  b=Y2sXe1KrpJihUGJxwO7SB6S8j16SxMwqSFO7am7c656WIAcWHh/AlZwY
   sF8s6aY/6N/tAdgZHnWOKKTho6RGOO9JI9NXExNBTlCaIZ4ygaWlqCK43
   0KU4755ycPj2xcMrJcTY0svSOjwRZepMIU0JEfUGo0fjH5x7yCGDI3Wuz
   5ZGXkaXbDNdFtdaFrKbCn+vRpoQ+goKTv1QBG9yhrkn5QUKsYtbFt2oqT
   MANwzU1UeGR3T9dTtMXw8BZzNyd6YqTtU9+O+pTBq3iatNu4nhD1wxtnE
   Tkj/6aYroqjMujNl6wtl9bZAizOR2ayg5JlHx3xg25v/oHsqFQGPOybEy
   w==;
X-CSE-ConnectionGUID: eXJo1bglTeaGYpZvoyj0HA==
X-CSE-MsgGUID: kN/hlvr1TSKBdFcpquFVyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1011832"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1011832"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:03 -0700
X-CSE-ConnectionGUID: H7USHCycTfOEmr4V5kQJBQ==
X-CSE-MsgGUID: oONJ9rWdTn6md+rBfLlS7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2663059"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:29:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 8/9] cxl/region: Simplify switch port target setup control flow
Date: Sat, 17 Oct 2026 12:28:54 -0700
Message-ID: <4a6a854c35234131279dbcdf1cf8c2cece709200.1792263750.git.alison.schofield@intel.com>
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

