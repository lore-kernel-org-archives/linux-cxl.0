Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54D25F984
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217273; cv=none; b=nTpl0ZUoA0Dw3oWkfRqODfG4/ktx85DihSsAFYDMGwBlfQ22BdTVyrG3R6R9JVx7SMBSpO8kLKmx08aEdjwlKxZMMqeW0LOiHT2/mjt/35ewPoCFqi5SP906OxXa4hpIMN9PF3U5fAWv4Hn0oWDvjLFhLSjLFGu5+wThqD/m+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217273; c=relaxed/simple;
	bh=VTQ+xM7P5y4GfAm2hsaU0QxNNCLaMI4fjS4bnHi3N3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6K94ckqKNlqp4pBHvE4xNFiXBeW4oJQMllf5XDU964jjGCscjY8m2JUC7FHjxDyNEK4yRT5vjFFRHoipL2qg9S5xEkstlUlwBvPfChZSWWdgoW5+05VaNA2DPlU/9ly7iYDRzWXF2gQM7MMqGAdBVMeHMvgCrqOwg/qdN9QaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bde0seje; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bde0seje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217272; x=1784753272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VTQ+xM7P5y4GfAm2hsaU0QxNNCLaMI4fjS4bnHi3N3k=;
  b=Bde0sejenrOKAcudm6Tp4DSpYAHta9eBs7yhb0x5RJu2IrDsdLq+y6lL
   1HI5yH+84CYM0i0I4m4uX19thDws6Yx4ixU6molv1ozPneA4xidlp59Uz
   KYd65JRYFVpQWe/IAjVZULprGxbrWeCiXS6hK0AgiOrHEkJ0XAM+Bqdfc
   g75taDCT3mN81dnUy2uusdPoPgVF0DVihh2b5ObSTtd88yc8c51UHydxn
   yq0UkTRRLkyLPNBA0bTogC9WopOYJnEZw17Pf+BsKgfRHk5fHmOCFaAP+
   cpaOfejeXnzrPH4aXgB3qIpMSS4mI4s0qd/DvozP1FX3zFucVtmYP91zv
   w==;
X-CSE-ConnectionGUID: Kp91pU0rQfKiPYcQ1KDGHA==
X-CSE-MsgGUID: rJKfPdeESgyWk3Ah9kOvDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58100176"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58100176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:51 -0700
X-CSE-ConnectionGUID: kzG7NjryRuOEU3oLY1677w==
X-CSE-MsgGUID: OatSo57eT9KbZwyF+y3vfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159001614"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:51 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/5] cxl: Support Poison Inject & Clear by Region Offset
Date: Tue, 22 Jul 2025 13:47:39 -0700
Message-ID: <cover.1753214969.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Built upon cxl repo branch cxl/next
Please excuse the checkpatch errors in new ACQUIRE syntax.

A CXL Unit Test update to cxl-poison.sh is posted separately.
A stand-alone test of the SPA<=>HPA<=>DPA of calculations is here:
https://github.com/pmem/ndctl/commit/0b5ae6882d882145f671c6d6bd9a4fc1edb4b99d

Changes in v4:
Changelog appears per patch also.
Add new precursor patch creating a root decoder ops structure (DaveJ)
Add /* Input validation ensures valid ways and gran */ (Jonathan)
Use a temp instead of modifying hpa_offset in place (Jonathan)
Reorder mask addends to match spec definition (Jonathan)
Add a blank line, remove a blank line (Jonathan)
s/Deivce/Device in commit log (Jonathan)
Use div64_u64_rem() for MOD operation (lkp)
Simplify return in cxl_[inject|clear]_poison() (Jonathan)

Changes in v3:
Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
Collapse a header comment into pos and offset blocks (Jonathan)
Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
Mask off bottom bits in < 8 offset case (Jonathan)
Wrap code comments closer to column 80 (Jonathan)
Use a continue to un-nest a for loop. (Jonathan)
Undo v2 return of rc from locked variants. Return 0. (Jonathan)
Return rc from region_offset_to_dpa_result() if present (Jonathan)
Remove the errant Documentation/ABI fixup (Jonathan)
Add the above rc to the dev_dbg message

Changes in v2:
Rebased onto cxl repo branch for-6.17/cxl-acquire
As the ACQUIRE() set noted, ACQUIRE() syntax leads to a checkpatch
ERROR: do not use assignment in if condition
We'll have to endure that noise here until that set is merged with
a checkpatch.pl update or a change to the syntax.

Changelog appears per patch also:
Simplify return using test_bit() in cxl_memdev_has_poison() (Jonathan)
Use ACQUIRE() in the debugfs inject and clear funcs (DaveJ, Jonathan)
Shift by (eig + eiw) not (eig + 8) in MOD 3 interleaves** (Jonathan)
Simplify bottom bit handling by saving and restoring (Jonathan)
Return the rc from locked variants in cxl_clear/inject_poison
Fail if offset is in the extended linear cache (Jonathan)
Calculate the pos and dpa_offset inline, not in a helper
Remove the not customary __ prefix from locked variants
Added 'cxl' to an existing ABI for memdev clear_poison
Add and use a root decoder callback for spa_to_hpa()
Redefine ABI to take a region offset, not SPA (Dan)
Use div64_u64 instead of / to fix 32-bit ARM (lkp)
Use div64_u64_rem instead of % for arch safety
Remove KernelVersion field in ABI doc (Dan)
Pass pointer to results structures (DaveJ)
Add spec references and comments (DaveJ)
Warn against misuse in ABI doc (Dan)
Add validate_region_offset() helper


Begin Cover Letter 

This series allows expert users to inject and clear poison by writing a
Host Physical Address (HPA) to a region debugfs files. At the core of this
new functionality is a helper that translates an HPA into a Device Physical
Address (DPA) and a memdev based on the region's decoder configuration.

The set is not merely a convenience wrapper for these region poison
operations as it enables these operations for XOR interleaved regions
where they were previously impossible.

Patch 1 is a new precursor patch creating a root decoder ops structure.

Patch 2 defines a SPA->CXL HPA root decoder callback for XOR Math. It's a
restructuring and renaming exercise that enables the reuse of an existing
xormap function in either direction SPA<-->CXL HPA. It gets used in Patch 2.

Patch 3 introduces the translation logic capable of retrieving the memdev
and a DPA for a region offset.

Patch 4 adds a locked variant of the inject and clear poison ops to
support callers that must hold locks during the entire translation and
operation sequence. It gets used in Patch 5.

Patch 5 exposes the capability through region debugfs attributes that 
only appear when all participating memdevs support the poison commands.

By the end of Patch 5 a region offset has been translated to a memdev
and a DPA and can simply be passed through to the pre-existing per memdev
inject and clear poison routines.



Alison Schofield (4):
  cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
  cxl/region: Introduce SPA to DPA address translation
  cxl/core: Add locked variants of the poison inject and clear funcs
  cxl/region: Add inject and clear poison by region offset

Dave Jiang (1):
  cxl: Move hpa_to_spa callback to a new root decoder ops structure

 Documentation/ABI/testing/debugfs-cxl |  87 ++++++++++
 drivers/cxl/acpi.c                    |  35 ++--
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |  60 +++++--
 drivers/cxl/core/port.c               |   2 +
 drivers/cxl/core/region.c             | 237 +++++++++++++++++++++++++-
 drivers/cxl/cxl.h                     |  14 +-
 drivers/cxl/cxlmem.h                  |   2 +
 8 files changed, 406 insertions(+), 35 deletions(-)


base-commit: 3a32c5b3bb7d2dfad5fab94817f59e8963e2b1a6
-- 
2.37.3

