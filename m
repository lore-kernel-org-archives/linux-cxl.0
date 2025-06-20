Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67626251793
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415825; cv=none; b=LnNWaFnFLBwGp86E9ZrFSGWpiyRIJHU4axHOO6Kwe9RIuDSH1YcR58N+FujsB6R4c2/N9F00/viSrsOWGHpt1WyE7XKRHvyGAvl64Xwtlwx48pS6+8b0/g0JDwtich9Uc4uOXJrhq9LKVfJFgDl1ZNtnlKS8Uki5irFB3vHzDz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415825; c=relaxed/simple;
	bh=sF/QL5Yqp/WDkIrGBIBEM8Twyaszu6/r4SVwnsZrius=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IlBrNjLzTuB7IRONBDAKJZiQ3mxSSf/Uyl12Wykuf41RU3DWt+ucLsONOmOfoelpyb6lvXxfVj2aAhgCNBdiK9Ge5rkU0MCNyu6himJBPDxFoBE25e4AY3YG8qDHSg4PZDnsDxOnuCUCNol9n3r19uvLWWXE2CXHYhwf7UFWbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsjJ6rsP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsjJ6rsP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750415823; x=1781951823;
  h=date:from:to:cc:subject:message-id;
  bh=sF/QL5Yqp/WDkIrGBIBEM8Twyaszu6/r4SVwnsZrius=;
  b=CsjJ6rsP5O74Bk6pcAcSW4hiXJF/en2k1TV4LUTlTq1t2C+JQhvv2j0W
   D3Iwxrz0qwtkpUJctoW6jGmA9pg7skuQX/iha6DNp0AEOLwyldZAswirb
   +2whDeVePFbZci7kIUeyJtb5b+vYpxNkVEAzg1qOTU1pu++0695vuG7iT
   uDCIFDnLW9J0Chfmd+GS3FyU/3ThJ4w2hqdeQW8/nA8b7gC5rwTp/KQP8
   vunxPO4AIhCj3ClZ/5OYuJKKOCGX1gdg2bdYJtGHmblosM0rNT7IGe4YU
   AUknk0vh8ZDASKDFKVZyQbT5Pr9MbD1Q/Q+aM42c+Zc3ftPV4DJy2D32G
   A==;
X-CSE-ConnectionGUID: praAjKVcQhWEG/Bkjszcnw==
X-CSE-MsgGUID: IZ7RHn4XS86DEsXqoizpDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="78083101"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="78083101"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:37:02 -0700
X-CSE-ConnectionGUID: 59Ftxlj1RBaqeNnIIDkBzA==
X-CSE-MsgGUID: tiww/KPLR0GPUfNfOyij/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151178781"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 03:37:01 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSZ7D-000Ld2-0E;
	Fri, 20 Jun 2025 10:36:59 +0000
Date: Fri, 20 Jun 2025 18:36:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.17/cxl-acquire] BUILD SUCCESS
 6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
Message-ID: <202506201821.arv5Anob-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.17/cxl-acquire
branch HEAD: 6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b  cxl: Convert to ACQUIRE() for conditional rwsem locking

elapsed time: 738m

configs tested: 180
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250620    gcc-8.5.0
arc                   randconfig-002-20250620    gcc-11.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                            dove_defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    clang-16
arm                        multi_v5_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250620    clang-21
arm                        shmobile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250620    gcc-9.5.0
arm64                 randconfig-002-20250620    gcc-8.5.0
arm64                 randconfig-003-20250620    gcc-11.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250620    gcc-13.3.0
csky                  randconfig-002-20250620    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386        buildonly-randconfig-006-20250620    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250620    gcc-14.3.0
loongarch             randconfig-002-20250620    gcc-15.1.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250620    gcc-8.5.0
nios2                 randconfig-002-20250620    gcc-10.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250620    gcc-10.5.0
parisc                randconfig-002-20250620    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250620    gcc-11.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc64             randconfig-001-20250620    gcc-14.3.0
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250620    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250620    gcc-14.3.0
riscv                 randconfig-002-20250620    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250620    gcc-9.3.0
s390                  randconfig-002-20250620    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20250620    gcc-15.1.0
sh                    randconfig-002-20250620    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250620    gcc-8.5.0
sparc                 randconfig-002-20250620    gcc-10.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250620    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250620    clang-21
um                    randconfig-002-20250620    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250620    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250620    clang-20
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250620    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
