Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D8282E1
	for <linux-cxl@vger.kernel.org>; Sat, 10 Feb 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707559576; cv=none; b=CwGXhOZairKi7jWn8A/uquG6d8WAhZKX+dYXsDjS3sUuOD2EYkSO/SD/D8lpEcGFzmrqTvweH2tMx8SUKgG8840CvZrHbut5qmXft/u8E5ExRselNoua1woWqrmA1Nq6VEoayj7It2ZKf54lFqBlYa+wix0fkJweDk1+LuzUE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707559576; c=relaxed/simple;
	bh=jVH6VI2MXH4ENeC8ngK4GzGHvXVVd8YlYxq2PUSNpe0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KwrrFoeuNXdtxTOtKTbbsW9LPivksjFmzREFghlJybyUYkUE+YVbAiltyu/Yap0jQaA1kjxdQBgiWpvNcfTJ4GJ9xinPMynyU3JRAP+k4uXe/KGMgNu3pyBYh9uHuSziWb/VQ6q35Nk+WYt9uz4QquVsQTJigvQuWmqzRCPp/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZBUd+7c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZBUd+7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707559575; x=1739095575;
  h=date:from:to:cc:subject:message-id;
  bh=jVH6VI2MXH4ENeC8ngK4GzGHvXVVd8YlYxq2PUSNpe0=;
  b=QZBUd+7chVBN6sm6uYdRFvIA5TefwdOT4gh3chwAfkk9rRH0gvcZKqK0
   TasevLF8m7EOONV7RIvl1mkeHXwrqHKMnT7pQeIFSVvjWMmj2V+BaYjAb
   5Y8/PQPZcUnekRW17R2y138tpRizKdZyINhbyq4wNkH2OSfYfwWKNqUbu
   4/LFZc70lzsieuMJGZtI3WjCc8GNkSmX1ErzjQGJe1J5c+DCedFI9Zeum
   5F3aMsy5xh/19MaYtaLvJHrg0LLr1K2C9TKKEVLD6MwWMO+H7qNSjiJ4Z
   fZJbOdwkxIHUlQ0fdl4XMnfr6ZCIHXM0bIIi9UUbIt38BzGaFKTPI5wLr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19059705"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="19059705"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2134142"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Feb 2024 02:06:11 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYkFN-0005YT-2V;
	Sat, 10 Feb 2024 10:06:09 +0000
Date: Sat, 10 Feb 2024 18:06:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 2e82c63333c2e154287a9671ac331b4fe3eb1b30
Message-ID: <202402101859.YygwG2t7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 2e82c63333c2e154287a9671ac331b4fe3eb1b30  cxl/test: Add support for qos_class checking

elapsed time: 1449m

configs tested: 293
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240209   gcc  
arc                   randconfig-001-20240210   gcc  
arc                   randconfig-002-20240209   gcc  
arc                   randconfig-002-20240210   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240209   clang
arm                   randconfig-001-20240210   gcc  
arm                   randconfig-002-20240209   gcc  
arm                   randconfig-002-20240210   gcc  
arm                   randconfig-003-20240209   gcc  
arm                   randconfig-003-20240210   gcc  
arm                   randconfig-004-20240209   gcc  
arm                   randconfig-004-20240210   gcc  
arm                        realview_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240209   clang
arm64                 randconfig-002-20240209   clang
arm64                 randconfig-002-20240210   gcc  
arm64                 randconfig-003-20240209   clang
arm64                 randconfig-003-20240210   gcc  
arm64                 randconfig-004-20240209   clang
arm64                 randconfig-004-20240210   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240209   gcc  
csky                  randconfig-001-20240210   gcc  
csky                  randconfig-002-20240209   gcc  
csky                  randconfig-002-20240210   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240209   clang
hexagon               randconfig-002-20240209   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240209   clang
i386         buildonly-randconfig-001-20240210   clang
i386         buildonly-randconfig-002-20240209   clang
i386         buildonly-randconfig-002-20240210   gcc  
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-003-20240210   clang
i386         buildonly-randconfig-004-20240209   clang
i386         buildonly-randconfig-004-20240210   clang
i386         buildonly-randconfig-005-20240209   clang
i386         buildonly-randconfig-005-20240210   clang
i386         buildonly-randconfig-006-20240209   gcc  
i386         buildonly-randconfig-006-20240210   clang
i386                                defconfig   clang
i386                  randconfig-001-20240209   clang
i386                  randconfig-001-20240210   gcc  
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-002-20240210   gcc  
i386                  randconfig-003-20240209   clang
i386                  randconfig-003-20240210   clang
i386                  randconfig-004-20240209   clang
i386                  randconfig-004-20240210   clang
i386                  randconfig-005-20240209   clang
i386                  randconfig-005-20240210   gcc  
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-006-20240210   gcc  
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-011-20240210   clang
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-012-20240210   clang
i386                  randconfig-013-20240209   clang
i386                  randconfig-013-20240210   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-014-20240210   gcc  
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-015-20240210   gcc  
i386                  randconfig-016-20240209   gcc  
i386                  randconfig-016-20240210   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240209   gcc  
loongarch             randconfig-001-20240210   gcc  
loongarch             randconfig-002-20240209   gcc  
loongarch             randconfig-002-20240210   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240209   gcc  
nios2                 randconfig-001-20240210   gcc  
nios2                 randconfig-002-20240209   gcc  
nios2                 randconfig-002-20240210   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240209   gcc  
parisc                randconfig-001-20240210   gcc  
parisc                randconfig-002-20240209   gcc  
parisc                randconfig-002-20240210   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240209   clang
powerpc               randconfig-001-20240210   gcc  
powerpc               randconfig-002-20240209   clang
powerpc               randconfig-003-20240209   gcc  
powerpc               randconfig-003-20240210   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240209   clang
powerpc64             randconfig-002-20240209   clang
powerpc64             randconfig-003-20240209   clang
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240209   clang
riscv                 randconfig-001-20240210   gcc  
riscv                 randconfig-002-20240209   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240209   gcc  
s390                  randconfig-001-20240210   gcc  
s390                  randconfig-002-20240209   gcc  
s390                  randconfig-002-20240210   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240209   gcc  
sh                    randconfig-001-20240210   gcc  
sh                    randconfig-002-20240209   gcc  
sh                    randconfig-002-20240210   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240209   gcc  
sparc64               randconfig-001-20240210   gcc  
sparc64               randconfig-002-20240209   gcc  
sparc64               randconfig-002-20240210   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240209   gcc  
um                    randconfig-001-20240210   gcc  
um                    randconfig-002-20240209   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-001-20240210   gcc  
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-002-20240210   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-003-20240210   gcc  
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-004-20240210   clang
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-005-20240210   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64       buildonly-randconfig-006-20240210   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-001-20240210   clang
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-002-20240210   clang
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-003-20240210   gcc  
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-004-20240210   clang
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-005-20240210   clang
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-006-20240210   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-011-20240210   gcc  
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-012-20240210   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-013-20240210   clang
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-014-20240210   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-015-20240210   gcc  
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-016-20240210   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-071-20240210   gcc  
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-072-20240210   gcc  
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-073-20240210   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-074-20240210   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-075-20240210   clang
x86_64                randconfig-076-20240209   clang
x86_64                randconfig-076-20240210   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240209   gcc  
xtensa                randconfig-001-20240210   gcc  
xtensa                randconfig-002-20240209   gcc  
xtensa                randconfig-002-20240210   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
