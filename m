Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6A2F24
	for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201838; cv=none; b=U2kwXUu9TEuGVVodCjefxziNG1nplJYFrCureWY6IGYJxEOsd4KV8aEBkgpaACyN96eBqGzf8nURXCHJqkcSyzNDWi8XCW6SXGoU1eBaIAMGwDIblcLmy7baaamarV8rc66RyJ0IYBPoWNQFExZKpQgmEhAz3wza1gBdGQE8EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201838; c=relaxed/simple;
	bh=giwx0jNRcr7JEOqx5iYkypFTb0vedIzv1BSirXqHZLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kjmQlqidSFbKUJoQYWijK9KyhWjiMlH1PctRfn0SMH+YuuK7cFZ7LiOKhugGETN9J729EflQANfaQTj9EO9B1NfwMF1JEUDIGVjfhJ+xf4V5gfIAnUcuS/9U8wGStakI5BMvohXw/xCm6JADBnk26rjcdccUDeFUft1KOvLe2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTiG3274; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTiG3274"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726201837; x=1757737837;
  h=date:from:to:cc:subject:message-id;
  bh=giwx0jNRcr7JEOqx5iYkypFTb0vedIzv1BSirXqHZLc=;
  b=UTiG3274bRFUOxE9ITUE+GqEGPSYBSvxT3s4zKP6ggEro/7Z/XDnz8Bp
   Qy7qtwR+ykMe0Yy5lb7VAv4C/rEZhHZZWT8YVaPJjiGsGPObZt1/GXf4E
   tx5gf+7Z9Cz+6665beejdzF/RnqOPEdk8UxRFW3l8ZBUnoy9oYdLM7bKY
   TOaTSIx7kguUqAmflB4nWT1TS0mqLZg32bEWAiCXopB3erzinJfyrUGBj
   cZS2fQJDShGmQ2JFRGmRiHA8kySkr0VWm+K1NR8KX7Ygh963sxd7j4zj8
   jFiFX0KFxjb0Q88ZswLWk796XFkJfhzDvroMY86s6RX4hEWiqYPi4AO57
   w==;
X-CSE-ConnectionGUID: GrZhedjgTxSdB1MZSYi11g==
X-CSE-MsgGUID: 39xQTniSQKCZ7tNAXeEG3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="28868709"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="28868709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:30:36 -0700
X-CSE-ConnectionGUID: Uv1pOte9QESrIGauAwqwIQ==
X-CSE-MsgGUID: mQuTpA4hQ2uOelkEa3BwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="91189726"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2024 21:30:34 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soxx1-00060s-2Q;
	Fri, 13 Sep 2024 04:30:31 +0000
Date: Fri, 13 Sep 2024 12:30:19 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 b5209da36b19b573cf25fe7e698e3a45b0f40a75
Message-ID: <202409131210.UJ5kCWt7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: b5209da36b19b573cf25fe7e698e3a45b0f40a75  cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input

elapsed time: 731m

configs tested: 178
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                   randconfig-001-20240913    gcc-13.2.0
arc                   randconfig-002-20240913    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                          ep93xx_defconfig    clang-14
arm                      integrator_defconfig    clang-20
arm                   randconfig-001-20240913    gcc-14.1.0
arm                   randconfig-002-20240913    gcc-14.1.0
arm                   randconfig-003-20240913    gcc-14.1.0
arm                   randconfig-004-20240913    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm64                            alldefconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240913    clang-15
arm64                 randconfig-002-20240913    clang-20
arm64                 randconfig-003-20240913    gcc-14.1.0
arm64                 randconfig-004-20240913    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240913    gcc-14.1.0
csky                  randconfig-002-20240913    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20240913    clang-20
hexagon               randconfig-002-20240913    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240913    clang-18
i386        buildonly-randconfig-002-20240913    gcc-12
i386        buildonly-randconfig-003-20240913    gcc-12
i386        buildonly-randconfig-004-20240913    gcc-12
i386        buildonly-randconfig-005-20240913    clang-18
i386        buildonly-randconfig-006-20240913    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240913    gcc-12
i386                  randconfig-002-20240913    gcc-12
i386                  randconfig-003-20240913    gcc-12
i386                  randconfig-004-20240913    clang-18
i386                  randconfig-005-20240913    clang-18
i386                  randconfig-006-20240913    clang-18
i386                  randconfig-011-20240913    gcc-11
i386                  randconfig-012-20240913    gcc-12
i386                  randconfig-013-20240913    gcc-12
i386                  randconfig-014-20240913    gcc-12
i386                  randconfig-015-20240913    gcc-11
i386                  randconfig-016-20240913    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240913    gcc-14.1.0
loongarch             randconfig-002-20240913    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       bvme6000_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240913    gcc-14.1.0
nios2                 randconfig-002-20240913    gcc-14.1.0
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
parisc                randconfig-001-20240913    gcc-14.1.0
parisc                randconfig-002-20240913    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20240913    clang-17
powerpc64             randconfig-001-20240913    clang-20
powerpc64             randconfig-002-20240913    clang-20
powerpc64             randconfig-003-20240913    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240913    gcc-14.1.0
riscv                 randconfig-002-20240913    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20240913    clang-16
s390                  randconfig-002-20240913    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240913    gcc-14.1.0
sh                    randconfig-002-20240913    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240913    gcc-14.1.0
sparc64               randconfig-002-20240913    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240913    gcc-12
um                    randconfig-002-20240913    clang-17
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240913    clang-18
x86_64      buildonly-randconfig-002-20240913    gcc-12
x86_64      buildonly-randconfig-003-20240913    clang-18
x86_64      buildonly-randconfig-004-20240913    clang-18
x86_64      buildonly-randconfig-005-20240913    gcc-12
x86_64      buildonly-randconfig-006-20240913    clang-18
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20240913    gcc-12
x86_64                randconfig-002-20240913    clang-18
x86_64                randconfig-003-20240913    gcc-12
x86_64                randconfig-004-20240913    clang-18
x86_64                randconfig-005-20240913    clang-18
x86_64                randconfig-006-20240913    gcc-12
x86_64                randconfig-011-20240913    gcc-12
x86_64                randconfig-012-20240913    clang-18
x86_64                randconfig-013-20240913    clang-18
x86_64                randconfig-014-20240913    clang-18
x86_64                randconfig-015-20240913    gcc-12
x86_64                randconfig-016-20240913    gcc-12
x86_64                randconfig-071-20240913    clang-18
x86_64                randconfig-072-20240913    gcc-12
x86_64                randconfig-073-20240913    gcc-12
x86_64                randconfig-074-20240913    gcc-12
x86_64                randconfig-075-20240913    clang-18
x86_64                randconfig-076-20240913    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240913    gcc-14.1.0
xtensa                randconfig-002-20240913    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
