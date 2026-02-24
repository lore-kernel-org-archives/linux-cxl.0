Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FACE555
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937422; cv=none; b=cDRdkTpNgYDu8LMvjN2AUfhLimiZudWJyJuRZYbQS0QmHj4U731L2s4Xlwgps3frU6/uuvCNMDpO7WdsqodU1vIDGx2lfK5hoH1VZ1mZl6MY6Wlz6j0fRKPA9yh8kku5/w6oZDQUEkACqBfeR7vp0tFH75IZt7ToMKygeuPT0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937422; c=relaxed/simple;
	bh=oQOwkzaDjGPzSSczRjWnX96Uvhk+wxgwHdNV7EeY7os=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kEL2iPrjWhxODz+57ag/lCw/e60Drc4T3CGhG7QNtBOTNEMe+pK1YSbEaBTWpSv9fHvZNoU8nYrJMfkL3i/iNvJVwl3fcQdwi/5B/qLbgZ/CeuA4iKgLvNnbX/Q+lPQoJweKdk+M2EMKDLNrtsEcXEwe2aO6jjhC2tN6sqDBJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+THBgqF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+THBgqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771937420; x=1803473420;
  h=date:from:to:cc:subject:message-id;
  bh=oQOwkzaDjGPzSSczRjWnX96Uvhk+wxgwHdNV7EeY7os=;
  b=S+THBgqFjClqEFcKBEbzHeIFRlRGSsCRNc9cN4HsgfLu1j+DfGgFUqWS
   xM/3Mt2I4TRtUlyyEwVG1KUkrJc3rLiEG+Snv0FgepkljKGszarakXDnL
   rdFUMzmtadK0qmKgzO+IkWRNua+CwmSgcn6XDyr8JDe2aWKobzDzhql6e
   Q3W+dhhHn3liskxYNCAPQkRcQoNeDLcHuhhyzEud2zBvqsbIbn4fWWo9p
   vQSFQ+/yMYUqs5DogQgDGUF8pqDmXAaR7v/NzCXfcmBZWE0imdEEHRT/t
   A3+OZc8fqI+ec9PHv+yQeHs5KLj118o5Bqu9easxKrk9Zd+NDYgZ1zOhR
   Q==;
X-CSE-ConnectionGUID: zRK9M7JhRhuJGpDwVQS4yA==
X-CSE-MsgGUID: L9PRRXLyQeOyd8hEOmDX0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98412049"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="98412049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 04:50:19 -0800
X-CSE-ConnectionGUID: g3ab55DQQuSmmd36u0KKVw==
X-CSE-MsgGUID: 1/eTu8aFTzaAHXFJgRC89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="219372458"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Feb 2026 04:50:18 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vurrj-000000001y1-29rd;
	Tue, 24 Feb 2026 12:50:15 +0000
Date: Tue, 24 Feb 2026 20:49:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 ebd11be59f7421e4b1ea19eaa8102d17ade3d6c6
Message-ID: <202602242022.74S4ouj2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: ebd11be59f7421e4b1ea19eaa8102d17ade3d6c6  cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask

elapsed time: 814m

configs tested: 289
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            hsdk_defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260224    gcc-14.3.0
arc                   randconfig-002-20260224    gcc-12.5.0
arc                   randconfig-002-20260224    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                        multi_v7_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260224    clang-18
arm                   randconfig-001-20260224    gcc-14.3.0
arm                   randconfig-002-20260224    clang-23
arm                   randconfig-002-20260224    gcc-14.3.0
arm                   randconfig-003-20260224    gcc-14.3.0
arm                   randconfig-003-20260224    gcc-8.5.0
arm                   randconfig-004-20260224    clang-23
arm                   randconfig-004-20260224    gcc-14.3.0
arm                             rpc_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    clang-23
arm                           u8500_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260224    gcc-14.3.0
arm64                 randconfig-002-20260224    gcc-14.3.0
arm64                 randconfig-002-20260224    gcc-9.5.0
arm64                 randconfig-003-20260224    clang-23
arm64                 randconfig-003-20260224    gcc-14.3.0
arm64                 randconfig-004-20260224    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260224    gcc-14.3.0
csky                  randconfig-001-20260224    gcc-15.2.0
csky                  randconfig-002-20260224    gcc-12.5.0
csky                  randconfig-002-20260224    gcc-14.3.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260224    clang-16
hexagon               randconfig-001-20260224    clang-18
hexagon               randconfig-002-20260224    clang-16
i386                             alldefconfig    gcc-14
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260224    clang-20
i386        buildonly-randconfig-002-20260224    clang-20
i386        buildonly-randconfig-003-20260224    clang-20
i386        buildonly-randconfig-004-20260224    clang-20
i386        buildonly-randconfig-004-20260224    gcc-14
i386        buildonly-randconfig-005-20260224    clang-20
i386        buildonly-randconfig-006-20260224    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260224    clang-20
i386                  randconfig-001-20260224    gcc-14
i386                  randconfig-002-20260224    clang-20
i386                  randconfig-002-20260224    gcc-14
i386                  randconfig-003-20260224    clang-20
i386                  randconfig-003-20260224    gcc-14
i386                  randconfig-004-20260224    gcc-14
i386                  randconfig-005-20260224    clang-20
i386                  randconfig-005-20260224    gcc-14
i386                  randconfig-006-20260224    clang-20
i386                  randconfig-006-20260224    gcc-14
i386                  randconfig-007-20260224    gcc-14
i386                  randconfig-011-20260224    clang-20
i386                  randconfig-011-20260224    gcc-14
i386                  randconfig-012-20260224    clang-20
i386                  randconfig-012-20260224    gcc-14
i386                  randconfig-013-20260224    gcc-14
i386                  randconfig-014-20260224    gcc-14
i386                  randconfig-015-20260224    clang-20
i386                  randconfig-015-20260224    gcc-14
i386                  randconfig-016-20260224    clang-20
i386                  randconfig-016-20260224    gcc-14
i386                  randconfig-017-20260224    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260224    clang-16
loongarch             randconfig-001-20260224    clang-23
loongarch             randconfig-002-20260224    clang-16
loongarch             randconfig-002-20260224    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                           ci20_defconfig    clang-23
mips                           ci20_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    clang-23
mips                          eyeq6_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           jazz_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260224    clang-16
nios2                 randconfig-001-20260224    gcc-8.5.0
nios2                 randconfig-002-20260224    clang-16
nios2                 randconfig-002-20260224    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc         de0_nano_multicore_defconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260224    clang-23
parisc                randconfig-001-20260224    gcc-10.5.0
parisc                randconfig-002-20260224    clang-23
parisc                randconfig-002-20260224    gcc-10.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    clang-23
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                   microwatt_defconfig    clang-23
powerpc                     mpc83xx_defconfig    clang-23
powerpc                  mpc866_ads_defconfig    clang-23
powerpc               randconfig-001-20260224    clang-23
powerpc               randconfig-001-20260224    gcc-8.5.0
powerpc               randconfig-002-20260224    clang-23
powerpc64             randconfig-001-20260224    clang-23
powerpc64             randconfig-002-20260224    clang-16
powerpc64             randconfig-002-20260224    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260224    gcc-10.5.0
riscv                 randconfig-001-20260224    gcc-15.2.0
riscv                 randconfig-002-20260224    gcc-10.5.0
riscv                 randconfig-002-20260224    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260224    gcc-10.5.0
s390                  randconfig-001-20260224    gcc-13.4.0
s390                  randconfig-002-20260224    gcc-10.5.0
s390                  randconfig-002-20260224    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                 kfr2r09-romimage_defconfig    gcc-15.2.0
sh                    randconfig-001-20260224    gcc-10.5.0
sh                    randconfig-002-20260224    gcc-10.5.0
sh                    randconfig-002-20260224    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260224    gcc-12.5.0
sparc                 randconfig-002-20260224    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260224    gcc-12.5.0
sparc64               randconfig-002-20260224    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260224    gcc-12.5.0
um                    randconfig-002-20260224    gcc-12.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260224    gcc-14
x86_64      buildonly-randconfig-002-20260224    clang-20
x86_64      buildonly-randconfig-002-20260224    gcc-14
x86_64      buildonly-randconfig-003-20260224    gcc-14
x86_64      buildonly-randconfig-004-20260224    clang-20
x86_64      buildonly-randconfig-004-20260224    gcc-14
x86_64      buildonly-randconfig-005-20260224    clang-20
x86_64      buildonly-randconfig-005-20260224    gcc-14
x86_64      buildonly-randconfig-006-20260224    gcc-13
x86_64      buildonly-randconfig-006-20260224    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260224    clang-20
x86_64                randconfig-001-20260224    gcc-14
x86_64                randconfig-002-20260224    gcc-14
x86_64                randconfig-003-20260224    gcc-14
x86_64                randconfig-004-20260224    gcc-14
x86_64                randconfig-005-20260224    clang-20
x86_64                randconfig-005-20260224    gcc-14
x86_64                randconfig-006-20260224    gcc-14
x86_64                randconfig-011-20260224    clang-20
x86_64                randconfig-012-20260224    clang-20
x86_64                randconfig-013-20260224    clang-20
x86_64                randconfig-014-20260224    clang-20
x86_64                randconfig-015-20260224    clang-20
x86_64                randconfig-016-20260224    clang-20
x86_64                randconfig-071-20260224    clang-20
x86_64                randconfig-071-20260224    gcc-14
x86_64                randconfig-072-20260224    clang-20
x86_64                randconfig-073-20260224    clang-20
x86_64                randconfig-074-20260224    clang-20
x86_64                randconfig-075-20260224    clang-20
x86_64                randconfig-076-20260224    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260224    gcc-12.5.0
xtensa                randconfig-002-20260224    gcc-12.5.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
