Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5D1632D1
	for <linux-cxl@vger.kernel.org>; Sat, 26 Oct 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939622; cv=none; b=ik4QvWu1cNgCMlnqIumk/dsLCfgljNBy2HqAq0JKc4yIZ70yQLgVHyhMEMy5At6/yiTqzo88Tbi8zrL29Tyl0vWvK2bdOhf98j9MStQdube354Nn3PKx2VjiItt7pd9YIucx5urJc2H9lNWlR+2sztCShZp96IUuYZ7FaE/+6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939622; c=relaxed/simple;
	bh=ZZ9Naxc7taDG86/0az2iCpYUWOo0EZKvV8Z52webH8Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OWxs5oVbALpFHVSsvWm1ddNLG9NecD+EMzMk/PYvyY1yWvG1HNLQ9EsYHs3SLW9s7KMqatUgXXo/NUJWN719m9FGo9IR2L6E9BzHWdbeiTFhqBRjpc+0BeVpqUTQFX8itujPhaXd4pbWEebTn0B2/g01T3V0IHeRRk/ZYEKfZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9Sc0/eH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9Sc0/eH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729939620; x=1761475620;
  h=date:from:to:cc:subject:message-id;
  bh=ZZ9Naxc7taDG86/0az2iCpYUWOo0EZKvV8Z52webH8Q=;
  b=g9Sc0/eHCOW8GsY+Qemmieza22DPg+ZNGR2s/umuvRLub6LJbKz/+JNo
   7jyb221EtK8UIwJXEu/281LBGRbY/waQyHkQ/AGnX7eo+1SIhwKMO7iw7
   LQa8THwWHZFZxNbXe9Z8JPTJrZxdGk33rGeNRv0kdlWz/njTyxlUiThsn
   t7gVjfA9iyFesFI4lxfnpk8yJZhMIkj2njBY25Q+bZI9AxENxgAY6Ddgc
   u0vDhK687An8aSStoMzFiMPkBACzZdSw5xWOSfMBZx8PCCmCfwc0xHRUX
   lswMeIPk/SDSt1H7XJB0rTExvqDMvMwe+WwScp4yGeFf1cxi6DeMA2cej
   g==;
X-CSE-ConnectionGUID: KmahGj6JTpOEHPAt7pcsZg==
X-CSE-MsgGUID: Z3IG8ZCuRmKeIyj2RsMoCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29790747"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29790747"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 03:47:00 -0700
X-CSE-ConnectionGUID: ZTGrea0tSASUQTbVriVZJA==
X-CSE-MsgGUID: IlcoCPdzT9igJqqNTHAOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="81319569"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Oct 2024 03:46:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4eJr-000ZXG-13;
	Sat, 26 Oct 2024 10:46:55 +0000
Date: Sat, 26 Oct 2024 18:45:57 +0800
From: kernel test robot <lkp@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 3a2b97b3210bd5758f66fad04c5171f85a016a04
Message-ID: <202410261849.9pM7cL7y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 3a2b97b3210bd5758f66fad04c5171f85a016a04  cxl/test: Improve init-order fidelity relative to real-world systems

elapsed time: 736m

configs tested: 230
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241026    gcc-13.2.0
arc                   randconfig-001-20241026    gcc-14.1.0
arc                   randconfig-002-20241026    gcc-13.2.0
arc                   randconfig-002-20241026    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    clang-20
arm                   randconfig-002-20241026    gcc-14.1.0
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    clang-20
arm64                 randconfig-002-20241026    gcc-14.1.0
arm64                 randconfig-003-20241026    clang-20
arm64                 randconfig-003-20241026    gcc-14.1.0
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241026    clang-20
hexagon               randconfig-001-20241026    gcc-14.1.0
hexagon               randconfig-002-20241026    clang-17
hexagon               randconfig-002-20241026    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241026    clang-19
i386        buildonly-randconfig-001-20241026    gcc-12
i386        buildonly-randconfig-002-20241026    clang-19
i386        buildonly-randconfig-002-20241026    gcc-12
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    clang-19
i386        buildonly-randconfig-004-20241026    gcc-12
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    clang-19
i386        buildonly-randconfig-006-20241026    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    clang-19
i386                  randconfig-001-20241026    gcc-12
i386                  randconfig-002-20241026    clang-19
i386                  randconfig-002-20241026    gcc-12
i386                  randconfig-003-20241026    clang-19
i386                  randconfig-003-20241026    gcc-12
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    clang-19
i386                  randconfig-005-20241026    gcc-12
i386                  randconfig-006-20241026    clang-19
i386                  randconfig-006-20241026    gcc-12
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq6_defconfig    clang-14
mips                           ip28_defconfig    gcc-14.1.0
mips                          rb532_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                 canyonlands_defconfig    clang-20
powerpc                     kmeter1_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    clang-20
powerpc               randconfig-003-20241026    gcc-14.1.0
powerpc64             randconfig-001-20241026    clang-20
powerpc64             randconfig-001-20241026    gcc-14.1.0
powerpc64             randconfig-002-20241026    clang-20
powerpc64             randconfig-002-20241026    gcc-14.1.0
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                        sh7757lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    clang-20
um                    randconfig-001-20241026    gcc-14.1.0
um                    randconfig-002-20241026    clang-20
um                    randconfig-002-20241026    gcc-14.1.0
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241026    clang-19
x86_64      buildonly-randconfig-002-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    gcc-12
x86_64      buildonly-randconfig-004-20241026    clang-19
x86_64      buildonly-randconfig-005-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241026    clang-19
x86_64                randconfig-002-20241026    clang-19
x86_64                randconfig-002-20241026    gcc-12
x86_64                randconfig-003-20241026    clang-19
x86_64                randconfig-003-20241026    gcc-12
x86_64                randconfig-004-20241026    clang-19
x86_64                randconfig-004-20241026    gcc-12
x86_64                randconfig-005-20241026    clang-19
x86_64                randconfig-005-20241026    gcc-12
x86_64                randconfig-006-20241026    clang-19
x86_64                randconfig-006-20241026    gcc-12
x86_64                randconfig-011-20241026    clang-19
x86_64                randconfig-012-20241026    clang-19
x86_64                randconfig-013-20241026    clang-19
x86_64                randconfig-013-20241026    gcc-12
x86_64                randconfig-014-20241026    clang-19
x86_64                randconfig-015-20241026    clang-19
x86_64                randconfig-016-20241026    clang-19
x86_64                randconfig-071-20241026    clang-19
x86_64                randconfig-072-20241026    clang-19
x86_64                randconfig-073-20241026    clang-19
x86_64                randconfig-074-20241026    clang-19
x86_64                randconfig-075-20241026    clang-19
x86_64                randconfig-076-20241026    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
