Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1830DEB7
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459774; cv=none; b=TbejK78LzBZImBkgrSjJWBYx6oSXqAY/QkvSDs0zhvLL3iOqGIk5h95C2NyMeReNM8pnNzcGmpkON8+chq6nGJOv8pJZRWGaZ/vl9tOexKkLxj3d4n1FqtBmUuuoYB6riCZ0vM62JeEiOD60KCE8xv8eyGcglyAgJR4pHrZRinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459774; c=relaxed/simple;
	bh=peMzvVQEJNwCtOHvpuBpSDwDl0zroyHzuKmJk3Ber14=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qYlKLzQZfm2Kow9xDKqMN6tFUp+8biqw9GE7YxfcnIqVzkQPt5ChHpVRIN3GwiS4cAOnhtv2OY2qQ6i7CCme191/4WqjQAFZEtjk3UBhfBP03uXZHURC8gvhpHzIxVDmFYj+QwqZkB5l/ePvmgpPW+wBs6MWt1Lc+1TGKkZptuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch9wfU9C; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch9wfU9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763459773; x=1794995773;
  h=date:from:to:cc:subject:message-id;
  bh=peMzvVQEJNwCtOHvpuBpSDwDl0zroyHzuKmJk3Ber14=;
  b=ch9wfU9COdHSHu8ce+jCWPgc+z0AfA/VTxqLvPTfIo4pFOtaGsqe7zjt
   Hhrm7jj6dxsWJziO0VuKw1qEjPCUBMfTKU4bzWSDplEY9g8+IDYsnGLPa
   iMt+g5DbCzmxcbFmZWOO0AZgb21Xy57fgOpBXjTZ265BUDK9daTgESfEX
   pvvdbR60CeHInqjoOClgQOYnq3PnOOhkzrrSxT8dUx0Fozp5+hWORgdMC
   ReGiAklSS7tIqFHD/9VVwu+D/SoSnLlUTpViW0c19z6HlLqHODE0rmHn9
   xF5NTQ6hSp9T8rrZjGgg5bkQP/VlXs7ylatlfwAg55E2wez3OdI/FU8bv
   w==;
X-CSE-ConnectionGUID: i0x0/xnqQPmDdL1eB1XL9w==
X-CSE-MsgGUID: XdfWWIM6TOWFxua+IO87TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65181345"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65181345"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 01:56:11 -0800
X-CSE-ConnectionGUID: wyHM0YKbTsG87xdmfjAFbA==
X-CSE-MsgGUID: 55b7lsHfSs2b7iPhOHaWbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195029507"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2025 01:56:10 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLIRT-0001Ze-1v;
	Tue, 18 Nov 2025 09:56:07 +0000
Date: Tue, 18 Nov 2025 17:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 7ec9db66cc552f2f8a6779c16d01a2a01eccedde
Message-ID: <202511181743.RkLCz69C-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 7ec9db66cc552f2f8a6779c16d01a2a01eccedde  Merge branch 'for-6.19/cxl-elc-test' into cxl-for-next

elapsed time: 939m

configs tested: 173
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251118    gcc-14.3.0
arc                   randconfig-002-20251118    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                   randconfig-001-20251118    gcc-8.5.0
arm                   randconfig-002-20251118    gcc-10.5.0
arm                   randconfig-003-20251118    clang-22
arm                   randconfig-004-20251118    clang-22
arm                        spear6xx_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251118    clang-20
arm64                 randconfig-002-20251118    clang-22
arm64                 randconfig-003-20251118    clang-19
arm64                 randconfig-004-20251118    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251118    gcc-10.5.0
csky                  randconfig-002-20251118    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251118    clang-16
hexagon               randconfig-002-20251118    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251118    clang-20
i386                  randconfig-002-20251118    clang-20
i386                  randconfig-003-20251118    gcc-14
i386                  randconfig-004-20251118    gcc-14
i386                  randconfig-005-20251118    clang-20
i386                  randconfig-006-20251118    gcc-14
i386                  randconfig-007-20251118    gcc-14
i386                  randconfig-011-20251118    gcc-14
i386                  randconfig-012-20251118    gcc-12
i386                  randconfig-013-20251118    clang-20
i386                  randconfig-014-20251118    gcc-14
i386                  randconfig-015-20251118    gcc-14
i386                  randconfig-016-20251118    gcc-14
i386                  randconfig-017-20251118    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251118    gcc-15.1.0
loongarch             randconfig-002-20251118    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-22
mips                          eyeq6_defconfig    clang-22
mips                        maltaup_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251118    gcc-11.5.0
nios2                 randconfig-002-20251118    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251118    gcc-14.3.0
parisc                randconfig-002-20251118    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251118    clang-22
powerpc               randconfig-002-20251118    clang-22
powerpc64             randconfig-001-20251118    gcc-13.4.0
powerpc64             randconfig-002-20251118    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251118    gcc-10.5.0
riscv                 randconfig-002-20251118    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-002-20251118    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251118    gcc-11.5.0
sh                    randconfig-002-20251118    gcc-15.1.0
sh                          rsk7269_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251118    gcc-8.5.0
sparc                 randconfig-002-20251118    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251118    clang-22
sparc64               randconfig-002-20251118    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251118    clang-22
um                    randconfig-002-20251118    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251118    clang-20
x86_64      buildonly-randconfig-002-20251118    gcc-14
x86_64      buildonly-randconfig-003-20251118    clang-20
x86_64      buildonly-randconfig-004-20251118    clang-20
x86_64      buildonly-randconfig-005-20251118    clang-20
x86_64      buildonly-randconfig-006-20251118    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251118    clang-20
x86_64                randconfig-002-20251118    gcc-12
x86_64                randconfig-003-20251118    gcc-14
x86_64                randconfig-004-20251118    gcc-14
x86_64                randconfig-005-20251118    clang-20
x86_64                randconfig-006-20251118    clang-20
x86_64                randconfig-011-20251118    clang-20
x86_64                randconfig-012-20251118    clang-20
x86_64                randconfig-013-20251118    gcc-14
x86_64                randconfig-014-20251118    clang-20
x86_64                randconfig-015-20251118    clang-20
x86_64                randconfig-016-20251118    clang-20
x86_64                randconfig-071-20251118    gcc-13
x86_64                randconfig-072-20251118    clang-20
x86_64                randconfig-073-20251118    gcc-14
x86_64                randconfig-074-20251118    gcc-13
x86_64                randconfig-075-20251118    gcc-14
x86_64                randconfig-076-20251118    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251118    gcc-9.5.0
xtensa                randconfig-002-20251118    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
