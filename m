Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFF7497
	for <linux-cxl@vger.kernel.org>; Sat,  4 Nov 2023 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFHy3rfo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B146184
	for <linux-cxl@vger.kernel.org>; Sat,  4 Nov 2023 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699097089; x=1730633089;
  h=date:from:to:cc:subject:message-id;
  bh=KN74sHfimBo5cuBl2icgut+9nUJJfLW9b++rJzkacpg=;
  b=ZFHy3rfoP8LesZSv7vg9X1614o5BqLOQPr2xMv4TWVtijrvnRsvT1JmO
   daB50ErQPjbdc+nERttz7KbWNJEG+FBtnoP2BDrrWAEdKNQAYBUsww4iL
   KiRuURfLPPnXRuCdWziJsy9VHI3T2Ijtq7XnKrpwFne6D18KMpZ+1y/Y3
   ONLBLO/jPWigyX3zmV870zkLZDex990isPJya86Q87AMT0PrmW0JiIXG0
   Qi/zmoUj8qq0l80X+qxaR+FMZKrYZqh0f+G8Iy28iI6dfvwMDwu2ZyH4u
   PAhHRLgaKkEm+iS2uMfPh22PVZdndkyn27ON+petV9a8KO6NZd7e3qKg7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="392968999"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="392968999"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1093321618"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="1093321618"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2023 04:24:46 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzElg-00042z-1x;
	Sat, 04 Nov 2023 11:24:44 +0000
Date: Sat, 04 Nov 2023 19:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD REGRESSION
 5d09c63f11f083707b60c8ea0bb420651c47740f
Message-ID: <202311041936.oUnk2Xp1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 5d09c63f11f083707b60c8ea0bb420651c47740f  cxl/hdm: Remove broken error path

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- powerpc-maple_defconfig
|   `-- arch-powerpc-mm-book3s64-hash_native.c:error:variable-index-set-but-not-used
|-- powerpc-pasemi_defconfig
|   `-- arch-powerpc-platforms-pasemi-pci.c:error:variable-res-set-but-not-used
|-- powerpc64-randconfig-001-20231101
|   |-- arch-powerpc-platforms-pasemi-pci.c:error:variable-res-set-but-not-used
|   |-- arch-powerpc-platforms-ps3-device-init.c:error:variable-result-set-but-not-used
|   `-- arch-powerpc-platforms-ps3-gelic_udbg.c:error:alignment-of-struct-debug_block-is-less-than
|-- powerpc64-randconfig-002-20231101
|   |-- arch-powerpc-platforms-ps3-device-init.c:error:variable-result-set-but-not-used
|   `-- arch-powerpc-platforms-ps3-gelic_udbg.c:error:alignment-of-struct-debug_block-is-less-than
`-- powerpc64-randconfig-003-20231101
    |-- arch-powerpc-platforms-pasemi-pci.c:error:variable-res-set-but-not-used
    |-- arch-powerpc-platforms-ps3-device-init.c:error:variable-result-set-but-not-used
    `-- arch-powerpc-platforms-ps3-gelic_udbg.c:error:alignment-of-struct-debug_block-is-less-than

elapsed time: 4928m

configs tested: 188
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231101   gcc  
arc                   randconfig-002-20231101   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231101   gcc  
arm                   randconfig-002-20231101   gcc  
arm                   randconfig-003-20231101   gcc  
arm                   randconfig-004-20231101   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231101   gcc  
arm64                 randconfig-002-20231101   gcc  
arm64                 randconfig-003-20231101   gcc  
arm64                 randconfig-004-20231101   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231101   gcc  
csky                  randconfig-002-20231101   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231101   gcc  
i386         buildonly-randconfig-002-20231101   gcc  
i386         buildonly-randconfig-003-20231101   gcc  
i386         buildonly-randconfig-004-20231101   gcc  
i386         buildonly-randconfig-005-20231101   gcc  
i386         buildonly-randconfig-006-20231101   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231101   gcc  
i386                  randconfig-002-20231101   gcc  
i386                  randconfig-003-20231101   gcc  
i386                  randconfig-004-20231101   gcc  
i386                  randconfig-005-20231101   gcc  
i386                  randconfig-006-20231101   gcc  
i386                  randconfig-011-20231101   gcc  
i386                  randconfig-012-20231101   gcc  
i386                  randconfig-013-20231101   gcc  
i386                  randconfig-014-20231101   gcc  
i386                  randconfig-015-20231101   gcc  
i386                  randconfig-016-20231101   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231101   gcc  
loongarch             randconfig-002-20231101   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                          malta_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231101   gcc  
nios2                 randconfig-002-20231101   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231101   gcc  
parisc                randconfig-002-20231101   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231101   gcc  
powerpc               randconfig-002-20231101   gcc  
powerpc               randconfig-003-20231101   gcc  
powerpc                     tqm8540_defconfig   clang
powerpc64             randconfig-001-20231101   gcc  
powerpc64             randconfig-002-20231101   gcc  
powerpc64             randconfig-003-20231101   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231101   gcc  
riscv                 randconfig-002-20231101   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231101   gcc  
s390                  randconfig-002-20231101   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                    randconfig-001-20231101   gcc  
sh                    randconfig-002-20231101   gcc  
sh                          rsk7264_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231101   gcc  
sparc                 randconfig-002-20231101   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231101   gcc  
sparc64               randconfig-002-20231101   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231101   gcc  
um                    randconfig-002-20231101   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231101   gcc  
x86_64       buildonly-randconfig-002-20231101   gcc  
x86_64       buildonly-randconfig-003-20231101   gcc  
x86_64       buildonly-randconfig-004-20231101   gcc  
x86_64       buildonly-randconfig-005-20231101   gcc  
x86_64       buildonly-randconfig-006-20231101   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231101   gcc  
x86_64                randconfig-002-20231101   gcc  
x86_64                randconfig-003-20231101   gcc  
x86_64                randconfig-004-20231101   gcc  
x86_64                randconfig-005-20231101   gcc  
x86_64                randconfig-006-20231101   gcc  
x86_64                randconfig-011-20231101   gcc  
x86_64                randconfig-012-20231101   gcc  
x86_64                randconfig-013-20231101   gcc  
x86_64                randconfig-014-20231101   gcc  
x86_64                randconfig-015-20231101   gcc  
x86_64                randconfig-016-20231101   gcc  
x86_64                randconfig-071-20231101   gcc  
x86_64                randconfig-072-20231101   gcc  
x86_64                randconfig-073-20231101   gcc  
x86_64                randconfig-074-20231101   gcc  
x86_64                randconfig-075-20231101   gcc  
x86_64                randconfig-076-20231101   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231101   gcc  
xtensa                randconfig-002-20231101   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
