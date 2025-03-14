Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04C1FDE08;
	Fri, 14 Mar 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952241; cv=none; b=FGKdFMyFt/+dvIybofn9X5ehDD3y6yu54DiTpLsKF+Koul+6tXjWZYi1bVkg2XABsC4hcKl6UGCA//U/hSW3MRb0glUujHgaMb9SdmNELyaxzVfztSHGxgMsrvTXv1N33Ii/wOtEcNykCG6INt3/cYphfJ2HfkfzeIoAR+l6NSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952241; c=relaxed/simple;
	bh=wp3fhs57P5CsFfIfYykTdJ3KeHe9g3cJ6zrREW55FnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npEqiYuilD/E223mliUX93Gb0BfEIPVlujMntQBw9S1ZkaequZPf/MJkf7OmJxgDnrg7KwEa/HAK8Gtyj04ohOK8fsSiWF9kqnNvVz4lYb7C0aWXGOjvPfkUPw568gPi97lc24/yWGEMfj2a9M0ciqNiKiiqiEbqyhZ9FytS/TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0Z6/0DV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0Z6/0DV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952240; x=1773488240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wp3fhs57P5CsFfIfYykTdJ3KeHe9g3cJ6zrREW55FnQ=;
  b=X0Z6/0DVygHcO/ICwKANnc8sWq1DLKA8dMcng2zk8gNkPe/SzcEXs37T
   bbQ7ss/B/KYORKrOg91q5C+x+UQgT6+cdHD42L1mgsnJ6wlco1CAxuIxl
   nNseTO5o2YpD0m5su0GEUqoXqEz9+u2oO3/xbOPG5aSofD4b66rddO2GJ
   IlmHtTGRZljlj7HsOiQhATBG5vZb/A2K6CU2wJfqap/q+9oCwRbFpCDMg
   8ypnaJ4yWeKfjI1QevW5cXS9KkEe3is1GZNZkJ50dO2giim1f/Y0Jl/jY
   ddSWYIqwNdcLfdfTvWJFwXw/iH7ucqSPswtY2AVav+XSoKFexz7JpXAzZ
   g==;
X-CSE-ConnectionGUID: UxRssSgjRC2dKjX4jL8ZnA==
X-CSE-MsgGUID: OxCe1B34RliWW992c1cqiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60497526"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60497526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:19 -0700
X-CSE-ConnectionGUID: tu2EcZApS0u55nzUTGhV8g==
X-CSE-MsgGUID: LkngO+XwQCGzxfeiibTvKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121751369"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:14 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Fri, 14 Mar 2025 12:36:29 +0100
Message-ID: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
Physical Address (HPA) windows that are associated with each CXL Host
Bridge. Each window represents a contiguous HPA that may be interleaved
with one or more targets (CXL v3.1 - 9.18.1.3).

The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
memory to which systems cannot send transactions. On those systems, BIOS
publishes CFMWS which communicate the active System Physical Address (SPA)
ranges that map to a subset of the Host Physical Address (HPA) ranges. The
SPA range trims out the hole, and capacity in the endpoint is lost with no
SPA to map to CXL HPA in that hole.

In the early stages of CXL Regions construction and attach on platforms
with Low Memory Holes, the driver fails and returns an error because it
expects that the CXL Endpoint Decoder range is a subset of the Root
Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.

Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
Decoders or already made CXL Regions and Decoders to allow the
construction of new CXL Regions and the attachment of Endpoint Decoders,
even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
range end to match Root Decoder's.

- Patch 1/4 changes the calling conventions of three match_*_by_range()
  helpers in preparation of 3/4.
- Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
  the HPA range end for CXL Regions construction.
- Patch 3/4 enables CXL Regions construction and Endpoint Decoders
  attachment by matching Root Decoders or Regions with Endpoint
  Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
  constraints while Endpoints decoders' attachment.
- Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.

Many thanks to Alison, Dan, and Ira for their help and for their reviews
of my RFC on Intel's internal ML.

Commenting on v1, Alison wrote a couple of observations on what users
will see. I suggest anyone interested to see how this series affect
users to take a look at her observations.[0] Thank you!

Changes for v3:

  Re-base the series on cxl/next.

  1/4 - 2/4:
	Constify local variables.
  3/4:
	Call arch_match_region() from region_res_match_cxl_range().
  4/4:
	arch_match_region() - Check that region end is under start + 4G;
	arch_match_spa() - Check that SPA range start is cfmws_range_start.
	
  base-commit: acc2913692413df9d1

v2 - https://lore.kernel.org/linux-cxl/20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com/
v1 - https://lore.kernel.org/all/20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com/

[0] - https://lore.kernel.org/all/Z0Tzif55CcHuujJ-@aschofie-mobl2.lan/
[1] - https://lore.kernel.org/oe-kbuild-all/202411252126.T7xKY88q-lkp@intel.com/ 

Fabio M. De Francesco (4):
  cxl/core: Change match_*_by_range() calling convention
  cxl/core: Add helpers to detect Low memory Holes on x86
  cxl/core: Enable Region creation on x86 with Low Memory Hole
  cxl/test: Simulate an x86 Low Memory Hole for tests

 drivers/cxl/Kconfig                  |  5 ++
 drivers/cxl/core/Makefile            |  1 +
 drivers/cxl/core/lmh.c               | 83 ++++++++++++++++++++++++++++
 drivers/cxl/core/lmh.h               | 31 +++++++++++
 drivers/cxl/core/region.c            | 82 +++++++++++++++++++++------
 tools/testing/cxl/Kbuild             |  1 +
 tools/testing/cxl/cxl_core_exports.c |  2 +
 tools/testing/cxl/test/cxl.c         | 10 ++++
 8 files changed, 197 insertions(+), 18 deletions(-)
 create mode 100644 drivers/cxl/core/lmh.c
 create mode 100644 drivers/cxl/core/lmh.h

-- 
2.48.1

