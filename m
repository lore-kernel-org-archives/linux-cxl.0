Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4116C69E
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792832; cv=none; b=M2ypj4eh1CnexW93zzJmV6d+PQoDF2p0SfOvHYMW9rUpjR0kNaBCdWo5D+ij+6U/GXYak9Yw3OYymkL4/ZSaOZ0JVOQnBKJZC7yUnbkmz35EQVYceF/w+CfJdXhlBuGa1EsoIyQleNP6G8XXXwjePyi8vXnGE6z4KAjaMEeDzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792832; c=relaxed/simple;
	bh=0Lq/zWnaoeTj+mEdLrgzYT8eMmP6ufIRqhBSFVRoJwY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NzwzJMrNoUv9PdBRBe+COSZzzGbRmJFb/wDy03+DVXGHEvPP2GpWlCvn32vJ39AFGJLmkSuJxN+Tp4dNfUAHaSyVDKsGjR8AlUvyl/otC7OiONxPkKYnfPPytEvwe2v0e0Y5H7XDnUqb4tSpWl9K0zxzT4taiyPy1wDJa3NfUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cl7COIcX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cl7COIcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720792830; x=1752328830;
  h=date:from:to:cc:subject:message-id;
  bh=0Lq/zWnaoeTj+mEdLrgzYT8eMmP6ufIRqhBSFVRoJwY=;
  b=cl7COIcXR7LmUQBxTXsihvH9f0h7llzjbeUocWOqPKFQRNmQOZQ2KNcl
   YXXaTk/3oKoxMu0PzK/OU5e2jMT1LU6+SJH5sK6ZlZ/3g9x6hwjRcBpPZ
   lco8CnIulYEbliuWLFaiUKWTCoRWPEOVZoJ7QMFqQVzToGZFISWk/VbP+
   h9sbsJikZm+qnepBtaUMjsqayk2FQQnCyo/NECDnHey0neKdQFUShAwa+
   lEBF9bobKQdiqv3bJdXAMJVT+u+7N1iaGm8Cl2GfXn+7Cc62Fn3h6HkD7
   rnKUcMbJptETbB+AQFNNFkSYyXo6g7WSf5vh1gtQP9B5NF/SUpG1jYP1K
   Q==;
X-CSE-ConnectionGUID: cKjEJ4P8R+qrZKp29ia/Sg==
X-CSE-MsgGUID: nrHy1ZNzSBeCWsYnWjVxqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18375391"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18375391"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 07:00:29 -0700
X-CSE-ConnectionGUID: VDRQt4AYRFWof3FhWMudig==
X-CSE-MsgGUID: ABd9wG2qTLmm7jHabigkNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48826945"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2024 07:00:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSGoy-000apg-1T;
	Fri, 12 Jul 2024 14:00:24 +0000
Date: Fri, 12 Jul 2024 22:00:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 56478475560bde71dd3ef944b5013900272db273
Message-ID: <202407122207.t9JtYHqp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 56478475560bde71dd3ef944b5013900272db273  Merge branch 'for-6.11/xor_fixes' into cxl-for-next

elapsed time: 801m

configs tested: 280
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   clang-19
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                          exynos_defconfig   clang-17
arm                         lpc18xx_defconfig   clang-17
arm                         lpc18xx_defconfig   clang-19
arm                        multi_v7_defconfig   clang-17
arm                   randconfig-001-20240712   clang-19
arm                   randconfig-001-20240712   gcc-13.2.0
arm                   randconfig-002-20240712   clang-19
arm                   randconfig-002-20240712   gcc-13.2.0
arm                   randconfig-003-20240712   gcc-13.2.0
arm                   randconfig-003-20240712   gcc-14.1.0
arm                   randconfig-004-20240712   clang-15
arm                   randconfig-004-20240712   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240712   gcc-13.2.0
arm64                 randconfig-001-20240712   gcc-14.1.0
arm64                 randconfig-002-20240712   gcc-13.2.0
arm64                 randconfig-002-20240712   gcc-14.1.0
arm64                 randconfig-003-20240712   clang-19
arm64                 randconfig-003-20240712   gcc-13.2.0
arm64                 randconfig-004-20240712   clang-17
arm64                 randconfig-004-20240712   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240712   gcc-13.2.0
csky                  randconfig-001-20240712   gcc-14.1.0
csky                  randconfig-002-20240712   gcc-13.2.0
csky                  randconfig-002-20240712   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240712   clang-14
hexagon               randconfig-002-20240712   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-002-20240712   gcc-9
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-003-20240712   gcc-9
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-004-20240712   gcc-9
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-005-20240712   gcc-9
i386         buildonly-randconfig-006-20240712   clang-18
i386         buildonly-randconfig-006-20240712   gcc-9
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-001-20240712   gcc-9
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-002-20240712   gcc-9
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-003-20240712   gcc-9
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-004-20240712   gcc-9
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-005-20240712   gcc-9
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-006-20240712   gcc-9
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-011-20240712   gcc-9
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-012-20240712   gcc-9
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-013-20240712   gcc-9
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-014-20240712   gcc-9
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-9
i386                  randconfig-016-20240712   gcc-12
i386                  randconfig-016-20240712   gcc-9
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240712   gcc-13.2.0
loongarch             randconfig-001-20240712   gcc-14.1.0
loongarch             randconfig-002-20240712   gcc-13.2.0
loongarch             randconfig-002-20240712   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                        stmark2_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   clang-17
mips                           ci20_defconfig   clang-17
mips                     decstation_defconfig   gcc-13.2.0
mips                            gpr_defconfig   clang-19
mips                        omega2p_defconfig   clang-17
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
mips                   sb1250_swarm_defconfig   gcc-14.1.0
nios2                         10m50_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240712   gcc-13.2.0
nios2                 randconfig-001-20240712   gcc-14.1.0
nios2                 randconfig-002-20240712   gcc-13.2.0
nios2                 randconfig-002-20240712   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-13.2.0
parisc                randconfig-001-20240712   gcc-14.1.0
parisc                randconfig-002-20240712   gcc-13.2.0
parisc                randconfig-002-20240712   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                      acadia_defconfig   clang-19
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      cm5200_defconfig   clang-19
powerpc                        fsp2_defconfig   clang-17
powerpc                  iss476-smp_defconfig   gcc-14.1.0
powerpc                      mgcoge_defconfig   clang-19
powerpc                 mpc8313_rdb_defconfig   clang-17
powerpc                 mpc834x_itx_defconfig   clang-19
powerpc               randconfig-001-20240712   clang-15
powerpc               randconfig-001-20240712   gcc-13.2.0
powerpc               randconfig-002-20240712   clang-19
powerpc               randconfig-002-20240712   gcc-13.2.0
powerpc               randconfig-003-20240712   clang-19
powerpc               randconfig-003-20240712   gcc-13.2.0
powerpc64                        alldefconfig   clang-17
powerpc64             randconfig-001-20240712   clang-19
powerpc64             randconfig-001-20240712   gcc-13.2.0
powerpc64             randconfig-002-20240712   clang-19
powerpc64             randconfig-002-20240712   gcc-13.2.0
powerpc64             randconfig-003-20240712   gcc-13.2.0
powerpc64             randconfig-003-20240712   gcc-14.1.0
riscv                            alldefconfig   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240712   clang-19
riscv                 randconfig-001-20240712   gcc-13.2.0
riscv                 randconfig-002-20240712   gcc-13.2.0
riscv                 randconfig-002-20240712   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240712   gcc-13.2.0
s390                  randconfig-001-20240712   gcc-14.1.0
s390                  randconfig-002-20240712   gcc-13.2.0
s390                  randconfig-002-20240712   gcc-14.1.0
s390                       zfcpdump_defconfig   clang-17
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-13.2.0
sh                    randconfig-001-20240712   gcc-14.1.0
sh                    randconfig-002-20240712   gcc-13.2.0
sh                    randconfig-002-20240712   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-13.2.0
sparc64               randconfig-001-20240712   gcc-14.1.0
sparc64               randconfig-002-20240712   gcc-13.2.0
sparc64               randconfig-002-20240712   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240712   clang-19
um                    randconfig-001-20240712   gcc-13.2.0
um                    randconfig-002-20240712   clang-15
um                    randconfig-002-20240712   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   clang-17
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   clang-18
x86_64                randconfig-001-20240712   gcc-12
x86_64                randconfig-002-20240712   clang-18
x86_64                randconfig-002-20240712   gcc-13
x86_64                randconfig-003-20240712   clang-18
x86_64                randconfig-003-20240712   gcc-12
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   clang-18
x86_64                randconfig-005-20240712   gcc-13
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   clang-18
x86_64                randconfig-014-20240712   gcc-13
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   clang-18
x86_64                randconfig-071-20240712   gcc-13
x86_64                randconfig-072-20240712   clang-18
x86_64                randconfig-072-20240712   gcc-11
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   clang-18
x86_64                randconfig-074-20240712   gcc-9
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                          iss_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240712   gcc-13.2.0
xtensa                randconfig-001-20240712   gcc-14.1.0
xtensa                randconfig-002-20240712   gcc-13.2.0
xtensa                randconfig-002-20240712   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
