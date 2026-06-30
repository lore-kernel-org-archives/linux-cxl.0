Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880D3191BD
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809036; cv=none; b=MoD/4Ofrdx0oml9+HowbfKvN0SkEqT3fTjwC/ibeOAAbbb/W4/4/rkOJFoCW+3EnIkcPxhDH1x6Y6tzmdReaMTZWy3jelbsKnJrRy3dBEA5/c6FCMP6KmfzGKaWaWuzkbV2caD2MhcFWqWDESpXjKx2GpOJPQzN49Gv2O3DVjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809036; c=relaxed/simple;
	bh=/RwrJhAoCm3lsmLrqsK/pS2ycyvNcSfBArqnD3PwxQE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZUtnVPlgpMwiNkJWJupcHOeZkWsKhhLlbA8FBMRQ5OKNFTvI3JYIsSk0UFRpZYcw7tVmvyxccMFFKhC0rkcHUbaObYgk61KAnG51Y6+pDu8f4C0TtIIJmr0NaxHUlbIULKNyUBQvcH4kBEvJ72tf9aeoDyBwt1M/AZh+dFLcXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeBk1KOg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeBk1KOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782809034; x=1814345034;
  h=date:from:to:cc:subject:message-id;
  bh=/RwrJhAoCm3lsmLrqsK/pS2ycyvNcSfBArqnD3PwxQE=;
  b=IeBk1KOgnqyvU+ms7G/Xi3vHWV6XN6oARch7RLCwhzBSL7FNUGImNGuo
   CnzSJrHLQVsvF6r1xPNSvqq8FeB41dXfY/hq9EE7atK0CV/3rZFEI0M3D
   ZV06SuF4VGyudQytsMqaLykTJFKOEscNx7ivJtEYrYzwd32BQP4+xmZvn
   Gwr6umMfshaD6bklD7IcBcYszjCiqx30ovFpvPSvOBR20PDhRookvHLMt
   HphMgXbucZ0mUWzgYmN9l6WFkuVAefP/P3kUeOETT20dZZW/aAqn8s1ej
   JdVVFp7xAyrMSYYCHA1Dsz97jHHrif/g0FkkbKrEABvML/3KbP3EcIHqm
   A==;
X-CSE-ConnectionGUID: RdTooU6FQ5SqBxV/DiprXA==
X-CSE-MsgGUID: JgsAgS35Tm6hZ2DdqZXdtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94666314"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94666314"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 01:43:54 -0700
X-CSE-ConnectionGUID: i46DbSVQS8mx27NmdIv8lQ==
X-CSE-MsgGUID: HodJkaV1RLirjM2Z/aE+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="256598895"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 30 Jun 2026 01:43:52 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1weU4L-0000000089r-0Tz9;
	Tue, 30 Jun 2026 08:43:49 +0000
Date: Tue, 30 Jun 2026 16:42:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.3/cxl-type2-support] BUILD SUCCESS
 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6
Message-ID: <202606301638.NGQLXGZt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.3/cxl-type2-support
branch HEAD: 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6  cxl: Support dpa without a mailbox

elapsed time: 754m

configs tested: 278
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260630    clang-23
arc                   randconfig-001-20260630    gcc-12.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260630    clang-23
arc                   randconfig-002-20260630    gcc-10.5.0
arc                    vdk_hs38_smp_defconfig    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260630    clang-23
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260630    clang-23
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260630    clang-23
arm                   randconfig-003-20260630    gcc-8.5.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260630    clang-23
arm                   randconfig-004-20260630    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260630    clang-17
arm64                 randconfig-001-20260630    clang-23
arm64                 randconfig-002-20260630    clang-23
arm64                 randconfig-003-20260630    clang-23
arm64                 randconfig-004-20260630    clang-23
arm64                 randconfig-004-20260630    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260630    clang-23
csky                  randconfig-001-20260630    gcc-14.3.0
csky                  randconfig-002-20260630    clang-23
csky                  randconfig-002-20260630    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260630    clang-18
hexagon               randconfig-002-20260630    clang-18
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260630    clang-22
i386        buildonly-randconfig-002-20260630    clang-22
i386        buildonly-randconfig-003-20260630    clang-22
i386        buildonly-randconfig-003-20260630    gcc-13
i386        buildonly-randconfig-004-20260630    clang-22
i386        buildonly-randconfig-005-20260630    clang-22
i386        buildonly-randconfig-006-20260630    clang-22
i386        buildonly-randconfig-006-20260630    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260630    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260630    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260630    clang-22
i386                  randconfig-003-20260630    gcc-14
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260630    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260630    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260630    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260630    clang-22
i386                  randconfig-011-20260630    gcc-12
i386                  randconfig-011-20260630    gcc-14
i386                  randconfig-012-20260630    clang-22
i386                  randconfig-012-20260630    gcc-12
i386                  randconfig-013-20260630    gcc-12
i386                  randconfig-014-20260630    clang-22
i386                  randconfig-014-20260630    gcc-12
i386                  randconfig-015-20260630    gcc-12
i386                  randconfig-015-20260630    gcc-14
i386                  randconfig-016-20260630    gcc-12
i386                  randconfig-017-20260630    clang-22
i386                  randconfig-017-20260630    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260630    clang-18
loongarch             randconfig-002-20260630    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      bmips_stb_defconfig    clang-17
mips                      malta_kvm_defconfig    gcc-16.1.0
mips                        maltaup_defconfig    clang-17
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260630    clang-18
nios2                 randconfig-002-20260630    clang-18
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-22
parisc                randconfig-001-20260630    clang-22
parisc                         randconfig-002    clang-22
parisc                randconfig-002-20260630    clang-22
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    clang-22
powerpc               randconfig-001-20260630    clang-22
powerpc                        randconfig-002    clang-22
powerpc               randconfig-002-20260630    clang-22
powerpc                        warp_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    clang-22
powerpc64             randconfig-001-20260630    clang-22
powerpc64                      randconfig-002    clang-22
powerpc64             randconfig-002-20260630    clang-22
riscv                            alldefconfig    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260630    gcc-9.5.0
riscv                 randconfig-002-20260630    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260630    gcc-9.5.0
s390                  randconfig-002-20260630    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260630    gcc-9.5.0
sh                    randconfig-002-20260630    gcc-9.5.0
sh                          rsk7201_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260630    clang-17
sparc                 randconfig-001-20260630    gcc-8.5.0
sparc                 randconfig-002-20260630    clang-17
sparc                 randconfig-002-20260630    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260630    clang-17
sparc64               randconfig-001-20260630    gcc-11.5.0
sparc64               randconfig-002-20260630    clang-17
sparc64               randconfig-002-20260630    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260630    clang-17
um                    randconfig-002-20260630    clang-17
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260630    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260630    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260630    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260630    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260630    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260630    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260630    clang-22
x86_64                randconfig-001-20260630    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260630    clang-22
x86_64                randconfig-002-20260630    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260630    clang-22
x86_64                randconfig-003-20260630    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260630    clang-22
x86_64                randconfig-004-20260630    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260630    clang-22
x86_64                randconfig-005-20260630    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260630    gcc-14
x86_64                randconfig-011-20260630    clang-22
x86_64                randconfig-011-20260630    gcc-14
x86_64                randconfig-012-20260630    gcc-14
x86_64                randconfig-013-20260630    gcc-14
x86_64                randconfig-014-20260630    clang-22
x86_64                randconfig-014-20260630    gcc-14
x86_64                randconfig-015-20260630    clang-22
x86_64                randconfig-015-20260630    gcc-14
x86_64                randconfig-016-20260630    gcc-14
x86_64                randconfig-071-20260630    clang-22
x86_64                randconfig-071-20260630    gcc-14
x86_64                randconfig-072-20260630    clang-22
x86_64                randconfig-072-20260630    gcc-14
x86_64                randconfig-073-20260630    clang-22
x86_64                randconfig-074-20260630    clang-22
x86_64                randconfig-075-20260630    clang-22
x86_64                randconfig-075-20260630    gcc-14
x86_64                randconfig-076-20260630    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260630    clang-17
xtensa                randconfig-001-20260630    gcc-15.2.0
xtensa                randconfig-002-20260630    clang-17
xtensa                randconfig-002-20260630    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
