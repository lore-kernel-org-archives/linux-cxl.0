Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EB1B7F4
	for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128127; cv=none; b=OeQbCqmJodRTBEoHXCwCW+jUMHu+2tBB5EKj8EeiIDQECSrkl8yZiKMtQQpNeNanWesut3SujoIxohXdqsqwXmv840jiQ1PESf5SOUNxNefUVZc7d99fr4NxXpK1u8joDVndyn0daj2tVB9PJ8gHWFWcY+dZy9TmB/Xm1Xpq3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128127; c=relaxed/simple;
	bh=Z8JM/px2vajr5wAXBQdrgPEGV1isJdMOGPXgAhnpzfs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cUS8HIFEv5CbUdoMiSIQaPJNfGjx1Fi4945XpO+MEuVKBJ3uK9hjwx3hRD+nQ2N9vYvgCwRLzIuXpYZ5vENdopBwc1VPhACwCNsh9PuAMCTeTGwtK5pxdL1sHS1wOYtZ8D++ncZ1KkGRwizVQlYWPtpCc4CL90t4ibULf6v4qW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7U3cGH1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7U3cGH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763128126; x=1794664126;
  h=date:from:to:cc:subject:message-id;
  bh=Z8JM/px2vajr5wAXBQdrgPEGV1isJdMOGPXgAhnpzfs=;
  b=L7U3cGH1+s7Czx6shrgeMXV3NuvTyqDGZ8oAIubl8LUDiN7TFeYkOUfN
   ohyMm4/wjfDtPkqaBklFxOO/NQz1a4mgxBwiucUlPog5FH6063F2zJkZy
   IB3AWl2LPmbiBmnU67FCDPAZrFHV2Vs/VQ7jd59jg0pOamPxsqw83uOG2
   TUXCZnjnLZ9AmAbfGV4xWAvOtZ7mh9apfQiYgHA5+xVrm0v6FD2xhl2J+
   4ATp2/99vHBtQdyY+l1iLOfVxKSlHoviooZvgBwcIg4YniGnUNMlX00xO
   PP+xLIbfRF8W/WV9D+C7Rx6XiYZ/fq4LXm2fTmRNVh2OWwodF5bQQWKcj
   Q==;
X-CSE-ConnectionGUID: cjWGYapTTpqE1ho74SF1qQ==
X-CSE-MsgGUID: pPgRq6WYQ26gRmqQNI4VGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="87867982"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="87867982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 05:48:43 -0800
X-CSE-ConnectionGUID: RbcYy44VSxqflxBy3IJC2g==
X-CSE-MsgGUID: c6xvUKJCSYaqMqQta7ydgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189978666"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Nov 2025 05:48:41 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJuAI-0006cl-1v;
	Fri, 14 Nov 2025 13:48:38 +0000
Date: Fri, 14 Nov 2025 21:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 482dc84e91a597149949f18c8eefb49cb2dc1bee
Message-ID: <202511142112.KyRif2EH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 482dc84e91a597149949f18c8eefb49cb2dc1bee  Merge branch 'for-6.19/cxl-elc' into cxl-for-next

elapsed time: 1259m

configs tested: 168
configs skipped: 6

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
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251114    gcc-8.5.0
arc                   randconfig-002-20251114    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251114    gcc-15.1.0
arm                   randconfig-002-20251114    gcc-14.3.0
arm                   randconfig-003-20251114    clang-22
arm                   randconfig-004-20251114    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251114    gcc-8.5.0
arm64                 randconfig-002-20251114    clang-22
arm64                 randconfig-003-20251114    clang-22
arm64                 randconfig-004-20251114    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251114    gcc-10.5.0
csky                  randconfig-002-20251114    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251114    clang-22
hexagon               randconfig-002-20251114    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251114    gcc-14
i386        buildonly-randconfig-002-20251114    clang-20
i386        buildonly-randconfig-003-20251114    clang-20
i386        buildonly-randconfig-004-20251114    gcc-14
i386        buildonly-randconfig-005-20251114    clang-20
i386        buildonly-randconfig-006-20251114    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251114    clang-20
i386                  randconfig-003-20251114    clang-20
i386                  randconfig-004-20251114    gcc-14
i386                  randconfig-011-20251114    gcc-12
i386                  randconfig-012-20251114    gcc-14
i386                  randconfig-013-20251114    gcc-14
i386                  randconfig-014-20251114    clang-20
i386                  randconfig-015-20251114    gcc-14
i386                  randconfig-016-20251114    gcc-14
i386                  randconfig-017-20251114    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251114    clang-18
loongarch             randconfig-002-20251114    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251114    gcc-10.5.0
nios2                 randconfig-002-20251114    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251114    gcc-12.5.0
parisc                randconfig-002-20251114    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251114    clang-17
powerpc               randconfig-002-20251114    clang-22
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20251114    gcc-8.5.0
powerpc64             randconfig-002-20251114    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251114    gcc-13.4.0
riscv                 randconfig-002-20251114    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251114    gcc-8.5.0
s390                  randconfig-002-20251114    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20251114    gcc-10.5.0
sh                    randconfig-002-20251114    gcc-15.1.0
sh                          rsk7203_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251114    gcc-14.3.0
sparc                 randconfig-002-20251114    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251114    gcc-8.5.0
sparc64               randconfig-002-20251114    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251114    gcc-13
um                    randconfig-002-20251114    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251114    clang-20
x86_64      buildonly-randconfig-002-20251114    gcc-14
x86_64      buildonly-randconfig-003-20251114    gcc-14
x86_64      buildonly-randconfig-004-20251114    clang-20
x86_64      buildonly-randconfig-005-20251114    clang-20
x86_64      buildonly-randconfig-006-20251114    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251114    clang-20
x86_64                randconfig-002-20251114    gcc-14
x86_64                randconfig-003-20251114    clang-20
x86_64                randconfig-004-20251114    clang-20
x86_64                randconfig-005-20251114    gcc-12
x86_64                randconfig-006-20251114    gcc-14
x86_64                randconfig-071-20251114    clang-20
x86_64                randconfig-072-20251114    clang-20
x86_64                randconfig-073-20251114    clang-20
x86_64                randconfig-074-20251114    clang-20
x86_64                randconfig-075-20251114    gcc-14
x86_64                randconfig-076-20251114    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251114    gcc-14.3.0
xtensa                randconfig-002-20251114    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
