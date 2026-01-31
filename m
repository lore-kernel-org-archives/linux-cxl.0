Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEB3EBF04
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841173; cv=none; b=OfkqUIO+XB1TpPL93Yx2toV7MUdTUMsrtUdLxCq8jyfOHX/hIIBafB4l43T62JUq1S5HrgMnykJciXQmNeCQ1/5Add0n3CWDB45di4FpoHNLJ9/l2VopJfRRGNtF0LAETfR0QVzs9L+J4qhkUQUJ4WEHd6pTTppTbV5nJP0W1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841173; c=relaxed/simple;
	bh=atpjeZd8Y1thxm9C/PN4v4YAFepnbH9MkG+6K76fL98=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j5KTyG2qJQeK6LZUOC6zYiLuZFEn+Cn31hgzL9RgO9MJX4l0rr/4PftGsnXJGsLuNWHMbVejbdiaVL6Xy3R+WL7PmrybNbMZdsB7QRpkhw4ZwXwDcVwdNoTBXMdxwmjqKJ8ENZagq75ZfpfhqB8c8TdT3RMfDffhtHJiNQ6vuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyaI1D2U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyaI1D2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769841171; x=1801377171;
  h=date:from:to:cc:subject:message-id;
  bh=atpjeZd8Y1thxm9C/PN4v4YAFepnbH9MkG+6K76fL98=;
  b=cyaI1D2UTq3Ge4TY8nKz7Y69NPDt2zsBgJz4aHqxiBHnDSIU7blgaKln
   DccbpRJYuxxkiTZsw0a7km2jAIQ4pailmNKmcneSPmYqCjNvjnwB95dgl
   tSgNvN4L84kf8ndWiWeIQ4KW71yD9x/CO2j39hXWXTvg0OkRLpKicogmX
   7xSfJvAWiKuwspxKdiwnuUUI7+ELa3HA6MeBgnK+5u7RDFyY5bEFAqR7T
   N08liIF3og/M7EAhIMOYhgAjJ+QaNTFVuZ1ZR3/y74QENJ4Konk6d7YXN
   L919gk+60y8BhBf7yk1V9WINe5E5i9T2GaEU/T0gN69Hg2fWVqHz+Mt1a
   g==;
X-CSE-ConnectionGUID: U71E9tl7RFmoqyZI7s4sFQ==
X-CSE-MsgGUID: sInVIV59RcejNeXPjF46GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="70997316"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="70997316"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 22:32:51 -0800
X-CSE-ConnectionGUID: F2kv6vxRQHienmAc4/Eonw==
X-CSE-MsgGUID: RyP3ldz/R3WBnsQjTtEa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209020546"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2026 22:32:48 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vm4XG-00000000dii-2kq8;
	Sat, 31 Jan 2026 06:32:46 +0000
Date: Sat, 31 Jan 2026 14:32:24 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 63050be0bfe0b280cce5d701b31940fd84858609
Message-ID: <202601311418.463XpBlS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 63050be0bfe0b280cce5d701b31940fd84858609  Merge branch 'for-7.0/cxl-misc' into cxl-for-next

elapsed time: 841m

configs tested: 250
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260131    gcc-10.5.0
arc                   randconfig-001-20260131    gcc-8.5.0
arc                   randconfig-002-20260131    gcc-14.3.0
arc                   randconfig-002-20260131    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260131    clang-22
arm                   randconfig-001-20260131    gcc-8.5.0
arm                   randconfig-002-20260131    gcc-8.5.0
arm                   randconfig-003-20260131    gcc-8.5.0
arm                   randconfig-004-20260131    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260131    clang-22
arm64                 randconfig-001-20260131    gcc-12.5.0
arm64                 randconfig-002-20260131    clang-22
arm64                 randconfig-003-20260131    clang-22
arm64                 randconfig-004-20260131    clang-22
arm64                 randconfig-004-20260131    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260131    clang-22
csky                  randconfig-001-20260131    gcc-14.3.0
csky                  randconfig-002-20260131    clang-22
csky                  randconfig-002-20260131    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260131    clang-22
hexagon               randconfig-001-20260131    gcc-11.5.0
hexagon               randconfig-002-20260131    clang-22
hexagon               randconfig-002-20260131    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260131    clang-20
i386        buildonly-randconfig-001-20260131    gcc-14
i386        buildonly-randconfig-002-20260131    clang-20
i386        buildonly-randconfig-002-20260131    gcc-14
i386        buildonly-randconfig-003-20260131    clang-20
i386        buildonly-randconfig-003-20260131    gcc-14
i386        buildonly-randconfig-004-20260131    clang-20
i386        buildonly-randconfig-004-20260131    gcc-14
i386        buildonly-randconfig-005-20260131    clang-20
i386        buildonly-randconfig-006-20260131    clang-20
i386        buildonly-randconfig-006-20260131    gcc-12
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260131    gcc-14
i386                  randconfig-002-20260131    gcc-14
i386                  randconfig-003-20260131    gcc-12
i386                  randconfig-003-20260131    gcc-14
i386                  randconfig-004-20260131    clang-20
i386                  randconfig-004-20260131    gcc-14
i386                  randconfig-005-20260131    gcc-14
i386                  randconfig-006-20260131    gcc-14
i386                  randconfig-007-20260131    gcc-14
i386                  randconfig-011-20260131    gcc-14
i386                  randconfig-012-20260131    clang-20
i386                  randconfig-012-20260131    gcc-14
i386                  randconfig-013-20260131    gcc-14
i386                  randconfig-014-20260131    gcc-14
i386                  randconfig-015-20260131    gcc-14
i386                  randconfig-016-20260131    gcc-14
i386                  randconfig-017-20260131    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260131    clang-22
loongarch             randconfig-001-20260131    gcc-11.5.0
loongarch             randconfig-002-20260131    clang-22
loongarch             randconfig-002-20260131    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                       bvme6000_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260131    gcc-10.5.0
nios2                 randconfig-001-20260131    gcc-11.5.0
nios2                 randconfig-002-20260131    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260131    gcc-8.5.0
parisc                randconfig-002-20260131    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260131    gcc-8.5.0
powerpc               randconfig-001-20260131    gcc-9.5.0
powerpc               randconfig-002-20260131    gcc-8.5.0
powerpc64             randconfig-001-20260131    gcc-8.5.0
powerpc64             randconfig-002-20260131    gcc-13.4.0
powerpc64             randconfig-002-20260131    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260131    gcc-8.5.0
riscv                 randconfig-002-20260131    gcc-12.5.0
riscv                 randconfig-002-20260131    gcc-8.5.0
s390                             alldefconfig    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260131    gcc-8.5.0
s390                  randconfig-002-20260131    clang-22
s390                  randconfig-002-20260131    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                    randconfig-001-20260131    gcc-8.5.0
sh                    randconfig-001-20260131    gcc-9.5.0
sh                    randconfig-002-20260131    gcc-15.2.0
sh                    randconfig-002-20260131    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260131    gcc-14
sparc                 randconfig-001-20260131    gcc-15.2.0
sparc                 randconfig-002-20260131    gcc-13.4.0
sparc                 randconfig-002-20260131    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260131    clang-22
sparc64               randconfig-001-20260131    gcc-14
sparc64               randconfig-002-20260131    gcc-12.5.0
sparc64               randconfig-002-20260131    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260131    gcc-14
um                    randconfig-002-20260131    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260131    gcc-14
x86_64      buildonly-randconfig-002-20260131    gcc-14
x86_64      buildonly-randconfig-003-20260131    gcc-14
x86_64      buildonly-randconfig-004-20260131    gcc-14
x86_64      buildonly-randconfig-005-20260131    gcc-14
x86_64      buildonly-randconfig-006-20260131    clang-20
x86_64      buildonly-randconfig-006-20260131    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260131    clang-20
x86_64                randconfig-002-20260131    clang-20
x86_64                randconfig-003-20260131    clang-20
x86_64                randconfig-004-20260131    clang-20
x86_64                randconfig-004-20260131    gcc-13
x86_64                randconfig-005-20260131    clang-20
x86_64                randconfig-006-20260131    clang-20
x86_64                randconfig-011-20260131    clang-20
x86_64                randconfig-011-20260131    gcc-12
x86_64                randconfig-012-20260131    clang-20
x86_64                randconfig-013-20260131    clang-20
x86_64                randconfig-013-20260131    gcc-14
x86_64                randconfig-014-20260131    clang-20
x86_64                randconfig-014-20260131    gcc-14
x86_64                randconfig-015-20260131    clang-20
x86_64                randconfig-015-20260131    gcc-14
x86_64                randconfig-016-20260131    clang-20
x86_64                randconfig-071-20260131    gcc-14
x86_64                randconfig-072-20260131    clang-20
x86_64                randconfig-073-20260131    gcc-14
x86_64                randconfig-074-20260131    clang-20
x86_64                randconfig-075-20260131    gcc-14
x86_64                randconfig-076-20260131    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260131    gcc-14
xtensa                randconfig-001-20260131    gcc-14.3.0
xtensa                randconfig-002-20260131    gcc-10.5.0
xtensa                randconfig-002-20260131    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
