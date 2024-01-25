Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B463AC
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162191; cv=none; b=Se1DjLD+IJBUJuWE0T0OOHcs/wHkxdBcfxUBHSpgeQx9H0OR8DXB1YtXR0SFfwPsIwS1uuQ1pLM3lGMUFRDdGcYiXUjB+RLyB35cp3QExaj37UfXgxvrt4gRp9JjWPc5+wqwYQZHOhQ10sxHuPL0qdzExElct/f9IBMhCpC8jtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162191; c=relaxed/simple;
	bh=mfgBba+jF/+J5pxQ41hiSO3JuztQumVsnfKWy8ju6kM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PB7by3w1A27JbLPDWpVkQ3NxVrxziPdjDClC7Deva91z+nX93vUeB4ITukFGUgv/rtAZRuQD4uLD2qO9od7ps2BjDN7bcCeOWn/BfEvdiXu37+A0H9QYQpih1Y3kiL/FPQHWHaeM7BoLUjwDqKNhi2gYEH1HMugNrwT2SzfhcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fa5NzKrR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fa5NzKrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706162190; x=1737698190;
  h=date:from:to:cc:subject:message-id;
  bh=mfgBba+jF/+J5pxQ41hiSO3JuztQumVsnfKWy8ju6kM=;
  b=Fa5NzKrRW1HftEtnKeyFNSbmWBBkozZcfj8ONegh9j2QGR8/+ocLgbza
   icoSKt+kf89pnVq3g2lgkNw5KUEppHOdTg5EzsVRLdu2F1834702Qs9Df
   q8XgKGf9NaFZ0sgLVdn7FjMKHX6ZWZfpymAtXYiBzSbKFjcALlyzZSZ0d
   2mse5jIA7RoIWSl6xljOh8iK+B/SCfT4hmXJQTCNMbWvYNlEkYumwG14S
   JfTdpnlEPiTFQ08ro78w0kEpLayyjT5ilj09Ob5hhHnpFjSbm9QeGjlka
   6jYwQYFKT2cB+s//ceW5mZq/ZXqTxzAWA+bMXyBtlT3oh4JDzDeQcws/J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15418770"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15418770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 21:56:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905855208"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905855208"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2024 21:56:26 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSsiu-0008ks-1C;
	Thu, 25 Jan 2024 05:56:24 +0000
Date: Thu, 25 Jan 2024 13:55:26 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 d72a4caf685989e353dff0a97d7376ee10edbf87
Message-ID: <202401251323.RuXxdOua-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: d72a4caf685989e353dff0a97d7376ee10edbf87  cxl/pci: Skip irq features if MSI/MSI-X are not supported

elapsed time: 1483m

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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240124   gcc  
arc                   randconfig-002-20240124   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240124   clang
arm                   randconfig-002-20240124   clang
arm                   randconfig-003-20240124   clang
arm                   randconfig-004-20240124   clang
arm                           sama5_defconfig   gcc  
arm                           spitz_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240124   clang
arm64                 randconfig-002-20240124   clang
arm64                 randconfig-003-20240124   clang
arm64                 randconfig-004-20240124   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240124   gcc  
csky                  randconfig-002-20240124   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240124   clang
hexagon               randconfig-002-20240124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240124   clang
i386         buildonly-randconfig-002-20240124   clang
i386         buildonly-randconfig-003-20240124   clang
i386         buildonly-randconfig-004-20240124   clang
i386         buildonly-randconfig-005-20240124   clang
i386         buildonly-randconfig-006-20240124   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240124   clang
i386                  randconfig-002-20240124   clang
i386                  randconfig-003-20240124   clang
i386                  randconfig-004-20240124   clang
i386                  randconfig-005-20240124   clang
i386                  randconfig-006-20240124   clang
i386                  randconfig-011-20240124   gcc  
i386                  randconfig-012-20240124   gcc  
i386                  randconfig-013-20240124   gcc  
i386                  randconfig-014-20240124   gcc  
i386                  randconfig-015-20240124   gcc  
i386                  randconfig-016-20240124   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240124   gcc  
loongarch             randconfig-002-20240124   gcc  
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
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240124   gcc  
nios2                 randconfig-002-20240124   gcc  
openrisc                         alldefconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240124   gcc  
parisc                randconfig-002-20240124   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240124   clang
powerpc               randconfig-002-20240124   clang
powerpc               randconfig-003-20240124   clang
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20240124   clang
powerpc64             randconfig-002-20240124   clang
powerpc64             randconfig-003-20240124   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240124   clang
riscv                 randconfig-002-20240124   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240124   gcc  
s390                  randconfig-002-20240124   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240124   gcc  
sh                    randconfig-002-20240124   gcc  
sh                             sh03_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240124   gcc  
sparc64               randconfig-002-20240124   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240124   clang
um                    randconfig-002-20240124   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240124   clang
x86_64       buildonly-randconfig-002-20240124   clang
x86_64       buildonly-randconfig-003-20240124   clang
x86_64       buildonly-randconfig-004-20240124   clang
x86_64       buildonly-randconfig-005-20240124   clang
x86_64       buildonly-randconfig-006-20240124   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240124   gcc  
x86_64                randconfig-002-20240124   gcc  
x86_64                randconfig-003-20240124   gcc  
x86_64                randconfig-004-20240124   gcc  
x86_64                randconfig-005-20240124   gcc  
x86_64                randconfig-006-20240124   gcc  
x86_64                randconfig-011-20240124   clang
x86_64                randconfig-012-20240124   clang
x86_64                randconfig-013-20240124   clang
x86_64                randconfig-014-20240124   clang
x86_64                randconfig-015-20240124   clang
x86_64                randconfig-016-20240124   clang
x86_64                randconfig-071-20240124   clang
x86_64                randconfig-072-20240124   clang
x86_64                randconfig-073-20240124   clang
x86_64                randconfig-074-20240124   clang
x86_64                randconfig-075-20240124   clang
x86_64                randconfig-076-20240124   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240124   gcc  
xtensa                randconfig-002-20240124   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
