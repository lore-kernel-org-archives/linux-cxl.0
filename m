Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DB270031
	for <linux-cxl@vger.kernel.org>; Thu, 27 Feb 2025 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638788; cv=none; b=fI6Iz/JCmXAikFdZBlY2ZgNsqa+En6OcgXnj+DGUqx89R/g2uAtb2lQnqSJQKU4nt3VCJ770iUChYkK4JkIJqZhJ2fDMq2EQSK70C5ioTnzuSXempHtzDwWFa6G/gZa8rdAui4QXv2ZBVBfBq9dL4nZHTVu1azh+Vq+zCSQEEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638788; c=relaxed/simple;
	bh=VXT8dMNPtvBssB4vyLSc3qSty8RZkiHc8mbTyc7BAw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QsHFmli1sT3uo/ZqVV9BE1EwAfkwqeEBoN3bgvdUqynAc/0NSGQJtRbg1zgSEKDsLfpjbSEHWABtLaW9IbxSu1W0kPFyD+kP3IAv1q2wcDwd02itZUmzNnDyI/U1Fr6Qna5Py0vNI9Q1/9C1+cZYJI2dGy+RfPEP6PL7foa3lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYHmHHzs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYHmHHzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740638786; x=1772174786;
  h=date:from:to:cc:subject:message-id;
  bh=VXT8dMNPtvBssB4vyLSc3qSty8RZkiHc8mbTyc7BAw4=;
  b=MYHmHHzsgxkeaCCiMxGyqNHBZX0kbg+0XKwWRtH0WxqHNvH3iukp6XLm
   uKXW0s5a2+tNvxv/P5xVB5xHWlxoltDVrKd6mY6ZLJf844r50AOpLEoTW
   oBli9lYx17xE24RZ4zfqxURL6J1gT9wkPkj4U4Xr5UMvHSQY5B5s1Iu1d
   54nmm3nRRkwnC/Vja/ef9NxQ3Il5Xx1W+4WpuXC4H0aVWSH6qmd4Xfvrs
   KcYchksiw3tIAOJFZ7DwY76Rn47zTrVtCo1VYsdoofDb3l0TWzEpefMyn
   AOVWIrhIfsZnbBXygaVLEBISlDRh23hr1ccs2G53L0krdFk/UcxnQ+oE+
   A==;
X-CSE-ConnectionGUID: x+1InnrgTd2Ym9kDSL+ISA==
X-CSE-MsgGUID: gEaI4DB3Q0ucS4eniRVs5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="63982533"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="63982533"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:46:26 -0800
X-CSE-ConnectionGUID: l6qpn+AYS3aMmtNkXl7oLw==
X-CSE-MsgGUID: VAHFsTwYTLiPhKV9oMnMHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117577400"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 26 Feb 2025 22:46:24 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnXf3-000Cys-2p;
	Thu, 27 Feb 2025 06:46:21 +0000
Date: Thu, 27 Feb 2025 14:46:00 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.15/features] BUILD SUCCESS
 a8b773f24203ef41162fc035944a82909a35f567
Message-ID: <202502271454.CiQXAYIR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.15/features
branch HEAD: a8b773f24203ef41162fc035944a82909a35f567  cxl: Setup exclusive CXL features that are reserved for the kernel

elapsed time: 836m

configs tested: 142
configs skipped: 3

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
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-21
arm                                 defconfig    clang-21
arm                          exynos_defconfig    clang-21
arm                           h3600_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-21
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-002-20250227    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-006-20250227    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-002-20250227    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
