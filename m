Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A335947
	for <linux-cxl@vger.kernel.org>; Sun, 13 Jul 2025 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374285; cv=none; b=VqHVfAxCOf1zbD6srKooGgP8H/OM+cHBq4/XhmAN4pvxuRcOWmxu+ygQ/BKnOnNNDwjKHAz3Dd1DVfbDWMZgaVTFYMi93+UXcCocBJwZbZqsgiiWlQyExfhITNE9R+FP+KamGR5G4D1DY2Ao/Pvc/c2nh62Dwe7sVSrDUrnAIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374285; c=relaxed/simple;
	bh=pip8VBRP/73o8ubUWG66Y/B147Ei3HJR7dZ2btgt9cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LG0efwFMXMmABLLU6B1vIbCyvpVY3WZsKSzYufCMvD4CBv9ab63CmAoSH6d4WXPTlt9y2oBUTaPJHivjwut6DYaa2QR1esPSI7AcgmH1cdCC1JAEEYCPPLIwTq84rDmw3hNPxFWwpiQoa5dT7xnFAw+vBx7nwSZtjLVxMLTD97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cocdZUDA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cocdZUDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752374283; x=1783910283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pip8VBRP/73o8ubUWG66Y/B147Ei3HJR7dZ2btgt9cQ=;
  b=cocdZUDACn8N/Hx51I1XJWmObWous7yr3fecYtJUgpNBkAVq7R5FIis0
   YW2fiQzb32bMTSDsuxnMcde7U1cwAYgRrvInq2ZWrAlUO49fnymzOfzTN
   KOQqcOiTKkpFQbCoq9jA5uRxXyB39c+HLEzE5OtQJe44Ga6UnwIMWq8KD
   MwFbmlYUK5yUMjT6B5u/20TugYVe9mC0f8IK9edsJu2dgZY/p2CPNZM8s
   tBx9awfnITR1k7Y8sqo0J/h2/B+CnUiLajFFXVmNHP90e7gVNIErmjAmP
   Fd62FLcDS3Ctfaw+1OGvCeEte0uqJzLOIICi4/Hpi//GXSr9WgIhyEBL7
   g==;
X-CSE-ConnectionGUID: r6OvsXZqS1aCJ7AT8VAJuQ==
X-CSE-MsgGUID: V//E5TwnQmWLrGkRDA2uIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65967434"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65967434"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:02 -0700
X-CSE-ConnectionGUID: 3L7g+qdwSG60i8kt8qjxhg==
X-CSE-MsgGUID: WX8F3GTLTRiG2bnvyGE5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157206901"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:01 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/4] cxl: Support Poison Inject & Clear by Region Offset
Date: Sat, 12 Jul 2025 19:37:53 -0700
Message-ID: <cover.1752365427.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Built upon cxl repo branch for-6.17/cxl-acquire.
Please excuse the checkpatch errors in new ACQUIRE syntax.

A stand-alone test of the SPA<=>HPA<=>DPA of calculations is here:
https://github.com/pmem/ndctl/commit/0b5ae6882d882145f671c6d6bd9a4fc1edb4b99d

Changes in v3:
Patch 2
Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
Collapse a header comment into pos and offset blocks (Jonathan)
Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
Mask off bottom bits in < 8 offset case (Jonathan)
Wrap code comments closer to column 80 (Jonathan)
Use a continue to un-nest a for loop. (Jonathan)
Patch 3
Undo v2 return of rc from locked variants. Return 0. (Jonathan)
Patch 4
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


Begin Cover Letter (no change since v2)

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

Patch 3 adds a locked variant of the inject and clear poison ops to
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

 Documentation/ABI/testing/debugfs-cxl |  87 ++++++++++
 drivers/cxl/acpi.c                    |  30 ++--
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |  64 ++++++--
 drivers/cxl/core/region.c             | 218 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h                     |   3 +
 drivers/cxl/cxlmem.h                  |   2 +
 7 files changed, 380 insertions(+), 28 deletions(-)


base-commit: 6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
-- 
2.37.3

