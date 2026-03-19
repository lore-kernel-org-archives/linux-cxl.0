Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75B363C63
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903332; cv=none; b=GeXEmQb3wAipO/8JhpdWpKVKj1xCJBGX3T4qJxqgZjW6fUFHljpUuWXG4lD3OfTTC1whQJ8pXo9i5Y+Y3sw3hg8b/YqQ7UdgZO3lpUVzxCn1i3iuR3fMvsSdm6Lyfc4mNZySnd+jH1N03R6IBmVJDlihkmhqW009zOB+0m2Mkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903332; c=relaxed/simple;
	bh=bpnZiyWzBmkBnibpXkEVmVcbqR/QN3B+8MkoZT3qgjA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VrEMxsRtht1UuHXcg3Lz90AZv4MPjqlwVp+3VCrfUaQVqlXsIZZX6pSo0+17l0RjF1iNBJTZd2NzOZQTxx7YqHl0sENXzszwust8y3tniMBoLnojt9W1G2tw4rW2OwFSdzLHtTZOJaxnX03UoxjuPaOTe1e5PZa5bspk3jnhJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6aWVJ32; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6aWVJ32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773903330; x=1805439330;
  h=date:from:to:cc:subject:message-id;
  bh=bpnZiyWzBmkBnibpXkEVmVcbqR/QN3B+8MkoZT3qgjA=;
  b=i6aWVJ32VRvFCU6WHydwOB01XJzhtRtfhXJctEAypjsFEAS/uxjgpPv1
   MbiKoiX87oP3FTzRmqrrXddEPs3ifeoI+z45hg8LlsXTSDWNuKp9ZCfCU
   AHjtJXsczOsDyISETxNjckBWSSX5zidgxQn9J4cIH74QKGDXM3SS4zZM1
   gdZA+KIT2ucP7xgYvGNSIws6V3cxAEIyEcJM08CQaWsI6VUL0fqPtjfSS
   cbUeBCy1moFgnt9ui35LJEF54Ih6Nmh+FxhbLrExunhaq92WAmQjyNcQv
   RLfYzHwuW50nCaauR7qkn6FDpAKYYFmbipCOtqwizVBhewiZTkez0vHxh
   w==;
X-CSE-ConnectionGUID: g5b5ZcYVRBm9qygsGEKwZg==
X-CSE-MsgGUID: NNX4btyyQVGqv6vxeUEjEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85671408"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="85671408"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 23:55:29 -0700
X-CSE-ConnectionGUID: oPw1ut2uTxC3yWU9U+KYdw==
X-CSE-MsgGUID: B/XqwWFvQUKifRSAmTuvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="218813181"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2026 23:55:28 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w37HL-000000000SD-2xIJ;
	Thu, 19 Mar 2026 06:54:59 +0000
Date: Thu, 19 Mar 2026 14:54:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.1/cxl-type2-support] BUILD SUCCESS
 64584273dfb8a1e5fc7d78094ba22a93c204b44e
Message-ID: <202603191437.VRXp2rjo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.1/cxl-type2-support
branch HEAD: 64584273dfb8a1e5fc7d78094ba22a93c204b44e  cxl/region: Factor out interleave granularity setup

elapsed time: 845m

configs tested: 178
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-8.5.0
arc                   randconfig-002-20260319    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20260319    clang-23
arm                   randconfig-002-20260319    gcc-8.5.0
arm                   randconfig-003-20260319    gcc-10.5.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260319    clang-23
arm64                 randconfig-002-20260319    gcc-12.5.0
arm64                 randconfig-003-20260319    gcc-15.2.0
arm64                 randconfig-004-20260319    clang-16
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260319    gcc-15.2.0
csky                  randconfig-002-20260319    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260319    clang-23
hexagon               randconfig-001-20260319    gcc-11.5.0
hexagon               randconfig-002-20260319    clang-19
hexagon               randconfig-002-20260319    gcc-11.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260319    clang-20
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-004-20260319    clang-20
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-006-20260319    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260319    clang-20
i386                  randconfig-002-20260319    clang-20
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-005-20260319    clang-20
i386                  randconfig-006-20260319    clang-20
i386                  randconfig-007-20260319    gcc-13
i386                  randconfig-011-20260319    gcc-14
i386                  randconfig-012-20260319    gcc-14
i386                  randconfig-013-20260319    gcc-14
i386                  randconfig-014-20260319    clang-20
i386                  randconfig-015-20260319    gcc-14
i386                  randconfig-016-20260319    gcc-14
i386                  randconfig-017-20260319    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260319    clang-18
loongarch             randconfig-001-20260319    gcc-11.5.0
loongarch             randconfig-002-20260319    clang-23
loongarch             randconfig-002-20260319    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260319    gcc-11.5.0
parisc                randconfig-002-20260319    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260319    clang-23
powerpc               randconfig-002-20260319    clang-16
powerpc64             randconfig-001-20260319    clang-19
powerpc64             randconfig-002-20260319    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260319    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260319    gcc-9.5.0
s390                  randconfig-002-20260319    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260319    gcc-10.5.0
sh                    randconfig-002-20260319    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-15.2.0
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260319    gcc-11.5.0
sparc64               randconfig-002-20260319    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260319    gcc-14
um                    randconfig-002-20260319    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260319    clang-20
x86_64      buildonly-randconfig-002-20260319    clang-20
x86_64      buildonly-randconfig-003-20260319    gcc-14
x86_64      buildonly-randconfig-004-20260319    clang-20
x86_64      buildonly-randconfig-005-20260319    clang-20
x86_64      buildonly-randconfig-006-20260319    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260319    gcc-14
x86_64                randconfig-002-20260319    gcc-12
x86_64                randconfig-003-20260319    gcc-14
x86_64                randconfig-004-20260319    gcc-14
x86_64                randconfig-005-20260319    clang-20
x86_64                randconfig-006-20260319    clang-20
x86_64                randconfig-011-20260319    clang-20
x86_64                randconfig-012-20260319    gcc-14
x86_64                randconfig-013-20260319    gcc-14
x86_64                randconfig-014-20260319    clang-20
x86_64                randconfig-015-20260319    clang-20
x86_64                randconfig-016-20260319    gcc-13
x86_64                randconfig-071-20260319    clang-20
x86_64                randconfig-072-20260319    gcc-14
x86_64                randconfig-073-20260319    clang-20
x86_64                randconfig-074-20260319    clang-20
x86_64                randconfig-075-20260319    clang-20
x86_64                randconfig-076-20260319    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-002-20260319    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
