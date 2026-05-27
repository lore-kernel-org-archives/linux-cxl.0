Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCC1A683F
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878034; cv=none; b=GWsFNpdaypxxmYtZjffmiah/1CihpCl5NlWPJJssmXeRUoqVD69zhlR+IIrKgcer5bEgyjs2s8Jgbz1gWqxaf1krpHDvRv9vDFwkcbKUYYJE5uZp6ZG5gGw8WDspvPU1yYJO7wkKio+rcxBYkbZ0nxEaaYAZIxM3uIIXXH932dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878034; c=relaxed/simple;
	bh=P6gWl2jUiH5fYlhv41oECJBMDsAsy+gqbYsdsr1tYnU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rfOoE5IjmeZv4crPtf9XsV714PmmoEnE5rYTwfRBPuAhh+HYyeg1HhTuUnMZUeBkT2nCpIUJDVrgmYrk9yNycHU7qfXEQM5LSB2x2cK1VoSE17l4wbN3HSnUcaP9f+foHp5WZYqHUB+rOJoRnj5YNzV7Oz4Ar0Pk86PHC+Odark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqHsoOl4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqHsoOl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779878032; x=1811414032;
  h=date:from:to:cc:subject:message-id;
  bh=P6gWl2jUiH5fYlhv41oECJBMDsAsy+gqbYsdsr1tYnU=;
  b=lqHsoOl4aomf1NaOTXcSoPvLH3pk0lvIAScAMZqifW3ymJFDUr3Uu3NX
   E349Pe8XV9sDv2I9EESKJ683naRcFe38Vdh8+FdgEJAh0Nb768tAAeWAt
   NrQDlcS5z78bbKGc1MP2tu42AYY977fmcYNMz6VrIk9jsnie+jXBJaCS+
   QoXU88foqwvp7hXnhd0saLWV+CZvcs6EbhZpMdWnQAt37Xao+XbigLiPx
   qFErXwtA0NjxOdTnKb41hX2pSOdlsN9qP5QX3Jn3j9ocXvankJbEJuCBN
   fNyWSlSzhDlIjb3BaJ8/OBhSkBMchqz5I3JYfOnCaQiiE1FcI6TR4H9D9
   A==;
X-CSE-ConnectionGUID: DRalX/33SS2iziFflOUulg==
X-CSE-MsgGUID: XYePj7l7Q+GV/cbYSPIRnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="92174862"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92174862"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 03:33:52 -0700
X-CSE-ConnectionGUID: CMBwrH/fSpy6WEWecw4quw==
X-CSE-MsgGUID: LvSg03I0TjiwUAYaXkvW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="239599589"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 May 2026 03:33:49 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSBa7-000000003oo-1olI;
	Wed, 27 May 2026 10:33:47 +0000
Date: Wed, 27 May 2026 18:33:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 d90f236f8b9e354848bd226f581db27755ab901d
Message-ID: <202605271814.r2Y6gSpy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: d90f236f8b9e354848bd226f581db27755ab901d  cxl/test: Update mock dev array before calling platform_device_add()

elapsed time: 765m

configs tested: 156
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260527    gcc-9.5.0
arc                   randconfig-002-20260527    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260527    clang-23
arm                   randconfig-002-20260527    clang-23
arm                   randconfig-003-20260527    gcc-10.5.0
arm                   randconfig-004-20260527    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260527    gcc-8.5.0
arm64                 randconfig-002-20260527    gcc-8.5.0
arm64                 randconfig-003-20260527    clang-23
arm64                 randconfig-004-20260527    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260527    gcc-15.2.0
csky                  randconfig-002-20260527    gcc-14.3.0
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260527    clang-23
hexagon               randconfig-002-20260527    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260527    clang-20
i386        buildonly-randconfig-002-20260527    gcc-14
i386        buildonly-randconfig-003-20260527    clang-20
i386        buildonly-randconfig-004-20260527    gcc-14
i386        buildonly-randconfig-005-20260527    gcc-14
i386        buildonly-randconfig-006-20260527    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260527    clang-20
i386                  randconfig-002-20260527    gcc-14
i386                  randconfig-003-20260527    gcc-14
i386                  randconfig-004-20260527    clang-20
i386                  randconfig-005-20260527    clang-20
i386                  randconfig-006-20260527    gcc-12
i386                  randconfig-007-20260527    clang-20
i386                  randconfig-011-20260527    gcc-14
i386                  randconfig-016-20260527    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260527    clang-19
loongarch             randconfig-002-20260527    gcc-13.4.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260527    gcc-11.5.0
nios2                 randconfig-002-20260527    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260527    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260527    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260527    gcc-8.5.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260527    clang-18
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260527    gcc-8.5.0
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260527    clang-20
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260527    gcc-9.5.0
riscv                 randconfig-002-20260527    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260527    gcc-12.5.0
s390                  randconfig-002-20260527    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260527    gcc-14.3.0
sh                    randconfig-002-20260527    gcc-11.5.0
sh                           se7206_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260527    gcc-14.3.0
sparc                 randconfig-002-20260527    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260527    clang-20
sparc64               randconfig-002-20260527    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260527    gcc-14
um                    randconfig-002-20260527    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260527    clang-20
x86_64      buildonly-randconfig-002-20260527    gcc-14
x86_64      buildonly-randconfig-003-20260527    gcc-14
x86_64      buildonly-randconfig-004-20260527    gcc-14
x86_64      buildonly-randconfig-005-20260527    gcc-14
x86_64      buildonly-randconfig-006-20260527    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260527    gcc-14
x86_64                randconfig-002-20260527    clang-20
x86_64                randconfig-003-20260527    clang-20
x86_64                randconfig-004-20260527    clang-20
x86_64                randconfig-005-20260527    clang-20
x86_64                randconfig-006-20260527    gcc-14
x86_64                randconfig-011-20260527    gcc-14
x86_64                randconfig-012-20260527    gcc-14
x86_64                randconfig-013-20260527    gcc-14
x86_64                randconfig-015-20260527    gcc-14
x86_64                randconfig-071-20260527    gcc-14
x86_64                randconfig-072-20260527    clang-20
x86_64                randconfig-073-20260527    clang-20
x86_64                randconfig-074-20260527    gcc-14
x86_64                randconfig-075-20260527    clang-20
x86_64                randconfig-076-20260527    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260527    gcc-8.5.0
xtensa                randconfig-002-20260527    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
