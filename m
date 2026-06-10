Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52167396587
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078102; cv=none; b=Dm7xrCCUbT0aTyhPIA2e7pLBPiptilI4ew0QvPuuPwSUtkJ90As93rJzLIiWZhobuSa3Izgk+EH+1uA8zR9mgYAjOHZGiGMvaZLKD0xA43yMr99rNlKYERoSlUVqa6C1HdnIFe3VrUgWKOdR6IP6byifE9Rlfdh6YVlKvpuQdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078102; c=relaxed/simple;
	bh=2VA1DcmvLNzqtDs9ULA1L0rWFyqOFdtrkoqffh+FEzo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nHWZamfK42b8l61j19PSBomczLheAULPreYN6qgOidGLvXxljsAQfeQt7shGBRYLe6+IkyYdIE0mJSvZrlDF4UuD2tjwdsl5pOBLcVRezyzMg2qyNgz+4E+d7CdwhWEU26Hzza204c2KSK+9SwvSdyjRrZoCceZuqd/dM8vHrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKYiAHya; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKYiAHya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781078098; x=1812614098;
  h=date:from:to:cc:subject:message-id;
  bh=2VA1DcmvLNzqtDs9ULA1L0rWFyqOFdtrkoqffh+FEzo=;
  b=UKYiAHyas01Q5mXeZtgLRwzG/GUJ1N49tBPDnn2EMYFs3g26Yw6m7Hbj
   Ow+xB/KCxThNUjVI3Qx1Y6R1141IvKdxF4FCwK3NINZUbJG1XO9RU0Moq
   SRDUFKVUbPCZJPFquDNSL2LnId1h+ixgJKZcxm3xy8AM93RKGLntTryax
   BEN0Wh2W3lEr5TTlwXAAgApG4QclXR/b77fjuLIDKoRu7kgHgXvM7n27E
   vlYX1THJOf0E83VO4TEhFrfO7m80sMR4e4YUV7LwkrPI2/hHLnSxrcMIY
   6wM13gsl23AUiw/hnhRGq6VAzuQrfX0Vhl5KcUSF+tGl6E3IRhOScDyfg
   Q==;
X-CSE-ConnectionGUID: t0/jEiPRQIOpQPL4a36zpw==
X-CSE-MsgGUID: w2LRVahaR8SKcl1eVEXGqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85755754"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85755754"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 00:54:57 -0700
X-CSE-ConnectionGUID: RH88ZEDCSaGIBWV5by2B6Q==
X-CSE-MsgGUID: HlLgBKZlR7mWvCGuKOMVpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269781085"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jun 2026 00:54:54 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXDm0-00000000L7G-1els;
	Wed, 10 Jun 2026 07:54:52 +0000
Date: Wed, 10 Jun 2026 15:53:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 72afdd8181219f459142e571999b3b44ef7b85fb
Message-ID: <202606101543.9XGP1WzR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 72afdd8181219f459142e571999b3b44ef7b85fb  Merge branch 'for-7.2/cxl-misc' into cxl-for-next

elapsed time: 823m

configs tested: 179
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260610    gcc-8.5.0
arc                   randconfig-002-20260610    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260610    clang-23
arm                   randconfig-002-20260610    clang-20
arm                   randconfig-003-20260610    clang-23
arm                   randconfig-004-20260610    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260610    gcc-11.5.0
arm64                 randconfig-002-20260610    gcc-9.5.0
arm64                 randconfig-003-20260610    gcc-8.5.0
arm64                 randconfig-004-20260610    clang-23
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260610    gcc-9.5.0
csky                  randconfig-002-20260610    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260610    clang-23
hexagon               randconfig-002-20260610    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260610    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260610    gcc-14
i386                  randconfig-002-20260610    gcc-14
i386                  randconfig-003-20260610    clang-22
i386                  randconfig-004-20260610    gcc-14
i386                  randconfig-005-20260610    clang-22
i386                  randconfig-006-20260610    gcc-14
i386                  randconfig-007-20260610    gcc-14
i386                  randconfig-011-20260610    clang-22
i386                  randconfig-012-20260610    clang-22
i386                  randconfig-013-20260610    clang-22
i386                  randconfig-014-20260610    clang-22
i386                  randconfig-015-20260610    clang-22
i386                  randconfig-016-20260610    clang-22
i386                  randconfig-017-20260610    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260610    gcc-16.1.0
loongarch             randconfig-002-20260610    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260610    gcc-11.5.0
nios2                 randconfig-002-20260610    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260610    gcc-8.5.0
parisc                randconfig-002-20260610    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                   microwatt_defconfig    gcc-16.1.0
powerpc                     powernv_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260610    gcc-9.5.0
powerpc               randconfig-002-20260610    clang-23
powerpc64             randconfig-001-20260610    clang-23
powerpc64             randconfig-002-20260610    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260610    gcc-15.2.0
riscv                 randconfig-002-20260610    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260610    clang-23
s390                  randconfig-002-20260610    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                          polaris_defconfig    gcc-16.1.0
sh                    randconfig-001-20260610    gcc-16.1.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260610    gcc-8.5.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260610    gcc-12.5.0
sparc64               randconfig-002-20260610    clang-23
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260610    clang-23
um                    randconfig-002-20260610    clang-18
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260610    clang-22
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64      buildonly-randconfig-003-20260610    clang-22
x86_64      buildonly-randconfig-004-20260610    clang-22
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260610    clang-22
x86_64                randconfig-002-20260610    clang-22
x86_64                randconfig-003-20260610    gcc-13
x86_64                randconfig-004-20260610    clang-22
x86_64                randconfig-005-20260610    clang-22
x86_64                randconfig-006-20260610    gcc-13
x86_64                randconfig-011-20260610    gcc-12
x86_64                randconfig-012-20260610    gcc-12
x86_64                randconfig-013-20260610    gcc-14
x86_64                randconfig-014-20260610    gcc-12
x86_64                randconfig-015-20260610    gcc-14
x86_64                randconfig-016-20260610    gcc-14
x86_64                randconfig-071-20260610    gcc-14
x86_64                randconfig-072-20260610    clang-22
x86_64                randconfig-073-20260610    clang-22
x86_64                randconfig-074-20260610    gcc-14
x86_64                randconfig-075-20260610    gcc-14
x86_64                randconfig-076-20260610    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260610    gcc-8.5.0
xtensa                randconfig-002-20260610    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
