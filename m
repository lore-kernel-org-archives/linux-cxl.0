Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A42352FBF
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167920; cv=none; b=IporFHuz3yD8TtvgZc539RyU+9lauIdwXF376y42RpN6lQnqf5Mw+4n25JmKmUEzOZhBmQuScOocVzhwUX2JbBkzdApANvw+KN7VbXzCe7MSE8S9kYQp9Kglug4Xa016da+1hEGaUCGVjfHsA6QbI5ApUx0WP/aPqvYP0PGUGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167920; c=relaxed/simple;
	bh=fFrNX957duUSL25ja0DU//s85l5jZaGBpEe8K43TOAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A17EZfzmP6i9pCB6s2njZNixE4K4Mnu4H2kqiBXhVXhXTHW3I+SudmqX7N1SC4thIFEUbOHwXxfRnW80nElWyN3+tRRHLMk7VFxNgKPF2ojKqhaKg4VinTy3y/DRmVeq1KygkiY7xWld8mI8jShl9J4q7HuAoUzGgK8Ix6K4Qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iF5ONTWo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iF5ONTWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769167917; x=1800703917;
  h=date:from:to:cc:subject:message-id;
  bh=fFrNX957duUSL25ja0DU//s85l5jZaGBpEe8K43TOAg=;
  b=iF5ONTWoWjunG3RI2Ata1jaPdnDZRLTEh7mJ7RWaOB8CiOLd24EpMe83
   vvRoOtOoPYklZzvOxjIu1WgTKYGbkm1UVbZbfIXAu0TJQk+51x6l9b4Po
   VJKuxQmjk0UOpeKP+WNYsL8XWgf4w2/ksLgytInx3plQ8Ys8mCkmBN7Jn
   QvW2pM7KBC8scCXKOfb1u0+6R+VGXYMBxzAExxlymQn0ZqZhu9IyL63RF
   Hwivo1eQUBZPbKiz7FGwm/9lOYJ90jN3u5nSMxxORecYUKXCKpeYjoEsz
   t6nz9WR2celNW/vThkhmxHTQlx+ciiA4v29QQp4AcX0bJiXBOoFXE0IVW
   A==;
X-CSE-ConnectionGUID: n6D+ozyrSwK5JrLDhy1tRg==
X-CSE-MsgGUID: SamzojA1Sne0XcvJnpvIQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81050323"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="81050323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:31:54 -0800
X-CSE-ConnectionGUID: MsB3txmGR7iq8kj6QLp23Q==
X-CSE-MsgGUID: rZFNykdTSmGzzMIo5LMT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207346671"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jan 2026 03:31:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjFOH-00000000Tta-2mrm;
	Fri, 23 Jan 2026 11:31:49 +0000
Date: Fri, 23 Jan 2026 19:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.0/cxl-aer-prep] BUILD SUCCESS
 9a8920ca8ebfb99604f639e7fbc681d0d04518a0
Message-ID: <202601231923.IRgemQVA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.0/cxl-aer-prep
branch HEAD: 9a8920ca8ebfb99604f639e7fbc681d0d04518a0  cxl: Update RAS handler interfaces to also support CXL Ports

elapsed time: 760m

configs tested: 281
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260123    gcc-10.5.0
arc                   randconfig-001-20260123    gcc-8.5.0
arc                   randconfig-002-20260123    gcc-10.5.0
arc                   randconfig-002-20260123    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         assabet_defconfig    clang-22
arm                     davinci_all_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                      integrator_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260123    clang-18
arm                   randconfig-001-20260123    gcc-10.5.0
arm                   randconfig-002-20260123    clang-22
arm                   randconfig-002-20260123    gcc-10.5.0
arm                   randconfig-003-20260123    gcc-10.5.0
arm                   randconfig-004-20260123    gcc-10.5.0
arm                   randconfig-004-20260123    gcc-15.2.0
arm                         s5pv210_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-13.4.0
arm64                 randconfig-002-20260123    gcc-15.2.0
arm64                 randconfig-003-20260123    gcc-10.5.0
arm64                 randconfig-003-20260123    gcc-15.2.0
arm64                 randconfig-004-20260123    gcc-13.4.0
arm64                 randconfig-004-20260123    gcc-15.2.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260123    clang-22
hexagon               randconfig-001-20260123    gcc-12.5.0
hexagon               randconfig-002-20260123    clang-18
hexagon               randconfig-002-20260123    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-002-20260123    clang-20
i386        buildonly-randconfig-002-20260123    gcc-14
i386        buildonly-randconfig-003-20260123    clang-20
i386        buildonly-randconfig-003-20260123    gcc-14
i386        buildonly-randconfig-004-20260123    clang-20
i386        buildonly-randconfig-004-20260123    gcc-14
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-006-20260123    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260123    clang-20
i386                  randconfig-001-20260123    gcc-14
i386                  randconfig-002-20260123    clang-20
i386                  randconfig-002-20260123    gcc-14
i386                  randconfig-003-20260123    gcc-14
i386                  randconfig-004-20260123    gcc-14
i386                  randconfig-005-20260123    clang-20
i386                  randconfig-005-20260123    gcc-14
i386                  randconfig-006-20260123    gcc-14
i386                  randconfig-007-20260123    gcc-13
i386                  randconfig-007-20260123    gcc-14
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-012-20260123    clang-20
i386                  randconfig-012-20260123    gcc-14
i386                  randconfig-013-20260123    clang-20
i386                  randconfig-013-20260123    gcc-14
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-015-20260123    clang-20
i386                  randconfig-015-20260123    gcc-14
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-017-20260123    clang-20
i386                  randconfig-017-20260123    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260123    gcc-12.5.0
loongarch             randconfig-002-20260123    gcc-12.5.0
loongarch             randconfig-002-20260123    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         cobalt_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260123    gcc-10.5.0
nios2                 randconfig-001-20260123    gcc-12.5.0
nios2                 randconfig-002-20260123    gcc-11.5.0
nios2                 randconfig-002-20260123    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-002-20260123    gcc-12.5.0
parisc                randconfig-002-20260123    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260123    clang-22
powerpc               randconfig-001-20260123    gcc-12.5.0
powerpc               randconfig-002-20260123    clang-22
powerpc               randconfig-002-20260123    gcc-12.5.0
powerpc                     taishan_defconfig    clang-22
powerpc                         wii_defconfig    gcc-15.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260123    gcc-12.5.0
powerpc64             randconfig-001-20260123    gcc-8.5.0
powerpc64             randconfig-002-20260123    gcc-12.5.0
powerpc64             randconfig-002-20260123    gcc-13.4.0
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260123    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260123    gcc-8.5.0
s390                  randconfig-002-20260123    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    clang-22
sh                    randconfig-001-20260123    gcc-13.4.0
sh                    randconfig-002-20260123    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260123    gcc-13.4.0
sparc                 randconfig-001-20260123    gcc-15.2.0
sparc                 randconfig-002-20260123    gcc-13.4.0
sparc                 randconfig-002-20260123    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260123    gcc-13.4.0
sparc64               randconfig-002-20260123    gcc-12.5.0
sparc64               randconfig-002-20260123    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260123    gcc-13.4.0
um                    randconfig-001-20260123    gcc-14
um                    randconfig-002-20260123    clang-22
um                    randconfig-002-20260123    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260123    clang-20
x86_64      buildonly-randconfig-002-20260123    clang-20
x86_64      buildonly-randconfig-003-20260123    clang-20
x86_64      buildonly-randconfig-004-20260123    clang-20
x86_64      buildonly-randconfig-005-20260123    clang-20
x86_64      buildonly-randconfig-006-20260123    clang-20
x86_64      buildonly-randconfig-006-20260123    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260123    clang-20
x86_64                randconfig-001-20260123    gcc-14
x86_64                randconfig-002-20260123    gcc-14
x86_64                randconfig-003-20260123    gcc-14
x86_64                randconfig-004-20260123    gcc-14
x86_64                randconfig-005-20260123    gcc-14
x86_64                randconfig-006-20260123    gcc-14
x86_64                randconfig-011-20260123    gcc-13
x86_64                randconfig-011-20260123    gcc-14
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-013-20260123    clang-20
x86_64                randconfig-013-20260123    gcc-14
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-016-20260123    gcc-13
x86_64                randconfig-016-20260123    gcc-14
x86_64                randconfig-071-20260123    clang-20
x86_64                randconfig-072-20260123    clang-20
x86_64                randconfig-073-20260123    clang-20
x86_64                randconfig-073-20260123    gcc-14
x86_64                randconfig-074-20260123    clang-20
x86_64                randconfig-074-20260123    gcc-13
x86_64                randconfig-075-20260123    clang-20
x86_64                randconfig-076-20260123    clang-20
x86_64                randconfig-076-20260123    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260123    gcc-11.5.0
xtensa                randconfig-001-20260123    gcc-13.4.0
xtensa                randconfig-002-20260123    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
