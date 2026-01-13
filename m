Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E537BE7A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292140; cv=none; b=HG0fcRmE8p+3sbXjkh8gI216Nx0fAuk1ONwxyIFjadm+0dKfFj5V6wsKHE37WyWTiTCsN8w9FacaSKa0HZEmowOtp28sf4gQy5eEGMs0M4uzaLO7aBLvURXA1cT/xsTHcRJwtFfE9WMspO1cKpdZf35YLjcyq0xxsrfHH42EirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292140; c=relaxed/simple;
	bh=2nHjrwL1zii+nj7Hi2mHBVOg+C3wrsaqa3i/oayMPC8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CrbfeVK7XscOTuDFc/tXh75CQ+wZXaPjCQ6XusGS1B/34qEDmdcJyJ0m+k/iMUfmzprY4nH0oqHbmVeQaWHF3s8W7q8riyvy3cHm7Uo6PE38qkMUWeHAQLMHh3NpiBxXtVbBJMlSa6oABhLVP/o/ywFbQNeu1ue9Ro3H9dLKNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdBAmtgU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdBAmtgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768292139; x=1799828139;
  h=date:from:to:cc:subject:message-id;
  bh=2nHjrwL1zii+nj7Hi2mHBVOg+C3wrsaqa3i/oayMPC8=;
  b=SdBAmtgUTnLhhBKUR2esBEC3fiCL24H1BWwx+lbc5RuEKecQ1zwjPuMt
   wH7E5VuVhWJQPTDFBTxmMj+2kemi/DenRZKaqOGlPMbe2LCf4aEewk06e
   cmhp+fzKpi5S0i9k75V43wMESA8eaoBsMRT7yKOAudR/tctMeRW3SDBL5
   diRZG9XLKj1uEa3Qv69ovdqmAFYVe57CdWu1N6NP+KR+ZDj/0I/2AjTjb
   rDljxfLwwcqpzJ+p0xbMG3mKE74mMWuM2DPc8lKPWbSAYLWxYMkksc16b
   o4aX8tHqeLUtKMB7Ni3SWkw/4X2mgZtXKG9Wic9wfIWAVCkQR35io6s1G
   g==;
X-CSE-ConnectionGUID: e9eAcEStQimHF0NTvOuRhg==
X-CSE-MsgGUID: gLj1v33kSMS3MM4qqaKj0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="86987214"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="86987214"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:15:39 -0800
X-CSE-ConnectionGUID: +gOWzhsiRluHaRITfBHtEg==
X-CSE-MsgGUID: FviJVdrdS6+Y5Go3XxuwMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203477383"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 00:15:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfZYr-00000000EQo-3pPC;
	Tue, 13 Jan 2026 08:15:33 +0000
Date: Tue, 13 Jan 2026 16:14:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 d4026a44626490dc4eca4dd2c4d0816338fa179b
Message-ID: <202601131641.xDjgzLaE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: d4026a44626490dc4eca4dd2c4d0816338fa179b  cxl/hdm: Fix potential infinite loop in __cxl_dpa_reserve()

elapsed time: 952m

configs tested: 295
configs skipped: 5

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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260113    clang-22
arc                   randconfig-001-20260113    gcc-8.5.0
arc                   randconfig-002-20260113    clang-22
arc                   randconfig-002-20260113    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    clang-22
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20260113    clang-19
arm                   randconfig-001-20260113    clang-22
arm                   randconfig-002-20260113    clang-22
arm                   randconfig-003-20260113    clang-22
arm                   randconfig-004-20260113    clang-22
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260113    clang-22
arm64                 randconfig-002-20260113    clang-22
arm64                 randconfig-003-20260113    clang-22
arm64                 randconfig-003-20260113    gcc-9.5.0
arm64                 randconfig-004-20260113    clang-22
arm64                 randconfig-004-20260113    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260113    clang-22
csky                  randconfig-001-20260113    gcc-15.2.0
csky                  randconfig-002-20260113    clang-22
csky                  randconfig-002-20260113    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260113    clang-22
hexagon               randconfig-002-20260113    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260113    clang-20
i386        buildonly-randconfig-001-20260113    gcc-14
i386        buildonly-randconfig-002-20260113    clang-20
i386        buildonly-randconfig-003-20260113    clang-20
i386        buildonly-randconfig-004-20260113    clang-20
i386        buildonly-randconfig-005-20260113    clang-20
i386        buildonly-randconfig-006-20260113    clang-20
i386        buildonly-randconfig-006-20260113    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260113    clang-20
i386                  randconfig-001-20260113    gcc-14
i386                  randconfig-002-20260113    clang-20
i386                  randconfig-003-20260113    clang-20
i386                  randconfig-004-20260113    clang-20
i386                  randconfig-004-20260113    gcc-14
i386                  randconfig-005-20260113    clang-20
i386                  randconfig-006-20260113    clang-20
i386                  randconfig-007-20260113    clang-20
i386                  randconfig-007-20260113    gcc-14
i386                  randconfig-011-20260113    clang-20
i386                  randconfig-011-20260113    gcc-14
i386                  randconfig-012-20260113    gcc-14
i386                  randconfig-013-20260113    gcc-14
i386                  randconfig-014-20260113    gcc-14
i386                  randconfig-015-20260113    gcc-14
i386                  randconfig-016-20260113    gcc-14
i386                  randconfig-017-20260113    clang-20
i386                  randconfig-017-20260113    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260113    clang-22
loongarch             randconfig-001-20260113    gcc-15.2.0
loongarch             randconfig-002-20260113    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          hp300_defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    clang-22
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-22
mips                           rs90_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260113    clang-22
nios2                 randconfig-001-20260113    gcc-8.5.0
nios2                 randconfig-002-20260113    clang-22
nios2                 randconfig-002-20260113    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260113    clang-19
parisc                randconfig-001-20260113    gcc-13.4.0
parisc                randconfig-002-20260113    clang-19
parisc                randconfig-002-20260113    gcc-14.3.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    clang-22
powerpc                  iss476-smp_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                     mpc512x_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260113    clang-19
powerpc               randconfig-001-20260113    clang-22
powerpc               randconfig-002-20260113    clang-17
powerpc               randconfig-002-20260113    clang-19
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc                        warp_defconfig    clang-22
powerpc64             randconfig-001-20260113    clang-19
powerpc64             randconfig-002-20260113    clang-19
powerpc64             randconfig-002-20260113    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260113    gcc-15.2.0
riscv                 randconfig-001-20260113    gcc-9.5.0
riscv                 randconfig-002-20260113    gcc-15.2.0
riscv                 randconfig-002-20260113    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260113    gcc-15.2.0
s390                  randconfig-001-20260113    gcc-8.5.0
s390                  randconfig-002-20260113    gcc-14.3.0
s390                  randconfig-002-20260113    gcc-15.2.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                               j2_defconfig    clang-22
sh                          landisk_defconfig    gcc-15.2.0
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260113    gcc-15.2.0
sh                    randconfig-002-20260113    gcc-14.3.0
sh                    randconfig-002-20260113    gcc-15.2.0
sh                      rts7751r2d1_defconfig    clang-22
sh                           se7705_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-22
sh                              ul2_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260113    gcc-14.3.0
sparc                 randconfig-001-20260113    gcc-8.5.0
sparc                 randconfig-002-20260113    gcc-14.3.0
sparc                 randconfig-002-20260113    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260113    gcc-14.3.0
sparc64               randconfig-002-20260113    gcc-14.3.0
sparc64               randconfig-002-20260113    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260113    gcc-14
um                    randconfig-001-20260113    gcc-14.3.0
um                    randconfig-002-20260113    clang-22
um                    randconfig-002-20260113    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260113    clang-20
x86_64      buildonly-randconfig-002-20260113    clang-20
x86_64      buildonly-randconfig-003-20260113    clang-20
x86_64      buildonly-randconfig-004-20260113    clang-20
x86_64      buildonly-randconfig-005-20260113    clang-20
x86_64      buildonly-randconfig-006-20260113    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260113    gcc-14
x86_64                randconfig-002-20260113    gcc-14
x86_64                randconfig-003-20260113    clang-20
x86_64                randconfig-003-20260113    gcc-14
x86_64                randconfig-004-20260113    gcc-14
x86_64                randconfig-005-20260113    gcc-14
x86_64                randconfig-006-20260113    gcc-14
x86_64                randconfig-011-20260113    clang-20
x86_64                randconfig-011-20260113    gcc-13
x86_64                randconfig-012-20260113    clang-20
x86_64                randconfig-013-20260113    clang-20
x86_64                randconfig-014-20260113    clang-20
x86_64                randconfig-014-20260113    gcc-13
x86_64                randconfig-015-20260113    clang-20
x86_64                randconfig-015-20260113    gcc-14
x86_64                randconfig-016-20260113    clang-20
x86_64                randconfig-071-20260113    clang-20
x86_64                randconfig-071-20260113    gcc-13
x86_64                randconfig-072-20260113    clang-20
x86_64                randconfig-072-20260113    gcc-14
x86_64                randconfig-073-20260113    clang-20
x86_64                randconfig-073-20260113    gcc-13
x86_64                randconfig-074-20260113    clang-20
x86_64                randconfig-075-20260113    clang-20
x86_64                randconfig-076-20260113    clang-20
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
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260113    gcc-14.3.0
xtensa                randconfig-001-20260113    gcc-9.5.0
xtensa                randconfig-002-20260113    gcc-14.3.0
xtensa                randconfig-002-20260113    gcc-15.2.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
