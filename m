Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26E3594F
	for <linux-cxl@vger.kernel.org>; Sat, 15 Nov 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245863; cv=none; b=fO2qyl/tTQ4Q6HDHtsDYiIRr6BBdPok5Y+hwUVdRW2tPprqXKJuB8cwNQszGJ7pkdZW6S7fo2nSsDz2lFxbHH7yXFkXjmDlhx6fA6an3YUmkHH1rt4V8mPkI5+gHw43HsPgdngQFbE5Xhek+LzrE4VI7R/4vdEFNu35DNbZ16ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245863; c=relaxed/simple;
	bh=acx0bK2lewVqVD543IljjnJtimVelSsl9W3ZDQq2QaE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A+TkQnTYRZm7cf2fShSx/OHayMBHQA5ioGxxxfuHhBgJE12f0/tNGM/4aumsskJS0JVMoQ2ZwoOjpXfBo6DbDHqZC6ojK+VbMiCLxG44kx/FRfJyTad/GDuIDhg0m9QHmiXd07XSnPq4Qtnr7/+2/dUsMGzoVagl8lXYE4q1kRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrbnhOwM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrbnhOwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763245862; x=1794781862;
  h=date:from:to:cc:subject:message-id;
  bh=acx0bK2lewVqVD543IljjnJtimVelSsl9W3ZDQq2QaE=;
  b=VrbnhOwMyqyvYSMN/R0NszwVQj1lVoq91qgDSfFL+yRgy4H3g+CPxHvD
   RRB4oi7dJ+D6csm94k0A/+c//BlLAedrUXoD10CBBQ+9rtiMb3y5SBLd3
   0z0jHkyi9fAq3BaaREDo4Fgp9wMVZNg7Uvzh9OBANt0TNszJ5exkiaK1D
   0et2eKtZGaGHfJUFyKcRLU42He21m51y+ytUHtVZ5YTE6uKHPVCUjUCSs
   J1yn5+DzoSEW3DlZvvKtg1VdWhxb7BpoOFUJQ8rKQEw538klXX37VjI1r
   YhdvNxLfinvCq0HJZsxYjoDKNszu+jETnwrp1wTlnqZFZdNojEMYvrdpo
   Q==;
X-CSE-ConnectionGUID: uh25OzWgR5CoIzAIKtPYag==
X-CSE-MsgGUID: vAtgoqErTRmV/2NRQWGABw==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="90775051"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="90775051"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 14:31:01 -0800
X-CSE-ConnectionGUID: cwz/T8abSDuwol8R0PqTyA==
X-CSE-MsgGUID: f/1HWyk0TvWei8pDFq2OdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="220767725"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2025 14:30:59 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKOnI-0008J5-24;
	Sat, 15 Nov 2025 22:30:56 +0000
Date: Sun, 16 Nov 2025 06:30:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.19/cxl-prm] BUILD SUCCESS
 7e71fa6e015e46275efd900a728a42d5fcd75179
Message-ID: <202511160605.PQbdWVie-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.19/cxl-prm
branch HEAD: 7e71fa6e015e46275efd900a728a42d5fcd75179  cxl/region: Remove local variable @inc in cxl_port_setup_targets()

elapsed time: 1615m

configs tested: 175
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251115    gcc-13.4.0
arc                   randconfig-002-20251115    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251115    clang-22
arm                   randconfig-002-20251115    gcc-8.5.0
arm                   randconfig-003-20251115    gcc-10.5.0
arm                   randconfig-004-20251115    clang-22
arm                          sp7021_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251115    gcc-8.5.0
arm64                 randconfig-002-20251115    clang-18
arm64                 randconfig-003-20251115    gcc-13.4.0
arm64                 randconfig-004-20251115    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251115    gcc-15.1.0
csky                  randconfig-002-20251115    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251115    clang-16
hexagon               randconfig-002-20251115    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251115    gcc-14
i386        buildonly-randconfig-002-20251115    gcc-14
i386        buildonly-randconfig-003-20251115    clang-20
i386        buildonly-randconfig-004-20251115    clang-20
i386        buildonly-randconfig-005-20251115    clang-20
i386        buildonly-randconfig-006-20251115    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251115    gcc-14
i386                  randconfig-002-20251115    clang-20
i386                  randconfig-003-20251115    clang-20
i386                  randconfig-004-20251115    clang-20
i386                  randconfig-005-20251115    gcc-14
i386                  randconfig-006-20251115    gcc-14
i386                  randconfig-007-20251115    gcc-14
i386                  randconfig-011-20251115    clang-20
i386                  randconfig-012-20251115    gcc-14
i386                  randconfig-013-20251115    gcc-14
i386                  randconfig-014-20251115    clang-20
i386                  randconfig-015-20251115    clang-20
i386                  randconfig-016-20251115    clang-20
i386                  randconfig-017-20251115    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251115    clang-18
loongarch             randconfig-002-20251115    gcc-13.4.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251115    gcc-8.5.0
nios2                 randconfig-002-20251115    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251115    gcc-8.5.0
parisc                randconfig-002-20251115    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251115    clang-19
powerpc               randconfig-002-20251115    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251115    gcc-11.5.0
powerpc64             randconfig-002-20251115    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251115    clang-22
riscv                 randconfig-002-20251115    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251115    clang-17
s390                  randconfig-002-20251115    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251115    gcc-12.5.0
sh                    randconfig-002-20251115    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251115    gcc-13.4.0
sparc                 randconfig-002-20251115    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251115    gcc-9.5.0
sparc64               randconfig-002-20251115    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251115    gcc-14
um                    randconfig-002-20251115    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251115    gcc-14
x86_64      buildonly-randconfig-002-20251115    gcc-12
x86_64      buildonly-randconfig-003-20251115    gcc-14
x86_64      buildonly-randconfig-004-20251115    gcc-14
x86_64      buildonly-randconfig-005-20251115    gcc-12
x86_64      buildonly-randconfig-006-20251115    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251115    gcc-14
x86_64                randconfig-002-20251115    clang-20
x86_64                randconfig-003-20251115    clang-20
x86_64                randconfig-004-20251115    clang-20
x86_64                randconfig-005-20251115    clang-20
x86_64                randconfig-006-20251115    gcc-13
x86_64                randconfig-071-20251115    gcc-14
x86_64                randconfig-072-20251115    clang-20
x86_64                randconfig-073-20251115    gcc-14
x86_64                randconfig-074-20251115    clang-20
x86_64                randconfig-075-20251115    clang-20
x86_64                randconfig-076-20251115    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251115    gcc-8.5.0
xtensa                randconfig-002-20251115    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
