Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130291A680F
	for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030607; cv=none; b=AfcWmcJA7GjN5zvvF9844syFj8FodshIIukmFPi3n/ZwB5jsZGtJtLuEM3MAtcZaHP10fsJXYej3NyTUmxRwzjjTAy5N87Upexb6UlJv0G9VOgR4rqN8uG2bGLpaMTfywcQkElOSf2g0sr/GV0ReMNflNd+ITiNnUuOfhdAQAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030607; c=relaxed/simple;
	bh=h+Fp8TJfQhQIyBWgP+UpbJcF0jB2T8WJQqNPmbH7mS0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nmSrCI2SVubasf4ZGfSKLGLtVvVjooal2+QHr1CTMttgA4nSPodIIWm1OvFWlxA8VffR9WPFDJPjKS2fsMWjPTDV8HhS6Yi1psB5JhtGPj9ErZAlrtPqLr3kVD+lDYDWNUNx2Kg7ymyeer3dZS8LgX74GxNIzjZJgTLE0ez98Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U84F3HFX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U84F3HFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780030603; x=1811566603;
  h=date:from:to:cc:subject:message-id;
  bh=h+Fp8TJfQhQIyBWgP+UpbJcF0jB2T8WJQqNPmbH7mS0=;
  b=U84F3HFXL0jrlJ/e0Cc7T7wRudOutEWmv0G4SHeQYtQbSuI6fLOZ2hc3
   QBkSdVbXDtoAjYR7ye+GiBOMLjpO53H7fbTfQti/eRbjWk75v2EzRQhqG
   Z3piQ9uwZlRVpDJD4Ke85LifF+hHWZnRPM+Q/o4ocevYc0ymu3BX+M3+b
   33G+HuCmOd7WpEq/A3vBqH/h3z5zUOHMOO1s9TIBWHGZ9hk5vwMNbU/G3
   wGKGzo2U4UKnqRrcPCS9e5QmbCtgNni6xRL7wJFCcOf/seiDvSxRKhsWy
   I7ssVUfkjXykLquH8Xqjahvp4cpvZnRh8aZ1q0P/KQVc0+W1G9h2bhAB1
   Q==;
X-CSE-ConnectionGUID: MhsYU34XRHKX3XARpsl4rQ==
X-CSE-MsgGUID: os+Fdz6lQbq9EAuljCXPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106330304"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="106330304"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 21:56:42 -0700
X-CSE-ConnectionGUID: m3jkEr17Q86AkTgVHYkZtA==
X-CSE-MsgGUID: cFz4flZ+QuO5OuWalWBB0Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 May 2026 21:56:41 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSpGw-000000006mk-0kgX;
	Fri, 29 May 2026 04:56:38 +0000
Date: Fri, 29 May 2026 12:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 8850852b25f7884d9804f8de5591edb3881bd674
Message-ID: <202605291237.17w5eRS3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 8850852b25f7884d9804f8de5591edb3881bd674  cxl/test: Enforce PMD alignment for volatile mock regions

elapsed time: 739m

configs tested: 185
configs skipped: 4

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
arc                   randconfig-001-20260529    gcc-14.3.0
arc                   randconfig-002-20260529    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260529    gcc-14.3.0
arm                   randconfig-002-20260529    gcc-8.5.0
arm                   randconfig-003-20260529    gcc-13.4.0
arm                   randconfig-004-20260529    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260529    gcc-8.5.0
arm64                 randconfig-002-20260529    clang-23
arm64                 randconfig-003-20260529    clang-23
arm64                 randconfig-004-20260529    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260529    gcc-15.2.0
csky                  randconfig-002-20260529    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260529    clang-23
hexagon               randconfig-001-20260529    gcc-8.5.0
hexagon               randconfig-002-20260529    clang-23
hexagon               randconfig-002-20260529    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260529    gcc-12
i386        buildonly-randconfig-002-20260529    clang-20
i386        buildonly-randconfig-003-20260529    gcc-12
i386        buildonly-randconfig-004-20260529    gcc-14
i386        buildonly-randconfig-005-20260529    gcc-14
i386        buildonly-randconfig-006-20260529    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260529    gcc-14
i386                  randconfig-002-20260529    gcc-12
i386                  randconfig-003-20260529    clang-20
i386                  randconfig-004-20260529    clang-20
i386                  randconfig-005-20260529    gcc-14
i386                  randconfig-006-20260529    clang-20
i386                  randconfig-007-20260529    gcc-12
i386                  randconfig-011-20260529    clang-20
i386                  randconfig-012-20260529    clang-20
i386                  randconfig-013-20260529    clang-20
i386                  randconfig-014-20260529    clang-20
i386                  randconfig-015-20260529    gcc-14
i386                  randconfig-016-20260529    clang-20
i386                  randconfig-017-20260529    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260529    gcc-15.2.0
loongarch             randconfig-001-20260529    gcc-8.5.0
loongarch             randconfig-002-20260529    gcc-15.2.0
loongarch             randconfig-002-20260529    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                          multi_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260529    gcc-8.5.0
nios2                 randconfig-002-20260529    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260529    clang-19
parisc                randconfig-001-20260529    gcc-8.5.0
parisc                randconfig-002-20260529    clang-19
parisc                randconfig-002-20260529    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260529    clang-19
powerpc               randconfig-001-20260529    gcc-12.5.0
powerpc               randconfig-002-20260529    clang-19
powerpc64             randconfig-001-20260529    clang-19
powerpc64             randconfig-001-20260529    gcc-15.2.0
powerpc64             randconfig-002-20260529    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260529    gcc-8.5.0
riscv                 randconfig-002-20260529    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260529    gcc-8.5.0
s390                  randconfig-002-20260529    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260529    gcc-15.2.0
sh                    randconfig-002-20260529    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260529    gcc-8.5.0
sparc                 randconfig-002-20260529    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260529    gcc-11.5.0
sparc64               randconfig-002-20260529    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260529    gcc-14
um                    randconfig-002-20260529    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260529    gcc-14
x86_64      buildonly-randconfig-002-20260529    gcc-14
x86_64      buildonly-randconfig-003-20260529    gcc-14
x86_64      buildonly-randconfig-004-20260529    clang-20
x86_64      buildonly-randconfig-005-20260529    clang-20
x86_64      buildonly-randconfig-006-20260529    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260529    clang-20
x86_64                randconfig-001-20260529    gcc-14
x86_64                randconfig-002-20260529    clang-20
x86_64                randconfig-003-20260529    clang-20
x86_64                randconfig-003-20260529    gcc-14
x86_64                randconfig-004-20260529    clang-20
x86_64                randconfig-005-20260529    clang-20
x86_64                randconfig-006-20260529    clang-20
x86_64                randconfig-011-20260529    gcc-14
x86_64                randconfig-012-20260529    gcc-14
x86_64                randconfig-071-20260529    gcc-14
x86_64                randconfig-072-20260529    clang-20
x86_64                randconfig-073-20260529    clang-20
x86_64                randconfig-074-20260529    gcc-14
x86_64                randconfig-075-20260529    gcc-14
x86_64                randconfig-076-20260529    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260529    gcc-11.5.0
xtensa                randconfig-002-20260529    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
