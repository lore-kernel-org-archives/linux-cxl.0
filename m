Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDCC481A91
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043613; cv=none; b=cn2kenlyVosptzUi56dM1kpbzyaDFgIfgwE4tlrAfW1w2IxQ6fCC05SLkQ7Ag16UQzPHhgUuNrvMEumJ9ann3T7mqRhN5hqml7QWb8BMz6rWWDXSDzeF2ZyERMicDU5E+tsav5dNYqIVvG1lz8YcjOuSYu07yuWXRuH1jEmJuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043613; c=relaxed/simple;
	bh=YHdSsbOdHw/EkCCgBSDLo98VZ4SwelL+D7cTdD1JD5A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jc6bvYVRUJdNqX1iO6jE0dRG+wju9K/YDSri8Ig19XLmtlXnqJOnyvWvbiqd+17k9WbuKccFBr2yE3JTrTHz7WWoO87eRE841ACq3l4TEWslffR6pSS0SsS/IIFp7RNTCruodpzgH2wKuTGYYHfqZDjs/xg3KUWFj+NV54t3+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwI7mbOh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwI7mbOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781043612; x=1812579612;
  h=date:from:to:cc:subject:message-id;
  bh=YHdSsbOdHw/EkCCgBSDLo98VZ4SwelL+D7cTdD1JD5A=;
  b=fwI7mbOhThZ+M0y7u9ZlhFgSQjD1v4vPfmFtyr+LdWSfVRdXg7C/U/lY
   d5edfYJcFwBsdHUyyuQQDl3nb6qdCatmB6v57DnAu/D6RMn/2bKHGrhY9
   QI7+T/kNlsDXNVHIyPE/SIrIGth6f4JgeyjDUVm4TtBKXX65hAPW2/VB4
   vO/O926+ThV8pU/y/ajciTIGJe2DXUTmGtny8Cv4WINnVqoIvRwKYw8Oq
   WspBQD2oKG0AZIE08+y9CVxxQWR6ftXtguoeo00s68M4LK6g/DyWpneWs
   NbEiiYrQKR3R2PAkXX9YP7WEp/Vj2izM89YbBZs0WDkvmBNgS6g2DnHYg
   A==;
X-CSE-ConnectionGUID: Q79buWpVS4iOmDWLntim9g==
X-CSE-MsgGUID: 2B3JkRVtTlu++YDQLl4yLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92499318"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92499318"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:20:11 -0700
X-CSE-ConnectionGUID: cdt6lvT0R9u3+/xd0hDNOA==
X-CSE-MsgGUID: bRz3xKMOSzKXb+7jyMIquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="243014420"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jun 2026 15:20:09 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX4nn-00000000Kbm-1Cac;
	Tue, 09 Jun 2026 22:20:07 +0000
Date: Wed, 10 Jun 2026 06:19:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.3/cxl-type2-enabling] BUILD REGRESSION
 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
Message-ID: <202606100636.hbI7dTJS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.3/cxl-type2-enabling
branch HEAD: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686  cxl/region: Introduce devm_cxl_probe_mem()

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202606100235.1ur3Z4YQ-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202606100401.GOjzpKHo-lkp@intel.com

    ld.lld: error: undefined symbol: cxl_memdev_attach_region
    mem.c:(.text+0x66): undefined reference to `cxl_memdev_attach_region'
    mem.c:(.text+0x69): undefined reference to `cxl_memdev_attach_region'
    mem.c:(.text+0x9f): undefined reference to `cxl_memdev_attach_region'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- mem.c:(.text):undefined-reference-to-cxl_memdev_attach_region
|-- i386-buildonly-randconfig-004-20260609
|   `-- ld.lld:error:undefined-symbol:cxl_memdev_attach_region
|-- s390-randconfig-001-20260609
|   `-- ld.lld:error:undefined-symbol:cxl_memdev_attach_region
|-- um-randconfig-002-20260609
|   `-- mem.c:(.text):undefined-reference-to-cxl_memdev_attach_region
`-- x86_64-buildonly-randconfig-005-20260610
    `-- mem.c:(.text):undefined-reference-to-cxl_memdev_attach_region

elapsed time: 1314m

configs tested: 259
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260609    gcc-15.2.0
arc                   randconfig-001-20260610    gcc-8.5.0
arc                   randconfig-002-20260609    gcc-13.4.0
arc                   randconfig-002-20260610    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                       imx_v6_v7_defconfig    clang-23
arm                   randconfig-001-20260609    gcc-13.4.0
arm                   randconfig-001-20260610    gcc-8.5.0
arm                   randconfig-002-20260609    clang-23
arm                   randconfig-002-20260610    gcc-8.5.0
arm                   randconfig-003-20260609    clang-23
arm                   randconfig-003-20260610    gcc-8.5.0
arm                   randconfig-004-20260609    clang-23
arm                   randconfig-004-20260610    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260609    clang-23
arm64                 randconfig-001-20260610    gcc-11.5.0
arm64                          randconfig-002    gcc-8.5.0
arm64                 randconfig-002-20260610    gcc-11.5.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20260610    gcc-11.5.0
arm64                 randconfig-004-20260609    clang-23
arm64                 randconfig-004-20260610    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-13.4.0
csky                  randconfig-001-20260609    gcc-9.5.0
csky                  randconfig-001-20260610    gcc-11.5.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260609    gcc-11.5.0
csky                  randconfig-002-20260610    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260609    clang-18
hexagon               randconfig-001-20260610    clang-22
hexagon               randconfig-002-20260609    clang-23
hexagon               randconfig-002-20260610    clang-22
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260609    gcc-14
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260609    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260609    clang-22
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260609    clang-22
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260609    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260609    clang-22
i386        buildonly-randconfig-006-20260610    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260609    gcc-14
i386                  randconfig-002-20260609    gcc-14
i386                  randconfig-007-20260609    gcc-14
i386                  randconfig-011-20260609    clang-22
i386                  randconfig-011-20260610    gcc-14
i386                  randconfig-012-20260609    clang-22
i386                  randconfig-012-20260610    gcc-14
i386                  randconfig-013-20260609    clang-22
i386                  randconfig-013-20260610    gcc-14
i386                  randconfig-014-20260609    gcc-14
i386                  randconfig-014-20260610    gcc-14
i386                  randconfig-015-20260609    clang-22
i386                  randconfig-015-20260610    gcc-14
i386                  randconfig-016-20260609    clang-22
i386                  randconfig-016-20260610    gcc-14
i386                  randconfig-017-20260609    gcc-14
i386                  randconfig-017-20260610    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260609    clang-23
loongarch             randconfig-001-20260610    clang-22
loongarch             randconfig-002-20260609    clang-23
loongarch             randconfig-002-20260610    clang-22
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260609    gcc-11.5.0
nios2                 randconfig-001-20260610    clang-22
nios2                 randconfig-002-20260609    gcc-11.5.0
nios2                 randconfig-002-20260610    clang-22
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260609    gcc-14.3.0
parisc                randconfig-001-20260610    gcc-8.5.0
parisc                randconfig-002-20260609    gcc-16.1.0
parisc                randconfig-002-20260610    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                   microwatt_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260609    clang-23
powerpc               randconfig-001-20260610    gcc-8.5.0
powerpc               randconfig-002-20260609    clang-23
powerpc               randconfig-002-20260610    gcc-8.5.0
powerpc                     tqm8548_defconfig    clang-23
powerpc64             randconfig-001-20260609    gcc-8.5.0
powerpc64             randconfig-001-20260610    gcc-8.5.0
powerpc64             randconfig-002-20260609    gcc-13.4.0
powerpc64             randconfig-002-20260610    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260610    gcc-16.1.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260609    clang-23
riscv                 randconfig-002-20260610    gcc-16.1.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260609    clang-23
s390                  randconfig-001-20260610    gcc-16.1.0
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260609    gcc-16.1.0
s390                  randconfig-002-20260610    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260609    gcc-13.4.0
sh                    randconfig-001-20260610    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260609    gcc-11.5.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260609    gcc-16.1.0
sparc                 randconfig-001-20260610    gcc-14.3.0
sparc                 randconfig-002-20260609    gcc-16.1.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260609    clang-23
sparc64               randconfig-001-20260610    gcc-14.3.0
sparc64               randconfig-002-20260609    gcc-10.5.0
sparc64               randconfig-002-20260610    gcc-14.3.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260609    gcc-14
um                    randconfig-001-20260610    gcc-14.3.0
um                    randconfig-002-20260609    gcc-12
um                    randconfig-002-20260610    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260609    clang-22
x86_64      buildonly-randconfig-001-20260610    gcc-14
x86_64      buildonly-randconfig-002-20260609    clang-22
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64      buildonly-randconfig-003-20260609    clang-22
x86_64      buildonly-randconfig-003-20260610    gcc-14
x86_64      buildonly-randconfig-004-20260609    gcc-14
x86_64      buildonly-randconfig-004-20260610    gcc-14
x86_64      buildonly-randconfig-005-20260609    clang-22
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64      buildonly-randconfig-006-20260609    gcc-14
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260609    gcc-14
x86_64                randconfig-002-20260609    clang-22
x86_64                randconfig-003-20260609    gcc-14
x86_64                randconfig-004-20260609    clang-22
x86_64                randconfig-005-20260609    clang-22
x86_64                randconfig-006-20260609    clang-22
x86_64                randconfig-011-20260609    gcc-14
x86_64                randconfig-012-20260609    clang-22
x86_64                randconfig-013-20260609    gcc-14
x86_64                randconfig-014-20260609    gcc-14
x86_64                randconfig-015-20260609    clang-22
x86_64                randconfig-016-20260609    gcc-14
x86_64                randconfig-071-20260609    clang-22
x86_64                randconfig-072-20260609    clang-22
x86_64                randconfig-073-20260609    clang-22
x86_64                randconfig-074-20260609    gcc-14
x86_64                randconfig-075-20260609    gcc-14
x86_64                randconfig-076-20260609    clang-22
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
xtensa                randconfig-001-20260609    gcc-16.1.0
xtensa                randconfig-001-20260610    gcc-14.3.0
xtensa                randconfig-002-20260609    gcc-8.5.0
xtensa                randconfig-002-20260610    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
