Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B925A2D1
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727109; cv=none; b=CzWSoTOf/96OH6vtms8D2ouz5wjsIvxcE9ogwya4BDs9vm7wtzGqiAJCCzwU+SsY73jZvkWP6fUwz6KQwenJKTBA+KOyn8GV7FTBzSySdygaljL/MuSs9PwbtTVA4thZEL+Q26LLeodJJxacsEe9FBd3w5tR1tNtKg8Yf38uApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727109; c=relaxed/simple;
	bh=BcZOxOUdN72II65gMzVzLpsqEfbgpO8UnG8ElhuJHZ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HN6gIAYuuEXgNXqI59VBqIzJ26JITMvNJxq1yo1dk7Hnafmw12ttNBNv+IsIq5BiulaUSwCXEsXxCPTcMkSvC2g3wdgksKfVXEolOn+V4UMXGjjIW7xNvvIel2KnS2UjQ/2ak8uHIvsYNJ8/IQ9ZH5W3fC0bPgn2QYeB+5beFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlT2QtWb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlT2QtWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747727107; x=1779263107;
  h=date:from:to:cc:subject:message-id;
  bh=BcZOxOUdN72II65gMzVzLpsqEfbgpO8UnG8ElhuJHZ8=;
  b=NlT2QtWbsjYtAwWki44BbD6TjXrINNwZB6/Dzqc3yoYx8jU9gjnXx/AD
   KclRmBQRMFDbrpvGNooBiBE7Yhp7+/cfQyJc6CRJ0JO68l+51R6tzYuOY
   esmele/Q5wMHU4aQo40L++khSR8YMhAztPQscj5CKGyID1asuJI7iE69n
   oQoYCgmwDQRj1rcgePYe4+X06ddczc4fz0+/PjU7IRz8dEbT48LAAHyCf
   2MijdtINYgVEEmUS0HmfcOyWJSjr70JznzI91yOoKtsa6pbDJimrMctXU
   O5ihlPUPi96e9GopBUImkIWza6xQaH69+AKVgMG0cJs2z2X3fzQzcbcIQ
   Q==;
X-CSE-ConnectionGUID: TdqmoR5eRhCKa4JOEczm9A==
X-CSE-MsgGUID: AsbMB7j5Qqusl6fpn1eCew==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48761033"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48761033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:45:06 -0700
X-CSE-ConnectionGUID: IuJpnnUlQB+GXAXl/yrhZw==
X-CSE-MsgGUID: Av7UYPNZRceWc+uUUyUYxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139649100"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2025 00:45:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHHeo-000MIq-2D;
	Tue, 20 May 2025 07:45:02 +0000
Date: Tue, 20 May 2025 15:44:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.16/cxl-type2-merge] BUILD SUCCESS
 e82f94c880eba66a8b9af8e713d31a87b553504c
Message-ID: <202505201556.wFOM3SpP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.16/cxl-type2-merge
branch HEAD: e82f94c880eba66a8b9af8e713d31a87b553504c  Merge branch 'for-6.16/cxl-type2' into cxl-for-next

elapsed time: 824m

configs tested: 207
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-001-20250520    gcc-8.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arc                   randconfig-002-20250520    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                                 defconfig    clang-21
arm                          ep93xx_defconfig    clang-21
arm                   milbeaut_m10v_defconfig    clang-19
arm                          moxart_defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-001-20250520    gcc-8.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-002-20250520    gcc-8.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-003-20250520    gcc-8.5.0
arm                   randconfig-004-20250520    gcc-7.5.0
arm                   randconfig-004-20250520    gcc-8.5.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-001-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-8.5.0
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-003-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-8.5.0
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-9.3.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-001-20250520    gcc-9.3.0
hexagon               randconfig-002-20250520    clang-21
hexagon               randconfig-002-20250520    gcc-9.3.0
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-003-20250520    gcc-12
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-005-20250520    gcc-12
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-011-20250520    gcc-12
i386                  randconfig-012-20250520    gcc-12
i386                  randconfig-013-20250520    gcc-12
i386                  randconfig-014-20250520    gcc-12
i386                  randconfig-015-20250520    gcc-12
i386                  randconfig-016-20250520    gcc-12
i386                  randconfig-017-20250520    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-9.3.0
loongarch             randconfig-002-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
nios2                 randconfig-002-20250520    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-001-20250520    gcc-9.3.0
parisc                randconfig-002-20250520    gcc-14.2.0
parisc                randconfig-002-20250520    gcc-9.3.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-001-20250520    gcc-9.3.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-002-20250520    gcc-9.3.0
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc               randconfig-003-20250520    gcc-9.3.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-001-20250520    gcc-9.3.0
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-002-20250520    gcc-9.3.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250520    gcc-12.4.0
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
riscv                 randconfig-002-20250520    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-001-20250520    gcc-12.4.0
s390                  randconfig-002-20250520    clang-21
s390                  randconfig-002-20250520    gcc-12.4.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-12.4.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-12.4.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-12.4.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250520    gcc-12.4.0
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-001-20250520    gcc-12.4.0
um                    randconfig-002-20250520    clang-21
um                    randconfig-002-20250520    gcc-12.4.0
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-12.4.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
