Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504E40D588
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268254; cv=none; b=qyI6nMgSs/uw5DGTmpSXBE0PGHdQrg/eGQnO4J/TTTaNQlp586C/8Jz0kxiXSJDhyi8WToqtQFfHHNhItaH7z1WDZsLt8tpnlhBu52Vhcug8SrXKz/hCTcH3zn2HHetvvosDx59tjhUD0ka63yvuWIghhKG00IiFwY6PvcQstoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268254; c=relaxed/simple;
	bh=CG/AvmqG2vxlcYI8otI6pILhRgiQBb9yTEcat+pHItQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nfTfhoGCofkLEh/kKk1ug5cG8Rlu61QJDIOI0fxkWqkaMDpeICGSrRsCwAueWbSBTYauzVSq+/xtddA0o19dXxWeOoeNdqgJSCot4ti3VZksUpJV8UWphX3v73pyAUf1T8jfEvfMt4fx2zHjU+DDNTvtKreF7STdjgQ0IkTcV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTJAvoWH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTJAvoWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790268251; x=1821804251;
  h=date:from:to:cc:subject:message-id;
  bh=CG/AvmqG2vxlcYI8otI6pILhRgiQBb9yTEcat+pHItQ=;
  b=iTJAvoWHwZyNnoezIWzBKwGGKIe+rdzf3xUib4Ps0HPWce+nOGqA/xXy
   V0HK4HC4x0uzzQV6y0gMKnAyWTSsuTzjR8gbu+DVfYFCUY4ioRQt/LqLe
   uoyMMCazJ0T++2edusT6v+F2OQ3hgZd+NB4olVz5rrqrTeFAFu5hoUUlC
   S+7GYAy3ULnS3L5tAjzbrsahYWQDA5+83WnLE0vYv2fVA8/86ltAI+leO
   1Iwat8MfPECnX3YBhvbgPcgoVMQAj4HDncN9k0tz8y9FVaSR6Uw2J0wCB
   9UrRJsNTKRcXE7wiw+MzSCgCcXpS5sq7c5JvtavVLs+3ZJNDaGJ2IPFQO
   Q==;
X-CSE-ConnectionGUID: 0yzplPeHTsCmNEjxaC4ZIg==
X-CSE-MsgGUID: vFBs3IQ7R4KcbnUM0uTO+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91153225"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91153225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:44:10 -0700
X-CSE-ConnectionGUID: f3lbEqTEQxmYqzZr3wfZdg==
X-CSE-MsgGUID: NbXb/pD5SUOBYYrUAz6sTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311995093"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 09:44:09 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9mYH-00000000JBC-0lCY;
	Thu, 24 Sep 2026 16:44:05 +0000
Date: Fri, 25 Sep 2026 00:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 f2e9991100c903ec2d8eb62c3a1d6e0b9c67432e
Message-ID: <202609250020.2EWcDu8M-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: f2e9991100c903ec2d8eb62c3a1d6e0b9c67432e  Merge branch 'for-7.4/cxl-fixes' into cxl-for-next

elapsed time: 4243m

configs tested: 391
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1304-20260924    gcc-16.1.0 sparse
alpha                randconfig-r2107-20260923    gcc-10.5.0 cocci
alpha                randconfig-r2107-20260924    gcc-16.1.0 cocci
alpha                randconfig-r2201-20260923    gcc-8.5.0  smatch
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260924    clang-24
arc                   randconfig-1000-20260924    gcc-12.5.0
arc                   randconfig-1001-20260924    clang-24
arc                   randconfig-1001-20260924    gcc-14.3.0
arc                  randconfig-r2102-20260924    gcc-12.5.0 cocci
arc                            tb10x_defconfig    gcc-16.1.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           ep93xx_defconfig    clang-24
arm                         keystone_defconfig    gcc-16.1.0
arm                    milbeaut_m10v_defconfig    clang-17
arm                         multi_v7_defconfig    clang-24
arm                   randconfig-1000-20260924    clang-24
arm                   randconfig-1000-20260924    gcc-10.5.0
arm                   randconfig-1001-20260924    clang-24
arm                   randconfig-1002-20260924    clang-19
arm                   randconfig-1002-20260924    clang-24
arm                   randconfig-1003-20260924    clang-20
arm                   randconfig-1003-20260924    clang-24
arm                  randconfig-r1300-20260923    gcc-8.5.0  sparse
arm                  randconfig-r1305-20260924    gcc-16.1.0 sparse
arm                  randconfig-r2100-20260923    gcc-8.5.0  cocci
arm                  randconfig-r2201-20260923    gcc-16.1.0 smatch
arm                        spear13xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260924    gcc-11.5.0
arm64                 randconfig-1001-20260924    gcc-11.5.0
arm64                 randconfig-1001-20260924    gcc-8.5.0
arm64                 randconfig-1002-20260924    gcc-11.5.0
arm64                 randconfig-1003-20260924    gcc-11.5.0
arm64                 randconfig-1003-20260924    gcc-13.4.0
arm64                randconfig-r1302-20260924    gcc-16.1.0 sparse
arm64                randconfig-r1302-20260924    gcc-9.5.0  sparse
arm64                randconfig-r1303-20260923    gcc-8.5.0  sparse
arm64                randconfig-r1307-20260924    gcc-11.5.0 sparse
arm64                randconfig-r2106-20260924    gcc-16.1.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260924    gcc-11.5.0
csky                  randconfig-1000-20260924    gcc-16.1.0
csky                  randconfig-1001-20260924    gcc-11.5.0
csky                  randconfig-1001-20260924    gcc-14.3.0
csky                 randconfig-r1300-20260924    gcc-16.1.0 sparse
csky                 randconfig-r1302-20260923    gcc-8.5.0  sparse
csky                 randconfig-r2103-20260923    gcc-8.5.0  cocci
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260924    clang-17
hexagon               randconfig-1000-20260924    gcc-8.5.0
hexagon               randconfig-1001-20260924    clang-19
hexagon               randconfig-1001-20260924    gcc-8.5.0
hexagon              randconfig-r1301-20260924    gcc-16.1.0 sparse
hexagon              randconfig-r1304-20260924    clang-24   sparse
hexagon              randconfig-r2104-20260923    clang-24   cocci
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260924    gcc-14
i386        buildonly-randconfig-1001-20260924    gcc-14
i386        buildonly-randconfig-1002-20260924    clang-22
i386        buildonly-randconfig-1002-20260924    gcc-14
i386        buildonly-randconfig-1003-20260924    gcc-14
i386        buildonly-randconfig-1004-20260924    gcc-14
i386        buildonly-randconfig-1005-20260924    clang-22
i386        buildonly-randconfig-1005-20260924    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260924    gcc-12
i386                  randconfig-1000-20260924    gcc-14
i386                  randconfig-1001-20260924    clang-22
i386                  randconfig-1001-20260924    gcc-12
i386                  randconfig-1002-20260924    gcc-12
i386                  randconfig-1003-20260924    gcc-12
i386                  randconfig-1003-20260924    gcc-14
i386                  randconfig-1004-20260924    gcc-12
i386                  randconfig-1004-20260924    gcc-14
i386                  randconfig-1005-20260924    clang-22
i386                  randconfig-1005-20260924    gcc-12
i386                  randconfig-1006-20260924    gcc-12
i386                  randconfig-1007-20260924    clang-22
i386                  randconfig-1008-20260924    clang-22
i386                  randconfig-1009-20260924    clang-22
i386                  randconfig-1010-20260924    clang-22
i386                  randconfig-1011-20260924    clang-22
i386                  randconfig-1012-20260924    clang-22
i386                  randconfig-1013-20260924    clang-22
i386                  randconfig-1300-20260924    clang-22   sparse
i386                  randconfig-1300-20260924    gcc-14     sparse
i386                  randconfig-1301-20260924    clang-22   sparse
i386                  randconfig-1301-20260924    gcc-14     sparse
i386                  randconfig-1302-20260924    clang-22   sparse
i386                  randconfig-2100-20260923    clang-22   cocci
i386                  randconfig-2101-20260923    clang-22   cocci
i386                  randconfig-2102-20260923    clang-22   cocci
i386                  randconfig-2103-20260923    clang-22   cocci
i386                  randconfig-2200-20260923    gcc-12     smatch
i386                 randconfig-r2100-20260923    gcc-14     cocci
i386                 randconfig-r2202-20260924    gcc-14     smatch
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260924    gcc-15.2.0
loongarch             randconfig-1000-20260924    gcc-8.5.0
loongarch             randconfig-1001-20260924    gcc-13.4.0
loongarch             randconfig-1001-20260924    gcc-8.5.0
loongarch            randconfig-r1300-20260924    gcc-16.1.0 sparse
loongarch            randconfig-r2104-20260923    gcc-10.5.0 cocci
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                           amiga_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                        m5249evb_defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    gcc-16.1.0
m68k                 randconfig-r2105-20260923    gcc-10.5.0 cocci
m68k                 randconfig-r2106-20260923    gcc-12.5.0 cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2100-20260924    gcc-12.5.0 cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                 randconfig-r1309-20260924    gcc-11.5.0 sparse
nios2                          3c120_defconfig    gcc-11.5.0
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260924    gcc-8.5.0
nios2                 randconfig-1001-20260924    gcc-11.5.0
nios2                 randconfig-1001-20260924    gcc-8.5.0
nios2                randconfig-r1303-20260924    gcc-16.1.0 sparse
nios2                randconfig-r1305-20260923    gcc-8.5.0  sparse
nios2                randconfig-r1306-20260924    gcc-11.5.0 sparse
nios2                randconfig-r1307-20260924    gcc-9.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
parisc                            alldefconfig    clang-24
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260924    gcc-14.3.0
parisc                randconfig-1000-20260924    gcc-8.5.0
parisc                randconfig-1001-20260924    gcc-16.1.0
parisc                randconfig-1001-20260924    gcc-8.5.0
parisc               randconfig-r1303-20260924    gcc-13.4.0 sparse
parisc               randconfig-r1306-20260924    gcc-11.5.0 sparse
parisc               randconfig-r1306-20260924    gcc-14     sparse
parisc               randconfig-r2104-20260924    gcc-16.1.0 cocci
parisc               randconfig-r2106-20260923    gcc-10.5.0 cocci
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                     adder875_defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                       cm5200_defconfig    clang-24
powerpc                       mgcoge_defconfig    gcc-16.1.0
powerpc                      ppa8548_defconfig    clang-24
powerpc               randconfig-1000-20260924    gcc-8.5.0
powerpc               randconfig-1001-20260924    gcc-15.2.0
powerpc               randconfig-1001-20260924    gcc-8.5.0
powerpc              randconfig-r1304-20260923    gcc-8.5.0  sparse
powerpc64             randconfig-1000-20260924    gcc-8.5.0
powerpc64             randconfig-1001-20260924    gcc-10.5.0
powerpc64             randconfig-1001-20260924    gcc-8.5.0
powerpc64            randconfig-r1309-20260924    gcc-14     sparse
powerpc64            randconfig-r2101-20260924    gcc-12.5.0 cocci
powerpc64            randconfig-r2103-20260923    gcc-14     cocci
powerpc64            randconfig-r2201-20260924    gcc-10.5.0 smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260924    clang-17
riscv                 randconfig-1000-20260924    gcc-15.2.0
riscv                 randconfig-1001-20260924    gcc-15.2.0
riscv                 randconfig-2000-20260923    gcc-9.5.0
riscv                 randconfig-2000-20260924    clang-24
riscv                 randconfig-2001-20260923    gcc-9.5.0
riscv                 randconfig-2001-20260924    clang-24
riscv                randconfig-r1309-20260924    clang-24   sparse
riscv                randconfig-r2105-20260923    clang-22   cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260924    gcc-15.2.0
s390                  randconfig-1000-20260924    gcc-9.5.0
s390                  randconfig-1001-20260924    clang-17
s390                  randconfig-1001-20260924    gcc-15.2.0
s390                  randconfig-2000-20260923    gcc-9.5.0
s390                  randconfig-2000-20260924    clang-24
s390                  randconfig-2001-20260923    gcc-9.5.0
s390                  randconfig-2001-20260924    clang-24
s390                 randconfig-r1301-20260923    gcc-8.5.0  sparse
s390                 randconfig-r1308-20260924    gcc-11.5.0 sparse
s390                 randconfig-r2200-20260923    gcc-8.5.0  smatch
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                      magicpanelr2_defconfig    clang-24
sh                    randconfig-1000-20260924    gcc-15.2.0
sh                    randconfig-1000-20260924    gcc-16.1.0
sh                    randconfig-1001-20260924    gcc-15.2.0
sh                    randconfig-1001-20260924    gcc-16.1.0
sh                    randconfig-2000-20260923    gcc-9.5.0
sh                    randconfig-2000-20260924    clang-24
sh                    randconfig-2001-20260923    gcc-9.5.0
sh                    randconfig-2001-20260924    clang-24
sh                   randconfig-r2101-20260923    gcc-14     cocci
sh                    rts7751r2dplus_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260924    clang-17
sparc                 randconfig-1000-20260924    gcc-16.1.0
sparc                 randconfig-1001-20260924    clang-17
sparc                 randconfig-1001-20260924    gcc-14.3.0
sparc                 randconfig-2000-20260923    gcc-14.3.0
sparc                 randconfig-2001-20260923    gcc-14.3.0
sparc                randconfig-r1308-20260924    gcc-14     sparse
sparc                randconfig-r2105-20260924    gcc-16.1.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260924    clang-17
sparc64               randconfig-1000-20260924    gcc-9.5.0
sparc64               randconfig-1001-20260924    clang-17
sparc64               randconfig-1001-20260924    gcc-11.5.0
sparc64               randconfig-2000-20260923    gcc-14.3.0
sparc64               randconfig-2001-20260923    gcc-14.3.0
sparc64              randconfig-r2102-20260923    gcc-8.5.0  cocci
sparc64              randconfig-r2107-20260923    clang-24   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260924    clang-17
um                    randconfig-1001-20260924    clang-17
um                    randconfig-1001-20260924    clang-24
um                    randconfig-2000-20260923    gcc-14.3.0
um                    randconfig-2001-20260923    gcc-14.3.0
um                   randconfig-r1307-20260924    gcc-14     sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260923    gcc-14
x86_64      buildonly-randconfig-1000-20260924    clang-22
x86_64      buildonly-randconfig-1001-20260923    gcc-14
x86_64      buildonly-randconfig-1001-20260924    clang-22
x86_64      buildonly-randconfig-1001-20260924    gcc-12
x86_64      buildonly-randconfig-1002-20260923    gcc-14
x86_64      buildonly-randconfig-1002-20260924    clang-22
x86_64      buildonly-randconfig-1002-20260924    gcc-14
x86_64      buildonly-randconfig-1003-20260923    gcc-14
x86_64      buildonly-randconfig-1003-20260924    clang-22
x86_64      buildonly-randconfig-1003-20260924    gcc-14
x86_64      buildonly-randconfig-1004-20260923    gcc-14
x86_64      buildonly-randconfig-1004-20260924    clang-22
x86_64      buildonly-randconfig-1004-20260924    gcc-14
x86_64      buildonly-randconfig-1005-20260923    gcc-14
x86_64      buildonly-randconfig-1005-20260924    clang-22
x86_64      buildonly-randconfig-1005-20260924    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260924    clang-22
x86_64                randconfig-1000-20260924    gcc-14
x86_64                randconfig-1001-20260924    clang-22
x86_64                randconfig-1002-20260924    clang-22
x86_64                randconfig-1002-20260924    gcc-14
x86_64                randconfig-1003-20260924    clang-22
x86_64                randconfig-1004-20260924    clang-22
x86_64                randconfig-1004-20260924    gcc-14
x86_64                randconfig-1005-20260924    clang-22
x86_64                randconfig-1005-20260924    gcc-14
x86_64                randconfig-1006-20260924    clang-22
x86_64                randconfig-1006-20260924    gcc-14
x86_64                randconfig-1007-20260924    clang-22
x86_64                randconfig-1007-20260924    gcc-14
x86_64                randconfig-1008-20260924    clang-22
x86_64                randconfig-1009-20260924    clang-22
x86_64                randconfig-1010-20260924    clang-22
x86_64                randconfig-1010-20260924    gcc-14
x86_64                randconfig-1011-20260924    clang-22
x86_64                randconfig-1012-20260923    gcc-14
x86_64                randconfig-1012-20260924    clang-22
x86_64                randconfig-1013-20260923    gcc-14
x86_64                randconfig-1013-20260924    clang-22
x86_64                randconfig-1014-20260923    gcc-14
x86_64                randconfig-1014-20260924    clang-22
x86_64                randconfig-1015-20260923    gcc-14
x86_64                randconfig-1015-20260924    clang-22
x86_64                randconfig-1015-20260924    gcc-14
x86_64                randconfig-1016-20260923    gcc-14
x86_64                randconfig-1016-20260924    clang-22
x86_64                randconfig-1016-20260924    gcc-14
x86_64                randconfig-1017-20260923    gcc-14
x86_64                randconfig-1017-20260924    clang-22
x86_64                randconfig-1017-20260924    gcc-14
x86_64                randconfig-1300-20260924    clang-22   sparse
x86_64                randconfig-1300-20260924    gcc-14     sparse
x86_64                randconfig-1301-20260924    clang-22   sparse
x86_64                randconfig-1302-20260924    clang-22   sparse
x86_64                randconfig-2100-20260923    clang-22   cocci
x86_64                randconfig-2101-20260923    clang-22   cocci
x86_64                randconfig-2102-20260923    clang-22   cocci
x86_64                randconfig-2103-20260923    clang-22   cocci
x86_64                randconfig-2200-20260923    gcc-14     smatch
x86_64                randconfig-2200-20260924    clang-22   smatch
x86_64               randconfig-r1301-20260924    gcc-14     sparse
x86_64               randconfig-r2101-20260923    gcc-8.5.0  cocci
x86_64               randconfig-r2102-20260923    gcc-14     cocci
x86_64               randconfig-r2103-20260924    gcc-12.5.0 cocci
x86_64               randconfig-r2200-20260924    clang-22   smatch
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260924    clang-17
xtensa                randconfig-1000-20260924    gcc-10.5.0
xtensa                randconfig-1001-20260924    clang-17
xtensa                randconfig-1001-20260924    gcc-16.1.0
xtensa                randconfig-2000-20260923    gcc-14.3.0
xtensa                randconfig-2001-20260923    gcc-14.3.0
xtensa               randconfig-r1305-20260924    gcc-8.5.0  sparse
xtensa               randconfig-r1308-20260924    gcc-9.5.0  sparse
xtensa               randconfig-r2202-20260923    gcc-10.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
