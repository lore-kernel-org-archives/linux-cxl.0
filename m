Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4418734F
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003079; cv=none; b=X9JXyLrw3OEOlQFlNzFjYf6CBQon+raLDVsqgOSaQo4+dzhRH6x2qim/UMHXROhuzAFFGLPd+/s/OsBiNsE+I4C1xgceuBfljUhFIAVDx8q+h0ysov76LCsEUpaxAlZnfqNrN95Qd6HfLftG8Btkg8j5vw58+Xwd4zfyWTYmuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003079; c=relaxed/simple;
	bh=ypYwjoWdyzTz1o5Fqsd5Yi6eNRJre+f9AjsFuHtEx44=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fJiTx2J5RXI838SyPp1k6ynD+JGXdt14xyhF621tyCcdNvWYeJU2a1TSfKTPqSf7eiKBLjI3icIIK1uTYkWnSJMVDCpbjv7whOpFnawChWpuHILlgrJPmvMwQuYH+4lD+97mSnGOFYClDXX7dQ2r2PJobGj1FNr5pfHLUp55pk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gI1CC1O4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gI1CC1O4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717003079; x=1748539079;
  h=date:from:to:cc:subject:message-id;
  bh=ypYwjoWdyzTz1o5Fqsd5Yi6eNRJre+f9AjsFuHtEx44=;
  b=gI1CC1O4QIN7pVKql4FoQi93wMqVApSfFUkdAvaK93przaabrsWkP8wv
   +C/xSdRpYQg/DAtOn08z5K4+dUTeH3V0YwTMgFiX0IiT/GrXsZtSSBJWH
   TSz0EqzifSwFq1LthdNbyi0+sAIViSj/CFsF+9bcZl52L2eMmn2pl/I/r
   KqvrYmsqp+/f2rPRYFfy25xhRYclq0mB/4Sb14Z6xSxDpcVZ/flysFaZU
   uC+SFPfphWYQ/yYBVy5T583hbOtAo4KIiWcRiEdDKieEaWU3s9lNlGIPN
   ib0cVGXR3IhmSzIaQJsXMIgG7qevuGidWfSyMto7wf8yix1eBwY9O8Asf
   g==;
X-CSE-ConnectionGUID: TDPh2ED3QPG65d1MxJn2uw==
X-CSE-MsgGUID: 6GN4fAD5T32dr2q5P9AlVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13589797"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13589797"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:17:58 -0700
X-CSE-ConnectionGUID: VoGo+go4TI6L1nlhyu+eYQ==
X-CSE-MsgGUID: f71OpLJqQ7iPaABSaexNbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35588834"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 29 May 2024 10:17:55 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCMvx-000Dzj-0h;
	Wed, 29 May 2024 17:17:53 +0000
Date: Thu, 30 May 2024 01:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
Message-ID: <202405300144.2wlo0PNL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1  cxl/region: Fix memregion leaks in devm_cxl_add_region()

elapsed time: 1024m

configs tested: 191
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240529   gcc  
arc                   randconfig-002-20240529   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240529   gcc  
arm                   randconfig-002-20240529   gcc  
arm                   randconfig-003-20240529   gcc  
arm                   randconfig-004-20240529   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240529   clang
arm64                 randconfig-002-20240529   clang
arm64                 randconfig-003-20240529   gcc  
arm64                 randconfig-004-20240529   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240529   gcc  
csky                  randconfig-002-20240529   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240529   clang
hexagon               randconfig-002-20240529   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240529   clang
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-004-20240529   clang
i386         buildonly-randconfig-005-20240529   gcc  
i386         buildonly-randconfig-006-20240529   clang
i386                                defconfig   clang
i386                  randconfig-001-20240529   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-005-20240529   clang
i386                  randconfig-006-20240529   clang
i386                  randconfig-011-20240529   clang
i386                  randconfig-012-20240529   clang
i386                  randconfig-013-20240529   clang
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-015-20240529   clang
i386                  randconfig-016-20240529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240529   gcc  
loongarch             randconfig-002-20240529   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                 decstation_r4k_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                          malta_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        omega2p_defconfig   clang
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240529   gcc  
nios2                 randconfig-002-20240529   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240529   gcc  
parisc                randconfig-002-20240529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc               randconfig-001-20240529   clang
powerpc               randconfig-002-20240529   clang
powerpc               randconfig-003-20240529   clang
powerpc                     redwood_defconfig   clang
powerpc64             randconfig-001-20240529   gcc  
powerpc64             randconfig-002-20240529   clang
powerpc64             randconfig-003-20240529   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240529   gcc  
riscv                 randconfig-002-20240529   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240529   clang
s390                  randconfig-002-20240529   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240529   gcc  
sh                    randconfig-002-20240529   gcc  
sh                           se7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240529   gcc  
sparc64               randconfig-002-20240529   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240529   clang
um                    randconfig-002-20240529   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240529   gcc  
x86_64       buildonly-randconfig-002-20240529   clang
x86_64       buildonly-randconfig-003-20240529   clang
x86_64       buildonly-randconfig-004-20240529   gcc  
x86_64       buildonly-randconfig-005-20240529   clang
x86_64       buildonly-randconfig-006-20240529   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240529   gcc  
x86_64                randconfig-002-20240529   clang
x86_64                randconfig-003-20240529   clang
x86_64                randconfig-004-20240529   clang
x86_64                randconfig-005-20240529   gcc  
x86_64                randconfig-006-20240529   gcc  
x86_64                randconfig-011-20240529   gcc  
x86_64                randconfig-012-20240529   gcc  
x86_64                randconfig-013-20240529   clang
x86_64                randconfig-014-20240529   gcc  
x86_64                randconfig-015-20240529   gcc  
x86_64                randconfig-016-20240529   clang
x86_64                randconfig-071-20240529   clang
x86_64                randconfig-072-20240529   gcc  
x86_64                randconfig-073-20240529   gcc  
x86_64                randconfig-074-20240529   clang
x86_64                randconfig-075-20240529   clang
x86_64                randconfig-076-20240529   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240529   gcc  
xtensa                randconfig-002-20240529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
