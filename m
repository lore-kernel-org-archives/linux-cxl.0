Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC379222585
	for <linux-cxl@vger.kernel.org>; Fri, 16 Jan 2026 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539549; cv=none; b=JqX2vmht03lrA7WDzD5qnNZwfV0BgMMOvz/4rTv8Sne8pYRsDpSehTm5zJWqGVYxselbTkNo8qRDHXSUQ0Dg8/hrrtM89LnaLfrZvS3KjHZW7ZuzWhZ0oUI28/bvEHhrQmmrpgCjU1XsOp7BA9j9Sn3MsZBnSBJ6SlpegzRf6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539549; c=relaxed/simple;
	bh=3dKDVOhSH0mPyGdYpRPivQxs0CSuB57ge58RoWhjiNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAyJmT8GDrmSe4yKkT5M5fzKK+jJolL0NkhRLUBJQVtMBwwb9tIz8n3N0rKJwr6bnzVU/QY9Lmt83jHz05ViuRyHgWRffEGtWKS8+sEoqpdYd4TBG9nx3PFkJslMt8fxu+woUrSav86kxKpQPY1MnB2gHB+XDMmdwFTsoezWJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dfwo4ykB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dfwo4ykB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768539545; x=1800075545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dKDVOhSH0mPyGdYpRPivQxs0CSuB57ge58RoWhjiNQ=;
  b=Dfwo4ykBrRIInvYt5qrCISmmOT6BvydBuU3INZJkiA8LGQo0NtcRbl1I
   s3QVCJ+qIgyNFE86oJIMudNfjczMSGj0G/Pp0wRtScOzrEq+jjhUxneHv
   AmZ1ArTGItVm15uUp5Zm4AFoc9TQvhaULXYXkodZQ8vpE7vCyAVZsMiv4
   V7PS23fY4dNINT+JuqnH5YkWD4xOj8zttno7OmM5M6CS8Zf1CpKGLMaMw
   VcPNt0wKbXBEoQYS9wrdc5QDDtK/dBq8F3lE5v9ZSx4Vf4bb9nUNd8j/S
   c2Wq2u1xRF6vWIbQWjqjZubQkmhINiMsJLM8Bt4y2zFAJ5PZDN9jgZNLW
   Q==;
X-CSE-ConnectionGUID: 0wHKm752TrqJ1PdKyCDXwg==
X-CSE-MsgGUID: wlpFYk39RcWVSJAXcN6nuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69750229"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="69750229"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:59:04 -0800
X-CSE-ConnectionGUID: BjgeIeP8QY2ThWcZnODQqQ==
X-CSE-MsgGUID: bmFIR+p2TnS8qtuJ/absOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209289506"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.9])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:59:03 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v6 2/2] cxl/region: Translate HPA to DPA and memdev in unaligned regions
Date: Thu, 15 Jan 2026 20:58:37 -0800
Message-ID: <f338b7aff7e4574fcc525b1a0d4f09786bfb6489.1768538962.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1768538962.git.alison.schofield@intel.com>
References: <cover.1768538962.git.alison.schofield@intel.com>
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
index cdfa454b940d..d5979000fba1 100644
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
+	interleave_index = div64_u64(offset, interleave_width);
+	gran_offset = div64_u64_rem(offset, gran, NULL);
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

