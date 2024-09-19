Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6B193432
	for <linux-cxl@vger.kernel.org>; Thu, 19 Sep 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726746704; cv=none; b=C2NTFRxnxG4XU23hLsb7X6WMlqBPL2+eLyFxR+LQGsu2woWd/MZrt8RTFBEUA3yzfw/l6m55YxzFSgShO6jcY4QNU5M7/subPFT0hkoMjQj7Djeb4E61jrYdpyRXn3UrZT82KPWpqi9pz65DWOGGdV7iS5US73kv3BqSDuRkE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726746704; c=relaxed/simple;
	bh=noGaa7iAPlUCnLh2USrm1VaSzfOdTRGqK7rcwP6cWkc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kCRvMsrWGzJsPuToJwGqAxUf8kzTfnrSXMTnKb2579Lj9VVx7xcfgMEpCJsG5Ircmk93YXBjbgwlhzuczZ764sD0iLrUBDsQSwUD16ThNA1PxRqc57MYsVI44BtS1tEqb/J85T+doe5XY6yBZdfVd6X4RduVwS4TGlfCvzosumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jj8jTKUD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jj8jTKUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726746703; x=1758282703;
  h=date:from:to:cc:subject:message-id;
  bh=noGaa7iAPlUCnLh2USrm1VaSzfOdTRGqK7rcwP6cWkc=;
  b=jj8jTKUD2qWLD6/HEAdykSrxH7dseT1TFw/Qu1ihcR8RCx9rueIcvKHU
   crsH/yS/Lr8eOATIBeOT0LQSZI3keoa+DX/nhSMDm4brPGCfOIx8MimQv
   xnjsZiExxD2XOKRlKR74NvI7+B/oZKpqAZnrmYHVN3HHA+tT3jCMMDAX9
   OaqGyELiimZUqk/Hl1rv632oWcDOvwJGM/XAUoTsIUv1H1v4H+Sym/jxl
   fwFavrJ+J5IzzhqTuxq8I9nHdIc0BLFSwnXUlhGb/dQ6pDV/DZoA/nhOf
   2cXpwjZQOByvywfGZA19sIGaW6m2Hd4lGrLqiKO59eW10SwOeFKP5rOHD
   g==;
X-CSE-ConnectionGUID: d9xQ4OixREqZTpsB4BSViw==
X-CSE-MsgGUID: JKSbaMaOTOyVMtPZLaiMBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29445431"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="29445431"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 04:51:43 -0700
X-CSE-ConnectionGUID: tC1fJ/waSmOwRZJZpSYsmQ==
X-CSE-MsgGUID: JLkK7m4LTGOG4SzyZIDoZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="93201442"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Sep 2024 04:51:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srFhC-000DEC-0f;
	Thu, 19 Sep 2024 11:51:38 +0000
Date: Thu, 19 Sep 2024 19:51:36 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 423c9baae4c7fe73d5812e28610418fd2e8050bd
Message-ID: <202409191931.NPhtXLmX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 423c9baae4c7fe73d5812e28610418fd2e8050bd  cxl: Fix comment regarding cxl_query_cmd() return data

elapsed time: 743m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240919    gcc-13.2.0
arc                   randconfig-002-20240919    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                          exynos_defconfig    clang-17
arm                   randconfig-001-20240919    clang-20
arm                   randconfig-002-20240919    clang-20
arm                   randconfig-003-20240919    clang-20
arm                   randconfig-004-20240919    clang-20
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240919    gcc-14.1.0
arm64                 randconfig-002-20240919    clang-15
arm64                 randconfig-003-20240919    clang-20
arm64                 randconfig-004-20240919    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240919    gcc-14.1.0
csky                  randconfig-002-20240919    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20240919    clang-20
hexagon               randconfig-002-20240919    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240919    clang-18
i386        buildonly-randconfig-002-20240919    clang-18
i386        buildonly-randconfig-002-20240919    gcc-12
i386        buildonly-randconfig-003-20240919    clang-18
i386        buildonly-randconfig-004-20240919    clang-18
i386        buildonly-randconfig-004-20240919    gcc-12
i386        buildonly-randconfig-005-20240919    clang-18
i386        buildonly-randconfig-006-20240919    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240919    clang-18
i386                  randconfig-002-20240919    clang-18
i386                  randconfig-003-20240919    clang-18
i386                  randconfig-003-20240919    gcc-12
i386                  randconfig-004-20240919    clang-18
i386                  randconfig-005-20240919    clang-18
i386                  randconfig-006-20240919    clang-18
i386                  randconfig-011-20240919    clang-18
i386                  randconfig-011-20240919    gcc-12
i386                  randconfig-012-20240919    clang-18
i386                  randconfig-012-20240919    gcc-12
i386                  randconfig-013-20240919    clang-18
i386                  randconfig-014-20240919    clang-18
i386                  randconfig-014-20240919    gcc-12
i386                  randconfig-015-20240919    clang-18
i386                  randconfig-015-20240919    gcc-11
i386                  randconfig-016-20240919    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240919    gcc-14.1.0
loongarch             randconfig-002-20240919    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip22_defconfig    gcc-14.1.0
mips                     loongson2k_defconfig    gcc-13.2.0
mips                      maltaaprp_defconfig    clang-14
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240919    gcc-14.1.0
nios2                 randconfig-002-20240919    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           alldefconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240919    gcc-14.1.0
parisc                randconfig-002-20240919    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240919    gcc-14.1.0
powerpc               randconfig-002-20240919    clang-20
powerpc               randconfig-003-20240919    gcc-14.1.0
powerpc                     stx_gp3_defconfig    clang-20
powerpc64             randconfig-001-20240919    clang-15
powerpc64             randconfig-002-20240919    clang-20
powerpc64             randconfig-003-20240919    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240919    gcc-14.1.0
riscv                 randconfig-002-20240919    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20240919    gcc-14.1.0
s390                  randconfig-002-20240919    clang-20
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                        dreamcast_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                    randconfig-001-20240919    gcc-14.1.0
sh                    randconfig-002-20240919    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240919    gcc-14.1.0
sparc64               randconfig-002-20240919    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240919    clang-17
um                    randconfig-002-20240919    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240919    gcc-14.1.0
xtensa                randconfig-002-20240919    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
