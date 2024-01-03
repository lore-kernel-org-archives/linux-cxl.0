Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A11D6BD
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbQnuixH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704313614; x=1735849614;
  h=date:from:to:cc:subject:message-id;
  bh=z9867RoM1lRRv/Mtza3+0uPW3HS9jsFGjPpTpQf8mco=;
  b=MbQnuixH5NunKhptKU1RsAAT554RWJ+1TQostEJWr7o3V2ETpN/EtonH
   8zRaqoe+LhYj3Ew1sl7aBo48CgwuAqzS+nteWTHFp6Ykjtr0J9yjW61uJ
   SviFtryABn2XELEhUdB89K7wSDFaSpeR96BRub5ExAw8do64NraM+WuEC
   K9iuaIYzxeZKWRVJdLC7JlP4RtvLvtfDgAFYMCD+HJjt2s0Ik3L6FvGQz
   WZ88AVaQiZ8HRuvjhGK4VX72amMa8J2v+2WOefUp7KdGjoPIKls+jxXwp
   XA5dHnWuPVb6S82wrI6SyFHg9bPhICEjZ3y+oTSzsvu5x89hqHAUUPpbR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="15704027"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="15704027"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:26:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="870664189"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="870664189"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2024 12:26:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL7pB-000MXH-2P;
	Wed, 03 Jan 2024 20:26:49 +0000
Date: Thu, 04 Jan 2024 04:25:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 11c83932028714014e4259072bd230473d6db730
Message-ID: <202401040445.qsNzGIIE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 11c83932028714014e4259072bd230473d6db730  Merge branch 'for-6.8/cxl-cdat' into for-6.8/cxl

elapsed time: 1464m

configs tested: 179
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240103   gcc  
arc                   randconfig-002-20240103   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240103   clang
arm                   randconfig-002-20240103   clang
arm                   randconfig-003-20240103   clang
arm                   randconfig-004-20240103   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240103   clang
arm64                 randconfig-002-20240103   clang
arm64                 randconfig-003-20240103   clang
arm64                 randconfig-004-20240103   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240103   gcc  
csky                  randconfig-002-20240103   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240103   clang
hexagon               randconfig-002-20240103   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240103   clang
i386         buildonly-randconfig-002-20240103   clang
i386         buildonly-randconfig-003-20240103   clang
i386         buildonly-randconfig-004-20240103   clang
i386         buildonly-randconfig-005-20240103   clang
i386         buildonly-randconfig-006-20240103   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240103   clang
i386                  randconfig-002-20240103   clang
i386                  randconfig-003-20240103   clang
i386                  randconfig-004-20240103   clang
i386                  randconfig-005-20240103   clang
i386                  randconfig-006-20240103   clang
i386                  randconfig-011-20240103   gcc  
i386                  randconfig-012-20240103   gcc  
i386                  randconfig-013-20240103   gcc  
i386                  randconfig-014-20240103   gcc  
i386                  randconfig-015-20240103   gcc  
i386                  randconfig-016-20240103   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240103   gcc  
loongarch             randconfig-002-20240103   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240103   gcc  
nios2                 randconfig-002-20240103   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240103   gcc  
parisc                randconfig-002-20240103   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20240103   clang
powerpc               randconfig-002-20240103   clang
powerpc               randconfig-003-20240103   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20240103   clang
powerpc64             randconfig-002-20240103   clang
powerpc64             randconfig-003-20240103   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240103   clang
riscv                 randconfig-002-20240103   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240103   gcc  
s390                  randconfig-002-20240103   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240103   gcc  
sh                    randconfig-002-20240103   gcc  
sh                           se7724_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240103   gcc  
sparc64               randconfig-002-20240103   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240103   clang
um                    randconfig-002-20240103   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240103   clang
x86_64       buildonly-randconfig-002-20240103   clang
x86_64       buildonly-randconfig-003-20240103   clang
x86_64       buildonly-randconfig-004-20240103   clang
x86_64       buildonly-randconfig-005-20240103   clang
x86_64       buildonly-randconfig-006-20240103   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240103   gcc  
x86_64                randconfig-002-20240103   gcc  
x86_64                randconfig-003-20240103   gcc  
x86_64                randconfig-004-20240103   gcc  
x86_64                randconfig-005-20240103   gcc  
x86_64                randconfig-006-20240103   gcc  
x86_64                randconfig-011-20240103   clang
x86_64                randconfig-012-20240103   clang
x86_64                randconfig-013-20240103   clang
x86_64                randconfig-014-20240103   clang
x86_64                randconfig-015-20240103   clang
x86_64                randconfig-016-20240103   clang
x86_64                randconfig-071-20240103   clang
x86_64                randconfig-072-20240103   clang
x86_64                randconfig-073-20240103   clang
x86_64                randconfig-074-20240103   clang
x86_64                randconfig-075-20240103   clang
x86_64                randconfig-076-20240103   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240103   gcc  
xtensa                randconfig-002-20240103   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
