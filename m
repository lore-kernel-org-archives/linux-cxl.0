Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9819ABB6
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337466; cv=none; b=QszirnBzTWcou/tiH997mYwReLoN7VVicCmQP6qnA/z7gS2zMnNKK28i2r8GpJv/6Ai8XfeRT50SxImeaFZcNImJW1gagp04/6QQCJheI65lm4hJJen7UoJb17yVgja9h9XUelcLvNNy1cAu209BDEMi3SJS3OdM5wOE1UELOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337466; c=relaxed/simple;
	bh=KjHUQHvlZlPdz0x/kbKzl7BHCYQnvq5wGEda+HQW0KU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H9WAPj+AhtrbijZ8bJdEeBoOsn5FMMTIHbtGCkpT5sdMil5X2D1zKLP/aHtlrepwYRRp/Q9+jF1rrojN9v6Mj28OzovhPEk7AhSWnG0If8sRIWeJo74wrtkqm8u0edYjbz1i3fo7V+f+drQbx2ohVmN0WIQyOUqFpPcT6KXWx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVLw4ihP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVLw4ihP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745337465; x=1776873465;
  h=date:from:to:cc:subject:message-id;
  bh=KjHUQHvlZlPdz0x/kbKzl7BHCYQnvq5wGEda+HQW0KU=;
  b=kVLw4ihPWb5tTz6Y0UhKTZZlPN6Qph9YKrGZKaXb3Nn9/xJNusVtHPJO
   p/hsvauHDDJn/CAPvJ6Zr7xmFNO1VoqbP8ykhcFp97trS8RzL432E1DzO
   S42AyYavLztY9EkemgqA4hj8r5Yq7ymdMZqt5AKiOhyApwELIkEcoVTDN
   tXmPOYaZaMl6aZLLY0E5WDVQO7e0IFyjzFDsjF58i/yXbKfsawTMVijUT
   9oE7ea80t04sg8md8Du+DRPdclFKiHpm6w8lsIDUQkvTjuTB/MjIOTJ+2
   WIzV0iX2J3rKx+KWIh2gNUCXsUcYlQwWgtEMBYKzRMk6UXu+d+/O+0W1m
   g==;
X-CSE-ConnectionGUID: wKZgLk6vTQu4Fo8STjCgLQ==
X-CSE-MsgGUID: 2FX9fe5DSNOnxhQrHdw6xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="69394678"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="69394678"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:57:44 -0700
X-CSE-ConnectionGUID: l2zmDtYeQsqN4yusQQSPJg==
X-CSE-MsgGUID: Cy/HSoncS+qFhBsRcycC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132373096"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Apr 2025 08:57:42 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7G0B-00018H-2o;
	Tue, 22 Apr 2025 15:57:39 +0000
Date: Tue, 22 Apr 2025 23:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 078d3ee7c162cd66d76171579c02d7890bd77daf
Message-ID: <202504222343.BOKXygaB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 078d3ee7c162cd66d76171579c02d7890bd77daf  cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports

elapsed time: 1454m

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
arc                   randconfig-001-20250422    gcc-8.5.0
arc                   randconfig-002-20250422    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                           imxrt_defconfig    clang-21
arm                        keystone_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250422    gcc-8.5.0
arm                   randconfig-002-20250422    gcc-8.5.0
arm                   randconfig-003-20250422    gcc-7.5.0
arm                   randconfig-004-20250422    gcc-7.5.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250422    gcc-6.5.0
arm64                 randconfig-002-20250422    clang-21
arm64                 randconfig-003-20250422    clang-18
arm64                 randconfig-004-20250422    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250422    gcc-10.5.0
csky                  randconfig-002-20250422    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250422    clang-21
hexagon               randconfig-002-20250422    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250422    clang-20
i386        buildonly-randconfig-002-20250422    clang-20
i386        buildonly-randconfig-003-20250422    gcc-12
i386        buildonly-randconfig-004-20250422    gcc-12
i386        buildonly-randconfig-005-20250422    clang-20
i386        buildonly-randconfig-006-20250422    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250422    gcc-14.2.0
loongarch             randconfig-002-20250422    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250422    gcc-10.5.0
nios2                 randconfig-002-20250422    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250422    gcc-7.5.0
parisc                randconfig-002-20250422    gcc-11.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250422    clang-21
powerpc               randconfig-002-20250422    gcc-6.5.0
powerpc               randconfig-003-20250422    clang-16
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250422    clang-21
powerpc64             randconfig-002-20250422    gcc-6.5.0
powerpc64             randconfig-003-20250422    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250422    clang-21
riscv                 randconfig-002-20250422    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250422    gcc-7.5.0
s390                  randconfig-002-20250422    clang-21
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20250422    gcc-14.2.0
sh                    randconfig-002-20250422    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250422    gcc-10.3.0
sparc                 randconfig-002-20250422    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250422    gcc-7.5.0
sparc64               randconfig-002-20250422    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250422    gcc-12
um                    randconfig-002-20250422    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250422    gcc-12
x86_64      buildonly-randconfig-002-20250422    clang-20
x86_64      buildonly-randconfig-003-20250422    gcc-12
x86_64      buildonly-randconfig-004-20250422    gcc-12
x86_64      buildonly-randconfig-005-20250422    clang-20
x86_64      buildonly-randconfig-006-20250422    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250422    gcc-14.2.0
xtensa                randconfig-002-20250422    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
