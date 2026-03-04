Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C6335543
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640308; cv=none; b=I/w1pc3LSkCThXC0PKAYtE0pWDfk2L960H3pZdoBgfyvHmybK9jkip/jqh+cBBWFV2TQrWGh1/o7yWJNH2Fmg1rrpzyXku1yrx+wqJmcymhbPuURYTsPCW5Mz58E4kWJNYnaV1TFtsHxs3XILuZcxbtquySkDGx/aQr+F9iZSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640308; c=relaxed/simple;
	bh=kaoyid/9ONZoHq+xmX/4o06H0dA2sb0L08LobF4wGi4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OJ109HI66EyaLv+tfeFIJG3wA9DN1yPIIvcOK5eEpUp4ljgagAvIcJCMedyxaQ2/+HpDV85yl1rPr2j9aBbjrFXNe/MI73yHJ30fJMRSjyRoTyUhEoIfg7t2zKh1hXunvFSfd/O9I8bbecE5O9BgWynkv0egEgrkUqtzseW+3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbjfyj51; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbjfyj51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772640307; x=1804176307;
  h=date:from:to:cc:subject:message-id;
  bh=kaoyid/9ONZoHq+xmX/4o06H0dA2sb0L08LobF4wGi4=;
  b=fbjfyj51H3MqxXGhRxorYSVVfzxJbM1bitCKL11GLsog2fdQ2BkPCNsJ
   vxd/VNGVrDZk3Hg0h2xNArvk9DRAQt4qKhmjq5w3kVYsh5YbxT4Yz2X3U
   bGi7uxxSCzPVbR4LDY+G2XMCBAfkL9i1uN+hGi/yHNjSPfOU5QKGoNOMN
   0mO8PaBVXho+C7raKGZhRf68suQLfPie4OXlqM815LTIb0E3e2kZXcq8w
   6GG0vXbCJqDEZhUBOY4+o9ouuB3dvBNWfsujqYlfVeeiBvqLXotguO1jO
   Z2MmrkPKIIRs/8mJaQrqYSYtn0I4dhNuj3n0uiIzLPCChhZShk34g2S73
   w==;
X-CSE-ConnectionGUID: JV3K0+9bQNST5yetiZ5Gpw==
X-CSE-MsgGUID: 7dvERDo/QP2gg6sPep2rZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84340007"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84340007"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:05:06 -0800
X-CSE-ConnectionGUID: dLzbDKGWT/u+0fDE17oyKg==
X-CSE-MsgGUID: SwjaI0QKQBeYba+zOYsM8Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Mar 2026 08:05:04 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxoib-0000000042T-2Yx9;
	Wed, 04 Mar 2026 16:05:01 +0000
Date: Thu, 05 Mar 2026 00:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4
Message-ID: <202603050049.UNUWcZlD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4  cxl/port: Fix use after free of parent_port in cxl_detach_ep()

elapsed time: 1288m

configs tested: 222
configs skipped: 4

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
arc                   randconfig-001-20260304    gcc-9.5.0
arc                   randconfig-002-20260304    gcc-9.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260304    clang-23
arm                   randconfig-002-20260304    clang-23
arm                   randconfig-003-20260304    clang-23
arm                   randconfig-004-20260304    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260304    clang-23
arm64                 randconfig-002-20260304    clang-23
arm64                 randconfig-003-20260304    clang-20
arm64                 randconfig-004-20260304    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260304    gcc-15.2.0
csky                  randconfig-002-20260304    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260304    gcc-15.2.0
hexagon               randconfig-002-20260304    gcc-15.2.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260304    gcc-14
i386        buildonly-randconfig-002-20260304    gcc-14
i386        buildonly-randconfig-003-20260304    clang-20
i386        buildonly-randconfig-003-20260304    gcc-14
i386        buildonly-randconfig-004-20260304    gcc-14
i386        buildonly-randconfig-005-20260304    gcc-14
i386        buildonly-randconfig-006-20260304    clang-20
i386        buildonly-randconfig-006-20260304    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260304    clang-20
i386                  randconfig-002-20260304    gcc-14
i386                  randconfig-003-20260304    clang-20
i386                  randconfig-004-20260304    gcc-14
i386                  randconfig-005-20260304    clang-20
i386                  randconfig-006-20260304    gcc-14
i386                  randconfig-007-20260304    clang-20
i386                  randconfig-011-20260304    clang-20
i386                  randconfig-011-20260304    gcc-14
i386                  randconfig-012-20260304    gcc-14
i386                  randconfig-013-20260304    gcc-14
i386                  randconfig-014-20260304    gcc-14
i386                  randconfig-015-20260304    gcc-14
i386                  randconfig-016-20260304    gcc-14
i386                  randconfig-017-20260304    clang-20
i386                  randconfig-017-20260304    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260304    gcc-15.2.0
loongarch             randconfig-002-20260304    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260304    gcc-15.2.0
nios2                 randconfig-002-20260304    gcc-15.2.0
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
parisc                randconfig-001-20260304    gcc-8.5.0
parisc                randconfig-002-20260304    gcc-13.4.0
parisc                randconfig-002-20260304    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260304    clang-20
powerpc               randconfig-001-20260304    gcc-8.5.0
powerpc               randconfig-002-20260304    gcc-8.5.0
powerpc               randconfig-002-20260304    gcc-9.5.0
powerpc64             randconfig-001-20260304    clang-23
powerpc64             randconfig-001-20260304    gcc-8.5.0
powerpc64             randconfig-002-20260304    clang-23
powerpc64             randconfig-002-20260304    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260304    clang-23
riscv                 randconfig-001-20260304    gcc-8.5.0
riscv                 randconfig-002-20260304    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260304    clang-23
s390                  randconfig-002-20260304    clang-23
s390                  randconfig-002-20260304    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260304    clang-23
sh                    randconfig-001-20260304    gcc-15.2.0
sh                    randconfig-002-20260304    clang-23
sh                    randconfig-002-20260304    gcc-15.2.0
sh                           se7780_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260304    gcc-11.5.0
sparc                 randconfig-002-20260304    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260304    clang-20
sparc64               randconfig-002-20260304    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260304    clang-23
um                    randconfig-002-20260304    clang-23
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260304    gcc-14
x86_64      buildonly-randconfig-002-20260304    clang-20
x86_64      buildonly-randconfig-002-20260304    gcc-14
x86_64      buildonly-randconfig-003-20260304    clang-20
x86_64      buildonly-randconfig-003-20260304    gcc-14
x86_64      buildonly-randconfig-004-20260304    gcc-14
x86_64      buildonly-randconfig-005-20260304    clang-20
x86_64      buildonly-randconfig-005-20260304    gcc-14
x86_64      buildonly-randconfig-006-20260304    clang-20
x86_64      buildonly-randconfig-006-20260304    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260304    clang-20
x86_64                randconfig-002-20260304    clang-20
x86_64                randconfig-003-20260304    clang-20
x86_64                randconfig-003-20260304    gcc-14
x86_64                randconfig-004-20260304    clang-20
x86_64                randconfig-004-20260304    gcc-12
x86_64                randconfig-005-20260304    clang-20
x86_64                randconfig-005-20260304    gcc-14
x86_64                randconfig-006-20260304    clang-20
x86_64                randconfig-011-20260304    gcc-14
x86_64                randconfig-012-20260304    clang-20
x86_64                randconfig-012-20260304    gcc-14
x86_64                randconfig-013-20260304    clang-20
x86_64                randconfig-013-20260304    gcc-14
x86_64                randconfig-014-20260304    gcc-14
x86_64                randconfig-015-20260304    clang-20
x86_64                randconfig-015-20260304    gcc-14
x86_64                randconfig-016-20260304    gcc-14
x86_64                randconfig-071-20260304    clang-20
x86_64                randconfig-072-20260304    clang-20
x86_64                randconfig-073-20260304    clang-20
x86_64                randconfig-073-20260304    gcc-14
x86_64                randconfig-074-20260304    clang-20
x86_64                randconfig-075-20260304    clang-20
x86_64                randconfig-076-20260304    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260304    gcc-10.5.0
xtensa                randconfig-002-20260304    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
