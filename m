Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF12233A
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555969; cv=none; b=CfRm+N50CuWZV8H4V8guh/1lwFDw/IeHOXyo+GOprFutN2K4ys7pmqu0xCh1A0E3YHtsNlAVIIAq4LMp4CPYR7F+wfC8QXXDm5qPeORE3CX1okOZP+ZGxmPBHidHNkXK549/HHtVGKyl6oHx7piR97azJrRt0EHA0uJ7zSrbT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555969; c=relaxed/simple;
	bh=l9x87vj1e4hlae0rwsug7yY6Xycbn4LsEj8o4knYMEs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bAdn8Sbwx+GbwzxPGB3FlTMEKmJzVy4r4rf6nMGi5CEEJrN1Cxly5JceE9AcfCeK/BN2/30JY/XUKl67ZYNuRYliHcNPlD8s2MYDdrUJetAbFDdQG3g+8xTO2oIonOrs3Ih1hVXnYliAh3jsCPT1GAgBS8+g2DRQ6Lvk/hMhuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4YHS6qF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4YHS6qF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714555968; x=1746091968;
  h=date:from:to:cc:subject:message-id;
  bh=l9x87vj1e4hlae0rwsug7yY6Xycbn4LsEj8o4knYMEs=;
  b=E4YHS6qFyrF0YPiHNgCbgkE60kuZwXUjdCrv1Bgof2jGJ91dpP8Wcb6X
   RNJT0uYN8MmNE6LzfeHSgFux1JJL6n0/f2EEfHGmhNZPFbzPqGKMAvAdP
   rBK+/wdtMfCH6PAp4yHC/oJ2mXDtaXf1Dltrra4huNGExEBNNJCE6rpZI
   w2+O6DZSZSvwgR2piTNXFP043sO/oRy0WWuZeAdZereuIK9yxUh6+5Mwo
   KyOQR+wx9s5GzhVloZO5ax0i11L/CwfHqZottZL9aSnfe/xYjSk1xqBfK
   Lb14dnRol0jEIvMAEIYZ9OGJS9SrnaSzgQqR4CADunjBrcujGg5yG6WRA
   w==;
X-CSE-ConnectionGUID: 2+F08mSlRACSWmaubRdy6w==
X-CSE-MsgGUID: tMfOM/h7SfC3WvVMp45YRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14061145"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="14061145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 02:32:32 -0700
X-CSE-ConnectionGUID: Yd3U7CCdTVaxWM87Ja8mFg==
X-CSE-MsgGUID: 4qBEnV4YTV+Kj79ioZC9oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="27150936"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 May 2024 02:32:30 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s26KA-0009Kg-2Z;
	Wed, 01 May 2024 09:32:26 +0000
Date: Wed, 01 May 2024 17:31:27 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.10/dpa-to-hpa] BUILD SUCCESS
 6aec00139d3a83e2394d4bcb0084e872b4036e8f
Message-ID: <202405011721.ezDlU6xf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.10/dpa-to-hpa
branch HEAD: 6aec00139d3a83e2394d4bcb0084e872b4036e8f  cxl/core: Add region info to cxl_general_media and cxl_dram events

elapsed time: 844m

configs tested: 180
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240501   gcc  
arc                   randconfig-002-20240501   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240501   gcc  
arm                   randconfig-002-20240501   gcc  
arm                   randconfig-003-20240501   clang
arm                   randconfig-004-20240501   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240501   gcc  
arm64                 randconfig-002-20240501   gcc  
arm64                 randconfig-003-20240501   clang
arm64                 randconfig-004-20240501   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240501   gcc  
csky                  randconfig-002-20240501   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240501   clang
hexagon               randconfig-002-20240501   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240501   clang
i386         buildonly-randconfig-002-20240501   gcc  
i386         buildonly-randconfig-003-20240501   clang
i386         buildonly-randconfig-004-20240501   gcc  
i386         buildonly-randconfig-005-20240501   gcc  
i386         buildonly-randconfig-006-20240501   clang
i386                                defconfig   clang
i386                  randconfig-001-20240501   gcc  
i386                  randconfig-002-20240501   clang
i386                  randconfig-003-20240501   gcc  
i386                  randconfig-004-20240501   gcc  
i386                  randconfig-005-20240501   clang
i386                  randconfig-006-20240501   clang
i386                  randconfig-011-20240501   gcc  
i386                  randconfig-012-20240501   gcc  
i386                  randconfig-013-20240501   gcc  
i386                  randconfig-014-20240501   gcc  
i386                  randconfig-015-20240501   gcc  
i386                  randconfig-016-20240501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240501   gcc  
loongarch             randconfig-002-20240501   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240501   gcc  
nios2                 randconfig-002-20240501   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240501   gcc  
parisc                randconfig-002-20240501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                      pcm030_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240501   clang
powerpc               randconfig-002-20240501   clang
powerpc               randconfig-003-20240501   clang
powerpc                     sequoia_defconfig   clang
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240501   clang
powerpc64             randconfig-002-20240501   clang
powerpc64             randconfig-003-20240501   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240501   clang
riscv                 randconfig-002-20240501   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240501   gcc  
s390                  randconfig-002-20240501   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240501   gcc  
sh                    randconfig-002-20240501   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240501   gcc  
sparc64               randconfig-002-20240501   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240501   gcc  
um                    randconfig-002-20240501   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240501   gcc  
x86_64       buildonly-randconfig-002-20240501   clang
x86_64       buildonly-randconfig-003-20240501   gcc  
x86_64       buildonly-randconfig-004-20240501   gcc  
x86_64       buildonly-randconfig-005-20240501   clang
x86_64       buildonly-randconfig-006-20240501   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240501   gcc  
x86_64                randconfig-002-20240501   gcc  
x86_64                randconfig-003-20240501   gcc  
x86_64                randconfig-004-20240501   clang
x86_64                randconfig-005-20240501   clang
x86_64                randconfig-006-20240501   gcc  
x86_64                randconfig-011-20240501   gcc  
x86_64                randconfig-012-20240501   clang
x86_64                randconfig-013-20240501   gcc  
x86_64                randconfig-014-20240501   clang
x86_64                randconfig-015-20240501   clang
x86_64                randconfig-016-20240501   clang
x86_64                randconfig-071-20240501   clang
x86_64                randconfig-072-20240501   clang
x86_64                randconfig-073-20240501   clang
x86_64                randconfig-074-20240501   gcc  
x86_64                randconfig-075-20240501   gcc  
x86_64                randconfig-076-20240501   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240501   gcc  
xtensa                randconfig-002-20240501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
