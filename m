Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404918BBB0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142459; cv=none; b=O7chzdeFcFha169WJ+NYgPWEPVj9cr2kebhea7F8ZambC1SqyE9kNP3lsL/1NAXxAN0eFS7YWLm0qpl1CNqanWhWrqzSvAWQ5yCs7Anvn0uXLNVybOoKZO4XI9TPbKhSYQewkbmpATw6KokdvGdp/ZN3f6I+bX8fpqhb+1I7nhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142459; c=relaxed/simple;
	bh=wTpm0YVeLgbTG2ETUeGCMkIPzgqgeXFz65yJ4axC6t0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OyRZO1lshfAweoQw+1xfwg+2Q+03R2A4DfCaxqwtSSll/McUksf4rhOZuAIJlYf3IMUf3Lr4KGQrH1HzrKRQkGMa32JDC+h1rILa0qvo804LlzsQYAEm1lMKWRdp1h4284L+zdPFU4PCnpVMrBG98WXjxJAavhjZuAyLIalT4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnFbv2VK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnFbv2VK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726142457; x=1757678457;
  h=date:from:to:cc:subject:message-id;
  bh=wTpm0YVeLgbTG2ETUeGCMkIPzgqgeXFz65yJ4axC6t0=;
  b=KnFbv2VK7TCJx7oRFViKUdC7J1bs0QpG6L2dfebo1nn6L2+N7aXhAZDG
   N/e21lrzQwYZ3aOOnvFPysO0lGRAmL1RL03z2vsJrhMh+64+GRaL9Hosf
   LVnJflP59sow9CF4pgSeeYrvKeVwxpPlsgCGS3C/bjwovXiLSymcH1Q5d
   CNzDq11/sy56fpwc7HY89XHwKrNL7gWFIXTsF0nqbVvynDn60sblpAgrz
   MdYwn3LBMR6WVqBqe1AHiaQGc87PUVXH5d72nUYsbGrbu5twEOR9vxQft
   9O4vuY+4XJIRP1KBgIKY9kXY07dJyWUJkVA0SRedx+AhZGZ71tKmt/kqk
   w==;
X-CSE-ConnectionGUID: f/MC9CN2SLibQOrYAaGkWw==
X-CSE-MsgGUID: YbswEfrYQq+Xm06lHgBasA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24864926"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24864926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:00:57 -0700
X-CSE-ConnectionGUID: /BBglbzAQ0iCSDbdigR1jw==
X-CSE-MsgGUID: bJ6CDCWAQ26fdeHOIyV4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72493604"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 05:00:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soiVI-00056p-0S;
	Thu, 12 Sep 2024 12:00:52 +0000
Date: Thu, 12 Sep 2024 20:00:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 6c1a151d4ea7973c80784777129b63f43b050cdd
Message-ID: <202409122006.ttJY5oWm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 6c1a151d4ea7973c80784777129b63f43b050cdd  cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input

elapsed time: 739m

configs tested: 232
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
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
arc                   randconfig-001-20240912    gcc-13.2.0
arc                   randconfig-002-20240912    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240912    gcc-14.1.0
arm                   randconfig-002-20240912    clang-20
arm                   randconfig-003-20240912    gcc-14.1.0
arm                   randconfig-004-20240912    clang-20
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                            allyesconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240912    clang-20
arm64                 randconfig-002-20240912    clang-20
arm64                 randconfig-003-20240912    gcc-14.1.0
arm64                 randconfig-004-20240912    gcc-14.1.0
csky                             allmodconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                             allyesconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240912    gcc-14.1.0
csky                  randconfig-002-20240912    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240912    clang-20
hexagon               randconfig-002-20240912    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240912    gcc-12
i386        buildonly-randconfig-002-20240912    gcc-11
i386        buildonly-randconfig-002-20240912    gcc-12
i386        buildonly-randconfig-003-20240912    gcc-12
i386        buildonly-randconfig-004-20240912    clang-18
i386        buildonly-randconfig-004-20240912    gcc-12
i386        buildonly-randconfig-005-20240912    gcc-12
i386        buildonly-randconfig-006-20240912    clang-18
i386        buildonly-randconfig-006-20240912    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240912    gcc-12
i386                  randconfig-002-20240912    gcc-12
i386                  randconfig-003-20240912    gcc-11
i386                  randconfig-003-20240912    gcc-12
i386                  randconfig-004-20240912    gcc-12
i386                  randconfig-005-20240912    clang-18
i386                  randconfig-005-20240912    gcc-12
i386                  randconfig-006-20240912    clang-18
i386                  randconfig-006-20240912    gcc-12
i386                  randconfig-011-20240912    clang-18
i386                  randconfig-011-20240912    gcc-12
i386                  randconfig-012-20240912    gcc-12
i386                  randconfig-013-20240912    gcc-12
i386                  randconfig-014-20240912    gcc-12
i386                  randconfig-015-20240912    clang-18
i386                  randconfig-015-20240912    gcc-12
i386                  randconfig-016-20240912    clang-18
i386                  randconfig-016-20240912    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                        allyesconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240912    gcc-14.1.0
loongarch             randconfig-002-20240912    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       alldefconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                             allmodconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                             allyesconfig    gcc-14.1.0
mips                          ath25_defconfig    clang-20
mips                         db1xxx_defconfig    clang-20
mips                           ip28_defconfig    gcc-14.1.0
mips                       lemote2f_defconfig    gcc-14.1.0
mips                malta_qemu_32r6_defconfig    gcc-13.2.0
mips                          rb532_defconfig    clang-20
mips                          rm200_defconfig    gcc-13.2.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240912    gcc-14.1.0
nios2                 randconfig-002-20240912    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.1.0
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240912    gcc-14.1.0
parisc                randconfig-002-20240912    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-002-20240912    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240912    clang-14
powerpc64             randconfig-002-20240912    clang-20
powerpc64             randconfig-003-20240912    clang-16
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240912    gcc-14.1.0
riscv                 randconfig-002-20240912    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20240912    clang-20
s390                  randconfig-002-20240912    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240912    gcc-14.1.0
sh                    randconfig-002-20240912    gcc-14.1.0
sh                          rsk7203_defconfig    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                             sh03_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240912    gcc-14.1.0
sparc64               randconfig-002-20240912    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240912    gcc-12
um                    randconfig-002-20240912    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240912    clang-18
x86_64      buildonly-randconfig-002-20240912    clang-18
x86_64      buildonly-randconfig-003-20240912    clang-18
x86_64      buildonly-randconfig-004-20240912    clang-18
x86_64      buildonly-randconfig-005-20240912    clang-18
x86_64      buildonly-randconfig-006-20240912    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240912    clang-18
x86_64                randconfig-002-20240912    clang-18
x86_64                randconfig-003-20240912    clang-18
x86_64                randconfig-004-20240912    clang-18
x86_64                randconfig-005-20240912    clang-18
x86_64                randconfig-006-20240912    clang-18
x86_64                randconfig-011-20240912    clang-18
x86_64                randconfig-012-20240912    clang-18
x86_64                randconfig-013-20240912    clang-18
x86_64                randconfig-014-20240912    clang-18
x86_64                randconfig-015-20240912    clang-18
x86_64                randconfig-016-20240912    clang-18
x86_64                randconfig-071-20240912    clang-18
x86_64                randconfig-072-20240912    clang-18
x86_64                randconfig-073-20240912    clang-18
x86_64                randconfig-074-20240912    clang-18
x86_64                randconfig-075-20240912    clang-18
x86_64                randconfig-076-20240912    clang-18
x86_64                          rhel-8.3-rust    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240912    gcc-14.1.0
xtensa                randconfig-002-20240912    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
