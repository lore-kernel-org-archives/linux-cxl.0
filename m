Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFF1C6FEF
	for <linux-cxl@vger.kernel.org>; Mon, 24 Feb 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441044; cv=none; b=OyA1cV+zMaBc209SO/RAINAvgRy5sdY5wT/DeiAp6JObN9ZTMjHWAHCwltlxXQWdS0nq2VOyi5fmcCvxwwtuyA5DAApt7cdo66oSjSvxPryqOvK3wsxbWp7RU/EQOz9N6t+bd+u0wcE1uzfkQY+RBqe6oOSIaBVfSTldoKrmr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441044; c=relaxed/simple;
	bh=DOu2XWKyAN20JuUL8sRl3lca3r5UaJAB4yDJzjQXs48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXDT8Uw+FKK9yhgJA1LlVYOiwW8xrJacJEe+rXqoOz/KFGYHrVzpQ3tclgvvR7ciP31ltMFyvwdGEaYxAutCmTnu0pms3mo5L5dXeuAEn+IRM3a8EZAvi7Ady35QkAlQNIshCtuCaFtONyy99BespmbN/pd/HMrKoDCVkvVcsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/0W4jJM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/0W4jJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740441042; x=1771977042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DOu2XWKyAN20JuUL8sRl3lca3r5UaJAB4yDJzjQXs48=;
  b=Q/0W4jJM0U8l05M9LZZtI0ZSotRc2JSK1Xo0Yno3c+unqy+dR0Mh7sOB
   X241GeBtCdAo3knnkv6Q8XW5XzE6tpa7TFmO5fl+HyWVGpNVbBk1qmYMU
   QPKW/8/88ROJsVRG+eTKBgKIXPj0dRLQe9zhnHUiJaLmvxbrrmMWE7FME
   x8ai2ClrLPBfqSE73arZU0jJZppR2a+VDsSvj7qxSwyCj/BY27ZquN3/+
   buj2QG5Kw0hvZX9do8xo02a2UWoYzVvxHtKvFZNEJ3y3UIxwRynyS7bSP
   9yb1zA0kQNhGdpbllPe/JDINThPmfvK3AZkgsjSbiKwM0wpCDJST8qXNW
   A==;
X-CSE-ConnectionGUID: G2GJ8XipSzWdGBHW3xo/uQ==
X-CSE-MsgGUID: xN3RwoMzRzeHqQ6EDNbqvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45001334"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="45001334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:50:40 -0800
X-CSE-ConnectionGUID: +sN7d1FGQmatQY+8lm8iGw==
X-CSE-MsgGUID: 14jhlpGGS3a0Fym80WjQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121462356"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:50:39 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB interleave
Date: Mon, 24 Feb 2025 15:50:30 -0800
Message-ID: <20250224235032.2259058-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL unit test cxl-xor-region.sh is skipping a 1+1+1 region
interleave test case because the window is not defined.

Additionally, upcoming expansion of 3 way HB interleave test cases
(like 2+2+2) require the same window.

Replace an unused CFMWS with a 3-way capable CFMWS in the set of
CFMWS's loaded when interleave_arithmetic=1.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 083a66a52731..e5cd874614d2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -331,14 +331,14 @@ static struct {
 				.length = sizeof(mock_cedt.cfmws8),
 			},
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
-			.interleave_ways = 2,
-			.granularity = 0,
+			.interleave_ways = 8,
+			.granularity = 1,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M * 16UL,
+			.window_size = SZ_512M * 6UL,
 		},
-		.target = { 0, 1, 0, 1, },
+		.target = { 0, 1, 2, },
 	},
 	.cxims0 = {
 		.cxims = {

base-commit: 2bb67004903cfd35710750654669a77e7223fcd1
-- 
2.37.3

