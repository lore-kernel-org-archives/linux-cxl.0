Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7423C4F2
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294422; cv=none; b=hvdn+fTs3xKqnG7CMGpBX5fHOcJUTcsZFjIU4aSIDjeHgsM0Z5T1+FWwHx5U2qWnfFO6sHwnklvzPZxqgzF9zY4bs4YTCb5pTtu5IXL7m/pypVwMTpyywu+n867IZ0n3Ax8gRsh9OoKjsYXhsdFq8QSnwx4BHbNGwUdJB05fP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294422; c=relaxed/simple;
	bh=cbKNVvdASSw0cmH4Hpfn19b1HSbMMuZbvJ8LlM+ImQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdH93RdCgiUiWJ68f060QLxgf5G42hUiEi/81rFY/8nkWKtP9lz2Z0tTw6KKV229e19ZDXTFhkmWoQsK4nAwUSqXwesz75reSo/Y5HHYhXv5T9GDkb87lee71OW2+bcPYZ4iw2D4pUC1cVNZ8ugUFOPwqepKt2HpvCeUXDluaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lw3zTx91; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lw3zTx91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754294420; x=1785830420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cbKNVvdASSw0cmH4Hpfn19b1HSbMMuZbvJ8LlM+ImQI=;
  b=lw3zTx917oAkc2UYwD7J8l4KqtH7rTISsgKlFh5uhTPR9VjhNhSwu0YF
   EituUXkzH8B7LV5pXjC/TyYu/Zv+ovm6X6BCFPegCVJVcCwF6gNlZoOYN
   L1nJDPPf/HdDQ1bB29Ow7S3o24gxUcltBLa+0Mr5GYETrxfK4yo6L9gtQ
   TR5nd5XrSP/6xYbJjefFt7IXou/PG8DM50SAj0zipHVhCwHOqJwJzMh2N
   0HIGz4MvPf05YdkLc5+92/VqNnH2YIKyUYUrBjloxfwGptoNsD7HakeJM
   6n8N7zei6pHO5L2Jr1ZTYCgcWBAa8atoeo61XvHEAcAVH6MRi21RFYQdG
   A==;
X-CSE-ConnectionGUID: 3+TzqZCpSlyYCT+uTLyR1w==
X-CSE-MsgGUID: F4fx41wBQlObLeBAdB6cWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56474216"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56474216"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:18 -0700
X-CSE-ConnectionGUID: Qq9wV/1aSqWqjrc+wiDLpw==
X-CSE-MsgGUID: ArdoPN7/QDuPfZt7GdKqjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168548791"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:00:18 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/5] cxl: Support Poison Inject & Clear by Region Offset
Date: Mon,  4 Aug 2025 01:00:08 -0700
Message-ID: <cover.1754290144.git.alison.schofield@intel.com>
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
A CXL Unit Test update to cxl-poison.sh is posted separately.

Changes in v5:
Changelog appears per patch also.
Patch 1: Remove stray blank line in cxl_root_decoder_alloc() (DaveJ)
Patch 5: Update Documentation/driver-api/cxl/maturity.map

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
System Physical Address (SPA) to a region debugfs files. At the core of this
new functionality is a helper that translates an HPA into a Device Physical
Address (DPA) and a memdev based on the region's decoder configuration.

The set is not merely a convenience wrapper for these region poison
operations as it enables these operations for XOR interleaved regions
where they were previously impossible.

Patch 1 Creates a root decoder ops structure

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

 Documentation/ABI/testing/debugfs-cxl         |  87 +++++++
 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 drivers/cxl/acpi.c                            |  35 ++-
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/memdev.c                     |  60 +++--
 drivers/cxl/core/port.c                       |   1 +
 drivers/cxl/core/region.c                     | 237 +++++++++++++++++-
 drivers/cxl/cxl.h                             |  14 +-
 drivers/cxl/cxlmem.h                          |   2 +
 9 files changed, 406 insertions(+), 36 deletions(-)


base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
-- 
2.37.3

