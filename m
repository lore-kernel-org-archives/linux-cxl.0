Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E632E12E
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476486; cv=none; b=EpbYDQuDkhViuXxqtKHFLKvg4VyE7Gc+WdDavg6DrITS2/tOTIImOxZ5mjIVp8dCtOWejwS0CeU4k0PliljXgseak/DGwVsS2rS1Yt+VciL6SBEauls7WCu0SqPzPGDBjk3zz5WZUXGlJ+Pzb2SdMhtcO8i3mZGdPb+zaYKMj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476486; c=relaxed/simple;
	bh=jt9Q8ovP1nyZeNYoCHFsjNVtWiAGXmuIuPgqIp202RY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DBwny20kpMF1swOnfYbPru8xTZ9R0T2F9yMVY7w0uLNJaRKyTwiT1VF3GiY5hTxhvrvbhfQwxrIVongdXWLNDCz+kfB/duIckQ7tbVwcixHPi06Ryb0ZPudUKnmTVPFBiPnSldsKAcaBOjblqFB0QIfJ4aQimq2/ztZepORbbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9FSMKh2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9FSMKh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476484; x=1815012484;
  h=date:from:to:cc:subject:message-id;
  bh=jt9Q8ovP1nyZeNYoCHFsjNVtWiAGXmuIuPgqIp202RY=;
  b=e9FSMKh2w5WjTo/sG0GYTQRgntA0U0edAPC/SRNoGvVmuaBjgXLjA0cO
   VIX/gGJF87Awpy8l9mX3arZhZdrthO9QXjHrIapVFIbQLxJHp8Ih2EV8l
   U9NEpZ3wIMpJCKzsQ4fbMT6eyczeB0EdVpuzVKx3ajHnz236tRXEIv3iE
   k0Yu7Un8RkWiitXjqtfvFUPw7u3eVNMh01D1xf2zUg1Uyqf6ejT0AI+4F
   T3DHtgPvxMTddqAEy71Ly7RvQ8SNfQNWDUCEyzguFD/VTrfe8DeEdS7Av
   UQOEt0e6T8rFudUGrz3vR9qrLVqAxXUkD2Eb5rjeEBhKax7toUQoPndwt
   A==;
X-CSE-ConnectionGUID: pqjn7yxgSKC36lxBckt63g==
X-CSE-MsgGUID: sSZYG6rxSh2p5fxo31G8Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95510702"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95510702"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:08:03 -0700
X-CSE-ConnectionGUID: SnZPm5q1SVW4oQDF/xx/XQ==
X-CSE-MsgGUID: GTP33g4rRJCPN8Bd60h0Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254804104"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 07 Jul 2026 19:08:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whHhd-00000000FuV-133P;
	Wed, 08 Jul 2026 02:07:57 +0000
Date: Wed, 08 Jul 2026 10:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 31adec5c3dc489966e6061cbe427dddb81d2e6b5
Message-ID: <202607081005.nsLojOZB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 31adec5c3dc489966e6061cbe427dddb81d2e6b5  Merge branch 'for-7.3/cxl-fixes' into cxl-for-next

elapsed time: 1455m

configs tested: 317
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260707    gcc-14.3.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-002-20260707    gcc-12.5.0
arc                   randconfig-002-20260708    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260707    gcc-8.5.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-002-20260707    clang-17
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-003-20260707    clang-17
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-004-20260707    clang-23
arm                   randconfig-004-20260708    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260707    clang-23
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                 randconfig-002-20260707    clang-18
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                 randconfig-003-20260707    clang-23
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                 randconfig-004-20260707    clang-17
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260707    gcc-16.1.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                  randconfig-002-20260707    gcc-16.1.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260707    clang-18
hexagon               randconfig-001-20260707    clang-23
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260707    clang-18
hexagon               randconfig-002-20260708    gcc-13.4.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260707    clang-22
i386        buildonly-randconfig-001-20260708    clang-22
i386        buildonly-randconfig-002-20260707    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386        buildonly-randconfig-003-20260707    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386        buildonly-randconfig-004-20260707    clang-22
i386        buildonly-randconfig-004-20260707    gcc-14
i386        buildonly-randconfig-004-20260708    clang-22
i386        buildonly-randconfig-005-20260707    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386        buildonly-randconfig-006-20260707    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260707    gcc-13
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260707    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260707    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260707    gcc-14
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260707    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260707    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260707    clang-22
i386                  randconfig-007-20260708    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260707    gcc-14
i386                  randconfig-011-20260708    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260707    gcc-14
i386                  randconfig-012-20260708    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260707    clang-22
i386                  randconfig-013-20260707    gcc-14
i386                  randconfig-013-20260708    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260707    gcc-14
i386                  randconfig-014-20260708    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260707    gcc-14
i386                  randconfig-015-20260708    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260707    gcc-14
i386                  randconfig-016-20260708    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260707    gcc-14
i386                  randconfig-017-20260708    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260707    clang-18
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260707    clang-18
loongarch             randconfig-002-20260707    clang-19
loongarch             randconfig-002-20260708    gcc-13.4.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260707    clang-18
nios2                 randconfig-001-20260707    gcc-11.5.0
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260707    clang-18
nios2                 randconfig-002-20260707    gcc-11.5.0
nios2                 randconfig-002-20260708    gcc-13.4.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260707    clang-22
parisc                randconfig-001-20260707    gcc-15.2.0
parisc                randconfig-001-20260708    clang-22
parisc                randconfig-002-20260707    clang-22
parisc                randconfig-002-20260707    gcc-9.5.0
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      bamboo_defconfig    clang-21
powerpc               randconfig-001-20260707    clang-22
powerpc               randconfig-001-20260707    clang-23
powerpc               randconfig-001-20260708    clang-22
powerpc               randconfig-002-20260707    clang-22
powerpc               randconfig-002-20260707    gcc-14.3.0
powerpc               randconfig-002-20260708    clang-22
powerpc64             randconfig-001-20260707    clang-22
powerpc64             randconfig-001-20260707    gcc-8.5.0
powerpc64             randconfig-001-20260708    clang-22
powerpc64             randconfig-002-20260707    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260707    gcc-14.3.0
riscv                 randconfig-001-20260708    clang-23
riscv                 randconfig-002-20260707    gcc-8.5.0
riscv                 randconfig-002-20260708    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260707    clang-21
s390                  randconfig-001-20260708    clang-23
s390                  randconfig-002-20260707    gcc-13.4.0
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260707    gcc-16.1.0
sh                    randconfig-001-20260708    clang-23
sh                    randconfig-002-20260707    gcc-16.1.0
sh                    randconfig-002-20260708    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260707    gcc-13.4.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-002-20260707    gcc-15.2.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260707    gcc-8.5.0
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-002-20260707    clang-23
sparc64               randconfig-002-20260708    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260707    clang-18
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-002-20260707    clang-23
um                    randconfig-002-20260708    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260707    clang-22
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64      buildonly-randconfig-002-20260707    clang-22
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64      buildonly-randconfig-003-20260707    clang-22
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64      buildonly-randconfig-004-20260707    clang-22
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64      buildonly-randconfig-005-20260707    clang-22
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64      buildonly-randconfig-006-20260707    clang-22
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260707    clang-22
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-002-20260707    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-003-20260707    clang-22
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-004-20260707    clang-22
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-005-20260707    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-006-20260707    gcc-12
x86_64                randconfig-006-20260708    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260707    clang-22
x86_64                randconfig-011-20260708    clang-22
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260707    clang-22
x86_64                randconfig-012-20260707    gcc-14
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260707    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260707    clang-22
x86_64                randconfig-014-20260707    gcc-14
x86_64                randconfig-014-20260708    clang-22
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260707    clang-22
x86_64                randconfig-015-20260707    gcc-14
x86_64                randconfig-015-20260708    clang-22
x86_64                randconfig-016-20260707    clang-22
x86_64                randconfig-016-20260708    clang-22
x86_64                randconfig-071-20260707    clang-22
x86_64                randconfig-071-20260708    clang-22
x86_64                randconfig-072-20260707    clang-22
x86_64                randconfig-072-20260708    clang-22
x86_64                randconfig-073-20260707    clang-22
x86_64                randconfig-073-20260708    clang-22
x86_64                randconfig-074-20260707    clang-22
x86_64                randconfig-074-20260708    clang-22
x86_64                randconfig-075-20260707    clang-22
x86_64                randconfig-075-20260708    clang-22
x86_64                randconfig-076-20260707    gcc-14
x86_64                randconfig-076-20260708    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260707    gcc-8.5.0
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-002-20260707    gcc-11.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
