Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854011A9F96
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678037; cv=none; b=PD27NBt4d+5U5MSQjGnNWQacCxMS17nMXfy6hvNkqvvu43bCupmsrKaA4zbII0sB+9wfUl1Wl0oha0DQBClTy88R/8G8u8qkIFGcwHMBlKIih0+z8/YQtseuZRMgxJ1E9GVWyj3b7GnwzAbY5SIlYEXhySHQAuqWUsM27xpZsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678037; c=relaxed/simple;
	bh=qM6vnR51VNHdWFO+ry+ZMcFEp4ZMr+qU0zB7MYditB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBZVu2QePd6MLLQR6WFdRw9yfU6VIzR6HwjW8uuTzZmKJTcD5azvKPNa6EmpM432c2cFwCX/AR15Jj0d5SKSnUHpFc00dEySfToHlJFzhOAqC50c9V5xE7BCAV26fuWiKgE41/5ANk10SplyxV5V6RWfboORNNI0OE280PnplN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2lCgzSh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2lCgzSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678036; x=1823214036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qM6vnR51VNHdWFO+ry+ZMcFEp4ZMr+qU0zB7MYditB8=;
  b=b2lCgzShPASUaBurl7oZjbhDSBzCPPv01m8qR6j3VwvdGqdCDHJOhjow
   gdehAA1QY/a941poxFsaJbKgzqi3gD1v9B2kZW2jYnZ01EjaTJDEmMboz
   H/l5sEVtedop/cfuxZdKbSWQ2+qnUXRHW3VZVXhbEiQE/HM3zXKBg/W8n
   abUvSumDixqBILLaXp8XGkfIM0BFVjCkrNVuDC0WKTF+bly0zg5JRuV9l
   SUBvUblXVqTwph/4fHWVI59k8Xw6MqJ3tohpDiqSSUOpoB9Mn1f9h27zj
   ZFcO/yV87LhCz116d8M4McQedZfv9EUIpAPP0Gl3ePMX26mP1pins2HXy
   w==;
X-CSE-ConnectionGUID: 99DE91RySX6j591tKJpUkw==
X-CSE-MsgGUID: eWsjy1BcRRm/M4Dj7M9/Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459358"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:36 -0700
X-CSE-ConnectionGUID: axqdG4egQD2+3TJQCNjM6g==
X-CSE-MsgGUID: vgA9Nm1cQV+IXLxq/xRoyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679075"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:35 -0700
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
Subject: [PATCH v2 8/8] cxl/region: Factor out cxl_switch_port_add_target()
Date: Sat, 10 Oct 2026 17:20:23 -0700
Message-ID: <108753432a27a29dcedca4c80f8b541f6aaaede7.1791676454.git.alison.schofield@intel.com>
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

cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
port's decoder target list. For an auto region it checks that the decoder
already targets that downstream port at the next position. For a user
created region it programs the downstream port at that position. That step
is open coded behind an add_target label that the target search jumps to.

Move that step to a new helper, cxl_switch_port_add_target(). The helper
takes the switch decoder whose target list it updates, rather than the
port, which makes its scope explicit. With the decoder setup and the
target add now in helpers, the path for the first endpoint to reach a port
becomes an else branch of the target search, so the add_target label is
no longer needed.

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 83 ++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 98aef1d5a4dd..c6039c991884 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1608,15 +1608,51 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
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
+		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] =
+			ep->dport->port_id;
+	}
+	cxl_rr->nr_targets_set++;
+
+	return 0;
+}
+
 static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
 					 struct cxl_endpoint_decoder *cxled)
 {
-	int child_iw, child_ig, rc, pos = cxled->pos;
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	int rc, pos = cxled->pos;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1641,38 +1677,23 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
 					return rc;
 				goto out_target_set;
 			}
-		goto add_target;
-	}
-
-	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
-	if (rc)
-		return rc;
-
-	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
-	if (rc)
-		return rc;
-add_target:
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
 	} else {
-		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
-		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
+		int child_iw, child_ig;
+
+		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw,
+					      &child_ig);
+		if (rc)
+			return rc;
+
+		rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw,
+					    child_ig);
+		if (rc)
+			return rc;
 	}
-	cxl_rr->nr_targets_set++;
+
+	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
+	if (rc)
+		return rc;
 out_target_set:
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
-- 
2.37.3

