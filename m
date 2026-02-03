Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E338E13C
	for <linux-cxl@vger.kernel.org>; Tue,  3 Feb 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110462; cv=none; b=uobiAjH95F/g8rVeM3+JDAFmlspgJBDN4DszxIq8HQr/+6Ve0zZNmP1vprLGEz9XbRA+F/GQJ7NjCVZ+5YAxqkPu0WNc3zuwZ03a7dhyFQsdMN0S+8c6wyl8RwBW+yuhZfy1qzU5GmU26qlUf5WK8lcD7Z6wUNtEjK9Yg3Vmjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110462; c=relaxed/simple;
	bh=3OcpGo1aDN1eH487QpVqWSXTk8XhXv7oa2VKKlXC6IQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IqjdZadpSba4m0w0JsVflEVP39/R0cfe1SK0US/Y7yyGDyuOZt2KWi8gckPbNRv7jgkakIk9gv4bUbn5eKdK83dN0bEOuUwjXI77lHixUkJJ4XoLYVTiwddO83xV2Jz4U4+3ILdBjVC93YLHE2myF8jC/S4gkMHna0WafEYNtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMUjMdMm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMUjMdMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770110461; x=1801646461;
  h=date:from:to:cc:subject:message-id;
  bh=3OcpGo1aDN1eH487QpVqWSXTk8XhXv7oa2VKKlXC6IQ=;
  b=JMUjMdMmxdW/Rric2zBL2HCPARdsqwAG4P+aqU9b2hZbjHTycsrA7ajg
   e2sOVT2NaZPROqy2O7bUVyeRCkw5oMN+Md8j+acv1p4nFpw+DEGT3Rlgh
   UOXZeLfcICX8UEyg+EqrvgvmlGoNcxIbl9Ke9uJ4Kjquv5DUCkHKex3M7
   3tiR4AK45QVi2ukC/kPhuz41yWra9jrr0wvQbuGz2PZKip65VWSi/qx05
   D42k0KheYgfO2JvzzVPwmn+A2WpKKMArXjWA78FaTl+1OBLDLJ52VeBy6
   z2VcRuClwfZEzOrERn6P4KWI++uS8CJ7LiD6P3FyENu+0FS7jH6JpIeJ9
   g==;
X-CSE-ConnectionGUID: u70fAiL/QT2XsYvspwrB8w==
X-CSE-MsgGUID: oPwWQ2LTQRi9F2msu1glmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88698359"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88698359"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:21:00 -0800
X-CSE-ConnectionGUID: MKVBp3j+QyWngKZQYkhn5g==
X-CSE-MsgGUID: Tdd6oeJSQuKnTjcBD7jY7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209807585"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Feb 2026 01:20:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnCad-00000000gUi-31F2;
	Tue, 03 Feb 2026 09:20:55 +0000
Date: Tue, 03 Feb 2026 17:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 0da3050bdded5f121aaca6b5247ea50681d7129e
Message-ID: <202602031731.IFGxVJoF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 0da3050bdded5f121aaca6b5247ea50681d7129e  Merge branch 'for-7.0/cxl-aer-prep' into cxl-for-next

elapsed time: 794m

configs tested: 279
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
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-001-20260203    gcc-8.5.0
arc                   randconfig-002-20260203    gcc-12.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-001-20260203    gcc-8.5.0
arm                   randconfig-002-20260203    clang-18
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-003-20260203    gcc-10.5.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-004-20260203    clang-16
arm                   randconfig-004-20260203    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260203    gcc-15.2.0
arm64                 randconfig-001-20260203    gcc-9.5.0
arm64                 randconfig-002-20260203    gcc-12.5.0
arm64                 randconfig-002-20260203    gcc-15.2.0
arm64                 randconfig-003-20260203    clang-22
arm64                 randconfig-003-20260203    gcc-15.2.0
arm64                 randconfig-004-20260203    clang-22
arm64                 randconfig-004-20260203    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260203    gcc-15.2.0
csky                  randconfig-002-20260203    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260203    clang-22
hexagon               randconfig-002-20260203    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260203    clang-20
i386        buildonly-randconfig-001-20260203    gcc-14
i386        buildonly-randconfig-002-20260203    clang-20
i386        buildonly-randconfig-002-20260203    gcc-13
i386        buildonly-randconfig-003-20260203    clang-20
i386        buildonly-randconfig-004-20260203    clang-20
i386        buildonly-randconfig-005-20260203    clang-20
i386        buildonly-randconfig-006-20260203    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260203    clang-20
i386                  randconfig-002-20260203    clang-20
i386                  randconfig-003-20260203    clang-20
i386                  randconfig-004-20260203    clang-20
i386                  randconfig-005-20260203    clang-20
i386                  randconfig-005-20260203    gcc-14
i386                  randconfig-006-20260203    clang-20
i386                  randconfig-007-20260203    clang-20
i386                  randconfig-007-20260203    gcc-14
i386                  randconfig-011-20260203    gcc-12
i386                  randconfig-011-20260203    gcc-14
i386                  randconfig-012-20260203    clang-20
i386                  randconfig-012-20260203    gcc-14
i386                  randconfig-013-20260203    clang-20
i386                  randconfig-013-20260203    gcc-14
i386                  randconfig-014-20260203    gcc-14
i386                  randconfig-015-20260203    clang-20
i386                  randconfig-015-20260203    gcc-14
i386                  randconfig-016-20260203    gcc-14
i386                  randconfig-017-20260203    clang-20
i386                  randconfig-017-20260203    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260203    clang-20
loongarch             randconfig-001-20260203    clang-22
loongarch             randconfig-002-20260203    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                     cu1830-neo_defconfig    clang-22
mips                           ip32_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-22
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260203    clang-22
nios2                 randconfig-001-20260203    gcc-8.5.0
nios2                 randconfig-002-20260203    clang-22
nios2                 randconfig-002-20260203    gcc-8.5.0
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
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260203    gcc-12.5.0
parisc                randconfig-002-20260203    gcc-12.5.0
parisc                randconfig-002-20260203    gcc-8.5.0
parisc64                         alldefconfig    gcc-15.2.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20260203    clang-22
powerpc               randconfig-001-20260203    gcc-12.5.0
powerpc               randconfig-002-20260203    gcc-10.5.0
powerpc               randconfig-002-20260203    gcc-12.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20260203    clang-16
powerpc64             randconfig-001-20260203    gcc-12.5.0
powerpc64             randconfig-002-20260203    gcc-12.5.0
powerpc64             randconfig-002-20260203    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260203    clang-22
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-002-20260203    clang-22
riscv                 randconfig-002-20260203    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-002-20260203    clang-22
s390                  randconfig-002-20260203    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-002-20260203    gcc-15.2.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                   sh7770_generic_defconfig    clang-22
sh                  sh7785lcr_32bit_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260203    gcc-13.4.0
sparc                 randconfig-001-20260203    gcc-8.5.0
sparc                 randconfig-002-20260203    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260203    clang-22
sparc64               randconfig-001-20260203    gcc-13.4.0
sparc64               randconfig-002-20260203    clang-22
sparc64               randconfig-002-20260203    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260203    clang-22
um                    randconfig-001-20260203    gcc-13.4.0
um                    randconfig-002-20260203    clang-20
um                    randconfig-002-20260203    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-004-20260203    gcc-14
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-005-20260203    gcc-13
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64      buildonly-randconfig-006-20260203    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260203    clang-20
x86_64                randconfig-002-20260203    clang-20
x86_64                randconfig-002-20260203    gcc-14
x86_64                randconfig-003-20260203    clang-20
x86_64                randconfig-004-20260203    clang-20
x86_64                randconfig-004-20260203    gcc-14
x86_64                randconfig-005-20260203    clang-20
x86_64                randconfig-005-20260203    gcc-12
x86_64                randconfig-006-20260203    clang-20
x86_64                randconfig-006-20260203    gcc-14
x86_64                randconfig-011-20260203    gcc-14
x86_64                randconfig-012-20260203    clang-20
x86_64                randconfig-012-20260203    gcc-14
x86_64                randconfig-013-20260203    gcc-14
x86_64                randconfig-014-20260203    gcc-14
x86_64                randconfig-015-20260203    gcc-14
x86_64                randconfig-016-20260203    clang-20
x86_64                randconfig-016-20260203    gcc-14
x86_64                randconfig-071-20260203    clang-20
x86_64                randconfig-071-20260203    gcc-14
x86_64                randconfig-072-20260203    gcc-13
x86_64                randconfig-072-20260203    gcc-14
x86_64                randconfig-073-20260203    gcc-14
x86_64                randconfig-074-20260203    gcc-14
x86_64                randconfig-075-20260203    gcc-13
x86_64                randconfig-075-20260203    gcc-14
x86_64                randconfig-076-20260203    gcc-14
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
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260203    gcc-13.4.0
xtensa                randconfig-001-20260203    gcc-14.3.0
xtensa                randconfig-002-20260203    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
