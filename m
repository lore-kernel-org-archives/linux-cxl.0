Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED7225A59
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515411; cv=none; b=gTZxXoavyadpNfw5EQPZfptwdfjTqcoEU9DNF6pNowAKfrAsZPip69uzTLn0nxP6W2t7fOKrusVyR1mLX8cBX22WIEGFmo13k/+TCsodt+xbVI7wf99Bx53hQl2QmWrVaLhyMZo1EUTPd4Oj2F+eZrtIi2PzagIlOfc6vHNszH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515411; c=relaxed/simple;
	bh=uMOg8Y0KK8ino2bFmMqUcKTOsS8uMvmTuuJFT258Ews=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSDJcfkCQT1o+A1vPLs6KUJI5set+jm1s7OO5Y0orp5r2jcbfunE2NBlSRGaWYTdJJLI8qkIRqEo0qxSp1V0LCmsdjE/N9wBCrNEpyOZL4AJkX/VKV6bQpW0smROs03w9gzasdSjX+qRyDrSX5r2ikrQnLCMJh7cTy1Ta7gqJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaTdYUk+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaTdYUk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751515409; x=1783051409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uMOg8Y0KK8ino2bFmMqUcKTOsS8uMvmTuuJFT258Ews=;
  b=LaTdYUk+hpoP7md6lpEet3LaLBzgc15WCgbSkNdMkNY+7kmw+rkY44X+
   dBqP4a4yEfa513Idz7P3M0DrfrZDziYpfX/ul5VuzpRzt/iUmIO+bkUiR
   HWeL9FxPsmCi8irtn8LJ+jQIMIbeVehBDTJvxAhWgndG5P8VyEkHhJO8R
   s6+TpZdSB/fC2/yUGOoXp/jkREbCionD2MYU67xoRKJB6unPuyz0VBdj2
   sOawrepTdwl4GwXBPTe8Yz6RRXEud4CH/9JiywYVKxRR2YIAP18dlj+Sb
   g31eh/xOItufBnBZoVORZXeWV38vSUJG7FFIEDn8sG5ya4T/63dMpYg9f
   g==;
X-CSE-ConnectionGUID: 3BK3FAU3RkCfrUF7OeCzeA==
X-CSE-MsgGUID: XGDz+kcXTJ6s4Qwj1afLJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53692319"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53692319"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:29 -0700
X-CSE-ConnectionGUID: ekkFbPSFROyy0swCVh29IA==
X-CSE-MsgGUID: 6RHkXfYlRUWIu4Rhh9dytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="159951118"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:03:29 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] cxl: Support Poison Inject & Clear by Region Offset
Date: Wed,  2 Jul 2025 21:03:19 -0700
Message-ID: <cover.1751513505.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Beware the rename of patchset and individual patches. Mostly just doing
HPA->Region Offset, and HPA->SPA.

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


Begin (updated) Cover Letter

This series allows expert users to inject and clear poison by writing a
Host Physical Address (HPA) to a region debugfs files. At the core of this
new functionality is a helper that translates an HPA into a Device Physical
Address (DPA) and a memdev based on the region's decoder configuration.

The set is not merely a convenience wrapper for these region poison
operations as it enables these operations for XOR interleaved regions
where they were previously impossible.

Patch 1 defines a SPA->CXL HPA root decoder callback for XOR Math. It's a
restructuring and renaming exercise that enables the reuse of an existing
xormap function in either direction SPA<-->CXL HPA. It gets used in Patch 2.

Patch 2 introduces the translation logic capable of retrieving the memdev
and a DPA for a region offset.

Patch 4 adds a locked variant of the inject and clear poison ops to
support callers that must hold locks during the entire translation and
operation sequence. It gets used in Patch 4.

Patch 4 exposes the capability through region debugfs attributes that 
only appear when all participating memdevs support the poison commands.

At the end of Patch 4 a region offset has been translated to a memdev
and a DPA and can simply be passed through to the pre-existing per memdev
inject and clear poison routines.

A CXL Unit Test update to cxl-poison.sh is posted separately.


Alison Schofield (4):
  cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
  cxl/region: Introduce SPA to DPA address translation
  cxl/core: Add locked variants of the poison inject and clear funcs
  cxl/region: Add inject and clear poison by region offset

 Documentation/ABI/testing/debugfs-cxl |  89 +++++++++-
 drivers/cxl/acpi.c                    |  30 ++--
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |  68 +++++---
 drivers/cxl/core/region.c             | 225 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h                     |   3 +
 drivers/cxl/cxlmem.h                  |   2 +
 7 files changed, 390 insertions(+), 31 deletions(-)


base-commit: 6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
-- 
2.37.3

