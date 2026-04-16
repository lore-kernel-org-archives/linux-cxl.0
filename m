Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4F386C03
	for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328118; cv=none; b=R0W5ikyailBqkfCX8niPq1AHXEKx/peRUCFjmigdqUNfygQe1flJOT5em2sG4UZ6/X0xHjP1h1tXvmE1pwMoZuCf/vcgYl0brsme3Zvlfi6Vwuo/9mr+24jGq76Gdjpu+6SZxbzpjiEba1rv6SjYfKekaBEQkjEFvSIrEe/FcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328118; c=relaxed/simple;
	bh=wX45i5cVJBTC+X6yc8kDxe8NtXGu5vVJfm5UJCpCPiQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jRdlQpRuLxk76A+zDLEHFTl3E3vttVSmBYvwdmIej/K8ZOvENzn1A9j8L63fN3otdu2vl4ed8k819ckphdt4ndcvGyG6rAqQDcExtZjJAeXpqhS+q8svuoeGpErjfps9QbNRuKZao4Sckh7q5Dnzdh31ON+6aa2lUIJpv2ObONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExeDLLAh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExeDLLAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776328116; x=1807864116;
  h=date:from:to:cc:subject:message-id;
  bh=wX45i5cVJBTC+X6yc8kDxe8NtXGu5vVJfm5UJCpCPiQ=;
  b=ExeDLLAhCorCHrs5feWd/PIUeRkTDhLbZFSVduG69dDB52ZfnNdsP8Bh
   DM+oSMiJf7HJhTVdch8qYlHuqkV3XzBwNUIO6LTOWFxVdtiSfmAyGFnRO
   xU2Hdot6ZHTiMPhbSmd3XWnKh+W4PZoq6BLPxVLRPIxWVsve4YOZ8q8CC
   W8ENz+xOUPD013d5gev6uGYSZpYJbDzS6Wylriyx4JzzYHZ3fWg0jRk8L
   GjvJO+etTlc+NTEMsQhSFVkhw3VdNMlVMon+e9zEya4ajsEFNT3n2J00Y
   uQlcdxZDakATteS+Ie4Z+PUkUrdNbsSPtoZhoVeZajDUuPgSYj6D0s73m
   g==;
X-CSE-ConnectionGUID: Ix48ICYoRySq3kboQES61A==
X-CSE-MsgGUID: anu8QNtoR+y7vdvKWvXcPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76353182"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76353182"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:28:35 -0700
X-CSE-ConnectionGUID: tonWXPrASieI0PyTJ0SYyA==
X-CSE-MsgGUID: LjlgJlYOS0+ZpQy0PC/RDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="226336769"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Apr 2026 01:28:34 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDI5P-000000001P0-2gWP;
	Thu, 16 Apr 2026 08:28:31 +0000
Date: Thu, 16 Apr 2026 16:28:10 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 6c724ce0ec6ed8608917673bbb363b208ce2644c
Message-ID: <202604161601.mFyv4jbn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 6c724ce0ec6ed8608917673bbb363b208ce2644c  Merge branch 'for-7.1/cxl-misc' into cxl-for-next

elapsed time: 726m

configs tested: 238
configs skipped: 3

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
arc                   randconfig-001-20260416    gcc-14.3.0
arc                   randconfig-002-20260416    gcc-10.5.0
arc                   randconfig-002-20260416    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260416    clang-23
arm                   randconfig-001-20260416    gcc-14.3.0
arm                   randconfig-002-20260416    gcc-14.3.0
arm                   randconfig-002-20260416    gcc-8.5.0
arm                   randconfig-003-20260416    gcc-14.3.0
arm                   randconfig-003-20260416    gcc-8.5.0
arm                   randconfig-004-20260416    gcc-11.5.0
arm                   randconfig-004-20260416    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260416    gcc-8.5.0
arm64                 randconfig-002-20260416    gcc-10.5.0
arm64                 randconfig-002-20260416    gcc-8.5.0
arm64                 randconfig-003-20260416    clang-23
arm64                 randconfig-003-20260416    gcc-8.5.0
arm64                 randconfig-004-20260416    clang-16
arm64                 randconfig-004-20260416    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260416    gcc-14.3.0
csky                  randconfig-001-20260416    gcc-8.5.0
csky                  randconfig-002-20260416    gcc-14.3.0
csky                  randconfig-002-20260416    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260416    clang-23
hexagon               randconfig-001-20260416    gcc-15.2.0
hexagon               randconfig-002-20260416    clang-23
hexagon               randconfig-002-20260416    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260416    gcc-14
i386        buildonly-randconfig-002-20260416    gcc-12
i386        buildonly-randconfig-003-20260416    clang-20
i386        buildonly-randconfig-004-20260416    clang-20
i386        buildonly-randconfig-005-20260416    clang-20
i386        buildonly-randconfig-006-20260416    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260416    gcc-14
i386                  randconfig-002-20260416    clang-20
i386                  randconfig-002-20260416    gcc-14
i386                  randconfig-003-20260416    clang-20
i386                  randconfig-003-20260416    gcc-14
i386                  randconfig-004-20260416    clang-20
i386                  randconfig-004-20260416    gcc-14
i386                  randconfig-005-20260416    clang-20
i386                  randconfig-005-20260416    gcc-14
i386                  randconfig-006-20260416    clang-20
i386                  randconfig-006-20260416    gcc-14
i386                  randconfig-007-20260416    gcc-14
i386                  randconfig-011-20260416    gcc-14
i386                  randconfig-012-20260416    gcc-14
i386                  randconfig-013-20260416    clang-20
i386                  randconfig-014-20260416    clang-20
i386                  randconfig-015-20260416    clang-20
i386                  randconfig-016-20260416    clang-20
i386                  randconfig-017-20260416    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260416    gcc-15.2.0
loongarch             randconfig-002-20260416    gcc-15.2.0
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
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260416    gcc-15.2.0
nios2                 randconfig-001-20260416    gcc-8.5.0
nios2                 randconfig-002-20260416    gcc-15.2.0
nios2                 randconfig-002-20260416    gcc-8.5.0
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
parisc                randconfig-001-20260416    gcc-10.5.0
parisc                randconfig-001-20260416    gcc-8.5.0
parisc                randconfig-002-20260416    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20260416    clang-23
powerpc               randconfig-001-20260416    gcc-8.5.0
powerpc               randconfig-002-20260416    gcc-8.5.0
powerpc64             randconfig-001-20260416    clang-16
powerpc64             randconfig-001-20260416    gcc-8.5.0
powerpc64             randconfig-002-20260416    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260416    clang-23
riscv                 randconfig-001-20260416    gcc-11.5.0
riscv                 randconfig-002-20260416    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260416    clang-23
s390                  randconfig-002-20260416    clang-20
s390                  randconfig-002-20260416    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260416    clang-23
sh                    randconfig-001-20260416    gcc-9.5.0
sh                    randconfig-002-20260416    clang-23
sh                    randconfig-002-20260416    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260416    clang-23
sparc                 randconfig-001-20260416    gcc-15.2.0
sparc                 randconfig-002-20260416    clang-23
sparc                 randconfig-002-20260416    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260416    clang-23
sparc64               randconfig-002-20260416    clang-23
sparc64               randconfig-002-20260416    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260416    clang-23
um                    randconfig-002-20260416    clang-23
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260416    gcc-12
x86_64      buildonly-randconfig-002-20260416    gcc-14
x86_64      buildonly-randconfig-003-20260416    clang-20
x86_64      buildonly-randconfig-004-20260416    gcc-14
x86_64      buildonly-randconfig-005-20260416    clang-20
x86_64      buildonly-randconfig-006-20260416    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260416    gcc-13
x86_64                randconfig-002-20260416    gcc-14
x86_64                randconfig-003-20260416    clang-20
x86_64                randconfig-004-20260416    clang-20
x86_64                randconfig-005-20260416    gcc-14
x86_64                randconfig-006-20260416    gcc-14
x86_64                randconfig-011-20260416    clang-20
x86_64                randconfig-011-20260416    gcc-12
x86_64                randconfig-012-20260416    gcc-12
x86_64                randconfig-012-20260416    gcc-14
x86_64                randconfig-013-20260416    gcc-12
x86_64                randconfig-013-20260416    gcc-14
x86_64                randconfig-014-20260416    gcc-12
x86_64                randconfig-015-20260416    clang-20
x86_64                randconfig-015-20260416    gcc-12
x86_64                randconfig-016-20260416    gcc-12
x86_64                randconfig-071-20260416    gcc-14
x86_64                randconfig-072-20260416    gcc-14
x86_64                randconfig-073-20260416    gcc-14
x86_64                randconfig-074-20260416    clang-20
x86_64                randconfig-075-20260416    clang-20
x86_64                randconfig-076-20260416    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260416    clang-23
xtensa                randconfig-001-20260416    gcc-11.5.0
xtensa                randconfig-002-20260416    clang-23
xtensa                randconfig-002-20260416    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
