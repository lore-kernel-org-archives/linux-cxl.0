Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94144DD6E2
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097139; cv=none; b=H/5BPIbYX3kL5sBeD1d6ROr8RurSyhVfoDiLQFqjRfYX3VTceCF5VmYslfyygzLgyUE3xFGbwFkg1aCYwBV1xEi9yL/Uo7cfL59f92pXym1mFKihbhxfzMZrkRJzQ02OmWoPZcNxnBboDUfVQvwJPFIHUMcqeEzfw+9wU86QZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097139; c=relaxed/simple;
	bh=twcKSjlbdSCaIWnauzlE3gHKEWeJe9AdWSSPsN6DGUA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IN4S226/DKqRdr5hGgy4sJLy6i2xMZso5A7wMO0Kpt611xb+4lnAxWjNMGXW/usIzOyGtEzyr+CBjnLT92XDzPvUG354D1dUY2c5yyJ7GJ1AM6+ZPYbnyXqiABOvnBpaGpxh6o/MdpjNL9B1VtLj6m8qBGa5OCZlc1dMWfCr6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QO/zFKPY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QO/zFKPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769097133; x=1800633133;
  h=date:from:to:cc:subject:message-id;
  bh=twcKSjlbdSCaIWnauzlE3gHKEWeJe9AdWSSPsN6DGUA=;
  b=QO/zFKPY+hjhXkAsltL/ReXRhxyQDjl/zhq4JXd3VZQpXRRRUhUBTj+r
   dBQz45B1kbaWDNus4Lf0dGlzDT0muOgg1wNPWJPT45yKMTIzzd4X3wyUf
   CkLmbDa09bxmJd0o5C73NYrhOzoRKwmSg5pddaunnoDedjD5v1AU2j93J
   o9ExtE5P4xUh1Ruyh7B6ImAFC/6KZ2M+BFt8HOUCdc+yqjWhBsZBdCydr
   6IYPawRTz4yUuimK2zE2gyxREgx5JChEfhU85CIGqs28aM/J55PmNTpv7
   iPzy5xXiNcbTvs1RczDFHPTFJJ5auSOq0u7SoLMuZ8ia16dHnr68F1bhA
   g==;
X-CSE-ConnectionGUID: jnzOUg/SQ5yaOHvj5C8Mew==
X-CSE-MsgGUID: XjbnoPRkTcGwaeorSV+pvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70399490"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70399490"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:52:10 -0800
X-CSE-ConnectionGUID: jSSoSn5pRUmTmpJH2C6A+A==
X-CSE-MsgGUID: gjj0GC8VSdiUMW87tBgKKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206813404"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Jan 2026 07:52:07 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viwyb-00000000Sz8-1Scs;
	Thu, 22 Jan 2026 15:52:05 +0000
Date: Thu, 22 Jan 2026 23:51:38 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.0/cxl-aer-prep] BUILD SUCCESS
 c61e99a20e7390bf8727a3b2cacbc00931b05d0b
Message-ID: <202601222333.R1WvivGG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.0/cxl-aer-prep
branch HEAD: c61e99a20e7390bf8727a3b2cacbc00931b05d0b  cxl: Update RAS handler interfaces to also support CXL Ports

elapsed time: 748m

configs tested: 280
configs skipped: 4

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
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260122    gcc-14.3.0
arc                   randconfig-001-20260122    gcc-15.2.0
arc                   randconfig-002-20260122    gcc-15.2.0
arc                           tb10x_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20260122    clang-22
arm                   randconfig-001-20260122    gcc-15.2.0
arm                   randconfig-002-20260122    gcc-11.5.0
arm                   randconfig-002-20260122    gcc-15.2.0
arm                   randconfig-003-20260122    gcc-15.2.0
arm                   randconfig-004-20260122    gcc-13.4.0
arm                   randconfig-004-20260122    gcc-15.2.0
arm                           sama7_defconfig    clang-22
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260122    clang-22
arm64                 randconfig-001-20260122    gcc-15.2.0
arm64                 randconfig-002-20260122    clang-20
arm64                 randconfig-002-20260122    gcc-15.2.0
arm64                 randconfig-003-20260122    clang-22
arm64                 randconfig-003-20260122    gcc-15.2.0
arm64                 randconfig-004-20260122    clang-22
arm64                 randconfig-004-20260122    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260122    gcc-12.5.0
csky                  randconfig-001-20260122    gcc-15.2.0
csky                  randconfig-002-20260122    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260122    clang-20
hexagon               randconfig-001-20260122    gcc-15.2.0
hexagon               randconfig-002-20260122    clang-22
hexagon               randconfig-002-20260122    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260122    clang-20
i386        buildonly-randconfig-002-20260122    clang-20
i386        buildonly-randconfig-002-20260122    gcc-14
i386        buildonly-randconfig-003-20260122    clang-20
i386        buildonly-randconfig-003-20260122    gcc-14
i386        buildonly-randconfig-004-20260122    clang-20
i386        buildonly-randconfig-004-20260122    gcc-14
i386        buildonly-randconfig-005-20260122    clang-20
i386        buildonly-randconfig-005-20260122    gcc-14
i386        buildonly-randconfig-006-20260122    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260122    gcc-14
i386                  randconfig-002-20260122    clang-20
i386                  randconfig-002-20260122    gcc-14
i386                  randconfig-003-20260122    gcc-12
i386                  randconfig-003-20260122    gcc-14
i386                  randconfig-004-20260122    gcc-14
i386                  randconfig-005-20260122    gcc-14
i386                  randconfig-006-20260122    gcc-14
i386                  randconfig-007-20260122    gcc-14
i386                  randconfig-011-20260122    clang-20
i386                  randconfig-012-20260122    clang-20
i386                  randconfig-013-20260122    clang-20
i386                  randconfig-014-20260122    clang-20
i386                  randconfig-015-20260122    clang-20
i386                  randconfig-016-20260122    clang-20
i386                  randconfig-017-20260122    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260122    gcc-15.2.0
loongarch             randconfig-002-20260122    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    clang-22
mips                       lemote2f_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260122    gcc-11.5.0
nios2                 randconfig-001-20260122    gcc-15.2.0
nios2                 randconfig-002-20260122    gcc-15.2.0
nios2                 randconfig-002-20260122    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260122    gcc-10.5.0
parisc                randconfig-002-20260122    gcc-10.5.0
parisc                randconfig-002-20260122    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    clang-22
powerpc                     powernv_defconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260122    gcc-10.5.0
powerpc               randconfig-001-20260122    gcc-14.3.0
powerpc               randconfig-002-20260122    clang-22
powerpc               randconfig-002-20260122    gcc-10.5.0
powerpc64             randconfig-001-20260122    clang-18
powerpc64             randconfig-001-20260122    gcc-10.5.0
powerpc64             randconfig-002-20260122    gcc-10.5.0
powerpc64             randconfig-002-20260122    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260122    clang-18
riscv                 randconfig-002-20260122    clang-18
riscv                 randconfig-002-20260122    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260122    clang-18
s390                  randconfig-001-20260122    gcc-8.5.0
s390                  randconfig-002-20260122    clang-18
s390                  randconfig-002-20260122    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260122    clang-18
sh                    randconfig-001-20260122    gcc-15.2.0
sh                    randconfig-002-20260122    clang-18
sh                    randconfig-002-20260122    gcc-11.5.0
sh                           se7206_defconfig    clang-22
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sh                             sh03_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260122    gcc-14.3.0
sparc                 randconfig-001-20260122    gcc-8.5.0
sparc                 randconfig-002-20260122    gcc-8.5.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260122    clang-22
sparc64               randconfig-001-20260122    gcc-8.5.0
sparc64               randconfig-002-20260122    clang-20
sparc64               randconfig-002-20260122    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260122    clang-22
um                    randconfig-001-20260122    gcc-8.5.0
um                    randconfig-002-20260122    gcc-14
um                    randconfig-002-20260122    gcc-8.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260122    clang-20
x86_64      buildonly-randconfig-002-20260122    clang-20
x86_64      buildonly-randconfig-003-20260122    clang-20
x86_64      buildonly-randconfig-004-20260122    clang-20
x86_64      buildonly-randconfig-004-20260122    gcc-14
x86_64      buildonly-randconfig-005-20260122    clang-20
x86_64      buildonly-randconfig-006-20260122    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260122    clang-20
x86_64                randconfig-001-20260122    gcc-14
x86_64                randconfig-002-20260122    clang-20
x86_64                randconfig-002-20260122    gcc-13
x86_64                randconfig-003-20260122    clang-20
x86_64                randconfig-004-20260122    clang-20
x86_64                randconfig-005-20260122    clang-20
x86_64                randconfig-006-20260122    clang-20
x86_64                randconfig-006-20260122    gcc-14
x86_64                randconfig-011-20260122    clang-20
x86_64                randconfig-011-20260122    gcc-14
x86_64                randconfig-012-20260122    clang-20
x86_64                randconfig-012-20260122    gcc-14
x86_64                randconfig-013-20260122    clang-20
x86_64                randconfig-014-20260122    clang-20
x86_64                randconfig-015-20260122    clang-20
x86_64                randconfig-016-20260122    clang-20
x86_64                randconfig-016-20260122    gcc-14
x86_64                randconfig-071-20260122    clang-20
x86_64                randconfig-072-20260122    clang-20
x86_64                randconfig-073-20260122    clang-20
x86_64                randconfig-073-20260122    gcc-14
x86_64                randconfig-074-20260122    clang-20
x86_64                randconfig-075-20260122    clang-20
x86_64                randconfig-075-20260122    gcc-14
x86_64                randconfig-076-20260122    clang-20
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260122    gcc-8.5.0
xtensa                randconfig-002-20260122    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
