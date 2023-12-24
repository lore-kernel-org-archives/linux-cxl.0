Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869A7E4
	for <linux-cxl@vger.kernel.org>; Sun, 24 Dec 2023 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNHzKCvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703382825; x=1734918825;
  h=date:from:to:cc:subject:message-id;
  bh=jj70Z3Cvxxohk7Rf3zBDcSYF5lnuXMVMZ8SI9qkHxDM=;
  b=VNHzKCvfbEOdvV7M74i2rNQ4z9I6BwkRvocOFub03rbZGpZl8UXVY1Bw
   Iu+f5JGOQGOEb7xA+TmlmtBxIkfuUsBmxqnL4aG36QufxpPe9fqa3M0eW
   jtRKxtCy0GeOjMeQDdEKLG66ELRI80ktJwuoklU1GRvoFsf16QI4S0TkX
   7lwguYiDzBYmorYkkzPxZnRn0hZ4Byd0kt9BjnGbMdwnQDSlkIsEhskrl
   Sqh38ozlnjmkIfG64lAf4t1yKKJZxqhR5WmSzyZuFKbnrnrF90r1/iey9
   nCWqzQiPte+Gpjx/QpcSFF0ZK5k/G9Ig0YvZgoJxymo1Ky2tw9z1kk9aY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="3475084"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="3475084"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 17:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="777426556"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="777426556"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Dec 2023 17:53:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHDgP-000BkB-1r;
	Sun, 24 Dec 2023 01:53:38 +0000
Date: Sun, 24 Dec 2023 09:52:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:pending] BUILD SUCCESS
 185c1a489f873cb71520fc089401e02dbf302dcd
Message-ID: <202312240936.erViZ8kv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: 185c1a489f873cb71520fc089401e02dbf302dcd  cxl: Check qos_class validity on memdev probe

elapsed time: 1485m

configs tested: 220
configs skipped: 8

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
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231223   gcc  
arc                   randconfig-002-20231223   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231223   clang
arm                   randconfig-002-20231223   clang
arm                   randconfig-003-20231223   clang
arm                   randconfig-004-20231223   clang
arm                        shmobile_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231223   clang
arm64                 randconfig-002-20231223   clang
arm64                 randconfig-003-20231223   clang
arm64                 randconfig-004-20231223   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231223   gcc  
csky                  randconfig-002-20231223   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231223   clang
hexagon               randconfig-002-20231223   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231223   clang
i386         buildonly-randconfig-002-20231223   clang
i386         buildonly-randconfig-003-20231223   clang
i386         buildonly-randconfig-004-20231223   clang
i386         buildonly-randconfig-005-20231223   clang
i386         buildonly-randconfig-006-20231223   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231223   clang
i386                  randconfig-002-20231223   clang
i386                  randconfig-003-20231223   clang
i386                  randconfig-004-20231223   clang
i386                  randconfig-005-20231223   clang
i386                  randconfig-006-20231223   clang
i386                  randconfig-011-20231223   gcc  
i386                  randconfig-011-20231224   clang
i386                  randconfig-012-20231223   gcc  
i386                  randconfig-012-20231224   clang
i386                  randconfig-013-20231223   gcc  
i386                  randconfig-013-20231224   clang
i386                  randconfig-014-20231223   gcc  
i386                  randconfig-014-20231224   clang
i386                  randconfig-015-20231223   gcc  
i386                  randconfig-015-20231224   clang
i386                  randconfig-016-20231223   gcc  
i386                  randconfig-016-20231224   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231223   gcc  
loongarch             randconfig-002-20231223   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231223   gcc  
nios2                 randconfig-002-20231223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231223   gcc  
parisc                randconfig-002-20231223   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc               randconfig-001-20231223   clang
powerpc               randconfig-002-20231223   clang
powerpc               randconfig-003-20231223   clang
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc64             randconfig-001-20231223   clang
powerpc64             randconfig-002-20231223   clang
powerpc64             randconfig-003-20231223   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231223   clang
riscv                 randconfig-002-20231223   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231223   gcc  
s390                  randconfig-002-20231223   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231223   gcc  
sh                    randconfig-002-20231223   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231223   gcc  
sparc64               randconfig-002-20231223   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231223   clang
um                    randconfig-002-20231223   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231223   clang
x86_64       buildonly-randconfig-001-20231224   gcc  
x86_64       buildonly-randconfig-002-20231223   clang
x86_64       buildonly-randconfig-002-20231224   gcc  
x86_64       buildonly-randconfig-003-20231223   clang
x86_64       buildonly-randconfig-003-20231224   gcc  
x86_64       buildonly-randconfig-004-20231223   clang
x86_64       buildonly-randconfig-004-20231224   gcc  
x86_64       buildonly-randconfig-005-20231223   clang
x86_64       buildonly-randconfig-005-20231224   gcc  
x86_64       buildonly-randconfig-006-20231223   clang
x86_64       buildonly-randconfig-006-20231224   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231223   gcc  
x86_64                randconfig-002-20231223   gcc  
x86_64                randconfig-003-20231223   gcc  
x86_64                randconfig-004-20231223   gcc  
x86_64                randconfig-005-20231223   gcc  
x86_64                randconfig-006-20231223   gcc  
x86_64                randconfig-011-20231223   clang
x86_64                randconfig-011-20231224   gcc  
x86_64                randconfig-012-20231223   clang
x86_64                randconfig-012-20231224   gcc  
x86_64                randconfig-013-20231223   clang
x86_64                randconfig-013-20231224   gcc  
x86_64                randconfig-014-20231223   clang
x86_64                randconfig-014-20231224   gcc  
x86_64                randconfig-015-20231223   clang
x86_64                randconfig-015-20231224   gcc  
x86_64                randconfig-016-20231223   clang
x86_64                randconfig-016-20231224   gcc  
x86_64                randconfig-071-20231223   clang
x86_64                randconfig-071-20231224   gcc  
x86_64                randconfig-072-20231223   clang
x86_64                randconfig-072-20231224   gcc  
x86_64                randconfig-073-20231223   clang
x86_64                randconfig-073-20231224   gcc  
x86_64                randconfig-074-20231223   clang
x86_64                randconfig-074-20231224   gcc  
x86_64                randconfig-075-20231223   clang
x86_64                randconfig-075-20231224   gcc  
x86_64                randconfig-076-20231223   clang
x86_64                randconfig-076-20231224   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231223   gcc  
xtensa                randconfig-002-20231223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
