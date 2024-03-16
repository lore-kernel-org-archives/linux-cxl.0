Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB5DDA0
	for <linux-cxl@vger.kernel.org>; Sat, 16 Mar 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574183; cv=none; b=M3bOKfaISsU5QDH9gQpPBXV/xsFdhI101Uh84F/0Chgl6jHX3yxrlXjn2lgF6Amwf4BhPAhiBq2n+IoEwujr6U4GsfUCUXkb9rNOREaw/Q3vgyp436ER2mY6/aQ0ufbSyhs72oVDEmksN4YmVTcYhZd0ONDi19Zme//USXFO4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574183; c=relaxed/simple;
	bh=9FCxcMIR9055xtTY0BLwSPVWRAABkeaZle+NfLdT05Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h77FQDzJtD2fjxLY/WbUMLZYHqTh6rnGzQIU/J1QtgOX0b2puHcnEBDCSddXO7kTz5w13CIXSf2lY+cwrTiMg4S8axjfkCSRXyv1AiNJjLeIsMwhIxY3oZ5dHatTJTJSn5VjQ34fIcwAmCZGFG+bR7fmBQwbqnOi26BK1HjuUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3O0+rnm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3O0+rnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710574181; x=1742110181;
  h=date:from:to:cc:subject:message-id;
  bh=9FCxcMIR9055xtTY0BLwSPVWRAABkeaZle+NfLdT05Y=;
  b=i3O0+rnmxA89pYtjsv9IbzQ/dXZHlgMfcixgciyHp/TCHEQXotNXeI7d
   aC7Bq31X0WnmJHP4YiBDhxhAknR7+P/O0pgFas7XnbhmHzpHQy05l+kE7
   5YAqE8cxivenjyesf7//7P9i5Wlr+yrS6fS3gzqV3FLaO6tWxh+z9tBtD
   BpJmRuEd3NVJvFi0XqRqpLaJhdBUs/pJt8HeBUfUj5jZuYpm4vnobfKQe
   oxrroDSDjhYX/VfqMN9XBNPiGsdP/y0xy8cd/SiycY0jSc1a5McWwCVL1
   NHjXZL+F1j3jD10FJAIzEecimRjPU5YtvAaG/w4XMphONQkbLWgfAxDMg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="9229010"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="9229010"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17623817"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Mar 2024 00:29:39 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlOU4-000FAT-01;
	Sat, 16 Mar 2024 07:29:36 +0000
Date: Sat, 16 Mar 2024 15:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 ed1ff2fba7afa7baca7ceb93824a4699130b8377
Message-ID: <202403161548.xqJm4Wlv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: ed1ff2fba7afa7baca7ceb93824a4699130b8377  Merge branch 'for-6.9/cxl-einj' into for-6.9/cxl

elapsed time: 722m

configs tested: 181
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240316   gcc  
arc                   randconfig-002-20240316   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                            mps2_defconfig   clang
arm                   randconfig-001-20240316   gcc  
arm                   randconfig-002-20240316   gcc  
arm                   randconfig-003-20240316   gcc  
arm                   randconfig-004-20240316   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240316   gcc  
arm64                 randconfig-002-20240316   clang
arm64                 randconfig-003-20240316   clang
arm64                 randconfig-004-20240316   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240316   gcc  
csky                  randconfig-002-20240316   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240316   clang
hexagon               randconfig-002-20240316   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240316   clang
i386         buildonly-randconfig-002-20240316   gcc  
i386         buildonly-randconfig-003-20240316   gcc  
i386         buildonly-randconfig-004-20240316   gcc  
i386         buildonly-randconfig-005-20240316   gcc  
i386         buildonly-randconfig-006-20240316   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240316   gcc  
i386                  randconfig-002-20240316   gcc  
i386                  randconfig-003-20240316   gcc  
i386                  randconfig-004-20240316   gcc  
i386                  randconfig-005-20240316   clang
i386                  randconfig-006-20240316   gcc  
i386                  randconfig-011-20240316   clang
i386                  randconfig-012-20240316   clang
i386                  randconfig-013-20240316   clang
i386                  randconfig-014-20240316   clang
i386                  randconfig-015-20240316   clang
i386                  randconfig-016-20240316   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240316   gcc  
loongarch             randconfig-002-20240316   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   clang
mips                     loongson1c_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240316   gcc  
nios2                 randconfig-002-20240316   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240316   gcc  
parisc                randconfig-002-20240316   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc               randconfig-001-20240316   clang
powerpc               randconfig-002-20240316   clang
powerpc               randconfig-003-20240316   gcc  
powerpc64             randconfig-001-20240316   gcc  
powerpc64             randconfig-002-20240316   gcc  
powerpc64             randconfig-003-20240316   clang
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240316   gcc  
riscv                 randconfig-002-20240316   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240316   clang
s390                  randconfig-002-20240316   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240316   gcc  
sh                    randconfig-002-20240316   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240316   gcc  
sparc64               randconfig-002-20240316   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240316   clang
um                    randconfig-002-20240316   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240316   clang
x86_64       buildonly-randconfig-002-20240316   gcc  
x86_64       buildonly-randconfig-003-20240316   gcc  
x86_64       buildonly-randconfig-004-20240316   gcc  
x86_64       buildonly-randconfig-005-20240316   gcc  
x86_64       buildonly-randconfig-006-20240316   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240316   gcc  
x86_64                randconfig-002-20240316   clang
x86_64                randconfig-003-20240316   clang
x86_64                randconfig-004-20240316   clang
x86_64                randconfig-005-20240316   clang
x86_64                randconfig-006-20240316   gcc  
x86_64                randconfig-011-20240316   clang
x86_64                randconfig-012-20240316   gcc  
x86_64                randconfig-013-20240316   gcc  
x86_64                randconfig-014-20240316   clang
x86_64                randconfig-015-20240316   gcc  
x86_64                randconfig-016-20240316   gcc  
x86_64                randconfig-071-20240316   clang
x86_64                randconfig-072-20240316   gcc  
x86_64                randconfig-073-20240316   gcc  
x86_64                randconfig-074-20240316   gcc  
x86_64                randconfig-075-20240316   clang
x86_64                randconfig-076-20240316   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240316   gcc  
xtensa                randconfig-002-20240316   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
