Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C4313E2C
	for <linux-cxl@vger.kernel.org>; Fri, 16 Jan 2026 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539544; cv=none; b=QOISjTN/mk3SOA48d8neZW80xg/i8topiH8wunLwlXjwY5Wma2W80nwgP3vkwll7SYTlIflunZdGwEvOzkxNy1g7OnozOFUauKbtGKEzIV70tzJexn64Ht/MP4Ey/bpH3Kr2tqhiHD2YMOefK4PlJmoNacB1tREo9RO2sHbPVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539544; c=relaxed/simple;
	bh=1s8sQbC66QK5JE4E+H0jDJgChgzSYGoDfBUTLXZXb4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfdJAlq6498xCTGKchK4mfohvnglIZBJ9tvvPy9FkOhSgY4oaDrqak3+TWUKSHSlmN5hZKsi+mowZrTNkkHWR+JaH8ToHYHGFolxoIkcKmdWw3RLPB4JM2Lzfe/Z6OsJbuutdtSBK+wbR9uj328KD9uoX54G/nrqOvV1d1dcibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXYNeAtA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXYNeAtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768539541; x=1800075541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1s8sQbC66QK5JE4E+H0jDJgChgzSYGoDfBUTLXZXb4g=;
  b=HXYNeAtAH4AoeJaM1xQ1+XVq/I1mcgxXnmEkT5TuHy0pYflWJQlZGdoj
   Ft2H1YDADnAAYtVa3D9V5nLGGGXtWx25qQbEiqJazerbFEFuAs2BREDli
   0ep5Hj0VgGmjp8oJwSxf3B2dbSTpJi/DjbWAWXp1ElGNTR1eMAdj2xnTI
   1n1SnoJGEYsuioXyNyKMsUi0hpEOjlIKdCU3PDbRggHeh9HKfp74Z/hOp
   OucDUWdAgsJ4bGNN5DODuO2tAycB7Dz/Fxm1vHOINwuzE9qDm03z+b2Uy
   ir07BO5CuCb7nboFWHgEz8gmxv3PH92WHtme4Mat3+LW4hQsLprWtizZe
   w==;
X-CSE-ConnectionGUID: iuzjG9GbQIa2dt8BC6paSQ==
X-CSE-MsgGUID: Lnou8sHRQS2dxBDB6Px4Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69750222"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="69750222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:59:00 -0800
X-CSE-ConnectionGUID: hkKpWoZUSZKfAoPv6pfHRQ==
X-CSE-MsgGUID: LvuAj8rgRRqvd6/vOiiFfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209289482"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.9])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:58:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/2] cxl/region: Support unaligned address translations
Date: Thu, 15 Jan 2026 20:58:35 -0800
Message-ID: <cover.1768538962.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6: 
- Replace 64-bit division operators with div64_u64() helpers (lkp)

Changes in v5:
- s/reg_ways/region_ways in decode_pos (DaveJ)
- Add comments in decode_pos
- Update the CXL spec references to 4.0

Changes in v4:
- Rebased Patch 1 onto 6.19-rc4 with minimal conflict.
- Added Patch 2 because 6.19 introduced poison by region offset
  meaning that too needed support for unaligned regions.

Changes in v3:
- Add bracketing to avert possibly uninitialized usage (lkp)
- Remove excessive narration in decode_pos()  (Jonathan)
- Calculate devices_per_hb only once after switch in decode_pos() (Jonathan)
- Reduce scope of hpa and shifted in unaligned_dpa_to_hpa() (Jonathan)
- Unmix non- and assignment declarations in unaligned_dpa_to_hpa()  (Jonathan)
- Add blank line after return ULLONG_MAX in unaligned_dpa_to_hpa() (Jonathan)
- s/index/position in for loop in unaligned_dpa_to_hpa() (Jonathan)
- Initialize bool aligned true
- Comment that restore_parent() math relies on power-of-2 granularity
- Tidy-up the restore_parent() comment block

Changes in v2:
- Add 6 and 12 Host Bridge interleaves to decode_pos() (Jonathan)
- Limit the unalignment check to MOD3 regions
- Move the cache_size increment to a single place 
- Updated some in code comments
- Rebase on v6.18-rc1 

Changes in v1 (was RFC):
- Replace "/" with do_div() to quiet i386 build warning (lkp)
- Replace 'cxld->interleave_ways' with 'hbiw' for clarity
- Use div64_u64_rem() for alignment alignment
- Fix up a printk format specifier (lkp)
- Update code comments and commit log
- Rebase on v6.17-rc7


Begin Cover Letter: 
With the introduction of MOD3 interleave way support, platforms may
create regions at starting addresses that are not power-of-2 aligned.
This allows platforms to avoid gaps in the memory map, but addresses
within those regions cannot be translated using the existing bit
manipulation method.

Introduce support for translating these unaligned addresses.


Alison Schofield (2):
  cxl/region: Translate DPA->HPA in unaligned MOD3 regions
  cxl/region: Translate HPA to DPA and memdev in unaligned regions

 drivers/cxl/core/region.c | 212 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 204 insertions(+), 8 deletions(-)


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.37.3

