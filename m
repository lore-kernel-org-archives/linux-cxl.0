Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E17537E8
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559286; cv=none; b=OkAygfpMUDpvEI9tgc+zd5vYsd9uG4ilOhdcXX1BrSSS2Nqr9ySUKxHUtHEeZ02Nlsvavk/uiLKpszDEDB003yW6brprVr8koWydAue3jb/c3+f7tSatpcOzR+r7IpZxOlA0aBJ77uCGwyc+B5mAxQeiWvLnY7gOtYOvsm94DWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559286; c=relaxed/simple;
	bh=xdaVbRtolqsxksBQMd+qO8Y6eQoZ0DhOvEand6mNomI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kovzP2Jf1EwiJJpsvKsmea4h0lwdpu8TnXO/GbOXpjYb6a7TWmgcsiNhPNtk80wmIpouixjlIXehk4yIFZF8lzBaAb2yqCx2l8ihHjJPtW26+Z3PpRB0U7+ScHnCi60hYBn7/DTURMkQFYXFnSmS9U5ZR4ZdIUhvtYKn0NpAbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2UOpVzK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2UOpVzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714559284; x=1746095284;
  h=date:from:to:cc:subject:message-id;
  bh=xdaVbRtolqsxksBQMd+qO8Y6eQoZ0DhOvEand6mNomI=;
  b=E2UOpVzK5dPSysdbzVymgYM0FSpKlITyfaWsFwviDdBbNiuBy118oOw4
   CQFtqX46NmiDSZGk8ttrsKc+ZVlVglZ9lhEWk+NYFT7DwTzOWei6eoCnL
   dZVLZYVXa8nCbo1IIJhgmBdjBC9DMdhKeQYeJXQug2AMkzrBr2FzOzU3d
   rBO4ySBM9fKJtQduK/ZF6ngeMd6TF5eBM0kkyjzyDa2ASkzcZMO8osDT4
   1Gx43L0vxdfJsHfAf691q2fMOTrw+8upDgH980c+DLFQFGwWW0Ut6NiKi
   bDWbVjuIi+Fc6wkuHbDA/nlBT4iAImHhfV1uoWTQ1vqDiFa91595vqWK3
   A==;
X-CSE-ConnectionGUID: my4KPPiiSoKZtONKevd5Uw==
X-CSE-MsgGUID: sySrTTanQeqY67d+r4eVYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21436935"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="21436935"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 03:28:04 -0700
X-CSE-ConnectionGUID: vHKeO3r6TBSaObFZrXPCrg==
X-CSE-MsgGUID: 0/p39sVuTSyIt360zyXf4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="26602942"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 May 2024 03:28:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s27Bv-0009Qb-0o;
	Wed, 01 May 2024 10:27:59 +0000
Date: Wed, 01 May 2024 18:27:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 1c987cf22d6b65ade46145c03eef13f0e3e81d83
Message-ID: <202405011812.ejznCmWM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 1c987cf22d6b65ade46145c03eef13f0e3e81d83  cxl/region: Fix cxlr_pmem leaks

elapsed time: 754m

configs tested: 171
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240501   gcc  
arc                   randconfig-002-20240501   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240501   gcc  
arm                   randconfig-002-20240501   gcc  
arm                   randconfig-003-20240501   clang
arm                   randconfig-004-20240501   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240501   gcc  
arm64                 randconfig-002-20240501   gcc  
arm64                 randconfig-003-20240501   clang
arm64                 randconfig-004-20240501   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240501   gcc  
csky                  randconfig-002-20240501   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240501   clang
hexagon               randconfig-002-20240501   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240501   clang
i386         buildonly-randconfig-002-20240501   gcc  
i386         buildonly-randconfig-003-20240501   clang
i386         buildonly-randconfig-004-20240501   gcc  
i386         buildonly-randconfig-005-20240501   gcc  
i386         buildonly-randconfig-006-20240501   clang
i386                                defconfig   clang
i386                  randconfig-001-20240501   gcc  
i386                  randconfig-002-20240501   clang
i386                  randconfig-003-20240501   gcc  
i386                  randconfig-004-20240501   gcc  
i386                  randconfig-005-20240501   clang
i386                  randconfig-006-20240501   clang
i386                  randconfig-011-20240501   gcc  
i386                  randconfig-012-20240501   gcc  
i386                  randconfig-013-20240501   gcc  
i386                  randconfig-014-20240501   gcc  
i386                  randconfig-015-20240501   gcc  
i386                  randconfig-016-20240501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240501   gcc  
loongarch             randconfig-002-20240501   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                         db1xxx_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240501   gcc  
nios2                 randconfig-002-20240501   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240501   gcc  
parisc                randconfig-002-20240501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240501   clang
powerpc               randconfig-002-20240501   clang
powerpc               randconfig-003-20240501   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240501   clang
powerpc64             randconfig-002-20240501   clang
powerpc64             randconfig-003-20240501   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240501   clang
riscv                 randconfig-002-20240501   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240501   gcc  
s390                  randconfig-002-20240501   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240501   gcc  
sh                    randconfig-002-20240501   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240501   gcc  
sparc64               randconfig-002-20240501   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240501   gcc  
um                    randconfig-002-20240501   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240501   gcc  
x86_64       buildonly-randconfig-002-20240501   clang
x86_64       buildonly-randconfig-003-20240501   gcc  
x86_64       buildonly-randconfig-004-20240501   gcc  
x86_64       buildonly-randconfig-005-20240501   clang
x86_64       buildonly-randconfig-006-20240501   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240501   gcc  
x86_64                randconfig-002-20240501   gcc  
x86_64                randconfig-003-20240501   gcc  
x86_64                randconfig-004-20240501   clang
x86_64                randconfig-005-20240501   clang
x86_64                randconfig-006-20240501   gcc  
x86_64                randconfig-011-20240501   gcc  
x86_64                randconfig-012-20240501   clang
x86_64                randconfig-013-20240501   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240501   gcc  
xtensa                randconfig-002-20240501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
