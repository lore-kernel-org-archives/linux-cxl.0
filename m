Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B922E54A8
	for <linux-cxl@vger.kernel.org>; Thu, 13 Nov 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046810; cv=none; b=Z+i1s6oGw2S5MH0Mq9sSe8VqvRT5OcQPPLIdPkeEKZArz2BE36yqGqqNgEzd4WGyJPe4Lr7IQmBDqxq+B32vWZ+zdHKxinyosA/L1gtIMyDdjiI5Ba/m6rGy0wQaa+jaW1XV9Z2+I4idVvaen5m4EzqfpC+Z5oEtwGHKwTB8bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046810; c=relaxed/simple;
	bh=6aFvpDt0VLkPcq16ueqy2rDKcsp/qAHoR0oSR+uM9PA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SyQiIDeU5urBrlMy7RSUTEeBab87t0eLDYngOPrGToqI+qcTeSvp8S80W47wVRAV29EYJvyzZWuhICY5D4L5OH0HGDyRMOl7inlYqNL1qwF9qj84Vg0uYFgfluWiCS7ULaOBq2rDz7T+srWQAB6h4t9BY9OxTKiqsifhzfdvuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgZD9Rbq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgZD9Rbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046808; x=1794582808;
  h=date:from:to:cc:subject:message-id;
  bh=6aFvpDt0VLkPcq16ueqy2rDKcsp/qAHoR0oSR+uM9PA=;
  b=KgZD9Rbq5QzncDEWCqsnyxctaTaR+0cZGcX0Z7ozfme/5H6MhR+C8btZ
   ZyHNzpHegZAMOv0j2ZLQQAtzgFRfuqbG8uj+QkIbPrJ3lxmerUNqXQNnc
   dqgk1v2IlRmhs3Hx7qRbfAnJ7+vFUUediyumSnsvsTV5ysCNBE9OcUA0r
   yOPSE374wjvN3158NWKdxnfpPCZML76U7+Z4DWDKWwgCOJkdRriMcYeb0
   UkI2nnXH3WP8BgRSEuxbzZdclsMY0WqenZvE85uLzy82vMQ8ol7s0Gill
   dTmV9tO9n5NQ2bouQdLciLyfRLpfkV2BuFj2vJ3qfQonXCT0lbUSa7lUk
   Q==;
X-CSE-ConnectionGUID: 6Byczh79SAiFrmBM9i75lw==
X-CSE-MsgGUID: m8Riw8MKR2qKzuA/Of0gtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68994161"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68994161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:13:28 -0800
X-CSE-ConnectionGUID: 15U9nLXRTVmavYGM5l+FmQ==
X-CSE-MsgGUID: DeszHQrpQyy40tv0CSP5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189536629"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2025 07:13:26 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJZ0m-0005Sx-0A;
	Thu, 13 Nov 2025 15:13:24 +0000
Date: Thu, 13 Nov 2025 23:12:31 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 214291cbaaceeb28debd773336642b1fca393ae0
Message-ID: <202511132326.O6WQ1BWa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 214291cbaaceeb28debd773336642b1fca393ae0  acpi/hmat: Fix lockdep warning for hmem_register_resource()

elapsed time: 998m

configs tested: 166
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
arc                   randconfig-001-20251113    gcc-8.5.0
arc                   randconfig-002-20251113    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20251113    gcc-10.5.0
arm                   randconfig-002-20251113    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251113    clang-16
arm64                 randconfig-002-20251113    clang-22
arm64                 randconfig-003-20251113    gcc-8.5.0
arm64                 randconfig-004-20251113    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251113    gcc-9.5.0
csky                  randconfig-002-20251113    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251113    clang-22
hexagon               randconfig-002-20251113    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251113    clang-20
i386        buildonly-randconfig-002-20251113    gcc-14
i386        buildonly-randconfig-003-20251113    gcc-14
i386        buildonly-randconfig-004-20251113    gcc-12
i386        buildonly-randconfig-005-20251113    gcc-14
i386        buildonly-randconfig-006-20251113    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251113    gcc-14
i386                  randconfig-002-20251113    clang-20
i386                  randconfig-003-20251113    clang-20
i386                  randconfig-004-20251113    gcc-14
i386                  randconfig-005-20251113    clang-20
i386                  randconfig-006-20251113    clang-20
i386                  randconfig-007-20251113    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251113    gcc-15.1.0
loongarch             randconfig-002-20251113    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
mips                           ci20_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251113    gcc-8.5.0
nios2                 randconfig-002-20251113    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251113    gcc-8.5.0
parisc                randconfig-002-20251113    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 linkstation_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251113    clang-22
powerpc                     sequoia_defconfig    clang-17
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251113    gcc-8.5.0
riscv                 randconfig-002-20251113    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251113    clang-22
s390                  randconfig-002-20251113    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251113    gcc-15.1.0
sh                    randconfig-002-20251113    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251113    gcc-8.5.0
sparc                 randconfig-002-20251113    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251113    clang-20
sparc64               randconfig-002-20251113    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251113    gcc-14
um                    randconfig-002-20251113    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251113    gcc-14
x86_64      buildonly-randconfig-002-20251113    clang-20
x86_64      buildonly-randconfig-003-20251113    clang-20
x86_64      buildonly-randconfig-004-20251113    gcc-14
x86_64      buildonly-randconfig-005-20251113    gcc-12
x86_64      buildonly-randconfig-006-20251113    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251113    gcc-13
x86_64                randconfig-002-20251113    clang-20
x86_64                randconfig-003-20251113    gcc-14
x86_64                randconfig-004-20251113    clang-20
x86_64                randconfig-005-20251113    gcc-14
x86_64                randconfig-006-20251113    clang-20
x86_64                randconfig-011-20251113    gcc-14
x86_64                randconfig-012-20251113    clang-20
x86_64                randconfig-013-20251113    clang-20
x86_64                randconfig-014-20251113    gcc-14
x86_64                randconfig-015-20251113    gcc-14
x86_64                randconfig-016-20251113    gcc-12
x86_64                randconfig-071-20251113    gcc-14
x86_64                randconfig-072-20251113    gcc-12
x86_64                randconfig-073-20251113    gcc-12
x86_64                randconfig-074-20251113    gcc-14
x86_64                randconfig-075-20251113    gcc-14
x86_64                randconfig-076-20251113    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251113    gcc-15.1.0
xtensa                randconfig-002-20251113    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
