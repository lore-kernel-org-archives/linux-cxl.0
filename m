Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8F78F2B
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174840; cv=none; b=RqY89Ez2VoAnL50LJd+VRWkZP7RjwYaiCUe5+wljIL/71a6TWV8Ut5PBuxkp207xrAADoUL9a1F2Rq65NRCcdB5eg2YVg5PayUXGCFRzTCKW97nC5I4KVz6LhqFLg/EFV9qThnUG26nqKy3YnPJqJxDqfzVEQdbw6ypWHp2oGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174840; c=relaxed/simple;
	bh=YTB+b+lX3lV30Twb0r27E7fahengim1ieqdN7vnFePg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZqUIX1nGFbFOvt1GkaBK+vNbc4YeK6O6gj9s5Jc6shgpLX6YLEjO9oEJlkhxi0GADrsP7Hie+QHDn0hayFbmOFXlh13CN6+AIR/qpF0RZuLQJHOKrkC8r0MWRsQBPs2DTYWnw7aVqKWGxiGznI1/GPwe5urmm8txc4Jt/wn4tIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFe+2zEs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFe+2zEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784174840; x=1815710840;
  h=date:from:to:cc:subject:message-id;
  bh=YTB+b+lX3lV30Twb0r27E7fahengim1ieqdN7vnFePg=;
  b=LFe+2zEsb3U0IW0Ur4cWmqwwAog51eraesq/xQHfi6JRWveAhoU4++ZX
   GZ5lRChtvDV/BrvoPqzoPDQB/J+v+A5D1lgStreBxvmpVShwo0Qv+qR7j
   Mxuc0EYXwO0/Ybk6akyxR0FI7g0jGWVCyOZ13ckQ/3XuSEIYYzxiQhH3o
   Pu3dRE2fGS27QB4yvrrfLGUD2QLVtRRYlsHjvjgdq4YHLl0Wrfo7OwCCR
   p2zG0pS1APNUMO1z2LMfbjGbvsBw+OdDN8pVPo8qJOu6CZzEOQjHWyE5r
   IOe71S3VvtJuLDOYRBGD3PqYmLb3EsIAvYmkFKMdQ1Dt7+/gyVbOHaGIR
   A==;
X-CSE-ConnectionGUID: 7lQXVUVUQXGp9byNM0K8oA==
X-CSE-MsgGUID: 4iW2BOYUS/aE/viIMbYPxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84853179"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84853179"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 21:07:19 -0700
X-CSE-ConnectionGUID: bjzPMPanQTCKROfzOPJ/TA==
X-CSE-MsgGUID: J9u2jbeQRaCrhXenvrM2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="257017632"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 15 Jul 2026 21:07:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkDNQ-00000000OIX-1bmg;
	Thu, 16 Jul 2026 04:07:12 +0000
Date: Thu, 16 Jul 2026 12:06:36 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d
Message-ID: <202607161223.yTPvMy3i-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d  Bounds-check the fwctl feature commands

elapsed time: 731m

configs tested: 179
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260716    gcc-14.3.0
arc                   randconfig-002-20260716    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260716    gcc-8.5.0
arm                   randconfig-002-20260716    clang-17
arm                   randconfig-003-20260716    gcc-12.5.0
arm                   randconfig-004-20260716    clang-23
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260716    clang-23
arm64                 randconfig-002-20260716    clang-22
arm64                 randconfig-003-20260716    clang-23
arm64                 randconfig-004-20260716    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260716    gcc-12.5.0
csky                  randconfig-002-20260716    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260716    clang-23
hexagon               randconfig-002-20260716    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-001-20260716    clang-22
i386                  randconfig-002-20260716    clang-22
i386                  randconfig-003-20260716    gcc-14
i386                  randconfig-004-20260716    gcc-14
i386                  randconfig-005-20260716    clang-22
i386                  randconfig-006-20260716    clang-22
i386                  randconfig-007-20260716    clang-22
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260715    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260715    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260715    gcc-14
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260715    clang-22
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260715    clang-22
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260715    clang-22
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260715    gcc-14
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-002-20260716    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                         cobalt_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260716    gcc-8.5.0
nios2                 randconfig-002-20260716    gcc-8.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260716    gcc-15.2.0
parisc                randconfig-002-20260716    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260716    clang-21
powerpc               randconfig-002-20260716    clang-19
powerpc64             randconfig-001-20260716    clang-22
powerpc64             randconfig-002-20260716    clang-23
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260716    gcc-14.3.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-002-20260716    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260716    gcc-16.1.0
sh                    randconfig-002-20260716    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260716    clang-23
sparc64               randconfig-002-20260716    clang-23
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260716    clang-23
um                    randconfig-002-20260716    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260716    clang-22
x86_64      buildonly-randconfig-002-20260716    gcc-14
x86_64      buildonly-randconfig-003-20260716    gcc-14
x86_64      buildonly-randconfig-004-20260716    gcc-14
x86_64      buildonly-randconfig-005-20260716    gcc-14
x86_64      buildonly-randconfig-006-20260716    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260716    gcc-12
x86_64                randconfig-002-20260716    gcc-14
x86_64                randconfig-003-20260716    clang-22
x86_64                randconfig-004-20260716    clang-22
x86_64                randconfig-005-20260716    clang-22
x86_64                randconfig-006-20260716    gcc-14
x86_64                randconfig-011-20260716    clang-22
x86_64                randconfig-012-20260716    clang-22
x86_64                randconfig-013-20260716    gcc-14
x86_64                randconfig-014-20260716    clang-22
x86_64                randconfig-015-20260716    clang-22
x86_64                randconfig-016-20260716    gcc-14
x86_64                randconfig-074-20260716    gcc-14
x86_64                randconfig-076-20260716    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                  nommu_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-9.5.0
xtensa                randconfig-002-20260716    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
