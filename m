Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EE1EB29
	for <linux-cxl@vger.kernel.org>; Mon, 25 Dec 2023 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIrxZhLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703546171; x=1735082171;
  h=date:from:to:cc:subject:message-id;
  bh=69xcu11+qGR9/JCptI3pH3CcFVzDcO7Fjw7L4FokM50=;
  b=BIrxZhLy915Zz01QtrCETxEHBDPaLGcX81HYF1JUc+qpY5DwFqeHyFwK
   TW1uNPSFz2acVh1KncFwyhmkpzWb3p9zQgJntpwQhDYwF0emEdMtmXcwu
   er/8idOb+z5ijdy/xpU7XxaC1QSGN7QATVQRIdrsgaFAE+aPh6ZKT100w
   ByuIGxG1E4n/LgcVeQ40cTuXf9jlC+Yxk4iy1foDXraeuPqYXys9rNBRY
   GFwt1tRxNgaP++JG9n8LYsADfBo2830Cnj7aOAWlladnXh1bUiXluoVkE
   HAmWlCeyndXnmGW4CI6qje1TiA6JImZwFIlmjx/VeycQ14ykTsIE2RAIX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427472532"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427472532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 15:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="812113806"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="812113806"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2023 15:16:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHuB4-000Dlr-0V;
	Mon, 25 Dec 2023 23:16:06 +0000
Date: Tue, 26 Dec 2023 07:15:17 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 49bf4e8a58ecc939bc2a0d33fe0ca1529f94ff59
Message-ID: <202312260712.16o2oAX9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 49bf4e8a58ecc939bc2a0d33fe0ca1529f94ff59  ACPI: NUMA: Fix overlap when extending memblks to fill CFMWS

elapsed time: 1458m

configs tested: 178
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231225   gcc  
arc                   randconfig-002-20231225   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20231225   clang
arm                   randconfig-002-20231225   clang
arm                   randconfig-003-20231225   clang
arm                   randconfig-004-20231225   clang
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231225   clang
arm64                 randconfig-002-20231225   clang
arm64                 randconfig-003-20231225   clang
arm64                 randconfig-004-20231225   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231225   gcc  
csky                  randconfig-002-20231225   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231225   clang
hexagon               randconfig-002-20231225   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231225   clang
i386         buildonly-randconfig-002-20231225   clang
i386         buildonly-randconfig-003-20231225   clang
i386         buildonly-randconfig-004-20231225   clang
i386         buildonly-randconfig-005-20231225   clang
i386         buildonly-randconfig-006-20231225   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231225   clang
i386                  randconfig-002-20231225   clang
i386                  randconfig-003-20231225   clang
i386                  randconfig-004-20231225   clang
i386                  randconfig-005-20231225   clang
i386                  randconfig-006-20231225   clang
i386                  randconfig-011-20231225   gcc  
i386                  randconfig-012-20231225   gcc  
i386                  randconfig-013-20231225   gcc  
i386                  randconfig-014-20231225   gcc  
i386                  randconfig-015-20231225   gcc  
i386                  randconfig-016-20231225   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231225   gcc  
loongarch             randconfig-002-20231225   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231225   gcc  
nios2                 randconfig-002-20231225   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231225   gcc  
parisc                randconfig-002-20231225   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc               randconfig-001-20231225   clang
powerpc               randconfig-002-20231225   clang
powerpc               randconfig-003-20231225   clang
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231225   clang
powerpc64             randconfig-002-20231225   clang
powerpc64             randconfig-003-20231225   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231225   clang
riscv                 randconfig-002-20231225   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231225   gcc  
s390                  randconfig-002-20231225   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231225   gcc  
sh                    randconfig-002-20231225   gcc  
sh                           se7722_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231225   gcc  
sparc64               randconfig-002-20231225   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231225   clang
um                    randconfig-002-20231225   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231225   clang
x86_64       buildonly-randconfig-002-20231225   clang
x86_64       buildonly-randconfig-003-20231225   clang
x86_64       buildonly-randconfig-004-20231225   clang
x86_64       buildonly-randconfig-005-20231225   clang
x86_64       buildonly-randconfig-006-20231225   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231225   gcc  
x86_64                randconfig-002-20231225   gcc  
x86_64                randconfig-003-20231225   gcc  
x86_64                randconfig-004-20231225   gcc  
x86_64                randconfig-005-20231225   gcc  
x86_64                randconfig-006-20231225   gcc  
x86_64                randconfig-011-20231225   clang
x86_64                randconfig-012-20231225   clang
x86_64                randconfig-013-20231225   clang
x86_64                randconfig-014-20231225   clang
x86_64                randconfig-015-20231225   clang
x86_64                randconfig-016-20231225   clang
x86_64                randconfig-071-20231225   clang
x86_64                randconfig-072-20231225   clang
x86_64                randconfig-073-20231225   clang
x86_64                randconfig-074-20231225   clang
x86_64                randconfig-075-20231225   clang
x86_64                randconfig-076-20231225   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231225   gcc  
xtensa                randconfig-002-20231225   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
