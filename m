Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D31547DC
	for <linux-cxl@vger.kernel.org>; Thu,  3 Oct 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963617; cv=none; b=nlk5TNh33+Dtzf1uWJo6DBuQSHHo46rL96/hvG2gcQNNleP3KFWosPc81aqtKaH9ham85VUGAd33YvLwfIAp7fVBSFHe/Ale6jUERpLExXM6PfRCz+KOyLcJb6UoLq1SaysSbFmgxvFOEIbOPRtZ2qozLK3IeRUEhl3uRw6ZMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963617; c=relaxed/simple;
	bh=CejMxaByQQBP7tgA+2pF9UDO9mgkSpbSfZKU0DMjI9w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Np+QqJzpf4Whdzim1BTa9V3N7sFo4J1SVGxesU3ed2qOTHZeHBc0pnrJGlrUc+sU+evfrR2tYORLREg0gZ9VlkelLroUxGoIHxrDY80IPKwmGwYv9OJZNXosI3RkBFzew5GIagEOMVZmsGIF3xvCA/vWFLI2wPsy22zM2+CjaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvL7RnUB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvL7RnUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727963615; x=1759499615;
  h=date:from:to:cc:subject:message-id;
  bh=CejMxaByQQBP7tgA+2pF9UDO9mgkSpbSfZKU0DMjI9w=;
  b=mvL7RnUBtqogNUYGnSd+ZiBUeWnIqDztVh4e0Q0K6EqPEz5bjvmGnnxb
   PuV1UB4lwHww1r146lLD1Jmwp0n9OIiH/YQ37jkmGqPTx2jMsGPYsuIj5
   pa8zRgyr3U06lOLbFsMRO7Y6xIC/IcPJCFPrZBtODHGbYqySqr15h28MV
   mI4Ij/skDptpJjvnqrSZqmuB0dCDsyxukbRCZ4y3rYk8TY2KHgCuQ9fJX
   plAqr5irgTrJ5w98wE0cCUQUTtuRG9JkLHfwFr+eQSy18qePrtFEHKOAJ
   A6lIrBfTtOhAFuJ++hpmStt1PgwZk6KgknGB4g04+PuAYibsW245//E7S
   w==;
X-CSE-ConnectionGUID: sDOBH2+VTN6rT0C7hOIN5Q==
X-CSE-MsgGUID: 6KZJ2DTBRyGnNuY+PeqxDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27042164"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27042164"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 06:53:34 -0700
X-CSE-ConnectionGUID: I1aaomZmTzqzxxmKu35fJQ==
X-CSE-MsgGUID: 7NUSJZ6bTVOP6EAbbMeLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="78900498"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2024 06:53:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swMGo-0000Ty-1L;
	Thu, 03 Oct 2024 13:53:30 +0000
Date: Thu, 03 Oct 2024 21:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 ee1e3c46ed19c096be22472c728fa7f68b1352c4
Message-ID: <202410032148.TZ0uC3Q0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: ee1e3c46ed19c096be22472c728fa7f68b1352c4  EINJ, CXL: Fix CXL device SBDF calculation

elapsed time: 1033m

configs tested: 273
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    gcc-14.1.0
arc                            hsdk_defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241003    gcc-13.2.0
arc                   randconfig-001-20241003    gcc-14.1.0
arc                   randconfig-002-20241003    gcc-13.2.0
arc                   randconfig-002-20241003    gcc-14.1.0
arc                        vdk_hs38_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                             mxs_defconfig    clang-20
arm                         orion5x_defconfig    gcc-14.1.0
arm                   randconfig-001-20241003    gcc-14.1.0
arm                   randconfig-002-20241003    gcc-14.1.0
arm                   randconfig-003-20241003    gcc-14.1.0
arm                   randconfig-004-20241003    clang-20
arm                   randconfig-004-20241003    gcc-14.1.0
arm                        realview_defconfig    gcc-14.1.0
arm                             rpc_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241003    clang-17
arm64                 randconfig-001-20241003    gcc-14.1.0
arm64                 randconfig-002-20241003    clang-15
arm64                 randconfig-002-20241003    gcc-14.1.0
arm64                 randconfig-003-20241003    clang-17
arm64                 randconfig-003-20241003    gcc-14.1.0
arm64                 randconfig-004-20241003    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241003    gcc-14.1.0
csky                  randconfig-002-20241003    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241003    gcc-14.1.0
hexagon               randconfig-002-20241003    clang-20
hexagon               randconfig-002-20241003    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241003    gcc-12
i386        buildonly-randconfig-002-20241003    clang-18
i386        buildonly-randconfig-002-20241003    gcc-12
i386        buildonly-randconfig-003-20241003    gcc-12
i386        buildonly-randconfig-004-20241003    clang-18
i386        buildonly-randconfig-004-20241003    gcc-12
i386        buildonly-randconfig-005-20241003    gcc-12
i386        buildonly-randconfig-006-20241003    clang-18
i386        buildonly-randconfig-006-20241003    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241003    gcc-12
i386                  randconfig-002-20241003    clang-18
i386                  randconfig-002-20241003    gcc-12
i386                  randconfig-003-20241003    clang-18
i386                  randconfig-003-20241003    gcc-12
i386                  randconfig-004-20241003    gcc-12
i386                  randconfig-005-20241003    clang-18
i386                  randconfig-005-20241003    gcc-12
i386                  randconfig-006-20241003    gcc-12
i386                  randconfig-011-20241003    clang-18
i386                  randconfig-011-20241003    gcc-12
i386                  randconfig-012-20241003    gcc-12
i386                  randconfig-013-20241003    gcc-12
i386                  randconfig-014-20241003    gcc-12
i386                  randconfig-015-20241003    gcc-12
i386                  randconfig-016-20241003    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241003    gcc-14.1.0
loongarch             randconfig-002-20241003    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                        mvme16x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    clang-20
mips                     cu1830-neo_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      maltasmvp_defconfig    gcc-14.1.0
mips                    maltaup_xpa_defconfig    gcc-14.1.0
mips                        qi_lb60_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241003    gcc-14.1.0
nios2                 randconfig-002-20241003    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20241003    gcc-14.1.0
parisc                randconfig-002-20241003    gcc-14.1.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   currituck_defconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241003    gcc-14.1.0
powerpc               randconfig-002-20241003    gcc-14.1.0
powerpc               randconfig-003-20241003    gcc-14.1.0
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm8548_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241003    clang-20
powerpc64             randconfig-001-20241003    gcc-14.1.0
powerpc64             randconfig-002-20241003    clang-20
powerpc64             randconfig-002-20241003    gcc-14.1.0
powerpc64             randconfig-003-20241003    clang-20
powerpc64             randconfig-003-20241003    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241003    clang-20
riscv                 randconfig-001-20241003    gcc-14.1.0
riscv                 randconfig-002-20241003    clang-20
riscv                 randconfig-002-20241003    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.1.0
s390                  randconfig-001-20241003    gcc-14.1.0
s390                  randconfig-002-20241003    gcc-14.1.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                            migor_defconfig    gcc-14.1.0
sh                    randconfig-001-20241003    gcc-14.1.0
sh                    randconfig-002-20241003    gcc-14.1.0
sh                          sdk7780_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                           se7750_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20241003    gcc-14.1.0
sparc64               randconfig-002-20241003    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241003    gcc-12
um                    randconfig-001-20241003    gcc-14.1.0
um                    randconfig-002-20241003    clang-20
um                    randconfig-002-20241003    gcc-14.1.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241003    clang-18
x86_64      buildonly-randconfig-002-20241003    clang-18
x86_64      buildonly-randconfig-002-20241003    gcc-12
x86_64      buildonly-randconfig-003-20241003    clang-18
x86_64      buildonly-randconfig-004-20241003    clang-18
x86_64      buildonly-randconfig-005-20241003    clang-18
x86_64      buildonly-randconfig-005-20241003    gcc-12
x86_64      buildonly-randconfig-006-20241003    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241003    clang-18
x86_64                randconfig-001-20241003    gcc-12
x86_64                randconfig-002-20241003    clang-18
x86_64                randconfig-003-20241003    clang-18
x86_64                randconfig-004-20241003    clang-18
x86_64                randconfig-005-20241003    clang-18
x86_64                randconfig-006-20241003    clang-18
x86_64                randconfig-006-20241003    gcc-12
x86_64                randconfig-011-20241003    clang-18
x86_64                randconfig-012-20241003    clang-18
x86_64                randconfig-012-20241003    gcc-12
x86_64                randconfig-013-20241003    clang-18
x86_64                randconfig-013-20241003    gcc-12
x86_64                randconfig-014-20241003    clang-18
x86_64                randconfig-015-20241003    clang-18
x86_64                randconfig-015-20241003    gcc-11
x86_64                randconfig-016-20241003    clang-18
x86_64                randconfig-071-20241003    clang-18
x86_64                randconfig-071-20241003    gcc-12
x86_64                randconfig-072-20241003    clang-18
x86_64                randconfig-072-20241003    gcc-12
x86_64                randconfig-073-20241003    clang-18
x86_64                randconfig-073-20241003    gcc-11
x86_64                randconfig-074-20241003    clang-18
x86_64                randconfig-074-20241003    gcc-12
x86_64                randconfig-075-20241003    clang-18
x86_64                randconfig-076-20241003    clang-18
x86_64                randconfig-076-20241003    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241003    gcc-14.1.0
xtensa                randconfig-002-20241003    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
