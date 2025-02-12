Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B61EE7B9
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356903; cv=none; b=E0HBnygiEoyCPmWCkwqh8nqHbRWkX7q77bhjDmdNJFDxGuPoLzfjOwI+GRsJrtJex3jA4hUSBxt2TIBQgEwAuM+NDEdj+JDpgG6L8hgP8mZoYn/CN9IzkTkZu64LT2h56TDrxH1KDuRGEochkN/1s2LnOd/ofzZX+KkXRwGBF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356903; c=relaxed/simple;
	bh=V5Cwz6DD0OH3vN+FTxZ5vVn3lsJQ+qa4m91wqBRkZvo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QBHorwEY3Ck2XsQ3dvff+c5tJ6qe3s7C9b+1E6opXN9tIffo60W8dLekznoFlXggXAwn08o1HrII/3jjujsyp+9lSftkv5wzqny3SOlwqAs25vJn5mLIr9I7egbkgDF8cWP0Hn8+S9PBLetKkIVDcyM4oiHXsnr413mN0LBPCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrO+nXCo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrO+nXCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739356902; x=1770892902;
  h=date:from:to:cc:subject:message-id;
  bh=V5Cwz6DD0OH3vN+FTxZ5vVn3lsJQ+qa4m91wqBRkZvo=;
  b=WrO+nXCom+d3k8mDIm/i0/GeGFZXd+t7kMjGu4OxUe/gFHOb/jaXNi4C
   aqPLvWkTeh37kDAh8FoUY3o2R95a/tqtZwTgrQl04FQD74VjdxjUWqUdi
   6suw0+qb3YaODq3zR8eFEnyPJLq1uYyT8m2Iotc7Am3EIs/+/Xb58UIv0
   pfEFbLGzg4DKZzLVwxnpYw0KjQ1qzwIMTVV5ioEvXMWAsacv6bQrY+Pi9
   MsIyNhkwkYZlsyvLmG+0aexwXrp+kG5shw/Jg6c5FKjwHoC9sHiRXNZcY
   tq03ACT50+GeHMbDJD/ytMUsVcjuJlo6gZ/PlrsVTb3X3Hecgo85rrqVZ
   g==;
X-CSE-ConnectionGUID: LI9kPTUJRQS5UIlr4f9e1g==
X-CSE-MsgGUID: jV/X6tbtTMWyaJyic70hHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39709568"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39709568"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:41:41 -0800
X-CSE-ConnectionGUID: kCOCbEdMS6q0hkIo3hlj8A==
X-CSE-MsgGUID: bhjt4jd0RGS1VEOzFGCH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113282055"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Feb 2025 02:41:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiABV-0015Vz-0f;
	Wed, 12 Feb 2025 10:41:37 +0000
Date: Wed, 12 Feb 2025 18:41:29 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 8760c1c0bf7eee63a56b5f9edb42d93737a6a378
Message-ID: <202502121813.46u9aHhK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 8760c1c0bf7eee63a56b5f9edb42d93737a6a378  cxl/cdat: Remove redundant gp_port initialization

elapsed time: 1015m

configs tested: 138
configs skipped: 7

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
arc                   randconfig-001-20250212    gcc-13.2.0
arc                   randconfig-002-20250212    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                         lpc32xx_defconfig    clang-21
arm                          pxa3xx_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250212    clang-18
arm                   randconfig-002-20250212    clang-16
arm                   randconfig-003-20250212    clang-21
arm                   randconfig-004-20250212    clang-16
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250212    gcc-14.2.0
arm64                 randconfig-002-20250212    gcc-14.2.0
arm64                 randconfig-003-20250212    clang-16
arm64                 randconfig-004-20250212    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250212    gcc-14.2.0
csky                  randconfig-002-20250212    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250212    clang-21
hexagon               randconfig-002-20250212    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250212    clang-19
i386        buildonly-randconfig-002-20250212    gcc-12
i386        buildonly-randconfig-003-20250212    gcc-12
i386        buildonly-randconfig-004-20250212    gcc-12
i386        buildonly-randconfig-005-20250212    gcc-12
i386        buildonly-randconfig-006-20250212    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250212    gcc-14.2.0
loongarch             randconfig-002-20250212    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250212    gcc-14.2.0
nios2                 randconfig-002-20250212    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250212    gcc-14.2.0
parisc                randconfig-002-20250212    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                      pcm030_defconfig    clang-17
powerpc               randconfig-001-20250212    gcc-14.2.0
powerpc               randconfig-002-20250212    clang-16
powerpc               randconfig-003-20250212    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250212    clang-16
powerpc64             randconfig-002-20250212    gcc-14.2.0
powerpc64             randconfig-003-20250212    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250212    clang-21
riscv                 randconfig-002-20250212    clang-18
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250212    clang-15
s390                  randconfig-002-20250212    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250212    gcc-14.2.0
sh                    randconfig-002-20250212    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250212    gcc-14.2.0
sparc                 randconfig-002-20250212    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250212    gcc-14.2.0
sparc64               randconfig-002-20250212    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250212    clang-16
um                    randconfig-002-20250212    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250212    gcc-11
x86_64      buildonly-randconfig-002-20250212    clang-19
x86_64      buildonly-randconfig-003-20250212    clang-19
x86_64      buildonly-randconfig-004-20250212    clang-19
x86_64      buildonly-randconfig-005-20250212    gcc-12
x86_64      buildonly-randconfig-006-20250212    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250212    gcc-14.2.0
xtensa                randconfig-002-20250212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
