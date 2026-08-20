Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E138F258
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268694; cv=none; b=ZKQwMqWcA6CblHj0L/2jo9ao/mozwhi1gJxJwYZvXqeKAOWoxnXQZ6ddS2R+nFNAq6u5iFIhPs3JGc/pibVTlEsItHtBRVOj9XwAtOmrf79syaZuBiwTCEzKp1PrmxTJhg22hIrrPnyQXMPN0rAPHqIOIHCc3D8KeGkBYSuv1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268694; c=relaxed/simple;
	bh=wcUIpuSM6w4jm4byDkTovpd/ro03QkRTYMxTtZBzNXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akrWJqOGxFFcfv7Dg9BwI8Z97qjmQYfbYICuT9pIIXpcobY9c7CyIom03PI9pgZE15yoW2Q1kJayvGzu1o6J5vkEZKEphP5ubsoGD1juXP2Q9njZY7zTTPipP2SbXazhoUHYvZoMu8LRBW8WkuxWaRGPkpyvhsWMjsk6ZaIBw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+No2vgI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+No2vgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268693; x=1818804693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcUIpuSM6w4jm4byDkTovpd/ro03QkRTYMxTtZBzNXI=;
  b=j+No2vgIWzMUYSbFKJFkaMKPSk5h2j82MWqmU2r6jEnLXkMkUJDoM2xZ
   pIVCGPHlgTKVqitUBLLPid7c3JZUs+qFRN3/32I2l1pfYtsMfCGIakmkY
   9Y3Taem9Ch0ss9Rj4r4lHwQ1+upxtpwagZfUyYNJ1dNKoTiINZazwrkiN
   g8RTcNki+3bKt1cnP1K0Byaugcv1OMo7aWrYUNE/72ox8g60qP6PmVNA7
   lr+R39AMxFqF9YhgihHJFg/3Z69jl2C3WJoFOZr+SlqQ52rySc3ff5KtS
   gP66uoAXd5IG1HMOhcdE1LbHd3vGONfsj/S/Xa8rqzjVD+rMS+N+5ji9O
   g==;
X-CSE-ConnectionGUID: x4tOlCFfRCuJfzzF/ibiOQ==
X-CSE-MsgGUID: LBbRaAECRqaVnTk7CdeMCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98973039"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98973039"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:29 -0700
X-CSE-ConnectionGUID: ubiCSGZXTqOWDrzIUlse7A==
X-CSE-MsgGUID: 6fTtb0tiSBOQUJXoYMi0aw==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/6] cxl: Support mixed-granularity region interleaves
Date: Thu, 20 Aug 2026 16:31:18 -0700
Message-ID: <cover.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


RobertR: I've dropped the Originally-by tags since the implementation no
longer carries the selector-bit approach from your original patch. If
you think Patch 3 still warrants an authorship tag based on the origin
of the auto-region work, let me know.

Changes in v4:
- Rework port decoder setup around parent granularity and target count,
  dropping the selector-walk and selector-derived granularity machinery
  from v3 (RobertR)
- Replace the mixed-granularity-specific endpoint position handling with
  one weighted position calculation for existing and mixed-gran regions
- Derive mixed-gran port decoder settings directly from the parent interleave
  geometry
- Promote the user-region position self-test from dev_dbg() to dev_warn()
- Update the documentation patch
- Update the cover letter summary and series structure
Link to v3:
https://lore.kernel.org/linux-cxl/cover.1785444498.git.alison.schofield@intel.com/

Changes in v3:
- Reduce scope to coarse-to-fine ordering (RichardC, Sashiko)
- Reject out-of-order layouts (RichardC, Sashiko)
- P1: Factor the selector walk and per-port checks into helpers (RobertR)
  That pre-work is the new Patch 1/8 and the Series Structure section of
  this cover letter describe same below.
- P3: Derive granularity from the highest available selector span (RobertR)
- P3: Validate auto-programmed granularity against the derived value
- P4: Rename root_pos_stride() to root_positions_per_target() (RobertR)
- P4: Drop the "stride" terminology throughout (RobertR)
- The complex Patch 4 of v2 is split into patches 4-6 in v3.
  Also noted in the Series Structure section of cover letter below.
- P9: Move the peer-distance walk and per-function walkthroughs from the doc
  into in-code comments and kernel-doc (RobertR)
- Drop Reviewed-by tags
Link to v2:
https://lore.kernel.org/linux-cxl/cover.1781199122.git.alison.schofield@intel.com/

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

A CXL region may interleave across multiple decoder levels: root,
optional switches, and endpoint. The driver has historically required
equal region and root decoder granularities. That blocks legal
mixed-granularity arrangements permitted by CXL 4.0 Section 9.13.1 and
makes some 6-way and 12-way configurations defined in Section 9.13.1.1
(Tables 9-6, 9-7, and 9-8) impossible to create.

Two prior proposals addressed parts of this gap:

AlisonS introduced position arithmetic and sysfs gating for auto and
user-created regions to support the 6- and 12-way interleave
configurations without a same-granularity alternative:
https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/

RobertR introduced an HPA selector-bit model for auto regions that
allows multi-level power-of-two interleaves regardless of granularity
ordering:
https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/

This series adds support for CXL regions where interleave granularity
differs between levels of the decoder hierarchy. The support applies to
both firmware-programmed auto regions and user-created regions.

Linux supports mixed-granularity configurations that are monotonic from
the interleaving root toward the endpoints. Granularity may remain the
same or become finer at each interleaving level. Configurations that
refine and then become coarser are permitted by the CXL Specification
but are not supported by Linux.

This support includes all power-of-two interleaves, as well as the
3-, 6-, and 12-way interleave configurations described by CXL 4.0
Section 9.13.1.1.


Series structure - reworked in v4
---------------------------------
Patch 1 promotes the existing user-region endpoint position self-test to
a visible diagnostic.

Patch 2 generalizes endpoint position calculation to account for
granularity changes between decoder levels.

Patch 3 enables mixed-granularity auto regions and validates their
coarse-to-fine decoder geometry.

Patch 4 enables mixed-granularity user regions by relaxing the existing
root/region granularity restriction.

Patch 5 adds cxl_test topology and coverage for mixed-granularity regions.

Patch 6 documents the mixed-granularity model and Linux support policy.


A companion NDCTL patchset that allows mixed-gran 'cxl create-region'
and adds the unit test is posted here:
https://lore.kernel.org/all/fa5c109f08824180f58341ebd9055545a2ff3142.1780099216.git.alison.schofield@intel.com/


Alison Schofield (6):
  cxl/region: Warn on user region position mismatch
  cxl/region: Generalize endpoint position mapping
  cxl/region: Support mixed-granularity auto regions
  cxl/region: Support mixed-granularity user created regions
  cxl/test: Add a topology to test mixed-granularity regions
  Documentation/cxl: Describe mixed-granularity regions

 .../driver-api/cxl/linux/cxl-driver.rst       | 135 +++++
 drivers/cxl/core/region.c                     | 193 ++++---
 tools/testing/cxl/test/cxl.c                  | 496 ++++++++++++++++--
 3 files changed, 706 insertions(+), 118 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.37.3

