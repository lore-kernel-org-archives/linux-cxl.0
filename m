Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E21CA81
	for <linux-cxl@vger.kernel.org>; Thu,  2 May 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627528; cv=none; b=C6M07AB2v7H8C9sqRt4cn2mMmD2pEyohUPEakBll77fV+enGKHU8hKXpCOkbsN7GhHtNpYiJiHz+OGOBt55PMi8Lk6Z4t5+0m3qJFDjjvr1AuzN1QsilxxaM6dfhzbKkQVPO6M3sXJj1/K1Ke00e4RGuwSj8Z1HbrBy3q28erVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627528; c=relaxed/simple;
	bh=DptbqL41zAOCrRGZmqIFQRM55kjvUgZlQ7ggq3jKrnA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=keQyq5Kj1v2ar27B3A3K5L1D+XiEnhAAEffoJ5TWWKyPZozZUPewF+2Dl6SwgSSymx9Kb+KYE0RgY8/On45BEyPmp3K6c6C5n5IXQGpYzQLXIy40p5ig2oB6nU+oIGDYWDbwJHzHSCP+te2+gdz6WCnlDbd5Yyh0NUeB47BHRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2ZXSL2m; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2ZXSL2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714627526; x=1746163526;
  h=date:from:to:cc:subject:message-id;
  bh=DptbqL41zAOCrRGZmqIFQRM55kjvUgZlQ7ggq3jKrnA=;
  b=Y2ZXSL2m1x1Yx3APXSJnXynSeBMqcBpO2SocS34waTiQJWrvEDYRLf/v
   OtbnJ+HP/iAvuJza3F3QcsLxs6EHaAt7fXf89o2eHxO9+3cc5QZ7k0ucy
   8LzNt5b3YNiDbbSht58DwDpAABFOfTOgAHO6M9vlKDOqDRLKCs1QXf84/
   hgpBB46ERtAm0aRjQ0IHPMMzaEpiYAad/yfKrmk9filfC9dQGE7OGF9m9
   MlVNLJnuFJWVTIFO2y4ydhLbX6fN+UiEgiu7poVF9iCuz333KgRROl9ua
   0jOh3iEjDMN2GY98dL+2OmRY++CgssWmiG7887Y847DjKITJdDiMP1Chp
   Q==;
X-CSE-ConnectionGUID: wE7ssf+QT5GzmMfZm/8yWQ==
X-CSE-MsgGUID: KhbX8cbUT2yfze5Ib3T1Ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10920701"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10920701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 22:25:25 -0700
X-CSE-ConnectionGUID: 8kWcNYGRTKmfBfcf+aF4Vg==
X-CSE-MsgGUID: Vis7ZW+1ToWKCV88C2cdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31819495"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 May 2024 22:25:24 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2Owb-000AQK-1D;
	Thu, 02 May 2024 05:25:21 +0000
Date: Thu, 02 May 2024 13:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.10/cper] BUILD SUCCESS
 c19ac30eda3a1d14d4883de0ea214b6c5c96a9b4
Message-ID: <202405021336.WFYqDGkJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.10/cper
branch HEAD: c19ac30eda3a1d14d4883de0ea214b6c5c96a9b4  cxl/pci: Process CPER events

elapsed time: 726m

configs tested: 178
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240502   gcc  
arc                   randconfig-002-20240502   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240502   gcc  
arm                   randconfig-002-20240502   gcc  
arm                   randconfig-003-20240502   gcc  
arm                   randconfig-004-20240502   gcc  
arm                             rpc_defconfig   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240502   gcc  
arm64                 randconfig-002-20240502   clang
arm64                 randconfig-003-20240502   clang
arm64                 randconfig-004-20240502   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240502   gcc  
csky                  randconfig-002-20240502   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240502   clang
hexagon               randconfig-002-20240502   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240502   gcc  
i386         buildonly-randconfig-002-20240502   gcc  
i386         buildonly-randconfig-003-20240502   clang
i386         buildonly-randconfig-004-20240502   gcc  
i386         buildonly-randconfig-005-20240502   clang
i386         buildonly-randconfig-006-20240502   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240502   gcc  
i386                  randconfig-002-20240502   clang
i386                  randconfig-003-20240502   clang
i386                  randconfig-004-20240502   gcc  
i386                  randconfig-005-20240502   gcc  
i386                  randconfig-006-20240502   clang
i386                  randconfig-011-20240502   gcc  
i386                  randconfig-012-20240502   clang
i386                  randconfig-013-20240502   clang
i386                  randconfig-014-20240502   gcc  
i386                  randconfig-015-20240502   clang
i386                  randconfig-016-20240502   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240502   gcc  
loongarch             randconfig-002-20240502   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240502   gcc  
nios2                 randconfig-002-20240502   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240502   gcc  
parisc                randconfig-002-20240502   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240502   clang
powerpc               randconfig-002-20240502   clang
powerpc               randconfig-003-20240502   clang
powerpc                    socrates_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240502   gcc  
powerpc64             randconfig-002-20240502   clang
powerpc64             randconfig-003-20240502   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240502   clang
riscv                 randconfig-002-20240502   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240502   gcc  
s390                  randconfig-002-20240502   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240502   gcc  
sh                    randconfig-002-20240502   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240502   gcc  
sparc64               randconfig-002-20240502   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240502   clang
um                    randconfig-002-20240502   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240502   gcc  
x86_64       buildonly-randconfig-002-20240502   gcc  
x86_64       buildonly-randconfig-003-20240502   clang
x86_64       buildonly-randconfig-004-20240502   gcc  
x86_64       buildonly-randconfig-005-20240502   gcc  
x86_64       buildonly-randconfig-006-20240502   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240502   gcc  
x86_64                randconfig-002-20240502   clang
x86_64                randconfig-003-20240502   clang
x86_64                randconfig-004-20240502   gcc  
x86_64                randconfig-005-20240502   clang
x86_64                randconfig-006-20240502   clang
x86_64                randconfig-011-20240502   clang
x86_64                randconfig-012-20240502   clang
x86_64                randconfig-013-20240502   gcc  
x86_64                randconfig-014-20240502   gcc  
x86_64                randconfig-015-20240502   gcc  
x86_64                randconfig-016-20240502   clang
x86_64                randconfig-071-20240502   gcc  
x86_64                randconfig-072-20240502   gcc  
x86_64                randconfig-073-20240502   gcc  
x86_64                randconfig-074-20240502   clang
x86_64                randconfig-075-20240502   clang
x86_64                randconfig-076-20240502   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240502   gcc  
xtensa                randconfig-002-20240502   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
