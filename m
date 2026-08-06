Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA5499F23
	for <linux-cxl@vger.kernel.org>; Thu,  6 Aug 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057436; cv=none; b=FE7Oj6TnMlwev9+SrHzpVmMLMhJV8kDc7KBm/ypOvDOsTi7Ka02wL1xSnL2vb2TKk2Jyvhz+gKmGNdmH7QGwrlPIUhrlsU3TekRXrQgyVDA/cXhQ7unk0UQTLJpfQxnZsu4C7ph4RaCSD5tSTH+X5bsDLDHOZRs9q/drcqgpwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057436; c=relaxed/simple;
	bh=dNAWilsOdqeKdmdpsYPwI70egeQgrcLDxds18XvjD8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F4H5E97QVztxIDL1ZaJBVl4s5jnYu48B2sD8mCsAvqe1FPj7urhmfFm9HmRzh91eYx+hf+HlXYXdYe3RoTUcZxsqOLpaz8dxhGYCIxolmvsnza/RYvycOxjJdVvvvK4JckhKBligLqftlRkx1921yJ5x1/ZDJ7H3QIuDjzGS6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L78lUt4+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L78lUt4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786057434; x=1817593434;
  h=date:from:to:cc:subject:message-id;
  bh=dNAWilsOdqeKdmdpsYPwI70egeQgrcLDxds18XvjD8E=;
  b=L78lUt4+xh8NTFu+x+xzwxQVuUrCz5LJimAcfb4TIMvcXl9q/KXR48YR
   VDs8DrOKLlPTxuFpjA9oxo/F1FszoOZh0bW4jkfwTLC9DzTM/4iU/5Ytf
   N5dKtn6FE010/bYcPL6PVKOg+ZnDZI3NV8nQ5IjHa5hBFntDu+XPQ87j4
   eddoiomOBtUiU4WMhEtG0J7FCh7vHdPMZNNeiG/qGQXX+O5TiMw7twB7q
   jU6n+XW89/zzN8GZKUdSL2/iMFjEsrnjSAF/BPuyQ6QSfFogFt8RaGIPE
   N40zdl+xihYXoo2cMvK5QZlDJ0ytas066pBkpueO6wOcTrm9g+xFvlVAs
   A==;
X-CSE-ConnectionGUID: BEdQwYi2Qreg1fbOPjx3cg==
X-CSE-MsgGUID: lHPznAUoS0ScvSp4Q/8oVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90483114"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="90483114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:03:54 -0700
X-CSE-ConnectionGUID: Bq24Z4vmQjSkBJQ0utzXgg==
X-CSE-MsgGUID: BLNrm9ndRq6aPbquQbjgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="259625476"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 16:03:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws77u-00000000GUz-0KLY;
	Thu, 06 Aug 2026 23:03:50 +0000
Date: Fri, 07 Aug 2026 07:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.3/cxl-port-err-prep] BUILD SUCCESS
 658fb50cc8882608dc72dfa6b2e052f87d265ce6
Message-ID: <202608070759.GWZHQ5uS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.3/cxl-port-err-prep
branch HEAD: 658fb50cc8882608dc72dfa6b2e052f87d265ce6  cxl: Rename find_cxl_port() to find_cxl_port_by_dport()

elapsed time: 1539m

configs tested: 206
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-001-20260806    gcc-8.5.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-002-20260806    gcc-11.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-001-20260806    clang-24
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-002-20260806    gcc-10.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-003-20260806    gcc-8.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm                  randconfig-004-20260806    gcc-8.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm64                randconfig-001-20260806    gcc-13.4.0
arm64                randconfig-001-20260806    gcc-8.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-002-20260806    gcc-11.5.0
arm64                randconfig-002-20260806    gcc-13.4.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-003-20260806    clang-17
arm64                randconfig-003-20260806    gcc-13.4.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-004-20260806    clang-17
arm64                randconfig-004-20260806    gcc-13.4.0
arm64                randconfig-004-20260807    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260806    gcc-13.4.0
csky                 randconfig-001-20260806    gcc-15.2.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-002-20260806    gcc-13.4.0
csky                 randconfig-002-20260807    gcc-16.1.0
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-002-20260806    clang-24
hexagon              randconfig-002-20260807    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260806    gcc-14
i386       buildonly-randconfig-002-20260806    gcc-14
i386       buildonly-randconfig-003-20260806    clang-22
i386       buildonly-randconfig-003-20260806    gcc-14
i386       buildonly-randconfig-004-20260806    clang-22
i386       buildonly-randconfig-004-20260806    gcc-14
i386       buildonly-randconfig-005-20260806    gcc-14
i386       buildonly-randconfig-006-20260806    gcc-14
i386                 randconfig-001-20260806    clang-22
i386                 randconfig-001-20260806    gcc-14
i386                 randconfig-002-20260806    clang-22
i386                 randconfig-003-20260806    clang-22
i386                 randconfig-003-20260806    gcc-14
i386                 randconfig-004-20260806    clang-22
i386                 randconfig-005-20260806    clang-22
i386                 randconfig-006-20260806    clang-22
i386                 randconfig-007-20260806    clang-22
i386                 randconfig-007-20260806    gcc-14
i386                 randconfig-011-20260806    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-012-20260806    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-013-20260806    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-014-20260806    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-015-20260806    clang-22
i386                 randconfig-015-20260806    gcc-13
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-016-20260806    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-017-20260806    clang-22
i386                 randconfig-017-20260807    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260806    clang-22
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-002-20260806    clang-24
loongarch            randconfig-002-20260807    clang-18
m68k                      m5208evb_defconfig    gcc-16.1.0
m68k                         sun3x_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-001-20260806    gcc-9.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-002-20260806    clang-24
nios2                randconfig-002-20260806    gcc-11.5.0
nios2                randconfig-002-20260807    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260806    gcc-8.5.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-002-20260806    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-001-20260806    gcc-11.5.0
powerpc              randconfig-001-20260806    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-002-20260806    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260806    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260806    clang-22
powerpc64            randconfig-002-20260806    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
riscv                randconfig-002-20260806    gcc-8.5.0
riscv                randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-001-20260806    clang-24
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-002-20260806    clang-24
s390                 randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-002-20260807    gcc-12.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260806    gcc-11.5.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sh                   randconfig-002-20260806    gcc-16.1.0
sh                   randconfig-002-20260807    gcc-12.5.0
sh                          se7705_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260806    gcc-16.1.0
sparc                randconfig-001-20260807    gcc-16.1.0
sparc                randconfig-002-20260806    gcc-8.5.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-001-20260806    clang-20
sparc64              randconfig-001-20260807    gcc-16.1.0
sparc64              randconfig-002-20260806    gcc-8.5.0
sparc64              randconfig-002-20260807    gcc-16.1.0
um                   randconfig-001-20260806    gcc-14
um                   randconfig-001-20260807    gcc-16.1.0
um                   randconfig-002-20260806    gcc-14
um                   randconfig-002-20260807    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-003-20260806    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-005-20260806    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64     buildonly-randconfig-006-20260806    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260806    clang-22
x86_64               randconfig-001-20260807    clang-22
x86_64               randconfig-002-20260806    clang-22
x86_64               randconfig-002-20260807    clang-22
x86_64               randconfig-003-20260806    clang-22
x86_64               randconfig-003-20260806    gcc-14
x86_64               randconfig-003-20260807    clang-22
x86_64               randconfig-004-20260806    clang-22
x86_64               randconfig-004-20260807    clang-22
x86_64               randconfig-005-20260806    clang-22
x86_64               randconfig-005-20260807    clang-22
x86_64               randconfig-006-20260806    clang-22
x86_64               randconfig-006-20260806    gcc-14
x86_64               randconfig-006-20260807    clang-22
x86_64               randconfig-011-20260806    clang-22
x86_64               randconfig-011-20260807    clang-22
x86_64               randconfig-012-20260806    clang-22
x86_64               randconfig-012-20260806    gcc-12
x86_64               randconfig-012-20260807    clang-22
x86_64               randconfig-013-20260806    clang-22
x86_64               randconfig-013-20260807    clang-22
x86_64               randconfig-014-20260806    clang-22
x86_64               randconfig-014-20260807    clang-22
x86_64               randconfig-015-20260806    clang-22
x86_64               randconfig-015-20260807    clang-22
x86_64               randconfig-016-20260806    clang-22
x86_64               randconfig-016-20260806    gcc-14
x86_64               randconfig-016-20260807    clang-22
x86_64               randconfig-071-20260806    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-072-20260806    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-073-20260806    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-074-20260806    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-075-20260806    clang-22
x86_64               randconfig-075-20260806    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-076-20260806    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260806    gcc-14.3.0
xtensa               randconfig-001-20260807    gcc-16.1.0
xtensa               randconfig-002-20260806    gcc-16.1.0
xtensa               randconfig-002-20260807    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
