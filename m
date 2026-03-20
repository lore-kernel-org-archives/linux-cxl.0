Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441752E4274
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004810; cv=none; b=EvNOxIjIoUFMjcdkt8GhJR+9TmMZEdFxxs/xQWq/CF5yNiFk7NX8XHMxoj3rxOQ8T/hl0jR4M81DSUVBDCIEegouvqH7MXRhYi1Qkqu6x/vMgiu6HxOn1yvwJwxBFDRnfwCKoN+mi4B0TKS0fW+X/bBcKvxl9sxO4xc/dL5QMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004810; c=relaxed/simple;
	bh=p3rXwkjG84hWQ4sxXFWbEUIq2beXRvbA9V6vVIINBTY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VscRDR4yTcCZawFTsm27Cr1+jPyilaQSVFsXEk4UXpme+Fcq9o2eR2WVgJ0r3BgNCtDu+5URmeWCXsw+uY/r7fVYqMaSmqS4k5BtKI+uqKYEyPlRsHfwe3zHCXFltWqf+ofrmdMmiACmeIHPmNJwUzM0ydFmnSV2wddJ+QIIWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exFyMcb1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exFyMcb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774004809; x=1805540809;
  h=date:from:to:cc:subject:message-id;
  bh=p3rXwkjG84hWQ4sxXFWbEUIq2beXRvbA9V6vVIINBTY=;
  b=exFyMcb16HOoNC9ApjX3HDagz11jwk9P1jnDMGJ76G3g+oe+vMTRvTeQ
   HbvIQUuVv934dB2tUHHdVEztWbC5tyEVoXUhiw2zV/0g1cQ7OP1vOxhUK
   /t8tzhr3xuQEczmYgDOHcdgqvgcgOGJXBEKmnUIUA1iCI/Hr4YJmOBx8F
   o12LLGjAFmiBhyMyRqN5EvHHfsVROG3MZdgpY9xYpMZIEnnScp1DEVcf4
   VeRuEAUqQupeWx/1ueN6JTfaZSZhvYmIffyMQVPPMfqd/Y3V/wIsDPuh9
   oWTr4uePTyGi9e3G8+feAe0qHh/JIHrnLBjB5Um4ZpaM16Un254i6uz2r
   A==;
X-CSE-ConnectionGUID: f3IpoOn8T1yx/9c8OMH5hg==
X-CSE-MsgGUID: 3OZWJ1aRTVS483n+sReAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74969605"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74969605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:06:49 -0700
X-CSE-ConnectionGUID: CfTABfteRBOqpq3yvltYsg==
X-CSE-MsgGUID: yZ1myKklQXuOyCbXjW3G9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261155399"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2026 04:06:46 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3Xey-000000002ID-0xB0;
	Fri, 20 Mar 2026 11:05:14 +0000
Date: Fri, 20 Mar 2026 19:03:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 be5c5280cf2b20e363dc8e2a424dd200a29b1c77
Message-ID: <202603201949.jfy8dqrd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: be5c5280cf2b20e363dc8e2a424dd200a29b1c77  cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi

elapsed time: 750m

configs tested: 160
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260320    gcc-13.4.0
arc                   randconfig-002-20260320    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260320    gcc-10.5.0
arm                   randconfig-002-20260320    clang-18
arm                   randconfig-003-20260320    gcc-13.4.0
arm                   randconfig-004-20260320    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260320    clang-17
arm64                 randconfig-002-20260320    gcc-8.5.0
arm64                 randconfig-003-20260320    clang-23
arm64                 randconfig-004-20260320    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260320    gcc-15.2.0
csky                  randconfig-002-20260320    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260320    clang-23
hexagon               randconfig-002-20260320    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260320    gcc-14
i386        buildonly-randconfig-002-20260320    gcc-14
i386        buildonly-randconfig-003-20260320    clang-20
i386        buildonly-randconfig-004-20260320    gcc-14
i386        buildonly-randconfig-005-20260320    clang-20
i386        buildonly-randconfig-006-20260320    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260320    clang-20
i386                  randconfig-002-20260320    clang-20
i386                  randconfig-003-20260320    clang-20
i386                  randconfig-004-20260320    gcc-14
i386                  randconfig-005-20260320    gcc-14
i386                  randconfig-006-20260320    gcc-14
i386                  randconfig-007-20260320    clang-20
i386                  randconfig-011-20260320    clang-20
i386                  randconfig-012-20260320    gcc-14
i386                  randconfig-013-20260320    clang-20
i386                  randconfig-014-20260320    clang-20
i386                  randconfig-015-20260320    clang-20
i386                  randconfig-016-20260320    clang-20
i386                  randconfig-017-20260320    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260320    clang-23
loongarch             randconfig-002-20260320    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260320    gcc-11.5.0
nios2                 randconfig-002-20260320    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260320    gcc-14.3.0
parisc                randconfig-002-20260320    gcc-9.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260320    clang-23
powerpc               randconfig-002-20260320    gcc-10.5.0
powerpc64             randconfig-001-20260320    gcc-10.5.0
powerpc64             randconfig-002-20260320    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260320    gcc-8.5.0
riscv                 randconfig-002-20260320    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260320    gcc-13.4.0
s390                  randconfig-002-20260320    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260320    gcc-15.2.0
sh                    randconfig-002-20260320    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260320    gcc-8.5.0
sparc                 randconfig-002-20260320    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260320    gcc-14.3.0
sparc64               randconfig-002-20260320    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260320    gcc-14
um                    randconfig-002-20260320    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260320    gcc-14
x86_64      buildonly-randconfig-002-20260320    gcc-14
x86_64      buildonly-randconfig-003-20260320    clang-20
x86_64      buildonly-randconfig-004-20260320    clang-20
x86_64      buildonly-randconfig-005-20260320    clang-20
x86_64      buildonly-randconfig-006-20260320    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260320    clang-20
x86_64                randconfig-002-20260320    clang-20
x86_64                randconfig-003-20260320    gcc-14
x86_64                randconfig-004-20260320    clang-20
x86_64                randconfig-005-20260320    clang-20
x86_64                randconfig-006-20260320    clang-20
x86_64                randconfig-011-20260320    gcc-14
x86_64                randconfig-012-20260320    gcc-14
x86_64                randconfig-013-20260320    gcc-14
x86_64                randconfig-014-20260320    gcc-14
x86_64                randconfig-015-20260320    gcc-14
x86_64                randconfig-016-20260320    gcc-12
x86_64                randconfig-071-20260320    gcc-14
x86_64                randconfig-072-20260320    gcc-14
x86_64                randconfig-073-20260320    clang-20
x86_64                randconfig-074-20260320    gcc-14
x86_64                randconfig-075-20260320    clang-20
x86_64                randconfig-076-20260320    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260320    gcc-8.5.0
xtensa                randconfig-002-20260320    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
