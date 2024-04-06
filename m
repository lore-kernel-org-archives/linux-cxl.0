Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EF2561F
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401416; cv=none; b=o2gIkIPW4T1tZw5q+wOYiLhY7pf2n7ZNqOn0xaVJWavkiBUUCOPQHxJwtTGR7I30VnePDU5md58RXrYKiZdFCVQ/74aNQsTXoa4oPjSuT5AAdVOV3iPY/NTO/hJGEBBkruOygI0f/Yc/fHjMTURcYAQZXarInA8FHS7xBSLJ/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401416; c=relaxed/simple;
	bh=eTbfdEuhRUEHPvYJUlTz2gbvLrwOBKa/WV/qPQ+Lob8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TaFLpQNkexOG1/7qe1b9eR3+bj/BFNc9TzJ1GXKhLWuX2aNb2FQ3T9BzepWA5TQhpkYfW7cPmmKtPlITijn1SEhYnZsP97L0W/qRrkYLmZbawzrfQc58pyeIwqHo9uLVDGoW50wLbCxnhGtOUKuT7Ph5Y8dmLqnDaNa1oMkD4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GF7BRXpF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GF7BRXpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712401414; x=1743937414;
  h=date:from:to:cc:subject:message-id;
  bh=eTbfdEuhRUEHPvYJUlTz2gbvLrwOBKa/WV/qPQ+Lob8=;
  b=GF7BRXpFVy25dRBcrY/22OqQ06T3cSePBckFjRSxryOB4UTjyj/GWbX2
   UivaxA9vE98L0ts9nl/NDWfmONdbX0pC9LmOye0oJRMtoGIQRVtZA0mMi
   F+LcReTAdnHX09cLg7bTeV1V9GDRHQceEylSpwhYjLRTk7lJp+oAwIibT
   9rNENYQ6gAUGfhm6X1OwjhGCLHk564jiPbGa1mNzGYYxupDzy8XraI3Hh
   UNgjTRe1xYwLKrI6hWbGyEhY8jpCVj1Au3kE9OMDpuRjpNy7ZfkSBMHvM
   Hsox2dTUuLfg9OAtxC7nmbvJe1/4JtEBy7eFqaddg9tnIEcxzDpMsPNos
   A==;
X-CSE-ConnectionGUID: a2eIt/HTTwaJLvsi/SaSpg==
X-CSE-MsgGUID: eSDnX5D2RqC4kU8G3a4lXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18867169"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="18867169"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 04:03:33 -0700
X-CSE-ConnectionGUID: k+YOzKfVRN2aeMfmT+9avA==
X-CSE-MsgGUID: HZRpgcIQTYWJ7hR+HJNyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="19850689"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2024 04:03:32 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rt3pY-0003PS-31;
	Sat, 06 Apr 2024 11:03:28 +0000
Date: Sat, 06 Apr 2024 19:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 4ff2d4b81d7057bf0141aa14cbcf1780f063a477
Message-ID: <202404061927.kxurmwjs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 4ff2d4b81d7057bf0141aa14cbcf1780f063a477  cxl: Add checks to access_coordinate calculation to fail missing data

elapsed time: 721m

configs tested: 180
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
arc                   randconfig-001-20240406   gcc  
arc                   randconfig-002-20240406   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240406   clang
arm                   randconfig-002-20240406   clang
arm                   randconfig-003-20240406   gcc  
arm                   randconfig-004-20240406   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240406   clang
arm64                 randconfig-002-20240406   clang
arm64                 randconfig-003-20240406   clang
arm64                 randconfig-004-20240406   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240406   gcc  
csky                  randconfig-002-20240406   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240406   clang
hexagon               randconfig-002-20240406   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240406   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240406   gcc  
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240406   gcc  
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240406   gcc  
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240406   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240406   gcc  
loongarch             randconfig-002-20240406   gcc  
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
mips                        bcm47xx_defconfig   clang
mips                           ip27_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240406   gcc  
nios2                 randconfig-002-20240406   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240406   gcc  
parisc                randconfig-002-20240406   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc               randconfig-001-20240406   clang
powerpc               randconfig-002-20240406   clang
powerpc               randconfig-003-20240406   gcc  
powerpc64             randconfig-001-20240406   gcc  
powerpc64             randconfig-002-20240406   gcc  
powerpc64             randconfig-003-20240406   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240406   gcc  
riscv                 randconfig-002-20240406   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240406   gcc  
s390                  randconfig-002-20240406   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240406   gcc  
sh                    randconfig-002-20240406   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240406   gcc  
sparc64               randconfig-002-20240406   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240406   clang
um                    randconfig-002-20240406   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240406   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-003-20240406   clang
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64       buildonly-randconfig-006-20240406   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-002-20240406   clang
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-004-20240406   clang
x86_64                randconfig-005-20240406   clang
x86_64                randconfig-006-20240406   clang
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-012-20240406   clang
x86_64                randconfig-013-20240406   clang
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-016-20240406   clang
x86_64                randconfig-071-20240406   clang
x86_64                randconfig-072-20240406   clang
x86_64                randconfig-073-20240406   clang
x86_64                randconfig-074-20240406   clang
x86_64                randconfig-075-20240406   clang
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240406   gcc  
xtensa                randconfig-002-20240406   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
