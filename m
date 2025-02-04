Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0F1F8EF5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738653211; cv=none; b=NtkF/Jhj/L5q2Noz864GE1GB7RrZLFXlAdzDfI4UYkhVLJupYRNaM2Ldo2qeczXgiB0jLuKtHsAhfGnp/xvtrG9Y2iuFbT1ONHg+Qly2BUGKEMjw/JwCpkoidCTHWeuRUDZ9XshvKuOKq/JAvxRFXsmQHwQdaW6MwxX5JzMz6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738653211; c=relaxed/simple;
	bh=uPpvid7cSZ8Lp3bu4FWUcdqY5zwPCcqhT/Uw0C1O1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hr597GJAu/7z80xgHe7/4Dl7oaT246PWARXJvV4sts2TDmpi74s/7+pxd5RyVAa2/GyXesO3BFpdrN1x1yWM7zDya8kcsz9NcSdbH6gT74U49f8EqEyF9WIdGd9wYx9TRLTPoEQXIu38AlPeWzHmnkljrgFwVmIbXDs1d/VIF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6eOr2US; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6eOr2US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738653209; x=1770189209;
  h=date:from:to:cc:subject:message-id;
  bh=uPpvid7cSZ8Lp3bu4FWUcdqY5zwPCcqhT/Uw0C1O1Ok=;
  b=i6eOr2USPD5EwythPUMRuYj9uasHsHeTaiUayt/xSYKfiFKRuhslalum
   V6W0kohqolsyDfVVTtKNketYbMYdKQvS7qhZ0Jq+Ic1Gn+WFeVkRrBc+L
   PtAv75ukUNodRDH/tyEUK9iqGYuTiYdMsICMv5671FCu04w/RZ7+3Chbo
   B49gJ/XKzWqK7ynOfrcShP6SlCXPnGggiEnvvcaZkQfJftiDSNMxvYIlT
   8Vadszj21HLrh0/kn5YjfV/eo5z97rjbJ8FSHDQCiRf95eCJVb1DUbKIP
   72sAr/HTGOCu2TGie9EOTeaNIrARs7NgShc81QBtQOu8elTWYy4NMZAwe
   g==;
X-CSE-ConnectionGUID: 25DQByMqQv2wu8xA0jOHlQ==
X-CSE-MsgGUID: fkk9OKtsQ/WkFKBl+YUneg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="50556234"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="50556234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 23:13:29 -0800
X-CSE-ConnectionGUID: nB7oNEl+SNGpwCr69aUzaQ==
X-CSE-MsgGUID: cAZ5ykthTe+1zz93CuxLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="141390967"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2025 23:13:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfD7c-000s87-11;
	Tue, 04 Feb 2025 07:13:24 +0000
Date: Tue, 04 Feb 2025 15:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS WITH WARNING
 0fd158c1ea0cc70434a52b4b812cbec4579b9f66
Message-ID: <202502041532.hocFqC7R-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 0fd158c1ea0cc70434a52b4b812cbec4579b9f66  cxl/pci: Support Global Persistent Flush (GPF)

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502040454.Jtb55wW7-lkp@intel.com

    drivers/cxl/core/pci.c:1103:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((base), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (base)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    drivers/cxl/core/pci.c:1104:10: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((scale), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (scale)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-002-20250204
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- arm64-allmodconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- arm64-randconfig-002-20250204
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- powerpc-allyesconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- powerpc-randconfig-r121-20250204
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- riscv-allmodconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- riscv-allyesconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- s390-allmodconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- um-allmodconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
|-- x86_64-allyesconfig
|   |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
|   `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned
`-- x86_64-randconfig-161-20250204
    |-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((base)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned-
    `-- drivers-cxl-core-pci.c:warning:result-of-comparison-of-constant-with-expression-of-type-typeof-(_Generic((scale)-char:(unsigned-char)-unsigned-char:(unsigned-char)-signed-char:(unsigned-char)-unsigned

elapsed time: 801m

configs tested: 141
configs skipped: 7

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250204    gcc-13.2.0
arc                   randconfig-002-20250204    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20250204    clang-21
arm                   randconfig-002-20250204    clang-17
arm                   randconfig-003-20250204    clang-19
arm                   randconfig-004-20250204    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250204    clang-21
arm64                 randconfig-002-20250204    clang-21
arm64                 randconfig-003-20250204    clang-17
arm64                 randconfig-004-20250204    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250204    gcc-14.2.0
csky                  randconfig-002-20250204    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250204    clang-21
hexagon               randconfig-002-20250204    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250204    gcc-12
i386        buildonly-randconfig-002-20250204    clang-19
i386        buildonly-randconfig-003-20250204    clang-19
i386        buildonly-randconfig-004-20250204    gcc-12
i386        buildonly-randconfig-005-20250204    clang-19
i386        buildonly-randconfig-006-20250204    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250204    gcc-14.2.0
loongarch             randconfig-002-20250204    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                           ip32_defconfig    clang-21
mips                        omega2p_defconfig    clang-16
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250204    gcc-14.2.0
nios2                 randconfig-002-20250204    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250204    gcc-14.2.0
parisc                randconfig-002-20250204    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250204    gcc-14.2.0
powerpc               randconfig-002-20250204    gcc-14.2.0
powerpc               randconfig-003-20250204    clang-21
powerpc                     taishan_defconfig    clang-17
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-002-20250204    clang-19
powerpc64             randconfig-003-20250204    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250204    gcc-14.2.0
riscv                 randconfig-002-20250204    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250204    gcc-14.2.0
s390                  randconfig-002-20250204    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250204    gcc-14.2.0
sh                    randconfig-002-20250204    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250204    gcc-14.2.0
sparc                 randconfig-002-20250204    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250204    gcc-14.2.0
sparc64               randconfig-002-20250204    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250204    clang-21
um                    randconfig-002-20250204    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250204    clang-19
x86_64      buildonly-randconfig-002-20250204    clang-19
x86_64      buildonly-randconfig-003-20250204    clang-19
x86_64      buildonly-randconfig-004-20250204    gcc-11
x86_64      buildonly-randconfig-005-20250204    clang-19
x86_64      buildonly-randconfig-006-20250204    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250204    gcc-14.2.0
xtensa                randconfig-002-20250204    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
