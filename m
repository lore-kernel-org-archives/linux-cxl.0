Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCB16426
	for <linux-cxl@vger.kernel.org>; Mon, 23 Sep 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115225; cv=none; b=kLsKTJLoBOnznQU1Ifli67CknH113St/GBUZI8bMTSjQ03mBmX3QmlEg8/IFdTyJujS9e5nEtqRMXDOwvxqZ+lR6h2612OhdFymewF8eX2N/7Lirem4HefLxHCaMvY2lWoI86l+sFB/aJTN73WezfncZkR0eV2/PEqJvdCKPJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115225; c=relaxed/simple;
	bh=LkvWArek+ZksGO+u1cWMMTrmfc2H2Q2RxZaEs+HmN1o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Onxhm0aqevnqKFYm06j60zeQJlrQCf3hpAm5mlAbp3SvZ6BVvK4vwLM/7X3YYjPDrLGlxO0Cg27nEtbHvSBPQMWvoS2cZoSmuhRZtKyu1XcY8KNa0DVUnETrit3VZOqvI7EjBW6OMYfjFYFvOmtIQcPsZ3pM4ShP0uX/K/BIVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2sbxdWm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2sbxdWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727115223; x=1758651223;
  h=date:from:to:cc:subject:message-id;
  bh=LkvWArek+ZksGO+u1cWMMTrmfc2H2Q2RxZaEs+HmN1o=;
  b=V2sbxdWmSfja48tT6DxMMtGx81B8ObWD1tkKM7QrFpY/92EmG8yKRvHL
   6EC8tlQbMVm/we7hQcpFj2neUuzp1acAjzhUKfRzNhvrlEyFMHOgOYPg6
   2Y50/QEHjcXlnYXmrMVMB2wdDZkfVUFgW8NozkBrX728d4b19ctguzw5Q
   Ik6P4O6568bJyCDDljTh0Uk3CxQ1+P6bH4ml+Z4MVqgBl0uqQt1Q5aU52
   eCFVjSJyFZccJBCmFYwQIXnMcoDVtwQVEwiMNMurLfTQ/TGE6ozIvUvAo
   cEnlo9LylRVoZ/CFPzHMcMjAqYflFhry8CTZeNLTW9RL16/+A/IfWENJt
   A==;
X-CSE-ConnectionGUID: IkbqoLXIRPmoF+jeQoCfaw==
X-CSE-MsgGUID: WLlvvQaTTxWOsXwuaE4Lhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36649209"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="36649209"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 11:13:42 -0700
X-CSE-ConnectionGUID: adJBooKJS0S2AXZtBvs1vQ==
X-CSE-MsgGUID: jya3FA+sRkiHh7RR7LODWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="75263039"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2024 11:13:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssnZ3-000HUU-1r;
	Mon, 23 Sep 2024 18:13:37 +0000
Date: Tue, 24 Sep 2024 02:13:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 2c70677dabb5e326467160e28915b804b925b53b
Message-ID: <202409240218.LffGl9g8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 2c70677dabb5e326467160e28915b804b925b53b  cxl: Add documentation to explain the shared link bandwidth calculation

elapsed time: 722m

configs tested: 291
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-20
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240923    clang-20
arc                   randconfig-001-20240923    gcc-13.2.0
arc                   randconfig-002-20240923    clang-20
arc                   randconfig-002-20240923    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                         at91_dt_defconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                          exynos_defconfig    clang-20
arm                          ixp4xx_defconfig    clang-20
arm                       multi_v4t_defconfig    clang-20
arm                        mvebu_v7_defconfig    clang-15
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20240923    clang-20
arm                   randconfig-001-20240923    gcc-14.1.0
arm                   randconfig-002-20240923    clang-20
arm                   randconfig-003-20240923    clang-20
arm                   randconfig-004-20240923    clang-20
arm                   randconfig-004-20240923    gcc-14.1.0
arm                        spear3xx_defconfig    clang-16
arm                         vf610m4_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240923    clang-20
arm64                 randconfig-002-20240923    clang-20
arm64                 randconfig-003-20240923    clang-20
arm64                 randconfig-004-20240923    clang-20
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240923    clang-20
csky                  randconfig-001-20240923    gcc-14.1.0
csky                  randconfig-002-20240923    clang-20
csky                  randconfig-002-20240923    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240923    clang-15
hexagon               randconfig-001-20240923    clang-20
hexagon               randconfig-002-20240923    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240923    clang-18
i386        buildonly-randconfig-001-20240923    gcc-11
i386        buildonly-randconfig-002-20240923    clang-18
i386        buildonly-randconfig-002-20240923    gcc-11
i386        buildonly-randconfig-003-20240923    gcc-11
i386        buildonly-randconfig-003-20240923    gcc-12
i386        buildonly-randconfig-004-20240923    clang-18
i386        buildonly-randconfig-004-20240923    gcc-11
i386        buildonly-randconfig-005-20240923    gcc-11
i386        buildonly-randconfig-005-20240923    gcc-12
i386        buildonly-randconfig-006-20240923    clang-18
i386        buildonly-randconfig-006-20240923    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240923    clang-18
i386                  randconfig-001-20240923    gcc-11
i386                  randconfig-002-20240923    clang-18
i386                  randconfig-002-20240923    gcc-11
i386                  randconfig-003-20240923    clang-18
i386                  randconfig-003-20240923    gcc-11
i386                  randconfig-004-20240923    gcc-11
i386                  randconfig-004-20240923    gcc-12
i386                  randconfig-005-20240923    gcc-11
i386                  randconfig-006-20240923    clang-18
i386                  randconfig-006-20240923    gcc-11
i386                  randconfig-011-20240923    clang-18
i386                  randconfig-011-20240923    gcc-11
i386                  randconfig-012-20240923    gcc-11
i386                  randconfig-012-20240923    gcc-12
i386                  randconfig-013-20240923    gcc-11
i386                  randconfig-013-20240923    gcc-12
i386                  randconfig-014-20240923    gcc-11
i386                  randconfig-014-20240923    gcc-12
i386                  randconfig-015-20240923    gcc-11
i386                  randconfig-015-20240923    gcc-12
i386                  randconfig-016-20240923    gcc-11
i386                  randconfig-016-20240923    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240923    clang-20
loongarch             randconfig-001-20240923    gcc-14.1.0
loongarch             randconfig-002-20240923    clang-20
loongarch             randconfig-002-20240923    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                      maltaaprp_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240923    clang-20
nios2                 randconfig-001-20240923    gcc-14.1.0
nios2                 randconfig-002-20240923    clang-20
nios2                 randconfig-002-20240923    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240923    clang-20
parisc                randconfig-001-20240923    gcc-14.1.0
parisc                randconfig-002-20240923    clang-20
parisc                randconfig-002-20240923    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                   microwatt_defconfig    gcc-13.2.0
powerpc                     mpc5200_defconfig    gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc               randconfig-001-20240923    clang-20
powerpc               randconfig-002-20240923    clang-20
powerpc               randconfig-003-20240923    clang-20
powerpc               randconfig-003-20240923    gcc-14.1.0
powerpc                     skiroot_defconfig    clang-20
powerpc                  storcenter_defconfig    clang-20
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc                     tqm8560_defconfig    clang-20
powerpc                         wii_defconfig    clang-20
powerpc64                        alldefconfig    clang-17
powerpc64             randconfig-001-20240923    clang-20
powerpc64             randconfig-002-20240923    clang-20
powerpc64             randconfig-003-20240923    clang-20
powerpc64             randconfig-003-20240923    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240923    clang-20
riscv                 randconfig-001-20240923    gcc-14.1.0
riscv                 randconfig-002-20240923    clang-20
riscv                 randconfig-002-20240923    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20240923    clang-20
s390                  randconfig-001-20240923    gcc-14.1.0
s390                  randconfig-002-20240923    clang-20
s390                  randconfig-002-20240923    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    clang-20
sh                          lboxre2_defconfig    gcc-14.1.0
sh                    randconfig-001-20240923    clang-20
sh                    randconfig-001-20240923    gcc-14.1.0
sh                    randconfig-002-20240923    clang-20
sh                    randconfig-002-20240923    gcc-14.1.0
sh                           se7721_defconfig    clang-20
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                   sh7770_generic_defconfig    clang-20
sh                   sh7770_generic_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240923    clang-20
sparc64               randconfig-001-20240923    gcc-14.1.0
sparc64               randconfig-002-20240923    clang-20
sparc64               randconfig-002-20240923    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240923    clang-20
um                    randconfig-002-20240923    clang-20
um                    randconfig-002-20240923    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240923    clang-18
x86_64      buildonly-randconfig-002-20240923    clang-18
x86_64      buildonly-randconfig-003-20240923    clang-18
x86_64      buildonly-randconfig-004-20240923    clang-18
x86_64      buildonly-randconfig-004-20240923    gcc-12
x86_64      buildonly-randconfig-005-20240923    clang-18
x86_64      buildonly-randconfig-005-20240923    gcc-12
x86_64      buildonly-randconfig-006-20240923    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240923    clang-18
x86_64                randconfig-001-20240923    gcc-12
x86_64                randconfig-002-20240923    clang-18
x86_64                randconfig-002-20240923    gcc-12
x86_64                randconfig-003-20240923    clang-18
x86_64                randconfig-004-20240923    clang-18
x86_64                randconfig-005-20240923    clang-18
x86_64                randconfig-005-20240923    gcc-12
x86_64                randconfig-006-20240923    clang-18
x86_64                randconfig-011-20240923    clang-18
x86_64                randconfig-012-20240923    clang-18
x86_64                randconfig-013-20240923    clang-18
x86_64                randconfig-013-20240923    gcc-12
x86_64                randconfig-014-20240923    clang-18
x86_64                randconfig-015-20240923    clang-18
x86_64                randconfig-015-20240923    gcc-12
x86_64                randconfig-016-20240923    clang-18
x86_64                randconfig-016-20240923    gcc-12
x86_64                randconfig-071-20240923    clang-18
x86_64                randconfig-072-20240923    clang-18
x86_64                randconfig-072-20240923    gcc-12
x86_64                randconfig-073-20240923    clang-18
x86_64                randconfig-074-20240923    clang-18
x86_64                randconfig-074-20240923    gcc-12
x86_64                randconfig-075-20240923    clang-18
x86_64                randconfig-076-20240923    clang-18
x86_64                randconfig-076-20240923    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-func    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20
xtensa                randconfig-001-20240923    clang-20
xtensa                randconfig-001-20240923    gcc-14.1.0
xtensa                randconfig-002-20240923    clang-20
xtensa                randconfig-002-20240923    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
