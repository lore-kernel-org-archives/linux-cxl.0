Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4A211497
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321655; cv=none; b=C7j8zlAu5b0FzHR3gVKATSD+4K4ZGGnEvJ/bFMHE//mX8Z6dYPnW9urc1tJkzOKusi5idFJaYj1iTQIQi+MTxHg9vcOsxtL1iXfYNQF5FPP0Rdk//v3UqKVBqf74Z8k4qw9eck2iH5Eq4T9DjOH4n36tex9cWbKK+hO1N3aELPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321655; c=relaxed/simple;
	bh=0kNfTmHuCgmmrrF7fgb8A9noDzbSJTSrxwT0quRm/uA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U77OCyfqmxaVRRGklz4DtLRibFQgzLuTo3ZIriq0nqxmZ+jWPsPP6D8JrIn8Fa6DdGphLn3TA5KCWHA1yr5X8Pipk33ZPWAVQVVMGWtq1gyRunMWYW6WhKc4uq0tbHHdkPdbTWQ95dC4Ls17PegeOuHPcAo2fW6tXTfEID8tnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFlfPG5/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFlfPG5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742321654; x=1773857654;
  h=date:from:to:cc:subject:message-id;
  bh=0kNfTmHuCgmmrrF7fgb8A9noDzbSJTSrxwT0quRm/uA=;
  b=YFlfPG5/Xn0INZJd8HFHWih6m3ml/dMoW4b2Q5dOct/WbH/eWBd7eaZ7
   fAALDzY0koo2aEC1UNIqm1gx3Zp1O+j5/U0Dfzt4tVlphHDtl8woj1X4W
   8pvJmQHx70vh1d058ydB83a+GzdouvGXD+IHU3GKkbU+6k3A/QhHPqdzj
   TjYx7eNM6/z3A7EDwEj/4cXM157dR4HJ9yz+jwLN5uzGbzQ0zCGxeuZkS
   BtNNCVnkr8IHGaKvdMplto6LOgyO8z5llaIAbtnML2glj6l0/N8cRpZri
   i9HhfEHiUFr+3T2TgeU9sQVjCqqnCTuvM2WtM9K14KjR4aOfK2z3XYMOs
   g==;
X-CSE-ConnectionGUID: wgENhn3PSWeP5KpRCtZNsQ==
X-CSE-MsgGUID: /huJvozpTouX3MP1MIdp4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43216505"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43216505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:14:13 -0700
X-CSE-ConnectionGUID: l7cHFRYSTSWM1RwtcG8Geg==
X-CSE-MsgGUID: 3c+XvVF1SneCyP72rclrZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153193517"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Mar 2025 11:14:12 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tubS4-000E3K-2l;
	Tue, 18 Mar 2025 18:14:08 +0000
Date: Wed, 19 Mar 2025 02:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 3b5d43245f0a56390baaa670e1b6d898772266b3
Message-ID: <202503190224.WYkmCCZT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 3b5d43245f0a56390baaa670e1b6d898772266b3  Merge branch 'for-6.15/features' into cxl-for-next

elapsed time: 1472m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250318    gcc-13.2.0
arc                   randconfig-002-20250318    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-004-20250318    clang-21
arm                        spear3xx_defconfig    clang-17
arm                        spear6xx_defconfig    clang-15
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-003-20250318    gcc-14.2.0
arm64                 randconfig-004-20250318    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-002-20250318    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-006-20250318    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-14.2.0
nios2                 randconfig-002-20250318    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250318    gcc-14.2.0
parisc                randconfig-002-20250318    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-003-20250318    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-002-20250318    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-002-20250318    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-002-20250318    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250318    gcc-14.2.0
sparc64               randconfig-002-20250318    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-002-20250318    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-002-20250318    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
