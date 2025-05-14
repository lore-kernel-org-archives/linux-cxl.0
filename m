Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23EC8F0
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225870; cv=none; b=SXQG95XjDBihu5fO+h9M4s7zjS8o9XIxJpsK0BAZT/Y29Nj+dOIBDyr46SKKptCqaTB4O/8UlpdRO9txm1lSJ/WKeYeuKQT/DJ1NoW89e98KfpwKWVyvvjz651mgR/2nm+WUHa0wV2M+3/tobYQ/9Oa7be70iLor2Jnc3RhJASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225870; c=relaxed/simple;
	bh=snh9A+a73yr9qaEGAmEarFHA4LpYfkrKx05bJt2+osQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rgg/9sBqYPQkuLbLrW68uwTsReoWUuHOTqk+2GfAghdcDeBiHfgtR8VKHqmTOcDc7/7mH2Xd3AYhhkU4UaUXRmVdZDOx4KBjN98/3wT+qZI1g+j1bFRvpN4WicJaSH6zJQJrKtP9SmMIbsS3BJ0qjkaLAAMQ+LPZKB6Pey8Fvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTf1fle1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTf1fle1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747225869; x=1778761869;
  h=date:from:to:cc:subject:message-id;
  bh=snh9A+a73yr9qaEGAmEarFHA4LpYfkrKx05bJt2+osQ=;
  b=cTf1fle1wOQOmVyIUAWXAYnHxIcN6nrIsaReDXOIkow354oDzzps5abZ
   n1MDSOsTOKIg4az7aX0yD1NbOWPfm6SIfULQ4O7Sh/oPcR09HhK78Gmw9
   Y64iciNhFC6QlStxCut8W4iKMG7iAhQpAmVRiysuW5wj1Eg5l6YFhPshS
   b+86kVEmnCqvlG+H2tA16Awg4P1erh6n8JdsFumSqIWV9apiaP5m5GP4E
   i6hmj0vP9DLWkUYj+0KlecoMxN6wg7xUirv22jBNaB6lwcj8M6Gj+AMCB
   c8gP4VaSSKG5WNu5WzOrvxrI+JZrucOJLYuRlsOCAEjHLmePXObJIXr3E
   A==;
X-CSE-ConnectionGUID: 74stIc2yQYON82p/ZzZdGw==
X-CSE-MsgGUID: pCN9U+cBRHWik/VSNaLPpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48230673"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48230673"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:30:23 -0700
X-CSE-ConnectionGUID: dmlpEmx0RhW+ZtWdcMm+5Q==
X-CSE-MsgGUID: lNIBVD2BR2q828VS41P8cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138445834"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2025 05:30:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFBFb-000H6h-1i;
	Wed, 14 May 2025 12:30:19 +0000
Date: Wed, 14 May 2025 20:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 128ad8fa385b151041e1f94ef737b080c2aea6f4
Message-ID: <202505142044.LN2bTASL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 128ad8fa385b151041e1f94ef737b080c2aea6f4  Documentation: Update the CXL Maturity Map

elapsed time: 803m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250514    gcc-13.3.0
arc                   randconfig-002-20250514    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-003-20250514    gcc-7.5.0
arm                   randconfig-004-20250514    gcc-7.5.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250514    clang-17
arm64                 randconfig-002-20250514    gcc-5.5.0
arm64                 randconfig-003-20250514    gcc-5.5.0
arm64                 randconfig-004-20250514    clang-21
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250514    gcc-13.3.0
csky                  randconfig-002-20250514    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250514    clang-21
hexagon               randconfig-002-20250514    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-002-20250514    gcc-12
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-005-20250514    gcc-12
i386        buildonly-randconfig-006-20250514    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250514    gcc-14.2.0
loongarch             randconfig-002-20250514    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
mips                           ip27_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250514    gcc-7.5.0
nios2                 randconfig-002-20250514    gcc-11.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250514    gcc-12.4.0
parisc                randconfig-002-20250514    gcc-10.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250514    clang-17
powerpc               randconfig-002-20250514    gcc-5.5.0
powerpc               randconfig-003-20250514    gcc-7.5.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250514    gcc-10.5.0
powerpc64             randconfig-002-20250514    clang-19
powerpc64             randconfig-003-20250514    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250514    gcc-7.5.0
riscv                 randconfig-002-20250514    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250514    clang-21
s390                  randconfig-002-20250514    clang-21
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250514    gcc-11.5.0
sh                    randconfig-002-20250514    gcc-9.3.0
sh                          rsk7264_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250514    gcc-8.5.0
sparc                 randconfig-002-20250514    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250514    gcc-14.2.0
sparc64               randconfig-002-20250514    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250514    gcc-12
um                    randconfig-002-20250514    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250514    clang-20
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-005-20250514    clang-20
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250514    gcc-10.5.0
xtensa                randconfig-002-20250514    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
