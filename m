Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D82219ED
	for <linux-cxl@vger.kernel.org>; Mon, 25 Dec 2023 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLs7GBAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703546173; x=1735082173;
  h=date:from:to:cc:subject:message-id;
  bh=Cogn/Q8RZMMo0zpF0+544MkYp6P+IRWrlWP+vzZ+mi4=;
  b=SLs7GBARL3a3n2vqXq5KjAEOUVt5VEdRsNkvmqAo1Gu5fU76n4FdvstD
   dpBkMy7+m6tzJeugGAi910nee5CWBga/EdlNqaRL0hEnWEd0UHz8hGXMp
   rLhW4TgyzR/cTnBN8WeSDpx1GZgCBLBbqOcW7n3hQCshIB2KYCi5mkVe3
   YdshHfwxuxLgG/hkuqFYYTngEMsO7883Zok2gneazMvZ2gg+pfsmcXoLg
   1wqsGgpusTHmYVL5eaptpjdallZ6+jgz5KKUFwtt3X2dGjkXDFw5Tu8B5
   Eupr5aIC0dw4aP8LFuJYjzFL8f75WOAhEbVtoKz4eFEvu3syuC2owCiM9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427472534"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="427472534"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 15:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="812113809"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="812113809"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2023 15:16:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHuB4-000Dly-1p;
	Mon, 25 Dec 2023 23:16:06 +0000
Date: Tue, 26 Dec 2023 07:15:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 b762d2aeb3077207b00594097cdc8767dcf65016
Message-ID: <202312260749.q4RF20It-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: b762d2aeb3077207b00594097cdc8767dcf65016  Merge branch 'for-6.8/cxl-cdat' into for-6.8/cxl

elapsed time: 1459m

configs tested: 250
configs skipped: 2

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
arc                   randconfig-001-20231225   gcc  
arc                   randconfig-001-20231226   gcc  
arc                   randconfig-002-20231225   gcc  
arc                   randconfig-002-20231226   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20231225   clang
arm                   randconfig-001-20231226   gcc  
arm                   randconfig-002-20231225   clang
arm                   randconfig-002-20231226   gcc  
arm                   randconfig-003-20231225   clang
arm                   randconfig-003-20231226   gcc  
arm                   randconfig-004-20231225   clang
arm                   randconfig-004-20231226   gcc  
arm                             rpc_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231225   clang
arm64                 randconfig-001-20231226   gcc  
arm64                 randconfig-002-20231225   clang
arm64                 randconfig-002-20231226   gcc  
arm64                 randconfig-003-20231225   clang
arm64                 randconfig-003-20231226   gcc  
arm64                 randconfig-004-20231225   clang
arm64                 randconfig-004-20231226   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231225   gcc  
csky                  randconfig-001-20231226   gcc  
csky                  randconfig-002-20231225   gcc  
csky                  randconfig-002-20231226   gcc  
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
i386                  randconfig-011-20231226   clang
i386                  randconfig-012-20231225   gcc  
i386                  randconfig-012-20231226   clang
i386                  randconfig-013-20231225   gcc  
i386                  randconfig-013-20231226   clang
i386                  randconfig-014-20231225   gcc  
i386                  randconfig-014-20231226   clang
i386                  randconfig-015-20231225   gcc  
i386                  randconfig-015-20231226   clang
i386                  randconfig-016-20231225   gcc  
i386                  randconfig-016-20231226   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231225   gcc  
loongarch             randconfig-001-20231226   gcc  
loongarch             randconfig-002-20231225   gcc  
loongarch             randconfig-002-20231226   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231225   gcc  
nios2                 randconfig-001-20231226   gcc  
nios2                 randconfig-002-20231225   gcc  
nios2                 randconfig-002-20231226   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231225   gcc  
parisc                randconfig-001-20231226   gcc  
parisc                randconfig-002-20231225   gcc  
parisc                randconfig-002-20231226   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc               randconfig-001-20231225   clang
powerpc               randconfig-001-20231226   gcc  
powerpc               randconfig-002-20231225   clang
powerpc               randconfig-002-20231226   gcc  
powerpc               randconfig-003-20231225   clang
powerpc               randconfig-003-20231226   gcc  
powerpc64             randconfig-001-20231225   clang
powerpc64             randconfig-001-20231226   gcc  
powerpc64             randconfig-002-20231225   clang
powerpc64             randconfig-002-20231226   gcc  
powerpc64             randconfig-003-20231225   clang
powerpc64             randconfig-003-20231226   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231225   clang
riscv                 randconfig-001-20231226   gcc  
riscv                 randconfig-002-20231225   clang
riscv                 randconfig-002-20231226   gcc  
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
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20231225   gcc  
sh                    randconfig-001-20231226   gcc  
sh                    randconfig-002-20231225   gcc  
sh                    randconfig-002-20231226   gcc  
sh                          sdk7786_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231225   gcc  
sparc64               randconfig-001-20231226   gcc  
sparc64               randconfig-002-20231225   gcc  
sparc64               randconfig-002-20231226   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231225   clang
um                    randconfig-001-20231226   gcc  
um                    randconfig-002-20231225   clang
um                    randconfig-002-20231226   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231225   clang
x86_64       buildonly-randconfig-001-20231226   gcc  
x86_64       buildonly-randconfig-002-20231225   clang
x86_64       buildonly-randconfig-002-20231226   gcc  
x86_64       buildonly-randconfig-003-20231225   clang
x86_64       buildonly-randconfig-003-20231226   gcc  
x86_64       buildonly-randconfig-004-20231225   clang
x86_64       buildonly-randconfig-004-20231226   gcc  
x86_64       buildonly-randconfig-005-20231225   clang
x86_64       buildonly-randconfig-005-20231226   gcc  
x86_64       buildonly-randconfig-006-20231225   clang
x86_64       buildonly-randconfig-006-20231226   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231225   gcc  
x86_64                randconfig-002-20231225   gcc  
x86_64                randconfig-003-20231225   gcc  
x86_64                randconfig-004-20231225   gcc  
x86_64                randconfig-005-20231225   gcc  
x86_64                randconfig-006-20231225   gcc  
x86_64                randconfig-011-20231225   clang
x86_64                randconfig-011-20231226   gcc  
x86_64                randconfig-012-20231225   clang
x86_64                randconfig-012-20231226   gcc  
x86_64                randconfig-013-20231225   clang
x86_64                randconfig-013-20231226   gcc  
x86_64                randconfig-014-20231225   clang
x86_64                randconfig-014-20231226   gcc  
x86_64                randconfig-015-20231225   clang
x86_64                randconfig-015-20231226   gcc  
x86_64                randconfig-016-20231225   clang
x86_64                randconfig-016-20231226   gcc  
x86_64                randconfig-071-20231225   clang
x86_64                randconfig-071-20231226   gcc  
x86_64                randconfig-072-20231225   clang
x86_64                randconfig-072-20231226   gcc  
x86_64                randconfig-073-20231225   clang
x86_64                randconfig-073-20231226   gcc  
x86_64                randconfig-074-20231225   clang
x86_64                randconfig-074-20231226   gcc  
x86_64                randconfig-075-20231225   clang
x86_64                randconfig-075-20231226   gcc  
x86_64                randconfig-076-20231225   clang
x86_64                randconfig-076-20231226   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231225   gcc  
xtensa                randconfig-001-20231226   gcc  
xtensa                randconfig-002-20231225   gcc  
xtensa                randconfig-002-20231226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
