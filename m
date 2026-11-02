Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650576;
	b=LWlkyvUjdzejG2skVIb6oG0B8JlZJzTL7azVKXqcMm9fJs8qvB8ooDsWjMV4VlUE+e2L
	 DSlAhA9JLbpSV5SX/RLnFvWoQeVulGGPcUz6fcPiGCjZ4hnRwm3r6RbqVAsK4InPapTtC
	 u7WfCYeAa17HcuoYj+Z4Tjp0LeOzQuYKzXf4sBLKO1dYRGQZ6oM8X+lHWB4nBXKWm0xUy
	 XNPEVdny8nKWu0shyXD1Q1ARbnqkaIvViILpdAdARZEtaHYWJZxFClbJW7ksEc6vIT8iL
	 IC71nraYzqy7mGZ0trkieDvBuEfVtbWposP9b8yJdKiv92Sq8ogPGZ22WRoJgAQnSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650576;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TbVyUni2GWS9V+k5KIx3YGRJeHypl3NDY9ZCsSgcvDQ=;
	b=lsUpmU+iLyN/JOIbqQ4I0glLnaxPrlf7+GzmBzKsQbzu8oY3tmCxW5/CsFnInCqcF+Hz
	 mIRyWiL/M5qGlonMDb6u1/PWWGgChvkSH+TcPzL14SBE/TNmUWyp0S1YCsd6KkgwkZLQv
	 FEZIbo4LiZwnwxtRzWo2Oal0NKnTOF9Q/vtjYZplwY5PuKd3nbkGq0Hg9+oHKmHA1xAU3
	 CR7YCX9ORlkAaAnd7YtR10UqMlQIXxm/+KMPdlDG5UiaX0yr9oUGvo08YzorhI2rTVkoG
	 adWlJtAc7A2HzDD0IqB0Nx5uiM8qi991L0mRlr/CIqpbp5w3nzru1k5DDW2l3YAwo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aivDtZr6;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989B606A32E
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8989B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aivDtZr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650576; x=1825186576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E6OUD8oDsfB1Bexj9r3yuhToNjIIS4B7Z28j/1m4yuA=;
  b=aivDtZr6wEgb0Ye98UbFxLfYXvK8GD3v7rxN4NR3LKP9nxYONZLhH4mG
   8bAnH/OLlDxBxN/r69hrBLluwBSH3UkVTKQmFG147zgRS6notnRRXWrQx
   8MTAsTp+RqZ5Msjg3bl3/EBdb4BD92eeul9TV0jXIYCVkvQl2+Ny8Iz5U
   jbp7hAZpopfaEoqZvAvTjFe5W0x9WJjyKxN3XKc7QGrtCGRnbcDuNKty3
   L5D1ed57tZyNx3SJtfyR90lk5Cl9bKjLKSNoR9Qhwb9TdH83kYvq+o5/0
   vD1ggck29cSkeZs+ilxiUGE7DYxRF3QxdI9CVilhLKoLlmSy5jMz6qAgA
   g==;
X-CSE-ConnectionGUID: L6o5bEBsS0CR5Im5qUdscg==
X-CSE-MsgGUID: B0WuYInjQJSQXm0iY6mGEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464056"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:15 -0800
X-CSE-ConnectionGUID: 86L+OfUDS5ex363TpSMWpA==
X-CSE-MsgGUID: fHWGgS7pRYCUf1KZwaIHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215637"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:15 -0800
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
Subject: [PATCH v5 9/9] cxl/region: Factor out cxl_switch_port_add_target()
Date: Mon,  2 Nov 2026 12:16:04 -0800
Message-ID: <0a46cfc2e9da5e92d0cc263f08b424a785c627aa.1793649898.git.alison.schofield@intel.com>
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

