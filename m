Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805321FF5E
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161872; cv=none; b=Ebsl+0nM5Vhh/C9qtiZaz3asjW3B1N9E4wbj+JR/crRyeKL3VFXEIkKG4+6hFowV91IlG6kczMIjzbg0MznrCFZcwJjsXAklgFFCl4jEUv20ESj+Y7Bi5aLhKb+II8Fd8i8pSWkKfMS/XE3Gwx+vEdJI9iK2l/EfXCWNDODkfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161872; c=relaxed/simple;
	bh=moGiQCO1fTHWOFXccIuBWregNxm44PhEFhx5dvZ34mc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KWOo9qReLVlp1AOldmVgT4xurbBfj8jGnFiWSNIxD5Kn6XQFch3bAY7SNEQsrZRbFwoUexSs0unHtw2x8nbg3AsLfi44hvysRzp1sYmox08boky1Eo0rcWstTc5vPNYI1XTy8ymx5exRNBAeFsfqkCWbU1aihQZRC3CYUelNpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duux1dtI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duux1dtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750161868; x=1781697868;
  h=date:from:to:cc:subject:message-id;
  bh=moGiQCO1fTHWOFXccIuBWregNxm44PhEFhx5dvZ34mc=;
  b=duux1dtI17Syo8Zr/tBImkWcKaJTJKbRBPQp7bRWbpj+DO7nHCFNZlJb
   biTgzuV84pfp8Q2xeJXSZCZJByny+WgyJmSDECK/YTTGrgXMtLDJV/57t
   OK+vYdEBw/WjMvlpmZL0oy7CwViBCC9+j0zCii2CORG6F5sr5/mJUlOzk
   ZZXypsBKbDvCPIKZfyCkkvxt3+mIvgDZCZiWpSzfLpdoOyM6NlQZlaSEF
   26C1N7EvXs+HcPKDiYcsIjnErJVRU4w1AFrrhyeqSmP60XLxz15UVG+Zt
   FBJ17xfoO3IoLb5TEpUBUzHRpqvhEB80ybkhJfIgskmXH9OxPYGuAJjP/
   w==;
X-CSE-ConnectionGUID: u+9i7wbkS8WL1xTUvCP9CA==
X-CSE-MsgGUID: 6ziWEcRdTnOJlu5gkRJpnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63368781"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63368781"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 05:04:27 -0700
X-CSE-ConnectionGUID: FUL18T/nTqiSCz7a6+jYGg==
X-CSE-MsgGUID: iuMKeFk/SY+jvSMhQKsvgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="148747021"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Jun 2025 05:04:25 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRV38-000Fwj-1q;
	Tue, 17 Jun 2025 12:04:22 +0000
Date: Tue, 17 Jun 2025 20:03:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 a021802c18c4c30dff3db9bd355cacb68521f1aa
Message-ID: <202506172045.rbiBCF4J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: a021802c18c4c30dff3db9bd355cacb68521f1aa  cxl: docs/devices Fix typos and clarify wording in device-types.rst

elapsed time: 739m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250617    gcc-11.5.0
arc                   randconfig-002-20250617    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                      footbridge_defconfig    clang-17
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250617    gcc-8.5.0
arm                   randconfig-002-20250617    clang-21
arm                   randconfig-003-20250617    clang-21
arm                   randconfig-004-20250617    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250617    gcc-11.5.0
arm64                 randconfig-002-20250617    clang-21
arm64                 randconfig-003-20250617    gcc-8.5.0
arm64                 randconfig-004-20250617    gcc-12.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250617    gcc-13.3.0
csky                  randconfig-002-20250617    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250617    clang-21
hexagon               randconfig-002-20250617    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250617    gcc-12
i386        buildonly-randconfig-002-20250617    clang-20
i386        buildonly-randconfig-003-20250617    gcc-12
i386        buildonly-randconfig-004-20250617    gcc-12
i386        buildonly-randconfig-005-20250617    gcc-12
i386        buildonly-randconfig-006-20250617    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250617    gcc-15.1.0
loongarch             randconfig-002-20250617    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250617    gcc-10.5.0
nios2                 randconfig-002-20250617    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250617    gcc-8.5.0
parisc                randconfig-002-20250617    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-21
powerpc                  mpc866_ads_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250617    gcc-8.5.0
powerpc               randconfig-002-20250617    clang-16
powerpc               randconfig-003-20250617    gcc-12.4.0
powerpc64             randconfig-001-20250617    gcc-14.3.0
powerpc64             randconfig-002-20250617    clang-21
powerpc64             randconfig-003-20250617    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250617    clang-21
riscv                 randconfig-002-20250617    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250617    clang-21
s390                  randconfig-002-20250617    clang-20
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250617    gcc-12.4.0
sh                    randconfig-002-20250617    gcc-14.3.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250617    gcc-12.4.0
sparc                 randconfig-002-20250617    gcc-13.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250617    gcc-15.1.0
sparc64               randconfig-002-20250617    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250617    gcc-12
um                    randconfig-002-20250617    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250617    clang-20
x86_64      buildonly-randconfig-002-20250617    clang-20
x86_64      buildonly-randconfig-003-20250617    gcc-11
x86_64      buildonly-randconfig-004-20250617    gcc-12
x86_64      buildonly-randconfig-005-20250617    gcc-12
x86_64      buildonly-randconfig-006-20250617    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250617    gcc-10.5.0
xtensa                randconfig-002-20250617    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
