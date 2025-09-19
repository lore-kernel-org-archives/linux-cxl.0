Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE619755B
	for <linux-cxl@vger.kernel.org>; Fri, 19 Sep 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279387; cv=none; b=YlduhmUQRAradykaE/fHCsLd6y6CcakIA1FljRTKfqtdURRX2t/tN8Yb5LmVrirjLC7PKy7aedvQKHqMXPEBlNd5x8u+a4ZMGNCrxbjc37wW6KOqgeTsjtYnd2vLcb214995uRWqDC1hughtuxJKdjzH60lPP3TCALZcFHDh/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279387; c=relaxed/simple;
	bh=Y5qZrRpeYCuCKQclnW17M2ROywODQXhKx9nlWrW2Sis=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UFYhmufztLEBgtED+HHgWgdH+6XyLh8EX3Lfl1JV7sciCa9emsEigSri0wa4+OUQCvtgHPz7JFRmuKsKSJNOljIUc3IAgTTv32bZd0x5/ItpaLF3WweS3szyGJuSITYpKrAkDjVNRVBdebHl9Vy+8Pfluhfzzbhm+5voWPKqGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/IVdPVc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/IVdPVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758279384; x=1789815384;
  h=date:from:to:cc:subject:message-id;
  bh=Y5qZrRpeYCuCKQclnW17M2ROywODQXhKx9nlWrW2Sis=;
  b=D/IVdPVc7zR3iqf6JMb00jvUakDR0dTLF40rKK0FY5lkpj5oK2RxJck0
   HyP/yqIqAjTqPka/MeRcjf3HnYTuEj36Sdrfjj+Lz4IwUm7GyRZrDpaVB
   lTtv0CM3EFIzZnXzhHlYTRygv42SonMppUtz9HYN43bviFmONa3gz99w7
   pTjevOAA7/VXMN7enqpEQTijwQDxmDO1vRPiudEJds31uS1jc0FD/QsZW
   18XtgiR3oyOcHhXzTBMJeQpQbgYJBtMjdyjfToByjPy0wXgOr0akkdKKq
   B2If0lOcGuIDbMjX9h8u31R/luCLwghLBgMeZwNkUPqbcZg0xp6f73nTL
   w==;
X-CSE-ConnectionGUID: Okr7V/18TnKodf4wFD42Ng==
X-CSE-MsgGUID: qswYCnJeSWKknHMq4Vly6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60555253"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60555253"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 03:56:23 -0700
X-CSE-ConnectionGUID: 5k9L8GDTToCi5cEpqbyQ0w==
X-CSE-MsgGUID: FyhzRtfDSjODCOTLzFPeXw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Sep 2025 03:56:22 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzYmq-0004Dz-0G;
	Fri, 19 Sep 2025 10:56:20 +0000
Date: Fri, 19 Sep 2025 18:56:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 46037455cbb748c5e85071c95f2244e81986eb58
Message-ID: <202509191855.59rDzWMt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 46037455cbb748c5e85071c95f2244e81986eb58  Merge branch 'for-6.18/cxl-delay-dport' into cxl-for-next

elapsed time: 731m

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
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250919    gcc-15.1.0
arc                   randconfig-002-20250919    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20250919    gcc-12.5.0
arm                   randconfig-002-20250919    gcc-10.5.0
arm                   randconfig-003-20250919    gcc-12.5.0
arm                   randconfig-004-20250919    clang-22
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250919    gcc-15.1.0
arm64                 randconfig-002-20250919    gcc-8.5.0
arm64                 randconfig-003-20250919    gcc-12.5.0
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250919    gcc-14.3.0
csky                  randconfig-002-20250919    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250919    clang-20
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250919    clang-20
i386        buildonly-randconfig-006-20250919    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250919    gcc-15.1.0
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250919    gcc-10.5.0
nios2                 randconfig-002-20250919    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250919    gcc-15.1.0
parisc                randconfig-002-20250919    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250919    gcc-10.5.0
powerpc               randconfig-002-20250919    gcc-8.5.0
powerpc               randconfig-003-20250919    clang-18
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250919    gcc-8.5.0
powerpc64             randconfig-002-20250919    gcc-13.4.0
powerpc64             randconfig-003-20250919    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250919    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250919    gcc-12.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250919    gcc-14.3.0
sparc                 randconfig-002-20250919    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250919    clang-22
sparc64               randconfig-002-20250919    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250919    gcc-12
um                    randconfig-002-20250919    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    gcc-14
x86_64      buildonly-randconfig-003-20250919    gcc-14
x86_64      buildonly-randconfig-004-20250919    clang-20
x86_64      buildonly-randconfig-005-20250919    clang-20
x86_64      buildonly-randconfig-006-20250919    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250919    gcc-11.5.0
xtensa                randconfig-002-20250919    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
