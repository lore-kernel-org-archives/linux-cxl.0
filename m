Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECC26D4DD
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101724; cv=none; b=dc9YgSIWJHxVxDdqaD2rqXz48zLy/YVB78hF2eRLUp1Uh2Vu8iNT5rfZQsUg2Sm9zhbwljiywoAHeU7IVVsm6q6MvYl4xwmFzwsjXsX/fcHoSBdmJbXJsK2NqgjOAg7fZSZpR6EElvQyx2wM1plA8diR0sbt8mNuIk28yu1hIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101724; c=relaxed/simple;
	bh=TU4Nmo5PJJtecL4qVu8JICU1X1fBRuNtF1i8ACJcq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V7KiAbNhD/ZaxP8byVZtvfMMfZxBSu0m9rFKepGkg1ztEM7ayjd0n6J4QSuznZqsITxc7zVZHz7mJ4oued9ezOcXPjs7F2rlMw4JQozLvg54+dTvUa8LSh0qLg5Dsu/fQ92C9cqWPTFfrb8bULRW/DL8lelzUzvkB/Hfy7bVxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW1bUd05; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW1bUd05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784101722; x=1815637722;
  h=date:from:to:cc:subject:message-id;
  bh=TU4Nmo5PJJtecL4qVu8JICU1X1fBRuNtF1i8ACJcq1Y=;
  b=PW1bUd050DX4tECQ7dgVCdTHasUlWs8Whea5Pko3P84cooY05LP/MRaD
   aK3tv48ux60nDPCgUHfOwGfRJhArgojVOpj8gvTAgTqEg6cLDY9WXPUjq
   A0Xeik9ceP7Fn96aFUZ8CSl1UkCm478UImofD6kO1ghIFAIk2kYKxgpIR
   BKCE9yUqOSmt8SxCkfE++GpQAsDEUglSaCx77cYwVeKX6Bm5yEmJG20Iu
   YU3BqRCbmN6Ap5VDAxBlZDV5shhRocuEt5QUrnPvz7aSO7OGeGX+sMV8o
   duQlyPaF77OGTUsUGjlGZLNg4IhZB2ndJNEPnGKBLgkMeZLc+nNSzqqV7
   A==;
X-CSE-ConnectionGUID: A+E3o8TPS9mEGURb6CkWFg==
X-CSE-MsgGUID: ObwZA4NGQHeCFskcUvMoOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95332041"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95332041"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:48:42 -0700
X-CSE-ConnectionGUID: LQhsJaK0Rky+FcUaN9cbYQ==
X-CSE-MsgGUID: j7ub4BEpTWafz8bIW76tvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="253482293"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jul 2026 00:48:39 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjuM6-00000000NQF-49ZP;
	Wed, 15 Jul 2026 07:48:35 +0000
Date: Wed, 15 Jul 2026 15:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 6675748e6267a86a0facb7ad22ec88b7192a4126
Message-ID: <202607151505.HaCoolAM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 6675748e6267a86a0facb7ad22ec88b7192a4126  Merge branch 'for-7.3/cxl-fixes' into cxl-for-next

elapsed time: 879m

configs tested: 281
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-10.5.0
arc                   randconfig-001-20260715    gcc-10.5.0
arc                   randconfig-001-20260715    gcc-9.5.0
arc                            randconfig-002    gcc-10.5.0
arc                   randconfig-002-20260715    gcc-10.5.0
arc                   randconfig-002-20260715    gcc-15.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                             pxa_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-10.5.0
arm                   randconfig-001-20260715    clang-23
arm                   randconfig-001-20260715    gcc-10.5.0
arm                            randconfig-002    gcc-10.5.0
arm                   randconfig-002-20260715    clang-23
arm                   randconfig-002-20260715    gcc-10.5.0
arm                            randconfig-003    gcc-10.5.0
arm                   randconfig-003-20260715    gcc-10.5.0
arm                   randconfig-003-20260715    gcc-15.2.0
arm                            randconfig-004    gcc-10.5.0
arm                   randconfig-004-20260715    gcc-10.5.0
arm                         socfpga_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260715    gcc-16.1.0
arm64                 randconfig-001-20260715    gcc-9.5.0
arm64                 randconfig-002-20260715    gcc-15.2.0
arm64                 randconfig-002-20260715    gcc-16.1.0
arm64                 randconfig-003-20260715    clang-23
arm64                 randconfig-003-20260715    gcc-16.1.0
arm64                 randconfig-004-20260715    gcc-11.5.0
arm64                 randconfig-004-20260715    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260715    gcc-16.1.0
csky                  randconfig-002-20260715    gcc-13.4.0
csky                  randconfig-002-20260715    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-11.5.0
hexagon               randconfig-001-20260715    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-11.5.0
hexagon               randconfig-002-20260715    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260715    clang-22
i386        buildonly-randconfig-002-20260715    clang-22
i386        buildonly-randconfig-002-20260715    gcc-14
i386        buildonly-randconfig-003-20260715    clang-22
i386        buildonly-randconfig-003-20260715    gcc-14
i386        buildonly-randconfig-004-20260715    clang-22
i386        buildonly-randconfig-004-20260715    gcc-14
i386        buildonly-randconfig-005-20260715    clang-22
i386        buildonly-randconfig-006-20260715    clang-22
i386        buildonly-randconfig-006-20260715    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260715    clang-22
i386                  randconfig-001-20260715    gcc-14
i386                  randconfig-002-20260715    clang-22
i386                  randconfig-003-20260715    clang-22
i386                  randconfig-003-20260715    gcc-12
i386                  randconfig-004-20260715    clang-22
i386                  randconfig-004-20260715    gcc-14
i386                  randconfig-005-20260715    clang-22
i386                  randconfig-006-20260715    clang-22
i386                  randconfig-006-20260715    gcc-14
i386                  randconfig-007-20260715    clang-22
i386                  randconfig-007-20260715    gcc-14
i386                  randconfig-011-20260715    clang-22
i386                  randconfig-011-20260715    gcc-14
i386                  randconfig-012-20260715    gcc-14
i386                  randconfig-013-20260715    gcc-14
i386                  randconfig-014-20260715    clang-22
i386                  randconfig-014-20260715    gcc-14
i386                  randconfig-015-20260715    clang-22
i386                  randconfig-015-20260715    gcc-14
i386                  randconfig-016-20260715    clang-22
i386                  randconfig-016-20260715    gcc-14
i386                  randconfig-017-20260715    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-11.5.0
loongarch             randconfig-001-20260715    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-11.5.0
loongarch             randconfig-002-20260715    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        bcm63xx_defconfig    clang-23
mips                      maltaaprp_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-11.5.0
nios2                 randconfig-001-20260715    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-11.5.0
nios2                 randconfig-002-20260715    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260715    clang-23
parisc                randconfig-001-20260715    gcc-12.5.0
parisc                randconfig-002-20260715    clang-23
parisc                randconfig-002-20260715    gcc-14.3.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260715    clang-23
powerpc               randconfig-001-20260715    gcc-8.5.0
powerpc               randconfig-002-20260715    clang-23
powerpc64             randconfig-001-20260715    clang-23
powerpc64             randconfig-002-20260715    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260715    clang-17
riscv                 randconfig-001-20260715    gcc-15.2.0
riscv                 randconfig-002-20260715    gcc-15.2.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260715    gcc-12.5.0
s390                  randconfig-001-20260715    gcc-15.2.0
s390                  randconfig-002-20260715    clang-23
s390                  randconfig-002-20260715    gcc-15.2.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260715    gcc-15.2.0
sh                    randconfig-001-20260715    gcc-16.1.0
sh                    randconfig-002-20260715    gcc-15.2.0
sh                    randconfig-002-20260715    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260715    gcc-16.1.0
sparc                 randconfig-002-20260715    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260715    clang-23
sparc64               randconfig-001-20260715    gcc-16.1.0
sparc64               randconfig-002-20260715    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260715    clang-23
um                    randconfig-001-20260715    gcc-16.1.0
um                    randconfig-002-20260715    gcc-14
um                    randconfig-002-20260715    gcc-16.1.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260715    clang-22
x86_64      buildonly-randconfig-001-20260715    gcc-14
x86_64      buildonly-randconfig-002-20260715    gcc-14
x86_64      buildonly-randconfig-003-20260715    gcc-14
x86_64      buildonly-randconfig-004-20260715    gcc-14
x86_64      buildonly-randconfig-005-20260715    clang-22
x86_64      buildonly-randconfig-005-20260715    gcc-14
x86_64      buildonly-randconfig-006-20260715    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260715    clang-22
x86_64                randconfig-002-20260715    clang-22
x86_64                randconfig-003-20260715    clang-22
x86_64                randconfig-004-20260715    clang-22
x86_64                randconfig-004-20260715    gcc-14
x86_64                randconfig-005-20260715    clang-22
x86_64                randconfig-006-20260715    clang-22
x86_64                randconfig-006-20260715    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260715    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260715    clang-22
x86_64                randconfig-012-20260715    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260715    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260715    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260715    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260715    clang-22
x86_64                randconfig-071-20260715    gcc-14
x86_64                randconfig-072-20260715    gcc-14
x86_64                randconfig-073-20260715    gcc-14
x86_64                randconfig-074-20260715    gcc-14
x86_64                randconfig-075-20260715    gcc-14
x86_64                randconfig-076-20260715    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260715    gcc-14.3.0
xtensa                randconfig-001-20260715    gcc-16.1.0
xtensa                randconfig-002-20260715    gcc-12.5.0
xtensa                randconfig-002-20260715    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
