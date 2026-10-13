Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE5472F7D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865571; cv=none; b=pc+7nYVV2ndB/ZmtD2mMz0++GRmP9sFfMiS9pLQ2wpBXYH1Dneqw3K8avbLmZe7YXtQac/9D9W1dQJwLeAqoJJWpA+VPPL5nkEFPWU+n3XZgKH3Rws0NHb0QuH/fS/XS7yhjfdhkzApeU4Kld9D2rGmnIBHd/eT9RLThTBTMb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865571; c=relaxed/simple;
	bh=vMPeelziI85qMcj85Np8lMqK0SXPdAOx8Ft5XSsR5Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9iR11clhoIEvq8zHT6kWw1bB6JsgccQ6y5r5kvtTb7Vn8kV3lEcKi1NgaSbQHDH8ZENHu/n9MJH8LiFBGD24D+FISPMTVdxRBI+FGEf+20HT9aLgRiN7mp0dnmDxc236nqijLnPiGCE47dNTIVPfO4FpEhHcnpVQyIS7y+MK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AalyOMTP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AalyOMTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865570; x=1823401570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMPeelziI85qMcj85Np8lMqK0SXPdAOx8Ft5XSsR5Ms=;
  b=AalyOMTPME68btvNTlYNJpvDhpaX8+aUOcK5cIld5nipi0yarb+lsiVI
   DNlKZRMFm1DXnFPLPFwgfHE9SLTEiTxa9yIDAmFq4zG+5zSQJZAi8G3k9
   P7Eg6WrECujmQsnoTzAScQneSite0Pp6+42gB8iZNlheSgzbCmuGHPebW
   kGR5gBrbVYzL5NsXghtwY3ZQHSVyHi3EstWfwbipILxMjkzru9MHlRR+W
   EEPIu5W2IC0vNoY1P0wzdmRnM2IGKAsuMP3y/0TpL5lY3j9+0jUWsKY9Q
   +kRkPvVhzGtP64L0bYomQ0atUE/lGjFn0n19Vt0gVRAJFMP3v312xocgQ
   w==;
X-CSE-ConnectionGUID: S9LHHCk7RS+5rStfzqWEog==
X-CSE-MsgGUID: R4XJa/eWTAGv+cgDyaN7eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455470"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455470"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:09 -0700
X-CSE-ConnectionGUID: aU+bPAqMSiumLsb7+wRNRg==
X-CSE-MsgGUID: smuIPvU/QSWGlUV8nuRwlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391067"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:08 -0700
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
Subject: [PATCH v3 1/7] cxl: Add interleave encoding validity helpers
Date: Mon, 12 Oct 2026 21:25:57 -0700
Message-ID: <17c9c350c9e579cbc059b02e0e22ed513c54d468.1791860305.git.alison.schofield@intel.com>
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

Some callers of ways_to_eiw(), granularity_to_eig(), and
eig_to_granularity() only need to determine whether an input is valid,
but must provide storage for a converted value that is then discarded.
This obscures the purpose of the call and requires unnecessary temporary
variables.

Define and use new helpers that provide a validation-only interface for
those callers.

cxl_port_setup_targets() also encodes and then decodes its calculated
granularity solely to validate it. Calculate the granularity directly
and validate it instead, making the calculation explicit and removing
the encode/decode round trip.

No functional change.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 49 +++++++++++++--------------------------
 drivers/cxl/cxl.h         | 21 +++++++++++++++++
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..bc087ca63946 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -493,11 +493,9 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int save, rc;
-	u8 iw;
 
-	rc = ways_to_eiw(val, &iw);
-	if (rc)
-		return rc;
+	if (!ways_valid(val))
+		return -EINVAL;
 
 	/*
 	 * Even for x3, x6, and x12 interleaves the region interleave must be a
@@ -566,12 +564,9 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	int rc;
-	u16 ig;
 
-	rc = granularity_to_eig(val, &ig);
-	if (rc)
-		return rc;
+	if (!granularity_valid(val))
+		return -EINVAL;
 
 	/*
 	 * When the host-bridge is interleaved, disallow region granularity !=
@@ -1451,8 +1446,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1524,48 +1517,38 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
+	if (!granularity_valid(parent_ig)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_ig);
-		return rc;
+		return -EINVAL;
 	}
 
-	rc = ways_to_eiw(parent_iw, &peiw);
-	if (rc) {
+	if (!ways_valid(parent_iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
 			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_iw);
-		return rc;
+		return -EINVAL;
 	}
 
 	iw = cxl_rr->nr_targets;
-	rc = ways_to_eiw(iw, &eiw);
-	if (rc) {
+	if (!ways_valid(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
 			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return rc;
+		return -EINVAL;
 	}
 
 	/*
 	 * Interleave granularity is a multiple of @parent_port granularity.
 	 * Multiplier is the parent port interleave ways.
 	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
+	ig = parent_ig * parent_iw;
+
+	if (!granularity_valid(ig)) {
 		dev_dbg(&cxlr->dev,
 			"%s: invalid granularity calculation (%d * %d)\n",
 			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
-
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
+		return -EINVAL;
 	}
 
 	if (iw > 8 || iw > cxlsd->nr_targets) {
@@ -3131,13 +3114,13 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
  */
 int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
 {
-	int ways, gran;
+	int ways;
 
 	if (eiw_to_ways(eiw, &ways)) {
 		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
 		return -EINVAL;
 	}
-	if (eig_to_granularity(eig, &gran)) {
+	if (!eig_valid(eig)) {
 		pr_debug("%s: invalid eig=%u\n", __func__, eig);
 		return -EINVAL;
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d96210b8f147..8f0a79e7b8ab 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -146,6 +146,27 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 	return 0;
 }
 
+static inline bool eig_valid(u16 eig)
+{
+	int granularity;
+
+	return eig_to_granularity(eig, &granularity) == 0;
+}
+
+static inline bool granularity_valid(int granularity)
+{
+	u16 eig;
+
+	return granularity_to_eig(granularity, &eig) == 0;
+}
+
+static inline bool ways_valid(unsigned int ways)
+{
+	u8 eiw;
+
+	return ways_to_eiw(ways, &eiw) == 0;
+}
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
-- 
2.37.3

