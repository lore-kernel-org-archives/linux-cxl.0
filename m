Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EF2066DE
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010062; cv=none; b=mjoGQ1gBMwIgG/DFbR7m0JwIibbhNyVa/9WXSw6S96w7ohkNiyGL68UtZBCJvJr92ycayWbJqrurg031of/szlcUhi+nBXW0/TrKoXLeknPrqjT/ftofhsMHRxG4b1W+H+71xuViSpIYU2+e83eNhSOTEGOqFvRuNhwM1T2Ks2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010062; c=relaxed/simple;
	bh=3Rt72ZCA7l/y+0XQhikrMcNkWpx5S2s9ALB4Ze5qi9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEqJKySra6tlGrDM7YSd7r5eePXsbrwqGtd8QC+FrYBesxz9cBKEzK3Ng1BPo9ySsGmQhNqsqHag9QO+QfLVQraz3h90BOCJee1x4iiXDqnJRCdlTi8sFYN3gsML4qXYaUE3sxLgXbxBRC05j9dpbO298e9Sg48y+FOepxjmtyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORNT+SzL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORNT+SzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768010061; x=1799546061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Rt72ZCA7l/y+0XQhikrMcNkWpx5S2s9ALB4Ze5qi9U=;
  b=ORNT+SzL/52atoXy+FDe6PRtD+bp0+C4tiqSjtNIY5UZ977+ttUwLtXy
   nTgJdsXdbuKzL9dX+PvHVCgHCV0YSeD0lFNM4rx0TE2hlShlOXGGJN2CZ
   kfDGJwIbi2VuGU21jakxO26y0LgaqJiUvN35h9MpBkXNjkQ43eDa94Xrt
   KJkW7gz/N/aN1RBGguRz3bvclx3HXrvBF9Yzp0eQ3zOJrd/r9Cr7OsP44
   pdgmusvkTMa49Yay4FDnsYnrS/ueT6YcNkzJ3c079/MEfICxW5aF1OtxO
   ghxwItdikBS5ucWLBV0nI1tRhCGdqrsSlBLY3d+IjLYsd+gTWmExqrqrg
   g==;
X-CSE-ConnectionGUID: fliafzIHSwKxc+3Sre4Itw==
X-CSE-MsgGUID: qY/V+0uJRemOh8JFsfzm8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69319319"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="69319319"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 17:54:21 -0800
X-CSE-ConnectionGUID: cToRI2xqSZeO3NUOA22WXw==
X-CSE-MsgGUID: TY/kZP7JRd2ySdABnA3OMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="203519669"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.121])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 17:54:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 2/2] cxl/region: Translate HPA to DPA and memdev in unaligned regions
Date: Fri,  9 Jan 2026 17:54:14 -0800
Message-ID: <0d7d47672e81d0c4d9a4e5e335ca536dbecb9dee.1768008522.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1768008522.git.alison.schofield@intel.com>
References: <cover.1768008522.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL driver supports an expert user debugfs interface to inject and
clear poison by a region offset. That feature requires translating a
HPA (the region address) to a DPA and a memdev to perform the poison
operation.

Unaligned regions do not have an algebraically invertible mapping
from HPA to DPA due to the region offset skew. The region base is not
aligned to a full interleave. Add a helper to perform the unaligned
translations that first calculates the DPA offset and then tests it
against each candidate endpoint decoder.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 146ae9e42496..f63fc15ba0c1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3307,6 +3307,48 @@ struct dpa_result {
 	u64 dpa;
 };
 
+static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
+						 u64 offset,
+						 struct dpa_result *result)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p = &cxlr->params;
+	u64 interleave_width, interleave_index;
+	u64 gran, gran_offset, dpa_offset;
+	u64 hpa = p->res->start + offset;
+
+	/*
+	 * Unaligned addresses are not algebraically invertible. Calculate
+	 * a dpa_offset independent of the target device and then enumerate
+	 * and test that dpa_offset against each candidate endpoint decoder.
+	 */
+	gran = cxld->interleave_granularity;
+	interleave_width = gran * cxld->interleave_ways;
+	interleave_index = offset / interleave_width;
+	gran_offset = offset % gran;
+
+	dpa_offset = interleave_index * gran + gran_offset;
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		int pos = cxled->pos;
+		u64 test_hpa;
+
+		test_hpa = unaligned_dpa_to_hpa(cxld, p, pos, dpa_offset);
+		if (test_hpa == hpa) {
+			result->cxlmd = cxled_to_memdev(cxled);
+			result->dpa =
+				cxl_dpa_resource_start(cxled) + dpa_offset;
+			return 0;
+		}
+	}
+	dev_err(&cxlr->dev,
+		"failed to resolve HPA %#llx in unaligned MOD3 region\n", hpa);
+
+	return -ENXIO;
+}
+
 static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
@@ -3336,6 +3378,10 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 		hpa_offset = offset;
 	}
 
+	if (region_is_unaligned_mod3(cxlr))
+		return unaligned_region_offset_to_dpa_result(cxlr, offset,
+							     result);
+
 	pos = cxl_calculate_position(hpa_offset, eiw, eig);
 	if (pos < 0 || pos >= p->nr_targets) {
 		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
-- 
2.37.3

