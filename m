Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE522D9ED1
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266965; cv=none; b=bZpsUpfKaoSYPn68lZNUps9QpMt2LouxXUxqifV32PSgwNQmrS2JjJMKA5kJkgMeDpUjU+io3E7OXC5NrRuFdnE7K+b9q9d7YpUg9Lkl07ioFfDLRdYq/n/vNOzxQOI5B0ZTXZF5kSf7f9ty82BZduIKMnCWUVj/ujU27TJ1CSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266965; c=relaxed/simple;
	bh=w21c0YaY7aRR2s+g+GlO0K70RO+sqePPdN4/TflAZ70=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hqcAqqP+Qf7apOjtLZvcBlRpmRr8Hk7VgDMQJbAMBc41m4YIvhjGHuUkCTIj47iqdMsnYgURvNgxP2pkFJ97+rtnVum+CAKGn3FF0iVoRMf2c5I4W6VGXitk+6JL0h/jI609XyQh184RFke12v5qa32cGqKcG5OwA1Yv/1/YPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lD29M+QV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lD29M+QV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764266964; x=1795802964;
  h=date:from:to:cc:subject:message-id;
  bh=w21c0YaY7aRR2s+g+GlO0K70RO+sqePPdN4/TflAZ70=;
  b=lD29M+QVL0vV0Y3+nHCruIz4oq5NtmIeFjeyfeYSLwJ7fl3EpVH3paon
   hkjgpTSXXDSWe9ssORESy0uNVTLTWZlE0RlY8q8MjtBOnvB/D1obryM5/
   cGx19mBO3c+zRPwtAJAsCunN2xKwx4U6lsgFwvwV8MY5YVa6hSaux1si+
   0hsrQnDLLCFiQQ8padmog8FEG1EOYPdM0Lwgj/wKZfz5M2fp1HQ88x7zO
   IztBLl0BAy3w8mTctQQwRHBliV1/a0ecIgTRj1yzkPZYodoMgjHE5W59t
   ajd2A0QMpTxWQZbowAAvzhkvmkzv6S8QFNd7sD5I/R0rbAKZO5K0XWzUi
   g==;
X-CSE-ConnectionGUID: NWSs0PJtRo+ZfL/CX/FHYQ==
X-CSE-MsgGUID: ngeVQHtXSVirzVq/9qvz7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="53883919"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="53883919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:09:24 -0800
X-CSE-ConnectionGUID: /qb/kdE+SDmxwuBxq4lruw==
X-CSE-MsgGUID: 9FHSRVzQQJau1TQEqOmgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193303298"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Nov 2025 10:09:22 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOgQh-000000005V5-1Ff6;
	Thu, 27 Nov 2025 18:09:19 +0000
Date: Fri, 28 Nov 2025 02:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.19/cxl-aer] BUILD SUCCESS
 19bcbd11a08d11cc2b54f82efae7ff068c880177
Message-ID: <202511280235.XvaprXPq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.19/cxl-aer
branch HEAD: 19bcbd11a08d11cc2b54f82efae7ff068c880177  cxl/port: Move endpoint component register management to cxl_port

elapsed time: 1100m

configs tested: 177
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
alpha                     defconfig    gcc-15.1.0
arc                    allmodconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc                    allyesconfig    gcc-15.1.0
arc                       defconfig    gcc-15.1.0
arc         randconfig-001-20251127    clang-22
arc         randconfig-001-20251127    gcc-15.1.0
arc         randconfig-002-20251127    clang-22
arc         randconfig-002-20251127    gcc-8.5.0
arm                     allnoconfig    clang-22
arm                     allnoconfig    gcc-15.1.0
arm                    allyesconfig    gcc-15.1.0
arm                       defconfig    clang-22
arm                gemini_defconfig    clang-20
arm         randconfig-001-20251127    clang-22
arm         randconfig-002-20251127    clang-22
arm         randconfig-003-20251127    clang-22
arm         randconfig-004-20251127    clang-22
arm         randconfig-004-20251127    gcc-10.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.1.0
arm64                     defconfig    gcc-15.1.0
arm64       randconfig-001-20251127    gcc-8.5.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                      defconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                 allnoconfig    gcc-15.1.0
hexagon                   defconfig    clang-22
hexagon     randconfig-001-20251127    gcc-15.1.0
hexagon     randconfig-002-20251127    gcc-15.1.0
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-15.1.0
i386                   allyesconfig    gcc-14
i386                      defconfig    clang-20
i386        randconfig-011-20251127    gcc-13
i386        randconfig-012-20251127    gcc-14
i386        randconfig-013-20251127    clang-20
i386        randconfig-014-20251127    clang-20
i386        randconfig-015-20251127    gcc-14
i386        randconfig-016-20251127    clang-20
i386        randconfig-017-20251127    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch               allnoconfig    gcc-15.1.0
loongarch                 defconfig    clang-19
loongarch   randconfig-001-20251127    gcc-15.1.0
loongarch   randconfig-002-20251127    gcc-15.1.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
m68k                      defconfig    clang-19
m68k                      defconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
microblaze                defconfig    clang-19
microblaze                defconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
mips             bmips_be_defconfig    gcc-15.1.0
nios2                  allmodconfig    clang-22
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-22
nios2                   allnoconfig    gcc-11.5.0
nios2                     defconfig    clang-19
nios2                     defconfig    gcc-11.5.0
nios2       randconfig-001-20251127    gcc-15.1.0
nios2       randconfig-002-20251127    gcc-15.1.0
openrisc               allmodconfig    clang-22
openrisc               allmodconfig    gcc-15.1.0
openrisc                allnoconfig    clang-22
openrisc                allnoconfig    gcc-15.1.0
openrisc                  defconfig    gcc-15.1.0
parisc                 allmodconfig    gcc-15.1.0
parisc                  allnoconfig    clang-22
parisc                  allnoconfig    gcc-15.1.0
parisc                 allyesconfig    gcc-15.1.0
parisc                    defconfig    gcc-15.1.0
parisc      randconfig-001-20251127    gcc-13.4.0
parisc      randconfig-001-20251127    gcc-8.5.0
parisc      randconfig-002-20251127    gcc-13.4.0
parisc      randconfig-002-20251127    gcc-15.1.0
parisc64                  defconfig    clang-19
parisc64                  defconfig    gcc-15.1.0
powerpc                allmodconfig    gcc-15.1.0
powerpc                 allnoconfig    clang-22
powerpc                 allnoconfig    gcc-15.1.0
powerpc          gamecube_defconfig    clang-22
powerpc     randconfig-001-20251127    clang-22
powerpc     randconfig-001-20251127    gcc-13.4.0
powerpc     randconfig-002-20251127    gcc-13.4.0
powerpc64   randconfig-001-20251127    gcc-13.4.0
powerpc64   randconfig-002-20251127    gcc-13.4.0
riscv                  allmodconfig    clang-22
riscv                   allnoconfig    clang-22
riscv                   allnoconfig    gcc-15.1.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    clang-22
riscv                     defconfig    gcc-15.1.0
riscv       randconfig-001-20251127    gcc-12.5.0
riscv       randconfig-002-20251127    gcc-12.5.0
s390                   allmodconfig    clang-18
s390                   allmodconfig    gcc-15.1.0
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390                      defconfig    clang-22
s390                      defconfig    gcc-15.1.0
s390        randconfig-001-20251127    gcc-11.5.0
s390        randconfig-001-20251127    gcc-12.5.0
s390        randconfig-002-20251127    gcc-12.5.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    clang-22
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh                        defconfig    gcc-14
sh                        defconfig    gcc-15.1.0
sh          randconfig-001-20251127    gcc-12.5.0
sh          randconfig-002-20251127    gcc-12.5.0
sparc                   allnoconfig    clang-22
sparc                   allnoconfig    gcc-15.1.0
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-001-20251127    clang-22
sparc       randconfig-001-20251127    gcc-13.4.0
sparc       randconfig-002-20251127    clang-22
sparc       randconfig-002-20251127    gcc-11.5.0
sparc64                allmodconfig    clang-22
sparc64                   defconfig    clang-20
sparc64                   defconfig    gcc-14
sparc64     randconfig-001-20251127    clang-22
sparc64     randconfig-001-20251127    gcc-15.1.0
sparc64     randconfig-002-20251127    clang-20
sparc64     randconfig-002-20251127    clang-22
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
um                        defconfig    clang-22
um                        defconfig    gcc-14
um                   i386_defconfig    gcc-14
um          randconfig-001-20251127    clang-22
um          randconfig-002-20251127    clang-22
um                 x86_64_defconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                  allnoconfig    clang-22
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64      randconfig-001-20251127    clang-20
x86_64      randconfig-002-20251127    clang-20
x86_64      randconfig-003-20251127    gcc-14
x86_64      randconfig-004-20251127    gcc-14
x86_64      randconfig-005-20251127    gcc-14
x86_64      randconfig-006-20251127    clang-20
x86_64      randconfig-011-20251127    clang-20
x86_64      randconfig-012-20251127    gcc-14
x86_64      randconfig-013-20251127    gcc-14
x86_64      randconfig-014-20251127    gcc-14
x86_64      randconfig-015-20251127    gcc-14
x86_64      randconfig-016-20251127    gcc-14
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-22
xtensa                  allnoconfig    gcc-15.1.0
xtensa                 allyesconfig    clang-22
xtensa                 allyesconfig    gcc-15.1.0
xtensa      randconfig-001-20251127    clang-22
xtensa      randconfig-002-20251127    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
