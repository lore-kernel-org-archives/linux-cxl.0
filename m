Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8331AF31
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886323; cv=none; b=bq8QUFBVuNTmvOcmW21SaIuphhTzN5K33cZwUOd4t1PsmKZIGfZqaM5PGV14uREcjnaE3Wd5Jp1LW9z67FhROdup9wDxpY5CfNSHTNaIZYFyZC1oHR+YbSQ5xySWbsTXzAKiZkavlVAqRXSWy+cnMU+eXXZ4Gbjk+vmgPzYMfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886323; c=relaxed/simple;
	bh=N6pdfESOzgVHLNviaL370LkKnoNKRCzMB7K+S+8B0jY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SheRg4ZnVDVJBjH72mRs3LPt/OtVG2MMaOBdAyiV2kI+fUji+71u4HZZO/YphwCYHi3Eywz/ndny+gDbQllo+WYfBH3GD5l+l9IshaKuF9m3RqSBd3N/qUKaZG016q8CIIQNBSdcmPkx8ps6NwjKdEe/TzP/ZRfLXi3ooKUuZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnT1HRZV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnT1HRZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768886321; x=1800422321;
  h=date:from:to:cc:subject:message-id;
  bh=N6pdfESOzgVHLNviaL370LkKnoNKRCzMB7K+S+8B0jY=;
  b=TnT1HRZVhx8nSQaEYYpBXOURPahpVC2V74vmpHX8jSmDZu2Qa61Mzdb7
   K3bhf2N9PPejtyll7uAoRElvPLs1ePkQtQlSDWyuUPFmrlcVtDh+hD7l9
   xZPiFK1dC9w7iGLdKFqhBB4xjq7xjU7xoJVSPSgktMsQVCjznKqTQ6R/U
   1L6JPGyCQm++FvPBXlFI6L/NLNm/dov1bOjqsvRLWvP/+bBFomSbzShaP
   JRNXKFSOXwuIuu6HCp+EGwXjzTbH8EJrYYwS+U0UxCJOzmxhYw1Jt9tDC
   L7JAEXQUcWRNY1hr+N5nxY+yHr7PT6fKPFh8fhAhr/8Bv9Kmub9DL2oIO
   g==;
X-CSE-ConnectionGUID: fZJy+g/SQEOlxi349Yn/VA==
X-CSE-MsgGUID: jwp+2k2xS8e+7d09AkklNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69098954"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="69098954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 21:18:41 -0800
X-CSE-ConnectionGUID: ySV/5K1OTt+/snIHiKcqMQ==
X-CSE-MsgGUID: TD4eumt2SHiYCm4JWDUy1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="206452166"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jan 2026 21:18:38 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi48S-00000000ObV-0GiX;
	Tue, 20 Jan 2026 05:18:36 +0000
Date: Tue, 20 Jan 2026 13:17:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 345f23df5d08fe58fb865cd17b696cd345455224
Message-ID: <202601201353.Ux5Odp8E-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 345f23df5d08fe58fb865cd17b696cd345455224  cxl/region: Use do_div() for 64-bit modulo operation

elapsed time: 808m

configs tested: 237
configs skipped: 6

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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260120    clang-22
arc                   randconfig-001-20260120    gcc-10.5.0
arc                   randconfig-002-20260120    clang-22
arc                   randconfig-002-20260120    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-22
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-002-20260120    clang-22
arm                   randconfig-002-20260120    gcc-13.4.0
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-004-20260120    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260120    gcc-12.5.0
arm64                 randconfig-001-20260120    gcc-15.2.0
arm64                 randconfig-002-20260120    gcc-15.2.0
arm64                 randconfig-002-20260120    gcc-8.5.0
arm64                 randconfig-003-20260120    clang-22
arm64                 randconfig-003-20260120    gcc-15.2.0
arm64                 randconfig-004-20260120    clang-22
arm64                 randconfig-004-20260120    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-002-20260120    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260120    clang-22
hexagon               randconfig-001-20260120    gcc-12.5.0
hexagon               randconfig-002-20260120    clang-22
hexagon               randconfig-002-20260120    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-004-20260120    clang-20
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-006-20260120    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260120    gcc-14
i386                  randconfig-002-20260120    gcc-12
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-007-20260120    gcc-14
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-012-20260120    clang-20
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-017-20260120    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-002-20260120    gcc-12.5.0
loongarch             randconfig-002-20260120    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                  decstation_64_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260120    gcc-11.5.0
nios2                 randconfig-001-20260120    gcc-12.5.0
nios2                 randconfig-002-20260120    gcc-11.5.0
nios2                 randconfig-002-20260120    gcc-12.5.0
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
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-002-20260120    gcc-8.5.0
parisc                randconfig-002-20260120    gcc-9.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260120    clang-19
powerpc               randconfig-001-20260120    gcc-8.5.0
powerpc               randconfig-002-20260120    gcc-10.5.0
powerpc               randconfig-002-20260120    gcc-8.5.0
powerpc64             randconfig-001-20260120    gcc-12.5.0
powerpc64             randconfig-001-20260120    gcc-8.5.0
powerpc64             randconfig-002-20260120    clang-22
powerpc64             randconfig-002-20260120    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-002-20260120    gcc-10.5.0
riscv                 randconfig-002-20260120    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260120    gcc-13.4.0
s390                  randconfig-001-20260120    gcc-15.2.0
s390                  randconfig-002-20260120    clang-22
s390                  randconfig-002-20260120    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260120    gcc-13.4.0
sh                    randconfig-001-20260120    gcc-15.2.0
sh                    randconfig-002-20260120    gcc-11.5.0
sh                    randconfig-002-20260120    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260120    clang-22
sparc64               randconfig-001-20260120    gcc-8.5.0
sparc64               randconfig-002-20260120    clang-20
sparc64               randconfig-002-20260120    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260120    gcc-14
um                    randconfig-001-20260120    gcc-8.5.0
um                    randconfig-002-20260120    gcc-14
um                    randconfig-002-20260120    gcc-8.5.0
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260120    gcc-14
x86_64      buildonly-randconfig-002-20260120    gcc-14
x86_64      buildonly-randconfig-003-20260120    gcc-14
x86_64      buildonly-randconfig-004-20260120    clang-20
x86_64      buildonly-randconfig-005-20260120    gcc-14
x86_64      buildonly-randconfig-006-20260120    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260120    gcc-13
x86_64                randconfig-001-20260120    gcc-14
x86_64                randconfig-002-20260120    gcc-13
x86_64                randconfig-002-20260120    gcc-14
x86_64                randconfig-003-20260120    gcc-14
x86_64                randconfig-004-20260120    gcc-14
x86_64                randconfig-005-20260120    gcc-14
x86_64                randconfig-006-20260120    gcc-13
x86_64                randconfig-006-20260120    gcc-14
x86_64                randconfig-011-20260120    clang-20
x86_64                randconfig-012-20260120    gcc-12
x86_64                randconfig-013-20260120    clang-20
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-015-20260120    clang-20
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-073-20260120    clang-20
x86_64                randconfig-073-20260120    gcc-14
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-075-20260120    clang-20
x86_64                randconfig-075-20260120    gcc-14
x86_64                randconfig-076-20260120    clang-20
x86_64                randconfig-076-20260120    gcc-14
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
xtensa                randconfig-001-20260120    gcc-13.4.0
xtensa                randconfig-001-20260120    gcc-8.5.0
xtensa                randconfig-002-20260120    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
