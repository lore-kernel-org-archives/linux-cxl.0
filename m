Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A018BBAC
	for <linux-cxl@vger.kernel.org>; Fri,  3 Jan 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899110; cv=none; b=T+p/dXKgNIzmR8XnUaXvPl+/8Fl/p0oeF0aWIK/WgMSPeniPZoMnyf0DvttxcJa0V5GfBcEGpylRvW2TxXQz7f0BpsOYRybVv49Wsa6t5vBty0s6nsKAzWOFdBVbnIJRDUQ2jzbse9x+iwq4zBeBQKbmYINTGlh5vreuY2/me+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899110; c=relaxed/simple;
	bh=lLCPDTuKD3+cjn/hBUMQIOXfKOMYra5a3teJ/8LGrvY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a3FPFg4UHyAjIqwMb1ndTGx3vnhwUEeUSZP99LgEXSxkBeTREIrpWtjx3DIcfA2ZVRCXFTeeJPHNBb0hpo8M8UACuKrHa/GjyXVktaN6iB23vF71mBQ/po2JsvMjS20zqnc7N97eD9HokSOwiaR3IfqDuvpNk0hpagU8sVsLFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dw5j+de0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dw5j+de0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735899109; x=1767435109;
  h=date:from:to:cc:subject:message-id;
  bh=lLCPDTuKD3+cjn/hBUMQIOXfKOMYra5a3teJ/8LGrvY=;
  b=dw5j+de0p35P3ETlv1H5s+pfyo75IjKWc6ItBpBsZJSsoML0cRjFpyti
   w/BlJYyXmr3fAKMuY3eaBPUTn827o4f3sYF7sSPygBpwSd3CAQlwklxlj
   AMP9V1c3yi6TggpU7i39VeZWUe120IgHQ1h6B5XNG06m7U1JerAfq9PWY
   HqaYtVqh3Qo30iMEWDu9GP/mMgZR77t3cBt3AupObg9FwvgKgEJ7JkfhD
   VBmgIXp7DpQBMNIz/cabRqd/mZ59qo0qf5Xgq/4GAZ3PTetDz97GVpL91
   aIW8RW3FDUilWIAxFFOdnALi0dtGwaaTS0q2iVM6tuiGH18M5y6lavNcZ
   w==;
X-CSE-ConnectionGUID: Q5vllqhgQM2ZpgUyuwFTvw==
X-CSE-MsgGUID: l8c+yrPKRcOf7UjGYgeazQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="36260897"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36260897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 02:11:49 -0800
X-CSE-ConnectionGUID: udmlWifyTVaRunE4uhpwpg==
X-CSE-MsgGUID: J4bBrhxNQpeDSiCO69j2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125039432"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jan 2025 02:11:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTeee-0009ZP-0T;
	Fri, 03 Jan 2025 10:11:44 +0000
Date: Fri, 03 Jan 2025 18:11:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
Message-ID: <202501031809.fk04KzvA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2  cxl/pci: Add CXL Type 1/2 support to cxl_dvsec_rr_decode()

elapsed time: 770m

configs tested: 189
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    clang-20
arc                   randconfig-001-20250103    clang-20
arc                   randconfig-001-20250103    gcc-13.2.0
arc                   randconfig-002-20250103    clang-20
arc                   randconfig-002-20250103    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    clang-20
arm                   randconfig-001-20250103    clang-20
arm                   randconfig-002-20250103    clang-15
arm                   randconfig-002-20250103    clang-20
arm                   randconfig-003-20250103    clang-20
arm                   randconfig-003-20250103    gcc-14.2.0
arm                   randconfig-004-20250103    clang-20
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250103    clang-19
arm64                 randconfig-001-20250103    clang-20
arm64                 randconfig-002-20250103    clang-20
arm64                 randconfig-003-20250103    clang-19
arm64                 randconfig-003-20250103    clang-20
arm64                 randconfig-004-20250103    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250103    gcc-14.2.0
csky                  randconfig-002-20250103    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20250103    clang-20
hexagon               randconfig-001-20250103    gcc-14.2.0
hexagon               randconfig-002-20250103    clang-20
hexagon               randconfig-002-20250103    gcc-14.2.0
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250103    clang-19
i386        buildonly-randconfig-002-20250103    clang-19
i386        buildonly-randconfig-003-20250103    gcc-12
i386        buildonly-randconfig-004-20250103    clang-19
i386        buildonly-randconfig-005-20250103    clang-19
i386        buildonly-randconfig-006-20250103    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250103    clang-19
i386                  randconfig-002-20250103    clang-19
i386                  randconfig-003-20250103    clang-19
i386                  randconfig-004-20250103    clang-19
i386                  randconfig-005-20250103    clang-19
i386                  randconfig-006-20250103    clang-19
i386                  randconfig-007-20250103    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250103    gcc-14.2.0
loongarch             randconfig-002-20250103    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-20
mips                       rbtx49xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250103    gcc-14.2.0
nios2                 randconfig-002-20250103    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250103    gcc-14.2.0
parisc                randconfig-002-20250103    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-16
powerpc                     ksi8560_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250103    clang-17
powerpc               randconfig-001-20250103    gcc-14.2.0
powerpc               randconfig-002-20250103    clang-19
powerpc               randconfig-002-20250103    gcc-14.2.0
powerpc               randconfig-003-20250103    gcc-14.2.0
powerpc                    socrates_defconfig    clang-20
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20250103    clang-19
powerpc64             randconfig-001-20250103    gcc-14.2.0
powerpc64             randconfig-002-20250103    gcc-14.2.0
powerpc64             randconfig-003-20250103    clang-19
powerpc64             randconfig-003-20250103    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250103    clang-20
riscv                 randconfig-002-20250103    clang-20
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250103    clang-20
s390                  randconfig-001-20250103    gcc-14.2.0
s390                  randconfig-002-20250103    clang-20
s390                  randconfig-002-20250103    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                    randconfig-001-20250103    clang-20
sh                    randconfig-001-20250103    gcc-14.2.0
sh                    randconfig-002-20250103    clang-20
sh                    randconfig-002-20250103    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250103    clang-20
sparc                 randconfig-001-20250103    gcc-14.2.0
sparc                 randconfig-002-20250103    clang-20
sparc                 randconfig-002-20250103    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250103    clang-20
sparc64               randconfig-001-20250103    gcc-14.2.0
sparc64               randconfig-002-20250103    clang-20
sparc64               randconfig-002-20250103    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250103    clang-20
um                    randconfig-001-20250103    gcc-11
um                    randconfig-002-20250103    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250103    gcc-12
x86_64      buildonly-randconfig-002-20250103    clang-19
x86_64      buildonly-randconfig-003-20250103    gcc-12
x86_64      buildonly-randconfig-004-20250103    clang-19
x86_64      buildonly-randconfig-005-20250103    clang-19
x86_64      buildonly-randconfig-006-20250103    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250103    clang-20
xtensa                randconfig-001-20250103    gcc-14.2.0
xtensa                randconfig-002-20250103    clang-20
xtensa                randconfig-002-20250103    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
