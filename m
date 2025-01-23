Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007720B215
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618500; cv=none; b=Gqav2lRvth4ZBWeDzK2GZdiyvhAMpHMhKe+L39dJ9wyrMC4gP6lvwOHd2mG+eyy76YCf+TXwtUSGXc9Dj8i4GBy9RHzuZli5ekF/eizAqk2o/+8CgmRjgZ2zeBXkNmzzjtFRHo7wE5/+PuyKHo2iDpCOMUzCx/hbYbmbjpYFiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618500; c=relaxed/simple;
	bh=BCuiVL0so9qj2lvdoQmnO85rPG0DaoJ3edXC4WipAic=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SqNFFbH3tHUjpwtjkH+DfBWQkvMIxaz0hxBhuZmLfEbM6DA8mzBK8FGMzaYS1Sr1sH1EtB4oPXCXKFAp5+Nn9oP48VzQHB/lOHngP7hZ5bFnGhPC0nRJ8XxMMYMOu619kINqlojwCTJeWLn3xuM2g74SWvqMc5Nownv4UagG7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihLLNbxQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihLLNbxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737618498; x=1769154498;
  h=date:from:to:cc:subject:message-id;
  bh=BCuiVL0so9qj2lvdoQmnO85rPG0DaoJ3edXC4WipAic=;
  b=ihLLNbxQorNcE/yd+eRBZloTsPg3TBwzDdVst6YCBMIKzjoWnrBY/IHE
   iZtjz/YES7J9jV9kP3GM99mN26F7QKXd1xIANkMVJgm1Hs453Ibxzzd0l
   wtOzeg9qHl9l0AS9fLvE00eIzE9Iq47gCHpXtd4T5fdHjBJpvPhNL111N
   8hjq5tfDU/tWrPJvIOS0P6PBbmoLn0BALHRIoR4jPgCmHYDf+uWCvvKIj
   mW4/sDAPVhoVYSSsHtqVvXDLtaT4/hBGEsTQ5pWAXwPBYB4vfZAwNI6rS
   wMRJdqHmO1odIswFzpV5uQIGF8nVc+hzh3uW9UAGr1LrRBlBIIUajJQpW
   Q==;
X-CSE-ConnectionGUID: 9yrYl2x8Q7+CxSxXFeLbZQ==
X-CSE-MsgGUID: Tn7YEwpLSfmJXWKo5itxwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48770739"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="48770739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 23:48:16 -0800
X-CSE-ConnectionGUID: 4na9XEq+QtitxtbkKzFeiQ==
X-CSE-MsgGUID: DtivVDm+R1izOgaT5cmNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130671548"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2025 23:48:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tarwi-000atb-1V;
	Thu, 23 Jan 2025 07:48:12 +0000
Date: Thu, 23 Jan 2025 15:47:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 448a60e85ae2afe2cb760f5d2ed2c8a49d2bd1b4
Message-ID: <202501231512.EteAaXXQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 448a60e85ae2afe2cb760f5d2ed2c8a49d2bd1b4  cxl/core/regs: Refactor out functions to count regblocks of given type

elapsed time: 859m

configs tested: 138
configs skipped: 7

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
arc                   randconfig-001-20250123    gcc-13.2.0
arc                   randconfig-002-20250123    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                   randconfig-001-20250123    clang-20
arm                   randconfig-002-20250123    gcc-14.2.0
arm                   randconfig-003-20250123    gcc-14.2.0
arm                   randconfig-004-20250123    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250123    gcc-14.2.0
arm64                 randconfig-002-20250123    clang-20
arm64                 randconfig-003-20250123    clang-20
arm64                 randconfig-004-20250123    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250123    gcc-14.2.0
csky                  randconfig-002-20250123    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20250123    clang-20
hexagon               randconfig-002-20250123    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250123    gcc-12
i386        buildonly-randconfig-002-20250123    clang-19
i386        buildonly-randconfig-003-20250123    gcc-12
i386        buildonly-randconfig-004-20250123    clang-19
i386        buildonly-randconfig-005-20250123    gcc-12
i386        buildonly-randconfig-006-20250123    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250123    gcc-14.2.0
loongarch             randconfig-002-20250123    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250123    gcc-14.2.0
nios2                 randconfig-002-20250123    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250123    gcc-14.2.0
parisc                randconfig-002-20250123    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   bluestone_defconfig    clang-20
powerpc                      pmac32_defconfig    clang-20
powerpc               randconfig-001-20250123    gcc-14.2.0
powerpc               randconfig-002-20250123    clang-18
powerpc               randconfig-003-20250123    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250123    gcc-14.2.0
powerpc64             randconfig-002-20250123    clang-16
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250123    gcc-14.2.0
riscv                 randconfig-002-20250123    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250123    gcc-14.2.0
s390                  randconfig-002-20250123    clang-15
s390                       zfcpdump_defconfig    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250123    gcc-14.2.0
sh                    randconfig-002-20250123    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250123    gcc-14.2.0
sparc                 randconfig-002-20250123    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250123    gcc-14.2.0
sparc64               randconfig-002-20250123    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250123    gcc-12
um                    randconfig-002-20250123    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250123    clang-19
x86_64      buildonly-randconfig-002-20250123    clang-19
x86_64      buildonly-randconfig-003-20250123    gcc-12
x86_64      buildonly-randconfig-004-20250123    gcc-12
x86_64      buildonly-randconfig-005-20250123    clang-19
x86_64      buildonly-randconfig-006-20250123    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250123    gcc-14.2.0
xtensa                randconfig-002-20250123    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
