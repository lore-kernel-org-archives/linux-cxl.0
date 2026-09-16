Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0E349CD2
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537982; cv=none; b=AASh7soruMCVKIKi/40nNX2iL4x/5oCCyS3nSzgjPtz/Vdjn44R3LHvKXcIE/RUuHSrwlIEYF5GRWZDepFmivFAZpTgsyo3u+TcH7RgEPG64wgb7w8R7BNr0EAm9TJlxFuzcM5hVv4MVqJL2K2jEEVDOa9b0YLno5mxUWRvPOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537982; c=relaxed/simple;
	bh=u9BK+kKHr79usV6gZTjtfuT1f56TAeJ8pSyIKz3wdzo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rSYcHL5J9KmOLxqHj8h8T/Zcvlc2n+XTLbxpBgcy3Chtj1j8ROfRx+Je3KquLFv4u8oxCADBCOUlslPt+5qNaAYG0I+p4cLC/lQVWozrMRYZKl97IAeZ92VsTR9aU9i9yfLShZB3vS73IID2HJfWW1/8b8wuX416w+sig8O3Eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSersdHP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSersdHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789537981; x=1821073981;
  h=date:from:to:cc:subject:message-id;
  bh=u9BK+kKHr79usV6gZTjtfuT1f56TAeJ8pSyIKz3wdzo=;
  b=QSersdHPpGxO55IQYrQSIYX1mNtxI88sOnxhgKWlrLUM+nn53Dbf++Xz
   nL0pE4f6AGX6q5V64wsHospQ4HoLMmK4WlEbcCV3fKeNBpxNNa4LvmRt8
   3pCW/SrdQvtu12JOyU0EmS/xzfYfMGzaTDqNDc8DBtHuu5tw0I6XNLqSB
   Sn9FLhpsl4PabTy0s93uMj0mAYBQS5IIg2MKwMOX7+eYbqqVyQcjg4iD7
   Tb8R4U26F8rjQvQzWqGAho9GkssGyOK6GMNBjT+B0GqkfLITOdGVjJ06e
   UgwiRr2hmO6dDk1IOYB8YcqE/L8VWgBVGN49RcBG+4osi0EJHVyqV6C3W
   w==;
X-CSE-ConnectionGUID: N/7y71imQCqx4NwB+Ptblw==
X-CSE-MsgGUID: +P7QWOmRRcq2kkGep142pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100232408"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100232408"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:53:01 -0700
X-CSE-ConnectionGUID: yIM1yN+8Sg+YiH3m52ltXg==
X-CSE-MsgGUID: SMOPlO+ZRISZdVUq3pV7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267025080"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 22:52:58 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6iZk-000000005Z7-0PcW;
	Wed, 16 Sep 2026 05:52:56 +0000
Date: Wed, 16 Sep 2026 13:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 3a4b643079e529c8c2c8f49ef4df1145ca509a31
Message-ID: <202609161335.R09oA1BC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 3a4b643079e529c8c2c8f49ef4df1145ca509a31  Merge branch 'for-7.4/cxl-misc' into cxl-for-next

elapsed time: 1902m

configs tested: 398
configs skipped: 30

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r063-20260915    gcc-8.5.0
alpha                randconfig-r064-20260915    gcc-15.2.0
alpha                randconfig-r073-20260915    gcc-14.3.0
arc                              allmodconfig    clang-24
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20260915    gcc-8.5.0
arc                   randconfig-001-20260916    clang-24
arc                   randconfig-002-20260915    gcc-10.5.0
arc                   randconfig-002-20260916    clang-24
arc                  randconfig-r053-20260915    gcc-8.5.0
arc                  randconfig-r062-20260915    gcc-8.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                              allyesconfig    gcc-16.1.0
arm                         at91_dt_defconfig    clang-17
arm                         axm55xx_defconfig    clang-24
arm                                 defconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                           h3600_defconfig    gcc-16.1.0
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20260915    clang-24
arm                   randconfig-001-20260916    clang-24
arm                   randconfig-002-20260915    clang-24
arm                   randconfig-002-20260916    clang-24
arm                   randconfig-003-20260915    gcc-10.5.0
arm                   randconfig-003-20260916    clang-24
arm                   randconfig-004-20260915    clang-24
arm                   randconfig-004-20260916    clang-24
arm                  randconfig-r051-20260915    clang-19
arm                  randconfig-r052-20260915    gcc-9.5.0
arm                  randconfig-r061-20260915    clang-22
arm                  randconfig-r062-20260915    clang-24
arm                  randconfig-r133-20260916    gcc-16.1.0 sparse
arm                           sama5_defconfig    gcc-16.1.0
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260915    clang-24
arm64                 randconfig-001-20260916    gcc-16.1.0
arm64                 randconfig-002-20260915    clang-24
arm64                 randconfig-002-20260916    gcc-16.1.0
arm64                 randconfig-003-20260915    clang-24
arm64                 randconfig-003-20260916    gcc-16.1.0
arm64                 randconfig-004-20260916    gcc-16.1.0
arm64                randconfig-r062-20260915    gcc-8.5.0
arm64                randconfig-r064-20260915    clang-22
arm64                randconfig-r072-20260915    gcc-11.5.0
arm64                randconfig-r073-20260915    clang-24
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260915    gcc-10.5.0
csky                  randconfig-001-20260916    gcc-16.1.0
csky                  randconfig-002-20260915    gcc-12.5.0
csky                  randconfig-002-20260916    gcc-16.1.0
csky                 randconfig-r111-20260916    clang-24 sparse
hexagon                          allmodconfig    clang-24
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-24
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-24
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260915    clang-17
hexagon               randconfig-001-20260916    gcc-16.1.0
hexagon               randconfig-002-20260915    clang-24
hexagon               randconfig-002-20260916    gcc-16.1.0
hexagon              randconfig-r054-20260915    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-001-20260915    clang-22
i386        buildonly-randconfig-001-20260916    clang-22
i386        buildonly-randconfig-002-20260915    clang-22
i386        buildonly-randconfig-002-20260916    clang-22
i386        buildonly-randconfig-003-20260915    gcc-13
i386        buildonly-randconfig-003-20260916    clang-22
i386        buildonly-randconfig-004-20260915    gcc-14
i386        buildonly-randconfig-004-20260916    clang-22
i386        buildonly-randconfig-005-20260915    clang-22
i386        buildonly-randconfig-005-20260916    clang-22
i386        buildonly-randconfig-006-20260915    clang-22
i386        buildonly-randconfig-006-20260916    clang-22
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260916    gcc-14
i386                  randconfig-002-20260915    gcc-14
i386                  randconfig-002-20260916    gcc-14
i386                  randconfig-003-20260915    gcc-14
i386                  randconfig-003-20260916    gcc-14
i386                  randconfig-004-20260915    clang-22
i386                  randconfig-004-20260916    gcc-14
i386                  randconfig-005-20260915    clang-22
i386                  randconfig-005-20260916    gcc-14
i386                  randconfig-006-20260915    gcc-13
i386                  randconfig-006-20260916    gcc-14
i386                  randconfig-007-20260915    clang-22
i386                  randconfig-007-20260916    gcc-14
i386                  randconfig-011-20260916    clang-22
i386                  randconfig-012-20260916    clang-22
i386                  randconfig-013-20260916    clang-22
i386                  randconfig-014-20260916    clang-22
i386                  randconfig-015-20260916    clang-22
i386                  randconfig-016-20260916    clang-22
i386                  randconfig-017-20260916    clang-22
i386                  randconfig-051-20260915    clang-22
i386                  randconfig-052-20260915    clang-22
i386                  randconfig-053-20260915    clang-22
i386                  randconfig-054-20260915    clang-22
i386                  randconfig-054-20260915    gcc-14
i386                  randconfig-061-20260915    clang-22 sparse
i386                  randconfig-062-20260915    gcc-14 sparse
i386                  randconfig-063-20260915    clang-22 sparse
i386                  randconfig-141-20260915    clang-22
i386                 randconfig-r051-20260915    clang-17
i386                 randconfig-r051-20260915    clang-22
i386                 randconfig-r051-20260915    gcc-9.5.0
i386                 randconfig-r131-20260916    gcc-16.1.0 sparse
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260915    clang-24
loongarch             randconfig-001-20260916    gcc-16.1.0
loongarch             randconfig-002-20260915    clang-21
loongarch             randconfig-002-20260916    gcc-16.1.0
loongarch            randconfig-r053-20260915    clang-19
loongarch            randconfig-r054-20260915    clang-22
loongarch            randconfig-r072-20260915    gcc-16.1.0
loongarch            randconfig-r111-20260916    gcc-12.5.0 sparse
loongarch            randconfig-r121-20260916    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-24
m68k                                defconfig    gcc-16.1.0
m68k                       m5329evb_defconfig    clang-20
m68k                 randconfig-r051-20260915    gcc-8.5.0
m68k                 randconfig-r053-20260915    gcc-8.5.0
m68k                 randconfig-r061-20260915    clang-24
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze                          defconfig    gcc-16.1.0
microblaze           randconfig-r053-20260915    clang-22
microblaze           randconfig-r053-20260915    gcc-9.5.0
microblaze           randconfig-r073-20260915    gcc-8.5.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                 randconfig-r054-20260915    gcc-9.5.0
mips                 randconfig-r063-20260915    gcc-8.5.0
mips                 randconfig-r064-20260915    gcc-8.5.0
mips                 randconfig-r073-20260915    gcc-16.1.0
mips                 randconfig-r113-20260916    clang-24 sparse
mips                 randconfig-r123-20260916    gcc-12.5.0 sparse
mips                           rs90_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-24
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-24
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260915    gcc-8.5.0
nios2                 randconfig-001-20260916    gcc-16.1.0
nios2                 randconfig-002-20260915    gcc-8.5.0
nios2                 randconfig-002-20260916    gcc-16.1.0
nios2                randconfig-r053-20260915    clang-17
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-24
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r062-20260915    gcc-16.1.0
openrisc             randconfig-r063-20260915    gcc-13.4.0
openrisc             randconfig-r071-20260915    gcc-14.3.0
openrisc             randconfig-r134-20260916    gcc-16.1.0 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260915    gcc-13.4.0
parisc                randconfig-001-20260916    clang-24
parisc                randconfig-002-20260915    gcc-15.2.0
parisc                randconfig-002-20260916    clang-24
parisc               randconfig-r052-20260915    clang-17
parisc               randconfig-r052-20260915    clang-19
parisc               randconfig-r052-20260915    gcc-8.5.0
parisc               randconfig-r052-20260915    gcc-9.5.0
parisc               randconfig-r054-20260915    gcc-8.5.0
parisc               randconfig-r072-20260915    gcc-8.5.0
parisc               randconfig-r122-20260916    gcc-12.5.0 sparse
parisc               randconfig-r132-20260916    gcc-11.5.0 sparse
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    clang-24
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        cell_defconfig    gcc-16.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20260915    gcc-10.5.0
powerpc               randconfig-001-20260916    clang-24
powerpc               randconfig-002-20260915    clang-24
powerpc               randconfig-002-20260916    clang-24
powerpc              randconfig-r063-20260915    clang-24
powerpc              randconfig-r064-20260915    clang-24
powerpc              randconfig-r071-20260915    clang-24
powerpc              randconfig-r072-20260915    gcc-9.5.0
powerpc              randconfig-r113-20260916    gcc-12.5.0 sparse
powerpc              randconfig-r122-20260916    clang-24 sparse
powerpc              randconfig-r134-20260915    clang-24 sparse
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260915    gcc-8.5.0
powerpc64             randconfig-001-20260916    clang-24
powerpc64             randconfig-002-20260915    clang-24
powerpc64             randconfig-002-20260916    clang-24
powerpc64            randconfig-r054-20260915    clang-19
powerpc64            randconfig-r071-20260915    gcc-10.5.0
powerpc64            randconfig-r112-20260916    gcc-12.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260916    gcc-16.1.0
riscv                 randconfig-002-20260915    gcc-8.5.0
riscv                 randconfig-002-20260916    gcc-16.1.0
riscv                randconfig-r053-20260915    clang-24
riscv                randconfig-r061-20260915    clang-17
riscv                randconfig-r064-20260915    gcc-8.5.0
riscv                randconfig-r072-20260915    clang-19
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260915    gcc-9.5.0
s390                  randconfig-001-20260916    gcc-16.1.0
s390                  randconfig-002-20260915    clang-17
s390                  randconfig-002-20260916    gcc-16.1.0
s390                 randconfig-r063-20260915    clang-22
s390                 randconfig-r064-20260915    gcc-13
s390                 randconfig-r064-20260915    gcc-8.5.0
s390                 randconfig-r073-20260915    clang-19
s390                 randconfig-r133-20260916    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                ecovec24-romimage_defconfig    gcc-16.1.0
sh                          lboxre2_defconfig    gcc-16.1.0
sh                     magicpanelr2_defconfig    gcc-16.1.0
sh                    randconfig-001-20260915    gcc-10.5.0
sh                    randconfig-001-20260916    gcc-16.1.0
sh                    randconfig-002-20260915    gcc-16.1.0
sh                    randconfig-002-20260916    gcc-16.1.0
sh                   randconfig-r051-20260915    clang-22
sh                   randconfig-r054-20260915    clang-24
sh                   randconfig-r123-20260916    clang-24 sparse
sh                          sdk7786_defconfig    clang-20
sh                           se7722_defconfig    gcc-16.1.0
sh                           se7751_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260915    gcc-8.5.0
sparc                 randconfig-001-20260916    gcc-14.3.0
sparc                 randconfig-002-20260915    gcc-13.4.0
sparc                 randconfig-002-20260916    gcc-14.3.0
sparc                randconfig-r061-20260915    gcc-8.5.0
sparc                randconfig-r063-20260915    gcc-13
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-24
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260915    gcc-15.2.0
sparc64               randconfig-001-20260916    gcc-14.3.0
sparc64               randconfig-002-20260915    gcc-9.5.0
sparc64               randconfig-002-20260916    gcc-14.3.0
sparc64              randconfig-r061-20260915    gcc-8.5.0
sparc64              randconfig-r071-20260915    gcc-15.2.0
sparc64              randconfig-r112-20260916    clang-24 sparse
sparc64              randconfig-r134-20260916    gcc-11.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-24
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260915    clang-24
um                    randconfig-001-20260916    gcc-14.3.0
um                    randconfig-002-20260915    clang-24
um                    randconfig-002-20260916    gcc-14.3.0
um                   randconfig-r052-20260915    clang-24
um                   randconfig-r072-20260915    clang-17
um                   randconfig-r121-20260916    clang-24 sparse
um                   randconfig-r132-20260916    gcc-16.1.0 sparse
um                           x86_64_defconfig    clang-24
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64      buildonly-randconfig-001-20260915    clang-22
x86_64      buildonly-randconfig-002-20260915    clang-22
x86_64      buildonly-randconfig-003-20260915    gcc-14
x86_64      buildonly-randconfig-004-20260915    clang-22
x86_64      buildonly-randconfig-005-20260915    gcc-14
x86_64      buildonly-randconfig-006-20260915    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260916    clang-22
x86_64                randconfig-002-20260916    clang-22
x86_64                randconfig-003-20260916    clang-22
x86_64                randconfig-004-20260916    clang-22
x86_64                randconfig-005-20260916    clang-22
x86_64                randconfig-006-20260916    clang-22
x86_64                randconfig-011-20260916    gcc-14
x86_64                randconfig-012-20260916    gcc-14
x86_64                randconfig-013-20260916    gcc-14
x86_64                randconfig-014-20260916    gcc-14
x86_64                randconfig-015-20260915    gcc-14
x86_64                randconfig-015-20260916    gcc-14
x86_64                randconfig-016-20260916    gcc-14
x86_64                randconfig-071-20260915    clang-22
x86_64                randconfig-071-20260916    gcc-14
x86_64                randconfig-072-20260915    clang-22
x86_64                randconfig-072-20260916    gcc-14
x86_64                randconfig-073-20260915    clang-22
x86_64                randconfig-073-20260916    gcc-14
x86_64                randconfig-074-20260915    gcc-13
x86_64                randconfig-074-20260916    gcc-14
x86_64                randconfig-075-20260915    clang-22
x86_64                randconfig-075-20260916    gcc-14
x86_64                randconfig-076-20260915    gcc-14
x86_64                randconfig-076-20260916    gcc-14
x86_64                randconfig-101-20260915    clang-22
x86_64                randconfig-102-20260915    clang-22
x86_64                randconfig-102-20260915    gcc-14
x86_64                randconfig-103-20260915    clang-22
x86_64                randconfig-104-20260915    clang-22
x86_64                randconfig-104-20260915    gcc-14
x86_64                randconfig-121-20260915    clang-22 sparse
x86_64                randconfig-122-20260915    clang-22 sparse
x86_64                randconfig-123-20260915    gcc-14 sparse
x86_64                randconfig-161-20260915    clang-22
x86_64               randconfig-r052-20260915    clang-22
x86_64               randconfig-r061-20260915    gcc-13
x86_64               randconfig-r062-20260915    clang-22
x86_64               randconfig-r063-20260915    gcc-8.5.0
x86_64               randconfig-r071-20260915    clang-22
x86_64               randconfig-r073-20260915    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260915    gcc-15.2.0
xtensa                randconfig-001-20260916    gcc-14.3.0
xtensa                randconfig-002-20260915    gcc-8.5.0
xtensa                randconfig-002-20260916    gcc-14.3.0
xtensa               randconfig-r051-20260915    clang-24
xtensa               randconfig-r054-20260915    gcc-8.5.0
xtensa               randconfig-r061-20260915    gcc-8.5.0
xtensa               randconfig-r062-20260915    gcc-13
xtensa               randconfig-r131-20260916    gcc-11.5.0 sparse
xtensa               randconfig-r133-20260915    gcc-12.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
