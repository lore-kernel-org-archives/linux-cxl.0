Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C626B741
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173682; cv=none; b=A1/Kl6Rm3PAwoqB2qvQiu/4bt+67rF+Xrosv5w5gQQulwTGVDvaabqs+Fj79179hMVzOuohIHL60ksyFyZ1cC1V/K4sJpCL64LMK3fdoiHrJXTZyvCmI+wQABcmOYMRH4Az6GopCorwMqrk7tovIu1jHY1hWwcv/h+5KCGEeTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173682; c=relaxed/simple;
	bh=DWuFia3BdTa396rwpYRO3z0RHOBL6YiFa5V9EN+HyaY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=txIbOxZOZDkbdeFv1+N3/w6xZKhfhRH553pBZ5VI1IucWaQKD2f4a071kTy/m1T7oI/BGpneli46wLttMfGfpj+p9wmKic5FTT4w707j/WnsPLl7am3Az6/HaT39LNXd1xysF3snj934UVOF/8TFhTGHSgdjJxkXXQfGDmo+wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnu2vw70; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnu2vw70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769173679; x=1800709679;
  h=date:from:to:cc:subject:message-id;
  bh=DWuFia3BdTa396rwpYRO3z0RHOBL6YiFa5V9EN+HyaY=;
  b=lnu2vw70DsQ2MsHYCtEDCZEMHFOuKcyt9327PPWLSHNpsR3yzI2yGWoS
   RGL7qaojv6LwEN9MxMrC2kqw3N1T4+t//aQfND/MKJLArWjggTn7V5Muf
   6OOMliL/PewA3tj8bmQ7aQfGElEV/twGddIu5y+XXLi9fjyq/V1kfRaSI
   jVLlj4k3VA2u26YxjTlkwdhCPp3dvoQ1VCHkSJYF//0D/+/MnnJuiPazo
   csdaY3DoNvIMKNL0c0yRK3tVYJ9s5POfkcUiRZwA7mdom1Dmj4FxQcOOV
   mPT8QjH4zNWUTGFZMHo+msAZqZ7FLMQdiBErhSazhY10NzOiIjkMArCFF
   A==;
X-CSE-ConnectionGUID: 08zcO5liR+eVKK60L36Rxw==
X-CSE-MsgGUID: Tjl0g21IRZ6vdGYRKl7HaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70589787"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70589787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 05:07:59 -0800
X-CSE-ConnectionGUID: 8gLy8LPiRX62A8ufcQxyow==
X-CSE-MsgGUID: XI5ZGXygQkikn5kjXNzsmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211147572"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Jan 2026 05:07:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjGtF-00000000TyE-3oAl;
	Fri, 23 Jan 2026 13:07:53 +0000
Date: Fri, 23 Jan 2026 21:07:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 914c743509d56067eeeb2b5e341a44a68ef8377d
Message-ID: <202601232134.0sjQbZo4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 914c743509d56067eeeb2b5e341a44a68ef8377d  Merge branch 'for-7.0/cxl-aer-prep' into cxl-for-next

elapsed time: 760m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260123    gcc-8.5.0
arc                   randconfig-002-20260123    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260123    clang-18
arm                   randconfig-002-20260123    clang-22
arm                   randconfig-003-20260123    gcc-10.5.0
arm                   randconfig-004-20260123    gcc-15.2.0
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-13.4.0
arm64                 randconfig-003-20260123    gcc-10.5.0
arm64                 randconfig-004-20260123    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260123    clang-22
hexagon               randconfig-002-20260123    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-002-20260123    gcc-14
i386        buildonly-randconfig-003-20260123    gcc-14
i386        buildonly-randconfig-004-20260123    gcc-14
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-006-20260123    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260123    clang-20
i386                  randconfig-002-20260123    clang-20
i386                  randconfig-003-20260123    gcc-14
i386                  randconfig-004-20260123    gcc-14
i386                  randconfig-005-20260123    clang-20
i386                  randconfig-006-20260123    gcc-14
i386                  randconfig-007-20260123    gcc-13
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-012-20260123    gcc-14
i386                  randconfig-013-20260123    gcc-14
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-015-20260123    gcc-14
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-017-20260123    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260123    gcc-12.5.0
loongarch             randconfig-002-20260123    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260123    gcc-10.5.0
nios2                 randconfig-002-20260123    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-002-20260123    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260123    clang-22
powerpc               randconfig-002-20260123    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20260123    gcc-8.5.0
powerpc64             randconfig-002-20260123    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260123    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260123    gcc-8.5.0
s390                  randconfig-002-20260123    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260123    gcc-13.4.0
sh                    randconfig-002-20260123    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260123    gcc-15.2.0
sparc                 randconfig-002-20260123    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260123    gcc-13.4.0
sparc64               randconfig-002-20260123    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260123    gcc-14
um                    randconfig-002-20260123    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260123    clang-20
x86_64      buildonly-randconfig-002-20260123    clang-20
x86_64      buildonly-randconfig-003-20260123    clang-20
x86_64      buildonly-randconfig-004-20260123    clang-20
x86_64      buildonly-randconfig-005-20260123    clang-20
x86_64      buildonly-randconfig-006-20260123    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260123    clang-20
x86_64                randconfig-002-20260123    gcc-14
x86_64                randconfig-003-20260123    gcc-14
x86_64                randconfig-004-20260123    gcc-14
x86_64                randconfig-005-20260123    gcc-14
x86_64                randconfig-006-20260123    gcc-14
x86_64                randconfig-011-20260123    gcc-13
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-013-20260123    clang-20
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-016-20260123    gcc-13
x86_64                randconfig-071-20260123    clang-20
x86_64                randconfig-072-20260123    clang-20
x86_64                randconfig-073-20260123    gcc-14
x86_64                randconfig-074-20260123    gcc-13
x86_64                randconfig-075-20260123    clang-20
x86_64                randconfig-076-20260123    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260123    gcc-11.5.0
xtensa                randconfig-002-20260123    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
