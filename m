Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848902E0926
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083287; cv=none; b=XtTi7qCQKfN2fZCiyohRwXIIzoUuOduYPBWydAB8HspHwFNHuvj0d4rFGNvKXb+N/43TzR0+6WXe3QEB6/YIjktWvBcLO3prMjOb6bIRhWlx5nlWueLuHDejEGXoJD/e38gB3T9qotb+vRCuH+7IKB1fLrAjeb1Fi7B+rwISlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083287; c=relaxed/simple;
	bh=nnwnSg69IBgq/M/m6M4U/ij0P06c3galag9NLHhdSMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SlMwvL3qUCOQqaANm37SrXySpVqqWSrmOCwZb3aZKep0sCCYUB8JR1RF24i7KZLgKkAOjxeL932xvB7Lm+O686Hc1xSAgx5PNQEbHwt+TrM1E/8NWCfNh2TwnZKM34siJv3AqUbOaOMdfVgZ/dT/pLmNSvgiCYL5OykoHKtuzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXRtaLkc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXRtaLkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766083286; x=1797619286;
  h=date:from:to:cc:subject:message-id;
  bh=nnwnSg69IBgq/M/m6M4U/ij0P06c3galag9NLHhdSMY=;
  b=MXRtaLkceZPJFRcw71uMXvTAXlFun3kjX2XBHofYP8UgB8sj+ei4N03Y
   z1TahEf4LVn99VSWchGI7WBj72byA7bzpm83fq5f1zR4q+WIfeQeEM4Kq
   v7AYfbCE6hvuC6YV82bQwlaT2m0Sz/sSTftiM1fQBYKdQ0PO+0k4C8OD5
   kxKpp9MCqzCTAWa2GkErf6A07FClLDD39Lo2AEb8kggY6hkGdnF5DFQgj
   NZaHrW9Z0y5huE24RFNN2ZWJhOGa3T/Zt26CX6fvd/bLdhuel3jHyWxM6
   4QuzLLrew+IzU8ohKT7tlxiI8V8+1v6nurk5WeNiyvdKSEZGaINGiz+QJ
   A==;
X-CSE-ConnectionGUID: hpaNv7sxTFS3oh2Ab0VnlA==
X-CSE-MsgGUID: hA3/auwXTvagOs3zRqshLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68200009"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="68200009"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 10:41:24 -0800
X-CSE-ConnectionGUID: nux6pIFqQ4+CVEarnv6aFw==
X-CSE-MsgGUID: E4k+Tl+jS0aCfAJRZCk6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198421490"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Dec 2025 10:41:22 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWIwB-000000002SH-2wFF;
	Thu, 18 Dec 2025 18:41:19 +0000
Date: Fri, 19 Dec 2025 02:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.0/cxl-init] BUILD SUCCESS
 e69c86f703135e7baab901aced57df8e23fb2b18
Message-ID: <202512190211.EWrddAi5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.0/cxl-init
branch HEAD: e69c86f703135e7baab901aced57df8e23fb2b18  cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation

elapsed time: 1465m

configs tested: 166
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251218    gcc-8.5.0
arc                   randconfig-002-20251218    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251218    clang-22
arm                   randconfig-002-20251218    clang-22
arm                   randconfig-003-20251218    gcc-14.3.0
arm                   randconfig-004-20251218    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251218    gcc-8.5.0
arm64                 randconfig-002-20251218    clang-19
arm64                 randconfig-003-20251218    gcc-14.3.0
arm64                 randconfig-004-20251218    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251218    gcc-15.1.0
csky                  randconfig-002-20251218    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251218    clang-18
hexagon               randconfig-002-20251218    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251218    gcc-14
i386        buildonly-randconfig-002-20251218    gcc-14
i386        buildonly-randconfig-003-20251218    gcc-14
i386        buildonly-randconfig-004-20251218    gcc-14
i386        buildonly-randconfig-005-20251218    gcc-14
i386        buildonly-randconfig-006-20251218    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251218    clang-20
i386                  randconfig-002-20251218    gcc-14
i386                  randconfig-003-20251218    gcc-14
i386                  randconfig-004-20251218    gcc-12
i386                  randconfig-005-20251218    clang-20
i386                  randconfig-006-20251218    gcc-14
i386                  randconfig-007-20251218    gcc-12
i386                  randconfig-011-20251218    gcc-13
i386                  randconfig-012-20251218    gcc-14
i386                  randconfig-013-20251218    gcc-14
i386                  randconfig-014-20251218    clang-20
i386                  randconfig-015-20251218    clang-20
i386                  randconfig-016-20251218    gcc-14
i386                  randconfig-017-20251218    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251218    clang-18
loongarch             randconfig-002-20251218    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251218    gcc-11.5.0
nios2                 randconfig-002-20251218    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251218    gcc-11.5.0
parisc                randconfig-002-20251218    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251218    clang-22
powerpc               randconfig-002-20251218    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20251218    gcc-8.5.0
powerpc64             randconfig-002-20251218    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251218    gcc-14.3.0
riscv                 randconfig-002-20251218    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251218    clang-22
s390                  randconfig-002-20251218    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251218    gcc-15.1.0
sh                    randconfig-002-20251218    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251218    gcc-15.1.0
sparc                 randconfig-002-20251218    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251218    gcc-8.5.0
sparc64               randconfig-002-20251218    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251218    gcc-14
um                    randconfig-002-20251218    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251218    gcc-14
x86_64      buildonly-randconfig-002-20251218    gcc-14
x86_64      buildonly-randconfig-003-20251218    clang-20
x86_64      buildonly-randconfig-004-20251218    gcc-14
x86_64      buildonly-randconfig-005-20251218    gcc-14
x86_64      buildonly-randconfig-006-20251218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251218    clang-20
x86_64                randconfig-002-20251218    clang-20
x86_64                randconfig-003-20251218    clang-20
x86_64                randconfig-004-20251218    clang-20
x86_64                randconfig-005-20251218    clang-20
x86_64                randconfig-006-20251218    clang-20
x86_64                randconfig-011-20251218    gcc-14
x86_64                randconfig-012-20251218    gcc-14
x86_64                randconfig-013-20251218    clang-20
x86_64                randconfig-014-20251218    gcc-12
x86_64                randconfig-015-20251218    gcc-14
x86_64                randconfig-016-20251218    gcc-14
x86_64                randconfig-071-20251218    gcc-14
x86_64                randconfig-072-20251218    gcc-14
x86_64                randconfig-073-20251218    gcc-12
x86_64                randconfig-074-20251218    clang-20
x86_64                randconfig-075-20251218    gcc-12
x86_64                randconfig-076-20251218    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251218    gcc-15.1.0
xtensa                randconfig-002-20251218    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
