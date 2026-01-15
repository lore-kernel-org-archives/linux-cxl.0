Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCD2E718B
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507702; cv=none; b=BRZqk98cIwCddaZgDXjP3gEG+znaleJe9ESdGEiLc1Awn+PwVAYgg1dCPzxuDmmN/HsdLMBMZFKdEfY3jGadBNP6EdDnZ/7yFd+SEe3PeCwiYSOupLEffs6ONbid72DVVZyTumF3aDY4WEmjHUp85JaN6o3yvnwTylmSK2eyRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507702; c=relaxed/simple;
	bh=JwUhf1LeJ76igrsaw2bQPwoMdWmzUlYRix8USaFGvXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1XQQM6eQ92/+AxQlSsUR39RMivBA4CoKEMcDL2VIV6r/L9q4NNISEIt1/4HWCgKAnCVGPj21B/7uFxb2PQn2s987KhuFriM+ZgfEDX7YP5/LSF1buqr3yx4hDUjWkQpJi9/kHmQSq59ZfVPFkY6V92ZLh/47aQiGSsirno0l+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te/sHSXa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te/sHSXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768507700; x=1800043700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JwUhf1LeJ76igrsaw2bQPwoMdWmzUlYRix8USaFGvXo=;
  b=Te/sHSXa6HpV6qVpQWctKUhJPu3LoL7xczLbRklz1ujHZg91Ikq8gM45
   MaR2YiRPpnLohsVf8C5fUU7sVxPPMOMpZwMXO4S4E4gblWCNadVFTf0Za
   Z8ptRTPsQkI8LYeeaYd1Q3hL8jSus2rlXxpSRAs1HbYr9WD0fpNXF7/ug
   EbcawnAuJYhlRNyfpggxl+mzp/waRKDrx4xvTrpgggqCB0S9hDTNcc1nE
   8vEEU6HCJDLm1k1ymBRqYCwbavLsBfWONcLflH6cVUdHZStTGwtXMi0ER
   UjbYJgnPlx+420J6JAo1iXYr1zYVqqTKxJMeiGJu+6lZoy6AQ2iulxtS2
   Q==;
X-CSE-ConnectionGUID: BUE0l0GURtG1op7vnx23gw==
X-CSE-MsgGUID: Gyj5nwQLSeOI6RKsnlmprQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69914798"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69914798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:08:20 -0800
X-CSE-ConnectionGUID: 6A5NVjIaQh6OlTS3wME/Rg==
X-CSE-MsgGUID: 4/uGEzWFTLe9oB1Ftl1ywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="210078265"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.9])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:08:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 2/2] cxl/region: Translate HPA to DPA and memdev in unaligned regions
Date: Thu, 15 Jan 2026 12:08:12 -0800
Message-ID: <5d1de87c8e2ac9e3d9b43af5c0d975f7f4ac269a.1768504636.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1768504636.git.alison.schofield@intel.com>
References: <cover.1768504636.git.alison.schofield@intel.com>
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cdfa454b940d..8ed66bedb407 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3314,6 +3314,48 @@ struct dpa_result {
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
@@ -3343,6 +3385,10 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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

