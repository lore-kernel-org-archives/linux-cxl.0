Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95761EB5C2
	for <linux-cxl@vger.kernel.org>; Tue,  6 Jan 2026 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729126; cv=none; b=TYxVB402YrwZchOJZD/siybDv3mH//QboT9eUXpUOFYq/zpN7CaMj3zBHM58T6uEFwk8xj9qu+c+ZcnkSsvh1HrumvIFxV/FSa8cr2tjDTdPfm27FwEureMTITFSAK7Vb78hCNiTWcOmQ8+Rxv12AztkOvF+cMeezKzBKlLiNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729126; c=relaxed/simple;
	bh=np/TbZzJD/kFZtKfLx0ry0Thl+ZihDAhVA54Z3K2l6I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E0im7KjW0uU0cOAto1BY6qDvPNcYEFd4t+UGZ7iYhxQEqxlT97QKj9BFuOe6EDb6pJLv2FLccMfXjJcjNEXTpVlbMw0zLK4eJxaNM8GlVTkq3cz0rcO+bw4DpKHNlFwUHhNCoLZsS9Kl9uFnqBAnOUIyoiF/MF01jtNl4H1SL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE4u6A8Q; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE4u6A8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767729125; x=1799265125;
  h=date:from:to:cc:subject:message-id;
  bh=np/TbZzJD/kFZtKfLx0ry0Thl+ZihDAhVA54Z3K2l6I=;
  b=nE4u6A8QsgQXNE8531aKBqVyxh5mwXz4PH9babcDYDHBdkMwqYVyhWZQ
   gU5aa9o5HZR9QbdZq8Rvh5X7Z4h0obTlDfOCIEbvhHBF2/D+RH5xbAf5+
   SCnEAwGmgmciI71b5AJJfKkl8dfDeDsHjc9/xl/ZDkxmNHoGn0ANutbuY
   BhmY1cDv6iOTy+gSbua8EA3LzLbTjxZ77azbP8Ag9VejRYq9IJg7+DtN/
   cSqIedPS22y5Vv1njZHe4RXh0Mt8gN04W3rS18pocgUTM8BK/e7vgwWBQ
   ilczTrtVOtl2QKmQaXZnGSRAmkq9F0xlVoiKXbDMFVlRnoY8635XfdnN4
   A==;
X-CSE-ConnectionGUID: cJ/oM6gOTPOiCCelojtuvg==
X-CSE-MsgGUID: RYtp8J57TA64gOjrNVsSaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="68295860"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="68295860"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 11:52:01 -0800
X-CSE-ConnectionGUID: MwgZ9LCkR7K1VpW0UJzbWA==
X-CSE-MsgGUID: /ShGjEDmRAm3xTfWNBcBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202498640"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Jan 2026 11:51:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdD5w-000000003BJ-2CxD;
	Tue, 06 Jan 2026 19:51:56 +0000
Date: Wed, 07 Jan 2026 03:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.0/cxl-init] BUILD SUCCESS
 29317f8dc6ed601ec54575689c2cd55cc470bcce
Message-ID: <202601070323.Hkv547Tl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.0/cxl-init
branch HEAD: 29317f8dc6ed601ec54575689c2cd55cc470bcce  cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation

elapsed time: 1437m

configs tested: 166
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
arc                   randconfig-001-20260106    gcc-13.4.0
arc                   randconfig-002-20260106    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260106    gcc-11.5.0
arm                   randconfig-002-20260106    clang-22
arm                   randconfig-003-20260106    gcc-10.5.0
arm                   randconfig-004-20260106    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260106    clang-22
arm64                 randconfig-002-20260106    gcc-8.5.0
arm64                 randconfig-003-20260106    gcc-9.5.0
arm64                 randconfig-004-20260106    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260106    gcc-10.5.0
csky                  randconfig-002-20260106    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260106    clang-22
hexagon               randconfig-002-20260106    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260106    clang-20
i386        buildonly-randconfig-002-20260106    clang-20
i386        buildonly-randconfig-003-20260106    gcc-14
i386        buildonly-randconfig-004-20260106    clang-20
i386        buildonly-randconfig-005-20260106    gcc-14
i386        buildonly-randconfig-006-20260106    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260106    clang-20
i386                  randconfig-002-20260106    gcc-14
i386                  randconfig-003-20260106    clang-20
i386                  randconfig-004-20260106    clang-20
i386                  randconfig-005-20260106    clang-20
i386                  randconfig-006-20260106    clang-20
i386                  randconfig-007-20260106    clang-20
i386                  randconfig-012-20260106    gcc-14
i386                  randconfig-013-20260106    gcc-14
i386                  randconfig-014-20260106    clang-20
i386                  randconfig-015-20260106    gcc-14
i386                  randconfig-016-20260106    clang-20
i386                  randconfig-017-20260106    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260106    gcc-15.1.0
loongarch             randconfig-002-20260106    gcc-15.1.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260106    gcc-8.5.0
nios2                 randconfig-002-20260106    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260106    gcc-8.5.0
parisc                randconfig-002-20260106    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20260106    clang-22
powerpc               randconfig-002-20260106    gcc-8.5.0
powerpc64             randconfig-001-20260106    gcc-8.5.0
powerpc64             randconfig-002-20260106    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260106    gcc-8.5.0
riscv                 randconfig-002-20260106    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260106    gcc-8.5.0
s390                  randconfig-002-20260106    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20260106    gcc-15.1.0
sh                    randconfig-002-20260106    gcc-10.5.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260106    gcc-11.5.0
sparc                 randconfig-002-20260106    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260106    clang-22
sparc64               randconfig-002-20260106    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260106    clang-22
um                    randconfig-002-20260106    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260106    clang-20
x86_64      buildonly-randconfig-002-20260106    gcc-14
x86_64      buildonly-randconfig-003-20260106    clang-20
x86_64      buildonly-randconfig-004-20260106    gcc-14
x86_64      buildonly-randconfig-005-20260106    clang-20
x86_64      buildonly-randconfig-006-20260106    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260106    gcc-14
x86_64                randconfig-002-20260106    gcc-14
x86_64                randconfig-003-20260106    clang-20
x86_64                randconfig-004-20260106    clang-20
x86_64                randconfig-005-20260106    gcc-14
x86_64                randconfig-006-20260106    gcc-14
x86_64                randconfig-011-20260106    gcc-14
x86_64                randconfig-012-20260106    gcc-13
x86_64                randconfig-013-20260106    gcc-14
x86_64                randconfig-014-20260106    gcc-14
x86_64                randconfig-015-20260106    clang-20
x86_64                randconfig-016-20260106    clang-20
x86_64                randconfig-071-20260106    gcc-14
x86_64                randconfig-072-20260106    clang-20
x86_64                randconfig-073-20260106    clang-20
x86_64                randconfig-074-20260106    clang-20
x86_64                randconfig-075-20260106    gcc-14
x86_64                randconfig-076-20260106    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20260106    gcc-8.5.0
xtensa                randconfig-002-20260106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
