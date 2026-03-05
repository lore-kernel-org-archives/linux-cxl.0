Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71914EC73
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772690948; cv=none; b=fSFpr+xWCgsdgSs0VUm9noSiAP0GIAxtayI0zwZ0PRaE6InERfFZQ53SHv9u8rC/j6QGBwY0Hie04ZjsfMu14KEAjXbqVVrcp32EDNQLuXR1sph/p+FatjiY+Tj0Ndicp082CpiTrYkU96DAU2d17S/VOQd6Y89O+ABpi4JzQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772690948; c=relaxed/simple;
	bh=yDnxGs1iKyl9DO4w9NQJalsFkEHbKGhuCKMGj+xb/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P9A+gT09tXFiaDgCbk/Ou5LlSayz9m6D3I6fSsLVGOD7N3ZDofG9o9JtRz8sAr/1egdcfBF5BOE0mhZWcTjyDYarFU7WmhXK3HRLgkC6fwv7c8ZT4dwyk3xcL8uKVmvjfW7wE/z2RfgdkGf5JCBa4Aq1GX4u2T4Z7HNb16l/4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3uTo5zo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3uTo5zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772690945; x=1804226945;
  h=date:from:to:cc:subject:message-id;
  bh=yDnxGs1iKyl9DO4w9NQJalsFkEHbKGhuCKMGj+xb/Qg=;
  b=Z3uTo5zoQ+dogZVPQ7+NTar91GXzzWhhpucirQvAwDgpwDu1VnZwEBTV
   Qo/dB71WDU82O1VLgDjFCK5dwJxS22PONofNTzmugf+a+OCU3zZ4kQUSY
   RENPw9evZFCnudyyzQW4MFLr7yqZxcNWzKELvIy4yef9+IyAZ+f0cVCHZ
   O8dajvQuS77jvBMTQUIJfd2jc3XAFNlQ/dePR7IYUqTeAuLeLwoXFpe5Z
   hLBRxlviZEvEi7DqtUwsLxp4jTWbzII51wfe41JvDHBfqu/h3hZZR7509
   /ny/eyP23FsTiBIQbsxVf88rbIbUzTmzFCrZdxcOP8+Gw7imOuUYZtarM
   A==;
X-CSE-ConnectionGUID: tMZXFxNYTEKfRJPg6IY5vw==
X-CSE-MsgGUID: sPRxRGunSeCBeK4BaaeozQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77613403"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77613403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 22:09:04 -0800
X-CSE-ConnectionGUID: g3ZjQsBHRP6mCPOm0nYj/w==
X-CSE-MsgGUID: EIdOqm/7Q1C/f39LhBUVqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="241587877"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2026 22:09:02 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy1tM-0000000002r-1Q5v;
	Thu, 05 Mar 2026 06:09:00 +0000
Date: Thu, 05 Mar 2026 14:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 77b310bb7b5ff8c017524df83292e0242ba89791
Message-ID: <202603051425.ZnrBDteF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 77b310bb7b5ff8c017524df83292e0242ba89791  cxl/region: Fix leakage in __construct_region()

elapsed time: 733m

configs tested: 180
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260305    gcc-8.5.0
arc                   randconfig-002-20260305    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260305    clang-23
arm                   randconfig-002-20260305    clang-19
arm                   randconfig-003-20260305    clang-23
arm                   randconfig-004-20260305    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260305    gcc-9.5.0
arm64                 randconfig-002-20260305    gcc-11.5.0
arm64                 randconfig-003-20260305    clang-16
arm64                 randconfig-004-20260305    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260305    gcc-13.4.0
csky                  randconfig-002-20260305    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260305    clang-23
hexagon               randconfig-002-20260305    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260305    clang-20
i386        buildonly-randconfig-002-20260305    gcc-14
i386        buildonly-randconfig-003-20260305    gcc-14
i386        buildonly-randconfig-004-20260305    gcc-14
i386        buildonly-randconfig-005-20260305    gcc-14
i386        buildonly-randconfig-006-20260305    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260305    clang-20
i386                  randconfig-002-20260305    gcc-14
i386                  randconfig-003-20260305    gcc-14
i386                  randconfig-004-20260305    clang-20
i386                  randconfig-005-20260305    gcc-14
i386                  randconfig-006-20260305    gcc-14
i386                  randconfig-007-20260305    clang-20
i386                  randconfig-011-20260305    clang-20
i386                  randconfig-012-20260305    clang-20
i386                  randconfig-013-20260305    clang-20
i386                  randconfig-014-20260305    clang-20
i386                  randconfig-015-20260305    clang-20
i386                  randconfig-016-20260305    clang-20
i386                  randconfig-017-20260305    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260305    gcc-15.2.0
loongarch             randconfig-002-20260305    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260305    gcc-8.5.0
nios2                 randconfig-002-20260305    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260305    gcc-9.5.0
parisc                randconfig-002-20260305    gcc-8.5.0
parisc                randconfig-002-20260305    gcc-9.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260305    gcc-12.5.0
powerpc               randconfig-001-20260305    gcc-9.5.0
powerpc               randconfig-002-20260305    gcc-8.5.0
powerpc               randconfig-002-20260305    gcc-9.5.0
powerpc64             randconfig-001-20260305    clang-17
powerpc64             randconfig-001-20260305    gcc-9.5.0
powerpc64             randconfig-002-20260305    gcc-10.5.0
powerpc64             randconfig-002-20260305    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260305    gcc-15.2.0
riscv                 randconfig-002-20260305    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-002-20260305    clang-18
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260305    gcc-15.2.0
sh                    randconfig-002-20260305    gcc-12.5.0
sh                           se7751_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260305    gcc-8.5.0
sparc                 randconfig-002-20260305    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260305    clang-23
sparc64               randconfig-002-20260305    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260305    clang-23
um                    randconfig-002-20260305    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260305    gcc-14
x86_64      buildonly-randconfig-002-20260305    clang-20
x86_64      buildonly-randconfig-003-20260305    clang-20
x86_64      buildonly-randconfig-004-20260305    clang-20
x86_64      buildonly-randconfig-005-20260305    clang-20
x86_64      buildonly-randconfig-006-20260305    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260305    clang-20
x86_64                randconfig-002-20260305    clang-20
x86_64                randconfig-003-20260305    gcc-13
x86_64                randconfig-004-20260305    clang-20
x86_64                randconfig-005-20260305    clang-20
x86_64                randconfig-006-20260305    gcc-14
x86_64                randconfig-011-20260305    clang-20
x86_64                randconfig-012-20260305    gcc-14
x86_64                randconfig-013-20260305    clang-20
x86_64                randconfig-014-20260305    clang-20
x86_64                randconfig-015-20260305    clang-20
x86_64                randconfig-016-20260305    clang-20
x86_64                randconfig-071-20260305    clang-20
x86_64                randconfig-072-20260305    gcc-14
x86_64                randconfig-073-20260305    gcc-14
x86_64                randconfig-074-20260305    gcc-14
x86_64                randconfig-075-20260305    gcc-14
x86_64                randconfig-076-20260305    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260305    gcc-8.5.0
xtensa                randconfig-002-20260305    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
