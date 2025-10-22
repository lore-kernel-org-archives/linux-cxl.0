Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721D38FA3
	for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113519; cv=none; b=aq27+JIfurWXOvlUQ3h0D8rL4v76Hu6rX6JjID0XylfJd2JUkgev+Mm7N6QhNlo4jGEDDgltwQ4fcVA9/rNRKwjFilmeF4sa07GOtzh+tl3Vy9qYCcZBdO6hUVZOm16gc3/JMd/XsZYBGv6O7+Z2MJ+W2Pw/CXYugdxv19AUb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113519; c=relaxed/simple;
	bh=NWVpdwBanMn/bGQO0CanM2rUn/77O0Oh9xP1uPOqIhM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BPrtR7KsF6ufxs+JfRQILayK5ezkHWL1Fi2PEbBLeCb0Tog+a/dP7l3/LtfYrdZ0KyL35U9n2j+0P77DKnDE8E0qxJ4GYE7g19tgCV0R+XwyTB5WV7ZtT83cR1Ni52/xPgJWzdX9gYRQ3W4LObuUy9bFwYS3/ahmo8J85yzH4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpY+XDEy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpY+XDEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761113517; x=1792649517;
  h=date:from:to:cc:subject:message-id;
  bh=NWVpdwBanMn/bGQO0CanM2rUn/77O0Oh9xP1uPOqIhM=;
  b=cpY+XDEy7oxZk/KMjEwavJc3CrIl/hosujfMO8H6HqCBjAaWRtt478Ln
   42TnOnXn7anK1OdzB0n3rj1KOhILkC1C0j5FqXIJaHIkjyFPpkXGN6NrN
   6vLfJmgJ2uJcOREDsd1ntF8oGtQHEO0oOEEl1pF99251m1CVCrfMZCHCE
   g7gowk2U4UCO1ZELbMcCIhjKv76+mkRhSklyFvS0o3lNuY9ZAGvHZ3aNG
   J8DgPUYYUnW5lxi7R1FuQOi92TNj4gMgDoGdfXGBcRp0+6NKrJvTEZRpf
   4e61/0eYHLO/D7wnd7AJnT5KHq0IE79eNBHlusyv+cNLuf+gzmCLjSaBM
   w==;
X-CSE-ConnectionGUID: cAVtLnvCSzOLGQ5ZYyalUA==
X-CSE-MsgGUID: GdnU5VNtQmSXCrOFecaglw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88719230"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="88719230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:11:56 -0700
X-CSE-ConnectionGUID: CBBAC6ayRU+Ue/PXW+dg4Q==
X-CSE-MsgGUID: kPwBl9aOTiO7fb2Fvlrinw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183666392"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Oct 2025 23:11:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBS4N-000C2f-1N;
	Wed, 22 Oct 2025 06:11:41 +0000
Date: Wed, 22 Oct 2025 14:11:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 7c3643f204edf1c5edb12b36b34838683ee5f8dc
Message-ID: <202510221400.Qa2pkMhA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 7c3643f204edf1c5edb12b36b34838683ee5f8dc  acpi,srat: Fix incorrect device handle check for Generic Initiator

elapsed time: 817m

configs tested: 134
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-002-20251022    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-004-20251022    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-004-20251022    gcc-12.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-002-20251022    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-002-20251022    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-006-20251022    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-002-20251022    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-002-20251022    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-002-20251022    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-003-20251022    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251022    gcc-14.3.0
riscv                 randconfig-002-20251022    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-002-20251022    clang-22
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251022    gcc-10.5.0
sh                    randconfig-002-20251022    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251022    gcc-14.3.0
sparc                 randconfig-002-20251022    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251022    gcc-8.5.0
sparc64               randconfig-002-20251022    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251022    gcc-14
um                    randconfig-002-20251022    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251022    gcc-11.5.0
xtensa                randconfig-002-20251022    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
