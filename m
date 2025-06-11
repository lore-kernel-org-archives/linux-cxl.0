Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69653D299
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649675; cv=none; b=OmyRvHUiYedRFzLBcoZ4tXSK6yy41tcQ8CyiB8Kj3iWKM0ma0LaL6xnztyJ8SPN/0jZ2w1miPiRq1EPIUaS2qnFR0CEcG3pcgXEbqtZaEsoNGTXt4/FXDIRPS2D2pt2XGdUMSWRnasG7PuRCDzA+UBiMZq/U4xNuyYbwdbbVY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649675; c=relaxed/simple;
	bh=nzjbCdRxrlVhxpOJlkqsOyUG9m16q7aXH9rkDp+vpbs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AOTuniB5Dmusxf3ZPPIGRc952BLtZ/B/D/bjRZJ8xAwducxKfcSdbr1qkbcboUdC/0Jvi8FIxYsFa67ZodMKUwb6tTkoUFAAxs70zEThTm9wELisQ+EIhUI/bsXY3Qfk+w9e6MFS94aw3vzjcChN2jTwikq0nblUxUM5esJSI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ8JsrWA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ8JsrWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749649674; x=1781185674;
  h=date:from:to:cc:subject:message-id;
  bh=nzjbCdRxrlVhxpOJlkqsOyUG9m16q7aXH9rkDp+vpbs=;
  b=fQ8JsrWAAyl3j4/LP4HCvx8Bqc8w7zguemSOn+/SCI248RYaE4kSPY7L
   Nzu1YMQTmyugFsAukeMHEFdka+GNXVs4MiB0AOFIX4JDOsaBCrO7g0ZoO
   SoO/f6LUe7xkl3oFbWyRgrHPuDnWSyT/6iM0MZnOVUz+dWEYbcRf1PyjF
   WxzyV4qYvEABDE6CWFd1p1QbgMotI5wB01Jj0p9IzOMpZ1g8YTNd+6Ogn
   chqcwKXA/MmLYwci1c23rgKeJRGFxBLLG87pA8fwJXj/pxKM5x00LzgEr
   acO3p0CL9o2nZI5rVD7iNYUn1HN/yHRevxWL9ZSonIifvd0I3t0t8RWFC
   w==;
X-CSE-ConnectionGUID: TtQHF66xQeGd+7l17CHYjw==
X-CSE-MsgGUID: cSq3adzETROQVGdU3wFbgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74328906"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74328906"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:47:54 -0700
X-CSE-ConnectionGUID: fj0yZYyGSfimFdexm59KoA==
X-CSE-MsgGUID: 69wEZA7OTEqtySA+q7+DzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="184410068"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2025 06:47:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPLnw-000AWi-1v;
	Wed, 11 Jun 2025 13:47:48 +0000
Date: Wed, 11 Jun 2025 21:47:42 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 85cc50bfcb8b08c9304925b66cd2bc83c1c765bf
Message-ID: <202506112131.LhhCZf9g-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 85cc50bfcb8b08c9304925b66cd2bc83c1c765bf  cxl/Documentation: Add more description about min/max scrub cycle

elapsed time: 731m

configs tested: 141
configs skipped: 4

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
arc                   randconfig-001-20250611    gcc-12.4.0
arc                   randconfig-002-20250611    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250611    gcc-11.5.0
arm                   randconfig-002-20250611    clang-21
arm                   randconfig-003-20250611    gcc-13.3.0
arm                   randconfig-004-20250611    gcc-13.3.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250611    gcc-8.5.0
arm64                 randconfig-002-20250611    gcc-9.5.0
arm64                 randconfig-003-20250611    gcc-13.3.0
arm64                 randconfig-004-20250611    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250611    gcc-15.1.0
csky                  randconfig-002-20250611    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250611    clang-21
hexagon               randconfig-002-20250611    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250611    gcc-12
i386        buildonly-randconfig-002-20250611    gcc-12
i386        buildonly-randconfig-003-20250611    clang-20
i386        buildonly-randconfig-004-20250611    gcc-12
i386        buildonly-randconfig-005-20250611    gcc-11
i386        buildonly-randconfig-006-20250611    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250611    gcc-15.1.0
loongarch             randconfig-002-20250611    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250611    gcc-8.5.0
nios2                 randconfig-002-20250611    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250611    gcc-11.5.0
parisc                randconfig-002-20250611    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250611    gcc-8.5.0
powerpc               randconfig-002-20250611    gcc-13.3.0
powerpc               randconfig-003-20250611    clang-21
powerpc64             randconfig-001-20250611    clang-21
powerpc64             randconfig-002-20250611    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250611    clang-21
riscv                 randconfig-002-20250611    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250611    gcc-15.1.0
s390                  randconfig-002-20250611    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250611    gcc-15.1.0
sh                    randconfig-002-20250611    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250611    gcc-11.5.0
sparc                 randconfig-002-20250611    gcc-8.5.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250611    gcc-8.5.0
sparc64               randconfig-002-20250611    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250611    clang-21
um                    randconfig-002-20250611    clang-19
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250611    gcc-12
x86_64      buildonly-randconfig-002-20250611    clang-20
x86_64      buildonly-randconfig-003-20250611    clang-20
x86_64      buildonly-randconfig-004-20250611    gcc-12
x86_64      buildonly-randconfig-005-20250611    gcc-12
x86_64      buildonly-randconfig-006-20250611    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250611    gcc-13.3.0
xtensa                randconfig-002-20250611    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
