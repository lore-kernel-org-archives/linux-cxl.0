Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA934252C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200057; cv=none; b=IiI9JUEF505hgBHaTG0xCVjN0SLnAaGJJvGGV1fAmtEUHkZOG9gJmKj3l8mFKiZ1hqoCW7ZOvMMGSKmppcwSJcfRQ6rPXnV/oZyzL8RRqJq0bw0gaYhHuOIhHwe0N0arrLj7imM8/CJW1GmguFDgL2oWc+YeeA+vJHvyxmWrL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200057; c=relaxed/simple;
	bh=QE65kVi81Xh3QYNcgquOJPZoruhZEpYr7/82u4giYb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWh30z8HymI8vTnH3K7MK+9QSGHd7BiQyoFJQRuqnhYeomT0mQgrm1I05m/uvHDGKlo6vF+eiAKjMZTWkwwAXUEJI8PbTskSt+IUo1qxkgo93gBPyWQGFZeAhBvRSbSBNIpMxbM2q+Zx6DUJt82vZ2M1vVDrEhWaD8NyPzT24C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjF0HWOd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjF0HWOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781200057; x=1812736057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QE65kVi81Xh3QYNcgquOJPZoruhZEpYr7/82u4giYb0=;
  b=CjF0HWOdUrR4mweC8vNmvapY+xroSZqhDHjBW3ny+NctVRcYReFW0mAT
   dqxkXjAC3GUNYVjxZ2y9yKVwGjEQ8QovFtmTQBy7R+AHjRPjID/qf+33A
   VRzHNXMIDgezcNGzjwgYlY6yNQhcAwHuSuMlfZ11Pn2Lmtl2PlsuvUC6g
   MWtnsnKCysMBJhZEyz/FOpEfyiZw5tDULYzVr6rz0xz6ymbRiwGcJ7Tme
   gZlf9wo7QcnK5cb8dIC1rP/Z0QLzItNNMw0rPc2pblIVFraEbTHu7uy+5
   OwI1p2LX1KDcql3bS4tuEfL5Kia7xxGS2Iy2n953wl2HyszXoUs8UIpMF
   Q==;
X-CSE-ConnectionGUID: NMdYYz1iShma7oJyuPFKJA==
X-CSE-MsgGUID: 4QB02MHwSOaFNzcroi+7pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99598789"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99598789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:36 -0700
X-CSE-ConnectionGUID: FtC55TtGSvG87qtUgMb21w==
X-CSE-MsgGUID: hATjlbyKShiRlkg0X2l2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246440985"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:47:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/6] cxl: Support mixed-granularity region interleaves
Date: Thu, 11 Jun 2026 10:47:24 -0700
Message-ID: <cover.1781199122.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Patch 1,2: Defer the unused selector var store to keep P1 bisectable (Sashiko)
- Patch 1: Make divide by 3 in get_selctor() work on 32-bit builds) (lkp)
- Patch 4: Use local vars in cxl_region_attach() for readability (DaveJ)
- Patch 5: Add NULL checks on unused mock arrays (Sashiko)
- Resolved errant err_rch unwind with rc7 merge (DaveJ)
- Rebase onto 7.1-rc7
- Update commit logs in 1,2,5 to align w changes in v2 
Link to v1:
https://lore.kernel.org/all/cover.1780095671.git.alison.schofield@intel.com/

Begin Cover Letter:

A CXL region interleaves across decoder levels (root, optional
switches, endpoint). CXL Spec 4.0 Section 9.13.1 requires only
that each level use a different, consecutive range of HPA bits to
select its target. The driver has historically required equal
region and root decoder granularities. That blocks the legal
mixed-granularity arrangements permitted by Section 9.13.1, and
makes the 6-way and 12-way configurations defined in Section
9.13.1.1 (Tables 9-6, 9-7, and 9-8) impossible to create.

Two prior proposals addressed parts of this gap:

AlisonS added position arithmetic and sysfs gating to allow
auto and user-created regions for the 6-way and 12-way
configurations that have no same-granularity alternative:
https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/

RobertR introduced an HPA selector-bit model to allow multi-level
regions regardless of granularity ordering for auto regions:
https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/

This series combines those two approaches into a complete mixed-
granularity implementation. It extends Robert's selector-bit model
from auto regions to user-created regions, extends AlisonS's
position-arithmetic and gating work to all mixed-gran layouts, and
adds the remaining validation needed for both paths. The result is
support for every mixed-granularity arrangement defined by the CXL
specification.


Series structure
----------------
Patches 1 and 2 replace the old granularity ordering rule with
selector-bit validation. Patches 3 and 4 propagate that model through
the remaining region-creation paths. Patch 5 adds cxl_test coverage
for the new layouts. Patch 6 documents the region granularity model
and multi-level interleaving rules.

A companion NDCTL patchset that allows mixed-gran 'cxl create-region'
and adds the unit test is posted here:
https://lore.kernel.org/all/fa5c109f08824180f58341ebd9055545a2ff3142.1780099216.git.alison.schofield@intel.com/

Alison Schofield (6):
  cxl/region: Validate interleave selector bits
  cxl/region: Derive port granularity from selector bits
  cxl/region: Account for mixed-granularity in position calculations
  cxl/region: Validate mixed-granularity at sysfs and attach gates
  cxl/test: Add a topology to test mixed-granularity regions
  Documentation/cxl: Add region granularity and multi-level interleave
    guide

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/region-granularity.rst          | 486 +++++++++++++++++
 drivers/cxl/core/region.c                     | 312 +++++++----
 tools/testing/cxl/test/cxl.c                  | 503 ++++++++++++++++--
 4 files changed, 1159 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.37.3

