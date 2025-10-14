Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEF2E5B13
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433911; cv=none; b=nbYIdJBqO3HZVLsqKlSgH380RqBGnxRRUzAmlw08/aZTYvCdWIY2+BmBVDy2cQ4z/DQN/30zlp3cMyyNdOmU/eNV95Kl2jCfhu+FjLE5NraMlIfuGRwgbpioKbP2WREkTY2KYVJG0cfs+PmttgKALY+oWUl84kh7lLVLFxy/Jpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433911; c=relaxed/simple;
	bh=8QMMpmdY/r4a2u/rjn6dcZPQoko+sb1u8gQ2cngsQKk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=khVWMDSJli6YTYN+mq2LT5GRI3hKjJ1YEynvxmcra6UuSF5Z0Yu6L5K1+S6BBWVEufhiFnFyIDErUN+PQN6hrcUZJdC9G3AQsYJsYhfsaAbbF0iyxa6xEErdRxErUpf1S723DALBWX4U22TzITw/iwgGCN5C3IhE/noWPWUbVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wsaucgcf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wsaucgcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760433909; x=1791969909;
  h=date:from:to:cc:subject:message-id;
  bh=8QMMpmdY/r4a2u/rjn6dcZPQoko+sb1u8gQ2cngsQKk=;
  b=WsaucgcfrshqD1dcI5wpiyX/bvrjan26El/vHoD407aSTOSEhqyxZu1R
   eVvSW22cHu9BU68VOXgkfIthSCuuDumCRqmKSJ1rWW2Hp7xYEo59fvL00
   kvX6fZrWD5jryc/aO8Tmh6KH7CSwpWdmqR/a+AECfzkGV8Mng+izV6y6x
   6pJOJ1UtPIUKpRc073N7+noilPjsDdQxo37TbObcMZiBHspkTi+TipFNm
   ATTTJksGrS2ryQ2uVhUI9hlTiY87z5iQwmdbRN2z1o5Ouga+f6BzJbrgz
   44iMTyWkPn8XLIWopaPgQHDkKN5mV0gqzrKc5nJllo5mqOWptFwH0jAtC
   w==;
X-CSE-ConnectionGUID: /qPNCApuRsa0zB7czXVNJA==
X-CSE-MsgGUID: CduWJcEaQoeNx9q8rLQTSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62628869"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62628869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 02:25:09 -0700
X-CSE-ConnectionGUID: rAkVeu2TTRykDspVFgGjlw==
X-CSE-MsgGUID: 81RbmdvgRima9ZXcarabqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="212454565"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Oct 2025 02:25:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8bHE-0002ax-1p;
	Tue, 14 Oct 2025 09:25:04 +0000
Date: Tue, 14 Oct 2025 17:24:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 0d9320bf34133feeb5048ccfd90d01ea7ba500ba
Message-ID: <202510141708.1bqxkfxd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 0d9320bf34133feeb5048ccfd90d01ea7ba500ba  cxl: Fix match_region_by_range() to use region_res_match_cxl_range()

elapsed time: 729m

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
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251014    gcc-15.1.0
arc                   randconfig-002-20251014    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251014    gcc-15.1.0
arm                   randconfig-002-20251014    gcc-13.4.0
arm                   randconfig-003-20251014    clang-16
arm                   randconfig-004-20251014    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251014    gcc-9.5.0
arm64                 randconfig-002-20251014    gcc-10.5.0
arm64                 randconfig-003-20251014    gcc-14.3.0
arm64                 randconfig-004-20251014    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251014    gcc-15.1.0
csky                  randconfig-002-20251014    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251014    clang-22
hexagon               randconfig-002-20251014    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251014    gcc-14
i386        buildonly-randconfig-002-20251014    clang-20
i386        buildonly-randconfig-003-20251014    clang-20
i386        buildonly-randconfig-004-20251014    gcc-14
i386        buildonly-randconfig-005-20251014    gcc-14
i386        buildonly-randconfig-006-20251014    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251014    clang-18
loongarch             randconfig-002-20251014    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251014    gcc-11.5.0
nios2                 randconfig-002-20251014    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251014    gcc-11.5.0
parisc                randconfig-002-20251014    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251014    gcc-9.5.0
powerpc               randconfig-002-20251014    clang-22
powerpc               randconfig-003-20251014    gcc-14.3.0
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251014    gcc-8.5.0
powerpc64             randconfig-002-20251014    gcc-8.5.0
powerpc64             randconfig-003-20251014    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251014    gcc-10.5.0
riscv                 randconfig-002-20251014    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251014    clang-22
s390                  randconfig-002-20251014    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251014    gcc-14.3.0
sh                    randconfig-002-20251014    gcc-11.5.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251014    gcc-15.1.0
sparc                 randconfig-002-20251014    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251014    clang-20
sparc64               randconfig-002-20251014    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251014    gcc-14
um                    randconfig-002-20251014    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251014    gcc-14
x86_64      buildonly-randconfig-002-20251014    clang-20
x86_64      buildonly-randconfig-003-20251014    gcc-14
x86_64      buildonly-randconfig-004-20251014    clang-20
x86_64      buildonly-randconfig-005-20251014    clang-20
x86_64      buildonly-randconfig-006-20251014    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251014    gcc-8.5.0
xtensa                randconfig-002-20251014    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
