Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CA111A9
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jan 2024 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWTsJN7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704601019; x=1736137019;
  h=date:from:to:cc:subject:message-id;
  bh=oVY6mqPKsZQaGalkuluqhkAoLhQ+smGpnVqnOmDF+GA=;
  b=ZWTsJN7SUecgN99/3Ler8ZBTb//iDNyJgjOHQjnsVhmeF7MnDjVXqTYI
   kJ/VbK9WyEG4MBbwp3GwECSLdoncN4MiqGrWZ7tKh7viK1tDI0amE0E3A
   h/vgp3ZERHbcFfe8JtU4OtJPEflpK0VZ/i1FL83Qu4K/i2tTXUKrihCx8
   sZiHD6JHlz5W1OSyOtzsXIvmf+oN7jnSL4iVml95AOdhMxk+Iq6h7WzAy
   f00R3S7HHQYjrlRiEE0E5yo+uEz1ei0ARP11A9P2MgKjoIad+HZ3h+jwq
   hAqkmBeEdoNShxYOx8f2ROU6cSg8ulQtXXQMWqyT77CnXFNZHbL9rZdAw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4788780"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="4788780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 20:03:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="29449344"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Jan 2024 20:03:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMKO2-0003Mk-1c;
	Sun, 07 Jan 2024 04:03:46 +0000
Date: Sun, 07 Jan 2024 12:03:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 e16bf7e015d75fdd805528bedaf285fcb71dad2a
Message-ID: <202401071226.0eJyOOJY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: e16bf7e015d75fdd805528bedaf285fcb71dad2a  Merge branch 'for-6.7/cxl' into for-6.8/cxl

elapsed time: 1447m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240106   gcc  
arc                   randconfig-002-20240106   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20240106   gcc  
arm                   randconfig-002-20240106   gcc  
arm                   randconfig-003-20240106   gcc  
arm                   randconfig-004-20240106   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240106   gcc  
arm64                 randconfig-002-20240106   gcc  
arm64                 randconfig-003-20240106   gcc  
arm64                 randconfig-004-20240106   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240106   gcc  
csky                  randconfig-002-20240106   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240106   clang
hexagon               randconfig-002-20240106   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240106   gcc  
i386         buildonly-randconfig-002-20240106   gcc  
i386         buildonly-randconfig-003-20240106   gcc  
i386         buildonly-randconfig-004-20240106   gcc  
i386         buildonly-randconfig-005-20240106   gcc  
i386         buildonly-randconfig-006-20240106   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240106   gcc  
i386                  randconfig-002-20240106   gcc  
i386                  randconfig-003-20240106   gcc  
i386                  randconfig-004-20240106   gcc  
i386                  randconfig-005-20240106   gcc  
i386                  randconfig-006-20240106   gcc  
i386                  randconfig-011-20240106   clang
i386                  randconfig-011-20240107   gcc  
i386                  randconfig-012-20240106   clang
i386                  randconfig-012-20240107   gcc  
i386                  randconfig-013-20240106   clang
i386                  randconfig-013-20240107   gcc  
i386                  randconfig-014-20240106   clang
i386                  randconfig-014-20240107   gcc  
i386                  randconfig-015-20240106   clang
i386                  randconfig-015-20240107   gcc  
i386                  randconfig-016-20240106   clang
i386                  randconfig-016-20240107   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240106   gcc  
loongarch             randconfig-002-20240106   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240106   gcc  
nios2                 randconfig-002-20240106   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240106   gcc  
parisc                randconfig-002-20240106   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc               randconfig-001-20240106   gcc  
powerpc               randconfig-002-20240106   gcc  
powerpc               randconfig-003-20240106   gcc  
powerpc                     skiroot_defconfig   clang
powerpc64             randconfig-001-20240106   gcc  
powerpc64             randconfig-002-20240106   gcc  
powerpc64             randconfig-003-20240106   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240106   gcc  
riscv                 randconfig-002-20240106   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240106   clang
s390                  randconfig-002-20240106   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240106   gcc  
sh                    randconfig-002-20240106   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240106   gcc  
sparc64               randconfig-002-20240106   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240106   gcc  
um                    randconfig-002-20240106   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240106   gcc  
x86_64       buildonly-randconfig-001-20240107   clang
x86_64       buildonly-randconfig-002-20240106   gcc  
x86_64       buildonly-randconfig-002-20240107   clang
x86_64       buildonly-randconfig-003-20240106   gcc  
x86_64       buildonly-randconfig-003-20240107   clang
x86_64       buildonly-randconfig-004-20240106   gcc  
x86_64       buildonly-randconfig-004-20240107   clang
x86_64       buildonly-randconfig-005-20240106   gcc  
x86_64       buildonly-randconfig-005-20240107   clang
x86_64       buildonly-randconfig-006-20240106   gcc  
x86_64       buildonly-randconfig-006-20240107   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240106   clang
x86_64                randconfig-002-20240106   clang
x86_64                randconfig-003-20240106   clang
x86_64                randconfig-004-20240106   clang
x86_64                randconfig-005-20240106   clang
x86_64                randconfig-006-20240106   clang
x86_64                randconfig-011-20240106   gcc  
x86_64                randconfig-011-20240107   clang
x86_64                randconfig-012-20240106   gcc  
x86_64                randconfig-012-20240107   clang
x86_64                randconfig-013-20240106   gcc  
x86_64                randconfig-013-20240107   clang
x86_64                randconfig-014-20240106   gcc  
x86_64                randconfig-014-20240107   clang
x86_64                randconfig-015-20240106   gcc  
x86_64                randconfig-015-20240107   clang
x86_64                randconfig-016-20240106   gcc  
x86_64                randconfig-016-20240107   clang
x86_64                randconfig-071-20240106   gcc  
x86_64                randconfig-071-20240107   clang
x86_64                randconfig-072-20240106   gcc  
x86_64                randconfig-072-20240107   clang
x86_64                randconfig-073-20240106   gcc  
x86_64                randconfig-073-20240107   clang
x86_64                randconfig-074-20240106   gcc  
x86_64                randconfig-074-20240107   clang
x86_64                randconfig-075-20240106   gcc  
x86_64                randconfig-075-20240107   clang
x86_64                randconfig-076-20240106   gcc  
x86_64                randconfig-076-20240107   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240106   gcc  
xtensa                randconfig-002-20240106   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
