Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E410E4
	for <linux-cxl@vger.kernel.org>; Sun, 16 Mar 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742083420; cv=none; b=gazIRpjs7iY/VwrYC4/V0DqRhYoQJfdiybdIl1UMbh69vBKZCjBKjbuot1BLvxik2BJ6v4eqPuS90qOYk0FhvJTH29sFVk0suTc4SZGfg8qYwz+R/j3rG4w0siyPTFkRSYGKcMDUHyeSdqTN90SLTlmUMsxas+CjhjyEcAdsni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742083420; c=relaxed/simple;
	bh=RcNRzjg9JvghxZ1GpYzrHxMa/Q5Ci94xkNyVwTxkhFc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=km/lwylnsv1USDzSz/7ZrSESdIkTRwKDfrNFXEqf+MFd7O5dhzU3WvH8RFfxKDL8sEQkZs21K44WzFa33BCns8ntInCSUYWqodLV/+EsHn1NZoPUDL9JeqK7WNpHPwGmALxsdNnVcPZrFftQld4Eji6lIGu7vlj2kJ2KnV/A7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LauROgVX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LauROgVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742083419; x=1773619419;
  h=date:from:to:cc:subject:message-id;
  bh=RcNRzjg9JvghxZ1GpYzrHxMa/Q5Ci94xkNyVwTxkhFc=;
  b=LauROgVXuCXtKUgxtVhZCKRkRqbDYhW3Camis8pFctuBD15Azcs49y69
   +SELBLLvUa8p9Fa8Dkt9Zk71okDRxve8y7Fevd9sRWdH8gVOo+bpYAKP2
   69O9YigRL60oU2T0KnFSbYtuQJXkO7QganPsSV9DGp97jp+f/5Nm+TTlO
   SddINrGIwQ7Eo9YoItvOPnh8rpoYfVrb1hXvSYuOoD1yNafNKoZT7usrJ
   GDZPTHLTtqYAiecST//TcdvQl/InpnIA+VO4yKYX+g6cJgJDSBop8EV9e
   gQjpyY9G0iMxZD2d3JBn81WfuFhuYhOnAZcNxkmXReCI1F28yMqA1XPKI
   g==;
X-CSE-ConnectionGUID: xreMPTirTNiroAmNhzec+g==
X-CSE-MsgGUID: IZs5jCtnTTOXankeeyfLyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="54590796"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="54590796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 17:03:38 -0700
X-CSE-ConnectionGUID: nepELujzRSCZnlpTsh+r9g==
X-CSE-MsgGUID: bAKSMwdMSge5cVKnN5OG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="122545109"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 15 Mar 2025 17:03:37 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttbTa-000Bj0-1z;
	Sun, 16 Mar 2025 00:03:34 +0000
Date: Sun, 16 Mar 2025 08:03:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 74d9c59658e4d3b06f163da0c5ed7647656705c1
Message-ID: <202503160813.STziP7pE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 74d9c59658e4d3b06f163da0c5ed7647656705c1  cxl/region: Quiet some dev_warn()s in extended linear cache setup

elapsed time: 1444m

configs tested: 141
configs skipped: 4

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
arc                   randconfig-001-20250315    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                          exynos_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250315    clang-21
arm                   randconfig-003-20250315    clang-21
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250315    clang-16
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250315    clang-21
hexagon               randconfig-002-20250315    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250315    gcc-12
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250315    gcc-11
i386        buildonly-randconfig-006-20250315    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       holly_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250315    clang-21
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250315    clang-18
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250315    clang-18
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250315    clang-19
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250315    gcc-12
um                    randconfig-002-20250315    clang-18
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250315    gcc-12
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    gcc-12
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
