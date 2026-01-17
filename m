Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87202857FC
	for <linux-cxl@vger.kernel.org>; Sat, 17 Jan 2026 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768634810; cv=none; b=INPrUGW97W9qVqeF9Lwk5PmEeKu8aKaD2/tShn4wx2nDaqFScb9ERLJgFEJ3h/8J8LPocPeRe1Y8wVRFiV4GnqyBR3FyeRQYxQFrJZvDd83VqZo9poOLack1DqII3WHpLonBfHHeKD4nz1YtbiWVXVfL/XcgNenVUl9gGpl6Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768634810; c=relaxed/simple;
	bh=SYZ1vSJjeBd6idvzO3ZkHpw916Eu7ZPUjv4ovHZjjyg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ULi7eaRoyiQ3HfQR4sHp+DaNUSLQ2hayGaNKnRQFmvn1GliPlhaM3L2oNFa9gtEIp7jfr5aEnt8t0ZGO4ijVIiK/YNgz/H5HjB0Cg1vE6ArpyW77Evo+5gOWB8Der+8ZZ/c+9NJM1kGforU0hIaFrIGPadTnivfny8gzGG/4kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMKfdqlL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMKfdqlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768634807; x=1800170807;
  h=date:from:to:cc:subject:message-id;
  bh=SYZ1vSJjeBd6idvzO3ZkHpw916Eu7ZPUjv4ovHZjjyg=;
  b=kMKfdqlLKX1GuVtsENZ4blZMyldJzrk8ofx3QgBuxAtX7wOoyu/cWyft
   JhRycHkrZuRbodbYDqVrPr9I2j9XxGR8kDo1fvI2wGd7rAWPXoZ+vMSb8
   HvAzVWCUscy6+pn3Fm/r76TDN8EFGQhSx5OKke8VeclCnbQa5DAoF3h4i
   +zlis6t2ntxq/3b7ZHafq/Ze0yezyj2LrVvXoOTGa/BigrQmEmEY3wf26
   ib5AzYD/+d6lp3LH5nRampEl7WbS9UaNzszkyfc4BuPYmLAaI5/ZwTkHx
   QaA2VKzChlqL0gu3+Rr38v7mhDK2DAqIK3RdGFgBWvJ9nmmgB2LycffsE
   A==;
X-CSE-ConnectionGUID: PeyHYXZAQ/aZNVG/6XSZQQ==
X-CSE-MsgGUID: r0k6VPGVQxuUS/wP006qeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="87354255"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="87354255"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 23:26:46 -0800
X-CSE-ConnectionGUID: Q4j3BnI+TWWdkrVykaPzTA==
X-CSE-MsgGUID: 5qdmHx0UQ+Sli0QHiefyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="204665913"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2026 23:26:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh0hl-00000000Lea-2qfX;
	Sat, 17 Jan 2026 07:26:41 +0000
Date: Sat, 17 Jan 2026 15:25:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 78b50b5984629d362f826e9615ce4599f429716e
Message-ID: <202601171545.I5nUXY4r-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 78b50b5984629d362f826e9615ce4599f429716e  cxl/region: Translate HPA to DPA and memdev in unaligned regions

elapsed time: 903m

configs tested: 279
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs103_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    clang-22
arc                   randconfig-001-20260117    gcc-12.5.0
arc                   randconfig-001-20260117    gcc-8.5.0
arc                   randconfig-002-20260117    gcc-12.5.0
arc                   randconfig-002-20260117    gcc-9.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260117    clang-20
arm                   randconfig-001-20260117    gcc-12.5.0
arm                   randconfig-002-20260117    gcc-12.5.0
arm                   randconfig-002-20260117    gcc-8.5.0
arm                   randconfig-003-20260117    gcc-12.5.0
arm                   randconfig-003-20260117    gcc-8.5.0
arm                   randconfig-004-20260117    gcc-12.5.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           stm32_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260117    clang-22
arm64                 randconfig-001-20260117    gcc-15.2.0
arm64                 randconfig-002-20260117    clang-22
arm64                 randconfig-003-20260117    clang-18
arm64                 randconfig-003-20260117    clang-22
arm64                 randconfig-004-20260117    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260117    clang-22
csky                  randconfig-001-20260117    gcc-12.5.0
csky                  randconfig-002-20260117    clang-22
csky                  randconfig-002-20260117    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260117    clang-22
hexagon               randconfig-002-20260117    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260117    clang-20
i386        buildonly-randconfig-001-20260117    gcc-13
i386        buildonly-randconfig-002-20260117    gcc-13
i386        buildonly-randconfig-003-20260117    gcc-13
i386        buildonly-randconfig-004-20260117    clang-20
i386        buildonly-randconfig-004-20260117    gcc-13
i386        buildonly-randconfig-005-20260117    gcc-13
i386        buildonly-randconfig-006-20260117    clang-20
i386        buildonly-randconfig-006-20260117    gcc-13
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260117    gcc-13
i386                  randconfig-001-20260117    gcc-14
i386                  randconfig-002-20260117    gcc-14
i386                  randconfig-003-20260117    clang-20
i386                  randconfig-003-20260117    gcc-14
i386                  randconfig-004-20260117    gcc-14
i386                  randconfig-005-20260117    clang-20
i386                  randconfig-005-20260117    gcc-14
i386                  randconfig-006-20260117    clang-20
i386                  randconfig-006-20260117    gcc-14
i386                  randconfig-007-20260117    clang-20
i386                  randconfig-007-20260117    gcc-14
i386                  randconfig-011-20260117    clang-20
i386                  randconfig-011-20260117    gcc-14
i386                  randconfig-012-20260117    gcc-14
i386                  randconfig-013-20260117    gcc-14
i386                  randconfig-014-20260117    gcc-14
i386                  randconfig-015-20260117    gcc-12
i386                  randconfig-015-20260117    gcc-14
i386                  randconfig-016-20260117    clang-20
i386                  randconfig-016-20260117    gcc-14
i386                  randconfig-017-20260117    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260117    clang-20
loongarch             randconfig-001-20260117    clang-22
loongarch             randconfig-002-20260117    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    clang-22
mips                           ip30_defconfig    clang-22
mips                      loongson3_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
mips                           rs90_defconfig    gcc-15.2.0
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260117    clang-22
nios2                 randconfig-001-20260117    gcc-8.5.0
nios2                 randconfig-002-20260117    clang-22
nios2                 randconfig-002-20260117    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260117    clang-22
parisc                randconfig-001-20260117    gcc-12.5.0
parisc                randconfig-002-20260117    clang-22
parisc                randconfig-002-20260117    gcc-15.2.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260117    clang-22
powerpc               randconfig-001-20260117    gcc-8.5.0
powerpc               randconfig-002-20260117    clang-22
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20260117    clang-22
powerpc64             randconfig-002-20260117    clang-22
powerpc64             randconfig-002-20260117    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260117    clang-22
riscv                 randconfig-001-20260117    gcc-10.5.0
riscv                 randconfig-002-20260117    clang-17
riscv                 randconfig-002-20260117    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260117    clang-22
s390                  randconfig-001-20260117    gcc-10.5.0
s390                  randconfig-002-20260117    clang-22
s390                  randconfig-002-20260117    gcc-10.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7751_defconfig    clang-22
sh                   secureedge5410_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260117    gcc-14.3.0
sparc                 randconfig-001-20260117    gcc-8.5.0
sparc                 randconfig-002-20260117    gcc-14.3.0
sparc                 randconfig-002-20260117    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260117    clang-22
um                    randconfig-001-20260117    gcc-14.3.0
um                    randconfig-002-20260117    clang-22
um                    randconfig-002-20260117    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260117    clang-20
x86_64      buildonly-randconfig-002-20260117    clang-20
x86_64      buildonly-randconfig-003-20260117    clang-20
x86_64      buildonly-randconfig-004-20260117    clang-20
x86_64      buildonly-randconfig-005-20260117    clang-20
x86_64      buildonly-randconfig-006-20260117    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260117    clang-20
x86_64                randconfig-002-20260117    clang-20
x86_64                randconfig-003-20260117    clang-20
x86_64                randconfig-004-20260117    clang-20
x86_64                randconfig-005-20260117    clang-20
x86_64                randconfig-005-20260117    gcc-12
x86_64                randconfig-006-20260117    clang-20
x86_64                randconfig-006-20260117    gcc-14
x86_64                randconfig-011-20260117    clang-20
x86_64                randconfig-012-20260117    clang-20
x86_64                randconfig-013-20260117    clang-20
x86_64                randconfig-014-20260117    clang-20
x86_64                randconfig-015-20260117    clang-20
x86_64                randconfig-015-20260117    gcc-14
x86_64                randconfig-016-20260117    clang-20
x86_64                randconfig-071-20260117    clang-20
x86_64                randconfig-072-20260117    clang-20
x86_64                randconfig-072-20260117    gcc-13
x86_64                randconfig-073-20260117    clang-20
x86_64                randconfig-074-20260117    clang-20
x86_64                randconfig-075-20260117    clang-20
x86_64                randconfig-076-20260117    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260117    gcc-10.5.0
xtensa                randconfig-001-20260117    gcc-14.3.0
xtensa                randconfig-002-20260117    gcc-13.4.0
xtensa                randconfig-002-20260117    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
