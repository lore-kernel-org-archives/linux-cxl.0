Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80F2CA8
	for <linux-cxl@vger.kernel.org>; Sat, 12 Jul 2025 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752297785; cv=none; b=oskokmFanqTPd8fWCv0P6Zn5SZBBwoIz2HTg0SZHaC+fYts36u7UjdSEJLVKIOpAgzIvI3QBwG1Jk9Jk0Fco6WsmsgdpymUANpdS7F++FnK3pEhTHYWX0zlCYxUAFDKe5bWfyRtuCJsQYls7uFecagORYz3d81BSYaDAf5hcin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752297785; c=relaxed/simple;
	bh=LUo0iF9S5EX9yns3aJSdWDSWsSxvYalpZi7k2HHilfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GwrJ80IQN7qh46Xv8nQGpkPxWu3SnXJjbTDJkqZBdqgdY/opNUqI7/5ZoUD2Qt3ieZkG4ajuu+SDZyMqxBEaPsk1c2NLLoWxujZi9BoE2B1zkxrJTtkr6Fdl4gbo3WbhfMXWHeUK2CK+FCyDPRvoJCPySyXLlm3DerFZnkHkDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPZ9Gs2i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPZ9Gs2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752297783; x=1783833783;
  h=date:from:to:cc:subject:message-id;
  bh=LUo0iF9S5EX9yns3aJSdWDSWsSxvYalpZi7k2HHilfQ=;
  b=XPZ9Gs2iwTXbLZMHpoX52qW39KuuO+qPg/gnpM3q/rdaACbpCHPKV6/T
   bPBKrbp1MSRibzvWKQ/YiUGpKJKCLy92eT56DQvaLcn9wbKk71c3efwb2
   n4jbNKmF559IyEAQBw07fcItDeapfvIkgR8RyW1+ERX4evYdRAVyzPVuC
   fD1X3udnZ8aIWCoAdtzoHdT2y6DZfbajaYysnixHy7gqk6ftdD546YcIT
   X2TSWc0CZjPeR5xY+bxV6odsKgzm1ZHcWKaxH83qUugIrX48ekjQBTpfU
   z4Uah3Ufsh+yZJ+MOrFqyLKxE2r79M2GNaykf+6nwc6DcRTzhzl5Jt3/w
   g==;
X-CSE-ConnectionGUID: yGsw+26CTOqc7EvBLHnhtA==
X-CSE-MsgGUID: CSODo7UaRpKEjMMec3LQAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54673527"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54673527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 22:23:02 -0700
X-CSE-ConnectionGUID: r9LvodG5QVuJ0d8cZvXdmQ==
X-CSE-MsgGUID: srei/MNXTSGrDBGKRyp9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="156610929"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2025 22:23:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaShO-000759-1A;
	Sat, 12 Jul 2025 05:22:58 +0000
Date: Sat, 12 Jul 2025 13:22:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 bdf2d9fd3a86538b8c7368989248b857b5f1bcf1
Message-ID: <202507121307.q7jDhia9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: bdf2d9fd3a86538b8c7368989248b857b5f1bcf1  cxl/core: Using cxl_resource_contains_addr() to check address availability

elapsed time: 730m

configs tested: 132
configs skipped: 7

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
arc                   randconfig-001-20250712    gcc-10.5.0
arc                   randconfig-002-20250712    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                   randconfig-001-20250712    gcc-8.5.0
arm                   randconfig-002-20250712    gcc-10.5.0
arm                   randconfig-003-20250712    clang-21
arm                   randconfig-004-20250712    clang-21
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250712    gcc-12.3.0
arm64                 randconfig-002-20250712    gcc-12.3.0
arm64                 randconfig-003-20250712    gcc-8.5.0
arm64                 randconfig-004-20250712    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250712    gcc-14.3.0
csky                  randconfig-002-20250712    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250712    clang-21
hexagon               randconfig-002-20250712    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250712    clang-20
i386        buildonly-randconfig-002-20250712    gcc-11
i386        buildonly-randconfig-003-20250712    gcc-12
i386        buildonly-randconfig-004-20250712    gcc-12
i386        buildonly-randconfig-005-20250712    gcc-12
i386        buildonly-randconfig-006-20250712    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250712    gcc-15.1.0
loongarch             randconfig-002-20250712    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250712    gcc-8.5.0
parisc                randconfig-002-20250712    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250712    gcc-15.1.0
powerpc               randconfig-002-20250712    gcc-8.5.0
powerpc               randconfig-003-20250712    clang-21
powerpc64             randconfig-002-20250712    clang-21
powerpc64             randconfig-003-20250712    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250712    gcc-8.5.0
riscv                 randconfig-002-20250712    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250712    clang-21
s390                  randconfig-002-20250712    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250712    gcc-15.1.0
sh                    randconfig-002-20250712    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250712    gcc-13.4.0
sparc                 randconfig-002-20250712    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250712    clang-20
sparc64               randconfig-002-20250712    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250712    gcc-12
um                    randconfig-002-20250712    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250712    gcc-12
x86_64      buildonly-randconfig-002-20250712    gcc-12
x86_64      buildonly-randconfig-003-20250712    clang-20
x86_64      buildonly-randconfig-004-20250712    clang-20
x86_64      buildonly-randconfig-005-20250712    gcc-12
x86_64      buildonly-randconfig-006-20250712    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250712    gcc-8.5.0
xtensa                randconfig-002-20250712    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
