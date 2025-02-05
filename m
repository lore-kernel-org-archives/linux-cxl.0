Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396B22B8A6
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749081; cv=none; b=WBwyH4+ww15YgRMArvum3QEI7IONF+mTpsfi+UhDAdu7FpkoTFCybq9qcoBYykJb+eaAJnrMN1d246sBisHy0l+eV9wVjDeTQvibwqJc3tGILlUjWX76jMyrustr2YxfIk0AHRMZoJ0r+bkvzXGO5xBhinAYVVVrOUptyHB01nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749081; c=relaxed/simple;
	bh=ayWt6PBcaePcV7c6zLhMAsviipHtpLFGPwWgKGA4Fw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A5oR1KVJINIUHabeIX3XLo7KZ5c8k75drUA0D9/6eYOR4oYen9a5LBRzNgLnUj/Ohn79/S4qD5t4CvqDGvGqLPfF3fk31kyBF4KsnHmYBnRVgWx6Knu9VCiJlr606NamaGEr71NAD/kZnAtdOTP32qZFIKx7iFnohr0fMpklttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na2sFIVy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na2sFIVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738749079; x=1770285079;
  h=date:from:to:cc:subject:message-id;
  bh=ayWt6PBcaePcV7c6zLhMAsviipHtpLFGPwWgKGA4Fw4=;
  b=na2sFIVygtPH5toTAnmpjErZfQuQQlFy3MmLay6VIKKid04wLIwE1TjA
   ArRDVsTBboEOZ7gkry1vmSKbudNvQewduKfbUXHr0dL3bTcmuw3utdOk0
   bnG6Ocyl7PJlxvvv+CwHe+M6pbubcze/X4aRMPNg7mEqdMOUiOLqzPiQB
   SGUdF4q5TKmhkhoCjCKKC6ZvO6GH3GJA7U3tYfOAbgAtk5IFL4m4wnGum
   1ecRV+LFuAStLi8wSOe3e4X/QhM/x/uVIUex/5ywvNJxRVeU97ksCgKIz
   MY4IO01uRedi+kBuT+Dhmv/YR4+fd7kZviK0Rlbrsw6TzE7CKbz5RTj+s
   g==;
X-CSE-ConnectionGUID: EYySo1gsRhSJU/UQEE3MoQ==
X-CSE-MsgGUID: UkIX4L4sQ2CQqnWM/FCkAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38539565"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="38539565"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:51:18 -0800
X-CSE-ConnectionGUID: LCM0cObWT4+UK0LT3FdT/w==
X-CSE-MsgGUID: RsSBAs8XSd6u7KGCMhJLgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115904397"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 01:51:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfc3u-000tiH-08;
	Wed, 05 Feb 2025 09:51:14 +0000
Date: Wed, 05 Feb 2025 17:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46
Message-ID: <202502051745.pzvS0wRt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46  Merge branch 'for-6.15/dpa-partition-cleanup' into cxl-for-next

elapsed time: 722m

configs tested: 137
configs skipped: 7

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
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250205    gcc-13.2.0
arc                   randconfig-002-20250205    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20250205    gcc-14.2.0
arm                   randconfig-002-20250205    gcc-14.2.0
arm                   randconfig-003-20250205    clang-16
arm                   randconfig-004-20250205    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250205    gcc-14.2.0
arm64                 randconfig-002-20250205    gcc-14.2.0
arm64                 randconfig-003-20250205    gcc-14.2.0
arm64                 randconfig-004-20250205    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250205    gcc-14.2.0
csky                  randconfig-002-20250205    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250205    clang-17
hexagon               randconfig-002-20250205    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250205    gcc-12
i386        buildonly-randconfig-002-20250205    gcc-12
i386        buildonly-randconfig-003-20250205    gcc-12
i386        buildonly-randconfig-004-20250205    gcc-11
i386        buildonly-randconfig-005-20250205    clang-19
i386        buildonly-randconfig-006-20250205    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250205    gcc-14.2.0
loongarch             randconfig-002-20250205    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250205    gcc-14.2.0
nios2                 randconfig-002-20250205    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250205    gcc-14.2.0
parisc                randconfig-002-20250205    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250205    clang-16
powerpc               randconfig-002-20250205    gcc-14.2.0
powerpc               randconfig-003-20250205    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-15
powerpc64             randconfig-001-20250205    clang-18
powerpc64             randconfig-002-20250205    gcc-14.2.0
powerpc64             randconfig-003-20250205    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250205    gcc-14.2.0
riscv                 randconfig-002-20250205    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250205    clang-17
s390                  randconfig-002-20250205    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250205    gcc-14.2.0
sh                    randconfig-002-20250205    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250205    gcc-14.2.0
sparc                 randconfig-002-20250205    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250205    gcc-14.2.0
sparc64               randconfig-002-20250205    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250205    gcc-11
um                    randconfig-002-20250205    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250205    clang-19
x86_64      buildonly-randconfig-002-20250205    clang-19
x86_64      buildonly-randconfig-003-20250205    clang-19
x86_64      buildonly-randconfig-004-20250205    gcc-12
x86_64      buildonly-randconfig-005-20250205    clang-19
x86_64      buildonly-randconfig-006-20250205    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250205    gcc-14.2.0
xtensa                randconfig-002-20250205    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
