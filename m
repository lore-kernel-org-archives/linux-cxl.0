Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEC3BBD6
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024070; cv=none; b=BB1ns19IqgUV0Eba1GaLd0fafXPw6GU7Q4Xby6LrmCQ/1XuMIov4z85xmJuZQK5ZBiF+0+Yz0UoLzO9+TxAXC0Dz5FlfLmSJJzXW67wJPy2bfj7JJK6TN27l20imbIa9wbnQHckZzd30hoySFkf3s2XoMvzbO9wwiyHUPlNtkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024070; c=relaxed/simple;
	bh=YA/0RBkFhCwjkDaV4sPeFmWHkg3+bh2hGrF5VlJiaDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ane5F4kB6dvQ+rbVrnyhvxok8UPGQrIQ8EMGrGsGqLaUm8iq18qSUNgBswd+7YIHpN0UManXYYQE+sDWtAhx41bYNWkibt14pUqED2JBMrfdjafuBOF7dSnHzdhNhscjv4f+UwQLfc9K/3mf4QkbbdYz+2QeHvE0WBhptb5cLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RV+82wu2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RV+82wu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714024068; x=1745560068;
  h=date:from:to:cc:subject:message-id;
  bh=YA/0RBkFhCwjkDaV4sPeFmWHkg3+bh2hGrF5VlJiaDY=;
  b=RV+82wu2XT2AIln1RSWn+k2bORBkLLlS4ulMwZ0Qvoqot+oVO5KuizE+
   pvw0aephjLtAk/GIzWc6wys4YHj+Jar3z7Eq6g+Napv6fSmdVJY8o77Pw
   sFWYc9JJcwqT9Pcy65BbXLdJRuBsY7bJFPPKuHirA8LQ9c3ygFVi5pg5h
   VfUcM4qQLXMqicJvjrH0YxYLj3OTy/yVvDICgAeldMA9rmib/CitrsccB
   y/ctjBl51TQ3jTpM/1pqXAO9m+rULOwYAWnIO+sGF70RCr2DWwb2dhYQ5
   uCZnWsNPvkj0jnLtzHvZIiiDUO9pjS/bQCcTR2Zd5FGJULU6gsssUSIdQ
   g==;
X-CSE-ConnectionGUID: ZdjXWJPKTJO3n0C6NGRPxg==
X-CSE-MsgGUID: NzOIO6d3T/iQy8CKb8TPZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9553581"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9553581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 22:47:47 -0700
X-CSE-ConnectionGUID: zRYKozYuQcGQrFUlc2ctTg==
X-CSE-MsgGUID: gpoIVD5ISVybMpaPRfYYQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25383429"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Apr 2024 22:47:45 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzrxO-00022S-1b;
	Thu, 25 Apr 2024 05:47:42 +0000
Date: Thu, 25 Apr 2024 13:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 866c0674541f81a85fd592990f373f560bb23e8a
Message-ID: <202404251330.Sx5rbuqj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 866c0674541f81a85fd592990f373f560bb23e8a  cxl: Fix use of phys_to_target_node() for x86

elapsed time: 749m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240425   gcc  
arc                   randconfig-002-20240425   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240425   clang
arm                   randconfig-002-20240425   clang
arm                   randconfig-003-20240425   clang
arm                   randconfig-004-20240425   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240425   gcc  
arm64                 randconfig-002-20240425   gcc  
arm64                 randconfig-003-20240425   gcc  
arm64                 randconfig-004-20240425   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240425   gcc  
csky                  randconfig-002-20240425   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240425   clang
hexagon               randconfig-002-20240425   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240425   gcc  
i386         buildonly-randconfig-002-20240425   clang
i386         buildonly-randconfig-003-20240425   gcc  
i386         buildonly-randconfig-004-20240425   clang
i386         buildonly-randconfig-005-20240425   clang
i386         buildonly-randconfig-006-20240425   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240425   clang
i386                  randconfig-002-20240425   clang
i386                  randconfig-003-20240425   clang
i386                  randconfig-004-20240425   gcc  
i386                  randconfig-005-20240425   clang
i386                  randconfig-006-20240425   clang
i386                  randconfig-011-20240425   clang
i386                  randconfig-012-20240425   clang
i386                  randconfig-013-20240425   gcc  
i386                  randconfig-014-20240425   gcc  
i386                  randconfig-015-20240425   gcc  
i386                  randconfig-016-20240425   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240425   gcc  
loongarch             randconfig-002-20240425   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                        vocore2_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240425   gcc  
nios2                 randconfig-002-20240425   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240425   gcc  
parisc                randconfig-002-20240425   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240425   gcc  
powerpc               randconfig-002-20240425   gcc  
powerpc               randconfig-003-20240425   clang
powerpc64             randconfig-001-20240425   gcc  
powerpc64             randconfig-002-20240425   gcc  
powerpc64             randconfig-003-20240425   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240425   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240425   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240425   clang
x86_64       buildonly-randconfig-002-20240425   gcc  
x86_64       buildonly-randconfig-003-20240425   clang
x86_64       buildonly-randconfig-004-20240425   clang
x86_64       buildonly-randconfig-005-20240425   clang
x86_64       buildonly-randconfig-006-20240425   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240425   clang
x86_64                randconfig-002-20240425   clang
x86_64                randconfig-003-20240425   clang
x86_64                randconfig-004-20240425   gcc  
x86_64                randconfig-005-20240425   gcc  
x86_64                randconfig-006-20240425   clang
x86_64                randconfig-011-20240425   gcc  
x86_64                randconfig-012-20240425   clang
x86_64                randconfig-013-20240425   clang
x86_64                randconfig-014-20240425   gcc  
x86_64                randconfig-015-20240425   clang
x86_64                randconfig-016-20240425   clang
x86_64                randconfig-071-20240425   clang
x86_64                randconfig-072-20240425   gcc  
x86_64                randconfig-073-20240425   gcc  
x86_64                randconfig-074-20240425   clang
x86_64                randconfig-075-20240425   clang
x86_64                randconfig-076-20240425   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
