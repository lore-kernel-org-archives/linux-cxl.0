Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161C15A845
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831146; cv=none; b=NnBW7F2+M8QuvFKNk5BnKZULjJkX6ZqDfrLSYIlY9CY9wvsTCUyxw0RJMntGEEvU8oZCh7GE9RbYILuwuxv2cJDElNvqlimdAZ5F7Y1ajBwlIdm9wQlDE7id2iD2VYfNnw9sPiXJo6Bz3WDNVTsem995Xjw7f6i1R5AMiejt3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831146; c=relaxed/simple;
	bh=FDS5NkmfcHTy8VkFiTXB2RjIISWD74SOTzJbv7kFN9c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UvzOCttuJtnu2/IfK2deur7+OeoZO7b7GVjqPD2zW73I6druflCYQf4WpTXm18Z0sFDQ3/bnNQHGRK6TAr/f9mMP+jyl42SUqbs3703F4Tovl8nt7HhNoE18l1s56LW/FRXoNyZzndvvm9jnTNGv5DTm5gb/M60kLStQMYZMYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1KRvn4+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1KRvn4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718831144; x=1750367144;
  h=date:from:to:cc:subject:message-id;
  bh=FDS5NkmfcHTy8VkFiTXB2RjIISWD74SOTzJbv7kFN9c=;
  b=B1KRvn4+4rOi6ZaGFQXWu7jpLVrEv+MSV1Og7qa0Aiy58XO++K2M2h+U
   1r3iG6+dFslzkDgSGF+ZmIxudsw3/g+pQ9O5k1MuVJUBFIkv0A1iZGY4/
   r8eHQiPvQmBqchn1mi9u1xyMQS114ZHfzSo0cnkYcHhIINvbRjChCFltX
   3y3mowHaHcPGvH1fwKmc7j3ccOp1v4urVkcdPerL5z/+tjqsDToBisQJe
   B2XRT62VS8qTbuhYTckqEws+bmo42ZqMXG6b5+ktzm6D6Npk08lKMeFp8
   8gwPh/XFHyyXaJve4WcuuZetNpLN17fw/BstF873OLai1jGZsUaLcQyz9
   Q==;
X-CSE-ConnectionGUID: e5cTu002S+ebCIrEN6QIMQ==
X-CSE-MsgGUID: YvMdEMz4QnGqa+/QetZ4uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26473968"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="26473968"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 14:05:43 -0700
X-CSE-ConnectionGUID: N6Q9zf4HQ4KKZ7V4Rorc/A==
X-CSE-MsgGUID: dauHJl1bRfSe9Yqx7OgjHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42724672"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Jun 2024 14:05:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK2Ut-0006zS-0J;
	Wed, 19 Jun 2024 21:05:39 +0000
Date: Thu, 20 Jun 2024 05:05:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 84ec985944ef34a34a1605b93ce401aa8737af96
Message-ID: <202406200527.BKbDpUvv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 84ec985944ef34a34a1605b93ce401aa8737af96  cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

elapsed time: 1202m

configs tested: 177
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240619   gcc-13.2.0
arc                   randconfig-002-20240619   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                         axm55xx_defconfig   clang-19
arm                                 defconfig   clang-14
arm                             mxs_defconfig   clang-19
arm                        neponset_defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm                   randconfig-001-20240619   clang-19
arm                   randconfig-002-20240619   clang-19
arm                   randconfig-003-20240619   clang-19
arm                   randconfig-004-20240619   gcc-13.2.0
arm                        realview_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240619   clang-19
arm64                 randconfig-002-20240619   clang-19
arm64                 randconfig-003-20240619   clang-19
arm64                 randconfig-004-20240619   clang-19
csky                             allmodconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                             allyesconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240619   gcc-13.2.0
csky                  randconfig-002-20240619   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240619   clang-15
hexagon               randconfig-002-20240619   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240619   clang-18
i386         buildonly-randconfig-002-20240619   clang-18
i386         buildonly-randconfig-003-20240619   clang-18
i386         buildonly-randconfig-004-20240619   clang-18
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                                defconfig   clang-18
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-003-20240619   clang-18
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-005-20240619   clang-18
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-011-20240619   clang-18
i386                  randconfig-012-20240619   clang-18
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-014-20240619   clang-18
i386                  randconfig-015-20240619   clang-18
i386                  randconfig-016-20240619   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240619   gcc-13.2.0
loongarch             randconfig-002-20240619   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240619   gcc-13.2.0
nios2                 randconfig-002-20240619   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                 simple_smp_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240619   gcc-13.2.0
parisc                randconfig-002-20240619   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                   microwatt_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   clang-19
powerpc               randconfig-001-20240619   gcc-13.2.0
powerpc               randconfig-002-20240619   clang-15
powerpc               randconfig-003-20240619   gcc-13.2.0
powerpc64             randconfig-001-20240619   gcc-13.2.0
powerpc64             randconfig-002-20240619   gcc-13.2.0
powerpc64             randconfig-003-20240619   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240619   clang-15
riscv                 randconfig-002-20240619   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240619   clang-19
s390                  randconfig-002-20240619   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240619   gcc-13.2.0
sh                    randconfig-002-20240619   gcc-13.2.0
sh                          rsk7201_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240619   gcc-13.2.0
sparc64               randconfig-002-20240619   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240619   clang-19
um                    randconfig-002-20240619   clang-19
um                           x86_64_defconfig   clang-15
x86_64                           alldefconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240619   clang-18
x86_64       buildonly-randconfig-002-20240619   clang-18
x86_64       buildonly-randconfig-003-20240619   gcc-11
x86_64       buildonly-randconfig-004-20240619   clang-18
x86_64       buildonly-randconfig-005-20240619   clang-18
x86_64       buildonly-randconfig-006-20240619   gcc-13
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240619   gcc-13
x86_64                randconfig-002-20240619   clang-18
x86_64                randconfig-003-20240619   gcc-8
x86_64                randconfig-004-20240619   clang-18
x86_64                randconfig-005-20240619   clang-18
x86_64                randconfig-006-20240619   gcc-13
x86_64                randconfig-011-20240619   gcc-13
x86_64                randconfig-012-20240619   gcc-13
x86_64                randconfig-013-20240619   gcc-13
x86_64                randconfig-014-20240619   clang-18
x86_64                randconfig-015-20240619   clang-18
x86_64                randconfig-016-20240619   gcc-11
x86_64                randconfig-071-20240619   clang-18
x86_64                randconfig-072-20240619   clang-18
x86_64                randconfig-073-20240619   gcc-9
x86_64                randconfig-074-20240619   gcc-9
x86_64                randconfig-075-20240619   clang-18
x86_64                randconfig-076-20240619   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240619   gcc-13.2.0
xtensa                randconfig-002-20240619   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
