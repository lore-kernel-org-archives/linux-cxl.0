Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2061EF080
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675509; cv=none; b=boMqvrDrwOVs+zb5MnpHPcQ4Kgh9nYLwjJDZsLYYLxhAI3/4Sien/Ahkja8jlAttWYFqk1o8NdP5KWRysyXTcTuqrZJm2Q+9kczF+BspKsF1awbwBPpmFG0ODIhgClGtr1lz8LwlhyIjaIx1M+rpLEMgBxSHuOOG0Pss2s/6RQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675509; c=relaxed/simple;
	bh=XTSOWAtcmX7g3835AMgu86g6pAlnfOF+vOHsOr2jwM8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QCaVvqiolhpR+gPtV9tUWjFs9hQuibxcjoqUb/gHYnKQfXedKc/BkwPA/07HL2JdhLDW2zGLFQAU8ehPtLl+P50Kae+9GG4y+JsTy3lE6HZNOW/YGzmiGYBI58wz+OwjehiyA4Q+LIPncmDswvPWcJlU6MJM5vswLAd3B1XgXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4fHJM84; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4fHJM84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746675508; x=1778211508;
  h=date:from:to:cc:subject:message-id;
  bh=XTSOWAtcmX7g3835AMgu86g6pAlnfOF+vOHsOr2jwM8=;
  b=C4fHJM84zVSUQ+qPLZqqa7ux0pc3E0gNiSO5klnpfrzf7zchRilIekWh
   t7qOKFRYIWQvnPKAtUnPZlIJ/lVyVxv7Tnx9HcxMjUfkDJLJsvRt4aKfp
   PYyJnkeNFeAKPorykwNrWEBpMcXP2/wqfQc4/AcS67jrQwRr5Jng3QWVH
   Z0OoL6WGmzv/7f8Up22ow1Psi5oT8qk1pH2/utNakaIHxixw2K4E2Z3Ik
   99du38PYa3TXj80Iv9Uzm7lZNcY6wmyXci5Xoze5a6jr2ZnCOZyq5TNnR
   cqqSDKTIL/OdktKCAjyc+Ky0SzRWaLGAPouM7FdfvrfJrBc+uE9b3asDp
   Q==;
X-CSE-ConnectionGUID: B1CQRP9DTiOUeOykJrIjDw==
X-CSE-MsgGUID: AoGTmixlSBiphkJEg5AjlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59068640"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59068640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 20:38:27 -0700
X-CSE-ConnectionGUID: RVNAj+S1SziYMq93bHsoJQ==
X-CSE-MsgGUID: 9ZAN+/gnTeKFc3Tyh39V1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136176228"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 20:38:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCs5X-0009mt-1O;
	Thu, 08 May 2025 03:38:23 +0000
Date: Thu, 08 May 2025 11:37:37 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 8e62ba590160f91abba6490d9c17aa13bada4752
Message-ID: <202505081130.VJMT8rO7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 8e62ba590160f91abba6490d9c17aa13bada4752  cxl/test: Address missing MODULE_DESCRIPTION warnings for cxl_test

elapsed time: 1736m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-14.2.0
alpha       allyesconfig    gcc-14.2.0
alpha          defconfig    gcc-14.2.0
arc         allmodconfig    gcc-14.2.0
arc          allnoconfig    gcc-14.2.0
arc         allyesconfig    gcc-14.2.0
arc            defconfig    gcc-14.2.0
arm         allmodconfig    gcc-14.2.0
arm          allnoconfig    clang-21
arm         allyesconfig    gcc-14.2.0
arm            defconfig    clang-21
arm64       allmodconfig    clang-19
arm64        allnoconfig    gcc-14.2.0
arm64          defconfig    gcc-14.2.0
csky         allnoconfig    gcc-14.2.0
csky           defconfig    gcc-14.2.0
hexagon     allmodconfig    clang-17
hexagon      allnoconfig    clang-21
hexagon     allyesconfig    clang-21
hexagon        defconfig    clang-21
i386        allmodconfig    gcc-12
i386         allnoconfig    gcc-12
i386        allyesconfig    gcc-12
i386           defconfig    clang-20
loongarch   allmodconfig    gcc-14.2.0
loongarch    allnoconfig    gcc-14.2.0
loongarch      defconfig    gcc-14.2.0
m68k        allmodconfig    gcc-14.2.0
m68k         allnoconfig    gcc-14.2.0
m68k        allyesconfig    gcc-14.2.0
m68k           defconfig    gcc-14.2.0
microblaze  allmodconfig    gcc-14.2.0
microblaze   allnoconfig    gcc-14.2.0
microblaze  allyesconfig    gcc-14.2.0
microblaze     defconfig    gcc-14.2.0
mips         allnoconfig    gcc-14.2.0
nios2        allnoconfig    gcc-14.2.0
nios2          defconfig    gcc-14.2.0
openrisc     allnoconfig    gcc-14.2.0
openrisc    allyesconfig    gcc-14.2.0
parisc      allmodconfig    gcc-14.2.0
parisc       allnoconfig    gcc-14.2.0
parisc      allyesconfig    gcc-14.2.0
parisc64       defconfig    gcc-14.1.0
powerpc     allmodconfig    gcc-14.2.0
powerpc      allnoconfig    gcc-14.2.0
powerpc     allyesconfig    clang-21
riscv       allmodconfig    clang-21
riscv        allnoconfig    gcc-14.2.0
riscv       allyesconfig    clang-16
s390        allmodconfig    clang-18
s390         allnoconfig    clang-21
s390        allyesconfig    gcc-14.2.0
sh          allmodconfig    gcc-14.2.0
sh           allnoconfig    gcc-14.2.0
sh          allyesconfig    gcc-14.2.0
sparc       allmodconfig    gcc-14.2.0
sparc        allnoconfig    gcc-14.2.0
um          allmodconfig    clang-19
um           allnoconfig    clang-21
x86_64       allnoconfig    clang-20
x86_64      allyesconfig    clang-20
x86_64         defconfig    gcc-11
xtensa       allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
