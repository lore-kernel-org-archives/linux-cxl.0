Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D2260360
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739723; cv=none; b=IgxMkx/YdPNJYnBtjPqCATTU/bgvn7FS3PZ2ovV/EmObFiCEbGTAlFlCXBDQPCCUcn7BkXYgNmoG5bCQ9LnF/yftNvaGXrZurKKy+g282HS9Ja/a5vh06nh8DJVKh6bNuS3+toyL3ehdyeHw1WPI0XBBQ128jROVFiUTvX7aTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739723; c=relaxed/simple;
	bh=qUjPyo7/rfroHpMysm5UpsOBLjCdRps6w+VgbL5p+hw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mu6ZKecFIzNYgCQe28b5bNEYeqF4MsIGrPtnMhfyA8jzP30NEYiSGRMOhomJSfvhUfkBS7l4PNk3/TW2/bAjyl7tTrGpI+pNfr5YIvWwD6WWBeMAHQ7d49+ta6O7bOAw7Pe4kd/HIE1BbCoWDYpMfVCKLJ7gNUWQfgINV9syQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR3fAEd7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR3fAEd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740739721; x=1772275721;
  h=date:from:to:cc:subject:message-id;
  bh=qUjPyo7/rfroHpMysm5UpsOBLjCdRps6w+VgbL5p+hw=;
  b=BR3fAEd7c43aFCX009enMpBcXZQjzzi7gtPeV8hehtkfV7w8bOAAVhFz
   cF8ZyqcWcR07Dfsxl3NWjSO/6Z5Y+hsiqMMZrlJv8iHcev0snA7i741b5
   4NK8SoTm3dc3vnCzjeU0c5yfJcPfff8+OF4gTdtHAahjyi/zAKueFQuQz
   oVzrG61p2cyMPwotiHGSgC07KAQuowHHVGnKhg+WqWXLqICB6ocXujJ3u
   5okPTg3EyVQrLABA9rNGBUINzSSapMQmZ3tL6HwjIA30BowT485fPtHAY
   ULFvnGO9uebxXhTZSOCwWTf2nLuF/O/nU0APQdSg+0Xkm2XEqz7xymqYj
   w==;
X-CSE-ConnectionGUID: cbGTMpLsQEycdamijBd6mg==
X-CSE-MsgGUID: 1zrDnD5VSsW78hv2y8JSxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="67041625"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="67041625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:48:40 -0800
X-CSE-ConnectionGUID: 2DJlpE2CQkecA1Tyiq4xkA==
X-CSE-MsgGUID: S2rZIt9pQCCCmhIwXmTRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148227965"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 02:48:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnxv3-000Elu-0N;
	Fri, 28 Feb 2025 10:48:37 +0000
Date: Fri, 28 Feb 2025 18:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 00d8107b0cbf869658860b98c9b77df607e0dd0c
Message-ID: <202502281848.Q7iiQQsh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 00d8107b0cbf869658860b98c9b77df607e0dd0c  cxl/test: Define a CFMWS capable of a 3 way HB interleave

elapsed time: 891m

configs tested: 140
configs skipped: 4

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
arc                   randconfig-001-20250228    gcc-13.2.0
arc                   randconfig-002-20250228    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20250228    clang-21
arm                   randconfig-002-20250228    gcc-14.2.0
arm                   randconfig-003-20250228    gcc-14.2.0
arm                   randconfig-004-20250228    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250228    gcc-14.2.0
arm64                 randconfig-002-20250228    clang-21
arm64                 randconfig-003-20250228    clang-16
arm64                 randconfig-004-20250228    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250228    gcc-14.2.0
csky                  randconfig-002-20250228    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250228    clang-19
hexagon               randconfig-002-20250228    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250228    clang-19
i386        buildonly-randconfig-002-20250228    clang-19
i386        buildonly-randconfig-003-20250228    gcc-12
i386        buildonly-randconfig-004-20250228    clang-19
i386        buildonly-randconfig-005-20250228    clang-19
i386        buildonly-randconfig-006-20250228    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250228    gcc-14.2.0
loongarch             randconfig-002-20250228    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                           ip28_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250228    gcc-14.2.0
nios2                 randconfig-002-20250228    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250228    gcc-14.2.0
parisc                randconfig-002-20250228    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250228    gcc-14.2.0
powerpc               randconfig-002-20250228    clang-16
powerpc               randconfig-003-20250228    clang-18
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250228    clang-16
powerpc64             randconfig-002-20250228    clang-18
powerpc64             randconfig-003-20250228    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250228    gcc-14.2.0
riscv                 randconfig-002-20250228    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250228    gcc-14.2.0
s390                  randconfig-002-20250228    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250228    gcc-14.2.0
sh                    randconfig-002-20250228    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250228    gcc-14.2.0
sparc                 randconfig-002-20250228    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250228    gcc-14.2.0
sparc64               randconfig-002-20250228    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250228    clang-21
um                    randconfig-002-20250228    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250228    clang-19
x86_64      buildonly-randconfig-002-20250228    clang-19
x86_64      buildonly-randconfig-003-20250228    gcc-12
x86_64      buildonly-randconfig-004-20250228    clang-19
x86_64      buildonly-randconfig-005-20250228    gcc-12
x86_64      buildonly-randconfig-006-20250228    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250228    gcc-14.2.0
xtensa                randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
