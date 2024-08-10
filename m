Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C612BB10
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723288136; cv=none; b=H8B5ATYwBta7vyVdFLwaUxK/qwuIfrflE0DYpM14IbYafc/qGGhQU9BNB+svV4n7pGSfaFybIqC9eqN4Cl8uJ66AvU7FNf32p68jxuIyQKaKS7JutCvujycsL3bb4Jo2QqG6fwmKKCW7/5hbCoYNRHPgs30rK5oSDRTXG2hjCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723288136; c=relaxed/simple;
	bh=OzYvGO5FYLf93zScfVyPnCkN6doy7ZfIDHwKqPVTRtg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nFq625LI4GTeMAZXVyjYLhpt/3NVFI9M+FWf3cQDKiW+N9x4SBbuRRaCNavkFliTkfe6g0YKPP/Fs9LIuJ7ykaqxPD+t/oGDmbz4SLtyky3D2A6tA1r3p9Jd8cFFCKIPCVCJTaA2PLXJf/VItFTF9WEPoiATmQGPfiZhpu9FAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks0ttaoH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks0ttaoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723288135; x=1754824135;
  h=date:from:to:cc:subject:message-id;
  bh=OzYvGO5FYLf93zScfVyPnCkN6doy7ZfIDHwKqPVTRtg=;
  b=ks0ttaoHgBhY3yhWMUUZY9MsY2TDAPl6YrpxptNkI/BMh4Iy94NTvf3K
   b4DkBg5TzltW2LpEFdyaOdYIGvgm+7iJlzql31IOoMFdTny1og+KXWxjA
   mQFuMD8px11RH7+7pZHsiAyXVtgC3fkmGQeHduxQeKvAS+ggaAg+g2DYd
   3dY1mpO53jc9Ec5VERSlkxXtHFuMMLsIWrgJsiy+MNP85bHVJ/V6A3Gt4
   GJ0kDbe2NP6hXf6oEPuuJFIYHuaNW2ZtI10x98sUPfgNXZEZv9zsocf5H
   eLmOiZypL1YkGN16oNy5NDmdztO/RakTXcvyWyCX5ozCfnv3GMNgfXX2L
   g==;
X-CSE-ConnectionGUID: BDYaGi4RRNGn+Q2kB26c2g==
X-CSE-MsgGUID: q8HJiU8DT2aJK1hp89oERg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21433601"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21433601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 04:08:53 -0700
X-CSE-ConnectionGUID: CO0cRk8CSsytGWNn80e0VQ==
X-CSE-MsgGUID: /TYGoY73RDyZgpIMtHBwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57464131"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 10 Aug 2024 04:08:49 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scjxn-0009sF-2w;
	Sat, 10 Aug 2024 11:08:47 +0000
Date: Sat, 10 Aug 2024 19:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 2c402bd2e85b44dc00ef85b5c0e217de684b5372
Message-ID: <202408101907.4DCRGEcS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 2c402bd2e85b44dc00ef85b5c0e217de684b5372  cxl/test: Skip cxl_setup_parent_dport() for emulated dports

elapsed time: 731m

configs tested: 207
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240810   gcc-13.2.0
arc                   randconfig-002-20240810   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   clang-14
arm                      footbridge_defconfig   clang-20
arm                         lpc18xx_defconfig   clang-20
arm                            mps2_defconfig   gcc-13.2.0
arm                   randconfig-001-20240810   gcc-14.1.0
arm                   randconfig-002-20240810   clang-20
arm                   randconfig-003-20240810   gcc-14.1.0
arm                   randconfig-004-20240810   gcc-14.1.0
arm                         s3c6400_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240810   gcc-14.1.0
arm64                 randconfig-002-20240810   clang-20
arm64                 randconfig-003-20240810   clang-20
arm64                 randconfig-004-20240810   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240810   gcc-14.1.0
csky                  randconfig-002-20240810   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240810   clang-20
hexagon               randconfig-002-20240810   clang-14
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-006-20240810   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-016-20240810   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240810   gcc-14.1.0
loongarch             randconfig-002-20240810   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-13.2.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                           ci20_defconfig   clang-20
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240810   gcc-14.1.0
nios2                 randconfig-002-20240810   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240810   gcc-14.1.0
parisc                randconfig-002-20240810   gcc-14.1.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                         alldefconfig   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                    amigaone_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   clang-20
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   clang-20
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240810   gcc-14.1.0
powerpc64             randconfig-002-20240810   clang-20
powerpc64             randconfig-003-20240810   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240810   clang-20
riscv                 randconfig-002-20240810   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240810   gcc-14.1.0
s390                  randconfig-002-20240810   clang-15
s390                       zfcpdump_defconfig   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                          lboxre2_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240810   gcc-14.1.0
sh                    randconfig-002-20240810   gcc-14.1.0
sh                           se7206_defconfig   gcc-14.1.0
sh                        sh7757lcr_defconfig   gcc-14.1.0
sh                             shx3_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240810   gcc-14.1.0
sparc64               randconfig-002-20240810   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240810   gcc-12
um                    randconfig-002-20240810   gcc-12
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240810   gcc-12
x86_64       buildonly-randconfig-002-20240810   clang-18
x86_64       buildonly-randconfig-003-20240810   clang-18
x86_64       buildonly-randconfig-004-20240810   clang-18
x86_64       buildonly-randconfig-005-20240810   clang-18
x86_64       buildonly-randconfig-006-20240810   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240810   clang-18
x86_64                randconfig-002-20240810   clang-18
x86_64                randconfig-003-20240810   gcc-12
x86_64                randconfig-004-20240810   clang-18
x86_64                randconfig-005-20240810   clang-18
x86_64                randconfig-006-20240810   gcc-12
x86_64                randconfig-011-20240810   clang-18
x86_64                randconfig-012-20240810   gcc-12
x86_64                randconfig-013-20240810   clang-18
x86_64                randconfig-014-20240810   clang-18
x86_64                randconfig-015-20240810   clang-18
x86_64                randconfig-016-20240810   clang-18
x86_64                randconfig-071-20240810   clang-18
x86_64                randconfig-072-20240810   gcc-12
x86_64                randconfig-073-20240810   clang-18
x86_64                randconfig-074-20240810   clang-18
x86_64                randconfig-075-20240810   gcc-12
x86_64                randconfig-076-20240810   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240810   gcc-14.1.0
xtensa                randconfig-002-20240810   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
