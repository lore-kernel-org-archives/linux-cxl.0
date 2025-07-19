Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8C2853E9
	for <linux-cxl@vger.kernel.org>; Sat, 19 Jul 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927676; cv=none; b=Tc1waZVms3VjovvGx9j4IAiBsv+M7HxqYwPzo0kL3ZGz/oV/+MCbl3hl4cbI+ZtFYWp9fssZ7RQTvVaMZRcQ1EOKu1vUvKLF5aeomwBC7fcpaHQUbnJflG+x6VcnXRIfA8j3b+WcuUzveRxW9YqfX1+9c4q3ShGhMJbLxRWS+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927676; c=relaxed/simple;
	bh=6Newalz+SIg/Pw8t3rJuVvNyef0QhP9GX0uDt/eA7KY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ID28VilBEuMt+wj2Y+LLZ36UPjxDvAGlVKsrG5FZDAUkG8w6UqDbOEM2w4KCuMLLCn4mv8gyyTRNinwzTFygpYMIDEjs+gMvpMQIaXkUM863H/ilmEWSnpMpuh32a7M9exdY1pDqzWHWp5guGIsDSPmHvu8VI+Tc09QsBbxSxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUddTaeN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUddTaeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752927673; x=1784463673;
  h=date:from:to:cc:subject:message-id;
  bh=6Newalz+SIg/Pw8t3rJuVvNyef0QhP9GX0uDt/eA7KY=;
  b=FUddTaeN2eBu5jVK48eiXiZMujiShWegQ7YaOvvQP4oz5MxWQ+NIHY6g
   Pg1nHAAEbFxQT3Yuw75HCzqVZLyQq+LhwwhxOblqTKpRqYZXUmuYKF+mW
   gLfwnqf5PpStJlUgIagCJRARbclLAiG+Ac7YHvRw4gFIE7BHzu5kNO+hu
   FJvE3eke9/UTJToh1MdgX2hYW4GxgmrE8wk7iuTAlyWy3w/Xn7WOVHmWu
   GJUhUkPwLUhS7RYd2Fcub6ZBWBWTvQTMnUzKV0Bk0/7D6qfUfCdDJaX0+
   Bo7OIYeR43E64gcF+SjRJM6xkPuuPLfoa75uFWmrnadGC+jBeUfU0SV5i
   Q==;
X-CSE-ConnectionGUID: AUYE+KIsT9G0KpmGLPH01g==
X-CSE-MsgGUID: eYzTsFVUSfWLrT8mZm1Ihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55360278"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="55360278"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 05:21:12 -0700
X-CSE-ConnectionGUID: uIMcJGfBRQ2F+bDWboKhbA==
X-CSE-MsgGUID: IFhz0nK8SAiTPz+C5tplAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="159132447"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2025 05:21:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud6Yt-000FU3-3D;
	Sat, 19 Jul 2025 12:21:08 +0000
Date: Sat, 19 Jul 2025 20:21:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 3a32c5b3bb7d2dfad5fab94817f59e8963e2b1a6
Message-ID: <202507192048.0fxVLrwM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 3a32c5b3bb7d2dfad5fab94817f59e8963e2b1a6  Merge branch 'for-6.17/cxl-events-updates' into cxl-for-next

elapsed time: 730m

configs tested: 136
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
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250719    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250719    clang-21
arm                   randconfig-003-20250719    clang-21
arm                   randconfig-004-20250719    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250719    clang-18
arm64                 randconfig-003-20250719    gcc-15.1.0
arm64                 randconfig-004-20250719    clang-20
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250719    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250719    clang-21
hexagon               randconfig-002-20250719    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250719    gcc-12
i386        buildonly-randconfig-003-20250719    gcc-12
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250719    clang-18
loongarch             randconfig-002-20250719    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250719    gcc-8.5.0
parisc                randconfig-002-20250719    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250719    clang-19
powerpc               randconfig-002-20250719    gcc-10.5.0
powerpc               randconfig-003-20250719    gcc-12.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250719    gcc-8.5.0
powerpc64             randconfig-002-20250719    clang-21
powerpc64             randconfig-003-20250719    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-002-20250719    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sh                           se7751_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250719    clang-16
um                    randconfig-002-20250719    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    gcc-12
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
