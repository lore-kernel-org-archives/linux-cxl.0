Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD428DF37
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553803; cv=none; b=fRTzVV3FhyR2UoU/HIRBBsrE4oahBC45WxrIN8bpJl+9PeUlDVmUpaMoQl0mBMd8iBVg+4+zzNKyCdil+iIn+F30/kyjMY8aiofygd1jIsxqoRYFm/V9MJCr+dTaI/PA+vsZnTrKzB5jfX8ivzyvf3nqt8BJikeCaTuXKAJPOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553803; c=relaxed/simple;
	bh=D8xhqclbLqEn6NtU5DJ62yRDI6qQqDEpct1Dm802Mt8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X7iQlxgksKso9BTfvBzO8HU7EY0W+5VRjy8X3hytQMlh/JpG2UN4egtxB4xp/tVRC9nyDbeanJsFoEUkgjEuxeQKptMfJAIOh6H49B7nwDXEcdYVk2yiyMDW0AT9CK/Dk9v4uubDm4RPw03//0mFH0TTUb6UFCMuKANusngTCX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiwXIGr6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiwXIGr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749553801; x=1781089801;
  h=date:from:to:cc:subject:message-id;
  bh=D8xhqclbLqEn6NtU5DJ62yRDI6qQqDEpct1Dm802Mt8=;
  b=hiwXIGr6o2vEkS/tRusolkqk6492iedbqe7GtrtNLR00FIuIMK4OFoMA
   W0LeKfyTxsHrBiOk3mjuN2qiuYVtUtiixSIxZbXOTzMs5gU2A6jqaSnSr
   b03Z2dE+JNYKLpNrrSNN0ghCcPkJte78Js2GaA0CMz8Dg7+GYZ7HxObIU
   W7H/i1BepFnQb76Cm0OOhLqMoruAqQg6CgNlC/jjFCFBgB2frVi2lgbCr
   8/MbiyWMijVOmZl3PwCijeX+/zpCIUlVucp9DVjWYGaDgNPAtl8Wnl3O4
   qy6E6tbAj4rh58WWQ0ob71PXAMnNmemCS5lmPbBFM3iPPrjoeOJWMm+KQ
   Q==;
X-CSE-ConnectionGUID: 0cMb140RSc6RycKjuWdeSQ==
X-CSE-MsgGUID: qD/5u6RbR3aql96/RwY5qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51568930"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51568930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:10:01 -0700
X-CSE-ConnectionGUID: c+U4P5OaSjOGiyzFhnbSFA==
X-CSE-MsgGUID: 0KVXNjOwS1mPIzRd7tCdrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146683415"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jun 2025 04:09:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOwrd-00087N-0j;
	Tue, 10 Jun 2025 11:09:57 +0000
Date: Tue, 10 Jun 2025 19:09:33 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 87b42c114cdda76c8ad3002f2096699ad5146cb3
Message-ID: <202506101921.VzynhJPw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 87b42c114cdda76c8ad3002f2096699ad5146cb3  cxl: fix return value in cxlctl_validate_set_features()

elapsed time: 1065m

configs tested: 231
configs skipped: 9

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
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-14.3.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-21
arm                          exynos_defconfig    clang-21
arm                         lpc32xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250610    clang-19
arm                   randconfig-001-20250610    gcc-12.4.0
arm                   randconfig-002-20250610    gcc-12.4.0
arm                   randconfig-002-20250610    gcc-8.5.0
arm                   randconfig-003-20250610    clang-21
arm                   randconfig-003-20250610    gcc-12.4.0
arm                   randconfig-004-20250610    clang-16
arm                   randconfig-004-20250610    gcc-12.4.0
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250610    clang-21
arm64                 randconfig-001-20250610    gcc-12.4.0
arm64                 randconfig-002-20250610    gcc-11.5.0
arm64                 randconfig-002-20250610    gcc-12.4.0
arm64                 randconfig-003-20250610    clang-21
arm64                 randconfig-003-20250610    gcc-12.4.0
arm64                 randconfig-004-20250610    clang-18
arm64                 randconfig-004-20250610    gcc-12.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250610    gcc-12.4.0
csky                  randconfig-001-20250610    gcc-15.1.0
csky                  randconfig-002-20250610    gcc-14.3.0
csky                  randconfig-002-20250610    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250610    clang-21
hexagon               randconfig-001-20250610    gcc-15.1.0
hexagon               randconfig-002-20250610    clang-21
hexagon               randconfig-002-20250610    gcc-15.1.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250610    clang-20
i386        buildonly-randconfig-002-20250610    clang-20
i386        buildonly-randconfig-003-20250610    clang-20
i386        buildonly-randconfig-004-20250610    clang-20
i386        buildonly-randconfig-004-20250610    gcc-12
i386        buildonly-randconfig-005-20250610    clang-20
i386        buildonly-randconfig-006-20250610    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250610    clang-20
i386                  randconfig-002-20250610    clang-20
i386                  randconfig-003-20250610    clang-20
i386                  randconfig-004-20250610    clang-20
i386                  randconfig-005-20250610    clang-20
i386                  randconfig-006-20250610    clang-20
i386                  randconfig-007-20250610    clang-20
i386                  randconfig-011-20250610    clang-20
i386                  randconfig-012-20250610    clang-20
i386                  randconfig-013-20250610    clang-20
i386                  randconfig-014-20250610    clang-20
i386                  randconfig-015-20250610    clang-20
i386                  randconfig-016-20250610    clang-20
i386                  randconfig-017-20250610    clang-20
loongarch                        alldefconfig    gcc-15.1.0
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20250610    gcc-15.1.0
loongarch             randconfig-002-20250610    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250610    gcc-15.1.0
nios2                 randconfig-001-20250610    gcc-8.5.0
nios2                 randconfig-002-20250610    gcc-13.3.0
nios2                 randconfig-002-20250610    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250610    gcc-10.5.0
parisc                randconfig-001-20250610    gcc-15.1.0
parisc                randconfig-002-20250610    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250610    gcc-10.5.0
powerpc               randconfig-001-20250610    gcc-15.1.0
powerpc               randconfig-002-20250610    gcc-15.1.0
powerpc               randconfig-002-20250610    gcc-8.5.0
powerpc               randconfig-003-20250610    clang-21
powerpc               randconfig-003-20250610    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250610    clang-21
powerpc64             randconfig-001-20250610    gcc-15.1.0
powerpc64             randconfig-002-20250610    clang-21
powerpc64             randconfig-002-20250610    gcc-15.1.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-15.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250610    gcc-14.3.0
riscv                 randconfig-001-20250610    gcc-9.3.0
riscv                 randconfig-002-20250610    clang-16
riscv                 randconfig-002-20250610    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250610    gcc-8.5.0
s390                  randconfig-001-20250610    gcc-9.3.0
s390                  randconfig-002-20250610    gcc-14.3.0
s390                  randconfig-002-20250610    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250610    gcc-9.3.0
sh                    randconfig-002-20250610    gcc-15.1.0
sh                    randconfig-002-20250610    gcc-9.3.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-9.3.0
sparc                 randconfig-002-20250610    gcc-12.4.0
sparc                 randconfig-002-20250610    gcc-9.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250610    gcc-8.5.0
sparc64               randconfig-001-20250610    gcc-9.3.0
sparc64               randconfig-002-20250610    gcc-8.5.0
sparc64               randconfig-002-20250610    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250610    gcc-11
um                    randconfig-001-20250610    gcc-9.3.0
um                    randconfig-002-20250610    gcc-12
um                    randconfig-002-20250610    gcc-9.3.0
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250610    clang-20
x86_64      buildonly-randconfig-001-20250610    gcc-12
x86_64      buildonly-randconfig-002-20250610    gcc-12
x86_64      buildonly-randconfig-003-20250610    clang-20
x86_64      buildonly-randconfig-003-20250610    gcc-12
x86_64      buildonly-randconfig-004-20250610    clang-20
x86_64      buildonly-randconfig-004-20250610    gcc-12
x86_64      buildonly-randconfig-005-20250610    gcc-12
x86_64      buildonly-randconfig-006-20250610    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250610    clang-20
x86_64                randconfig-072-20250610    clang-20
x86_64                randconfig-073-20250610    clang-20
x86_64                randconfig-074-20250610    clang-20
x86_64                randconfig-075-20250610    clang-20
x86_64                randconfig-076-20250610    clang-20
x86_64                randconfig-077-20250610    clang-20
x86_64                randconfig-078-20250610    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250610    gcc-11.5.0
xtensa                randconfig-001-20250610    gcc-9.3.0
xtensa                randconfig-002-20250610    gcc-12.4.0
xtensa                randconfig-002-20250610    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
