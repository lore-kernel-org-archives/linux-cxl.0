Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C521C16A
	for <linux-cxl@vger.kernel.org>; Sat,  8 Nov 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762615330; cv=none; b=adIGqCs4ug/p+2F+h3MHkbu99gmIIJ7pKrfwFWPBKCAmDmd9c6XISmjcy1VER6FzZA6+NQkYerxEll42HKA34DBl+/bYw8kplfeOqx6/9wEW0sizIiX5YI/KFEInybTLW/yyoO82w5nVubuSedAcE1+iAizG+H5kY62Noz/nSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762615330; c=relaxed/simple;
	bh=UZd7mht0rJ4ZS6lhOretC9a4O50pygTagcDClYR737c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r5vD61of/P2Lnt0Gy8HrFDwc9memRO0JN0njZaxh3OFYXnP0cYvtr4n5aEKMdY669y4CBUTa3hsRpoZxV4aVRjzjzl5MA3XuI8qzbwFQK31BYTfQIOw1Qzwk8A64f8wcIN17egLT5iAbKe84gpD9IXJwb9XmoV8sIrpEpPSLAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ncpl5kP7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ncpl5kP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762615328; x=1794151328;
  h=date:from:to:cc:subject:message-id;
  bh=UZd7mht0rJ4ZS6lhOretC9a4O50pygTagcDClYR737c=;
  b=Ncpl5kP71kB6SdDppWLcEYRE5riVsfDkZLVfhRda2Whv/cJhuc2Uvc3a
   jp3zZ6SKERngwkZ+xxRSgrHYQbTnTbDiJuEuoyQxnzaEMRxMVJ+1itfBI
   xFBR4+eAjnMXbR+ZLcvFtf78eMP08TS8RRKjQAItp5Vv2IPVEkjr/6Cof
   8oYWIat77qPdo+peHU2J410+oUJluHLnLdFbQhh6QRPeD7Xz7CueMUmAe
   x2qZlo76XOuC5oWfmiQcVAvT91hK+xDacXNcspRabtw9FYPRagvtrf4Ql
   I3/ZU2uP/996puIosvePfnUVvqqK1gfEdOpbLr9MOZgt33ll44Ly9hoTc
   g==;
X-CSE-ConnectionGUID: Isz6XdgEQcmM4gsEQUpN2A==
X-CSE-MsgGUID: qZ7Ux2ySS++oIp7c1hcngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="63747925"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="63747925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 07:22:07 -0800
X-CSE-ConnectionGUID: TGYqiK6ISXCYNilTOEDH1A==
X-CSE-MsgGUID: sQGgKQ20R860blINPKwCPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="187596976"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Nov 2025 07:22:06 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHklP-00016i-1c;
	Sat, 08 Nov 2025 15:22:03 +0000
Date: Sat, 08 Nov 2025 23:21:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 b6cfddd26ec55e865b4715f73e9bbb17a15091ed
Message-ID: <202511082301.EmUmR1Qm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: b6cfddd26ec55e865b4715f73e9bbb17a15091ed  cxl: Adjust offset calculation for poison injection

elapsed time: 1221m

configs tested: 187
configs skipped: 4

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
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251108    gcc-12.5.0
arc                   randconfig-002-20251108    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251108    gcc-14.3.0
arm                   randconfig-002-20251108    gcc-15.1.0
arm                   randconfig-003-20251108    clang-22
arm                   randconfig-004-20251108    gcc-10.5.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251108    gcc-8.5.0
arm64                 randconfig-002-20251108    clang-22
arm64                 randconfig-003-20251108    clang-22
arm64                 randconfig-004-20251108    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251108    gcc-15.1.0
csky                  randconfig-002-20251108    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251108    clang-22
hexagon               randconfig-002-20251108    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251108    gcc-14
i386        buildonly-randconfig-002-20251108    gcc-14
i386        buildonly-randconfig-003-20251108    gcc-14
i386        buildonly-randconfig-004-20251108    gcc-14
i386        buildonly-randconfig-005-20251108    clang-20
i386        buildonly-randconfig-006-20251108    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251108    clang-20
i386                  randconfig-002-20251108    clang-20
i386                  randconfig-003-20251108    gcc-12
i386                  randconfig-004-20251108    gcc-12
i386                  randconfig-005-20251108    clang-20
i386                  randconfig-006-20251108    gcc-14
i386                  randconfig-007-20251108    gcc-14
i386                  randconfig-011-20251108    gcc-14
i386                  randconfig-012-20251108    clang-20
i386                  randconfig-013-20251108    gcc-14
i386                  randconfig-014-20251108    clang-20
i386                  randconfig-015-20251108    gcc-14
i386                  randconfig-016-20251108    gcc-14
i386                  randconfig-017-20251108    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251108    gcc-12.5.0
loongarch             randconfig-002-20251108    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
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
nios2                 randconfig-001-20251108    gcc-8.5.0
nios2                 randconfig-002-20251108    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251108    gcc-8.5.0
parisc                randconfig-002-20251108    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251108    gcc-8.5.0
powerpc               randconfig-002-20251108    gcc-9.5.0
powerpc64             randconfig-001-20251108    gcc-8.5.0
powerpc64             randconfig-002-20251108    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251108    clang-19
riscv                 randconfig-002-20251108    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251108    clang-22
s390                  randconfig-002-20251108    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251108    gcc-15.1.0
sh                    randconfig-002-20251108    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251108    gcc-14.3.0
sparc                 randconfig-002-20251108    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251108    clang-20
sparc64               randconfig-002-20251108    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251108    gcc-14
um                    randconfig-002-20251108    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251108    gcc-14
x86_64      buildonly-randconfig-002-20251108    gcc-12
x86_64      buildonly-randconfig-003-20251108    clang-20
x86_64      buildonly-randconfig-004-20251108    gcc-14
x86_64      buildonly-randconfig-005-20251108    gcc-14
x86_64      buildonly-randconfig-006-20251108    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251108    clang-20
x86_64                randconfig-002-20251108    clang-20
x86_64                randconfig-003-20251108    clang-20
x86_64                randconfig-004-20251108    gcc-14
x86_64                randconfig-005-20251108    clang-20
x86_64                randconfig-006-20251108    clang-20
x86_64                randconfig-011-20251108    clang-20
x86_64                randconfig-012-20251108    gcc-14
x86_64                randconfig-013-20251108    clang-20
x86_64                randconfig-014-20251108    clang-20
x86_64                randconfig-015-20251108    clang-20
x86_64                randconfig-016-20251108    gcc-14
x86_64                randconfig-071-20251108    gcc-14
x86_64                randconfig-072-20251108    clang-20
x86_64                randconfig-073-20251108    clang-20
x86_64                randconfig-074-20251108    clang-20
x86_64                randconfig-075-20251108    gcc-12
x86_64                randconfig-076-20251108    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251108    gcc-8.5.0
xtensa                randconfig-002-20251108    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
