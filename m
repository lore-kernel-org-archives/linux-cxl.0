Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6D41D658
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827291; cv=none; b=Jx3pDAIBo09yzm59quf2RVkrwB1Cfz3tYbzrwwtUh6RtmHG38pn8Mom+T5XcjvuN5+kVD5y81wLImsNjRc9p3xZ/J66nYhZcBrRpL+xvXmKU555O05JdLFNhyx/VkjWV/A87zMhdht5o6iyAOFLvpwSr8Z5Kez6YUJ7xm1XCGnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827291; c=relaxed/simple;
	bh=Z3tlIKt5NiBDJlrM7B4IrJ1NtsN6eZ88CDkGdka3irM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vr/bpXr2B64aDub8pyPpDPtjDOgsiEaBjYtMKLPvw0PdjjvSlX1JbsDGrnL0caB16msY6yDKE2kKB7hcR31h8FByoRS3692s/hLOQok6wMYRfnejBQTkTj3DwoQBvGzpkHQ/leT/THSbgksJ+Jgy7d03I8dYBUDM5PoRu/pjkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOiMu/Bm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOiMu/Bm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785827289; x=1817363289;
  h=date:from:to:cc:subject:message-id;
  bh=Z3tlIKt5NiBDJlrM7B4IrJ1NtsN6eZ88CDkGdka3irM=;
  b=kOiMu/BmPFDLp9lHG0wqAESI3GcAjOjVd1KV+PJHPNTh7mznxE+DU8NN
   9kdngzwQaODVwALNDzxH3Jtr12q/ZQVL+usyMB91PgHAtQzlIB6CNZm1c
   5IlicBWc2FWgUPjz3R+zSGXS05/8Gs8mCw0QhzBjt62aXqwxh0y3q0FmJ
   dmvauAZrB8BZVO0LTBU7xcGFjVJK3+QoiTBEJJLYoMwKujwH7gUIYeBHw
   WaBgKW+gKnw7hDowXCbme1mPhAP9beZF762jLMBklTl8HDcxkjCQJLPGF
   e1V/14jnJtsdvRUza4/2WWq29Jmil4YcmiJ79ITgL0rtvx9OAUdf4nAc7
   Q==;
X-CSE-ConnectionGUID: QVYIThL9T8GY7alZDMlFgA==
X-CSE-MsgGUID: hzvumMtfQFuCd7VB5jtPIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86225207"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86225207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 00:08:09 -0700
X-CSE-ConnectionGUID: HaBz4xiaQC65A8DrNuDHvg==
X-CSE-MsgGUID: +EWkK0UqR9+DtSZu+Z0qWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="258086257"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Aug 2026 00:08:08 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr9Ft-000000009EL-1Bby;
	Tue, 04 Aug 2026 07:08:05 +0000
Date: Tue, 04 Aug 2026 15:07:33 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 212e015fc34712c849653cdb3179cd643c915015
Message-ID: <202608041520.qs80T5Hb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 212e015fc34712c849653cdb3179cd643c915015  Merge branch 'for-7.3/cxl-misc' into cxl-for-next

elapsed time: 729m

configs tested: 99
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260804    gcc-15.2.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-10.5.0
arm                  randconfig-002-20260804    gcc-15.2.0
arm                  randconfig-003-20260804    clang-17
arm                  randconfig-004-20260804    gcc-8.5.0
arm64                randconfig-001-20260804    clang-24
arm64                randconfig-002-20260804    gcc-9.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260804    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-9.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260804    clang-24
hexagon              randconfig-002-20260804    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260804    clang-22
i386       buildonly-randconfig-002-20260804    clang-22
i386       buildonly-randconfig-003-20260804    clang-22
i386       buildonly-randconfig-004-20260804    gcc-12
i386       buildonly-randconfig-005-20260804    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386                 randconfig-001-20260804    gcc-14
i386                 randconfig-002-20260804    gcc-14
i386                 randconfig-003-20260804    gcc-14
i386                 randconfig-004-20260804    gcc-14
i386                 randconfig-005-20260804    gcc-14
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260804    gcc-14
i386                 randconfig-011-20260804    clang-22
i386                 randconfig-012-20260804    gcc-14
i386                 randconfig-013-20260804    clang-22
i386                 randconfig-014-20260804    gcc-14
i386                 randconfig-015-20260804    clang-22
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260804    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    clang-24
loongarch            randconfig-002-20260804    gcc-16.1.0
mips                         ath79_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-8.5.0
nios2                randconfig-002-20260804    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-001-20260804    clang-24
powerpc              randconfig-002-20260804    gcc-11.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
riscv                randconfig-002-20260804    gcc-13.4.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-002-20260804    clang-18
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    gcc-16.1.0
sh                   randconfig-002-20260804    gcc-16.1.0
sh                          se7206_defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260804    clang-24
sparc64              randconfig-002-20260804    clang-20
um                   randconfig-001-20260804    gcc-14
um                   randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260804    clang-22
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260804    clang-22
x86_64     buildonly-randconfig-006-20260804    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260804    gcc-13
x86_64               randconfig-003-20260804    clang-22
x86_64               randconfig-004-20260804    clang-22
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260804    clang-22
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260804    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-071-20260804    gcc-14
x86_64               randconfig-072-20260804    gcc-14
x86_64               randconfig-073-20260804    gcc-14
x86_64               randconfig-074-20260804    gcc-12
x86_64               randconfig-075-20260804    gcc-14
x86_64               randconfig-076-20260804    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-8.5.0
xtensa               randconfig-002-20260804    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
