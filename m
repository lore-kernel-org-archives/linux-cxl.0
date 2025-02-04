Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800218A6D4
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643044; cv=none; b=HEw/WXE1j7qt7b/qk4RfX168thPQOJULuy4u+hUbOOmb5lBybCbasESNDQPF57j1nVMN7UyTs/JTPZ5zjw6BmXb78EYxD67VqHlgxDvAYtLJITgJ10RaTnPFsvTglWk1RxJOpqG2LuIedYQJNGfbf6ldjY7Tfp9xwdztb6vKd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643044; c=relaxed/simple;
	bh=+vxTPigUIFj7NnNasD52hngWmabU4gmzwDQd9NDCnfs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ez1SFgUx+mg4anWlsiUZrRp3iUJovcz0z6e9w8RJiiGJaYZFdMEBG4Xm4tOFzoqVrV5dSYHMhbD2zNuQ6wSpIzCx5ig0heUn6kqkZcKIhSAcUYHVxyoGBQkMHXdOIrmWlINYskY3N6BYQwkR3en8o5wTc0j9demHbBe63jQxBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzWMu4SQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzWMu4SQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738643042; x=1770179042;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+vxTPigUIFj7NnNasD52hngWmabU4gmzwDQd9NDCnfs=;
  b=XzWMu4SQ7JchLlyHAWJ5on57j3EUbNN/Fu7qMbpOfojyTCFflRiFj9Q2
   bnh0+/ni7HnQBy30RtMbmr4jHEBFqrRylvI0y8el4LGzqE1zjuzcLiH5L
   XVVR59OBI72/Dr4Yfi4Hs1lqG3LZHVoLmEULBHJW7KotnKMFFd32EUTyl
   ByHknol1JKlFkkuAbQAxAXC5o3ercqPWfDwMN7vaXBoMXdDYflfWLZ1uv
   vQ0ETlFE9DiqF1nqVsaCRvDIqOmPn2B+/mLTP6vFR9glA0RmUBH2arvLw
   1et5w6V3NFXwof++xkB7Lr6xuKAgu81Yn/79cyNW+T8Fzq2g8/abgSjFa
   A==;
X-CSE-ConnectionGUID: BLu7vLSHRmy3Okc1o+ab5A==
X-CSE-MsgGUID: WU/eK9SwRSazNfpmJj7jVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39058634"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="39058634"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:02 -0800
X-CSE-ConnectionGUID: kNarfTP+QeyZQybF8mpsBw==
X-CSE-MsgGUID: 3STr3uuBRSy2PNSEos8jZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114520362"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:01 -0800
Subject: [PATCH v3 0/6] cxl: DPA partition metadata is a mess...
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 dave.jiang@intel.com, Jonathan.Cameron@huawei.com
Date: Mon, 03 Feb 2025 20:24:00 -0800
Message-ID: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v2 [0]:
- Fix "no partition found" debug messages in update_perf_entry() and
  cxl_memdev_set_qos_class() (Jonathan)
- Avoid touching dpa_perf_contains() twice in the series to add / remove
  NULL check (Alejandro)
- Add a cxl_mode_name() helper (Jonathan)
- Use @part as the iterator in cxl_dpa_set_part() to simplify mode
  lookups (Jonathan)
- Require ordered + contiguous partitions (Ira and Alejandro)
- Fix partition detection for BIOS established reservations, and kill
  CXL_PARTMODE_NONE (Jonathan)
- Simplify release_skip() reuse its internals for request_skip()
  (Jonathan)
- Add patch6 to finish cleanup of explicit partition lookups

[0]: http://lore.kernel.org/173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com

---

As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
device [1], and Dynamic Capacity (DCD) support [2], tripped on the
no-longer-fit-for-purpose design in the CXL subsystem for tracking
device-physical-address (DPA) metadata.

In fact there was no design at all, just a couple of open-coded 'struct
resource' instances for 'ram' and 'pmem' and a pile of explicit code
referencing those resources directly.

See patch3 for more details on the specific problems that caused, and
patch4 for the eyesore reduction of making the DPA allocation algorithm
partition number agnostic.

The motivation with this effort is to make it easier to land the Type-2
and DCD series.

[1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
[2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com

---

Dan Williams (6):
      cxl: Remove the CXL_DECODER_MIXED mistake
      cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
      cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
      cxl: Make cxl_dpa_alloc() DPA partition number agnostic
      cxl: Kill enum cxl_decoder_mode
      cxl: Cleanup partition size and perf helpers


 drivers/cxl/core/cdat.c      |  101 +++++++------
 drivers/cxl/core/core.h      |    4 -
 drivers/cxl/core/hdm.c       |  319 ++++++++++++++++++++++++++++++++----------
 drivers/cxl/core/mbox.c      |   66 +++------
 drivers/cxl/core/memdev.c    |   66 +++++----
 drivers/cxl/core/port.c      |   21 ++-
 drivers/cxl/core/region.c    |  137 +++++++++---------
 drivers/cxl/cxl.h            |   39 +----
 drivers/cxl/cxlmem.h         |   52 ++++++-
 drivers/cxl/mem.c            |    2 
 drivers/cxl/pci.c            |    7 +
 tools/testing/cxl/test/cxl.c |   22 +--
 tools/testing/cxl/test/mem.c |    7 +
 13 files changed, 519 insertions(+), 324 deletions(-)

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
