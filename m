Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D07171CD
	for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601846; cv=none; b=Jgnn28+p4WrCqxhno4SOYDeo3FmMcW4js5bwzq0l/yV+kerw1Dj5aszVd/Ytd+iG88H7mZq/9kEMOi6Lz/ITNJjxMZJZC15GDvHxNXUbVWVgungbQFrywqq7wy7kDc9fxjjFc4xKCUl4eevOJk0VG8mT9KWHVfmtAr15yZPpc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601846; c=relaxed/simple;
	bh=WVekVFMr93gu7B7tQyDL7H4OOlLNiptTS2q6UXDprwQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f1pq7B/MtHDi4yBudDDwXMxSjwOEuycSou9OIR+Hvk+makFaRye3WojAG5WVeFu6UG1m8eO9ZASxozv+PUzHyNRCutcCXLAKN1PW9qANKWBnVG+YMNcFdmjTiZFDZzUODrSwt4QF1uoncJyWifHEiSTeS/CXpC9KBOwFSyGKID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzG24jaW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzG24jaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763601844; x=1795137844;
  h=date:from:to:cc:subject:message-id;
  bh=WVekVFMr93gu7B7tQyDL7H4OOlLNiptTS2q6UXDprwQ=;
  b=QzG24jaWHedWjRTzZy3BrUpkwP+OpQF47toOktiPkk/uMvykHivVBQyw
   siNX2gP+c1LJdgrHi/sWZMDuTMTprJy6VX9k8XW4QGcGLDeIBNsVIqEi7
   NJDIq3kuHkaQpnzVdTxhddVLNVWRYa1L3T1A4ZfbHXVhGtdWq8/SQUAE/
   KhH/SEYYy2t8/zPoD3vN7Lx+bVy0Yu08w34KAzjgNnqx8u+qro2pDg8L1
   9jkuG3pxhaKu8dpmtCIdThBifuNVtztWV8hcy2ZmAdIwi/cLUNwbf7Lnp
   ED0Ty775ag4O2BvXk8iMUbumOCgrszqVOSUsWXVgMPSn6GN3bdISf04Cx
   Q==;
X-CSE-ConnectionGUID: IU7HBKn6R6yJxvDRv2nv2A==
X-CSE-MsgGUID: Bhq89SSoQhyuNc70dM37Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83047702"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="83047702"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 17:24:04 -0800
X-CSE-ConnectionGUID: yDLyRmZzT629yBMAzSwQTg==
X-CSE-MsgGUID: GZd4m7ZgSkaHpv15gGuPQg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Nov 2025 17:24:01 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLtOx-0003UR-1v;
	Thu, 20 Nov 2025 01:23:59 +0000
Date: Thu, 20 Nov 2025 09:23:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 ea5514e300568cbe8f19431c3e424d4791db8291
Message-ID: <202511200914.cEG20WoQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: ea5514e300568cbe8f19431c3e424d4791db8291  Merge branch 'for-6.19/cxl-misc' into cxl-for-next

elapsed time: 1513m

configs tested: 172
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
arc                   randconfig-001-20251119    gcc-10.5.0
arc                   randconfig-002-20251119    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251119    gcc-8.5.0
arm                   randconfig-002-20251119    clang-16
arm                   randconfig-003-20251119    clang-22
arm                   randconfig-004-20251119    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251119    clang-22
arm64                 randconfig-002-20251119    gcc-8.5.0
arm64                 randconfig-003-20251119    clang-22
arm64                 randconfig-004-20251119    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251119    gcc-15.1.0
csky                  randconfig-002-20251119    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251119    gcc-14
i386        buildonly-randconfig-002-20251119    clang-20
i386        buildonly-randconfig-003-20251119    clang-20
i386        buildonly-randconfig-004-20251119    clang-20
i386        buildonly-randconfig-005-20251119    gcc-14
i386        buildonly-randconfig-006-20251119    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251119    clang-20
i386                  randconfig-002-20251119    clang-20
i386                  randconfig-003-20251119    clang-20
i386                  randconfig-004-20251119    clang-20
i386                  randconfig-005-20251119    clang-20
i386                  randconfig-006-20251119    gcc-14
i386                  randconfig-007-20251119    gcc-14
i386                  randconfig-011-20251119    clang-20
i386                  randconfig-012-20251119    clang-20
i386                  randconfig-013-20251119    clang-20
i386                  randconfig-014-20251119    gcc-14
i386                  randconfig-015-20251119    gcc-14
i386                  randconfig-016-20251119    clang-20
i386                  randconfig-017-20251119    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251119    gcc-8.5.0
parisc                randconfig-002-20251119    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251119    clang-16
powerpc               randconfig-002-20251119    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8548_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251119    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251119    gcc-15.1.0
riscv                 randconfig-002-20251119    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251119    gcc-8.5.0
s390                  randconfig-002-20251119    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251119    gcc-11.5.0
sh                    randconfig-002-20251119    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251119    gcc-15.1.0
sparc                 randconfig-002-20251119    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251119    gcc-15.1.0
sparc64               randconfig-002-20251119    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251119    clang-16
um                    randconfig-002-20251119    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251119    gcc-14
x86_64      buildonly-randconfig-002-20251119    gcc-14
x86_64      buildonly-randconfig-003-20251119    clang-20
x86_64      buildonly-randconfig-004-20251119    clang-20
x86_64      buildonly-randconfig-005-20251119    gcc-14
x86_64      buildonly-randconfig-006-20251119    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251119    clang-20
x86_64                randconfig-002-20251119    clang-20
x86_64                randconfig-003-20251119    gcc-14
x86_64                randconfig-004-20251119    gcc-14
x86_64                randconfig-005-20251119    gcc-14
x86_64                randconfig-006-20251119    clang-20
x86_64                randconfig-011-20251119    clang-20
x86_64                randconfig-012-20251119    clang-20
x86_64                randconfig-013-20251119    clang-20
x86_64                randconfig-014-20251119    gcc-14
x86_64                randconfig-015-20251119    clang-20
x86_64                randconfig-016-20251119    gcc-14
x86_64                randconfig-071-20251119    gcc-14
x86_64                randconfig-072-20251119    clang-20
x86_64                randconfig-073-20251119    gcc-12
x86_64                randconfig-074-20251119    clang-20
x86_64                randconfig-075-20251119    clang-20
x86_64                randconfig-076-20251119    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251119    gcc-8.5.0
xtensa                randconfig-002-20251119    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
