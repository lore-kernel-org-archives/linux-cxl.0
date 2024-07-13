Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B01B960
	for <linux-cxl@vger.kernel.org>; Sat, 13 Jul 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862476; cv=none; b=YjHYOQzBlH0Y/u30QztTMgPFjNdAK67M/92m26Csv2njf44MTC+oe7Ty9TVDwjaxhAMRvx2PSXlmP2sTa717NEm36bY4DOW4dqbcp6annQ7t4wScmFwKHDSvvgkng1F/J7xFEiOrbhfDSorFbiQglVBY/lbIdkL1umFpH9g0WYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862476; c=relaxed/simple;
	bh=df1xJKRixqL7jFsNGDwFEY/RlSfa2x+y19GJRQXwP/4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VcixPB1CbiERO5c50dLirK1+vtix83a8Ss6YMjs4pMyPjPhsL91ctHzZavZCV9byZ15aouaRXhv08nRdngCElqK1qIG7CMSERcJzyNigvLIjXnN1YQwm8NI1yalw6UL3QmxR32vl43Aymzy2cepKwrrhZvfsQcoCkqsRKFjo36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MV3KqFfQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MV3KqFfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720862475; x=1752398475;
  h=date:from:to:cc:subject:message-id;
  bh=df1xJKRixqL7jFsNGDwFEY/RlSfa2x+y19GJRQXwP/4=;
  b=MV3KqFfQ35CACylrknJyL+clurePrRHjkbP61NbtnaKQ13TrT7FkfRLz
   NCVgIkR+dXcR8MiBLR/Bx0y9LBJ8GnoF1QdGxl7J0oU1Vmqz9asaDhhQy
   uVgqwzJSvS9OsEwdiEBTIOwjftNL7dmnQN2AyRgaqDgtchplOZ+xyv8lK
   Azuqul78ACaEi/Wc2JVQHZOyeqXu9ReWuOhB/4roVwZI589G3RaF8EiHq
   RXy6FpNlN7LtH0j34guHGPyTX4vjpNCkD2U2hanHSqIoDk+wzd/DcTZhv
   33eYvsZWZBFXTR83D+8utrnc62wNibGJjlr7y1IPmd/6r5JGOMCxKg0qq
   Q==;
X-CSE-ConnectionGUID: LUHeEEG/RfmDP8HMYXWnMA==
X-CSE-MsgGUID: nHRrsANuSqWIXSJv8fULjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18150874"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="18150874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 02:21:15 -0700
X-CSE-ConnectionGUID: bQriy6A9QyWd6/bigi0wvA==
X-CSE-MsgGUID: S+dCTiBBSDOCZ7pRYkRqKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="53517424"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jul 2024 02:21:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSYwH-000bvE-3C;
	Sat, 13 Jul 2024 09:21:09 +0000
Date: Sat, 13 Jul 2024 17:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.11/xor_fixes] BUILD SUCCESS
 8f55ada796565ce801418bf579f31a6a522d0337
Message-ID: <202407131753.fNmoPlhn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.11/xor_fixes
branch HEAD: 8f55ada796565ce801418bf579f31a6a522d0337  cxl: Remove defunct code calculating host bridge target positions

elapsed time: 733m

configs tested: 202
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240713   gcc-13.2.0
arc                   randconfig-002-20240713   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         at91_dt_defconfig   clang-19
arm                     davinci_all_defconfig   clang-19
arm                                 defconfig   clang-14
arm                       imx_v4_v5_defconfig   clang-16
arm                      integrator_defconfig   clang-19
arm                          pxa168_defconfig   clang-19
arm                             pxa_defconfig   gcc-14.1.0
arm                   randconfig-001-20240713   gcc-14.1.0
arm                   randconfig-002-20240713   gcc-14.1.0
arm                   randconfig-003-20240713   clang-19
arm                   randconfig-004-20240713   clang-19
arm                        realview_defconfig   clang-19
arm                             rpc_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240713   gcc-14.1.0
arm64                 randconfig-002-20240713   gcc-14.1.0
arm64                 randconfig-003-20240713   clang-19
arm64                 randconfig-004-20240713   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240713   gcc-14.1.0
csky                  randconfig-002-20240713   gcc-14.1.0
hexagon                          alldefconfig   clang-15
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240713   clang-19
hexagon               randconfig-002-20240713   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240713   clang-18
i386         buildonly-randconfig-002-20240713   clang-18
i386         buildonly-randconfig-003-20240713   clang-18
i386         buildonly-randconfig-003-20240713   gcc-8
i386         buildonly-randconfig-004-20240713   clang-18
i386         buildonly-randconfig-005-20240713   clang-18
i386         buildonly-randconfig-005-20240713   gcc-13
i386         buildonly-randconfig-006-20240713   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240713   clang-18
i386                  randconfig-001-20240713   gcc-10
i386                  randconfig-002-20240713   clang-18
i386                  randconfig-002-20240713   gcc-13
i386                  randconfig-003-20240713   clang-18
i386                  randconfig-003-20240713   gcc-13
i386                  randconfig-004-20240713   clang-18
i386                  randconfig-005-20240713   clang-18
i386                  randconfig-005-20240713   gcc-10
i386                  randconfig-006-20240713   clang-18
i386                  randconfig-006-20240713   gcc-12
i386                  randconfig-011-20240713   clang-18
i386                  randconfig-012-20240713   clang-18
i386                  randconfig-012-20240713   gcc-7
i386                  randconfig-013-20240713   clang-18
i386                  randconfig-013-20240713   gcc-13
i386                  randconfig-014-20240713   clang-18
i386                  randconfig-014-20240713   gcc-13
i386                  randconfig-015-20240713   clang-18
i386                  randconfig-015-20240713   gcc-11
i386                  randconfig-016-20240713   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240713   gcc-14.1.0
loongarch             randconfig-002-20240713   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                      loongson3_defconfig   clang-19
mips                malta_qemu_32r6_defconfig   clang-19
mips                        maltaup_defconfig   clang-19
mips                        omega2p_defconfig   clang-19
mips                           rs90_defconfig   clang-19
nios2                         3c120_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240713   gcc-14.1.0
nios2                 randconfig-002-20240713   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-002-20240713   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                     asp8347_defconfig   clang-19
powerpc                 canyonlands_defconfig   clang-19
powerpc                       eiger_defconfig   clang-19
powerpc                    gamecube_defconfig   clang-19
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-19
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc                 mpc834x_itx_defconfig   clang-19
powerpc                      ppc44x_defconfig   clang-19
powerpc                     tqm8555_defconfig   clang-19
powerpc                        warp_defconfig   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          sdk7780_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240713   clang-18
x86_64       buildonly-randconfig-002-20240713   clang-18
x86_64       buildonly-randconfig-003-20240713   clang-18
x86_64       buildonly-randconfig-003-20240713   gcc-13
x86_64       buildonly-randconfig-004-20240713   clang-18
x86_64       buildonly-randconfig-005-20240713   clang-18
x86_64       buildonly-randconfig-005-20240713   gcc-8
x86_64       buildonly-randconfig-006-20240713   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240713   clang-18
x86_64                randconfig-002-20240713   clang-18
x86_64                randconfig-003-20240713   clang-18
x86_64                randconfig-004-20240713   clang-18
x86_64                randconfig-004-20240713   gcc-13
x86_64                randconfig-005-20240713   clang-18
x86_64                randconfig-006-20240713   clang-18
x86_64                randconfig-011-20240713   clang-18
x86_64                randconfig-012-20240713   clang-18
x86_64                randconfig-013-20240713   clang-18
x86_64                randconfig-013-20240713   gcc-13
x86_64                randconfig-014-20240713   clang-18
x86_64                randconfig-015-20240713   clang-18
x86_64                randconfig-015-20240713   gcc-13
x86_64                randconfig-016-20240713   clang-18
x86_64                randconfig-016-20240713   gcc-13
x86_64                randconfig-071-20240713   clang-18
x86_64                randconfig-071-20240713   gcc-8
x86_64                randconfig-072-20240713   clang-18
x86_64                randconfig-072-20240713   gcc-8
x86_64                randconfig-073-20240713   clang-18
x86_64                randconfig-074-20240713   clang-18
x86_64                randconfig-075-20240713   clang-18
x86_64                randconfig-075-20240713   gcc-13
x86_64                randconfig-076-20240713   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
