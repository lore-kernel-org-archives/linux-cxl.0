Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF9134AF
	for <linux-cxl@vger.kernel.org>; Sat, 16 Dec 2023 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn4JLKPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702711426; x=1734247426;
  h=date:from:to:cc:subject:message-id;
  bh=CdnzlN1cDEBNm2nsGtFh42I4vZ4AQvZc2MZIw9oK0ao=;
  b=kn4JLKPBLWWuITBZ+jsytjTFRp27mLM6jgv0vlI1SWp8/W3SLcWh+hn0
   DbSH/7bLNeWdvyZPYBItGPAKonqnOOAwYvyRdBGiPst5958bLsnEZU064
   vncfAnD8PFViYxoCaRqooQj+55r6ZtpdKYIPVTI25fSZP/wTBWwwdH1IS
   3IkO3S1v7lekNtX6yBgN70fO+bG1z6RhmLWtU9idWEQk0DLD0LPJqxQKp
   z3goribXTbwL7xj5PnlNuiSUWec8ZxQfTqM4uUuBWMw2v0xaOPLRPA7Ay
   ihCpTXQcQWKB3vh2MOHdSldu7trrblEX5cuCIyYdgsKRWJBNxXrNc9NA8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375516972"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="375516972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 23:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948214184"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="948214184"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2023 23:23:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEP1R-0001Gu-0u;
	Sat, 16 Dec 2023 07:23:41 +0000
Date: Sat, 16 Dec 2023 15:23:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 ef3d5cf9c59cccb012aa6b93d99f4c6eb5d6648e
Message-ID: <202312161507.gcEVRKcH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: ef3d5cf9c59cccb012aa6b93d99f4c6eb5d6648e  cxl/pmu: Ensure put_device on pmu devices

elapsed time: 1464m

configs tested: 177
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
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20231215   gcc  
arc                   randconfig-002-20231215   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                   randconfig-001-20231215   clang
arm                   randconfig-002-20231215   clang
arm                   randconfig-003-20231215   clang
arm                   randconfig-004-20231215   clang
arm                        spear3xx_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231215   clang
arm64                 randconfig-002-20231215   clang
arm64                 randconfig-003-20231215   clang
arm64                 randconfig-004-20231215   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231215   gcc  
csky                  randconfig-002-20231215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231215   clang
hexagon               randconfig-002-20231215   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231215   clang
i386         buildonly-randconfig-002-20231215   clang
i386         buildonly-randconfig-003-20231215   clang
i386         buildonly-randconfig-004-20231215   clang
i386         buildonly-randconfig-005-20231215   clang
i386         buildonly-randconfig-006-20231215   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231215   clang
i386                  randconfig-002-20231215   clang
i386                  randconfig-003-20231215   clang
i386                  randconfig-004-20231215   clang
i386                  randconfig-005-20231215   clang
i386                  randconfig-006-20231215   clang
i386                  randconfig-011-20231215   gcc  
i386                  randconfig-012-20231215   gcc  
i386                  randconfig-013-20231215   gcc  
i386                  randconfig-014-20231215   gcc  
i386                  randconfig-015-20231215   gcc  
i386                  randconfig-016-20231215   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231215   gcc  
loongarch             randconfig-002-20231215   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231215   gcc  
nios2                 randconfig-002-20231215   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231215   gcc  
parisc                randconfig-002-20231215   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc               randconfig-001-20231215   clang
powerpc               randconfig-002-20231215   clang
powerpc               randconfig-003-20231215   clang
powerpc                      tqm8xx_defconfig   gcc  
powerpc64             randconfig-001-20231215   clang
powerpc64             randconfig-002-20231215   clang
powerpc64             randconfig-003-20231215   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231215   clang
riscv                 randconfig-002-20231215   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231215   gcc  
s390                  randconfig-002-20231215   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231215   gcc  
sh                    randconfig-002-20231215   gcc  
sh                          rsk7201_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231215   gcc  
sparc64               randconfig-002-20231215   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231215   clang
um                    randconfig-002-20231215   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231215   clang
x86_64       buildonly-randconfig-002-20231215   clang
x86_64       buildonly-randconfig-003-20231215   clang
x86_64       buildonly-randconfig-004-20231215   clang
x86_64       buildonly-randconfig-005-20231215   clang
x86_64       buildonly-randconfig-006-20231215   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231215   gcc  
x86_64                randconfig-002-20231215   gcc  
x86_64                randconfig-003-20231215   gcc  
x86_64                randconfig-004-20231215   gcc  
x86_64                randconfig-005-20231215   gcc  
x86_64                randconfig-006-20231215   gcc  
x86_64                randconfig-011-20231215   clang
x86_64                randconfig-012-20231215   clang
x86_64                randconfig-013-20231215   clang
x86_64                randconfig-014-20231215   clang
x86_64                randconfig-015-20231215   clang
x86_64                randconfig-016-20231215   clang
x86_64                randconfig-071-20231215   clang
x86_64                randconfig-072-20231215   clang
x86_64                randconfig-073-20231215   clang
x86_64                randconfig-074-20231215   clang
x86_64                randconfig-075-20231215   clang
x86_64                randconfig-076-20231215   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231215   gcc  
xtensa                randconfig-002-20231215   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
