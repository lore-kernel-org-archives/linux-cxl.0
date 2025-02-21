Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906F1E493
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142627; cv=none; b=Qzue8CWXGTc6A580NI3hPyywVjj0/G/57Ls5C4o46JLtRrJsH8Zpgn1xmjSxPujPLKuVyMleH+Zqiwhi7ppsjnXX4AjRO5Hf9e0Gn+FAfzLtGEB5mmCtGFctI4lm9vo9JVaBZFUfi4JZoXuNtM5YLKRdxp0pjg0sQzR3Ratq444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142627; c=relaxed/simple;
	bh=4qLdujKKnEWLelUyw6r+Rdjco9RzA92ibO8fCyMc4is=;
	h=Date:From:To:Cc:Subject:Message-ID; b=piXT0BDIjRAm7qQ4lWS93kdxPZ/vtiuLD6AILVNwKYc1i6caDUkZSY6Uf1pmekCf/WDyW3/HPRmdKil9wJpuzXp9hp/eU367HsbgkeDx08jGhjP8Ro96UwecoDMe99Y2xSRw/O2oGo2/4UkTgjZv1/IsKAAuESHoktt7gHlk2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLVQpTfO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLVQpTfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740142626; x=1771678626;
  h=date:from:to:cc:subject:message-id;
  bh=4qLdujKKnEWLelUyw6r+Rdjco9RzA92ibO8fCyMc4is=;
  b=KLVQpTfOK2RzTwX/AdKpJ+KHKrYvu+6tBn1hyQMMwQOejX/sWS/VHjPL
   +H6q5oklcRBNU1jdXYI9XtebNjOm0AaBjilVMXMFShAvI6xXM3HslKuSC
   CVroXZVqFPONFZM6sppS7gxYZ3lKqDijtfWn+d8gywnP0bDZw8P/A3SBh
   ty+FCi9iOBMXakYq8bYqkq8DpwdIg+/WvUC8ruimXOdWHhbSTmsfDK5x+
   u5cbtElCA9nKXq7qaqzJ0Fx56VymEhxsb+PMXr906RJVp2HOaBwerIggi
   bs1ugJwVTux+cXZwINqdNzaGpA8kZQEGQvbIzB09n+E/U4VjMMdjTQLFO
   w==;
X-CSE-ConnectionGUID: T6bRWsfcSnSzhnMzHfKixA==
X-CSE-MsgGUID: yxJEnD1tQge4KSvx/4BdhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51176569"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51176569"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:57:05 -0800
X-CSE-ConnectionGUID: v5+EZWi2RbiawcaaRdC8QA==
X-CSE-MsgGUID: CLXBI4T3T1axABkQFRPH1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146248778"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Feb 2025 04:57:03 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlSaS-0005Wp-2S;
	Fri, 21 Feb 2025 12:57:00 +0000
Date: Fri, 21 Feb 2025 20:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 d5d2106e2118c4e09fef131d9889f79559b95bfc
Message-ID: <202502212048.CFsYOV74-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: d5d2106e2118c4e09fef131d9889f79559b95bfc  cxl: Document missing sysfs files

elapsed time: 1069m

configs tested: 139
configs skipped: 5

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
arc                   randconfig-001-20250221    gcc-13.2.0
arc                   randconfig-002-20250221    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-19
arm                                 defconfig    clang-21
arm                           h3600_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-19
arm                   randconfig-001-20250221    gcc-14.2.0
arm                   randconfig-002-20250221    clang-19
arm                   randconfig-003-20250221    gcc-14.2.0
arm                   randconfig-004-20250221    clang-21
arm                         s5pv210_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250221    clang-15
arm64                 randconfig-002-20250221    clang-21
arm64                 randconfig-003-20250221    clang-21
arm64                 randconfig-004-20250221    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250221    gcc-14.2.0
csky                  randconfig-002-20250221    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250221    clang-21
hexagon               randconfig-002-20250221    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250221    gcc-12
i386        buildonly-randconfig-002-20250221    gcc-12
i386        buildonly-randconfig-003-20250221    gcc-12
i386        buildonly-randconfig-004-20250221    gcc-12
i386        buildonly-randconfig-005-20250221    clang-19
i386        buildonly-randconfig-006-20250221    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250221    gcc-14.2.0
loongarch             randconfig-002-20250221    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-21
mips                         rt305x_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250221    gcc-14.2.0
nios2                 randconfig-002-20250221    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250221    gcc-14.2.0
parisc                randconfig-002-20250221    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250221    clang-21
powerpc               randconfig-002-20250221    clang-21
powerpc               randconfig-003-20250221    clang-17
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250221    clang-21
powerpc64             randconfig-002-20250221    clang-21
powerpc64             randconfig-003-20250221    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250221    clang-21
riscv                 randconfig-002-20250221    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250221    gcc-14.2.0
s390                  randconfig-002-20250221    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250221    gcc-14.2.0
sh                    randconfig-002-20250221    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250221    gcc-14.2.0
sparc                 randconfig-002-20250221    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250221    gcc-14.2.0
sparc64               randconfig-002-20250221    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250221    gcc-12
um                    randconfig-002-20250221    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250221    gcc-12
x86_64      buildonly-randconfig-002-20250221    clang-19
x86_64      buildonly-randconfig-003-20250221    clang-19
x86_64      buildonly-randconfig-004-20250221    clang-19
x86_64      buildonly-randconfig-005-20250221    clang-19
x86_64      buildonly-randconfig-006-20250221    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250221    gcc-14.2.0
xtensa                randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
