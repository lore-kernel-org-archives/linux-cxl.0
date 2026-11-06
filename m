Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002242;
	b=KVZ5dapFHE6ZDiOyyBeFCZV0OFcgIXrjvhnVZSy78SCIeami07rjkqf97d+nXQeAEEVq
	 5+n+gqH+74m0ZKWK8VR7DiuV/3FrWf2c/RZt7953L2mPJXVs+HEa/0ONIhGE6JhyXuOHJ
	 O7VlHzWb7vTLV2LXzkxi72ghIv80JFdNUGEjskxaYVXYifX/nejCeOcaJUO6CiBn+5BkL
	 ZtRWPqpmLG7uTEqheXCDUsaSWKtvhR6H7vVHvf34YWBOMqPlsrAQLGYhsbV11HFa8wjU/
	 +doKT+YDq2CW/h6z8QWAPCRlqPl/KFu2mGnPDnj3vGRVT7nNn53lGlPFc/YUBjse+SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002242;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rR0ynBrJsbCyYC3X9W337nGFeyHKGp5VoiHQZeIJu50=;
	b=qm5RAn3jQFNY3TMEMw8wqaAvQBpe2sS1nsPxUq5HA1/eHlaNF/zVmU8X1pMnqluJmH3i
	 DBiqoQY991dBdC4xYozIqSNzPzmLRSZD4Uz6hzv55UHYCwiveKvB5NOEyTckDxyOfcxCb
	 3kFfws9UfC6mgFYWg3sMX9MxvlGQACLSfnC7P0MFOrrHiCQVRRpPZR1BajTcT/7Zaew8W
	 kgpxYHp4mfToBgLVpjQCPUt8LFhhkv4SfrNkxDZCa+lP4S2TJaMWL+qx5ysGIOpA+y1F4
	 BVDQ2lr82gy01oPiIJqNJK4ui/sZsNuacjmY1s0EHYAGysBooSkK0ZfdgpqvIAyHo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Faj8GWd5;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72729606A331
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 21:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72729606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Faj8GWd5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002242; x=1825538242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9OuXIjdDRYmw+52n3LjzrhvqS8ozJ8biSoqPXF/lQos=;
  b=Faj8GWd5aRObj2I6UiseU4/K0hjIobqkP8VqGMY/l8Mfprx6BoGwn/jj
   ChILSzf3Y2hN35yAvCie0HRX6RA+qwYwo2Mr4oZmYouiS+tvosTaPxA8v
   4AO2yr/ld/GxgftWKs0ni3Gp7c6uOispL0ChE5Ueg6dq0x4ub/6U7xDZ/
   m4IxEeuuKZQ6+VT12aCcr02pnkw7GYyPZvxogHiXTggFKHgfjo1uGy6Dt
   ZzYENyVUYAMTlkVtd2EsOEs9Vmcorb8YIS6depNl1r7M/ut4C9NCtvQCP
   fBYsm+ttnhg3q1OqmH2iBYQoYp47+NwfOpDMrFk2EVBEu8Q4QshaQQKV4
   Q==;
X-CSE-ConnectionGUID: OPTJJolsS9atqbf1gTCCoA==
X-CSE-MsgGUID: DV5fmb+WRPyEKP329PQdvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2812934"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2812934"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:20 -0800
X-CSE-ConnectionGUID: jQ7UiwqNSqWZwc2rcJT8RA==
X-CSE-MsgGUID: ygR67TJ0R3as3nWGJJLCOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147246"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v7 4/5] cxl/region: Support user region granularity finer than the root
Date: Fri,  6 Nov 2026 13:57:11 -0800
Message-ID: <545ed66fd5836c5628671aa1e6e4390e07017dd7.1794000806.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794000806.git.alison.schofield@intel.com>
References: <cover.1794000806.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation currently requires an interleaving root to have the
same granularity as the region.

That rejects a region granularity finer than the granularity of the
interleaving root decoder. A region granularity coarser than the root
remains invalid because it produces incorrect DPA translations.

Allow a region granularity finer than an interleaving root and continue to
reject a coarser granularity. The root span check at endpoint attach
validates the complete ways/granularity relationship.

For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way region at
IGB across three host bridges as a 3-way root interleave at 2 * IGB with a
2-way interleave at IGB below it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0a39e634b4b0..fcee7ed7c0d4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -569,15 +569,15 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 		return -EINVAL;
 
 	/*
-	 * When the host-bridge is interleaved, disallow region granularity !=
-	 * root granularity. Regions with a granularity less than the root
-	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to support in the future). Regions
-	 * with a granularity greater than the root interleave result in invalid
-	 * DPA translations (invalid to support).
+	 * Region granularity coarser than the root produces invalid endpoint
+	 * address translations.
 	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"cannot set granularity to %d: exceeds root decoder granularity %d\n",
+			val, cxld->interleave_granularity);
 		return -EINVAL;
+	}
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
 
-- 
2.37.3

