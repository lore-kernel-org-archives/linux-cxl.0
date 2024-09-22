Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B24374F6
	for <linux-cxl@vger.kernel.org>; Sun, 22 Sep 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726975878; cv=none; b=f1d466bmTRZnQKdABFHlRwoFyL0NqwGU7+86Arz+abnsKJ5QCzYk9ZmtzK2GApFqMk2VDKnZ+E8shlnQ66SjraMeOWiwbawAgYw5dyJCOsv5x4V/LiQRgnlus+M3gBHxLTajX9Y8Yyc+sYQqZYK3Sk1H/agGKDHVVs+twrgpRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726975878; c=relaxed/simple;
	bh=0rHgcqyJlodon9zwzKnvw5YdG2UbcKrMco8YaZf37XM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rtk9qJWIiSOiBhcaLBFTXycKe1koLDrihxllMSHEYAVe2AnQ+EQp4ntl41gf1X+EhQTyn8EHinWs8Ip8zv9LnQdgbTaRhXVut2t3CvGLmfCjDdp8eEAyZclnFyGuBBG2jnWjCCVTn/MBiDzpAVBT7hUd3zYwdHB77lVgoR68xCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqs7fxv3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqs7fxv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726975876; x=1758511876;
  h=date:from:to:cc:subject:message-id;
  bh=0rHgcqyJlodon9zwzKnvw5YdG2UbcKrMco8YaZf37XM=;
  b=iqs7fxv3vi3OtmiLMDwsadA7RFH/AJnFCMNOwiphMb2+PTfCkkQJmO7E
   2I8q/JvMKcIwA2covHbuWieUl1FL1wzO1Nam0RTEn4IgwO/Y+9Fwy8bZx
   szc2nOa24Ser8Sw0i0/vB+G4pasMlEeFDMd7jAAIWJDimDwU6dcG5K9+3
   lix+3KjXpRdU5XX3wxJDLMWZ3T6oxN7ZPqbQ9dKah34Te/+A/PrrOtZk3
   YwtyJfo8ZRjKgI30KJJrxocazypr4PRMUfwo5Bw+EDur2DsluNHoU7gmK
   Uex7Yp/ca6fcfy5kfy0VbeaQpKAImaeu+hlmHK4TIjOL29T7rkNPfV8ew
   w==;
X-CSE-ConnectionGUID: EOqD6HcsRr2Wkj03fNe4sw==
X-CSE-MsgGUID: qP0Mk0OJRG2c1JaXyC1ASg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29840877"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="29840877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 20:31:16 -0700
X-CSE-ConnectionGUID: 4jGI3T52T96ynZARf2U98Q==
X-CSE-MsgGUID: N8kP8T+eSASQjOJeyu3fRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70595619"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Sep 2024 20:31:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssDJX-000Fzu-10;
	Sun, 22 Sep 2024 03:31:11 +0000
Date: Sun, 22 Sep 2024 11:30:14 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 43cb008f857f48a46df87afa2223693277c1abc7
Message-ID: <202409221109.8f0duStx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 43cb008f857f48a46df87afa2223693277c1abc7  cxl: Add documentation to explain the shared link bandwidth calculation

elapsed time: 786m

configs tested: 280
configs skipped: 8

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
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    clang-20
arc                            hsdk_defconfig    clang-20
arc                   randconfig-001-20240922    clang-20
arc                   randconfig-001-20240922    gcc-13.2.0
arc                   randconfig-002-20240922    clang-20
arc                   randconfig-002-20240922    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                         axm55xx_defconfig    clang-20
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                      jornada720_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.1.0
arm                   randconfig-001-20240922    clang-20
arm                   randconfig-001-20240922    gcc-14.1.0
arm                   randconfig-002-20240922    clang-20
arm                   randconfig-003-20240922    clang-16
arm                   randconfig-003-20240922    clang-20
arm                   randconfig-004-20240922    clang-20
arm                   randconfig-004-20240922    gcc-14.1.0
arm                             rpc_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240922    clang-20
arm64                 randconfig-001-20240922    gcc-14.1.0
arm64                 randconfig-002-20240922    clang-20
arm64                 randconfig-003-20240922    clang-20
arm64                 randconfig-003-20240922    gcc-14.1.0
arm64                 randconfig-004-20240922    clang-20
arm64                 randconfig-004-20240922    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240922    clang-20
csky                  randconfig-001-20240922    gcc-14.1.0
csky                  randconfig-002-20240922    clang-20
csky                  randconfig-002-20240922    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240922    clang-20
hexagon               randconfig-002-20240922    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240921    clang-18
i386        buildonly-randconfig-001-20240922    gcc-12
i386        buildonly-randconfig-002-20240921    clang-18
i386        buildonly-randconfig-002-20240922    gcc-12
i386        buildonly-randconfig-003-20240921    clang-18
i386        buildonly-randconfig-003-20240922    gcc-12
i386        buildonly-randconfig-004-20240921    gcc-12
i386        buildonly-randconfig-004-20240922    gcc-12
i386        buildonly-randconfig-005-20240921    clang-18
i386        buildonly-randconfig-005-20240922    gcc-12
i386        buildonly-randconfig-006-20240921    gcc-12
i386        buildonly-randconfig-006-20240922    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240921    clang-18
i386                  randconfig-001-20240922    gcc-12
i386                  randconfig-002-20240921    clang-18
i386                  randconfig-002-20240922    gcc-12
i386                  randconfig-003-20240921    clang-18
i386                  randconfig-003-20240922    gcc-12
i386                  randconfig-004-20240921    clang-18
i386                  randconfig-004-20240922    gcc-12
i386                  randconfig-005-20240921    clang-18
i386                  randconfig-005-20240922    gcc-12
i386                  randconfig-006-20240921    gcc-12
i386                  randconfig-006-20240922    gcc-12
i386                  randconfig-011-20240921    clang-18
i386                  randconfig-011-20240922    gcc-12
i386                  randconfig-012-20240921    clang-18
i386                  randconfig-012-20240922    gcc-12
i386                  randconfig-013-20240921    gcc-11
i386                  randconfig-013-20240922    gcc-12
i386                  randconfig-014-20240921    gcc-12
i386                  randconfig-014-20240922    gcc-12
i386                  randconfig-015-20240921    clang-18
i386                  randconfig-015-20240922    gcc-12
i386                  randconfig-016-20240921    clang-18
i386                  randconfig-016-20240922    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240922    clang-20
loongarch             randconfig-001-20240922    gcc-14.1.0
loongarch             randconfig-002-20240922    clang-20
loongarch             randconfig-002-20240922    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-14.1.0
m68k                            q40_defconfig    clang-20
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       alldefconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240922    clang-20
nios2                 randconfig-001-20240922    gcc-14.1.0
nios2                 randconfig-002-20240922    clang-20
nios2                 randconfig-002-20240922    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20240922    clang-20
parisc                randconfig-001-20240922    gcc-14.1.0
parisc                randconfig-002-20240922    clang-20
parisc                randconfig-002-20240922    gcc-14.1.0
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    amigaone_defconfig    clang-20
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                     kmeter1_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc               randconfig-002-20240922    clang-20
powerpc               randconfig-002-20240922    gcc-14.1.0
powerpc                  storcenter_defconfig    clang-20
powerpc64             randconfig-001-20240922    clang-20
powerpc64             randconfig-002-20240922    clang-20
powerpc64             randconfig-002-20240922    gcc-14.1.0
powerpc64             randconfig-003-20240922    clang-20
powerpc64             randconfig-003-20240922    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240922    clang-20
riscv                 randconfig-001-20240922    gcc-14.1.0
riscv                 randconfig-002-20240922    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20240922    clang-20
s390                  randconfig-002-20240922    clang-20
s390                  randconfig-002-20240922    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                        dreamcast_defconfig    clang-20
sh                    randconfig-001-20240922    clang-20
sh                    randconfig-001-20240922    gcc-14.1.0
sh                    randconfig-002-20240922    clang-20
sh                    randconfig-002-20240922    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7721_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240922    clang-20
sparc64               randconfig-001-20240922    gcc-14.1.0
sparc64               randconfig-002-20240922    clang-20
sparc64               randconfig-002-20240922    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240922    clang-20
um                    randconfig-001-20240922    gcc-12
um                    randconfig-002-20240922    clang-20
um                    randconfig-002-20240922    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240921    gcc-12
x86_64      buildonly-randconfig-001-20240922    clang-18
x86_64      buildonly-randconfig-002-20240921    clang-18
x86_64      buildonly-randconfig-002-20240922    clang-18
x86_64      buildonly-randconfig-003-20240921    clang-18
x86_64      buildonly-randconfig-003-20240922    clang-18
x86_64      buildonly-randconfig-004-20240921    gcc-12
x86_64      buildonly-randconfig-004-20240922    clang-18
x86_64      buildonly-randconfig-005-20240921    clang-18
x86_64      buildonly-randconfig-005-20240922    clang-18
x86_64      buildonly-randconfig-006-20240921    gcc-12
x86_64      buildonly-randconfig-006-20240922    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240921    clang-18
x86_64                randconfig-001-20240922    clang-18
x86_64                randconfig-002-20240921    clang-18
x86_64                randconfig-002-20240922    clang-18
x86_64                randconfig-003-20240921    gcc-12
x86_64                randconfig-003-20240922    clang-18
x86_64                randconfig-004-20240921    gcc-12
x86_64                randconfig-004-20240922    clang-18
x86_64                randconfig-005-20240921    gcc-11
x86_64                randconfig-005-20240922    clang-18
x86_64                randconfig-006-20240921    gcc-12
x86_64                randconfig-006-20240922    clang-18
x86_64                randconfig-011-20240921    clang-18
x86_64                randconfig-011-20240922    clang-18
x86_64                randconfig-012-20240921    clang-18
x86_64                randconfig-012-20240922    clang-18
x86_64                randconfig-013-20240921    gcc-12
x86_64                randconfig-013-20240922    clang-18
x86_64                randconfig-014-20240921    clang-18
x86_64                randconfig-014-20240922    clang-18
x86_64                randconfig-015-20240921    clang-18
x86_64                randconfig-015-20240922    clang-18
x86_64                randconfig-016-20240921    clang-18
x86_64                randconfig-016-20240922    clang-18
x86_64                randconfig-071-20240921    gcc-12
x86_64                randconfig-071-20240922    clang-18
x86_64                randconfig-072-20240921    clang-18
x86_64                randconfig-072-20240922    clang-18
x86_64                randconfig-073-20240921    clang-18
x86_64                randconfig-073-20240922    clang-18
x86_64                randconfig-074-20240921    gcc-12
x86_64                randconfig-074-20240922    clang-18
x86_64                randconfig-075-20240921    clang-18
x86_64                randconfig-075-20240922    clang-18
x86_64                randconfig-076-20240921    clang-18
x86_64                randconfig-076-20240922    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240922    clang-20
xtensa                randconfig-001-20240922    gcc-14.1.0
xtensa                randconfig-002-20240922    clang-20
xtensa                randconfig-002-20240922    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
