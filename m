Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556963087
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639085; cv=none; b=d0t9LhZaJuA5fEHQTlDXgKhyxYn8LrCm4g9gvcVv7N5hLwCe2fQ6+jGg84ytd0uW2OEpRX3BimdpqKwSTthHC5YqKwAHtKuX/cSrHkyeOkdL3GeSStw3AvP4AsUodUXvxmyBmAecIqKdx27ViMjqGLhqBW7OkW6RMNpyY1na0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639085; c=relaxed/simple;
	bh=gDNgxw+sNfJJye9S4kdh5DPqYaxwnKScKHdL9wu9fKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XgnpvEEdvCF6iUggNHEsJmxv64NNaPhqQIvyw4O71Y200r6zPZBGgy6F2xJtTkCr0atOebZyUeOQthWhopIzpCCMfoZWk6stBJ5k8hnrvp/aux/Jz+zjr7wpHZtyN0TriWrW08CoNHlXNiTmnhdQCuV7Tm7+T9d6BFmspq0ZgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVjybqBR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVjybqBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712639083; x=1744175083;
  h=date:from:to:cc:subject:message-id;
  bh=gDNgxw+sNfJJye9S4kdh5DPqYaxwnKScKHdL9wu9fKc=;
  b=NVjybqBRzG9yEROitgGw2TfMKnadGkce8LzwrurmXH8ErwzCrJk1FPN5
   0xp6upZaDZNR4gF2KKgf6otE6vFOxbdHjaIkuvwr3QLjx82qyoXH41POT
   RUTIag2KEzRccZzs54btgKrPvNq1Clzco0QN45GIDKoriGxTeOl8WlNes
   2BLnEiVmpW38MWW7CJxf19Rc65RR7kK1enVr0cLVoMIIxxhybEBpXs1u5
   y1uFPBCrHfOFb37jdirmLSeid0I2ebUM7MXUPI116D+HVirAQY93Z0eQ9
   +p+x8RfpRSZ+UXnd+VFTCu6gXtDDNEfIuHN9IzuuWkmw+hUy0NhyWSO1v
   Q==;
X-CSE-ConnectionGUID: 1GfC/yHERB226FGFvYHG1A==
X-CSE-MsgGUID: lXKpsL+iSMS1AfX4TdWLYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30432104"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="30432104"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 22:04:43 -0700
X-CSE-ConnectionGUID: 65ZeDC6oSbCt9ThMtNatsA==
X-CSE-MsgGUID: +afCwjg4Qs+pZFZMFGL5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20674552"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Apr 2024 22:04:41 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru3ew-0005kI-1C;
	Tue, 09 Apr 2024 05:04:38 +0000
Date: Tue, 09 Apr 2024 13:03:45 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 7bcf809b1e7889ab7e75fe1fcf8f1a98332f36d2
Message-ID: <202404091342.mz1TCvfW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 7bcf809b1e7889ab7e75fe1fcf8f1a98332f36d2  cxl: Add checks to access_coordinate calculation to fail missing data

elapsed time: 725m

configs tested: 177
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
arc                   randconfig-001-20240409   gcc  
arc                   randconfig-002-20240409   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                                 defconfig   clang
arm                          exynos_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240409   gcc  
arm                   randconfig-002-20240409   clang
arm                   randconfig-003-20240409   clang
arm                   randconfig-004-20240409   gcc  
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240409   gcc  
arm64                 randconfig-002-20240409   gcc  
arm64                 randconfig-003-20240409   clang
arm64                 randconfig-004-20240409   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240409   gcc  
csky                  randconfig-002-20240409   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240409   clang
hexagon               randconfig-002-20240409   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240409   clang
i386                  randconfig-002-20240409   gcc  
i386                  randconfig-003-20240409   clang
i386                  randconfig-004-20240409   gcc  
i386                  randconfig-005-20240409   gcc  
i386                  randconfig-006-20240409   clang
i386                  randconfig-011-20240409   gcc  
i386                  randconfig-012-20240409   clang
i386                  randconfig-013-20240409   clang
i386                  randconfig-014-20240409   clang
i386                  randconfig-015-20240409   gcc  
i386                  randconfig-016-20240409   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240409   gcc  
loongarch             randconfig-002-20240409   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                     loongson1b_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240409   gcc  
nios2                 randconfig-002-20240409   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240409   gcc  
parisc                randconfig-002-20240409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                       maple_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240409   clang
powerpc               randconfig-002-20240409   gcc  
powerpc               randconfig-003-20240409   clang
powerpc64             randconfig-001-20240409   gcc  
powerpc64             randconfig-002-20240409   clang
powerpc64             randconfig-003-20240409   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240409   clang
riscv                 randconfig-002-20240409   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240409   gcc  
s390                  randconfig-002-20240409   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240409   gcc  
sh                    randconfig-002-20240409   gcc  
sh                           se7780_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240409   gcc  
sparc64               randconfig-002-20240409   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240409   clang
um                    randconfig-002-20240409   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240409   clang
x86_64       buildonly-randconfig-002-20240409   clang
x86_64       buildonly-randconfig-003-20240409   gcc  
x86_64       buildonly-randconfig-004-20240409   gcc  
x86_64       buildonly-randconfig-005-20240409   clang
x86_64       buildonly-randconfig-006-20240409   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240409   clang
x86_64                randconfig-002-20240409   clang
x86_64                randconfig-003-20240409   gcc  
x86_64                randconfig-004-20240409   gcc  
x86_64                randconfig-005-20240409   clang
x86_64                randconfig-006-20240409   clang
x86_64                randconfig-011-20240409   gcc  
x86_64                randconfig-012-20240409   clang
x86_64                randconfig-013-20240409   gcc  
x86_64                randconfig-014-20240409   clang
x86_64                randconfig-015-20240409   gcc  
x86_64                randconfig-016-20240409   gcc  
x86_64                randconfig-071-20240409   gcc  
x86_64                randconfig-072-20240409   clang
x86_64                randconfig-073-20240409   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240409   gcc  
xtensa                randconfig-002-20240409   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
