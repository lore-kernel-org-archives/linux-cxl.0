Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EC85623
	for <linux-cxl@vger.kernel.org>; Thu,  2 May 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655446; cv=none; b=AOH68CP8mTH+gV8TmCQ00/43qMVz6Ze2yDtdISEDvO7fo4bjrZoV8gqqT/oDcdw6lCpyyVhpg3iBa1OQhHJRnB8nRknCXvBbrfE1ZeMBfsqTJwrsr4siw3oedmVffzRf2mtSp7OH7/NSLrV5PJ9g+nyFBHjHZbvLjJcehKsXKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655446; c=relaxed/simple;
	bh=i0AKuvXYyzS5KmZ7j2HTll2198m5W+n1Os7qXO+Rc2A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gyalVv2pJHk5Ba0H4U/dQVlbmsbiDkWMhD0oQLfCv0ehYX65KLzBtYKFWl2KEs7rkDWNgoVImCaJo5VWeO/pjBytGgDWTSyDBzn+c0tMmsi/mVzaKQAmwbV1A3fShUCsbHT+hG/MZfLcbFqwrhpwpFPWf5k2BRVA9dSGDvdrk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D333Xef2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D333Xef2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714655444; x=1746191444;
  h=date:from:to:cc:subject:message-id;
  bh=i0AKuvXYyzS5KmZ7j2HTll2198m5W+n1Os7qXO+Rc2A=;
  b=D333Xef2T2L7XJHZuZ74+5XFJxEZGdnjcgrBSWJp2wmwRCJpfDyhaBKt
   OjjF1tsngpaB4NMtWRXGFtF1z2MKXHEGnqgly4JcecsEdugGt9gN7bAFe
   38QcTm+RMk+a8z3uRp5KFLsxBJyoUCH6fEIXpr+tOfhmRZ0xcMTBc+TfS
   ObDKyy0P85qiGKSDZX4ICKY/acuZgd8B2us/yIZJyFzOWDrkvldAzkUp9
   JZFAgbNtp/lEWDjxkqc9XzHSvqtrY0YOc9VwbP/F+9FzVwqotSJW5rsz4
   NYGSjRh36YnEr4/F/6u4oVc98YPDWywSi75E0ebSaTI1mMPjmVLCfa7v7
   w==;
X-CSE-ConnectionGUID: zwM0c4woSWGtkcgO3H6Zug==
X-CSE-MsgGUID: hYxCx2ggQpO6FtVjJOZnpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10550827"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10550827"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 06:10:43 -0700
X-CSE-ConnectionGUID: vdFjgPmqReOayNZLUHynKw==
X-CSE-MsgGUID: RMoYtCrjSlyUPIl9L25F6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31782195"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 May 2024 06:10:42 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2WCt-000Ahi-1E;
	Thu, 02 May 2024 13:10:39 +0000
Date: Thu, 02 May 2024 21:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 eedb1dd62a7e7471cef18de55d3794cb64adb818
Message-ID: <202405022150.zZCRhNsu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: eedb1dd62a7e7471cef18de55d3794cb64adb818  cxl/cper: Fix non-ACPI-APEI-GHES build

elapsed time: 971m

configs tested: 176
configs skipped: 5

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
arc                   randconfig-001-20240502   gcc  
arc                   randconfig-002-20240502   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240502   gcc  
arm                   randconfig-002-20240502   gcc  
arm                   randconfig-003-20240502   gcc  
arm                   randconfig-004-20240502   gcc  
arm                             rpc_defconfig   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240502   gcc  
arm64                 randconfig-002-20240502   clang
arm64                 randconfig-003-20240502   clang
arm64                 randconfig-004-20240502   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240502   gcc  
csky                  randconfig-002-20240502   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240502   clang
hexagon               randconfig-002-20240502   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240502   gcc  
i386         buildonly-randconfig-002-20240502   gcc  
i386         buildonly-randconfig-003-20240502   clang
i386         buildonly-randconfig-004-20240502   gcc  
i386         buildonly-randconfig-005-20240502   clang
i386         buildonly-randconfig-006-20240502   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240502   gcc  
i386                  randconfig-002-20240502   clang
i386                  randconfig-003-20240502   clang
i386                  randconfig-004-20240502   gcc  
i386                  randconfig-005-20240502   gcc  
i386                  randconfig-006-20240502   clang
i386                  randconfig-011-20240502   gcc  
i386                  randconfig-012-20240502   clang
i386                  randconfig-013-20240502   clang
i386                  randconfig-014-20240502   gcc  
i386                  randconfig-015-20240502   clang
i386                  randconfig-016-20240502   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240502   gcc  
loongarch             randconfig-002-20240502   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240502   gcc  
nios2                 randconfig-002-20240502   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240502   gcc  
parisc                randconfig-002-20240502   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240502   clang
powerpc               randconfig-002-20240502   clang
powerpc               randconfig-003-20240502   clang
powerpc                    socrates_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240502   gcc  
powerpc64             randconfig-002-20240502   clang
powerpc64             randconfig-003-20240502   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240502   clang
riscv                 randconfig-002-20240502   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240502   gcc  
s390                  randconfig-002-20240502   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240502   gcc  
sh                    randconfig-002-20240502   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240502   gcc  
sparc64               randconfig-002-20240502   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240502   clang
um                    randconfig-002-20240502   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240502   gcc  
x86_64       buildonly-randconfig-002-20240502   gcc  
x86_64       buildonly-randconfig-003-20240502   clang
x86_64       buildonly-randconfig-004-20240502   gcc  
x86_64       buildonly-randconfig-005-20240502   gcc  
x86_64       buildonly-randconfig-006-20240502   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240502   gcc  
x86_64                randconfig-002-20240502   clang
x86_64                randconfig-003-20240502   clang
x86_64                randconfig-004-20240502   gcc  
x86_64                randconfig-005-20240502   clang
x86_64                randconfig-006-20240502   clang
x86_64                randconfig-011-20240502   clang
x86_64                randconfig-012-20240502   clang
x86_64                randconfig-013-20240502   gcc  
x86_64                randconfig-014-20240502   gcc  
x86_64                randconfig-015-20240502   gcc  
x86_64                randconfig-016-20240502   clang
x86_64                randconfig-071-20240502   gcc  
x86_64                randconfig-072-20240502   gcc  
x86_64                randconfig-073-20240502   gcc  
x86_64                randconfig-074-20240502   clang
x86_64                randconfig-075-20240502   clang
x86_64                randconfig-076-20240502   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240502   gcc  
xtensa                randconfig-002-20240502   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
