Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E41D5CD9
	for <linux-cxl@vger.kernel.org>; Sat,  1 Mar 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831221; cv=none; b=FjgBb0HRfwPT7xCqV91MUD+z+8w67gLT3Nu5jNKud5K4sTGGmrk97sgT2jsrdju7pWPvOxCgmTAXHRXghsoFPVISQOQACryWzMZlf9TYGbcn1OPXQORNDGopReIkK+WusENvsUAU/TmeH9dBfJKKJxH6Q0Q99lJfQDlVae8U38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831221; c=relaxed/simple;
	bh=+ieuuoOvymZ24Cgi9RuBbl1Zcfg2Q4pS9sF1jpmxHoI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V8O5OKij3bxmZIFR1jbDNhOvxZdWfA/HnC/3OivD6txSiSSLQKgH/SU54mKgStImcbbdw95sc6uU4qr0v+agRFQjcczjnOYg5Dl8J5fMEIwl77lnMNJ64Y7dYSluEuxow7Ck6qBo8wcMo9YjKTj3jSb3pxX/mWDVmQi0jAYh3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5ysY4VG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5ysY4VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740831219; x=1772367219;
  h=date:from:to:cc:subject:message-id;
  bh=+ieuuoOvymZ24Cgi9RuBbl1Zcfg2Q4pS9sF1jpmxHoI=;
  b=U5ysY4VG7reu3pzgR4JycTdny+m76aDFCoeRgN/7U0UKlqiAN+ZoNQe9
   pxU4vECH9uEJh4Ibdk2PoxDWH5xUfC+H8CZXS+5+MCOct90U+wASptira
   iB9OXu+FQ5AJDroyYFG2SvmhHLjmJYKtrdd9FATju0WLG4ihE+M/bXsF5
   CzbbYN+4n91/YDlU0L8CaISjfdY8o1UlIoC3Q/rJ5xwXAKGaFHgc2xjgE
   zJVqFugq/4f+Uj7s6CnmvmL1HU8B3Vk/YwbQZiURciNOIoEMkGnyEjJt4
   Tc9U5G6LHtTwRJ7sYDBk1j4YY8MpLE1SSAl0TEaFQqisNQsfxnSKpohyW
   Q==;
X-CSE-ConnectionGUID: /UZPhgi7SiumpcrTVN+/vg==
X-CSE-MsgGUID: a9I3stgYSa6+N3L6NAAL4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41453334"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="41453334"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 04:13:38 -0800
X-CSE-ConnectionGUID: W70C1p7iTlyY5JQgo+2F/Q==
X-CSE-MsgGUID: vvMtAqiZQzWazVDefAZ3SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154744117"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Mar 2025 04:13:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toLie-000GE2-1U;
	Sat, 01 Mar 2025 12:13:26 +0000
Date: Sat, 01 Mar 2025 20:13:14 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 26600bf10173beda5358d194ec425a1cfafa2fe2
Message-ID: <202503012008.KrIViJoz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 26600bf10173beda5358d194ec425a1cfafa2fe2  cxl: Fix warning from emitting resource_size_t as long long int on 32bit systems

elapsed time: 859m

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
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-17
arm                         bcm2835_defconfig    clang-16
arm                                 defconfig    clang-21
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-004-20250301    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-004-20250301    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-002-20250301    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-003-20250301    clang-21
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-002-20250301    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250301    gcc-12
um                    randconfig-002-20250301    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
