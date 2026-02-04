Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B838BF70
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190033; cv=none; b=gZG6sKs3/gUEn+jC/UvDudNXCrRDo1G0/Vd09N9DYCauC2bZ2dsNeUe1XV9IJOAmrQRi8pa3I0aYwB/+wHRufO0HEgFBfcIvRsV30CojePggvfxYEXHfoyWcztln8347USchN3SxRJ4Zvhz8MIgCbDzDMpX6wCc9XB0k1ywwmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190033; c=relaxed/simple;
	bh=d6aso6VMAdgiuwV6QKD7e4bvWIfp374k/aAM8DxksnU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Oo6RPrktFcQdGwuX3KWZL/A6HihktHT/i/AcurYmcuvprHiu9MLDqXJfdI8UpjH87JouvqoOtbJN6JtXBIIV9mS7K/1weWtDa8WZS8AvDTBc2GwarRYtRS8biMZZYY5TSATi3pdqJpXud+dbrLOJeBv7GgBFpk743f5wQBT3aGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtlThwTP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtlThwTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770190033; x=1801726033;
  h=date:from:to:cc:subject:message-id;
  bh=d6aso6VMAdgiuwV6QKD7e4bvWIfp374k/aAM8DxksnU=;
  b=CtlThwTPNV3q9hs7OYypCtD2T1KLfEGDAo7qZJ1/+AcMz6JyTwedWfjr
   Ca7vSvCthzD69bcwcVHlw/pJ4OHQNxyTO6XIEJOTTPoHkKqHw7Xazcejb
   dPvkhFuXQvVbPqq2jgvapioYHLNOpLw7UwU7RSDgANlF9jFk/aQd3ASjg
   G8aJtTPg6iEH9avLrQhmGMBOAk/SvTXLWCMCF42GXjtF9eAGw3uyeJueg
   QmQiD1jcTlO0IiJ3JTViHucUdM5Gl4hETk1SvY6KYZuYn97pEaI4XZ2TM
   0p2j17RQPVrKCM0dPvZRIkcbPvaZDoI7VN1dlEfOLe12smZN8W8OGl51g
   w==;
X-CSE-ConnectionGUID: 7M56HCJ3TzepGh180rC/iA==
X-CSE-MsgGUID: b/4WktlJTPmLV8LwJLY02A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88947179"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88947179"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 23:27:12 -0800
X-CSE-ConnectionGUID: lwXTw+s9QB2ml7ukMEb0mg==
X-CSE-MsgGUID: N5tc09szRoSoX/YqoEOnmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214780307"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 23:27:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnXI4-00000000hYG-2bNK;
	Wed, 04 Feb 2026 07:27:08 +0000
Date: Wed, 04 Feb 2026 15:26:52 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 00bc604c96bb762f0f050460e25de2729edb1699
Message-ID: <202602041543.e3jWVpzQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 00bc604c96bb762f0f050460e25de2729edb1699  Merge branch 'for-7.0/cxl-prm-translation' into cxl-for-next

elapsed time: 756m

configs tested: 270
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-001-20260204    gcc-9.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260204    clang-22
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-002-20260204    gcc-11.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-003-20260204    clang-22
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-001-20260204    gcc-8.5.0
arm64                 randconfig-002-20260204    clang-22
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-003-20260204    clang-22
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260204    clang-19
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-002-20260204    clang-18
hexagon               randconfig-002-20260204    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260204    clang-20
i386        buildonly-randconfig-001-20260204    gcc-14
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-006-20260204    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260204    clang-20
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-004-20260204    gcc-12
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-012-20260204    clang-20
i386                  randconfig-012-20260204    gcc-14
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-015-20260204    clang-20
i386                  randconfig-015-20260204    gcc-13
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-017-20260204    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          multi_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260204    gcc-11.5.0
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-002-20260204    gcc-11.5.0
nios2                 randconfig-002-20260204    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-10.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                 linkstation_defconfig    clang-20
powerpc                   motionpro_defconfig    clang-22
powerpc               randconfig-001-20260204    clang-22
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-002-20260204    gcc-14.3.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc64             randconfig-001-20260204    clang-19
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260204    gcc-11.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260204    clang-22
riscv                 randconfig-002-20260204    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260204    clang-19
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260204    gcc-14.3.0
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-002-20260204    gcc-12.5.0
sh                    randconfig-002-20260204    gcc-8.5.0
sh                          rsk7269_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260204    clang-22
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260204    gcc-14
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-002-20260204    gcc-14
um                    randconfig-002-20260204    gcc-8.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260204    clang-20
x86_64      buildonly-randconfig-001-20260204    gcc-12
x86_64      buildonly-randconfig-002-20260204    clang-20
x86_64      buildonly-randconfig-002-20260204    gcc-14
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-004-20260204    clang-20
x86_64      buildonly-randconfig-004-20260204    gcc-14
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-006-20260204    clang-20
x86_64      buildonly-randconfig-006-20260204    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260204    gcc-13
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260204    clang-20
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-006-20260204    clang-20
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-012-20260204    gcc-14
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-014-20260204    gcc-14
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-015-20260204    gcc-14
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-016-20260204    gcc-14
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-001-20260204    gcc-9.5.0
xtensa                randconfig-002-20260204    gcc-12.5.0
xtensa                randconfig-002-20260204    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
