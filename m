Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E01F4CB7
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443418; cv=none; b=pUofOw4sGLbYFIh5oqVpJ+oWoqwxV9GBhf9qgcEd8xoPOluYg94Hfc8uWj0Bub3ANettNOhayyI8ZkVTJJwbPFPD02DbKCGMWQ1MEn8TQVrnVR0rgs77d2xYiL1Y3UMX4ad6ScjvdftorCJNm0sryLwJGxl9o3zadFji66Q/jDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443418; c=relaxed/simple;
	bh=9yOHen+zDxYb77q+ijBiEXk8HWRTF6MECKkf55XtsmA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nbXhytVc3cHjUd2t4f1RG3mmXjcAoepqA87A7YyaAN+pXI0NFv8DhpF1ZwiHDfw7QT3zo12jD/eSNYJo/owOlE3ruXQ94BiMVG9pFHJUla3SpBP6Gabr+Mh87tlSIxeiN23lXlvuVGGxEegVbNnDcbXOCdLgg+e+ccQ8rxpDjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jX5rIQwT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX5rIQwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750443416; x=1781979416;
  h=date:from:to:cc:subject:message-id;
  bh=9yOHen+zDxYb77q+ijBiEXk8HWRTF6MECKkf55XtsmA=;
  b=jX5rIQwTQxJMD/Md3xk5xTWNnVu8wVokEPB6uG8jcvrzj/KKjMoPBjF/
   Y4DpqwVnfa6gogODvOJNU3Ai4O4W6gecfFlGDkWZTzTciI7gZtsfts1Ub
   pR0PQiZIBKDtYn/Pvm+xsyDXHtmIhWv7pQJVALFlVhiNq7YuhZPDXDSHM
   IJPe9LWIhEPYCw1cevji93LZmyJhmAV9t/gEhThYUOn2QKnZh+XRJYTN1
   k94oBOuI0vCbiIumUa7c3Z9SOeFQiHjs9dYK3LFgG8gSzRw2J8B+ou7Xg
   AupaF4A6e0veLUrR+uoisOH5U+txwlaoAS57l5hyHaHBE3N5NO741YgVy
   A==;
X-CSE-ConnectionGUID: sEh9vURrTVS57PdPtkkMWw==
X-CSE-MsgGUID: V6GXi21tTUS0OY6A+FDoFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52680270"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="52680270"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 11:16:56 -0700
X-CSE-ConnectionGUID: /3UWKtRQS+KVpJj94rjW1w==
X-CSE-MsgGUID: l6Pvd0fBRaOg3MEysY0eUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151115982"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jun 2025 11:16:54 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSgIG-000M3S-06;
	Fri, 20 Jun 2025 18:16:52 +0000
Date: Sat, 21 Jun 2025 02:16:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.17/cleanup-acquire] BUILD SUCCESS
 41e8737fed161ee0cfc9692d8eff881440ef4b10
Message-ID: <202506210234.jeB2spBE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.17/cleanup-acquire
branch HEAD: 41e8737fed161ee0cfc9692d8eff881440ef4b10  cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks

elapsed time: 1199m

configs tested: 249
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250620    clang-21
arc                   randconfig-001-20250620    gcc-8.5.0
arc                   randconfig-002-20250620    clang-21
arc                   randconfig-002-20250620    gcc-11.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                      integrator_defconfig    clang-21
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250620    clang-21
arm                        realview_defconfig    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250620    clang-21
arm64                 randconfig-001-20250620    gcc-9.5.0
arm64                 randconfig-002-20250620    clang-21
arm64                 randconfig-002-20250620    gcc-8.5.0
arm64                 randconfig-003-20250620    clang-21
arm64                 randconfig-003-20250620    gcc-11.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250620    clang-21
csky                  randconfig-001-20250620    gcc-13.3.0
csky                  randconfig-002-20250620    clang-21
csky                  randconfig-002-20250620    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386        buildonly-randconfig-006-20250620    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        alldefconfig    gcc-15.1.0
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250620    clang-21
loongarch             randconfig-001-20250620    gcc-14.3.0
loongarch             randconfig-002-20250620    clang-21
loongarch             randconfig-002-20250620    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
mips                           ci20_defconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250620    clang-21
nios2                 randconfig-001-20250620    gcc-8.5.0
nios2                 randconfig-002-20250620    clang-21
nios2                 randconfig-002-20250620    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250620    clang-21
parisc                randconfig-001-20250620    gcc-10.5.0
parisc                randconfig-002-20250620    clang-21
parisc                randconfig-002-20250620    gcc-12.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250620    clang-21
powerpc               randconfig-002-20250620    gcc-11.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250620    clang-21
powerpc64             randconfig-001-20250620    gcc-14.3.0
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250620    clang-19
powerpc64             randconfig-003-20250620    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250620    gcc-13.3.0
riscv                 randconfig-001-20250620    gcc-14.3.0
riscv                 randconfig-002-20250620    clang-21
riscv                 randconfig-002-20250620    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250620    gcc-13.3.0
s390                  randconfig-001-20250620    gcc-9.3.0
s390                  randconfig-002-20250620    clang-21
s390                  randconfig-002-20250620    gcc-13.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20250620    gcc-13.3.0
sh                    randconfig-001-20250620    gcc-15.1.0
sh                    randconfig-002-20250620    gcc-13.3.0
sh                    randconfig-002-20250620    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250620    gcc-13.3.0
sparc                 randconfig-001-20250620    gcc-8.5.0
sparc                 randconfig-002-20250620    gcc-10.3.0
sparc                 randconfig-002-20250620    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250620    gcc-13.3.0
sparc64               randconfig-002-20250620    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250620    clang-21
um                    randconfig-001-20250620    gcc-13.3.0
um                    randconfig-002-20250620    clang-21
um                    randconfig-002-20250620    gcc-13.3.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250620    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250620    clang-20
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250620    gcc-13.3.0
xtensa                randconfig-001-20250620    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
