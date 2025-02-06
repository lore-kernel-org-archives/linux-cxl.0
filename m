Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394C21CFF4
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844481; cv=none; b=t0ArhL086Rd3oWKrkgIJ/Nw7D9Xk6T+I0YVaGv97AOI6bHb1CPCyEhRjk4hT3jncYsmKMZ1NkZ6tDXLAMiEnoBpmc2G3kJfH+ix7Hu3VCZrBNWwJBVlQLDz7WqlNHlGqoHVGnoY8iaOnrjiSgfRtSaMRBR6how3RS4FCzJ6cx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844481; c=relaxed/simple;
	bh=ZTrryqo0mKQoEr21GxQ0INpsXteJ9UF146RYSqzPTzk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Gj6V0yJ+gLWwYvt4OaQOhw6Pq+OCR+IUUGggqQnbSwyloOz2jc528Gk8JMQ/FFmNnciuBvFHeDDHm0tuyOAkNSPYi0+nM+PHQA/1VkipdOiaeGK/OouXsft+O/sjO8bgxS5GdQqJ6YTGdo7pzHOe05CWD/nvm/5nU/UeHmM8nL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB/DD/eC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB/DD/eC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738844479; x=1770380479;
  h=date:from:to:cc:subject:message-id;
  bh=ZTrryqo0mKQoEr21GxQ0INpsXteJ9UF146RYSqzPTzk=;
  b=RB/DD/eCATdsaZmA8PVrrR1Ke1pEHdWuMRtDSQCG2FwitHPH1FZCINv2
   9qYxnl7lbP9Zj1yHE4ZxgLfVJNlaLL1WeViYPdF6R1nzED/cm6HZAHvC7
   oZThTMEg85EzBGySmmjFjpeOD2iRP+jOnKoXnuhUqG6vTS2Dkoai0LKIM
   OV6rxFwXid0BsWkfuvqj4MROuoBlxojrJVeLy/S62DU/eQU4crYY8sQa4
   w7E67P60YQ8i9sLTHb37sCk3QqQUJP4aygUzRdFL1d6ARyVWhpRZ6z1BM
   tLlWSaOjJ4E6ydCwxXN/OkbYKqdKsedPQIiWEr0RhsC3HuJrbJFLanePU
   A==;
X-CSE-ConnectionGUID: scbsI//lSHyWLPVGdXBF7A==
X-CSE-MsgGUID: ftnPRrYnTWKOEccejXo8Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39600940"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39600940"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 04:21:18 -0800
X-CSE-ConnectionGUID: DabD7he0QrCS+KHJD7cGNw==
X-CSE-MsgGUID: lO9YLbTZSXqNVAqnVaQAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="142080197"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Feb 2025 04:21:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tg0sb-000wqd-2T;
	Thu, 06 Feb 2025 12:21:13 +0000
Date: Thu, 06 Feb 2025 20:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 43ca2463df9de2c192b03a0f4dc964e6ba7d7993
Message-ID: <202502062020.gb4E2pEu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 43ca2463df9de2c192b03a0f4dc964e6ba7d7993  cxl: Refactor user ioctl command path from mds to mailbox

elapsed time: 965m

configs tested: 139
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250206    gcc-13.2.0
arc                   randconfig-002-20250206    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                          gemini_defconfig    clang-21
arm                            mmp2_defconfig    gcc-14.2.0
arm                   randconfig-001-20250206    clang-21
arm                   randconfig-002-20250206    clang-19
arm                   randconfig-003-20250206    clang-21
arm                   randconfig-004-20250206    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250206    clang-21
arm64                 randconfig-002-20250206    clang-21
arm64                 randconfig-003-20250206    clang-15
arm64                 randconfig-004-20250206    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250206    gcc-14.2.0
csky                  randconfig-002-20250206    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250206    clang-21
hexagon               randconfig-002-20250206    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250206    clang-19
i386        buildonly-randconfig-002-20250206    gcc-12
i386        buildonly-randconfig-003-20250206    clang-19
i386        buildonly-randconfig-004-20250206    clang-19
i386        buildonly-randconfig-005-20250206    clang-19
i386        buildonly-randconfig-006-20250206    gcc-12
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250206    gcc-14.2.0
loongarch             randconfig-002-20250206    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                           mtx1_defconfig    clang-21
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250206    gcc-14.2.0
nios2                 randconfig-002-20250206    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250206    gcc-14.2.0
parisc                randconfig-002-20250206    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250206    clang-21
powerpc               randconfig-002-20250206    clang-19
powerpc               randconfig-003-20250206    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250206    clang-15
powerpc64             randconfig-002-20250206    clang-17
powerpc64             randconfig-003-20250206    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250206    clang-19
riscv                 randconfig-002-20250206    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250206    clang-21
s390                  randconfig-002-20250206    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250206    gcc-14.2.0
sh                    randconfig-002-20250206    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250206    gcc-14.2.0
sparc                 randconfig-002-20250206    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250206    gcc-14.2.0
sparc64               randconfig-002-20250206    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250206    clang-15
um                    randconfig-002-20250206    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250206    clang-19
x86_64      buildonly-randconfig-002-20250206    clang-19
x86_64      buildonly-randconfig-003-20250206    clang-19
x86_64      buildonly-randconfig-004-20250206    clang-19
x86_64      buildonly-randconfig-005-20250206    clang-19
x86_64      buildonly-randconfig-006-20250206    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250206    gcc-14.2.0
xtensa                randconfig-002-20250206    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
