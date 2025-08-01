Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714721E097
	for <linux-cxl@vger.kernel.org>; Fri,  1 Aug 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043237; cv=none; b=D4Ucs4WQxbQ7bsRW4pNp1WGJ/Fi/kckBnHU2+dDfjhJpwkt6EU7BkanznlLhWWVYz1Jo19/kBd1SfZ3j0Gk4LLryqwQ2715Rhwz0HOjDjVfYNR63c+h/oN/IfD0v/TnGU30DGVxSsyHU11EGHxWRNonxcx5G9sxye07WFRCDKms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043237; c=relaxed/simple;
	bh=Cnsri+ETff39janCXAdcCfg8zOBRacd7kO2+KbVtEvg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vCns30vL5OazYr/a4tQKhrGHNfB/8I9PskdNZrO7i1JqppVC/isdRDU+Ugx8L1Xr3Dvi/JJgAreeaaQJIr4hq85KGwCuXqgTdgDL9MwN+J5qZndoMfpyT/av7c3tHHkkey9lTMUfrLXKkIAwKpsR6Oq1LCI1NATGL9g0LepdWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvujFg+o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvujFg+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754043234; x=1785579234;
  h=date:from:to:cc:subject:message-id;
  bh=Cnsri+ETff39janCXAdcCfg8zOBRacd7kO2+KbVtEvg=;
  b=RvujFg+oQ2mYK1uAcxtvHF9X33CHi51r4XkSg8efWIyi+OUAax69pEV7
   MpUSe9AER4Cpel3yQTvnw5ff5aZZhGX0PuPZ18SmmpmmeBUA7mUb+nbO5
   JbPA3uUH/5ZGvFoVp+4UjSUEndYM88jqhNOibipyT0D7xCPod/KdcaZbG
   Arf84ks/jySiVbTCIwFtx/lSolqBwwp4637PiOpZwkxxDxMFrQyHYB8qk
   GSfpe7XSv/8VyEGVNyTrP1Yb1MmRgNV0DJSEf6QqWdnh+j4UJ7sBsmf6S
   HFCfEkpFvNHv1yVhs0kZgqT4QS3/HtHMahQqwsBbU8S/BLxqXVMJbgi7k
   Q==;
X-CSE-ConnectionGUID: jVCOiKgFT72nn2zf2YpHIw==
X-CSE-MsgGUID: 9+2ZMAtvQZK+7L0ijBEymQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="60217626"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="60217626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 03:13:54 -0700
X-CSE-ConnectionGUID: rB/9xCgcRpOOAwDdNxiHbg==
X-CSE-MsgGUID: XrCF1PEHSIOJjQmJoPUk6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163982636"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 01 Aug 2025 03:13:51 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhmlo-0004Wq-2d;
	Fri, 01 Aug 2025 10:13:48 +0000
Date: Fri, 01 Aug 2025 18:12:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.18/cxl-probe-order] BUILD SUCCESS
 ab70c6227ee6165a562c215d9dcb4a1c55620d5d
Message-ID: <202508011848.PpdNIvWq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.18/cxl-probe-order
branch HEAD: ab70c6227ee6165a562c215d9dcb4a1c55620d5d  dax/cxl: Defer Soft Reserved registration

elapsed time: 722m

configs tested: 211
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250801    gcc-10.5.0
arc                   randconfig-001-20250801    gcc-15.1.0
arc                   randconfig-002-20250801    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250801    clang-22
arm                   randconfig-001-20250801    gcc-10.5.0
arm                   randconfig-002-20250801    gcc-10.5.0
arm                   randconfig-002-20250801    gcc-8.5.0
arm                   randconfig-003-20250801    gcc-10.5.0
arm                   randconfig-004-20250801    gcc-10.5.0
arm                   randconfig-004-20250801    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250801    clang-22
arm64                 randconfig-001-20250801    gcc-10.5.0
arm64                 randconfig-002-20250801    clang-22
arm64                 randconfig-002-20250801    gcc-10.5.0
arm64                 randconfig-003-20250801    gcc-10.5.0
arm64                 randconfig-003-20250801    gcc-11.5.0
arm64                 randconfig-004-20250801    clang-22
arm64                 randconfig-004-20250801    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250801    gcc-13.4.0
csky                  randconfig-001-20250801    gcc-15.1.0
csky                  randconfig-002-20250801    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250801    clang-22
hexagon               randconfig-001-20250801    gcc-15.1.0
hexagon               randconfig-002-20250801    clang-22
hexagon               randconfig-002-20250801    gcc-15.1.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250801    clang-20
i386        buildonly-randconfig-001-20250801    gcc-12
i386        buildonly-randconfig-002-20250801    gcc-12
i386        buildonly-randconfig-003-20250801    gcc-12
i386        buildonly-randconfig-004-20250801    gcc-12
i386        buildonly-randconfig-005-20250801    gcc-12
i386        buildonly-randconfig-006-20250801    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250801    gcc-12
i386                  randconfig-002-20250801    gcc-12
i386                  randconfig-003-20250801    gcc-12
i386                  randconfig-004-20250801    gcc-12
i386                  randconfig-005-20250801    gcc-12
i386                  randconfig-006-20250801    gcc-12
i386                  randconfig-007-20250801    gcc-12
i386                  randconfig-011-20250801    gcc-12
i386                  randconfig-012-20250801    gcc-12
i386                  randconfig-013-20250801    gcc-12
i386                  randconfig-014-20250801    gcc-12
i386                  randconfig-015-20250801    gcc-12
i386                  randconfig-016-20250801    gcc-12
i386                  randconfig-017-20250801    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250801    gcc-15.1.0
loongarch             randconfig-002-20250801    clang-22
loongarch             randconfig-002-20250801    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250801    gcc-11.5.0
nios2                 randconfig-001-20250801    gcc-15.1.0
nios2                 randconfig-002-20250801    gcc-15.1.0
nios2                 randconfig-002-20250801    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250801    gcc-13.4.0
parisc                randconfig-001-20250801    gcc-15.1.0
parisc                randconfig-002-20250801    gcc-15.1.0
parisc                randconfig-002-20250801    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250801    gcc-13.4.0
powerpc               randconfig-001-20250801    gcc-15.1.0
powerpc               randconfig-002-20250801    clang-22
powerpc               randconfig-002-20250801    gcc-15.1.0
powerpc               randconfig-003-20250801    clang-22
powerpc               randconfig-003-20250801    gcc-15.1.0
powerpc64             randconfig-001-20250801    gcc-15.1.0
powerpc64             randconfig-001-20250801    gcc-8.5.0
powerpc64             randconfig-002-20250801    clang-22
powerpc64             randconfig-002-20250801    gcc-15.1.0
powerpc64             randconfig-003-20250801    gcc-13.4.0
powerpc64             randconfig-003-20250801    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20250801    clang-22
riscv                 randconfig-002-20250801    clang-17
riscv                 randconfig-002-20250801    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250801    clang-22
s390                  randconfig-002-20250801    clang-22
s390                  randconfig-002-20250801    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250801    clang-22
sh                    randconfig-001-20250801    gcc-14.3.0
sh                    randconfig-002-20250801    clang-22
sh                    randconfig-002-20250801    gcc-11.5.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250801    clang-22
sparc                 randconfig-001-20250801    gcc-15.1.0
sparc                 randconfig-002-20250801    clang-22
sparc                 randconfig-002-20250801    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250801    clang-22
sparc64               randconfig-001-20250801    gcc-9.5.0
sparc64               randconfig-002-20250801    clang-22
sparc64               randconfig-002-20250801    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250801    clang-22
um                    randconfig-001-20250801    gcc-12
um                    randconfig-002-20250801    clang-22
um                    randconfig-002-20250801    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250801    gcc-12
x86_64      buildonly-randconfig-002-20250801    clang-20
x86_64      buildonly-randconfig-002-20250801    gcc-12
x86_64      buildonly-randconfig-003-20250801    clang-20
x86_64      buildonly-randconfig-003-20250801    gcc-12
x86_64      buildonly-randconfig-004-20250801    clang-20
x86_64      buildonly-randconfig-004-20250801    gcc-12
x86_64      buildonly-randconfig-005-20250801    gcc-12
x86_64      buildonly-randconfig-006-20250801    clang-20
x86_64      buildonly-randconfig-006-20250801    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250801    clang-20
x86_64                randconfig-002-20250801    clang-20
x86_64                randconfig-003-20250801    clang-20
x86_64                randconfig-004-20250801    clang-20
x86_64                randconfig-005-20250801    clang-20
x86_64                randconfig-006-20250801    clang-20
x86_64                randconfig-007-20250801    clang-20
x86_64                randconfig-008-20250801    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250801    clang-22
xtensa                randconfig-001-20250801    gcc-8.5.0
xtensa                randconfig-002-20250801    clang-22
xtensa                randconfig-002-20250801    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
