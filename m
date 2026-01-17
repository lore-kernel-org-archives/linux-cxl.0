Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D7288B8
	for <linux-cxl@vger.kernel.org>; Sat, 17 Jan 2026 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768625257; cv=none; b=GzkCH8MGz+0a1evS+iOgKE9pgHyF8wCVUyB9JKQN7/4lub0ktrH0RPXnJe5ndbjiETAhREkq2t2Wz7DoL0FPLCBpA2LX6rtAXU0WqCHK7bgGILy+cUS2h+YS2ZL/ayBO3r0p97YrWRfqHtm/nsU5oSM9y8q8kdfpxnvdxGO5clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768625257; c=relaxed/simple;
	bh=bXt+j8ZHOeWZJZPFTAWa6xoz5mrzdwZRhyI6nnZt6KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alDj4R48eSdDqrMqDbIZr0x0N3yoa2WckO1kDYK4hGuYO6FCprvhA5to2bnnSzi33Ws77QTm3lhybTxDHPPiBF9Kotzs+42ofkpMSVMzqlcnj96SnJ0nqDgS3rA9HjgCuY1YzIF8uvEafFg/BroIcYwlV2KBk5uh7p95SYtdy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDKUxt1Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDKUxt1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768625257; x=1800161257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bXt+j8ZHOeWZJZPFTAWa6xoz5mrzdwZRhyI6nnZt6KI=;
  b=NDKUxt1ZbwVUmDjOe/BZFw/kBUfIn3XFDYKbfEw9F2kytcNt7CHLUm9i
   xLeQZq+EAR/zVJOWcUM1CwmRBaTifVlreYXX4OCnsHAB923L0d5HSSYn3
   hlfrWc8o7J3t98DZgkIFYquWcQiOVkJGrSQ4rOiPaXX8LnyVNzxc0Kg9x
   D8Q+le0Yw2ct6TBX0X/YMTXycG8JTvEoLJTZAcJAFjwofLXDH1XCze+8W
   CE8YNuBHmaRNps4ps3PdW2E7c+LV/qHrsRzhogimwefgnNCPv/zLFbE2s
   U6dt0szNKp8h+Wr2iHElGH/L13nzhyvny/Ajk5MkQf9tcWGyFBUkdASDG
   w==;
X-CSE-ConnectionGUID: 2Ifi8G7MRl6CjiO5DjyC8A==
X-CSE-MsgGUID: 9/h0yMDlTYuS/Ekck9DEXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73783026"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="73783026"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 20:47:36 -0800
X-CSE-ConnectionGUID: 6zFc2RmVSoSCJOcrY9NP0g==
X-CSE-MsgGUID: l77f9S5DRcK7ZGEl+PysWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="205463151"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.93])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 20:47:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Use do_div() for 64-bit modulo operation
Date: Fri, 16 Jan 2026 20:47:30 -0800
Message-ID: <20260117044732.567831-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

div64_u64_rem() was the wrong choice for doing a modulo operation
and it was used incorrectly, causing a kernel oops by passing NULL
as the remainder parameter. Replace it with the do_div() helper
that does the intended math (gran_offset = offset % gran) and is
architecture safe.

This bug appeared during testing of unaligned address translations.
The visibility to userspace would be limited to folks doing poison
injection or clear by HPA on unaligned regions.

Fixes: 78b50b598462 ("cxl/region: Translate HPA to DPA and memdev in unaligned regions")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d5979000fba1..96888d87a8df 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3324,6 +3324,7 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
 	u64 interleave_width, interleave_index;
 	u64 gran, gran_offset, dpa_offset;
 	u64 hpa = p->res->start + offset;
+	u64 tmp = offset;
 
 	/*
 	 * Unaligned addresses are not algebraically invertible. Calculate
@@ -3333,7 +3334,7 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
 	gran = cxld->interleave_granularity;
 	interleave_width = gran * cxld->interleave_ways;
 	interleave_index = div64_u64(offset, interleave_width);
-	gran_offset = div64_u64_rem(offset, gran, NULL);
+	gran_offset = do_div(tmp, gran);
 
 	dpa_offset = interleave_index * gran + gran_offset;
 

base-commit: 78b50b5984629d362f826e9615ce4599f429716e
-- 
2.37.3

