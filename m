Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475139AEE
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738379; cv=none; b=Eqlsk+Pa/q1ZdOBZMHKmgCVuiBtqpBaGesyi3QbTvsLG5eVor4v46db7u9/TFY5tGQxkg2FPHV3VzGSkIW5hBfAxWAiOZrCVvTK8PGVYzT/lD1MrV0SBHKcfhbkqyV3E/Yu9bufS/il1OEvjs7Q9BIoZeMf3UzXIM3LZmCxWrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738379; c=relaxed/simple;
	bh=1j/Hm44zXG32we2KNQio/SvUYluJazkTrdmhImuD8iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AM0nKh1boUVlqqHo00e4Vsj8pmko4bf4x39PYviNcWlCEDLUJtQ+AY9Pvc8H6qnygE5hreqjwVHDwZY196G//VsCHK38DesEbvemk+xWvuXS3tjOtQG1MXgCn8ikMLdDDVsHop2AF+1zuBQTonvkUPxFdIhDDBs9Z/9MH8kpigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmhvvmgA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmhvvmgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706738377; x=1738274377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1j/Hm44zXG32we2KNQio/SvUYluJazkTrdmhImuD8iU=;
  b=dmhvvmgAn+XZRhoCPlJ98O3Uj/aXvSQQgTCRDeTYy62TSAGE0+jtVepU
   20nxaHcpz3R14abWTwRb5A3Ovu3jV7+ERo/ZAeOqQRhtPdHtOgaLkBMf9
   IcdD8jdFmaiiwWNxpaRbjnApobv9BxFHl4sl4Y2hO9pVt4z8Gl0AiAVWq
   MusseelM//MDDCHbYyjTs6pFI6cuFW5zhii8YpUkrUX3x176IT8uf1id8
   rBftaUKmtNreAg50IfVFEAzysdJYxN2dXgs9aSYw9NS9u7QXBs9Vn0XMi
   jX5DTopYP1RqTq8MD6TEI+SzFOYmix0KyDGV/HaB0kRYXaab5Iwd72G1e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2675445"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="2675445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931989693"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="931989693"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.39.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:59:35 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: [PATCH v3 1/2] cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
Date: Wed, 31 Jan 2024 13:59:30 -0800
Message-Id: <79ae6d72978ef9f3ceec9722e1cb793820553c8e.1706736863.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706736863.git.alison.schofield@intel.com>
References: <cover.1706736863.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

In preparation for adding a new caller of cxl_region_find_decoders()
teach it to find a decoder from a cxl_endpoint_decoder structure.

Combining switch and endpoint decoder lookup in one function prevents
code duplication in call sites.

Update the existing caller.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..7af40d9cf80a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -730,12 +730,17 @@ static int match_auto_decoder(struct device *dev, void *data)
 	return 0;
 }
 
-static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
-						   struct cxl_region *cxlr)
+static struct cxl_decoder *
+cxl_region_find_decoder(struct cxl_port *port,
+			struct cxl_endpoint_decoder *cxled,
+			struct cxl_region *cxlr)
 {
 	struct device *dev;
 	int id = 0;
 
+	if (port == cxled_to_port(cxled))
+		return &cxled->cxld;
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
@@ -853,10 +858,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	if (port == cxled_to_port(cxled))
-		cxld = &cxled->cxld;
-	else
-		cxld = cxl_region_find_decoder(port, cxlr);
+	cxld = cxl_region_find_decoder(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.37.3

