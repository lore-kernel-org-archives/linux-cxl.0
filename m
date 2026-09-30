Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DD4D9F72
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773737; cv=none; b=beAnOHGa0/yhH6pY8y96qm6BGYE/lu44/h8CVNk6hYCROgqGkfdpVXHXbNUNR5w9B+Hf5gDTvOUMBmo0Ikwhls+uB8ziNr16ygdFOPZuL2Q3nfpUi2SbOZma10MbmiSQyPe10h8RX9QWdwyz1yev9NHZn2VoZHGc5NJJZl2EtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773737; c=relaxed/simple;
	bh=j33hMxGjbH/FnnurTcr/ZCJSdBNWm0DsnhhfrML3Od0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nx3Gsa40p/Zgx57we41ADzs9b5jeseoOwnQouqcjbCelbUGZbp2lK/en0K59dr3Mhs45nADmrCC/3ZqUkuYJKtIpkhg8VtrBb35bQY5bvH4n+N0JfDigYzJuZ2vOwGFpItF9tfNgcXBr0B1FR7YwIFMoWIvlB71wkzDJPfsx2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9K5xwYf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9K5xwYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790773730; x=1822309730;
  h=date:from:to:cc:subject:message-id;
  bh=j33hMxGjbH/FnnurTcr/ZCJSdBNWm0DsnhhfrML3Od0=;
  b=Q9K5xwYftmE10q86J2WfCED4vwFBVff2i0vBml/GVfxeDAfd6tl4Ny80
   4OlXXTLyhblFadRTZnGP9TSE9is1Aha4LYVskgO2E+9HZPNcy5DxGp2Aw
   vpTKABUR+gC0FUjjo5TMdg9VMqmmv+SxhUEQ9w7SsTIHY6U7aJQru/kR+
   JDzfmSSdLLFCjN6WtxShbCn2tKfuuCTD+8xFpZshXqvxCcTewRZe58PQ2
   ZjZc6bqUqA383fng/5QOA46kZtLNEampgKZn5Cq7ZM2l7fZDl32gCgBqp
   +s+OpfAQeg/sp6FQbC151mTw/Ct/HqvX66vkUbijCEkoLLHA1eI/JfXFe
   Q==;
X-CSE-ConnectionGUID: paDio7L2Tfy/cgS6ycZAcQ==
X-CSE-MsgGUID: kjTPvvRXQ8e2hTqEdwhmAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79077097"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79077097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 06:08:43 -0700
X-CSE-ConnectionGUID: PvS2s+3aS4i/G0ubGhj+kA==
X-CSE-MsgGUID: gDCRVRdwQTGc7V0bCnq6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275824560"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Sep 2026 06:08:41 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBu35-00000000QeV-0vPP;
	Wed, 30 Sep 2026 13:08:39 +0000
Date: Wed, 30 Sep 2026 21:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 71392a644e88c6bb921cdf12cb2b00adec070fe4
Message-ID: <202609302154.HfcPzMZn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 71392a644e88c6bb921cdf12cb2b00adec070fe4  Merge branch 'for-7.4/cxl-misc' into cxl-for-next

elapsed time: 813m

configs tested: 351
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2300-20260930    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1000-20260930    gcc-13.4.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2104-20260930    gcc-12     cocci
arc                  randconfig-r2107-20260930    gcc-8.5.0  cocci
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                          at91_dt_defconfig    clang-17
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                    milbeaut_m10v_defconfig    clang-17
arm                             mmp2_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260930    clang-24
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-10.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    clang-17
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-13.4.0
arm                  randconfig-r2309-20260930    gcc-8.5.0  sparse
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    clang-24
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    clang-24
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    clang-24
arm64                 randconfig-1003-20260930    gcc-16.1.0
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-9.5.0
csky                  randconfig-1001-20260930    gcc-16.1.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2102-20260930    clang-24   cocci
hexagon              randconfig-r2304-20260930    gcc-8.5.0  sparse
i386                              alldefconfig    gcc-16.1.0
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260930    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    clang-22
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1007-20260930    gcc-14
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1010-20260930    gcc-14
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1011-20260930    gcc-14
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1012-20260930    gcc-14
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260930    gcc-14     sparse
i386                  randconfig-2301-20260930    clang-22   sparse
i386                  randconfig-2302-20260930    gcc-14     sparse
i386                 randconfig-r2103-20260930    gcc-14     cocci
i386                 randconfig-r2105-20260930    gcc-12     cocci
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch             randconfig-1001-20260930    gcc-16.1.0
loongarch            randconfig-r2102-20260930    gcc-9.5.0  cocci
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                        bvme6000_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2202-20260930    gcc-15.2.0 smatch
m68k                 randconfig-r2305-20260930    gcc-14.3.0 sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2103-20260930    gcc-9.5.0  cocci
microblaze           randconfig-r2104-20260930    gcc-8.5.0  cocci
microblaze           randconfig-r2305-20260930    gcc-8.5.0  sparse
microblaze           randconfig-r2308-20260930    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                          bigsur_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                           malta_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    gcc-16.1.0
mips                 randconfig-r2202-20260930    gcc-16.1.0 smatch
mips                 randconfig-r2303-20260930    clang-24   sparse
mips                 randconfig-r2306-20260930    clang-17   sparse
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1000-20260930    gcc-11.5.0
nios2                 randconfig-1001-20260930    clang-24
nios2                 randconfig-1001-20260930    gcc-11.5.0
nios2                randconfig-r2100-20260930    gcc-11.5.0 cocci
nios2                randconfig-r2106-20260930    gcc-12     cocci
nios2                randconfig-r2201-20260930    gcc-11.5.0 smatch
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2302-20260930    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-11.5.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2107-20260930    gcc-12     cocci
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    clang-20
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    clang-19
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2105-20260930    gcc-11.5.0 cocci
powerpc              randconfig-r2307-20260930    clang-24   sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc                         warp_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    clang-24
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2106-20260930    gcc-11.5.0 cocci
powerpc64            randconfig-r2200-20260930    gcc-8.5.0  smatch
powerpc64            randconfig-r2301-20260930    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-8.5.0
riscv                 randconfig-1001-20260930    clang-17
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2000-20260930    gcc-15.2.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260930    gcc-8.5.0
riscv                randconfig-r2101-20260930    clang-24   cocci
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    clang-24
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    clang-18
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260930    clang-24
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                  randconfig-2001-20260930    gcc-8.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                              espt_defconfig    gcc-16.1.0
sh                           r7785rp_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-13.4.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260930    gcc-12.5.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1000-20260930    gcc-8.5.0
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-1001-20260930    gcc-11.5.0
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2000-20260930    gcc-14.3.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260930    gcc-8.5.0
sparc                randconfig-r2301-20260930    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1000-20260930    gcc-8.5.0
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2000-20260930    gcc-8.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260930    gcc-9.5.0
sparc64              randconfig-r2304-20260930    clang-20   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1000-20260930    gcc-14
um                    randconfig-1001-20260930    clang-22
um                    randconfig-1001-20260930    gcc-14
um                    randconfig-2000-20260930    clang-24
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260930    clang-24
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2200-20260930    clang-24   smatch
um                   randconfig-r2303-20260930    gcc-8.5.0  sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1000-20260930    gcc-14
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    gcc-14
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    gcc-14
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    gcc-14
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    clang-22
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    clang-22
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    clang-22
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-13
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    clang-22
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    clang-22
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    clang-22
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    clang-22
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1014-20260930    gcc-14
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1016-20260930    gcc-14
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2102-20260930    gcc-14     cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260930    clang-22   sparse
x86_64                randconfig-2301-20260930    gcc-14     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1000-20260930    gcc-15.2.0
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-1001-20260930    gcc-8.5.0
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2000-20260930    gcc-12.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0
xtensa               randconfig-r2100-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2101-20260930    gcc-9.5.0  cocci
xtensa               randconfig-r2201-20260930    gcc-10.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
