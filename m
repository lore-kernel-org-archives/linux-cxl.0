Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF015C6
	for <linux-cxl@vger.kernel.org>; Sun, 14 Jan 2024 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyKfK1oV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705192498; x=1736728498;
  h=date:from:to:cc:subject:message-id;
  bh=qWhhp2kRRChezHXqEomVtQlfp3/d5+UuEkMSJ+VEm1E=;
  b=DyKfK1oV4/oUhhzoxN++DD+Zo4M9Ew+lp0BJohQiBQ8muTiq6HquE9G5
   xZ+UPJHRkBL1Ezx2p8BUg9PnMtD239yWkE+mgKk7NmEjluDCRBUhejpPw
   27mNnbhyTMoGZ0jZBZMTFHDQBSa+AnZltDsC6JSKZOrvMfHzQZXfMqNrT
   r4Dl9qgk9WZyeoAvkMgAis03gaGpMKJwqR6KH8UUV0nXusEzfZAqz935K
   vl8RcW/brTShMjmEUNIlN1qygX3Ieqs/b8+qG+wp+ZKA/z4zANmuQVT2v
   Xumalx5ynXgV043uEUjpLthRxmcQpjELhwg6nEJbjjgmNhENdYUp6cK80
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="18021898"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="18021898"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 16:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="776372729"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="776372729"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2024 16:34:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOoSj-000B3W-0E;
	Sun, 14 Jan 2024 00:34:53 +0000
Date: Sun, 14 Jan 2024 08:34:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5
Message-ID: <202401140814.piFmKuxR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5  cxl/core: use sysfs_emit() for attr's _show()

elapsed time: 1482m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240113   gcc  
arc                   randconfig-002-20240113   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20240113   gcc  
arm                   randconfig-002-20240113   gcc  
arm                   randconfig-003-20240113   gcc  
arm                   randconfig-004-20240113   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240113   gcc  
arm64                 randconfig-002-20240113   gcc  
arm64                 randconfig-003-20240113   gcc  
arm64                 randconfig-004-20240113   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240113   gcc  
csky                  randconfig-002-20240113   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240113   clang
hexagon               randconfig-002-20240113   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240113   gcc  
i386         buildonly-randconfig-002-20240113   gcc  
i386         buildonly-randconfig-003-20240113   gcc  
i386         buildonly-randconfig-004-20240113   gcc  
i386         buildonly-randconfig-005-20240113   gcc  
i386         buildonly-randconfig-006-20240113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240113   gcc  
i386                  randconfig-002-20240113   gcc  
i386                  randconfig-003-20240113   gcc  
i386                  randconfig-004-20240113   gcc  
i386                  randconfig-005-20240113   gcc  
i386                  randconfig-006-20240113   gcc  
i386                  randconfig-011-20240113   clang
i386                  randconfig-012-20240113   clang
i386                  randconfig-013-20240113   clang
i386                  randconfig-014-20240113   clang
i386                  randconfig-015-20240113   clang
i386                  randconfig-016-20240113   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240113   gcc  
loongarch             randconfig-002-20240113   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240113   gcc  
nios2                 randconfig-002-20240113   gcc  
openrisc                         alldefconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240113   gcc  
parisc                randconfig-002-20240113   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20240113   gcc  
powerpc               randconfig-002-20240113   gcc  
powerpc               randconfig-003-20240113   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                      walnut_defconfig   clang
powerpc64             randconfig-001-20240113   gcc  
powerpc64             randconfig-002-20240113   gcc  
powerpc64             randconfig-003-20240113   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240113   gcc  
riscv                 randconfig-002-20240113   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240113   clang
s390                  randconfig-002-20240113   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240113   gcc  
sh                    randconfig-002-20240113   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240113   gcc  
sparc64               randconfig-002-20240113   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240113   gcc  
um                    randconfig-002-20240113   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240113   gcc  
x86_64       buildonly-randconfig-002-20240113   gcc  
x86_64       buildonly-randconfig-003-20240113   gcc  
x86_64       buildonly-randconfig-004-20240113   gcc  
x86_64       buildonly-randconfig-005-20240113   gcc  
x86_64       buildonly-randconfig-006-20240113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240113   clang
x86_64                randconfig-002-20240113   clang
x86_64                randconfig-003-20240113   clang
x86_64                randconfig-004-20240113   clang
x86_64                randconfig-005-20240113   clang
x86_64                randconfig-006-20240113   clang
x86_64                randconfig-011-20240113   gcc  
x86_64                randconfig-012-20240113   gcc  
x86_64                randconfig-013-20240113   gcc  
x86_64                randconfig-014-20240113   gcc  
x86_64                randconfig-015-20240113   gcc  
x86_64                randconfig-016-20240113   gcc  
x86_64                randconfig-071-20240113   gcc  
x86_64                randconfig-072-20240113   gcc  
x86_64                randconfig-073-20240113   gcc  
x86_64                randconfig-074-20240113   gcc  
x86_64                randconfig-075-20240113   gcc  
x86_64                randconfig-076-20240113   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240113   gcc  
xtensa                randconfig-002-20240113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
