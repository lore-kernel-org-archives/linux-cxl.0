Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FB86329
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773807807; cv=none; b=GsA+95Lr1h0CDQ0vC2tZU04Z9+ZnhAWnEY1aMmf3l9D/rgwjLa3TMvyy6I5QKR/hx9WJOhvPn6AWcTMg27IKR2v7oBsWs4NA1WcVKBQCGG93L4xZehNBv7Z18P+O44VYigToYDIFexOmrG3lJoEZBNogTIRFMbEMSSnLHyAyhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773807807; c=relaxed/simple;
	bh=vEdn4UFOXwej1F4X91kBecMxo3jZVR2dR7+NeO/8TcM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YrqxoDLDDYOroXW5ETPTln+Gj+s/oMVE8WrzYbYWlPZ9rEXEjuDTtSkslfsCPFCvaDiJ8IIxReBRzQsX7WiZiLJ2yXBMU7UVAL/P76ZllViNIdxuIviLxrDjBvwxMFk/kMmjCMZ10NGnjC88tfekXjdOuipSyLxN8X7087aih3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPaqQ0yM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPaqQ0yM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773807806; x=1805343806;
  h=date:from:to:cc:subject:message-id;
  bh=vEdn4UFOXwej1F4X91kBecMxo3jZVR2dR7+NeO/8TcM=;
  b=mPaqQ0yMtdBPj5gwWweYJMoEjIJfMub39bVRTB7EkAt/tqcPhedPLVdX
   rt9TVuvQ/k9HV4xBKjXPkgIY9LP/UVUBAEDgj/qfdXHnLKwyVlA2wsD/B
   QklzJvukml3/PqUTjKuaz8VeXmjMtd9rk6X/Xce8Q9xI6nbW53k6phiNu
   IYcjoQ0WFXmjPAvCtWfEwKteS86HbApyXU5/4hRn1cFDxbys45/JIAYCP
   fC/gLGPoC6qsT9p3Fp4CSEC7jhXy8kkdUAN+M4jA/RAkUheuKkmsz8H63
   6JeybrnFsIkzwsGqsLvfmJDC/wxI7wxeuykfRyqJhMYZlic2tkxmzvcn0
   w==;
X-CSE-ConnectionGUID: ahoVH4WMTuOiwefOEbbGYg==
X-CSE-MsgGUID: 9Thqa4zvQ7ClzSfOaJPrHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100315945"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="100315945"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 21:23:25 -0700
X-CSE-ConnectionGUID: 9P2t/xRzRkqBtvkbk9xE5w==
X-CSE-MsgGUID: RXFR2N3KTJ6VNSaPHe/UIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222534151"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Mar 2026 21:23:23 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2iRE-000000002VF-1P9S;
	Wed, 18 Mar 2026 04:23:20 +0000
Date: Wed, 18 Mar 2026 12:23:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 d5f9bfc37906bbb737790af11f1537593f8778a5
Message-ID: <202603181209.LCv5sA6f-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: d5f9bfc37906bbb737790af11f1537593f8778a5  Merge branch 'for-7.1/cxl-type2-support' into cxl-for-next

elapsed time: 792m

configs tested: 281
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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260317    gcc-9.5.0
arc                   randconfig-001-20260318    gcc-8.5.0
arc                   randconfig-002-20260317    gcc-13.4.0
arc                   randconfig-002-20260318    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                   randconfig-001-20260317    clang-23
arm                   randconfig-001-20260318    gcc-8.5.0
arm                   randconfig-002-20260317    clang-23
arm                   randconfig-002-20260318    gcc-8.5.0
arm                   randconfig-003-20260317    clang-23
arm                   randconfig-003-20260318    gcc-8.5.0
arm                   randconfig-004-20260317    clang-23
arm                   randconfig-004-20260318    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260318    clang-23
arm64                 randconfig-001-20260318    gcc-8.5.0
arm64                 randconfig-002-20260318    clang-23
arm64                 randconfig-002-20260318    gcc-15.2.0
arm64                 randconfig-003-20260318    clang-23
arm64                 randconfig-004-20260318    clang-23
arm64                 randconfig-004-20260318    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260318    clang-23
csky                  randconfig-001-20260318    gcc-13.4.0
csky                  randconfig-002-20260318    clang-23
csky                  randconfig-002-20260318    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260317    clang-23
hexagon               randconfig-001-20260318    gcc-8.5.0
hexagon               randconfig-002-20260317    clang-23
hexagon               randconfig-002-20260318    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260318    clang-20
i386        buildonly-randconfig-001-20260318    gcc-14
i386        buildonly-randconfig-002-20260318    gcc-14
i386        buildonly-randconfig-003-20260318    clang-20
i386        buildonly-randconfig-003-20260318    gcc-14
i386        buildonly-randconfig-004-20260318    gcc-14
i386        buildonly-randconfig-005-20260318    gcc-14
i386        buildonly-randconfig-006-20260318    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260317    gcc-14
i386                  randconfig-001-20260318    gcc-14
i386                  randconfig-002-20260317    clang-20
i386                  randconfig-002-20260318    gcc-14
i386                  randconfig-003-20260317    gcc-14
i386                  randconfig-003-20260318    gcc-14
i386                  randconfig-004-20260317    gcc-14
i386                  randconfig-004-20260318    gcc-14
i386                  randconfig-005-20260317    gcc-14
i386                  randconfig-005-20260318    gcc-14
i386                  randconfig-006-20260317    gcc-14
i386                  randconfig-006-20260318    gcc-14
i386                  randconfig-007-20260317    clang-20
i386                  randconfig-007-20260318    gcc-14
i386                  randconfig-011-20260317    gcc-14
i386                  randconfig-011-20260318    clang-20
i386                  randconfig-012-20260317    gcc-14
i386                  randconfig-012-20260318    clang-20
i386                  randconfig-013-20260317    gcc-14
i386                  randconfig-013-20260318    clang-20
i386                  randconfig-014-20260317    clang-20
i386                  randconfig-014-20260318    clang-20
i386                  randconfig-015-20260317    clang-20
i386                  randconfig-015-20260318    clang-20
i386                  randconfig-016-20260317    gcc-14
i386                  randconfig-016-20260318    clang-20
i386                  randconfig-017-20260317    clang-20
i386                  randconfig-017-20260318    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260317    clang-23
loongarch             randconfig-001-20260318    gcc-8.5.0
loongarch             randconfig-002-20260317    clang-18
loongarch             randconfig-002-20260318    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    gcc-15.2.0
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
nios2                 randconfig-001-20260317    gcc-8.5.0
nios2                 randconfig-001-20260318    gcc-8.5.0
nios2                 randconfig-002-20260317    gcc-11.5.0
nios2                 randconfig-002-20260318    gcc-8.5.0
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
parisc                randconfig-001-20260317    gcc-11.5.0
parisc                randconfig-001-20260318    gcc-11.5.0
parisc                randconfig-002-20260317    gcc-14.3.0
parisc                randconfig-002-20260318    gcc-11.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260317    gcc-8.5.0
powerpc               randconfig-001-20260318    gcc-11.5.0
powerpc               randconfig-002-20260317    clang-23
powerpc               randconfig-002-20260318    gcc-11.5.0
powerpc64             randconfig-001-20260317    gcc-8.5.0
powerpc64             randconfig-001-20260318    gcc-11.5.0
powerpc64             randconfig-002-20260317    clang-23
powerpc64             randconfig-002-20260318    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260317    clang-23
riscv                 randconfig-001-20260318    gcc-15.2.0
riscv                 randconfig-002-20260317    gcc-8.5.0
riscv                 randconfig-002-20260318    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260317    gcc-15.2.0
s390                  randconfig-001-20260318    gcc-15.2.0
s390                  randconfig-002-20260317    clang-23
s390                  randconfig-002-20260318    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260317    gcc-15.2.0
sh                    randconfig-001-20260318    gcc-15.2.0
sh                    randconfig-002-20260317    gcc-10.5.0
sh                    randconfig-002-20260318    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260317    gcc-8.5.0
sparc                 randconfig-001-20260318    gcc-13.4.0
sparc                 randconfig-002-20260317    gcc-12.5.0
sparc                 randconfig-002-20260318    gcc-13.4.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260317    clang-23
sparc64               randconfig-001-20260318    gcc-13.4.0
sparc64               randconfig-002-20260317    gcc-12.5.0
sparc64               randconfig-002-20260318    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260317    clang-23
um                    randconfig-001-20260318    gcc-13.4.0
um                    randconfig-002-20260317    clang-23
um                    randconfig-002-20260318    gcc-13.4.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260318    gcc-14
x86_64      buildonly-randconfig-002-20260318    gcc-14
x86_64      buildonly-randconfig-003-20260318    gcc-14
x86_64      buildonly-randconfig-004-20260318    clang-20
x86_64      buildonly-randconfig-004-20260318    gcc-14
x86_64      buildonly-randconfig-005-20260318    clang-20
x86_64      buildonly-randconfig-005-20260318    gcc-14
x86_64      buildonly-randconfig-006-20260318    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260317    gcc-14
x86_64                randconfig-001-20260318    gcc-14
x86_64                randconfig-002-20260317    gcc-14
x86_64                randconfig-002-20260318    gcc-14
x86_64                randconfig-003-20260317    clang-20
x86_64                randconfig-003-20260318    gcc-14
x86_64                randconfig-004-20260317    clang-20
x86_64                randconfig-004-20260318    gcc-14
x86_64                randconfig-005-20260317    clang-20
x86_64                randconfig-005-20260318    gcc-14
x86_64                randconfig-006-20260317    gcc-14
x86_64                randconfig-006-20260318    gcc-14
x86_64                randconfig-011-20260317    gcc-14
x86_64                randconfig-011-20260318    clang-20
x86_64                randconfig-012-20260317    clang-20
x86_64                randconfig-012-20260318    clang-20
x86_64                randconfig-013-20260317    clang-20
x86_64                randconfig-013-20260318    clang-20
x86_64                randconfig-014-20260317    gcc-14
x86_64                randconfig-014-20260318    clang-20
x86_64                randconfig-015-20260317    clang-20
x86_64                randconfig-015-20260318    clang-20
x86_64                randconfig-016-20260317    clang-20
x86_64                randconfig-016-20260318    clang-20
x86_64                randconfig-071-20260317    clang-20
x86_64                randconfig-071-20260318    gcc-14
x86_64                randconfig-072-20260317    clang-20
x86_64                randconfig-072-20260318    gcc-14
x86_64                randconfig-073-20260317    clang-20
x86_64                randconfig-073-20260318    gcc-14
x86_64                randconfig-074-20260317    clang-20
x86_64                randconfig-074-20260318    gcc-14
x86_64                randconfig-075-20260317    clang-20
x86_64                randconfig-075-20260318    gcc-14
x86_64                randconfig-076-20260317    clang-20
x86_64                randconfig-076-20260318    gcc-14
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
xtensa                randconfig-001-20260317    gcc-9.5.0
xtensa                randconfig-001-20260318    gcc-13.4.0
xtensa                randconfig-002-20260317    gcc-11.5.0
xtensa                randconfig-002-20260318    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
