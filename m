Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AD49B464
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577495; cv=none; b=hFFN3mykononkjZ4mQBriz4EtjMdgTqmc4lsODqqDKF2kgQDF2lLUArDe9l1niZ92R3U8Prf+Z/KEhrv/9fHpFXUFXZmam/h/FSC2rvkB6AwKh3wWNx0vQ094SM8amxuLTQ+ib9mWwkte76KJaFFtfxZi/UooTJd9+T8WoClRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577495; c=relaxed/simple;
	bh=tHflHAHwAlQZBFaWJaaL32WhlrRybHDCDPwfjCj80UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7zMKixEpSqUq05Q3O9BDQesWDISiOvOLGTUyc0mwY8QWhpgpjEr3/wG3g5FtJyXnr7eBXPtEFkKmD2LOMuo1qMkqx4Iem31mSlyR1EfdVrTJswDuuUh3+xowFX7C/8bOFuqBzfcfjVlKkwQ6QRMNcoXBxLWJlXk2j1E23x71AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oxs7w7aU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oxs7w7aU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577495; x=1823113495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tHflHAHwAlQZBFaWJaaL32WhlrRybHDCDPwfjCj80UI=;
  b=Oxs7w7aUeuC63BHeKkOTp/fa6TlO1wIx42vDbytPISJKOyasl4cAkz+p
   BSmmOoxUlYr9rPgYmiu6n4oeuX0JYxyWZUtWJFkPA5GikI8Hd7T4IExqa
   bEnYYGwmIP0NRuSakCSXGEWSp2t7MznjUw2ao8FivkBUwBosgmbRRK4K1
   sta1WdHUCzmuQRgRrdOZ6fKItZEXAVPnnxgE+XJwIKF6vkge4d5lkkQwL
   lnJdydHZrXu7Zc4GJ6kAVzvbC6r5rhPvgmpbsRvfqc+qNrFAENICdp97f
   zNMcVrSXjdPRWJ6k8A79b91hxExYSMuos7M56GF2P10MyoUlqblbr2kSu
   g==;
X-CSE-ConnectionGUID: JgnKxXKgTeaePaDEWhJzAA==
X-CSE-MsgGUID: AvxwilUDQMuvTj9nkQOxHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="377069"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="377069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:45 -0700
X-CSE-ConnectionGUID: tua1+nbXS0qVv1yn+pnzPw==
X-CSE-MsgGUID: ySFLCTvcRVqgT99bdlEhRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743037"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:43 -0700
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
Subject: [PATCH 7/7] cxl/region: Factor out cxl_port_add_target()
Date: Fri,  9 Oct 2026 13:24:07 -0700
Message-ID: <a9855ed2663c8f93ac4b1c881eefe3c301dfc39c.1791575481.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791575481.git.alison.schofield@intel.com>
References: <cover.1791575481.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() adds an endpoint's downstream port to a port's
decoder target list. For an auto region it checks that the decoder already
targets that downstream port at the next position. For a user created
region it programs the downstream port at that position. That step is open
coded behind an add_target label that the target search jumps to.

Move that step to a new helper, cxl_port_add_target(). With the decoder
setup and the target add now in helpers, the path for the first endpoint to
reach a port becomes an else branch of the target search, so the add_target
label is no longer needed.

No functional change.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 82 ++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4e9b0880663d..abe5fcc62e9d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
 	return 0;
 }
 
+static int cxl_port_add_target(struct cxl_port *port, struct cxl_region *cxlr,
+			       struct cxl_region_ref *cxl_rr,
+			       struct cxl_endpoint_decoder *cxled, struct cxl_ep *ep)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_switch_decoder *cxlsd;
+	int pos = cxled->pos;
+
+	cxlsd = to_cxl_switch_decoder(&cxl_rr->decoder->dev);
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
 static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
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
@@ -1641,38 +1676,23 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
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
+	rc = cxl_port_add_target(port, cxlr, cxl_rr, cxled, ep);
+	if (rc)
+		return rc;
 out_target_set:
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
-- 
2.37.3

