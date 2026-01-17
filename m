Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91932AAA5
	for <linux-cxl@vger.kernel.org>; Sat, 17 Jan 2026 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768629286; cv=none; b=Z8sBYbl4YpFkWv4lxBDI9lU8E6Uk63sxASeWcsQDcsATiCbvZdjJA4zpm6dStAWWtbIE384jyE2ZtnJzw0iGu1PULHd9e+qfASTE3lTbA4xr1D540sIy8C22AdckybnkrlCAp0Z7V7ICkepzCDqPQeZl5bY8wxUE4flTp4617Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768629286; c=relaxed/simple;
	bh=++TmV79Mu3sZ38+ODLvP+WCnX7MTh1qKhSwKT6vir3s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TxxHEdwBaFQqMD9xVrNuUMgO7bb5pc56Fwq98NMrjm10MfixKujRdT2+POXKJJq8FUjlRvfdNW06EfoqKbZBuwCfJotLDH2yoMEPn1KpK0gsJSsprGc1bEFmzVCoRBu3JCht3P79C1dQOeo8k95dv2xqsW55FBB59h+5ey0YCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzsKuDz+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzsKuDz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768629284; x=1800165284;
  h=date:from:to:cc:subject:message-id;
  bh=++TmV79Mu3sZ38+ODLvP+WCnX7MTh1qKhSwKT6vir3s=;
  b=mzsKuDz+MxXPIvtaVTal9HsonVj+z7SKjn7XcbDuX0iT+5jdOgtgIOvI
   4FXBh80K09zBcgcb30Gm7nzT6nUzDPqAS8UuBPlM28ODKxRK1muvcjUwD
   P2oDPWTrNX1ekEGRifDid3I36pCTMHMIx7qPPoUlvPYHWYZbI18q26kdP
   o4n5c3cqtNMQB0tvC2JdYmHNalZhOUyvhCpPGI2xFSKb6btiK5sFrP9/a
   3oI9xgdo86AdniClX2BeyqZzaGMnluu3/14USMTcT8tovrMCcwny0ZB97
   drbLIJTrrEBaTCDv9Tst7pPxskLYbUH9LnhNAyayR2Faa26ATxKVVUtzR
   A==;
X-CSE-ConnectionGUID: vEoPa9gURhmWmKswxg7ozQ==
X-CSE-MsgGUID: z2qNvx70Q1iFJh0S4qMURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69139957"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="69139957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 21:54:44 -0800
X-CSE-ConnectionGUID: o69JD86+SBqp27pKcYKvcA==
X-CSE-MsgGUID: a8L4jSzDQfyTjGhPU24yEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="205315111"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jan 2026 21:54:42 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgzGh-00000000LbM-1HpL;
	Sat, 17 Jan 2026 05:54:39 +0000
Date: Sat, 17 Jan 2026 13:53:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.0/cxl-init] BUILD SUCCESS
 bc62f5b308cbdedf29132fe96e9d591e526527e1
Message-ID: <202601171349.GMMXS3N2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.0/cxl-init
branch HEAD: bc62f5b308cbdedf29132fe96e9d591e526527e1  dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is ready

elapsed time: 811m

configs tested: 270
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs103_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260117    gcc-12.5.0
arc                   randconfig-001-20260117    gcc-8.5.0
arc                   randconfig-002-20260117    gcc-12.5.0
arc                   randconfig-002-20260117    gcc-9.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20260117    clang-20
arm                   randconfig-001-20260117    gcc-12.5.0
arm                   randconfig-002-20260117    gcc-12.5.0
arm                   randconfig-002-20260117    gcc-8.5.0
arm                   randconfig-003-20260117    gcc-12.5.0
arm                   randconfig-003-20260117    gcc-8.5.0
arm                   randconfig-004-20260117    gcc-12.5.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           stm32_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260117    clang-22
arm64                 randconfig-001-20260117    gcc-15.2.0
arm64                 randconfig-002-20260117    clang-22
arm64                 randconfig-003-20260117    clang-18
arm64                 randconfig-003-20260117    clang-22
arm64                 randconfig-004-20260117    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260117    clang-22
csky                  randconfig-001-20260117    gcc-12.5.0
csky                  randconfig-002-20260117    clang-22
csky                  randconfig-002-20260117    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260117    clang-22
hexagon               randconfig-002-20260117    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260117    clang-20
i386        buildonly-randconfig-001-20260117    gcc-13
i386        buildonly-randconfig-002-20260117    gcc-13
i386        buildonly-randconfig-003-20260117    gcc-13
i386        buildonly-randconfig-004-20260117    clang-20
i386        buildonly-randconfig-004-20260117    gcc-13
i386        buildonly-randconfig-005-20260117    gcc-13
i386        buildonly-randconfig-006-20260117    clang-20
i386        buildonly-randconfig-006-20260117    gcc-13
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260117    gcc-13
i386                  randconfig-001-20260117    gcc-14
i386                  randconfig-002-20260117    gcc-14
i386                  randconfig-003-20260117    clang-20
i386                  randconfig-003-20260117    gcc-14
i386                  randconfig-004-20260117    gcc-14
i386                  randconfig-005-20260117    clang-20
i386                  randconfig-005-20260117    gcc-14
i386                  randconfig-006-20260117    clang-20
i386                  randconfig-006-20260117    gcc-14
i386                  randconfig-007-20260117    clang-20
i386                  randconfig-007-20260117    gcc-14
i386                  randconfig-011-20260117    clang-20
i386                  randconfig-011-20260117    gcc-14
i386                  randconfig-012-20260117    gcc-14
i386                  randconfig-013-20260117    gcc-14
i386                  randconfig-014-20260117    gcc-14
i386                  randconfig-015-20260117    gcc-12
i386                  randconfig-015-20260117    gcc-14
i386                  randconfig-016-20260117    clang-20
i386                  randconfig-016-20260117    gcc-14
i386                  randconfig-017-20260117    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260117    clang-20
loongarch             randconfig-001-20260117    clang-22
loongarch             randconfig-002-20260117    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                          rm200_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260117    clang-22
nios2                 randconfig-001-20260117    gcc-8.5.0
nios2                 randconfig-002-20260117    clang-22
nios2                 randconfig-002-20260117    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260117    clang-22
parisc                randconfig-001-20260117    gcc-12.5.0
parisc                randconfig-002-20260117    clang-22
parisc                randconfig-002-20260117    gcc-15.2.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260117    clang-22
powerpc               randconfig-001-20260117    gcc-8.5.0
powerpc               randconfig-002-20260117    clang-22
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260117    clang-22
powerpc64             randconfig-002-20260117    clang-22
powerpc64             randconfig-002-20260117    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260117    clang-22
riscv                 randconfig-001-20260117    gcc-10.5.0
riscv                 randconfig-002-20260117    clang-17
riscv                 randconfig-002-20260117    gcc-10.5.0
s390                             alldefconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260117    clang-22
s390                  randconfig-001-20260117    gcc-10.5.0
s390                  randconfig-002-20260117    clang-22
s390                  randconfig-002-20260117    gcc-10.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        dreamcast_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260117    gcc-14.3.0
sparc                 randconfig-001-20260117    gcc-8.5.0
sparc                 randconfig-002-20260117    gcc-14.3.0
sparc                 randconfig-002-20260117    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260117    clang-22
um                    randconfig-001-20260117    gcc-14.3.0
um                    randconfig-002-20260117    clang-22
um                    randconfig-002-20260117    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260117    clang-20
x86_64      buildonly-randconfig-002-20260117    clang-20
x86_64      buildonly-randconfig-003-20260117    clang-20
x86_64      buildonly-randconfig-004-20260117    clang-20
x86_64      buildonly-randconfig-005-20260117    clang-20
x86_64      buildonly-randconfig-006-20260117    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260117    clang-20
x86_64                randconfig-002-20260117    clang-20
x86_64                randconfig-003-20260117    clang-20
x86_64                randconfig-004-20260117    clang-20
x86_64                randconfig-005-20260117    clang-20
x86_64                randconfig-005-20260117    gcc-12
x86_64                randconfig-006-20260117    clang-20
x86_64                randconfig-006-20260117    gcc-14
x86_64                randconfig-011-20260117    clang-20
x86_64                randconfig-012-20260117    clang-20
x86_64                randconfig-013-20260117    clang-20
x86_64                randconfig-014-20260117    clang-20
x86_64                randconfig-015-20260117    clang-20
x86_64                randconfig-015-20260117    gcc-14
x86_64                randconfig-016-20260117    clang-20
x86_64                randconfig-071-20260117    clang-20
x86_64                randconfig-072-20260117    clang-20
x86_64                randconfig-072-20260117    gcc-13
x86_64                randconfig-073-20260117    clang-20
x86_64                randconfig-074-20260117    clang-20
x86_64                randconfig-075-20260117    clang-20
x86_64                randconfig-076-20260117    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260117    gcc-10.5.0
xtensa                randconfig-001-20260117    gcc-14.3.0
xtensa                randconfig-002-20260117    gcc-13.4.0
xtensa                randconfig-002-20260117    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
