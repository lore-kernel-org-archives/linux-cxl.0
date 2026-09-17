Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECA4A99DE
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689309; cv=none; b=gWiuZIDhMdZB8uaEY8pw3HxgLZY/2WvwVhg9+9vVeQvY649oajmAudRI3mtF2r/okj6ZMvpEoJSpP6mx+x7XWgNoTngU2IX8/NRDbRCsjARQd9mKgc4M/0rfEC44r71W0dGmmwbGyGQMpC0AFLdDmohaf5CIZDNKf0tmAifgWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689309; c=relaxed/simple;
	bh=jxuBpiKLr4PG9jrneFI3O91KzTvxe3eLZjwDPmU03ek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rj/FE38wj25AOXKqE9RZEkSIQf+mQ9dw8qb8WP5+1EbEVq2ItwSf6QjBeQRkn19CEy6tj5Q67yxxMCEVUBSZA+LnRBmE6DdYaP8sFQjsCP/Zd2GGRB2OAgjcHksp9K/GhTPMcdVt1eJKJVmzR1PCWkcmBa6JU/HQ2KHXglIiewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkRscdWp; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkRscdWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789689307; x=1821225307;
  h=date:from:to:cc:subject:message-id;
  bh=jxuBpiKLr4PG9jrneFI3O91KzTvxe3eLZjwDPmU03ek=;
  b=jkRscdWpduhjpA8aeFTa8D94KRQLRyOz0WJybC6D1yGQW0yt6RT7Fsyt
   v+qTyNBTao9TLZwwhDt137aAuEqVzkUmKNq+flEn10pHHDwOzzXehu0il
   mJIZrq/jViTatuOyMzfPDo2B3n5nnyAfvnZDmKY+iHWn0l3rl+cYNO8rz
   43noFWV2WA4dJdJYQOlzVetC0kxe4l1RCeOLgVXrEbqy/fW0tLmLXDW76
   mbo8hpa2YhTPLs4HolqfIeh29BJIIiCu41R3DbjsN224rwFLA6hHqC6O5
   F0rAphaGsUfB0OTtQNWs+4PNq82XC8PAhh7LA2ipHmMGdQrpYcV/m04vK
   g==;
X-CSE-ConnectionGUID: d2P03PvhSceDsL4TA/XKbA==
X-CSE-MsgGUID: EKIU1Wx1SkWOpb8RUicLcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="674538"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="674538"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:55:06 -0700
X-CSE-ConnectionGUID: ofGVYgZTSlWLxABRpwAK+Q==
X-CSE-MsgGUID: Lw9N7pmiQUu67Qk6pUI6Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297566077"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 16:55:03 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7LwO-000000008mR-3fpw;
	Thu, 17 Sep 2026 23:54:56 +0000
Date: Fri, 18 Sep 2026 07:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 f63fae2960cf0f27dd8775747821e89a3e377e77
Message-ID: <202609180751.5pMtyFYl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: f63fae2960cf0f27dd8775747821e89a3e377e77  Merge branch 'for-7.4/decoder_hardening' into cxl-for-next

elapsed time: m

configs tested: 386
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1300-20260917    gcc-8.5.0  sparse
alpha                randconfig-r1304-20260917    clang-21   sparse
alpha                randconfig-r1306-20260917    clang-24   sparse
alpha                randconfig-r1306-20260917    gcc-15.2.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260917    gcc-15.2.0
arc                   randconfig-1000-20260917    gcc-8.5.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260917    gcc-15.2.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                  randconfig-r1302-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1303-20260917    gcc-8.5.0  sparse
arc                  randconfig-r1305-20260917    gcc-8.5.0  sparse
arc                  randconfig-r2201-20260917    gcc-10.5.0
arc                            tb10x_defconfig    gcc-16.1.0
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                        aspeed_g4_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                        imx_v6_v7_defconfig    gcc-16.1.0
arm                         multi_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260917    gcc-15.2.0
arm                   randconfig-1000-20260917    gcc-8.5.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260917    gcc-15.2.0
arm                   randconfig-1001-20260917    gcc-8.5.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260917    clang-17
arm                   randconfig-1002-20260917    gcc-15.2.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260917    gcc-15.2.0
arm                   randconfig-1003-20260917    gcc-8.5.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm                  randconfig-r1308-20260917    gcc-13.4.0 sparse
arm                          s5pv210_defconfig    clang-24
arm                          socfpga_defconfig    gcc-16.1.0
arm64                             alldefconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260917    gcc-11.5.0
arm64                 randconfig-1000-20260917    gcc-8.5.0
arm64                 randconfig-1001-20260917    gcc-11.5.0
arm64                 randconfig-1001-20260917    gcc-8.5.0
arm64                 randconfig-1002-20260917    clang-24
arm64                 randconfig-1002-20260917    gcc-11.5.0
arm64                 randconfig-1003-20260917    clang-17
arm64                 randconfig-1003-20260917    gcc-11.5.0
arm64                randconfig-r1306-20260917    clang-18   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260917    gcc-11.5.0
csky                  randconfig-1000-20260917    gcc-9.5.0
csky                  randconfig-1001-20260917    gcc-11.5.0
csky                 randconfig-r1304-20260917    gcc-16.1.0 sparse
csky                 randconfig-r1308-20260917    clang-24   sparse
csky                 randconfig-r1309-20260917    clang-18   sparse
csky                 randconfig-r2105-20260917    gcc-13.4.0
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260917    clang-20
hexagon               randconfig-1000-20260917    clang-24
hexagon               randconfig-1001-20260917    clang-17
hexagon               randconfig-1001-20260917    clang-24
hexagon              randconfig-r1300-20260917    clang-21   sparse
hexagon              randconfig-r1301-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1304-20260917    gcc-8.5.0  sparse
hexagon              randconfig-r1307-20260917    clang-18   sparse
i386                              allmodconfig    clang-22
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386                              allyesconfig    gcc-14
i386        buildonly-randconfig-1000-20260917    gcc-13
i386        buildonly-randconfig-1000-20260918    gcc-14
i386        buildonly-randconfig-1001-20260917    gcc-13
i386        buildonly-randconfig-1001-20260918    gcc-14
i386        buildonly-randconfig-1002-20260917    gcc-13
i386        buildonly-randconfig-1002-20260918    gcc-14
i386        buildonly-randconfig-1003-20260917    gcc-13
i386        buildonly-randconfig-1003-20260918    gcc-14
i386        buildonly-randconfig-1004-20260917    gcc-13
i386        buildonly-randconfig-1004-20260918    gcc-14
i386        buildonly-randconfig-1005-20260917    gcc-13
i386        buildonly-randconfig-1005-20260918    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260917    clang-22
i386                  randconfig-1001-20260917    clang-22
i386                  randconfig-1002-20260917    clang-22
i386                  randconfig-1003-20260917    clang-22
i386                  randconfig-1003-20260917    gcc-14
i386                  randconfig-1004-20260917    clang-22
i386                  randconfig-1005-20260917    clang-22
i386                  randconfig-1006-20260917    clang-22
i386                  randconfig-1007-20260917    clang-22
i386                  randconfig-1007-20260917    gcc-13
i386                  randconfig-1008-20260917    clang-22
i386                  randconfig-1009-20260917    clang-22
i386                  randconfig-1010-20260917    clang-22
i386                  randconfig-1011-20260917    clang-22
i386                  randconfig-1011-20260917    gcc-14
i386                  randconfig-1012-20260917    clang-22
i386                  randconfig-1012-20260917    gcc-12
i386                  randconfig-1013-20260917    clang-22
i386                  randconfig-1300-20260917    gcc-14     sparse
i386                  randconfig-1301-20260917    gcc-14     sparse
i386                  randconfig-1302-20260917    gcc-12     sparse
i386                  randconfig-1302-20260917    gcc-14     sparse
i386                  randconfig-2100-20260917    gcc-14
i386                  randconfig-2101-20260917    gcc-14
i386                  randconfig-2102-20260917    gcc-14
i386                  randconfig-2103-20260917    clang-22
i386                  randconfig-2200-20260917    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260917    clang-24
loongarch             randconfig-1001-20260917    clang-24
loongarch            randconfig-r1307-20260917    clang-24   sparse
loongarch            randconfig-r1309-20260917    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                          amcore_defconfig    gcc-16.1.0
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
m68k                 randconfig-r2102-20260917    gcc-14.3.0
m68k                 randconfig-r2103-20260917    gcc-12.5.0
m68k                           sun3x_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2107-20260917    gcc-12.5.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                          cobalt_defconfig    gcc-16.1.0
mips                  decstation_r4k_defconfig    gcc-16.1.0
mips                            gcw0_defconfig    clang-24
mips                            ip27_defconfig    gcc-16.1.0
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                            mtx1_defconfig    clang-19
mips                         omega2p_defconfig    clang-24
mips                 randconfig-r1309-20260917    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260917    clang-24
nios2                 randconfig-1000-20260917    gcc-11.5.0
nios2                 randconfig-1001-20260917    clang-24
nios2                 randconfig-1001-20260917    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1300-20260917    gcc-8.5.0  sparse
openrisc             randconfig-r1308-20260917    clang-18   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260917    gcc-11.5.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260917    gcc-11.5.0
parisc                randconfig-1001-20260917    gcc-9.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc               randconfig-r1302-20260917    clang-21   sparse
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                        ebony_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                           g5_defconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc                          ps3_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260917    clang-24
powerpc               randconfig-1000-20260917    gcc-11.5.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260917    clang-24
powerpc               randconfig-1001-20260917    gcc-11.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc              randconfig-r2200-20260917    gcc-12.5.0
powerpc                   storcenter_defconfig    gcc-16.1.0
powerpc                      tqm8540_defconfig    gcc-16.1.0
powerpc                         warp_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260917    clang-24
powerpc64             randconfig-1000-20260917    gcc-11.5.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260917    clang-22
powerpc64             randconfig-1001-20260917    gcc-11.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
powerpc64            randconfig-r1305-20260917    clang-21   sparse
powerpc64            randconfig-r1305-20260917    gcc-8.5.0  sparse
powerpc64            randconfig-r1309-20260917    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    clang-24
riscv                 randconfig-1000-20260917    clang-17
riscv                 randconfig-1000-20260917    gcc-16.1.0
riscv                 randconfig-1001-20260917    clang-17
riscv                 randconfig-2000-20260917    clang-24
riscv                 randconfig-2001-20260917    clang-17
riscv                randconfig-r2101-20260917    clang-24
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260917    clang-17
s390                  randconfig-1001-20260917    clang-17
s390                  randconfig-1001-20260917    clang-20
s390                  randconfig-2000-20260917    clang-17
s390                  randconfig-2001-20260917    clang-24
s390                 randconfig-r1301-20260917    gcc-16.1.0 sparse
s390                 randconfig-r2104-20260917    clang-18
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                          ecovec24_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260917    clang-17
sh                    randconfig-1000-20260917    gcc-16.1.0
sh                    randconfig-1001-20260917    clang-17
sh                    randconfig-1001-20260917    gcc-11.5.0
sh                    randconfig-2000-20260917    gcc-14.3.0
sh                    randconfig-2001-20260917    gcc-16.1.0
sh                   randconfig-r2106-20260917    gcc-14.3.0
sh                            se7750_defconfig    clang-24
sh                             shmin_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260917    clang-17
sparc                 randconfig-1000-20260917    gcc-8.5.0
sparc                 randconfig-1001-20260917    clang-17
sparc                 randconfig-1001-20260917    gcc-15.2.0
sparc                 randconfig-2000-20260917    gcc-16.1.0
sparc                 randconfig-2001-20260917    gcc-12.5.0
sparc                randconfig-r1302-20260917    gcc-15.2.0 sparse
sparc                randconfig-r1306-20260917    gcc-13.4.0 sparse
sparc                randconfig-r1307-20260917    gcc-13.4.0 sparse
sparc                randconfig-r2202-20260917    gcc-15.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260917    clang-17
sparc64               randconfig-1000-20260917    clang-24
sparc64               randconfig-1001-20260917    clang-17
sparc64               randconfig-1001-20260917    gcc-8.5.0
sparc64               randconfig-2000-20260917    clang-20
sparc64               randconfig-2001-20260917    clang-20
sparc64              randconfig-r1301-20260917    clang-21   sparse
sparc64              randconfig-r1303-20260917    clang-21   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260917    clang-17
um                    randconfig-1000-20260917    gcc-14
um                    randconfig-1001-20260917    clang-17
um                    randconfig-2000-20260917    clang-20
um                    randconfig-2001-20260917    clang-17
um                   randconfig-r1307-20260917    clang-17   sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260917    gcc-13
x86_64      buildonly-randconfig-1000-20260917    gcc-14
x86_64      buildonly-randconfig-1001-20260917    gcc-14
x86_64      buildonly-randconfig-1002-20260917    gcc-14
x86_64      buildonly-randconfig-1003-20260917    gcc-14
x86_64      buildonly-randconfig-1004-20260917    gcc-14
x86_64      buildonly-randconfig-1005-20260917    clang-22
x86_64      buildonly-randconfig-1005-20260917    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260917    clang-22
x86_64                randconfig-1000-20260917    gcc-14
x86_64                randconfig-1001-20260917    clang-22
x86_64                randconfig-1002-20260917    clang-22
x86_64                randconfig-1002-20260917    gcc-14
x86_64                randconfig-1003-20260917    clang-22
x86_64                randconfig-1004-20260917    clang-22
x86_64                randconfig-1004-20260917    gcc-14
x86_64                randconfig-1005-20260917    clang-22
x86_64                randconfig-1005-20260917    gcc-14
x86_64                randconfig-1006-20260917    clang-22
x86_64                randconfig-1006-20260917    gcc-14
x86_64                randconfig-1007-20260917    clang-22
x86_64                randconfig-1007-20260917    gcc-14
x86_64                randconfig-1008-20260917    clang-22
x86_64                randconfig-1008-20260917    gcc-14
x86_64                randconfig-1009-20260917    clang-22
x86_64                randconfig-1010-20260917    clang-22
x86_64                randconfig-1011-20260917    clang-22
x86_64                randconfig-1011-20260917    gcc-14
x86_64                randconfig-1012-20260917    clang-22
x86_64                randconfig-1012-20260917    gcc-14
x86_64                randconfig-1013-20260917    clang-22
x86_64                randconfig-1013-20260917    gcc-14
x86_64                randconfig-1014-20260917    clang-22
x86_64                randconfig-1015-20260917    clang-22
x86_64                randconfig-1016-20260917    clang-22
x86_64                randconfig-1017-20260917    clang-22
x86_64                randconfig-1300-20260917    clang-22   sparse
x86_64                randconfig-1300-20260917    gcc-14     sparse
x86_64                randconfig-1301-20260917    gcc-14     sparse
x86_64                randconfig-1302-20260917    gcc-14     sparse
x86_64                randconfig-2100-20260917    clang-22
x86_64                randconfig-2101-20260917    gcc-14
x86_64                randconfig-2102-20260917    gcc-14
x86_64                randconfig-2103-20260917    gcc-13
x86_64                randconfig-2200-20260917    gcc-14
x86_64               randconfig-r1308-20260917    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.1.0
xtensa                   cadence_csp_defconfig    gcc-16.1.0
xtensa                        common_defconfig    gcc-16.1.0
xtensa                           iss_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260917    clang-17
xtensa                randconfig-1000-20260917    gcc-8.5.0
xtensa                randconfig-1001-20260917    clang-17
xtensa                randconfig-1001-20260917    gcc-13.4.0
xtensa                randconfig-2000-20260917    gcc-8.5.0
xtensa                randconfig-2001-20260917    gcc-10.5.0
xtensa               randconfig-r1303-20260917    gcc-10.5.0 sparse
xtensa               randconfig-r2100-20260917    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
