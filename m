Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C9205E23
	for <linux-cxl@vger.kernel.org>; Sat, 22 Feb 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214795; cv=none; b=Q9PTHTyYcIcpva2jhxIv2dd5t/+bWcz00t42WgKqlURFgypaGFV49oQpfoqs8ECxRFe8X01fqaPK1UrfZEs1ZkO7PTLJzGWJXt54lsrYeJr87hBmko+1yqqdJhyZZ/9ho/fj33MzNBcy0NKYiNprwg2eK7V57i3UPxfipKDlUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214795; c=relaxed/simple;
	bh=rvVqI0ZW9LUQOGkcxXewumjJDp/B82saceodp/rVJt4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=js3gTOVAmMilB8reKE8dNQAIqY311B+5zs+796z5/czHYUI8UijzIJWuzXnyEwUkBScjhYAKtbKiqqbqp1g2A/RwMF+VWQcU02epi/8doqpyzh2lKK7umLc1uPosuscIW2JAU71YT6N4f74k+KORVvTarOKb2JErnQsdqgy0+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAwWSCFs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAwWSCFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740214793; x=1771750793;
  h=date:from:to:cc:subject:message-id;
  bh=rvVqI0ZW9LUQOGkcxXewumjJDp/B82saceodp/rVJt4=;
  b=oAwWSCFs9WXqUYQ6hKrfxm98hbHBSfLOoWkSVSGhtpX6lb86NQ+awMy+
   Aw5vM+cXDBnAaQNmLionnWr5wtKT8ThFlsjGzogGKLqDWMU6eQVlH2k/B
   zJfepyRWW5NEfF0ul3GVyXSQ8rzY9wpAuBdnJgEOxY03U8EQQELweVcOU
   5utsrPVz9DIRmWjKeOTYWa5e8dYBRBW6mI2aOqG+zotCjb47oZ3kpjMZW
   W4xNlUF/oVGfhPiuPvACAk7txBeyrA5RCxZNgAPuEpw/Xozy/YeKz3cmi
   0Aiv3sX3X+Euj8NEbphJgoNr3QHWLI8TImSJndEp5MOBOO/Wo53iXkO/6
   A==;
X-CSE-ConnectionGUID: Ygy/RECDQIKXyGBcaE/+Zg==
X-CSE-MsgGUID: pYboaZV6Sq2uhHQGO5C+xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58582140"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="58582140"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 00:59:51 -0800
X-CSE-ConnectionGUID: xs83OuB2QRKbifvAkc/tPQ==
X-CSE-MsgGUID: wyQPuGzDSUK09Rx9lMkbyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="115393772"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2025 00:59:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tllMR-0006Q7-38;
	Sat, 22 Feb 2025 08:59:47 +0000
Date: Sat, 22 Feb 2025 16:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 2bb67004903cfd35710750654669a77e7223fcd1
Message-ID: <202502221644.UwiOc1Tp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 2bb67004903cfd35710750654669a77e7223fcd1  tools/testing/cxl: Set Shutdown State support

elapsed time: 958m

configs tested: 138
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
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250222    gcc-13.2.0
arc                   randconfig-002-20250222    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                          gemini_defconfig    clang-21
arm                            mmp2_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20250222    gcc-14.2.0
arm                   randconfig-002-20250222    gcc-14.2.0
arm                   randconfig-003-20250222    clang-16
arm                   randconfig-004-20250222    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250222    gcc-14.2.0
arm64                 randconfig-002-20250222    clang-21
arm64                 randconfig-003-20250222    clang-18
arm64                 randconfig-004-20250222    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250222    gcc-14.2.0
csky                  randconfig-002-20250222    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250222    clang-17
hexagon               randconfig-002-20250222    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250222    clang-19
i386        buildonly-randconfig-002-20250222    gcc-12
i386        buildonly-randconfig-003-20250222    gcc-12
i386        buildonly-randconfig-004-20250222    clang-19
i386        buildonly-randconfig-005-20250222    gcc-12
i386        buildonly-randconfig-006-20250222    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250222    gcc-14.2.0
loongarch             randconfig-002-20250222    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-21
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250222    gcc-14.2.0
nios2                 randconfig-002-20250222    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250222    gcc-14.2.0
parisc                randconfig-002-20250222    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                  mpc885_ads_defconfig    clang-18
powerpc               randconfig-001-20250222    gcc-14.2.0
powerpc               randconfig-002-20250222    gcc-14.2.0
powerpc               randconfig-003-20250222    gcc-14.2.0
powerpc64             randconfig-001-20250222    gcc-14.2.0
powerpc64             randconfig-002-20250222    clang-16
powerpc64             randconfig-003-20250222    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250222    clang-21
riscv                 randconfig-002-20250222    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250222    gcc-14.2.0
s390                  randconfig-002-20250222    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250222    gcc-14.2.0
sh                    randconfig-002-20250222    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250222    gcc-14.2.0
sparc                 randconfig-002-20250222    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250222    gcc-14.2.0
sparc64               randconfig-002-20250222    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250222    gcc-12
um                    randconfig-002-20250222    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250222    clang-19
x86_64      buildonly-randconfig-002-20250222    gcc-12
x86_64      buildonly-randconfig-003-20250222    gcc-12
x86_64      buildonly-randconfig-004-20250222    clang-19
x86_64      buildonly-randconfig-005-20250222    clang-19
x86_64      buildonly-randconfig-006-20250222    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250222    gcc-14.2.0
xtensa                randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
