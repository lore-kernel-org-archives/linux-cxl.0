Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BCA1E51D
	for <linux-cxl@vger.kernel.org>; Sat,  9 Nov 2024 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731131858; cv=none; b=XCyi3AsnN8uRmQdLa93jm7tTTLhemxHme0zvkZ/XIb8bcmmEtyCnaJi83jYrdeupn5pSVAKYIlxiaK1/tODfw9Lw2Md2YITUDIdfNYN00jS2z2Xc7YZGjsVp3UyHah+nRFX0/AbjEV0WHvaBZkV3BBkR9cOoJMKR11XR6b6URQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731131858; c=relaxed/simple;
	bh=u0v77MDUv1h4H/HE2LV6DHvJbul2UNLrAU3KL8KqFEs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h9hVxNZ5JUn8p96OIcOCRGrVdoxyD6aozZLJGs3zdc8DJCHiLd0x83bAoQVE6rXgwTD5xpJflJ2Y0WJqawoW559oCMf4ZK1L6qf1+oKYfNEoT/X6Bzm6G9BapPnhIVxoBbAlTNncT02EgVEAigBeDHwl3bIpNq0LBkLjSyqXXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ6cAx8J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ6cAx8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731131856; x=1762667856;
  h=date:from:to:cc:subject:message-id;
  bh=u0v77MDUv1h4H/HE2LV6DHvJbul2UNLrAU3KL8KqFEs=;
  b=VZ6cAx8JnxCk/2RZAmU7HLDMU8p2s5aGB0WKaTrZPPuswLyoXa7K7BXq
   vQy0e57h02kjhBaElBayzwD6iGr1Oc4BLoTdVLqRVcFIUv5RG3HAaccW+
   eyaroSteN4xUbgmUjGyKPCHe0ImBYA3hqUoYRI1bW6pHugSJ1LtE/hkSr
   6VM0B/AE79PJOhL/ULWK8MeOJDYqlNygmqX6FvRUDTMs04QSTTI+jQpv0
   4nieS9uG2gw9AE940hMfE5pL6X16GkQ3iA0jfJ8IzIaJkdHzpPhWjBLsy
   AIr0aGJ8vNT8O2MB7GVP45iokAOiEkkGJ2xctIKfiKBaaIGrwEcoy6zdW
   Q==;
X-CSE-ConnectionGUID: u0G/fsz5QdKxNdc7YTyCMw==
X-CSE-MsgGUID: euouzs3XRt6zYv8pNxdPPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30434150"
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="30434150"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 21:57:36 -0800
X-CSE-ConnectionGUID: wd0w1nMDQwK2LyUq8lb7xg==
X-CSE-MsgGUID: mSAdKwcPTyWXmVFPtM0T8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="85832992"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2024 21:57:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9eTT-000s7S-2P;
	Sat, 09 Nov 2024 05:57:31 +0000
Date: Sat, 09 Nov 2024 13:56:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 a83383e2ae7c499ff7b318945d9b2fe4e3006c2c
Message-ID: <202411091342.TqSEnfbw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: a83383e2ae7c499ff7b318945d9b2fe4e3006c2c  Merge branch 'cxl/for-6.13/dcd-prep' into cxl-for-next

elapsed time: 722m

configs tested: 271
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    clang-14
arc                        nsimosci_defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20241109    gcc-13.2.0
arc                   randconfig-002-20241109    gcc-13.2.0
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-20
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-17
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-16
arm                            mps2_defconfig    gcc-14.2.0
arm                        neponset_defconfig    clang-14
arm                            qcom_defconfig    gcc-14.2.0
arm                   randconfig-001-20241109    gcc-14.2.0
arm                   randconfig-002-20241109    clang-16
arm                   randconfig-003-20241109    clang-20
arm                   randconfig-004-20241109    gcc-14.2.0
arm                        realview_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm                           u8500_defconfig    clang-14
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241109    clang-14
arm64                 randconfig-002-20241109    gcc-14.2.0
arm64                 randconfig-003-20241109    clang-20
arm64                 randconfig-004-20241109    clang-14
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241109    gcc-14.2.0
csky                  randconfig-002-20241109    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-002-20241109    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241109    clang-19
i386        buildonly-randconfig-001-20241109    gcc-12
i386        buildonly-randconfig-002-20241109    clang-19
i386        buildonly-randconfig-003-20241109    clang-19
i386        buildonly-randconfig-003-20241109    gcc-12
i386        buildonly-randconfig-004-20241109    clang-19
i386        buildonly-randconfig-004-20241109    gcc-12
i386        buildonly-randconfig-005-20241109    clang-19
i386        buildonly-randconfig-006-20241109    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241109    clang-19
i386                  randconfig-002-20241109    clang-19
i386                  randconfig-003-20241109    clang-19
i386                  randconfig-003-20241109    gcc-12
i386                  randconfig-004-20241109    clang-19
i386                  randconfig-005-20241109    clang-19
i386                  randconfig-006-20241109    clang-19
i386                  randconfig-011-20241109    clang-19
i386                  randconfig-011-20241109    gcc-12
i386                  randconfig-012-20241109    clang-19
i386                  randconfig-013-20241109    clang-19
i386                  randconfig-014-20241109    clang-19
i386                  randconfig-015-20241109    clang-19
i386                  randconfig-015-20241109    gcc-11
i386                  randconfig-016-20241109    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241109    gcc-14.2.0
loongarch             randconfig-002-20241109    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    clang-14
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    clang-20
mips                        qi_lb60_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-14
mips                           xway_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241109    gcc-14.2.0
nios2                 randconfig-002-20241109    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    clang-14
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241109    gcc-14.2.0
parisc                randconfig-002-20241109    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-14
powerpc                     ep8248e_defconfig    clang-14
powerpc                        fsp2_defconfig    clang-14
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-14
powerpc                  iss476-smp_defconfig    clang-20
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                     mpc512x_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-14
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-14
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                  mpc885_ads_defconfig    clang-14
powerpc               randconfig-001-20241109    gcc-14.2.0
powerpc               randconfig-002-20241109    clang-16
powerpc               randconfig-003-20241109    clang-20
powerpc                     redwood_defconfig    clang-14
powerpc                 xes_mpc85xx_defconfig    clang-20
powerpc64             randconfig-001-20241109    clang-20
powerpc64             randconfig-002-20241109    gcc-14.2.0
powerpc64             randconfig-003-20241109    gcc-14.2.0
riscv                            alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-20
riscv                 randconfig-001-20241109    gcc-14.2.0
riscv                 randconfig-002-20241109    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241109    gcc-14.2.0
s390                  randconfig-002-20241109    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    clang-20
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241109    gcc-14.2.0
sh                    randconfig-002-20241109    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    clang-20
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241109    gcc-14.2.0
sparc64               randconfig-002-20241109    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241109    clang-16
um                    randconfig-002-20241109    clang-20
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241109    gcc-12
x86_64      buildonly-randconfig-002-20241109    clang-19
x86_64      buildonly-randconfig-002-20241109    gcc-12
x86_64      buildonly-randconfig-003-20241109    clang-19
x86_64      buildonly-randconfig-003-20241109    gcc-12
x86_64      buildonly-randconfig-004-20241109    clang-19
x86_64      buildonly-randconfig-004-20241109    gcc-12
x86_64      buildonly-randconfig-005-20241109    gcc-12
x86_64      buildonly-randconfig-006-20241109    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241109    clang-19
x86_64                randconfig-001-20241109    gcc-12
x86_64                randconfig-002-20241109    clang-19
x86_64                randconfig-002-20241109    gcc-12
x86_64                randconfig-003-20241109    gcc-12
x86_64                randconfig-004-20241109    gcc-12
x86_64                randconfig-005-20241109    clang-19
x86_64                randconfig-005-20241109    gcc-12
x86_64                randconfig-006-20241109    gcc-12
x86_64                randconfig-011-20241109    clang-19
x86_64                randconfig-011-20241109    gcc-12
x86_64                randconfig-012-20241109    gcc-12
x86_64                randconfig-013-20241109    clang-19
x86_64                randconfig-013-20241109    gcc-12
x86_64                randconfig-014-20241109    gcc-12
x86_64                randconfig-015-20241109    clang-19
x86_64                randconfig-015-20241109    gcc-12
x86_64                randconfig-016-20241109    gcc-12
x86_64                randconfig-071-20241109    clang-19
x86_64                randconfig-071-20241109    gcc-12
x86_64                randconfig-072-20241109    clang-19
x86_64                randconfig-072-20241109    gcc-12
x86_64                randconfig-073-20241109    clang-19
x86_64                randconfig-073-20241109    gcc-12
x86_64                randconfig-074-20241109    clang-19
x86_64                randconfig-074-20241109    gcc-12
x86_64                randconfig-075-20241109    clang-19
x86_64                randconfig-075-20241109    gcc-12
x86_64                randconfig-076-20241109    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241109    gcc-14.2.0
xtensa                randconfig-002-20241109    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
