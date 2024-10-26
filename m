Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83D179958
	for <linux-cxl@vger.kernel.org>; Sat, 26 Oct 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729965440; cv=none; b=b0MUuVK5yj2llW829QcCXFraFYGNgIBMVjr+nwgTHCioDz25Y8sqlEDDZBP8VUIvvuo8osJAkrQDbvfiCols0zYldQ94HvCOhrRt0N9X6+2jzubw2e/r/tLkercf0fvTQ1xa8HVUzlo+ZN7If7Ie8DGS49dHZenX79IRao4Pk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729965440; c=relaxed/simple;
	bh=EaDI9tF7vbqt9wuCJlkTnHD1IGyRw08MHmtWGimA4PY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V5lN4QOauq8oXUizYJsEy+uMGFLDwZlas6U9B+g2kZjyX1lwJInKdll+cjCwvtp77VUVgk6NTyFx/3koQCpw5S9vai29+JWSTijQMC+L5lFo8WRgrS2gstSYe/qPG7h5lnhLIRUTkBxEAHvyBVp6ZQ+cwykAHBVjt2eyHGi0aLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqvxTOs1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqvxTOs1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729965438; x=1761501438;
  h=date:from:to:cc:subject:message-id;
  bh=EaDI9tF7vbqt9wuCJlkTnHD1IGyRw08MHmtWGimA4PY=;
  b=hqvxTOs1kLlLg3nQ+r7/DS59GvwPAmO8Teb5NP4E8HgDMzb1EidXEjZ9
   uj9qI6fYhbNg8gE6mTJZI9c9MnuYQWoDiZ2b50nO7MfL+4AUIch+mQOzi
   NCV1AKWJfI7DxuE1vLtzn/GWeCfR/4kNoM2Vdf1ZJb2uciLcMqaFSgwvD
   ln6uETSLgdLWr6J7CKRodycvYdWW3L1+a52OAban2EwmRouTVDRVGE80D
   m1cCa2RvZ95rLlrGC+kbsUptvVnpF77OpikhV6LwwqU+1Uu1Bym5MmyYS
   CAXGG9MhJyEDfJdn3uBGFRk1JuD2vaFNsatAGcX+DrHwn4/uY1Uq+tXj5
   w==;
X-CSE-ConnectionGUID: sXPfFunjSuargYJQzI5jeQ==
X-CSE-MsgGUID: TbchlLWvS8Cg9y5Qv0kLYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="29508825"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="29508825"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 10:57:17 -0700
X-CSE-ConnectionGUID: AaL5MNTbRIuyEcG3uyKLoQ==
X-CSE-MsgGUID: v7uYVAouSwylnlRdatlIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="112062565"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Oct 2024 10:57:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4l2H-000ZuH-1n;
	Sat, 26 Oct 2024 17:57:13 +0000
Date: Sun, 27 Oct 2024 01:56:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 75c301e57dc1582f62da091e63739d38e0d2e6be
Message-ID: <202410270126.o0FyAiTj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 75c301e57dc1582f62da091e63739d38e0d2e6be  cxl: downgrade a warning message to debug level in cxl_probe_component_regs()

elapsed time: 1167m

configs tested: 275
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20241026    gcc-13.2.0
arc                   randconfig-001-20241026    gcc-14.1.0
arc                   randconfig-002-20241026    gcc-13.2.0
arc                   randconfig-002-20241026    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                     am200epdkit_defconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    clang-20
arm                         axm55xx_defconfig    clang-20
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                          gemini_defconfig    clang-20
arm                           h3600_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.1.0
arm                             mxs_defconfig    clang-20
arm                        neponset_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    clang-20
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    clang-20
arm                   randconfig-002-20241026    gcc-14.1.0
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    clang-20
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    clang-20
arm64                 randconfig-002-20241026    gcc-14.1.0
arm64                 randconfig-003-20241026    clang-20
arm64                 randconfig-003-20241026    gcc-14.1.0
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241026    clang-20
hexagon               randconfig-001-20241026    gcc-14.1.0
hexagon               randconfig-002-20241026    clang-17
hexagon               randconfig-002-20241026    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241026    clang-19
i386        buildonly-randconfig-001-20241026    gcc-12
i386        buildonly-randconfig-002-20241026    clang-19
i386        buildonly-randconfig-002-20241026    gcc-12
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    clang-19
i386        buildonly-randconfig-004-20241026    gcc-12
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    clang-19
i386        buildonly-randconfig-006-20241026    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    clang-19
i386                  randconfig-001-20241026    gcc-12
i386                  randconfig-002-20241026    clang-19
i386                  randconfig-002-20241026    gcc-12
i386                  randconfig-003-20241026    clang-19
i386                  randconfig-003-20241026    gcc-12
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    clang-19
i386                  randconfig-005-20241026    gcc-12
i386                  randconfig-006-20241026    clang-19
i386                  randconfig-006-20241026    gcc-12
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    clang-20
mips                         db1xxx_defconfig    clang-20
mips                          rb532_defconfig    gcc-14.1.0
mips                           xway_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                      chrp32_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-20
powerpc                      katmai_defconfig    clang-20
powerpc                     kmeter1_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-16
powerpc                         ps3_defconfig    clang-20
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    clang-20
powerpc               randconfig-003-20241026    gcc-14.1.0
powerpc                    sam440ep_defconfig    clang-20
powerpc                    socrates_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    clang-20
powerpc64             randconfig-001-20241026    clang-20
powerpc64             randconfig-001-20241026    gcc-14.1.0
powerpc64             randconfig-002-20241026    clang-20
powerpc64             randconfig-002-20241026    gcc-14.1.0
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    clang-20
riscv                 randconfig-002-20241026    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    clang-20
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                          r7785rp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                        sh7757lcr_defconfig    gcc-14.1.0
sparc                            alldefconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    clang-20
um                    randconfig-001-20241026    gcc-14.1.0
um                    randconfig-002-20241026    clang-20
um                    randconfig-002-20241026    gcc-14.1.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241026    clang-19
x86_64      buildonly-randconfig-002-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    gcc-12
x86_64      buildonly-randconfig-004-20241026    clang-19
x86_64      buildonly-randconfig-005-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241026    clang-19
x86_64                randconfig-002-20241026    clang-19
x86_64                randconfig-002-20241026    gcc-12
x86_64                randconfig-003-20241026    clang-19
x86_64                randconfig-003-20241026    gcc-12
x86_64                randconfig-004-20241026    clang-19
x86_64                randconfig-004-20241026    gcc-12
x86_64                randconfig-005-20241026    clang-19
x86_64                randconfig-005-20241026    gcc-12
x86_64                randconfig-006-20241026    clang-19
x86_64                randconfig-006-20241026    gcc-12
x86_64                randconfig-011-20241026    clang-19
x86_64                randconfig-012-20241026    clang-19
x86_64                randconfig-013-20241026    clang-19
x86_64                randconfig-013-20241026    gcc-12
x86_64                randconfig-014-20241026    clang-19
x86_64                randconfig-015-20241026    clang-19
x86_64                randconfig-015-20241026    gcc-12
x86_64                randconfig-016-20241026    clang-19
x86_64                randconfig-071-20241026    clang-19
x86_64                randconfig-072-20241026    clang-19
x86_64                randconfig-073-20241026    clang-19
x86_64                randconfig-074-20241026    clang-19
x86_64                randconfig-075-20241026    clang-19
x86_64                randconfig-076-20241026    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
