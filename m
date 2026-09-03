Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6234CCDC5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477845; cv=none; b=BJaqUN40+BpXFbqjsqEHgWcINqDL48n5mKNdre8NJ822sAae7Yc2dEbqHPMEdak11fW5aZ1GShbSBHnuIgnmPRjK8NZr7XludgdNvCvmtksBXSVKC3ip42mX5NROCJpEmYceAetwPZRlQfU/Sz82iUxBJXRw3jN+TildBYeTzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477845; c=relaxed/simple;
	bh=MEF9n6e1HJ1rIBTebb8qIS2x1I6Z4ZKd/bU1hrdjsP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQPsGbcr8TBtncxgVNwTIAiTzkyemNawWsWTZLpMMsAd3oQn1paypVzxlfQAh8UsvkKqYx4mztcizALhpOM0T0KfIzzHXdzqcFR6urmU06kJWqMp09QZKMKtQJAOfz+vxYsKns016pIOGW2Rf8XiqZuZLGMH+uhm7tKeiZFng6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLupZ5A+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLupZ5A+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477844; x=1820013844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MEF9n6e1HJ1rIBTebb8qIS2x1I6Z4ZKd/bU1hrdjsP4=;
  b=SLupZ5A+Oc75A26ZLlWopkoft81wDC1KLDb1xs/z2LtHcgyYjct6A/cJ
   +tuByU5famy3sHQDuDzNhYi0WHs0HbwqE7MGlL7GCOzFwVcDAyC92yhxY
   UxYbVvFobbFPtSYp5lPQJJx456j4uRwR8WOX7ZDJqWTX909EGhBNr3wRX
   /6w51WG/VYD2pjfvO654dWkvaUoApUCRvtbaFtZ1qQW2Dx+b/cQFKB2Gw
   uWUDYlRHxRmSzafXVkzRshYzcQOTyMipvsNDBzvjBL2kTZ77glRzz8f3v
   ztN2/JoMhfwI/niduUtTYZmCgSAvrddBjE6osmGAmEVArlBs/ORu3kU4W
   Q==;
X-CSE-ConnectionGUID: 3W0thvktSkK1FzC8KD0mQQ==
X-CSE-MsgGUID: DNykkdE1SfCXc/1bny3E0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847664"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847664"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:03 -0700
X-CSE-ConnectionGUID: ZhYBeOrIQ2qUXyd86vexZA==
X-CSE-MsgGUID: Lprw/j+wRoSrV05JeLSRLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129468"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:02 -0700
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
Subject: [PATCH v5 0/7] cxl: Support mixed-granularity region interleaves
Date: Thu,  3 Sep 2026 16:23:42 -0700
Message-ID: <cover.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


JonathanC, I kept your tags on Patches 2,5.

RobertR, Same comment as in v4. I've dropped the Originally-by tags since the
implementation no longer carries the selector-bit approach from your original
patch. Let me know what authorship tags you'd like.


Changes in v5:
Series wide:
- Rebase onto 7.3-rc1
- Move the documentation patch to the front of the series (Jonathan)
- Reword commit messages to use new terms of documentation (Jonathan)
- Wrap code and code comments closer to 80 columns (Jonathan)
- Rewrap all commit messages to 75 columns (Jonathan)
- Split combined declarations (Jonathan)
Patch 1: Documentation/cxl: Describe mixed-granularity regions
- Define a mixed-granularity region and monotonic requirement (Jonathan)
- Define span, region position, and weight (Jonathan)
- Explain refining granularity and cross-link first (Jonathan)
- Use an 8-way example interleaved at the host bridge w one switch (Jonathan)
- Clarify config 'legal per the CXL Spec but unsupported by Linux' (Jonathan)
Patch 2: cxl/region: Warn on user region position mismatch
- Log the position mismatch against the region device and name the decoder
Patch 3: cxl/region: Generalize endpoint position mapping
- Pass the region interleave granularity into cxl_calc_interleave_pos() instead
  of using the endpoint decoder granularity (RichardC)
- Rewrite the example comment to define a region position and each decoder
  level's weight, rather than what it spans (Jonathan)
New Patch 4: cxl/region: Name the interleave locals in cxl_port_setup_targets()
- Rename iw and ig to child_iw and child_ig (Jonathan)
Patch 5: cxl/region: Support mixed-granularity auto regions
- Restore the topology-derived peer distance, using 1 only for mixed-granularity
  regions, avoiding a NULL deref on the auto path
- Reject a layout whose derived granularity comes out finer than the region
  granularity, which the topology-derived distance used to catch
- Define what a span is where the root and region spans are compared (Jonathan)
- Add comment that the power-of-two exemption is for same-granularity regions
  that span multiple root interleaves, and that Mod3 roots are width-matched
  instead (Jonathan, Sashiko)
- Report both spans in the span-check dev_dbg
Patch 6: cxl/region: Support mixed-granularity user created regions
- Add a dev_dbg naming both granularities to the coarser-than-root rejection
Patch 7: cxl/test: Add a topology to test mixed-granularity regions
- Rebuild the topology as cross-HB, then HB, then switch (Jonathan)
- Add a third window to support a 12-way region at 256
- Drop the cascade of two switch levels (Jonathan)
- Replace bare '2' with NR_CXL_MIX_GRAN_RPS_PER_HB
- Create and use a chbs_range() helper
Link to v4:
https://lore.kernel.org/linux-cxl/cover.1787255388.git.alison.schofield@intel.com/

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

Linux has required that a region's interleave granularity equal the interleave
granularity of its interleaving root decoder. A mixed-granularity region lifts
that restriction: the region granularity may be finer than the root's, so the
interleave refines from the root toward the endpoints. The mix is between the
root and the region, not granularity varying arbitrarily down the hierarchy.

A CXL region may interleave across multiple decoder levels: root, optional
switches, and endpoint. The equal-granularity requirement blocks legal
mixed-granularity arrangements permitted by CXL 4.0 Section 9.13.1 and makes
some 6-way and 12-way configurations defined in Section 9.13.1.1 (Tables 9-6,
9-7) impossible to create.

Two prior proposals addressed parts of this gap:

AlisonS introduced position arithmetic and sysfs gating for auto and
user-created regions to support the 6- and 12-way interleave configurations
without a same-granularity alternative:
https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/

RobertR introduced an HPA selector-bit model for auto regions that allows
multi-level power-of-two interleaves regardless of granularity ordering:
https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/

This series adds support for CXL regions where interleave granularity differs
between levels of the decoder hierarchy. The support applies to both firmware
programmed auto regions and user created regions.

Linux supports mixed-granularity configurations that are monotonic from the
interleaving root toward the endpoints. Granularity may remain the same or
become finer at each interleaving level. Configurations that refine and then
become coarser are permitted by the CXL Specification but are not supported
by Linux.

This support covers power-of-two and Mod3 interleaves at any depth. Of the Mod3
configs listed in CXL 4.0 Section 9.13.1.1, all are supported except Table 9-6
row 6, the refine-then-coarsen 12-way composition. See the Patch 1 documentation
update for additional info.


Series structure in v5:
-----------------------
Patch 1 documents the mixed-granularity model and Linux support policy.
It comes first so that the terms the rest of the series uses - span,
region position, weight - are defined before they are used.

Patch 2 promotes the existing user-region endpoint position self-test to
a visible diagnostic.

Patch 3 generalizes endpoint position calculation to account for
granularity changes between decoder levels.

Patch 4 names the interleave locals in cxl_port_setup_targets(). It is a
mechanical rename, carried separately so it does not muddy Patch 5.

Patch 5 enables mixed-granularity auto regions and validates their
coarse-to-fine decoder geometry.

Patch 6 enables mixed-granularity user created regions by relaxing the
existing root/region granularity restriction.

Patch 7 adds a cxl_test topology and coverage for mixed-granularity
regions.


The companion NDCTL patchset that allows mixed-granularity 'cxl create-region'
and adds the unit test is posted here:
https://lore.kernel.org/nvdimm/cover.1788469004.git.alison.schofield@intel.com/


Alison Schofield (7):
  Documentation/cxl: Describe mixed-granularity regions
  cxl/region: Warn on user region position mismatch
  cxl/region: Generalize endpoint position mapping
  cxl/region: Name the interleave locals in cxl_port_setup_targets()
  cxl/region: Support mixed-granularity auto regions
  cxl/region: Support mixed-granularity user created regions
  cxl/test: Add a topology to test mixed-granularity regions

 .../driver-api/cxl/linux/cxl-driver.rst       | 153 +++++++
 drivers/cxl/core/region.c                     | 247 +++++++----
 tools/testing/cxl/test/cxl.c                  | 410 +++++++++++++++++-
 3 files changed, 698 insertions(+), 112 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.37.3

