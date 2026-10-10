Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F53B8407
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673374; cv=none; b=ZUjZ0cBrLO220BP8bxg3LxP6nu6rDJgfrstU+eKuT9nsnMDa9yYKRyfK9/rrV9Pbx3RVuupnXbGznft9kKAcQFxaxBTACPTTIUjbPJ7zVcljHjg4Pi8lR0bHZcCB7IKh+fI4+lXipiWNhB1iWMMRo0CDfzZZhCohaDekYY7reOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673374; c=relaxed/simple;
	bh=4ESL3rLhEcQy5VujlEf86v+cLkQz7hiX/sZwx3AbRLI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BhbTR7/lIL1HCIlAGuvc3LJ+ugEK7Cd7pvdluQEvUf9Kan2WJfeZhIeEqkobfdEbYOK1nKsUbRpBatAA6LHxZJUX0JBMc4aOGfygc8C6XayWXYKM2GvmhjoAmEYxaJSK1p0gbk3Q+2DIF1svIiAroK+9245CycNKU98UgESUME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZJ1ITBd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZJ1ITBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791673363; x=1823209363;
  h=date:from:to:cc:subject:message-id;
  bh=4ESL3rLhEcQy5VujlEf86v+cLkQz7hiX/sZwx3AbRLI=;
  b=XZJ1ITBdo2DpmpKohwPpzkAqgAnJWdiRfV9S47QKLEd9fDAkwayPhY97
   zMRaaNWiDlJdBE/qCTwQGhemag8yj6wUQjAc4SxQ2RX+zZu1tBN3SbuCz
   mDAXbw1iV0VTleDShfRqhvxpSIswxBweckMhisdkR9rDUU5PkKrA4Plaq
   r45BCwGkSEcOR1et6oqcSszy9qGTMSgVcsgU3Hc/vPLzGkfqG91jB2JVV
   jkk2+M6yhnp1Yvz+ZarfFGWGENsYJmdo8yJL+dO0gHTZGU+EbTB9qX/ed
   TtobSTgFUYHktJdh/vxuZftrq2n44GszyRelhn4BEaspLGDa4GNODQg5Y
   w==;
X-CSE-ConnectionGUID: yI7Ulg1mQkCDFbZGv7LfUw==
X-CSE-MsgGUID: hgxyaqWvSLGflHZ63MlBGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="437369"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="437369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 16:02:42 -0700
X-CSE-ConnectionGUID: x4ppUhkTR8e9qA7sa6pqMg==
X-CSE-MsgGUID: 0s8Rg1eNQV+XhH4YdKCKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="1036461"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Oct 2026 16:02:40 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFg5N-00000000A8O-34oN;
	Sat, 10 Oct 2026 23:02:37 +0000
Date: Sun, 11 Oct 2026 07:02:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 91320b84095afcaf9e4f676eef5b05346d60eb79
Message-ID: <202610110701.eRgMcWi9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 91320b84095afcaf9e4f676eef5b05346d60eb79  Merge branch 'for-7.4/cxl-fixes' into cxl-for-next

elapsed time: 1100m

configs tested: 421
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2102-20261010    gcc-12.5.0 cocci
alpha                randconfig-r2107-20261010    gcc-8.5.0  cocci
alpha                randconfig-r2305-20261010    gcc-8.5.0  sparse
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261010    gcc-15.2.0
arc                   randconfig-1000-20261010    gcc-8.5.0
arc                   randconfig-1001-20261010    gcc-13.4.0
arc                   randconfig-1001-20261010    gcc-8.5.0
arc                  randconfig-r2104-20261010    gcc-8.5.0  cocci
arc                  randconfig-r2107-20261010    gcc-8.5.0  cocci
arc                  randconfig-r2200-20261010    gcc-14.3.0 smatch
arc                  randconfig-r2300-20261010    gcc-8.5.0  sparse
arc                  randconfig-r2305-20261010    clang-17   sparse
arc                  randconfig-r2307-20261010    clang-22   sparse
arc                  randconfig-r2308-20261010    gcc-13.4.0 sparse
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                        aspeed_g5_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261010    clang-24
arm                   randconfig-1000-20261010    gcc-8.5.0
arm                   randconfig-1001-20261010    gcc-15.2.0
arm                   randconfig-1001-20261010    gcc-8.5.0
arm                   randconfig-1002-20261010    gcc-8.5.0
arm                   randconfig-1003-20261010    gcc-8.5.0
arm                  randconfig-r2105-20261010    gcc-8.5.0  cocci
arm                  randconfig-r2303-20261010    gcc-8.5.0  sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261010    gcc-10.5.0
arm64                 randconfig-1001-20261010    gcc-10.5.0
arm64                 randconfig-1002-20261010    gcc-10.5.0
arm64                 randconfig-1003-20261010    gcc-10.5.0
arm64                 randconfig-2000-20261010    gcc-16.1.0
arm64                 randconfig-2001-20261010    gcc-16.1.0
arm64                randconfig-r2101-20261010    clang-22   cocci
arm64                randconfig-r2101-20261010    gcc-10.5.0 cocci
arm64                randconfig-r2302-20261010    gcc-13.4.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261010    gcc-10.5.0
csky                  randconfig-1001-20261010    gcc-10.5.0
csky                  randconfig-2000-20261010    gcc-16.1.0
csky                  randconfig-2001-20261010    gcc-16.1.0
csky                 randconfig-r2103-20261010    gcc-16.1.0 cocci
csky                 randconfig-r2301-20261010    gcc-13.4.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261010    clang-17
hexagon               randconfig-1000-20261010    clang-24
hexagon               randconfig-1001-20261010    clang-17
hexagon               randconfig-2000-20261010    gcc-16.1.0
hexagon               randconfig-2001-20261010    gcc-16.1.0
hexagon              randconfig-r2101-20261010    clang-24   cocci
hexagon              randconfig-r2106-20261010    gcc-8.5.0  cocci
hexagon              randconfig-r2200-20261010    clang-24   smatch
hexagon              randconfig-r2302-20261010    clang-17   sparse
hexagon              randconfig-r2306-20261010    gcc-16.1.0 sparse
i386                              allmodconfig    clang-22
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261010    gcc-13
i386        buildonly-randconfig-1000-20261010    gcc-14
i386        buildonly-randconfig-1001-20261010    clang-22
i386        buildonly-randconfig-1001-20261010    gcc-14
i386        buildonly-randconfig-1002-20261010    gcc-14
i386        buildonly-randconfig-1003-20261010    gcc-14
i386        buildonly-randconfig-1004-20261010    clang-22
i386        buildonly-randconfig-1004-20261010    gcc-14
i386        buildonly-randconfig-1005-20261010    clang-22
i386        buildonly-randconfig-1005-20261010    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261010    clang-22
i386                  randconfig-1000-20261010    gcc-14
i386                  randconfig-1001-20261010    clang-22
i386                  randconfig-1002-20261010    clang-22
i386                  randconfig-1003-20261010    clang-22
i386                  randconfig-1004-20261010    clang-22
i386                  randconfig-1004-20261010    gcc-14
i386                  randconfig-1005-20261010    clang-22
i386                  randconfig-1005-20261010    gcc-13
i386                  randconfig-1006-20261010    clang-22
i386                  randconfig-1007-20261010    gcc-14
i386                  randconfig-1008-20261010    gcc-14
i386                  randconfig-1009-20261010    gcc-14
i386                  randconfig-1010-20261010    gcc-14
i386                  randconfig-1011-20261010    clang-22
i386                  randconfig-1011-20261010    gcc-14
i386                  randconfig-1012-20261010    clang-22
i386                  randconfig-1012-20261010    gcc-14
i386                  randconfig-1013-20261010    clang-22
i386                  randconfig-1013-20261010    gcc-14
i386                  randconfig-2100-20261010    clang-22   cocci
i386                  randconfig-2101-20261010    clang-22   cocci
i386                  randconfig-2102-20261010    clang-22   cocci
i386                  randconfig-2103-20261010    clang-22   cocci
i386                  randconfig-2200-20261010    gcc-12     smatch
i386                  randconfig-2300-20261010    gcc-14     sparse
i386                  randconfig-2301-20261010    gcc-14     sparse
i386                  randconfig-2302-20261010    clang-22   sparse
i386                  randconfig-2302-20261010    gcc-14     sparse
i386                 randconfig-r2103-20261010    gcc-12.5.0 cocci
i386                 randconfig-r2305-20261010    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261010    gcc-16.1.0 sparse
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261010    clang-17
loongarch             randconfig-1000-20261010    clang-24
loongarch             randconfig-1001-20261010    clang-17
loongarch             randconfig-1001-20261010    clang-18
loongarch             randconfig-2000-20261010    gcc-8.5.0
loongarch             randconfig-2001-20261010    gcc-8.5.0
loongarch            randconfig-r2105-20261010    gcc-8.5.0  cocci
loongarch            randconfig-r2300-20261010    clang-17   sparse
loongarch            randconfig-r2304-20261010    gcc-8.5.0  sparse
loongarch            randconfig-r2309-20261010    gcc-16.1.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                          amcore_defconfig    gcc-16.1.0
m68k                                 defconfig    gcc-16.1.0
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                        m5282evb_defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    gcc-16.1.0
m68k                         m5407c3_defconfig    gcc-16.1.0
m68k                 randconfig-r2103-20261010    gcc-14.3.0 cocci
m68k                 randconfig-r2201-20261010    gcc-8.5.0  smatch
m68k                 randconfig-r2303-20261010    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2103-20261010    gcc-10.5.0 cocci
microblaze           randconfig-r2105-20261010    gcc-8.5.0  cocci
microblaze           randconfig-r2304-20261010    clang-17   sparse
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
mips                            ip22_defconfig    gcc-16.1.0
mips                       loongson1_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20261010    gcc-10.5.0 cocci
mips                 randconfig-r2105-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2106-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2107-20261010    gcc-8.5.0  cocci
mips                 randconfig-r2200-20261010    gcc-14.3.0 smatch
mips                 randconfig-r2202-20261010    clang-18   smatch
mips                 randconfig-r2301-20261010    gcc-8.5.0  sparse
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20261010    clang-17
nios2                 randconfig-1000-20261010    gcc-11.5.0
nios2                 randconfig-1001-20261010    clang-17
nios2                 randconfig-1001-20261010    gcc-11.5.0
nios2                 randconfig-2000-20261010    gcc-8.5.0
nios2                 randconfig-2001-20261010    gcc-8.5.0
nios2                randconfig-r2106-20261010    gcc-8.5.0  cocci
nios2                randconfig-r2306-20261010    clang-22   sparse
nios2                randconfig-r2306-20261010    gcc-13.4.0 sparse
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261010    clang-22   cocci
openrisc             randconfig-r2104-20261010    gcc-8.5.0  cocci
openrisc             randconfig-r2201-20261010    gcc-16.1.0 smatch
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261010    gcc-9.5.0
parisc                randconfig-1001-20261010    gcc-8.5.0
parisc                randconfig-2000-20261010    gcc-8.5.0
parisc                randconfig-2001-20261010    gcc-8.5.0
parisc               randconfig-r2201-20261010    gcc-10.5.0 smatch
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                        ebony_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261010    gcc-8.5.0
powerpc               randconfig-1001-20261010    clang-24
powerpc               randconfig-2000-20261010    gcc-14
powerpc               randconfig-2001-20261010    gcc-14
powerpc              randconfig-r2100-20261010    clang-22   cocci
powerpc              randconfig-r2107-20261010    clang-20   cocci
powerpc              randconfig-r2202-20261010    clang-17   smatch
powerpc              randconfig-r2302-20261010    gcc-8.5.0  sparse
powerpc                      sequoia_defconfig    clang-24
powerpc                       tqm8xx_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261010    clang-24
powerpc64             randconfig-1001-20261010    clang-24
powerpc64             randconfig-2000-20261010    gcc-14
powerpc64             randconfig-2001-20261010    gcc-14
powerpc64            randconfig-r2104-20261010    clang-20   cocci
powerpc64            randconfig-r2301-20261010    clang-17   sparse
powerpc64            randconfig-r2303-20261010    gcc-8.5.0  sparse
powerpc64            randconfig-r2307-20261010    gcc-13.4.0 sparse
powerpc64            randconfig-r2309-20261010    clang-22   sparse
powerpc64            randconfig-r2309-20261010    gcc-14     sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261010    clang-19
riscv                 randconfig-1001-20261010    clang-19
riscv                 randconfig-1001-20261010    clang-24
riscv                 randconfig-2000-20261010    gcc-16.1.0
riscv                 randconfig-2000-20261010    gcc-9.5.0
riscv                 randconfig-2001-20261010    clang-24
riscv                 randconfig-2001-20261010    gcc-16.1.0
riscv                randconfig-r2304-20261010    gcc-8.5.0  sparse
riscv                randconfig-r2304-20261010    gcc-9.5.0  sparse
riscv                randconfig-r2306-20261010    clang-24   sparse
s390                              alldefconfig    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261010    clang-19
s390                  randconfig-1000-20261010    clang-24
s390                  randconfig-1001-20261010    clang-19
s390                  randconfig-1001-20261010    clang-24
s390                  randconfig-2000-20261010    clang-17
s390                  randconfig-2000-20261010    gcc-16.1.0
s390                  randconfig-2001-20261010    gcc-15.2.0
s390                  randconfig-2001-20261010    gcc-16.1.0
s390                 randconfig-r2100-20261010    gcc-16.1.0 cocci
s390                 randconfig-r2102-20261010    gcc-10.5.0 cocci
s390                 randconfig-r2300-20261010    gcc-8.5.0  sparse
s390                 randconfig-r2307-20261010    gcc-16.1.0 sparse
s390                        zfcpdump_defconfig    clang-22
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                    randconfig-1000-20261010    clang-19
sh                    randconfig-1000-20261010    gcc-11.5.0
sh                    randconfig-1001-20261010    clang-19
sh                    randconfig-1001-20261010    gcc-13.4.0
sh                    randconfig-2000-20261010    gcc-16.1.0
sh                    randconfig-2001-20261010    gcc-16.1.0
sh                   randconfig-r2101-20261010    gcc-12.5.0 cocci
sh                   randconfig-r2200-20261010    gcc-9.5.0  smatch
sh                   randconfig-r2201-20261010    gcc-15.2.0 smatch
sh                   randconfig-r2202-20261010    gcc-9.5.0  smatch
sh                   randconfig-r2303-20261010    clang-17   sparse
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-16.1.0
sparc                 randconfig-1000-20261010    gcc-8.5.0
sparc                 randconfig-1001-20261010    gcc-16.1.0
sparc                 randconfig-1001-20261010    gcc-8.5.0
sparc                 randconfig-2000-20261010    gcc-16.1.0
sparc                 randconfig-2000-20261010    gcc-8.5.0
sparc                 randconfig-2001-20261010    gcc-16.1.0
sparc                randconfig-r2100-20261010    gcc-12.5.0 cocci
sparc                randconfig-r2101-20261010    gcc-16.1.0 cocci
sparc                randconfig-r2106-20261010    clang-20   cocci
sparc                randconfig-r2200-20261010    gcc-16.1.0 smatch
sparc                randconfig-r2305-20261010    gcc-16.1.0 sparse
sparc                randconfig-r2308-20261010    gcc-14.3.0 sparse
sparc                randconfig-r2309-20261010    gcc-16.1.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261010    clang-24
sparc64               randconfig-1000-20261010    gcc-16.1.0
sparc64               randconfig-1001-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261010    gcc-16.1.0
sparc64               randconfig-2000-20261010    gcc-8.5.0
sparc64               randconfig-2001-20261010    clang-21
sparc64               randconfig-2001-20261010    gcc-16.1.0
sparc64              randconfig-r2302-20261010    gcc-8.5.0  sparse
sparc64              randconfig-r2306-20261010    gcc-14     sparse
sparc64              randconfig-r2307-20261010    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261010    gcc-14
um                    randconfig-1000-20261010    gcc-16.1.0
um                    randconfig-1001-20261010    gcc-14
um                    randconfig-1001-20261010    gcc-16.1.0
um                    randconfig-2000-20261010    clang-24
um                    randconfig-2000-20261010    gcc-16.1.0
um                    randconfig-2001-20261010    clang-24
um                    randconfig-2001-20261010    gcc-16.1.0
um                   randconfig-r2100-20261010    gcc-14     cocci
um                   randconfig-r2105-20261010    clang-20   cocci
um                   randconfig-r2309-20261010    gcc-13.4.0 sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261010    clang-22
x86_64      buildonly-randconfig-1000-20261010    gcc-14
x86_64      buildonly-randconfig-1000-20261011    gcc-14
x86_64      buildonly-randconfig-1001-20261010    clang-22
x86_64      buildonly-randconfig-1001-20261010    gcc-13
x86_64      buildonly-randconfig-1001-20261011    gcc-14
x86_64      buildonly-randconfig-1002-20261010    clang-22
x86_64      buildonly-randconfig-1002-20261011    gcc-14
x86_64      buildonly-randconfig-1003-20261010    clang-22
x86_64      buildonly-randconfig-1003-20261011    gcc-14
x86_64      buildonly-randconfig-1004-20261010    clang-22
x86_64      buildonly-randconfig-1004-20261010    gcc-13
x86_64      buildonly-randconfig-1004-20261011    gcc-14
x86_64      buildonly-randconfig-1005-20261010    clang-22
x86_64      buildonly-randconfig-1005-20261011    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261010    gcc-14
x86_64                randconfig-1001-20261010    gcc-14
x86_64                randconfig-1002-20261010    clang-22
x86_64                randconfig-1002-20261010    gcc-14
x86_64                randconfig-1003-20261010    clang-22
x86_64                randconfig-1003-20261010    gcc-14
x86_64                randconfig-1004-20261010    gcc-14
x86_64                randconfig-1005-20261010    gcc-13
x86_64                randconfig-1005-20261010    gcc-14
x86_64                randconfig-1006-20261010    clang-22
x86_64                randconfig-1007-20261010    clang-22
x86_64                randconfig-1008-20261010    clang-22
x86_64                randconfig-1009-20261010    clang-22
x86_64                randconfig-1010-20261010    clang-22
x86_64                randconfig-1011-20261010    clang-22
x86_64                randconfig-1011-20261010    gcc-14
x86_64                randconfig-1012-20261010    clang-22
x86_64                randconfig-1012-20261010    gcc-14
x86_64                randconfig-1013-20261010    clang-22
x86_64                randconfig-1013-20261010    gcc-14
x86_64                randconfig-1014-20261010    clang-22
x86_64                randconfig-1014-20261010    gcc-14
x86_64                randconfig-1015-20261010    clang-22
x86_64                randconfig-1015-20261010    gcc-14
x86_64                randconfig-1016-20261010    clang-22
x86_64                randconfig-1016-20261010    gcc-14
x86_64                randconfig-1017-20261010    clang-22
x86_64                randconfig-2000-20261010    gcc-14
x86_64                randconfig-2001-20261010    gcc-14
x86_64                randconfig-2100-20261010    clang-22   cocci
x86_64                randconfig-2101-20261010    clang-22   cocci
x86_64                randconfig-2102-20261010    clang-22   cocci
x86_64                randconfig-2103-20261010    clang-22   cocci
x86_64                randconfig-2104-20261010    clang-22   cocci
x86_64                randconfig-2105-20261010    clang-22   cocci
x86_64                randconfig-2200-20261010    gcc-14     smatch
x86_64                randconfig-2300-20261010    clang-22   sparse
x86_64                randconfig-2300-20261010    gcc-14     sparse
x86_64                randconfig-2301-20261010    clang-22   sparse
x86_64                randconfig-2301-20261010    gcc-14     sparse
x86_64                randconfig-2302-20261010    clang-22   sparse
x86_64                randconfig-2302-20261010    gcc-14     sparse
x86_64               randconfig-r2103-20261010    clang-22   cocci
x86_64               randconfig-r2104-20261010    gcc-8.5.0  cocci
x86_64               randconfig-r2201-20261010    clang-22   smatch
x86_64               randconfig-r2202-20261010    clang-22   smatch
x86_64               randconfig-r2307-20261010    gcc-14     sparse
x86_64               randconfig-r2308-20261010    clang-22   sparse
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
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20261010    gcc-16.1.0
xtensa                randconfig-1000-20261010    gcc-9.5.0
xtensa                randconfig-1001-20261010    gcc-15.2.0
xtensa                randconfig-1001-20261010    gcc-16.1.0
xtensa                randconfig-2000-20261010    gcc-10.5.0
xtensa                randconfig-2000-20261010    gcc-16.1.0
xtensa                randconfig-2001-20261010    gcc-16.1.0
xtensa               randconfig-r2102-20261010    gcc-15.2.0 cocci
xtensa               randconfig-r2102-20261010    gcc-16.1.0 cocci
xtensa               randconfig-r2104-20261010    gcc-8.5.0  cocci
xtensa               randconfig-r2300-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2301-20261010    gcc-8.5.0  sparse
xtensa               randconfig-r2308-20261010    gcc-14     sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
