Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F732BF5D
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892256; cv=none; b=V0hRquPxUfnODyMdd8xndXLNU+pmbeJ7L4xQQdrYUsFiSyok8khSTUcqb7xC5Mie7HE7rNUOo5SZD6oUE7jh+Yk3n+x1a+JenBQLLt0jlH8CyOD51T6xOB05z/6qQD71zEf2rO0XsrN8FY8q0FYcbw8LiiT+8Zq3NdjOBICP1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892256; c=relaxed/simple;
	bh=qEbEX3z6pnxF2t2Q15hrm1qqDahHxsNalUbfGQAQ0Yg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mm16sI+ya2vCxN6qePjM4+HrETmiaBWd0Kg+tA8UWg9IImoN/t1ZJNLN8vQdczAxog8Sh+iRduygA0PxGn5vtHLb3M4hBBQ9W2sL/r6ZlI/f3dIxCd/dVc+mGzkaox+sBQSHHysuf7kDmpfO7/yLohEoBi+uFTAkB0QsztPmFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsnR2EFI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsnR2EFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775892254; x=1807428254;
  h=date:from:to:cc:subject:message-id;
  bh=qEbEX3z6pnxF2t2Q15hrm1qqDahHxsNalUbfGQAQ0Yg=;
  b=jsnR2EFI6xRpH8Gj7x/vdq6agCXbFfkyt3AK2/vO9mWCP/P87ZBc8n1t
   xf0iDwZK2kXaJsHHNgqFPWgF9qyZBwk7LoCsDdA85G1tjX108iKZ3s4vQ
   GTlpTg28dl991wm25M0wSSFKqYvXSWgGdBjAeH1vPBcE0Z/8vaPwGtm5s
   WgDWgaXnOkiFUbnzZ0P1Ot69dIkFOCJSDEmcbqSwkvrX2owQpzShav9l/
   ok6Ak+4T+DDEKNS1FIdtKWluvx7E308sgoOyqn+AWvuRkNx0CLKxKsthq
   DJWmx7Tlz18uiLA9l6FQ8TirlyWQi94ah3fUlhA5qxBUV4LXjCWYF7Qfk
   w==;
X-CSE-ConnectionGUID: zO+D7F/oSXSalWRpHANcQg==
X-CSE-MsgGUID: Q1pBAGuGQvmrA7c0fxYhwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94295871"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="94295871"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 00:24:14 -0700
X-CSE-ConnectionGUID: IRabpMgNQMKt8G749UV5jQ==
X-CSE-MsgGUID: xYoZZcQpS4+hFw0bx0ssNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="228450980"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2026 00:24:12 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBShN-000000000wl-2nKU;
	Sat, 11 Apr 2026 07:24:09 +0000
Date: Sat, 11 Apr 2026 15:23:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 3939dba00f981c26d1748769f2f28a3cc0afb6a8
Message-ID: <202604111538.LeOcMutm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 3939dba00f981c26d1748769f2f28a3cc0afb6a8  Merge branch 'for-7.1/cxl-misc' into cxl-for-next

elapsed time: 724m

configs tested: 257
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260411    gcc-12.5.0
arm                   randconfig-001-20260411    gcc-14.3.0
arm                   randconfig-002-20260411    clang-23
arm                   randconfig-002-20260411    gcc-12.5.0
arm                   randconfig-003-20260411    clang-23
arm                   randconfig-003-20260411    gcc-12.5.0
arm                   randconfig-004-20260411    clang-23
arm                   randconfig-004-20260411    gcc-12.5.0
arm                        shmobile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260411    clang-23
arm64                 randconfig-002-20260411    clang-23
arm64                 randconfig-003-20260411    clang-16
arm64                 randconfig-003-20260411    clang-23
arm64                 randconfig-004-20260411    clang-19
arm64                 randconfig-004-20260411    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260411    clang-23
csky                  randconfig-001-20260411    gcc-12.5.0
csky                  randconfig-002-20260411    clang-23
csky                  randconfig-002-20260411    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260411    clang-23
hexagon               randconfig-001-20260411    gcc-14.3.0
hexagon               randconfig-002-20260411    clang-23
hexagon               randconfig-002-20260411    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260411    clang-20
i386        buildonly-randconfig-001-20260411    gcc-14
i386        buildonly-randconfig-002-20260411    clang-20
i386        buildonly-randconfig-002-20260411    gcc-14
i386        buildonly-randconfig-003-20260411    clang-20
i386        buildonly-randconfig-003-20260411    gcc-14
i386        buildonly-randconfig-004-20260411    clang-20
i386        buildonly-randconfig-004-20260411    gcc-14
i386        buildonly-randconfig-005-20260411    gcc-14
i386        buildonly-randconfig-006-20260411    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260411    clang-20
i386                  randconfig-002-20260411    clang-20
i386                  randconfig-003-20260411    clang-20
i386                  randconfig-004-20260411    clang-20
i386                  randconfig-005-20260411    clang-20
i386                  randconfig-005-20260411    gcc-14
i386                  randconfig-006-20260411    clang-20
i386                  randconfig-006-20260411    gcc-13
i386                  randconfig-007-20260411    clang-20
i386                  randconfig-011-20260411    clang-20
i386                  randconfig-012-20260411    clang-20
i386                  randconfig-012-20260411    gcc-14
i386                  randconfig-013-20260411    clang-20
i386                  randconfig-013-20260411    gcc-14
i386                  randconfig-014-20260411    clang-20
i386                  randconfig-014-20260411    gcc-14
i386                  randconfig-015-20260411    clang-20
i386                  randconfig-016-20260411    clang-20
i386                  randconfig-016-20260411    gcc-14
i386                  randconfig-017-20260411    clang-20
i386                  randconfig-017-20260411    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260411    gcc-14.3.0
loongarch             randconfig-002-20260411    clang-18
loongarch             randconfig-002-20260411    gcc-14.3.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
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
nios2                 randconfig-001-20260411    gcc-14.3.0
nios2                 randconfig-001-20260411    gcc-9.5.0
nios2                 randconfig-002-20260411    gcc-11.5.0
nios2                 randconfig-002-20260411    gcc-14.3.0
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
parisc                randconfig-001-20260411    gcc-10.5.0
parisc                randconfig-001-20260411    gcc-11.5.0
parisc                randconfig-002-20260411    gcc-11.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260411    clang-17
powerpc               randconfig-001-20260411    gcc-11.5.0
powerpc               randconfig-002-20260411    clang-17
powerpc               randconfig-002-20260411    gcc-11.5.0
powerpc64             randconfig-001-20260411    clang-16
powerpc64             randconfig-001-20260411    gcc-11.5.0
powerpc64             randconfig-002-20260411    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260411    clang-17
riscv                 randconfig-001-20260411    gcc-10.5.0
riscv                 randconfig-002-20260411    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260411    gcc-10.5.0
s390                  randconfig-001-20260411    gcc-8.5.0
s390                  randconfig-002-20260411    gcc-10.5.0
s390                  randconfig-002-20260411    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260411    gcc-10.5.0
sh                    randconfig-001-20260411    gcc-12.5.0
sh                    randconfig-002-20260411    gcc-10.5.0
sh                    randconfig-002-20260411    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260411    gcc-14
sparc                 randconfig-001-20260411    gcc-8.5.0
sparc                 randconfig-002-20260411    gcc-14
sparc                 randconfig-002-20260411    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260411    gcc-14
sparc64               randconfig-001-20260411    gcc-15.2.0
sparc64               randconfig-002-20260411    gcc-11.5.0
sparc64               randconfig-002-20260411    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260411    gcc-14
um                    randconfig-002-20260411    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260411    gcc-14
x86_64      buildonly-randconfig-002-20260411    clang-20
x86_64      buildonly-randconfig-002-20260411    gcc-14
x86_64      buildonly-randconfig-003-20260411    gcc-13
x86_64      buildonly-randconfig-003-20260411    gcc-14
x86_64      buildonly-randconfig-004-20260411    gcc-14
x86_64      buildonly-randconfig-005-20260411    gcc-14
x86_64      buildonly-randconfig-006-20260411    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260411    gcc-12
x86_64                randconfig-001-20260411    gcc-14
x86_64                randconfig-002-20260411    gcc-14
x86_64                randconfig-003-20260411    gcc-14
x86_64                randconfig-004-20260411    clang-20
x86_64                randconfig-004-20260411    gcc-14
x86_64                randconfig-005-20260411    clang-20
x86_64                randconfig-005-20260411    gcc-14
x86_64                randconfig-006-20260411    gcc-12
x86_64                randconfig-006-20260411    gcc-14
x86_64                randconfig-011-20260411    clang-20
x86_64                randconfig-011-20260411    gcc-14
x86_64                randconfig-012-20260411    clang-20
x86_64                randconfig-013-20260411    clang-20
x86_64                randconfig-013-20260411    gcc-14
x86_64                randconfig-014-20260411    clang-20
x86_64                randconfig-015-20260411    clang-20
x86_64                randconfig-015-20260411    gcc-14
x86_64                randconfig-016-20260411    clang-20
x86_64                randconfig-071-20260411    clang-20
x86_64                randconfig-072-20260411    clang-20
x86_64                randconfig-073-20260411    clang-20
x86_64                randconfig-073-20260411    gcc-14
x86_64                randconfig-074-20260411    clang-20
x86_64                randconfig-075-20260411    clang-20
x86_64                randconfig-075-20260411    gcc-14
x86_64                randconfig-076-20260411    clang-20
x86_64                randconfig-076-20260411    gcc-14
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
xtensa                randconfig-001-20260411    gcc-14
xtensa                randconfig-001-20260411    gcc-15.2.0
xtensa                randconfig-002-20260411    gcc-14
xtensa                randconfig-002-20260411    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
