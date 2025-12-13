Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D533B8D4B
	for <linux-cxl@vger.kernel.org>; Sat, 13 Dec 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765641780; cv=none; b=PB6ZOWyIoAgvi1bSk3ZVaYgCPQ+mnjUnbJ5tq/iY9e9T9KVloGNeoGR5nkPd4QwO4RHGRaKtSfs6VwbjED1lb3q6Y8PZgJWUVJBRmvllNz+ZWU8nPeWaECMI7fNlUgqU7EoVq2++LfTVWzagqEc5xkKM9kjOvCVifqwKSFi6CbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765641780; c=relaxed/simple;
	bh=xwduwB6qaYqzQnh91mPuNxuT/b4K1yP/VOB1nBV7/mE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mnpVZnZaW1BQ7dV1IvSJ6oP190+pYiY0QWCzQNj2okYOdZEVUUHrbxrOdzscPcZkPpTOS7iKS8yxstq2bsz57csbEDLUC3HKHvzPVLbXrTRZUe9GX1epKw+7CA2xiJvDXhnTQMm4g1XgZXWwJUPvowi9vhbXmATJzDFKShVR/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHhvjIXS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHhvjIXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765641779; x=1797177779;
  h=date:from:to:cc:subject:message-id;
  bh=xwduwB6qaYqzQnh91mPuNxuT/b4K1yP/VOB1nBV7/mE=;
  b=RHhvjIXSs47s8CA2Eb12J+zbpNmYCSSc3ch/yOAf3sa0bkc+4mrzdlMm
   4+WycgGCBBgGL3Lgpo7BKLUqGhQZzQMfDTTc6IUGLYSGUx7x9tvvCic1j
   sJnd4P2Yo6b2UiUmBLO1J6bCh8le4boDwTvpGsMxli6uC8VDbNn5p1mfv
   GsGmzQLMxiIfHXivAivPku30oP0GwZaK2hWfahwynsmndlvhZHdBlLu2X
   FGme640hCRSJ3bVvwTYCznHmRQDoU1XjbXxAvOqHzKqteA4dQ1E5Vl4T5
   DB+S8645DdmbroCcmpmeQQIyDxFw7PsYPlVLWPB/GUVtTEGLyqGYsnhsX
   w==;
X-CSE-ConnectionGUID: TPAyURsXT6i7mWa58m2A9Q==
X-CSE-MsgGUID: Um2NysygTd6k1UnGzuxhhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="78254839"
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="78254839"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 08:02:58 -0800
X-CSE-ConnectionGUID: 39qyr14qS/++b1ZG1N6cYw==
X-CSE-MsgGUID: jIX5tVVMRiiaW8bj9/q2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,146,1763452800"; 
   d="scan'208";a="220711697"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Dec 2025 08:02:56 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUS57-000000007qn-3oa2;
	Sat, 13 Dec 2025 16:02:53 +0000
Date: Sun, 14 Dec 2025 00:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.20/cxl-sync-probe] BUILD SUCCESS
 519d0579d32dfd3d2e88469bd3100b1de71245be
Message-ID: <202512140001.Qd5X5lkF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.20/cxl-sync-probe
branch HEAD: 519d0579d32dfd3d2e88469bd3100b1de71245be  cxl/mem: Introduce a memdev creation ->probe() operation

elapsed time: 1453m

configs tested: 280
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251213    gcc-15.1.0
arc                   randconfig-001-20251213    gcc-8.5.0
arc                   randconfig-002-20251213    gcc-15.1.0
arc                   randconfig-002-20251213    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                          exynos_defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                   randconfig-001-20251213    clang-20
arm                   randconfig-001-20251213    gcc-8.5.0
arm                   randconfig-002-20251213    gcc-8.5.0
arm                   randconfig-003-20251213    clang-22
arm                   randconfig-003-20251213    gcc-8.5.0
arm                   randconfig-004-20251213    clang-22
arm                   randconfig-004-20251213    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm                          sp7021_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251213    clang-22
arm64                 randconfig-002-20251213    clang-22
arm64                 randconfig-003-20251213    clang-22
arm64                 randconfig-004-20251213    clang-20
arm64                 randconfig-004-20251213    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251213    clang-22
csky                  randconfig-001-20251213    gcc-15.1.0
csky                  randconfig-002-20251213    clang-22
csky                  randconfig-002-20251213    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251213    clang-22
hexagon               randconfig-001-20251213    gcc-9.5.0
hexagon               randconfig-002-20251213    clang-20
hexagon               randconfig-002-20251213    gcc-9.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251213    clang-20
i386        buildonly-randconfig-002-20251213    clang-20
i386        buildonly-randconfig-002-20251213    gcc-14
i386        buildonly-randconfig-003-20251213    clang-20
i386        buildonly-randconfig-003-20251213    gcc-14
i386        buildonly-randconfig-004-20251213    clang-20
i386        buildonly-randconfig-005-20251213    clang-20
i386        buildonly-randconfig-006-20251213    clang-20
i386        buildonly-randconfig-006-20251213    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251213    clang-20
i386                  randconfig-002-20251213    clang-20
i386                  randconfig-002-20251213    gcc-14
i386                  randconfig-003-20251213    clang-20
i386                  randconfig-003-20251213    gcc-13
i386                  randconfig-004-20251213    clang-20
i386                  randconfig-005-20251213    clang-20
i386                  randconfig-006-20251213    clang-20
i386                  randconfig-006-20251213    gcc-14
i386                  randconfig-007-20251213    clang-20
i386                  randconfig-007-20251213    gcc-14
i386                  randconfig-011-20251213    gcc-14
i386                  randconfig-012-20251213    gcc-14
i386                  randconfig-013-20251213    clang-20
i386                  randconfig-013-20251213    gcc-14
i386                  randconfig-014-20251213    gcc-14
i386                  randconfig-015-20251213    gcc-14
i386                  randconfig-016-20251213    gcc-14
i386                  randconfig-017-20251213    clang-20
i386                  randconfig-017-20251213    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251213    clang-20
loongarch             randconfig-001-20251213    gcc-9.5.0
loongarch             randconfig-002-20251213    clang-20
loongarch             randconfig-002-20251213    gcc-9.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath79_defconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                         10m50_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251213    gcc-9.5.0
nios2                 randconfig-002-20251213    gcc-11.5.0
nios2                 randconfig-002-20251213    gcc-9.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251213    clang-18
parisc                randconfig-001-20251213    gcc-8.5.0
parisc                randconfig-002-20251213    clang-18
parisc                randconfig-002-20251213    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251213    clang-18
powerpc               randconfig-002-20251213    clang-18
powerpc               randconfig-002-20251213    clang-22
powerpc64             randconfig-001-20251213    clang-16
powerpc64             randconfig-001-20251213    clang-18
powerpc64             randconfig-002-20251213    clang-16
powerpc64             randconfig-002-20251213    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251213    clang-16
riscv                 randconfig-001-20251213    clang-22
riscv                 randconfig-002-20251213    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    clang-22
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251213    clang-22
s390                  randconfig-001-20251213    gcc-13.4.0
s390                  randconfig-002-20251213    clang-17
s390                  randconfig-002-20251213    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-22
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251213    clang-22
sh                    randconfig-001-20251213    gcc-15.1.0
sh                    randconfig-002-20251213    clang-22
sh                    randconfig-002-20251213    gcc-10.5.0
sh                           se7343_defconfig    clang-22
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251213    gcc-14.3.0
sparc                 randconfig-002-20251213    gcc-14.3.0
sparc                 randconfig-002-20251213    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251213    gcc-14.3.0
sparc64               randconfig-001-20251213    gcc-15.1.0
sparc64               randconfig-002-20251213    gcc-14.3.0
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251213    clang-22
um                    randconfig-001-20251213    gcc-14.3.0
um                    randconfig-002-20251213    gcc-14
um                    randconfig-002-20251213    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251213    clang-20
x86_64      buildonly-randconfig-002-20251213    clang-20
x86_64      buildonly-randconfig-003-20251213    clang-20
x86_64      buildonly-randconfig-004-20251213    clang-20
x86_64      buildonly-randconfig-005-20251213    clang-20
x86_64      buildonly-randconfig-005-20251213    gcc-14
x86_64      buildonly-randconfig-006-20251213    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251213    gcc-14
x86_64                randconfig-002-20251213    gcc-14
x86_64                randconfig-003-20251213    gcc-14
x86_64                randconfig-004-20251213    clang-20
x86_64                randconfig-004-20251213    gcc-14
x86_64                randconfig-005-20251213    gcc-14
x86_64                randconfig-006-20251213    clang-20
x86_64                randconfig-006-20251213    gcc-14
x86_64                randconfig-011-20251213    clang-20
x86_64                randconfig-011-20251213    gcc-14
x86_64                randconfig-012-20251213    clang-20
x86_64                randconfig-012-20251213    gcc-14
x86_64                randconfig-013-20251213    clang-20
x86_64                randconfig-014-20251213    clang-20
x86_64                randconfig-015-20251213    clang-20
x86_64                randconfig-015-20251213    gcc-14
x86_64                randconfig-016-20251213    clang-20
x86_64                randconfig-071-20251213    clang-20
x86_64                randconfig-072-20251213    clang-20
x86_64                randconfig-073-20251213    clang-20
x86_64                randconfig-074-20251213    clang-20
x86_64                randconfig-074-20251213    gcc-13
x86_64                randconfig-075-20251213    clang-20
x86_64                randconfig-076-20251213    clang-20
x86_64                randconfig-076-20251213    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251213    gcc-14.3.0
xtensa                randconfig-001-20251213    gcc-15.1.0
xtensa                randconfig-002-20251213    gcc-14.3.0
xtensa                randconfig-002-20251213    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
