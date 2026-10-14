Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B41DDC38
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965452; cv=none; b=chgk6EG06iQvj9OVEbcAHeMULpx7C5MFiSUcGNpeQ577PjzG0sToqNDGXaPksdzysue496tAcd0y4q0VGBxS/JOO1a1CrG0/T1SUXrEgCM1f2xCyqbbkcPZlB0Ds7hznY7g04dakua6HuYUXihfRXtQ0pQFAfwryVMZSWv04BeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965452; c=relaxed/simple;
	bh=QJNu+OT13GDuM29oNR8tuTxbQdIK1kGBU0O7VA+asIQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eVZDHLvkRW+vCuYbKd2dUo4sQaky7j1/yKEl1HxX6c8cFDLb1GNlE/NGERHOPtoj0SlcUzcB1z6WVFv+IN8kH8cA9sB/+Ity1kBEC+SnqJDUGAof1q7YWvkkN8May27VJ/MDCVShol1TKoiOJGNzAPznqm+68g95LCMDO5HAqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXZSGGfg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXZSGGfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791965451; x=1823501451;
  h=date:from:to:cc:subject:message-id;
  bh=QJNu+OT13GDuM29oNR8tuTxbQdIK1kGBU0O7VA+asIQ=;
  b=BXZSGGfgggY7t76jQBIPvDJNhNjweYdappygHkt8lixuOy556y3PRUfy
   ASQok6nABBgqoQ/ZJftKgW9POeYnQA8aU13Crig1ehGacFI/E+croPQ/z
   +UfweLD63GSZRzLVnATOTUlcqunRVo6jHSBAuAIN8voCe07xaFjVKS4Qw
   Q/9GGS/YJHTe9i6VhSeHTz1FhOfBW0v85TEj3Y9XD2FG70WuBNSmXCZkZ
   +xyBC7UZ4orRes44nzbvOa/maEAhAKmWXHQTjD0PXFA9xk5IgpA89ewLI
   hjjTUp4DNMe8RAPwxorSSVfGtWcQL+jSgw5e0EeotkJj39r3Pc0kjrXk1
   Q==;
X-CSE-ConnectionGUID: VGgrzUrlRq2XHh4czB29bw==
X-CSE-MsgGUID: O6IpnAz0TEG8NtV1cP3A9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="721720"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="721720"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 01:10:50 -0700
X-CSE-ConnectionGUID: qRQQ+rGNRwWB12zMM5qKlg==
X-CSE-MsgGUID: DSW+ZQY6SSCxmKgKaJ7etg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1718264"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2026 01:10:48 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGu4U-00000000EMV-0XqH;
	Wed, 14 Oct 2026 08:10:46 +0000
Date: Wed, 14 Oct 2026 16:10:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 d304df5f329302fff4658cd6ed8f93aec4b94d27
Message-ID: <202610141633.H3bZyEc2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: d304df5f329302fff4658cd6ed8f93aec4b94d27  Merge branch 'for-7.4/cxl-dcd' into cxl-for-next

elapsed time: 909m

configs tested: 195
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261014    clang-17
arc                   randconfig-1000-20261014    gcc-15.2.0
arc                   randconfig-1001-20261014    clang-17
arc                   randconfig-1001-20261014    gcc-13.4.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           pxa168_defconfig    clang-24
arm                   randconfig-1000-20261014    clang-17
arm                   randconfig-1001-20261014    clang-17
arm                   randconfig-1001-20261014    clang-19
arm                   randconfig-1002-20261014    clang-17
arm                   randconfig-1003-20261014    clang-17
arm                     vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261014    clang-24
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1001-20261014    gcc-9.5.0
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261014    clang-17
hexagon               randconfig-1000-20261014    clang-18
hexagon               randconfig-1001-20261014    clang-18
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261014    clang-22
i386                  randconfig-1000-20261014    gcc-14
i386                  randconfig-1001-20261014    clang-22
i386                  randconfig-1002-20261014    clang-22
i386                  randconfig-1003-20261014    clang-22
i386                  randconfig-1003-20261014    gcc-14
i386                  randconfig-1004-20261014    clang-22
i386                  randconfig-1004-20261014    gcc-14
i386                  randconfig-1005-20261014    clang-22
i386                  randconfig-1006-20261014    clang-22
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    clang-24
loongarch             randconfig-1000-20261014    clang-18
loongarch             randconfig-1000-20261014    gcc-12.5.0
loongarch             randconfig-1001-20261014    clang-18
loongarch             randconfig-1001-20261014    gcc-16.1.0
m68k                              alldefconfig    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20261014    clang-18
nios2                 randconfig-1000-20261014    gcc-8.5.0
nios2                 randconfig-1001-20261014    clang-18
nios2                 randconfig-1001-20261014    gcc-9.5.0
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                    de0_nano_defconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261014    clang-22
parisc                randconfig-1000-20261014    gcc-8.5.0
parisc                randconfig-1001-20261014    clang-22
parisc                randconfig-1001-20261014    gcc-15.2.0
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                   iss476-smp_defconfig    gcc-16.1.0
powerpc                       pasemi_defconfig    gcc-16.1.0
powerpc                       pcm030_defconfig    clang-24
powerpc               randconfig-1000-20261014    clang-19
powerpc               randconfig-1000-20261014    clang-22
powerpc               randconfig-1001-20261014    clang-22
powerpc64             randconfig-1000-20261014    clang-22
powerpc64             randconfig-1000-20261014    clang-24
powerpc64             randconfig-1001-20261014    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20261014    clang-18
riscv                 randconfig-1001-20261014    clang-17
s390                               allnoconfig    clang-24
s390                           debug_defconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20261014    gcc-8.5.0
s390                  randconfig-1001-20261014    clang-24
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                          ap325rxa_defconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                         dreamcast_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261014    gcc-15.2.0
sh                    randconfig-1001-20261014    gcc-16.1.0
sh                            se7619_defconfig    gcc-16.1.0
sh                             shmin_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261014    gcc-11.5.0
sparc                 randconfig-1001-20261014    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20261014    clang-22
sparc64               randconfig-1001-20261014    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261014    gcc-14
um                    randconfig-1001-20261014    clang-24
um                            x86_64_defconfig    clang-24
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261014    gcc-14
x86_64      buildonly-randconfig-1001-20261014    clang-22
x86_64      buildonly-randconfig-1002-20261014    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261014    clang-22
x86_64                randconfig-1001-20261014    clang-22
x86_64                randconfig-1002-20261014    gcc-14
x86_64                randconfig-1003-20261014    clang-22
x86_64                randconfig-1004-20261014    gcc-14
x86_64                randconfig-1005-20261014    clang-22
x86_64                randconfig-1006-20261014    clang-22
x86_64                randconfig-1007-20261014    gcc-14
x86_64                randconfig-1008-20261014    gcc-14
x86_64                randconfig-1009-20261014    clang-22
x86_64                randconfig-1010-20261014    gcc-14
x86_64                randconfig-1011-20261014    gcc-14
x86_64                randconfig-1012-20261014    clang-22
x86_64                randconfig-1013-20261014    gcc-14
x86_64                randconfig-1014-20261014    clang-22
x86_64                randconfig-1015-20261014    gcc-14
x86_64                randconfig-1016-20261014    clang-22
x86_64                randconfig-1017-20261014    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20261014    gcc-13.4.0
xtensa                randconfig-1001-20261014    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
