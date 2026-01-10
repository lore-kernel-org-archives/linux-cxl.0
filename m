Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6581A3164
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010061; cv=none; b=LppDGSqhNYDVIJZ67JMmharrKY5qqHSGpt0ri1aJeO7yDo9NyM5mlR6px12X0ZVbwNibfVgk2An5j7q7yqcui1BJNdRvMZJCXcYalhRz0IDI7w1pKnP8Ou7FcoLmCRwnpIBJO6MOr1HpuIafyGb73L0IC8E9LxPeqzOzhqeH43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010061; c=relaxed/simple;
	bh=bEP/XpeZV1ls4905lWpZQijafd20fOTkcIhlm+CSeJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDEMdmSOV+FgYMRRdqkGlRdR1j3GGTgeuaH0wFPBttHcVctfa/j+YggZM8v/ce5xyH2G+ehFpd1jHJibAMT+WjcrFiNvZHIT3pPg3mnMhb6KPtic8qWEB3UzrfW+T5zbjnkGMOVeoirIn6BqpWZgiEh5WGnedJ3bac4d5VXACsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GV7HBYjz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV7HBYjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768010059; x=1799546059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bEP/XpeZV1ls4905lWpZQijafd20fOTkcIhlm+CSeJY=;
  b=GV7HBYjzUu/z1CpoLGJ2n2vBAhbXnU05AiNtprhAV8D4FAepvDTQSntQ
   M5/FJm0JQ0nwoHqvYtIF//kE4UBCGxSbQLIuHJqDzJIblTIVWfnvqgzZ+
   5O/PIrI8hiuKlQ1I/pzdxgu296/2AErFF8BpqwKQXQ1FwJV0TuS0qLHoM
   GzoxRSVSFC0OXtJ2yKPgOs7/LBs4aOajtumPE3gknkrCdTu32mBPvbi0S
   2UUtN0iQ6HsY2gCDSW0n98GAeWrHJmUYveWdCV8wdttC/9f8UVBoXmzNc
   1eLpXWRyGj04oz7Kp+lVlckzJYsAndeji8vJ0Q2lJ2x6HT8RzUTkdisph
   g==;
X-CSE-ConnectionGUID: VlwMAq3VTRaOAwAfYEMFkA==
X-CSE-MsgGUID: sx5htiEmQYKl1K1LxclqUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69319313"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="69319313"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 17:54:19 -0800
X-CSE-ConnectionGUID: e6g52YSgRwa9z+9fEP9Wsw==
X-CSE-MsgGUID: MjQ1yhArQNefQy7d/zRWhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="203519663"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.121])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 17:54:18 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/2] cxl/region: Support unaligned address translations
Date: Fri,  9 Jan 2026 17:54:12 -0800
Message-ID: <cover.1768008522.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I took the liberty of rolling this into a patchset and keeping
my original versioning. Patch 1's change history is appended
below. Patch 2 is a new add to align with the poison by region
offset feature available in 6.19.

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

 drivers/cxl/core/region.c | 205 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 197 insertions(+), 8 deletions(-)


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.37.3

