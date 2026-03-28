Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37A13AD26
	for <linux-cxl@vger.kernel.org>; Sat, 28 Mar 2026 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774683600; cv=none; b=mA/u2VxURDeSFLI5gDEP2RvTMJzB041iLeAjPoXqaxhAxuyWrhjLo49kXu9HdDdXsKGOemMVrhKoS5o+2/jTfirxSWI1/iIOcjp/AHy3UcEWXIvKmGQnuZq6r7Z0Q90Pd+XA8bV4nAplV8eTcaJSlGzzW+6osKTiDX+CgSs5c4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774683600; c=relaxed/simple;
	bh=ejv9tVqAjQNWlKSRISrs0iCJkMGhN1FhOsudnsj33VM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G8sEyxdu1oebAsRtF0qegBdXt6Bz4tTWBAgZ5W+sOhrXSWPRGn/17kWZrTyoDNkfi7p5OLaLNd55cOg7nZb/TzFW1j0s6YUP6JLCqGURgeDZazWhAkBxIHWET6twgGRJ1AN7MQFWM08Feib3jISKY1S0COAOOtUV5iEoFQPRBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfCfHYKQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfCfHYKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774683598; x=1806219598;
  h=date:from:to:cc:subject:message-id;
  bh=ejv9tVqAjQNWlKSRISrs0iCJkMGhN1FhOsudnsj33VM=;
  b=nfCfHYKQ/rFVvQn0EbPGwjntTVPQGJx1BECXGvrIK1RxJC3NU1wCDH93
   oKG6N0i8UWIPrsLTgQLJMWxIL9+UtVnrLBtKyuvQzG7aNv3b4Ze4BzUPb
   OgLBo/L2VKtTSshlZoZGgUycWqsIayX3M02S250DjKj5M0nv17sLpc7VE
   uAYpv8UhIOfhhfTeU8vPxSMWuKLiP422x57ca0OxXLznctuWiWAtwRAG/
   9yvXkVfH9/ValQHqLbPWi6AfRYxL66wHdq+xs3kX9ti7xCuWDoKnV2ceX
   Gf+UKpygEBbcL/aYh6FWFeqWhufLXyT0UpjlCMUq/FhElVNPw3wIqfWrO
   Q==;
X-CSE-ConnectionGUID: O8oEHxflRm6BPLWDJgeidg==
X-CSE-MsgGUID: 0CN9VowlRN+5iFqicTbjpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74781177"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="74781177"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 00:39:58 -0700
X-CSE-ConnectionGUID: NVxCQTqoSlyA3o3DE8+63w==
X-CSE-MsgGUID: 5Bx/Tj+tQE6JX+wUNFdlKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="220671757"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Mar 2026 00:39:56 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6OGv-00000000BBl-3VwY;
	Sat, 28 Mar 2026 07:39:53 +0000
Date: Sat, 28 Mar 2026 15:38:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.1/cxl-region-refactor] BUILD SUCCESS
 29990ab5cb408d5aa15939d6535e3291aeef748b
Message-ID: <202603281546.WKWFamup-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.1/cxl-region-refactor
branch HEAD: 29990ab5cb408d5aa15939d6535e3291aeef748b  cxl/core: use cleanup.h for devm_cxl_add_dax_region

elapsed time: 741m

configs tested: 263
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
arc                   randconfig-001-20260328    gcc-15.2.0
arc                   randconfig-001-20260328    gcc-8.5.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260328    gcc-12.5.0
arm                   randconfig-001-20260328    gcc-15.2.0
arm                   randconfig-002-20260328    gcc-15.2.0
arm                   randconfig-002-20260328    gcc-8.5.0
arm                   randconfig-003-20260328    gcc-15.2.0
arm                   randconfig-003-20260328    gcc-8.5.0
arm                   randconfig-004-20260328    gcc-15.2.0
arm                   randconfig-004-20260328    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260328    gcc-14.3.0
arm64                 randconfig-003-20260328    gcc-8.5.0
arm64                 randconfig-004-20260328    gcc-14.3.0
arm64                 randconfig-004-20260328    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260328    gcc-14.3.0
csky                  randconfig-001-20260328    gcc-15.2.0
csky                  randconfig-002-20260328    gcc-13.4.0
csky                  randconfig-002-20260328    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260328    clang-23
hexagon               randconfig-001-20260328    gcc-11.5.0
hexagon               randconfig-002-20260328    clang-23
hexagon               randconfig-002-20260328    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260328    clang-20
i386        buildonly-randconfig-002-20260328    gcc-12
i386        buildonly-randconfig-003-20260328    clang-20
i386        buildonly-randconfig-003-20260328    gcc-14
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260328    clang-20
i386        buildonly-randconfig-006-20260328    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260328    clang-20
i386                  randconfig-002-20260328    clang-20
i386                  randconfig-003-20260328    clang-20
i386                  randconfig-003-20260328    gcc-14
i386                  randconfig-004-20260328    clang-20
i386                  randconfig-004-20260328    gcc-14
i386                  randconfig-005-20260328    clang-20
i386                  randconfig-006-20260328    clang-20
i386                  randconfig-006-20260328    gcc-14
i386                  randconfig-007-20260328    clang-20
i386                  randconfig-007-20260328    gcc-14
i386                  randconfig-011-20260328    gcc-13
i386                  randconfig-012-20260328    gcc-13
i386                  randconfig-012-20260328    gcc-14
i386                  randconfig-013-20260328    clang-20
i386                  randconfig-013-20260328    gcc-13
i386                  randconfig-014-20260328    gcc-13
i386                  randconfig-014-20260328    gcc-14
i386                  randconfig-015-20260328    gcc-13
i386                  randconfig-016-20260328    gcc-13
i386                  randconfig-017-20260328    clang-20
i386                  randconfig-017-20260328    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260328    clang-23
loongarch             randconfig-001-20260328    gcc-11.5.0
loongarch             randconfig-002-20260328    gcc-11.5.0
loongarch             randconfig-002-20260328    gcc-15.2.0
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
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
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
parisc                randconfig-001-20260328    gcc-10.5.0
parisc                randconfig-001-20260328    gcc-13.4.0
parisc                randconfig-002-20260328    gcc-10.5.0
parisc                randconfig-002-20260328    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260328    gcc-10.5.0
powerpc               randconfig-001-20260328    gcc-13.4.0
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260328    gcc-13.4.0
powerpc64             randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-002-20260328    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260328    clang-23
riscv                 randconfig-001-20260328    gcc-11.5.0
riscv                 randconfig-002-20260328    clang-17
riscv                 randconfig-002-20260328    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260328    clang-16
s390                  randconfig-001-20260328    clang-23
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260328    clang-23
sh                    randconfig-001-20260328    gcc-15.2.0
sh                    randconfig-002-20260328    clang-23
sh                    randconfig-002-20260328    gcc-15.2.0
sh                           se7705_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260328    gcc-14
sparc                 randconfig-001-20260328    gcc-14.3.0
sparc                 randconfig-002-20260328    gcc-14
sparc                 randconfig-002-20260328    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260328    clang-23
sparc64               randconfig-001-20260328    gcc-14
sparc64               randconfig-002-20260328    gcc-14
sparc64               randconfig-002-20260328    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260328    clang-20
x86_64      buildonly-randconfig-001-20260328    gcc-14
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260328    clang-20
x86_64      buildonly-randconfig-005-20260328    gcc-14
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260328    clang-20
x86_64                randconfig-001-20260328    gcc-14
x86_64                randconfig-002-20260328    gcc-13
x86_64                randconfig-002-20260328    gcc-14
x86_64                randconfig-003-20260328    gcc-14
x86_64                randconfig-004-20260328    gcc-14
x86_64                randconfig-005-20260328    clang-20
x86_64                randconfig-005-20260328    gcc-14
x86_64                randconfig-006-20260328    gcc-14
x86_64                randconfig-011-20260328    clang-20
x86_64                randconfig-012-20260328    clang-20
x86_64                randconfig-013-20260328    clang-20
x86_64                randconfig-013-20260328    gcc-14
x86_64                randconfig-014-20260328    clang-20
x86_64                randconfig-014-20260328    gcc-14
x86_64                randconfig-015-20260328    clang-20
x86_64                randconfig-016-20260328    clang-20
x86_64                randconfig-071-20260328    gcc-12
x86_64                randconfig-072-20260328    clang-20
x86_64                randconfig-072-20260328    gcc-12
x86_64                randconfig-073-20260328    gcc-12
x86_64                randconfig-073-20260328    gcc-14
x86_64                randconfig-074-20260328    gcc-12
x86_64                randconfig-075-20260328    gcc-12
x86_64                randconfig-075-20260328    gcc-14
x86_64                randconfig-076-20260328    gcc-12
x86_64                randconfig-076-20260328    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260328    gcc-14
xtensa                randconfig-001-20260328    gcc-8.5.0
xtensa                randconfig-002-20260328    gcc-10.5.0
xtensa                randconfig-002-20260328    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
