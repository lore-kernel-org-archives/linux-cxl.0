Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B12E718B
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507699; cv=none; b=jlt0hOV9J728jxQSjSHieVT2ufJE+MrO9q7K+YRlFZKEkkIAfz31OfbjsOc67MHqcydevtCi90vn5IP37SbJYGJXiq8HReqOTb4/YmuLjCHJXjTTnZvE5JQ8eQPfyU7PS2jK//EfzeBPQV22iX1SG7HyjlEjf4fRQWxnRl4xn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507699; c=relaxed/simple;
	bh=GINO4yMUv1BTnYmhckWtaV1GgSFinUImqps24TgMxZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVqwiac+s6wloipi8alCgNasMyh7ETRsAtV79OtYbz4UCMrdvkbNniWYu3bnAyGHhBiZX1ru2bWJvycb8+GSjIXhEUCvHnQ6bMGAZatYMEY1ThriYdS6pu4BMgLVKDqruNSCPJR4OHIu+qHVrUW+m50BWIT2h3AOQ+KTbW+RhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNRRrC3i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNRRrC3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768507698; x=1800043698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GINO4yMUv1BTnYmhckWtaV1GgSFinUImqps24TgMxZI=;
  b=eNRRrC3iTPgeMJjk/M8ejkd956FLU+Tg/a4oYZe6Y1piM+98db4t/WId
   prJ/I3oQVzIWGN1V1UV8YTvumk6Ftc4oC36ozZsuWPMjVtT8xzmOY+FhP
   7ow94XiUjbBaRsJDZrknc+SRJ4fVzLuu6NyM4+7QWHksKJ5CetiqdnrWc
   6LX0Gdk4ldKpfc58eg7pViq/aB0tAYktT0f5jJr0OiI1iE2fVQE1Iaylo
   ZtnwXYGOJI3bAyZZoKIaSMd1lfitMbqPWUcC2zkkBQotrkybtXB8H9lKb
   lXybmGASyTRmgUbzoXIScg0oIWZqXMm0KKEoDzX2zQr+KQzl2tS9xhdH3
   Q==;
X-CSE-ConnectionGUID: 7BepbqtVSdSeuKjfvkZUbw==
X-CSE-MsgGUID: 5wAfzxBPTDSTCQeV9USgrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69914791"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69914791"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:08:17 -0800
X-CSE-ConnectionGUID: LDszbJ+pTlGe9LQHv9HF1w==
X-CSE-MsgGUID: WCFRxOS1Tw+SzfijAWTiuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="210078255"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.9])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:08:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/2] cxl/region: Support unaligned address translations
Date: Thu, 15 Jan 2026 12:08:10 -0800
Message-ID: <cover.1768504636.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- s/reg_ways/region_ways in decode_pos (DaveJ)
- Add comments in decode_pos
- Update the CXL spec references to 4.0
- Unit test at https://lore.kernel.org/nvdimm/20260115200241.522809-1-alison.schofield@intel.com/

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

