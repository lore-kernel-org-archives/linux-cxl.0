Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728935CB75
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283023; cv=none; b=FXUq4pGeXaNYh2mDNuQQ7GP+G6xJEOjLgXPkaHgBHMpfuxapWVjrJAHwDCmedZbv40W04BvNC/Sv/O7w4I7lGAwG50GGT4A1oQbrw6SjghR+d8agYy+l5FArnUyhxMFC0VFRptZuKpFrgAaR/Ix58SeiHLzCzh6lygS4rTwO8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283023; c=relaxed/simple;
	bh=HQBu64N/NMQ/4MDm/MaSQwSkcattGKHujzxRJX9wLQs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AwoxsJpdLUPKRAEJYd0NsxY3aWvwBMgowD1Yo6WXV5rNJEHa+3LAmLYjYQCMrwMluhsX6U2wxERUKt3yf/HxEzmMAlHNLlAkWo7Pt1DkCJDBxUblYwAnlB+qDmoJc0QYpwAF+lmxCqOJ7BlyffeBVpUryRSgZlAgNf4VlMKjykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPqmXxBR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPqmXxBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770283023; x=1801819023;
  h=date:from:to:cc:subject:message-id;
  bh=HQBu64N/NMQ/4MDm/MaSQwSkcattGKHujzxRJX9wLQs=;
  b=JPqmXxBRAskMvLHSs4ytLAW50jfchsNGUfdkcvV5udYywcPK9uiUJ5gp
   faPT9BKiFx7sPMepb8QKvhnNH/f8PeflwGK2N4W6jlQ0wTJEsQ3j+lwNa
   QnentX9e6oB5QqlLiGjLtoXBVKyympFYUmOTs0y3/RXYcMuAlIelGBPpg
   TVTQpILKEQRFIjB7cKY7nirgUwLfSJs+UqCTERK9OZ06ZEkHSqiWUaOZH
   Z8zfKPfAKQnbfGbd8E4fZGOfJpCC6WAZCmkxGAsW5AqAXaVGpSwr7U6lM
   2hL/U2DjafR0JAqBJW9u6m1JF/v+JfKJQRiUhZ0iBcBMdtJPOOEafK2rC
   Q==;
X-CSE-ConnectionGUID: ojuSjXxTTBiGuUiW29Mejw==
X-CSE-MsgGUID: QliYgYNcTHa3UJtEGZMbVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96935498"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="96935498"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 01:17:02 -0800
X-CSE-ConnectionGUID: u0nCMr0KSie/d6mJQL5Ijg==
X-CSE-MsgGUID: KI9ol2RrRVG6/z2kBvnXLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210395196"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2026 01:17:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnvTt-00000000jfE-3rFJ;
	Thu, 05 Feb 2026 09:16:57 +0000
Date: Thu, 05 Feb 2026 17:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
Message-ID: <202602051752.udbjcJS9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23  Merge branch 'for-7.0/cxl-prm-translation' into cxl-for-next

elapsed time: 891m

configs tested: 272
configs skipped: 10

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
arc                   randconfig-001-20260205    gcc-8.5.0
arc                   randconfig-002-20260205    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20260205    clang-22
arm                   randconfig-001-20260205    gcc-8.5.0
arm                   randconfig-002-20260205    gcc-8.5.0
arm                   randconfig-003-20260205    clang-22
arm                   randconfig-003-20260205    gcc-8.5.0
arm                   randconfig-004-20260205    gcc-8.5.0
arm                           sunxi_defconfig    gcc-15.2.0
arm64                            alldefconfig    gcc-14
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260205    clang-22
arm64                 randconfig-001-20260205    gcc-10.5.0
arm64                 randconfig-002-20260205    gcc-10.5.0
arm64                 randconfig-003-20260205    clang-22
arm64                 randconfig-003-20260205    gcc-10.5.0
arm64                 randconfig-004-20260205    clang-19
arm64                 randconfig-004-20260205    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260205    gcc-10.5.0
csky                  randconfig-001-20260205    gcc-9.5.0
csky                  randconfig-002-20260205    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260205    clang-22
hexagon               randconfig-001-20260205    gcc-15.2.0
hexagon               randconfig-002-20260205    clang-22
hexagon               randconfig-002-20260205    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260205    gcc-13
i386        buildonly-randconfig-001-20260205    gcc-14
i386        buildonly-randconfig-002-20260205    clang-20
i386        buildonly-randconfig-002-20260205    gcc-14
i386        buildonly-randconfig-003-20260205    clang-20
i386        buildonly-randconfig-003-20260205    gcc-14
i386        buildonly-randconfig-004-20260205    clang-20
i386        buildonly-randconfig-004-20260205    gcc-14
i386        buildonly-randconfig-005-20260205    gcc-14
i386        buildonly-randconfig-006-20260205    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260205    gcc-13
i386                  randconfig-001-20260205    gcc-14
i386                  randconfig-002-20260205    clang-20
i386                  randconfig-002-20260205    gcc-13
i386                  randconfig-003-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-13
i386                  randconfig-004-20260205    gcc-14
i386                  randconfig-005-20260205    clang-20
i386                  randconfig-005-20260205    gcc-13
i386                  randconfig-006-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-13
i386                  randconfig-007-20260205    gcc-14
i386                  randconfig-011-20260205    gcc-14
i386                  randconfig-012-20260205    clang-20
i386                  randconfig-013-20260205    gcc-14
i386                  randconfig-014-20260205    clang-20
i386                  randconfig-015-20260205    gcc-14
i386                  randconfig-016-20260205    clang-20
i386                  randconfig-017-20260205    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260205    clang-22
loongarch             randconfig-001-20260205    gcc-15.2.0
loongarch             randconfig-002-20260205    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-14
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                           ci20_defconfig    gcc-14
mips                          eyeq6_defconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-14
mips                      loongson3_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-14
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-11.5.0
nios2                 randconfig-001-20260205    gcc-15.2.0
nios2                 randconfig-002-20260205    gcc-11.5.0
nios2                 randconfig-002-20260205    gcc-15.2.0
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
parisc                randconfig-001-20260205    gcc-9.5.0
parisc                randconfig-002-20260205    gcc-8.5.0
parisc                randconfig-002-20260205    gcc-9.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-14
powerpc                   lite5200b_defconfig    gcc-14
powerpc                     mpc83xx_defconfig    clang-22
powerpc                       ppc64_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260205    gcc-15.2.0
powerpc               randconfig-001-20260205    gcc-9.5.0
powerpc               randconfig-002-20260205    clang-16
powerpc               randconfig-002-20260205    gcc-9.5.0
powerpc64             randconfig-001-20260205    clang-22
powerpc64             randconfig-001-20260205    gcc-9.5.0
powerpc64             randconfig-002-20260205    clang-22
powerpc64             randconfig-002-20260205    gcc-9.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260205    clang-19
riscv                 randconfig-002-20260205    clang-19
riscv                 randconfig-002-20260205    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260205    clang-18
s390                  randconfig-001-20260205    clang-19
s390                  randconfig-002-20260205    clang-19
s390                  randconfig-002-20260205    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260205    clang-19
sh                    randconfig-001-20260205    gcc-15.2.0
sh                    randconfig-002-20260205    clang-19
sh                    randconfig-002-20260205    gcc-10.5.0
sh                          rsk7201_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260205    gcc-12.5.0
sparc                 randconfig-001-20260205    gcc-15.2.0
sparc                 randconfig-002-20260205    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260205    gcc-12.5.0
sparc64               randconfig-001-20260205    gcc-8.5.0
sparc64               randconfig-002-20260205    gcc-12.5.0
sparc64               randconfig-002-20260205    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260205    clang-22
um                    randconfig-001-20260205    gcc-12.5.0
um                    randconfig-002-20260205    gcc-12.5.0
um                    randconfig-002-20260205    gcc-13
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260205    clang-20
x86_64      buildonly-randconfig-001-20260205    gcc-14
x86_64      buildonly-randconfig-002-20260205    clang-20
x86_64      buildonly-randconfig-002-20260205    gcc-14
x86_64      buildonly-randconfig-003-20260205    gcc-14
x86_64      buildonly-randconfig-004-20260205    clang-20
x86_64      buildonly-randconfig-004-20260205    gcc-14
x86_64      buildonly-randconfig-005-20260205    clang-20
x86_64      buildonly-randconfig-005-20260205    gcc-14
x86_64      buildonly-randconfig-006-20260205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260205    clang-20
x86_64                randconfig-001-20260205    gcc-12
x86_64                randconfig-002-20260205    clang-20
x86_64                randconfig-003-20260205    clang-20
x86_64                randconfig-004-20260205    clang-20
x86_64                randconfig-005-20260205    clang-20
x86_64                randconfig-005-20260205    gcc-14
x86_64                randconfig-006-20260205    clang-20
x86_64                randconfig-011-20260205    clang-20
x86_64                randconfig-012-20260205    clang-20
x86_64                randconfig-012-20260205    gcc-14
x86_64                randconfig-013-20260205    clang-20
x86_64                randconfig-013-20260205    gcc-14
x86_64                randconfig-014-20260205    clang-20
x86_64                randconfig-015-20260205    clang-20
x86_64                randconfig-015-20260205    gcc-14
x86_64                randconfig-016-20260205    clang-20
x86_64                randconfig-071-20260205    clang-20
x86_64                randconfig-072-20260205    clang-20
x86_64                randconfig-073-20260205    clang-20
x86_64                randconfig-074-20260205    clang-20
x86_64                randconfig-075-20260205    clang-20
x86_64                randconfig-076-20260205    clang-20
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
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260205    gcc-12.5.0
xtensa                randconfig-001-20260205    gcc-8.5.0
xtensa                randconfig-002-20260205    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
