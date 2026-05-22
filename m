Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149639185C
	for <linux-cxl@vger.kernel.org>; Fri, 22 May 2026 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428249; cv=none; b=h+wvqE6lZX2Mz+WHMndvC0gQcgeJ8GrPfPdWNh/voqhzJacR4Z2TWTms93KS5nptZHWvZJThTMDwgXuZ1E1DTIQ10w7Q1JQfPtz4gt+J2TyPPfz4y9wtKMlUEMsmKHxv8p2XYUAqhiNIHIasJ0Nd1HQs9+mjmPZDnnyDxOowV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428249; c=relaxed/simple;
	bh=NvIYuZnT3m6pLkObo/0PzUrq4mThFi6nV6Nk6oeJ/p8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AmNVJcORVpA4jeUdF/2ImBOqAIQ6XY9/F08VurJS/aimW/w+rk2tNwqvfneQpGAwr9XcvwSkd2VW6IGkDIPn5s7IrL1Ps0vWGcFEmuBxU6n859VHNnZgr9VlXNq0l4Vz50xQUvJjgn3lm8ZNQEQgdDXsMv01c7nbFh2y4XHofSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUhXes3R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUhXes3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779428248; x=1810964248;
  h=date:from:to:cc:subject:message-id;
  bh=NvIYuZnT3m6pLkObo/0PzUrq4mThFi6nV6Nk6oeJ/p8=;
  b=kUhXes3RSNBoxW/e5K8kJf5Wmn0MolSOkQRy9lV9SDDvAuKMvwbO1gSu
   hfLqcCe0dMFzzjJx94dMriBz+p0bET1HSYd/1bCeHGaGqMO9bOuctVs7y
   4ZJIcUGOJi5gaDrAez40yMnSxy8PEDI/vFgLMAI7O2FF8YsYmPkVr9CtH
   0WRI//4FGfl8HjO9cH2Moahf3d4+yoePIz5v02j2hKw0b5djcUi2ErS6n
   jBwRjvi1oh4XnJQLc3Cic1tv0xeyyC43HCa0Ho2y1RQv6ysReHE9QSI6i
   YwsObbyCaLIAElXz8ARmVDf0tVXArUMP/f27Y65afYl71CLEHeqxk1uao
   Q==;
X-CSE-ConnectionGUID: +w1QOOpbSf6wpoFbTGr2QA==
X-CSE-MsgGUID: TN9NX9AKQX2UaLuwFE+yrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105819752"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105819752"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 22:37:27 -0700
X-CSE-ConnectionGUID: C7hrJrz+TaeNKTuP2BN7ow==
X-CSE-MsgGUID: GEsN2EZBSpuC1iQqzj6GwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="241043321"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2026 22:37:24 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQIZW-000000001nl-1WEv;
	Fri, 22 May 2026 05:37:22 +0000
Date: Fri, 22 May 2026 13:36:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 abb3c0de119032f4c0c81177884a3bb0a133e6ca
Message-ID: <202605221322.UuakftWo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: abb3c0de119032f4c0c81177884a3bb0a133e6ca  cxl/region: Validate partition index before array access

elapsed time: 744m

configs tested: 165
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260522    gcc-9.5.0
arc                   randconfig-002-20260522    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            qcom_defconfig    clang-23
arm                   randconfig-001-20260522    gcc-8.5.0
arm                   randconfig-002-20260522    gcc-10.5.0
arm                   randconfig-003-20260522    gcc-11.5.0
arm                   randconfig-004-20260522    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260522    clang-20
arm64                 randconfig-002-20260522    gcc-14.3.0
arm64                 randconfig-003-20260522    clang-23
arm64                 randconfig-004-20260522    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260522    gcc-15.2.0
csky                  randconfig-002-20260522    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260522    clang-23
hexagon               randconfig-002-20260522    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260522    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260522    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260522    clang-20
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260522    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260522    clang-20
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260522    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260522    gcc-14
i386                  randconfig-002-20260522    clang-20
i386                  randconfig-003-20260522    gcc-13
i386                  randconfig-004-20260522    gcc-14
i386                  randconfig-005-20260522    gcc-14
i386                  randconfig-006-20260522    clang-20
i386                  randconfig-007-20260522    gcc-13
i386                  randconfig-011-20260522    gcc-14
i386                  randconfig-012-20260522    clang-20
i386                  randconfig-013-20260522    clang-20
i386                  randconfig-014-20260522    gcc-14
i386                  randconfig-015-20260522    clang-20
i386                  randconfig-016-20260522    clang-20
i386                  randconfig-017-20260522    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260522    clang-23
loongarch             randconfig-002-20260522    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260522    gcc-8.5.0
nios2                 randconfig-002-20260522    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260522    gcc-14.3.0
parisc                randconfig-002-20260522    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260522    clang-20
powerpc               randconfig-002-20260522    clang-18
powerpc64             randconfig-001-20260522    gcc-10.5.0
powerpc64             randconfig-002-20260522    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260522    clang-17
riscv                 randconfig-002-20260522    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260522    clang-23
s390                  randconfig-002-20260522    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260522    gcc-10.5.0
sh                    randconfig-002-20260522    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260522    gcc-15.2.0
sparc                 randconfig-002-20260522    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260522    gcc-14.3.0
sparc64               randconfig-002-20260522    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260522    clang-23
um                    randconfig-002-20260522    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260522    clang-20
x86_64      buildonly-randconfig-002-20260522    gcc-13
x86_64      buildonly-randconfig-003-20260522    gcc-14
x86_64      buildonly-randconfig-004-20260522    clang-20
x86_64      buildonly-randconfig-005-20260522    clang-20
x86_64      buildonly-randconfig-006-20260522    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260522    clang-20
x86_64                randconfig-002-20260522    clang-20
x86_64                randconfig-003-20260522    gcc-14
x86_64                randconfig-004-20260522    gcc-14
x86_64                randconfig-005-20260522    gcc-14
x86_64                randconfig-006-20260522    gcc-14
x86_64                randconfig-011-20260522    gcc-14
x86_64                randconfig-012-20260522    clang-20
x86_64                randconfig-013-20260522    gcc-13
x86_64                randconfig-014-20260522    clang-20
x86_64                randconfig-015-20260522    clang-20
x86_64                randconfig-016-20260522    gcc-14
x86_64                randconfig-071-20260522    gcc-14
x86_64                randconfig-072-20260522    gcc-14
x86_64                randconfig-073-20260522    clang-20
x86_64                randconfig-074-20260522    gcc-14
x86_64                randconfig-075-20260522    clang-20
x86_64                randconfig-076-20260522    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260522    gcc-9.5.0
xtensa                randconfig-002-20260522    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
