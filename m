Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8B1B423D
	for <linux-cxl@vger.kernel.org>; Sat, 24 May 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748088295; cv=none; b=ZXStiWEb0xGCRuVjIlDO4VHkFmJ372Za58S/Jz4cCnb3WZ3jx++hE+HIL4kH+MJI/ESNrwa3xZABl8VDMfPrzW5/OsxAjo177YXjfyx8M4qgKRxSlbB4WmlNPyl/KSmyI2IREsyIi70xviRf4ab3BD9BCJt8BEDvzNKmeVVT5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748088295; c=relaxed/simple;
	bh=+/GbawEAoSqbnUxISSR6jiEZOrL7DlkOTgtLKPi3uuw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CJNbQTKUVrzNDf/KT7f/YTeFo42Bz/Kn7zWNEpAjoSfvZ/RcbaT0OXy5SwcT9EYauDvDVXHwrZqvbytqDYD3YHe8vG6kF01jJHN7vWkO8o20+UDckP4IJfIDMVsOd/iSc2S7KmDMMXIKGwfUMG6XKXbFpbO2SB+MsF8DCTLiS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfzHEqxG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfzHEqxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748088294; x=1779624294;
  h=date:from:to:cc:subject:message-id;
  bh=+/GbawEAoSqbnUxISSR6jiEZOrL7DlkOTgtLKPi3uuw=;
  b=dfzHEqxG90Usro4mTVA5vnZnK2/XGB+iL10sSgh7fL+3hBcHgzFrJa+x
   iTWh42dO5wxvvmbixSt8nOA8LMG/xyOxnzjzBfdF888tj4ojRBbDefjMO
   /v0b6RVr10KN3xNGVZf56klKMdLji1KyS43dKxCm2fSNNIDLvgeF52HwV
   9SQFWD6gV8U7XOemcQbBqpOlDOZSU7CmoOyiPJuyU1kGIHgzWdEBqyl9z
   H1NErT9GpSidY66N63CUhBScTlWN1VkoOD14MQct1dfhoFDLkLN+aI9Gf
   SQkldWcJbJ5PfpT/YW/THnzFsFAbntkWoc/hqNIBkIkX0PCVAc2wvKy5s
   g==;
X-CSE-ConnectionGUID: ww/k8jw+Q/K0k6A/mC2/iQ==
X-CSE-MsgGUID: VkRDEOobSQar4xfp5gmF1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61480867"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="61480867"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 05:04:53 -0700
X-CSE-ConnectionGUID: tuZEpvErS6WghZwDcGOxlw==
X-CSE-MsgGUID: xCumPnhMQzOT4BUYS/Yl+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="145494440"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 May 2025 05:04:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIncP-000RBM-0R;
	Sat, 24 May 2025 12:04:49 +0000
Date: Sat, 24 May 2025 20:04:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 9f153b7fb5ae45c7d426851f896487927f40e501
Message-ID: <202505242024.hBAqwvVY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 9f153b7fb5ae45c7d426851f896487927f40e501  Merge branch 'for-6.16/cxl-features-ras' into cxl-for-next

elapsed time: 890m

configs tested: 141
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250524    gcc-15.1.0
arc                   randconfig-002-20250524    gcc-15.1.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                         lpc18xx_defconfig    clang-21
arm                   randconfig-001-20250524    gcc-7.5.0
arm                   randconfig-002-20250524    gcc-7.5.0
arm                   randconfig-003-20250524    clang-20
arm                   randconfig-004-20250524    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250524    gcc-5.5.0
arm64                 randconfig-002-20250524    gcc-7.5.0
arm64                 randconfig-003-20250524    clang-19
arm64                 randconfig-004-20250524    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250524    gcc-11.5.0
csky                  randconfig-002-20250524    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250524    clang-21
hexagon               randconfig-002-20250524    clang-21
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250524    clang-20
i386        buildonly-randconfig-002-20250524    gcc-12
i386        buildonly-randconfig-003-20250524    gcc-12
i386        buildonly-randconfig-004-20250524    gcc-12
i386        buildonly-randconfig-005-20250524    clang-20
i386        buildonly-randconfig-006-20250524    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250524    gcc-13.3.0
loongarch             randconfig-002-20250524    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250524    gcc-13.3.0
nios2                 randconfig-002-20250524    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250524    gcc-6.5.0
parisc                randconfig-002-20250524    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
powerpc               randconfig-001-20250524    gcc-5.5.0
powerpc               randconfig-002-20250524    gcc-7.5.0
powerpc               randconfig-003-20250524    clang-21
powerpc                     skiroot_defconfig    clang-21
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250524    gcc-7.5.0
powerpc64             randconfig-002-20250524    gcc-10.5.0
powerpc64             randconfig-003-20250524    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250524    clang-21
riscv                 randconfig-002-20250524    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250524    clang-17
s390                  randconfig-002-20250524    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                    randconfig-001-20250524    gcc-13.3.0
sh                    randconfig-002-20250524    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250524    gcc-6.5.0
sparc                 randconfig-002-20250524    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250524    gcc-8.5.0
sparc64               randconfig-002-20250524    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250524    gcc-12
um                    randconfig-002-20250524    clang-21
um                           x86_64_defconfig    clang-21
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250524    gcc-12
x86_64      buildonly-randconfig-002-20250524    gcc-12
x86_64      buildonly-randconfig-003-20250524    gcc-12
x86_64      buildonly-randconfig-004-20250524    gcc-12
x86_64      buildonly-randconfig-005-20250524    gcc-11
x86_64      buildonly-randconfig-006-20250524    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250524    gcc-8.5.0
xtensa                randconfig-002-20250524    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
