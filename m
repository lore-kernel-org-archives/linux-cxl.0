Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632B2367BA
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922495; cv=none; b=aWShXR14jAbUKW5dJLKHpcOHufSewSqxO81T9oahNR4PPH2d+KogMQeZvV9OBqzPbqu+WbzU6K5QJz7J9976vigQTwE+Rj9JO1UNwq6iiWrhSvK2fibddwe6TZDqn0scYQtjjKJ94B3lTaRCEFcfCG8MtwfPYnAFlzukivFC39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922495; c=relaxed/simple;
	bh=mJw3Cg/OLV/sfVquV6b5dLtTX7oanhqaZNgSDzC25t8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ifrc5Yc127BW51LAHkXhD+Cd7kH5P9cAgFJ21izRI8WQUQbpF4XR6bmopb+j3TC3roKXI2F5+5JrD53zmV+yi6yFlkogB3Slu04c4q4mFWHsFDYflUi7MuDjwAmF3DRwI+Ax0YZ4hRWIiXyWNOTuBTPsk03yIaik2GWOql3k1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9rd18jb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9rd18jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750922494; x=1782458494;
  h=date:from:to:cc:subject:message-id;
  bh=mJw3Cg/OLV/sfVquV6b5dLtTX7oanhqaZNgSDzC25t8=;
  b=f9rd18jb30DTFcykxM74vA5KCjxID20fp3Ys1lztNc0qTKZe55TQL+4a
   8zHa1UljRMCnDj0EnPWD2tVPBSqRwIirpKwBqbIwLqLmbIJ5o+KXbm3HI
   RfKGmmdRqnXyopw7XUUfQjmkUxG75T/qf3Ys4S2hdIOmrXbc/l+NnYga9
   CewQnvYcV8FGceFThqazyx6zCTxB8tXL8xVZXh9jnlqFosXNqQJswO2uW
   iPqdZ6eGU9aCFBbb1yOdFLq2Si36kc3j33azQrpQ7TBsz/fpBJrfTO2FH
   bv4HDp4v9tLPrUC5SG5Clj2dNCZS/rvXb8tksCjm0xFsumfRcIo3fPYpu
   g==;
X-CSE-ConnectionGUID: PBPV6IFISx2LoU+t72hSMg==
X-CSE-MsgGUID: p6Af08H3SRObFRk6Ympwqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64267474"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="64267474"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 00:21:34 -0700
X-CSE-ConnectionGUID: Q+JFzyulQCWw/zbNSIbn0w==
X-CSE-MsgGUID: 6kduc0IrT4+UEskjoAS16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="158198846"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Jun 2025 00:21:31 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUgvJ-000Tpa-1L;
	Thu, 26 Jun 2025 07:21:29 +0000
Date: Thu, 26 Jun 2025 15:20:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136
Message-ID: <202506261537.xWYZhgHb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136  cxl/edac: Fix using wrong repair type to check dram event record

elapsed time: 732m

configs tested: 77
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-002-20250626    gcc-13.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-004-20250626    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-003-20250626    gcc-8.5.0
arm64                 randconfig-004-20250626    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-006-20250626    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
