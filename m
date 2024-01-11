Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E609D502
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jan 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6SmTbcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704957825; x=1736493825;
  h=date:from:to:cc:subject:message-id;
  bh=ecPtINsGcPwCZgSO8NnhrCVgKhxgT5B1p7uf5vDQJno=;
  b=K6SmTbczG6QMJ9zRXGvPkziOkENIFG4iTkdRZQ1YmBN4mjnRVRDBeBhi
   PSmE4/899KDaUc+ydOV1C+mLbAueLzJWy22frN6GHqAFx8X4CDxcHn4/R
   wkitvI0GBtdRGvMXEzLPqAcFJvzsj8Q58DbBv5gY6L62ovXqTSM0xq09M
   s0fm2CwmEBdgWccnFNSOq7c2cGMwhR6EeJVb+qNYwusFi0lQI2afU2NOF
   xhTekxpZ5Ve7BLj/s9t02n5WPORpDeRJw5awyn8UetCBsw2YaWCGJdTiY
   b4TvXQjXLKhTaQRWzH+ireSF39NNf/DAhmzozipPH2usQ6dUqIoB+YrRN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="398458864"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="398458864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="955653072"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="955653072"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2024 23:23:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNpPg-0007x0-16;
	Thu, 11 Jan 2024 07:23:40 +0000
Date: Thu, 11 Jan 2024 15:23:26 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 3601311593eb44d34f142b993cb6f38f9a7863b3
Message-ID: <202401111524.ZOi1Q4VY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 3601311593eb44d34f142b993cb6f38f9a7863b3  Merge branch 'for-6.8/cxl-cper' into for-6.8/cxl

elapsed time: 1459m

configs tested: 177
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240110   gcc  
arc                   randconfig-002-20240110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                   randconfig-001-20240110   clang
arm                   randconfig-002-20240110   clang
arm                   randconfig-003-20240110   clang
arm                   randconfig-004-20240110   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240110   clang
arm64                 randconfig-002-20240110   clang
arm64                 randconfig-003-20240110   clang
arm64                 randconfig-004-20240110   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240110   gcc  
csky                  randconfig-002-20240110   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240110   clang
hexagon               randconfig-002-20240110   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240110   clang
i386         buildonly-randconfig-002-20240110   clang
i386         buildonly-randconfig-003-20240110   clang
i386         buildonly-randconfig-004-20240110   clang
i386         buildonly-randconfig-005-20240110   clang
i386         buildonly-randconfig-006-20240110   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240110   clang
i386                  randconfig-002-20240110   clang
i386                  randconfig-003-20240110   clang
i386                  randconfig-004-20240110   clang
i386                  randconfig-005-20240110   clang
i386                  randconfig-006-20240110   clang
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-016-20240110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240110   gcc  
loongarch             randconfig-002-20240110   gcc  
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
mips                      maltaaprp_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240110   gcc  
nios2                 randconfig-002-20240110   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240110   gcc  
parisc                randconfig-002-20240110   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc               randconfig-001-20240110   clang
powerpc               randconfig-002-20240110   clang
powerpc               randconfig-003-20240110   clang
powerpc64             randconfig-001-20240110   clang
powerpc64             randconfig-002-20240110   clang
powerpc64             randconfig-003-20240110   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240110   clang
riscv                 randconfig-002-20240110   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240110   gcc  
s390                  randconfig-002-20240110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240110   gcc  
sh                    randconfig-002-20240110   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240110   gcc  
sparc64               randconfig-002-20240110   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240110   clang
um                    randconfig-002-20240110   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240110   clang
x86_64       buildonly-randconfig-002-20240110   clang
x86_64       buildonly-randconfig-003-20240110   clang
x86_64       buildonly-randconfig-004-20240110   clang
x86_64       buildonly-randconfig-005-20240110   clang
x86_64       buildonly-randconfig-006-20240110   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240110   gcc  
x86_64                randconfig-002-20240110   gcc  
x86_64                randconfig-003-20240110   gcc  
x86_64                randconfig-004-20240110   gcc  
x86_64                randconfig-005-20240110   gcc  
x86_64                randconfig-006-20240110   gcc  
x86_64                randconfig-011-20240110   clang
x86_64                randconfig-012-20240110   clang
x86_64                randconfig-013-20240110   clang
x86_64                randconfig-014-20240110   clang
x86_64                randconfig-015-20240110   clang
x86_64                randconfig-016-20240110   clang
x86_64                randconfig-071-20240110   clang
x86_64                randconfig-072-20240110   clang
x86_64                randconfig-073-20240110   clang
x86_64                randconfig-074-20240110   clang
x86_64                randconfig-075-20240110   clang
x86_64                randconfig-076-20240110   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240110   gcc  
xtensa                randconfig-002-20240110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
