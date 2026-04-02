Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC44312826
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112433; cv=none; b=UvEVpL6of3/Po/8oVjmLKNxjutZRAidt+3WuCeGEtDA1S2G7DbXVe/Qh/LYbg+0JlL7dDZxvMQweadVauEQj1dvZmzQzRoFwhZhc+Bu1AbRaXaRykldM2WhMURYX4S9hGkEHxJLAkeIuZq6THRuaMuSgEJ4T40Fsp+H6s/CJshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112433; c=relaxed/simple;
	bh=5iHfctViw/PxVqwR5ilSZZQde3JXAmVmKRsV7E9tkh8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HQnIwG15VXui5e5zhpqUWhf+XFE/a5GQGAEq7JV4IqnCptvfvyHn/Nu0lplwfdBuo5yrFILg868OZ7lS4hdV3hnTM+Y3EHxDTIJbHhDmzvdyAnj0MDQTj8VuO4VnCw6OuFZX09HLjyEGQYhxRG9G0zg63pEqEYSN2ogsOKoonFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNugWtma; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNugWtma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112431; x=1806648431;
  h=date:from:to:cc:subject:message-id;
  bh=5iHfctViw/PxVqwR5ilSZZQde3JXAmVmKRsV7E9tkh8=;
  b=VNugWtmapk6XFtPDvb0CiV4wO4BbVmkbNSXQGOslrEZAzgKmvMn6jc7j
   AIjJZNetA72XEIbMKk16C519OPBN2zTt4uYJHk5raveYOoEWsdCiLBpYq
   phsRivwsDFoDJn2qkv8g7888RQ/l6J7Tclk1jBX3fhUcpRRTIw5N1Xhy2
   7+4C3gxIcJojFA/9bnQ06YVCnIG425Ufok6jEnlydkR19wEeBuUwm0jdO
   seU6d2nazFXIAVgs3+gg1Gt8hckTyoBDe2fxB3upTgdbSY3gQK8upD/Y/
   qWzUyOkdMBXtAlBaakRwlLxfTfVIBpta+EGL2Dz9webhPOcejQeU1mEc5
   A==;
X-CSE-ConnectionGUID: rCjdiEeOQJeiiitax58RHQ==
X-CSE-MsgGUID: 1Gthxcc5RBCoJIasE+ZZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76052759"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76052759"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:47:11 -0700
X-CSE-ConnectionGUID: qhr4xtGhRlqQaT+OebmpXA==
X-CSE-MsgGUID: VNG4C/pXTqWapjAbgG5CwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231845214"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Apr 2026 23:47:10 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8BpR-000000000G1-1vgi;
	Thu, 02 Apr 2026 06:47:01 +0000
Date: Thu, 02 Apr 2026 10:08:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.1/dax-hmem] BUILD SUCCESS
 fe5dfc24e003a54afcb9ab38133da4698f8168d4
Message-ID: <202604021014.bqHdFhkr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.1/dax-hmem
branch HEAD: fe5dfc24e003a54afcb9ab38133da4698f8168d4  tools/testing/cxl: Test dax_hmem takeover of CXL regions

elapsed time: 1540m

configs tested: 246
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260401    clang-23
arc                   randconfig-001-20260401    gcc-8.5.0
arc                   randconfig-002-20260401    clang-23
arc                   randconfig-002-20260401    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    clang-23
arm                   randconfig-004-20260401    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    clang-18
arm64                 randconfig-001-20260401    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-8.5.0
arm64                 randconfig-003-20260401    gcc-15.2.0
arm64                 randconfig-003-20260401    gcc-8.5.0
arm64                 randconfig-004-20260401    gcc-11.5.0
arm64                 randconfig-004-20260401    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-13.4.0
csky                  randconfig-001-20260401    gcc-15.2.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260401    clang-23
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-002-20260401    clang-17
hexagon               randconfig-002-20260401    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    clang-20
i386        buildonly-randconfig-002-20260401    gcc-14
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    clang-20
i386        buildonly-randconfig-006-20260401    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    clang-20
i386                  randconfig-002-20260401    gcc-14
i386                  randconfig-003-20260401    clang-20
i386                  randconfig-003-20260401    gcc-14
i386                  randconfig-004-20260401    gcc-12
i386                  randconfig-004-20260401    gcc-14
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    clang-20
i386                  randconfig-016-20260401    gcc-14
i386                  randconfig-017-20260401    clang-20
i386                  randconfig-017-20260401    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    clang-23
loongarch             randconfig-002-20260401    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-001-20260401    gcc-8.5.0
nios2                 randconfig-002-20260401    gcc-15.2.0
nios2                 randconfig-002-20260401    gcc-9.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    clang-18
powerpc               randconfig-002-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260401    gcc-14.3.0
powerpc64             randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260401    gcc-8.5.0
riscv                 randconfig-001-20260401    gcc-9.5.0
riscv                 randconfig-002-20260401    gcc-11.5.0
riscv                 randconfig-002-20260401    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-8.5.0
s390                  randconfig-002-20260401    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260401    gcc-10.5.0
sh                    randconfig-001-20260401    gcc-9.5.0
sh                    randconfig-002-20260401    gcc-15.2.0
sh                    randconfig-002-20260401    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    clang-16
sparc                 randconfig-001-20260401    gcc-8.5.0
sparc                 randconfig-002-20260401    clang-16
sparc                 randconfig-002-20260401    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260401    clang-16
sparc64               randconfig-001-20260401    clang-23
sparc64               randconfig-002-20260401    clang-16
sparc64               randconfig-002-20260401    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    clang-16
um                    randconfig-002-20260401    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-12
x86_64      buildonly-randconfig-001-20260401    gcc-14
x86_64      buildonly-randconfig-002-20260401    gcc-12
x86_64      buildonly-randconfig-002-20260401    gcc-14
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    clang-20
x86_64      buildonly-randconfig-005-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260401    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260401    clang-20
x86_64                randconfig-001-20260401    gcc-14
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    clang-20
x86_64                randconfig-003-20260401    gcc-14
x86_64                randconfig-004-20260401    clang-20
x86_64                randconfig-004-20260401    gcc-14
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    gcc-14
x86_64                randconfig-015-20260401    gcc-14
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    clang-20
x86_64                randconfig-072-20260401    gcc-14
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    clang-20
x86_64                randconfig-075-20260401    gcc-14
x86_64                randconfig-076-20260401    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260401    clang-16
xtensa                randconfig-001-20260401    gcc-9.5.0
xtensa                randconfig-002-20260401    clang-16
xtensa                randconfig-002-20260401    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
