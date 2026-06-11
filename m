Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA12306764
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188969; cv=none; b=lahThm/DrxKxRcxmTaOwc/Mpy2IFzfnUHHPesNyd08pWzKVkfoTrjE16ZrbThSV6eAFtCN3y7HmWd8zWrZ3OnhSj/coLCzOoeG/jZ88gscjRhPkxfwPaZ/BifbVAYIPehnahMGYyT+Yk+MXtV8Hq4NhqbLTJ/8PWjaMFfqYEqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188969; c=relaxed/simple;
	bh=d6yYvI3VXy+m6sifgUAdZinKVlMhOXMcJubvBHgWrwk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A4+ChowULeEDvewFHQ0zcWYHALcUHEuA5ywm7AU4Br/H15bBbtUkDQWLN76cgt+87EpEYIorLqeD7lw5Ri+zmGcjIfVBHG5yyHMGmBMjwr+aGeV/n9rnnZq4KlPa94EMjj1WNYkiE76X3nFxrqMvoTDX/VW8B3HWkbKwI0KvD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQGe0YdR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQGe0YdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781188965; x=1812724965;
  h=date:from:to:cc:subject:message-id;
  bh=d6yYvI3VXy+m6sifgUAdZinKVlMhOXMcJubvBHgWrwk=;
  b=VQGe0YdRHoPJYCU4Jam9gc7iz3JinzqJQubaS6KKuxVnRlo1cmlDZ4IB
   B7BiTqgbPagV3sf5DEYIhByBViDkbcsRVrNpuTq/AA1e5M7j/2ijmGiv7
   oqHGDhIw4qkrjfZeWeZUg5c0m/gK9Do1bgvtNromZPWVHGpypddFew7Ff
   i+oDxBg5HNg8oEDW54W8WE+xiKzcys5uoOYJRPF0+g5J4LBJlig7h/cma
   yQGtiwLCQFitUeO+gFwLJhmMfvwEbf+pPuxDVJV2+EgkpgUqYIFeSNOe/
   3SFXraLl6cgs6BFIeOfh4jydOV5sSR8gwVhZQ1IfhhB/6HfUsLrPfwuKt
   g==;
X-CSE-ConnectionGUID: LtHT1ggeR5aglP++AGBXeQ==
X-CSE-MsgGUID: gfmfJ/v4Rn2lHlfnfiOmPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85842017"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="85842017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:42:44 -0700
X-CSE-ConnectionGUID: 9j5z8FfHR0OKe7KpiVb7zA==
X-CSE-MsgGUID: U5VzDelFRX+7lHqEBpx40A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="248376361"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2026 07:42:43 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXgcC-00000000NEU-1Tnh;
	Thu, 11 Jun 2026 14:42:40 +0000
Date: Thu, 11 Jun 2026 22:42:08 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 0f080679044dd7d563e84612d1e499f0c3c983d5
Message-ID: <202606112259.E13AmXAB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 0f080679044dd7d563e84612d1e499f0c3c983d5  Merge branch 'for-7.2/cxl-misc' into cxl-for-next

elapsed time: 776m

configs tested: 328
configs skipped: 12

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
arc                        nsim_700_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-14.3.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                            randconfig-002    gcc-14.3.0
arc                   randconfig-002-20260611    gcc-14.3.0
arc                   randconfig-002-20260611    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                           omap1_defconfig    gcc-16.1.0
arm                          pxa910_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-14.3.0
arm                   randconfig-001-20260611    clang-16
arm                   randconfig-001-20260611    gcc-14.3.0
arm                            randconfig-002    gcc-14.3.0
arm                   randconfig-002-20260611    gcc-10.5.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                            randconfig-003    gcc-14.3.0
arm                   randconfig-003-20260611    gcc-12.5.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260611    clang-17
arm                   randconfig-004-20260611    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260611    gcc-10.5.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-002-20260611    clang-23
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-003-20260611    gcc-10.5.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-004-20260611    clang-22
arm64                 randconfig-004-20260611    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-001-20260611    gcc-16.1.0
csky                  randconfig-002-20260611    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-16
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-001-20260611    clang-23
hexagon               randconfig-002-20260611    clang-16
hexagon               randconfig-002-20260611    clang-17
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260611    clang-22
i386        buildonly-randconfig-002-20260611    clang-22
i386        buildonly-randconfig-003-20260611    clang-22
i386        buildonly-randconfig-004-20260611    clang-22
i386        buildonly-randconfig-005-20260611    clang-22
i386        buildonly-randconfig-005-20260611    gcc-14
i386        buildonly-randconfig-006-20260611    clang-22
i386        buildonly-randconfig-006-20260611    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260611    clang-22
i386                  randconfig-001-20260611    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260611    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260611    gcc-13
i386                  randconfig-003-20260611    gcc-14
i386                           randconfig-004    clang-22
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260611    clang-22
i386                  randconfig-004-20260611    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260611    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260611    clang-22
i386                  randconfig-006-20260611    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260611    gcc-14
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-014-20260611    gcc-12
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-015-20260611    clang-22
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-017-20260611    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-16
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-001-20260611    clang-18
loongarch             randconfig-002-20260611    clang-16
loongarch             randconfig-002-20260611    clang-17
loongarch             randconfig-002-20260611    clang-18
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
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260611    clang-16
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-001-20260611    gcc-11.5.0
nios2                 randconfig-002-20260611    clang-16
nios2                 randconfig-002-20260611    clang-17
nios2                 randconfig-002-20260611    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                randconfig-001-20260611    gcc-8.5.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64             randconfig-001-20260611    gcc-8.5.0
powerpc64             randconfig-002-20260611    gcc-12.5.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-12.5.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                 randconfig-001-20260611    gcc-8.5.0
riscv                          randconfig-002    clang-23
riscv                          randconfig-002    gcc-12.5.0
riscv                 randconfig-002-20260611    clang-23
riscv                 randconfig-002-20260611    gcc-12.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-12.5.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260611    gcc-11.5.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                           randconfig-002    clang-18
s390                           randconfig-002    gcc-12.5.0
s390                  randconfig-002-20260611    clang-23
s390                  randconfig-002-20260611    gcc-12.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-12.5.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260611    gcc-12.5.0
sh                             randconfig-002    gcc-12.5.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260611    gcc-10.5.0
sh                    randconfig-002-20260611    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-001-20260611    gcc-16.1.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260611    clang-23
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-002-20260611    gcc-11.5.0
sparc64               randconfig-002-20260611    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260611    clang-23
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-002-20260611    clang-23
um                    randconfig-002-20260611    gcc-15.2.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64               buildonly-randconfig-002    clang-22
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260611    clang-22
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260611    clang-22
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260611    clang-22
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260611    clang-22
x86_64                randconfig-001-20260611    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260611    clang-22
x86_64                randconfig-002-20260611    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260611    clang-22
x86_64                randconfig-003-20260611    gcc-12
x86_64                randconfig-003-20260611    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260611    clang-22
x86_64                randconfig-004-20260611    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260611    clang-22
x86_64                randconfig-005-20260611    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260611    clang-22
x86_64                randconfig-006-20260611    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260611    clang-22
x86_64                randconfig-011-20260611    gcc-14
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260611    clang-22
x86_64                randconfig-012-20260611    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260611    clang-22
x86_64                randconfig-013-20260611    gcc-14
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260611    clang-22
x86_64                randconfig-014-20260611    gcc-14
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260611    clang-22
x86_64                randconfig-015-20260611    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260611    clang-22
x86_64                randconfig-016-20260611    gcc-14
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-076-20260611    clang-22
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
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-001-20260611    gcc-8.5.0
xtensa                randconfig-002-20260611    gcc-15.2.0
xtensa                randconfig-002-20260611    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
