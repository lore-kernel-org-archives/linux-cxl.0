Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859E4718D3
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866673; cv=none; b=sjZb8T6ZOCz4JLGEGVF0rjlXFlqDYKjF016enDddN2EWUwlxCohTarT4IkMXckxIE8mixsB0uWZst/HwSBwFTVTEiIloCj1PoeC2hDWC4Kt1vT8XMXOW96CSI6yx7sTpfatKLJQIc4dPNywCQXGabSknYMumrub/f3WJ7OAkP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866673; c=relaxed/simple;
	bh=O4kx0GPiQepXUqbOxJajbkhgLVNZsB1JgJRqg+C/2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPgAJqzqIhEiBPAgwu8HGyg1C/osjkpXEH6eAcFX5QtArcnAWK5K0ptu9a/KBqgBmN21sWfqinPxb/MnKm/AnaJ4zzNxLtROu9UKajMdcz2pn8DVz9M9x9i7BBzU1Tkk52sxfFYY2qhUetBGlQey7tJTa95ict+YaPtKM7WzDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyGhDDxP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyGhDDxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791866672; x=1823402672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4kx0GPiQepXUqbOxJajbkhgLVNZsB1JgJRqg+C/2ao=;
  b=DyGhDDxPd/07uVayS6ONB9kqrAg0C6ijSY8MwbT5zkeQNWYfMlZeq3rL
   5ylx9Xo4wJM44boSBeqkJDG1JOdyKlXcHmCOY+hMdWTcPnebAsP8rx7Yo
   7lxW1Wl8q/Mr/uc0IM6VINQWD4J7oZsQv2trTUeCG+0uycUlBdhjFBsOk
   0gO/yHFa1oyNf1hAayWH+fGbJnu9CN6IF4931B06vLkUEiqkeraZ4Wd5E
   7fRCC/DWLLisW6Iz+Zxf71/KXnBY5UBv6TDmY+gt4b0W5rvmUBFeF7xzV
   eyauic1FXxwJQjEw6oleMrSQ0c+KPQGpCX/1rZiAp3WKAQ2H7WK0e4LAA
   w==;
X-CSE-ConnectionGUID: U+xQC/qTT2SspojspF/Pjg==
X-CSE-MsgGUID: s3qYKeSNTDu+qc1kXM+Ufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="482787"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="482787"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:31 -0700
X-CSE-ConnectionGUID: o5Ca/gj8TROHRMByDJQJ2g==
X-CSE-MsgGUID: Dit5u7EVQBSX6Xl6UpJK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1170826"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/5] CXL: Support region granularities finer than the root
Date: Mon, 12 Oct 2026 21:44:22 -0700
Message-ID: <cover.1791863201.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** Use to be cxl: Support mixed-granularity region interleaves *** 
Long long time ago, I can still remember when this issue first arose.
I simply called it mixed, because previously region and root decoders
had to match. Well, mixed was too simple and too broad. So rather than
continuing to qualify it, drop it and just state what the set actually
enables: region grans finer than root grans.

It's not just a new title. It reframes a lot of language throughout the
series, from the cover letter, commit messages, documentation, and
code naming.

Changes in v6:
Series wide:
- Reframe the series around what it enables: a region granularity finer
  than the root granularity, with monotonic refinement as the supported
  model. Drop the term "mixed-granularity", which read as support for
  arbitrary granularity arrangements. (Jonathan, Robert)
- Rebase onto the cxl_switch_port_setup_targets() refactor [1].
- Drop "cxl/region: Warn on user region position mismatch", merged in cxl/next
- Drop "cxl/region: Name the interleave locals in cxl_port_setup_targets()". 
Patch 1: Documentation/cxl: Describe region granularity finer than the root
- Separate what the CXL Spec permits from what Linux supports (Robert)
- Describe the resulting support rather than the prior restriction (Robert)
- Define region position by address translation (Robert)
- Define region granularity before the span equation (Robert)
- Condense the Mod3 section, keeping the annotated tables (Robert)
- Reword the refining and coarsening weight explanation
Patch 2: cxl/region: Generalize endpoint position mapping
- Pass the region to cxl_calc_interleave_pos() (Robert)
- Fold the per-level target lookup and weighting into cxl_port_interleave_pos() (Robert)
- Define region position by address translation in the kernel-doc (Robert)
- Drop the stale Normalized Addressing rationale (Robert)
- Name parent_pos in the commit message to match the code (Jonathan)
- Document the negative errno return of cxl_port_interleave_pos()
Patch 3: cxl/region: Support auto region granularity finer than the root
- Put peer distance walk and the iw/ig calculation in helpers (Robert)
- Return the peer distance of 1 explicitly for regions finer than the root,
  and explain why in the comment (Jonathan, Robert)
- Rename cxl_region_validate_interleave() to check_root_interleave() and
  move it next to check_interleave_cap() (Robert)
- Reword the span exemption comment to describe only the same-granularity
  power-of-two exception (Robert)
- Simplify the commit message description of the finer-than-region check (Robert)
- Describe the span identity as a requirement of the supported layouts (Robert)
Patch 4: cxl/region: Support user region granularity finer than the root
- Comment why a region granularity coarser than the root is rejected (Robert)
Patch 5: cxl/test: Add a topology for region granularity finer than the root
- Map the mock memdevs to online NUMA nodes, like other mock topologies
- Skip unpopulated entries in the finer-gran memdev cleanup loops
v5: https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/


Begin Cover Letter:

Linux requires a region's interleave granularity to equal the interleave
granularity of its interleaving root decoder. This series relaxes that one
restriction: a region granularity may be finer than the root granularity,
provided the interleave levels between them refine monotonically toward
the endpoints.

This series does not add general support for every granularity arrangement
the CXL Specification permits. A region granularity coarser than the root
remains invalid, and configurations whose granularity refines and then
coarsens along the decoder path remain unsupported. Of the Mod3
configurations listed in CXL 4.0 Section 9.13.1.1, all are supported
except Table 9-6 row 6, the refine-then-coarsen 12-way composition.

The use case driving this series is 6- and 12-way regions behind a 3-way
host bridge interleave, CXL 4.0 Tables 9-6 and 9-7, which have no
same-granularity alternative. Power-of-two regions finer than the root
fall out of the same implementation.

Support applies to both firmware programmed auto regions and user created
regions.

Two prior proposals addressed parts of this gap:

AlisonS introduced position arithmetic and sysfs gating for auto and
user-created regions to support the 6- and 12-way interleave configurations
without a same-granularity alternative [2].

RobertR introduced an HPA selector-bit model for auto regions that allows
multi-level power-of-two interleaves regardless of granularity ordering [3].

Series structure in v6:
-----------------------
Patch 1 documents which region granularities Linux supports relative to the
root and the monotonic refinement model.

Patch 2 generalizes endpoint position calculation to account for granularity
changes between decoder levels.

Patch 3 enables auto regions with a granularity finer than the root and
validates their decoder geometry.

Patch 4 enables user created regions with a granularity finer than the root
by relaxing the existing root/region granularity restriction.

Patch 5 adds a cxl_test topology and coverage for region granularity finer
than the root.

Dependencies:
-------------
This series is built upon cxl/next, plus the refactor series [1].

The companion NDCTL patchset that allows these regions in 'cxl create-region'
and adds the unit test support is posted [4].


[1] https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/
[3] https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/
[4] https://lore.kernel.org/linux-cxl/cover.1791863817.git.alison.schofield@intel.com/


Alison Schofield (5):
  Documentation/cxl: Describe region granularity finer than the root
  cxl/region: Generalize endpoint position mapping
  cxl/region: Support auto region granularity finer than the root
  cxl/region: Support user region granularity finer than the root
  cxl/test: Add a topology for region granularity finer than the root

 .../driver-api/cxl/linux/cxl-driver.rst       | 119 +++++
 drivers/cxl/core/region.c                     | 220 ++++++---
 tools/testing/cxl/test/cxl.c                  | 420 +++++++++++++++++-
 3 files changed, 681 insertions(+), 78 deletions(-)

-- 
2.37.3

