Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C382E7384
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450042; cv=none; b=gZGd+gAJCaSIWeQyYC2CSt2w8WJk5iLT6YSsZ8vTZezr9gwm4+XdgUvGrj5CdTqjv8sWpOzbQJX75+6XYRgWWTPxVT2RynexMLUmAawa7+Q/XTB4lfYJzy4S3T+iMsTRZPxzUjJxQKtvC9GBbSBObGFY3kzDW3+C9+OWPIxJy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450042; c=relaxed/simple;
	bh=bo/sDRrrN1TFVHtt+mM/zpVkXQ5QqnKnyFFctktuW+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dV37XsUqU3eQzHXNwGAm78E0D78eSPiMP5r5mRePCzTzdKizPnPjr3DeXRiwoAD9P350gEtB2Jkfc7N/HL8m1e5/YB2wOaVKC393k53EP1Ya2yFYTiW/hjMCAnhtVTVnMhHNRs+KXd4Py1kHfQ7PuWSZw1coNBf/UVQfBIBm4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoePOpPM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoePOpPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450040; x=1816986040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bo/sDRrrN1TFVHtt+mM/zpVkXQ5QqnKnyFFctktuW+Q=;
  b=ZoePOpPMQn1PdY6b+b7SiF829QjQJG/aXi9PNJAQqifqhenY7gqnGm04
   Zk+nDhvgfsJnP86w65bRSt03XA3QR6yal6e5wFgj6Y7cT2biZliVLIL8+
   8s4bDkoZp9KWUm5qCe+P8mKcdN8lD1uS+p5v2XM5/5DnEPNzSQH/Z/iy+
   AztxMTS5HOdJueHwQGYOiqtnnkDy7DoVp4s6sRtMttO6OWse6aXESj9np
   lszUXp2PFBUqg52I/dukxeDGkbhWCt4KfeHdjR/ckKxKV/dX39XcQP6fa
   ulrBRRFv5mHKT5uJlvAehfN7na1UOeuS54rnJhcagDlsKyuqFqTvQlH2P
   g==;
X-CSE-ConnectionGUID: OLl3MyreT72ZssoSgW2ifg==
X-CSE-MsgGUID: fom76BO4SVKf2XVf36pykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89890893"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89890893"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:40 -0700
X-CSE-ConnectionGUID: SAEXBoUtSL+Bvb9njvFyGA==
X-CSE-MsgGUID: pXSdG/M/Sv2QCgsm6Vu/uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="264224204"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:39 -0700
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
Subject: [PATCH v3 0/9] cxl: Support mixed-granularity region interleaves
Date: Thu, 30 Jul 2026 15:20:20 -0700
Message-ID: <cover.1785444498.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 note for RobertR,
I appreciate the testing and tag offered in v2, but I did not keep it,
because as you see here in v3, the changes make that tag stale. I
appreciate if in addition to reviewing you can retest. Also, I'm not
certain on the tags I did give you. I used "Originally-by" but if 
Co-developed-by: with your Signed-off-by: is the more correct choice,
let me know.

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

This series combines those two approaches. It extends Robert's
selector-bit model from auto regions to user-created regions,
extends AlisonS's position-arithmetic and gating work to the mixed-
granularity layouts, and adds the remaining validation needed for
both paths.

When the region granularity is finer than the root decoder's (a
mixed-granularity region), each interleaving level must be finer than
its nearest interleaving ancestor -- coarse-to-fine from the root
down. Arrangements that reverse direction are rejected with -ENXIO on
both the auto and user-created paths. Same-granularity regions are
unaffected; their levels legitimately coarsen away from the root.

This is the full range the position arithmetic represents, and a
superset of the prior behavior, which accepted only
region_gran == root_gran. On user-created regions the driver derives
each level's granularity coarse-to-fine, so an out-of-order
arrangement cannot be expressed and is refused by the selector-fit
checks; the coarse-to-fine ordering gate is what guards
firmware-programmed (auto) layouts, where the granularities arrive
already set.

Series structure - changed in v3
----------------
Patch 1 factors the per-port target calculations into helpers with no
functional change. Patches 2 and 3 validate the interleave selector
bits and derive each port's granularity from them. Patch 4 generalizes
the position arithmetic for mixed-granularity layouts. Patches 5, 6,
and 7 allow mixed-granularity regions, enforce coarse-to-fine ordering,
and make the position check fatal. Patch 8 adds cxl_test coverage for
the new layouts. Patch 9 documents the region granularity model and
multi-level interleaving rules.


A companion NDCTL patchset that allows mixed-gran 'cxl create-region'
and adds the unit test is posted here:
https://lore.kernel.org/all/fa5c109f08824180f58341ebd9055545a2ff3142.1780099216.git.alison.schofield@intel.com/


Alison Schofield (9):
  cxl/region: Factor port target calculations
  cxl/region: Validate interleave selector bits
  cxl/region: Derive port granularity from selector bits
  cxl/region: Account for mixed-granularity in position calculations
  cxl/region: Allow mixed-granularity regions
  cxl/region: Enforce coarse-to-fine ordering for mixed-granularity
    regions
  cxl/region: Fail region creation on position check mismatch
  cxl/test: Add a topology to test mixed-granularity regions
  Documentation/cxl: Describe multi-level interleave validation

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/region-granularity.rst          |  66 ++
 drivers/cxl/core/region.c                     | 580 +++++++++++++-----
 tools/testing/cxl/test/cxl.c                  | 498 +++++++++++++--
 4 files changed, 968 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

