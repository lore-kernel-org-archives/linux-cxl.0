Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE879DD
	for <linux-cxl@vger.kernel.org>; Wed, 13 Mar 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359647; cv=none; b=eIpfgkLMwpK7vMNOUziRdDND9eta0E/xtIMkklBrBqj0KpspWTihsyKInpQoexdneI8S4ZBWx82dPq6MPqzQE1PGvOJwIX0ameM5oAf4rv2cX6CFLxjMambL5kUictpIoqSCWWHN5eFN0B85OYc+k7UIeZgtW7Yg2cEkAg78ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359647; c=relaxed/simple;
	bh=73iGg+/d6nmylWjJytVMTIfEExiUKvUHXGiaMuNeCsM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cti9oPEzs7X9LvVZ789KkXtoNzVgLONX/hWCHyUuGF9PnYrNJZX4loYP5qjRZbZWOmqi+y6H6vTSpaEqz/D9DAF85E7m9Rz6AMJtlb7v88uSB4Jw/vz9DU0msZauXEH5p0aNwrWRPxWR/AW0S9EtZ0j5RVV017rvGOLSByyjK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNTSCBvd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNTSCBvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710359645; x=1741895645;
  h=date:from:to:cc:subject:message-id;
  bh=73iGg+/d6nmylWjJytVMTIfEExiUKvUHXGiaMuNeCsM=;
  b=fNTSCBvdUMS7fVVYh+SdH6kuNYyg38NUtuFtynUFEdQ3WFT++GEZEYkj
   BKN1+ub5+sEmQf+3sF/G2/rpQUj+71L4RLJEjidrX/GHpAoAVmqRZHJVI
   jDx6cWt3HiB7ulslUNTHQOIWyzIP5FPA0motUOXQ5fOrXkeClbiY8wq1i
   q+bY0riWXcSldTdJjrsrgsUYpBgu545Bm7M0KI0NqAlTyz+EuhyJd+OKo
   kFXifkj9DkI3gvl4V4vm3cGr3TVOE0AL9lLQKidsfos0dbcJJC3r1Oi1Y
   NlLgejN+OwJmJol0jx/CqQULJPnIsu6tjCAhxuB8LEXLLQkjWw8xf+rtl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8972403"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8972403"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="11929017"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Mar 2024 12:54:02 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkUfo-000Cig-01;
	Wed, 13 Mar 2024 19:54:00 +0000
Date: Thu, 14 Mar 2024 03:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 88482878c3b4abc2a6e66e016cc01eacbdc5b0ed
Message-ID: <202403140342.Q115gQ43-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 88482878c3b4abc2a6e66e016cc01eacbdc5b0ed  Merge branch 'for-6.9/cxl-fixes' into for-6.9/cxl

elapsed time: 737m

configs tested: 192
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240313   gcc  
arc                   randconfig-002-20240313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                   randconfig-001-20240313   gcc  
arm                   randconfig-002-20240313   clang
arm                   randconfig-003-20240313   gcc  
arm                   randconfig-004-20240313   clang
arm                          sp7021_defconfig   gcc  
arm                        spear6xx_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240313   clang
arm64                 randconfig-002-20240313   clang
arm64                 randconfig-003-20240313   clang
arm64                 randconfig-004-20240313   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240313   gcc  
csky                  randconfig-002-20240313   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240313   clang
hexagon               randconfig-002-20240313   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-016-20240313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240313   gcc  
loongarch             randconfig-002-20240313   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                         rt305x_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240313   gcc  
nios2                 randconfig-002-20240313   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240313   gcc  
parisc                randconfig-002-20240313   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc               randconfig-001-20240313   gcc  
powerpc               randconfig-002-20240313   gcc  
powerpc               randconfig-003-20240313   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240313   clang
powerpc64             randconfig-002-20240313   gcc  
powerpc64             randconfig-003-20240313   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240313   clang
riscv                 randconfig-002-20240313   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240313   gcc  
s390                  randconfig-002-20240313   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240313   gcc  
sh                    randconfig-002-20240313   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240313   gcc  
sparc64               randconfig-002-20240313   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240313   gcc  
um                    randconfig-002-20240313   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240313   clang
x86_64       buildonly-randconfig-002-20240313   gcc  
x86_64       buildonly-randconfig-003-20240313   clang
x86_64       buildonly-randconfig-004-20240313   clang
x86_64       buildonly-randconfig-005-20240313   gcc  
x86_64       buildonly-randconfig-006-20240313   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240313   clang
x86_64                randconfig-002-20240313   gcc  
x86_64                randconfig-003-20240313   clang
x86_64                randconfig-004-20240313   gcc  
x86_64                randconfig-005-20240313   gcc  
x86_64                randconfig-006-20240313   clang
x86_64                randconfig-011-20240313   clang
x86_64                randconfig-012-20240313   clang
x86_64                randconfig-013-20240313   clang
x86_64                randconfig-014-20240313   clang
x86_64                randconfig-015-20240313   gcc  
x86_64                randconfig-016-20240313   gcc  
x86_64                randconfig-071-20240313   gcc  
x86_64                randconfig-072-20240313   clang
x86_64                randconfig-073-20240313   clang
x86_64                randconfig-074-20240313   gcc  
x86_64                randconfig-075-20240313   clang
x86_64                randconfig-076-20240313   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
