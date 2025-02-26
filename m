Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03A214206
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570994; cv=none; b=nQEHGocQuMT3+rvDQWrZ9Vu4dOTEDm4bQuOdsmtX28kaFdV28o1xdPcYgSOMTp00sJZsbq4ffnCp6BoKalF/VmL53fZ6B5YIRzfzhfmENvb4Mgbh+ZqHQ5UOpfV8gYR90FBgnT1zp6kBIuhp2pv+7OMqCPXB9W1aH+XD0BciTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570994; c=relaxed/simple;
	bh=Brz56oZqMewT+LQ8AAC9e5nWkTkjBHEF5BMz6o5THSk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kkD4s/DzDjvYGdzc922qfbf2ki9n0Lw4wiuRnjfZyj+T8LksPCLv7lVdX49ptoST/NhbgoAuNY2vbEYAz+KYIKd9Zx/GD7V5ks08uDvazS7D2wvfNWzoo6/lEV8+6CWh3Y8qJ3H2I1sj5XpqAwfggFKSWyd4J/vR8r3FxJmNaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbVbakxP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbVbakxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740570993; x=1772106993;
  h=date:from:to:cc:subject:message-id;
  bh=Brz56oZqMewT+LQ8AAC9e5nWkTkjBHEF5BMz6o5THSk=;
  b=LbVbakxPFAmVC6W0FKZFXAS5p937SNQsvHMzJ5ACrbk6w7pqP2SwlnIv
   qQIDdh/RRAQz97ZUwg085R/+kFyTeVyUTOKCe8Rmkdjh78bRI+pyxW1gk
   v6RTwp1QR6Tx4t9Jc6Ytk6JLAs6QrOqzyaWlP6rfbKxCypk4BCaUqkFtt
   OHUWpX8P+3qcGJ3+09Np/c4nYDIEveMtvfwSwUTYF8DrcMUT2txpXFpEg
   sBxKppnvjjs8jmanCYs05u1ESyh48dtFSdKwYPEjZqBAFtHM0hHvmsTo4
   vjzxWIC+VRk4OPyc57ubqSGDhAahMF3+6B/GeukuikKjF8CRf7vjAtT7c
   g==;
X-CSE-ConnectionGUID: cuW0oZPwSHGvxv49u7nGDw==
X-CSE-MsgGUID: qVeZ/L3hQO2Nl39OMerwfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29004432"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="29004432"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 03:56:32 -0800
X-CSE-ConnectionGUID: 2bEqUAfEQ7ON1Y6m4LT4uQ==
X-CSE-MsgGUID: GI2/lM7rReSe9CB49AXheg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121679166"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 03:56:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnG1S-000BdP-1O;
	Wed, 26 Feb 2025 11:56:23 +0000
Date: Wed, 26 Feb 2025 19:56:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 0f5f030697213244d627b9e26276a494472087df
Message-ID: <202502261956.m0ixJzDX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 0f5f030697213244d627b9e26276a494472087df  Merge branch 'for-6.15/features' into cxl-for-next

elapsed time: 1102m

configs tested: 139
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250226    gcc-13.2.0
arc                   randconfig-002-20250226    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                           h3600_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250226    gcc-14.2.0
arm                   randconfig-002-20250226    clang-21
arm                   randconfig-003-20250226    gcc-14.2.0
arm                   randconfig-004-20250226    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250226    gcc-14.2.0
arm64                 randconfig-002-20250226    gcc-14.2.0
arm64                 randconfig-003-20250226    clang-21
arm64                 randconfig-004-20250226    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250226    gcc-14.2.0
csky                  randconfig-002-20250226    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250226    clang-21
hexagon               randconfig-002-20250226    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250226    gcc-12
i386        buildonly-randconfig-002-20250226    gcc-12
i386        buildonly-randconfig-003-20250226    gcc-12
i386        buildonly-randconfig-004-20250226    clang-19
i386        buildonly-randconfig-005-20250226    gcc-12
i386        buildonly-randconfig-006-20250226    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250226    gcc-14.2.0
loongarch             randconfig-002-20250226    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                       bmips_be_defconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                          eyeq5_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250226    gcc-14.2.0
nios2                 randconfig-002-20250226    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250226    gcc-14.2.0
parisc                randconfig-002-20250226    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     mpc5200_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250226    gcc-14.2.0
powerpc               randconfig-002-20250226    clang-18
powerpc               randconfig-003-20250226    clang-21
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250226    clang-18
powerpc64             randconfig-002-20250226    gcc-14.2.0
powerpc64             randconfig-003-20250226    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250226    clang-18
riscv                 randconfig-002-20250226    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250226    gcc-14.2.0
s390                  randconfig-002-20250226    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250226    gcc-14.2.0
sh                    randconfig-002-20250226    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250226    gcc-14.2.0
sparc                 randconfig-002-20250226    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250226    gcc-14.2.0
sparc64               randconfig-002-20250226    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250226    clang-18
um                    randconfig-002-20250226    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250226    clang-19
x86_64      buildonly-randconfig-002-20250226    clang-19
x86_64      buildonly-randconfig-003-20250226    gcc-12
x86_64      buildonly-randconfig-004-20250226    clang-19
x86_64      buildonly-randconfig-005-20250226    gcc-12
x86_64      buildonly-randconfig-006-20250226    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250226    gcc-14.2.0
xtensa                randconfig-002-20250226    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
