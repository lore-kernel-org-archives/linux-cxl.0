Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AE26ED3E
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208891; cv=none; b=lcMWy5aBbiLnr5NvlBudeiYO3wguhlxmDcu5lQTIA7YcB3ckHijngmUWOjYApg5fe9AY/6StW91SiJFOyGM8zaQJkA/KxoCmFfbMyirGjVYKvNzdRd8JxKpJgJ7FpDiD1dEZe9TQ/b3E/i5D5HCGPiO55rfldPVyO+TvQXo0TpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208891; c=relaxed/simple;
	bh=JgWx9bo9nzxlElIHHBpv1mGJ9PwlR9bEbGDhRS7GE4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NpD6RGE8kIT/ixtXS/En41TqQdvmeYK9FPiLEKVye++/jbQ+lJhgFPoJmpszQwnMtrZnHQYYhf+s5C7+Bhx6JihvxNv030Koy2AxBu0MVaDObAYlFiBXlHxIm4MYV+zvaMPXrDtoMFByZ7R1S4p1E1IHnBBQYyjmVQUPTHL9gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFMufMZt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFMufMZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786208889; x=1817744889;
  h=date:from:to:cc:subject:message-id;
  bh=JgWx9bo9nzxlElIHHBpv1mGJ9PwlR9bEbGDhRS7GE4o=;
  b=MFMufMZt0YIWe5ZuVnA51MrkYTHrBDrqY6mZhebCKsy13hWdY4RmnciP
   hf6HkDxjyR58PLTxFRWsSbPlRgxo2VAMb/UDItIXwoCF4X6s2mWp3ZvuH
   rmWvAKPMj7KWLngPI5MQWty7EAeq1byPL6VaPQ5SNniox4rUc6adGVApZ
   UnuzS6XRXxaIh2f4S3eB8q+sc8RWRC6V1rlQNdZLXT9UGtve+1CMRAiEr
   JxcDz/o1iCADab6NTG/1lGVBHc83H5mI8mXR0phHJ9m7MXrCM2i9kkTIW
   1TDRYs1dtdiZnQ2ro0xMPMcXb1SW3Aaw/KshnsSZhnJp5HNlFYSBWMz/d
   A==;
X-CSE-ConnectionGUID: p3Yu/c5fQquSdhBNyW9eiQ==
X-CSE-MsgGUID: vLXW1PPASYaKOTI/fnZbgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="90469128"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="90469128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:08:09 -0700
X-CSE-ConnectionGUID: 5RX4b6S4S0a/ye7n46IqGw==
X-CSE-MsgGUID: XtTxSv4ZQzCBIsNYv9bFtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="260045751"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2026 10:08:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wskWh-00000000KUb-40Dp;
	Sat, 08 Aug 2026 17:08:03 +0000
Date: Sun, 09 Aug 2026 01:07:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
Message-ID: <202608090107.DBHcyoOQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07  Merge branch 'for-7.3/cxl-misc' into cxl-for-next

elapsed time: 2812m

configs tested: 199
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-001-20260807    gcc-8.5.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-001-20260807    clang-17
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-002-20260807    gcc-12.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-003-20260807    gcc-10.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm                  randconfig-004-20260807    gcc-16.1.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260807    clang-24
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260807    clang-24
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260807    clang-17
arm64                randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-14.3.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260807    gcc-16.1.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-001-20260807    clang-24
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-002-20260807    clang-18
hexagon              randconfig-002-20260807    clang-24
hexagon              randconfig-002-20260808    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-001-20260807    gcc-14
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-002-20260807    gcc-14
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260807    clang-22
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260807    clang-22
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260807    clang-22
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260807    gcc-13
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-012-20260807    gcc-14
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-014-20260807    gcc-14
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260807    clang-22
i386                 randconfig-017-20260807    gcc-14
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-001-20260807    clang-24
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-002-20260807    clang-18
loongarch            randconfig-002-20260808    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-001-20260807    gcc-8.5.0
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-002-20260807    clang-18
nios2                randconfig-002-20260807    gcc-8.5.0
nios2                randconfig-002-20260808    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260807    gcc-9.5.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-001-20260807    clang-24
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-002-20260807    clang-24
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc64                       alldefconfig    clang-17
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-14.3.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260807    gcc-10.5.0
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260807    gcc-9.5.0
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260807    gcc-15.2.0
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260807    gcc-16.1.0
sh                   randconfig-002-20260808    clang-24
sparc                randconfig-001-20260807    gcc-15.2.0
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-001-20260807    clang-20
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-002-20260807    clang-20
sparc64              randconfig-002-20260808    gcc-8.5.0
um                   randconfig-001-20260807    gcc-14
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-002-20260807    clang-24
um                   randconfig-002-20260808    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-002-20260807    gcc-14
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-003-20260807    gcc-14
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260807    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260807    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260807    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260807    gcc-14
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260807    gcc-14
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260807    gcc-14
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-071-20260807    gcc-13
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-075-20260807    gcc-14
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260807    gcc-8.5.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-002-20260807    gcc-13.4.0
xtensa               randconfig-002-20260808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
