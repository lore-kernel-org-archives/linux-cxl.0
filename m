Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6762F25
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461378; cv=none; b=KzwORg7CJsDzFCC+KakhfyVqPuHEB82Qq0T63tl5ki5KqLdGW+3ZuFgujB26r0/9uKKTrgzAJbVoxQTHVnEDpqzeYhLW2C/OjUUubaGCdIOQzvZ1y3MDdo/waPZO+/rEwPWLYSIJq3NT+3kNUAYNgEJV3LKSNC13zCEG/4Q2xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461378; c=relaxed/simple;
	bh=mJoc4sYPY4j8zElZancDAANufJbqxJamxk8efqJmtCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwfcDpSeBv5uD/idTXmzKGtwkagpdEbyn686T/dVNi9+ePaB52Onj/KShL8ftEkIXDTw4m9oXPJB2Vb6Wcp9VV/ueHwl3KFdStQVXgRarKiItifx525jKaFTxVxRf2LDDxtmJ7SWsSEZDfOKKkYn1gJlE1jf7Fdk9uf9myihUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/EQpg+M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/EQpg+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717461375; x=1748997375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mJoc4sYPY4j8zElZancDAANufJbqxJamxk8efqJmtCI=;
  b=A/EQpg+M0H8Rh0qQw/xAQQyj1D5iOIBks0DFYeYZVSxjSXGjAuKWpQdp
   fBnjyfdqzo0aRviqtrXGnc7voJxOYRrjYywIDPGEBfWLcGIhNyWtlNWvM
   JFN7D72KtYNZgfbMZnDkkrsfuX94j8mdnwe5r2eN25ryHeZ4+3qA++U36
   c+7YAJQPZbQ8/yilatu0JpmPTEsjbTfxybgwAYX+YPiB0w/xcOU9Tddlx
   PiIlmCknwe/N1dmLsFcmmGhjdV62Mec4zmqEUuWtxAmWDZrDiQl1GdaXZ
   WPX/oRqt2Gz5XN5NKY50oedDRmwhUCX7f7VEY+qha6lSAAkBxDr4cikok
   w==;
X-CSE-ConnectionGUID: X2PHANwNToeyx2PeBKGuCg==
X-CSE-MsgGUID: ddjqrI//Q2KRwxNwVyLrBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14100387"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14100387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:36:15 -0700
X-CSE-ConnectionGUID: pASEq7fVQrSuPSyI5tEEbw==
X-CSE-MsgGUID: p2wVOv0QTiCpnKFB9IUtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37677862"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.116.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:36:14 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Avoid null pointer dereference in region lookup
Date: Mon,  3 Jun 2024 17:36:09 -0700
Message-Id: <20240604003609.202682-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

cxl_dpa_to_region() looks up a region based on a memdev and DPA.
It wrongly assumes an endpoint found mapping the DPA is also of
a fully assembled region. When not true it leads to a null pointer
dereference looking up the region name.

This appears during testing of region lookup after a failure to
assemble a BIOS defined region or if the lookup raced with the
assembly of the BIOS defined region.

Failure to clean up BIOS defined regions that fail assembly is an
issue in itself and a fix to that problem will alleviate some of
the impact. It will not alleviate the race condition so let's harden
this path.

The behavior change is that the kernel oops due to a null pointer
dereference is replaced with a dev_dbg() message noting that an
endpoint was mapped.

Additional comments are added so that future users of this function
can more clearly understand what it provides.

Fixes: 0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..88051bb673bf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2688,22 +2688,33 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 {
 	struct cxl_dpa_to_region_context *ctx = arg;
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
 	u64 dpa = ctx->dpa;
 
 	if (!is_endpoint_decoder(dev))
 		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return 0;
 
 	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
 		return 0;
 
-	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
-		dev_name(&cxled->cxld.region->dev));
+	/*
+	 * Stop the region search (return 1) when an endpoint mapping is
+	 * found. The region may not be fully constructed so offering
+	 * the cxlr in the context structure is not guaranteed.
+	 */
+	cxlr = cxled->cxld.region;
+	if (cxlr)
+		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
+			dev_name(&cxlr->dev));
+	else
+		dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
+			dev_name(dev));
 
-	ctx->cxlr = cxled->cxld.region;
+	ctx->cxlr = cxlr;
 
 	return 1;
 }

base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
-- 
2.37.3

