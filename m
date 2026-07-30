Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7343D8901
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450065; cv=none; b=nKIHkmSMEZ+lcNgmBkpI8qm/fXcH/Psx/JXVyw7DFp4WH1wGwgoBoh2Aj/pg0D0d1GnmcSvOhCZs3435/9vDTBvoLm689YSoU/OJShRyVaTjLWpSytKGwRq5XBFyvLtxRanAGcYnKGaNlnKtgGMqtffJEE1RpH50fxxs1V2J3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450065; c=relaxed/simple;
	bh=PH0AlGQrBxNvW3g4huRIGTMIJ/Rw2vW1Tsw6SoYTjsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhx4D5oVVrWY38chxdSz9OWgozyY0ln7yqcbIJWMBL3SGblGk1kroXkrkFBnDN8byv8Jp6JioaIsu2oRZ4nEXcC8o8UxAp7LMYr8zPv4Q/xVgVYdI90eOo64VvKJHL2+5LDTcTWKIj32KWNpDQNarkTfbDqneiioWs8N7q+wQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+4xA0SS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+4xA0SS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450063; x=1816986063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PH0AlGQrBxNvW3g4huRIGTMIJ/Rw2vW1Tsw6SoYTjsI=;
  b=U+4xA0SShdllFmtQx3S/5sbxkA937crxC2PHhgpc0Wy081vZWugt3HMs
   xjzBUabQ7so4ossaWlWR1ZQf6zWZazA1YWKYXXMeZz6CF4l2/CwmP63Hj
   483ZuBkA91isl4AXW09ghl6dDcDouswnder/MNeXCiUPE4J4KoOqfZZxg
   35y16dB/foK5aexsO+A/SF7e7UoLo7JFC5WX72KgJUBhXoLZv0k1NJz5R
   WNpmvp8zXYpD6wTkhYSUcLpgCzm02JjAZJHp6Fo2RGQ8r5w8Rto/IQKI5
   +stpI5JKNmQYiMDEOy5LdZtLYLfjzdSDDqg2sNJB55gnz7Vtu6odEp4vp
   A==;
X-CSE-ConnectionGUID: ceukfXeNTKONz7X3pvTQRw==
X-CSE-MsgGUID: ZIySn699S0qcfcr5ssCMMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665395"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665395"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:50 -0700
X-CSE-ConnectionGUID: e8q1QQlET9yjbutqsKV3Kw==
X-CSE-MsgGUID: OSP0krqoT5q4Wnj5E/l5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482259"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:46 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 6/9] cxl/region: Enforce coarse-to-fine ordering for mixed-granularity regions
Date: Thu, 30 Jul 2026 15:20:26 -0700
Message-ID: <c0c02a889a3e53d0daa5e69ad92cc6a3e88f1732.1785444498.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With mixed granularity allowed, selector disjointness alone would
accept an arrangement where an interleaving level is coarser than one
above it. The position arithmetic cannot represent such a layout: it
assumes each level below the root refines the one above.

In a mixed-granularity region require each interleaving level to be
strictly finer than its nearest interleaving ancestor, and reject a
violation with -ENXIO in check_gran_ordering(), called from
cxl_port_setup_targets(). The value validated is the derived
granularity on the user path and the firmware-programmed granularity on
the auto path. Same-granularity regions are exempt; their levels
legitimately coarsen away from the root.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3919f64e2467..b4e8ebe158f7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1680,6 +1680,50 @@ static int derive_port_granularity(struct cxl_port *port,
 	return 0;
 }
 
+/**
+ * check_gran_ordering() - Check mixed-granularity decoder ordering
+ * @port: port being configured
+ * @cxlr: region under construction
+ * @cxld: port decoder
+ * @accum: selectors used by the ancestor decoders
+ * @iw: port decoder interleave ways
+ * @ig: derived port decoder granularity
+ *
+ * The mixed-granularity position calculation requires each interleaving
+ * decoder below the root to use a smaller granularity than its nearest
+ * interleaving ancestor. Passthrough decoders do not participate.
+ *
+ * Auto regions validate the firmware-programmed granularity. User-created
+ * regions validate @ig.
+ *
+ * Return: 0 on success, -ENXIO on invalid ordering.
+ */
+static int check_gran_ordering(struct cxl_port *port, struct cxl_region *cxlr,
+			       struct cxl_decoder *cxld, u64 accum, int iw,
+			       int ig)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	u64 val, ancestor_gran;
+
+	if (!cxl_region_is_mixed_gran(cxlr) || iw <= 1)
+		return 0;
+
+	val = test_bit(CXL_REGION_F_AUTO, &cxlr->flags) ?
+		cxld->interleave_granularity : ig;
+	ancestor_gran = accum ? (1ULL << __ffs64(accum)) :
+		cxlrd->cxlsd.cxld.interleave_granularity;
+
+	if (val >= ancestor_gran) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: iw %d ig %llu not finer than nearest interleaving ancestor (ig %llu); coarse-to-fine ordering required\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			iw, val, ancestor_gran);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 /**
  * cxl_port_setup_targets() - Validate and program a port decoder
  * @port: port being configured
@@ -1762,6 +1806,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	rc = check_gran_ordering(port, cxlr, cxld, accum, iw, ig);
+	if (rc)
+		return rc;
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (iw > 1 && cxld->interleave_granularity != ig) {
 			dev_dbg(&cxlr->dev,
-- 
2.37.3

