Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E5204955
	for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197378; cv=none; b=Jv+PYKT5uthHTnFQPv9v4wuOrr0rZKA+bEUMtfbDt9yhogZ8wrUqEieSWkqtnNxXBeMSOOtvCt2HIBeOu+wr0Q4bztFizLc0MyUwSxWsY0f25wBDqjXPHqj/d48RwGf1vTV+bAL037A0NBsxTUxmyd6MWgwE9J7SIFH9JYaD1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197378; c=relaxed/simple;
	bh=0qSwlsekACUKRRS+SdDnonQhKBDlkOB3K4UMcr04kR0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S5MxMRFju8AVMoPGCegeMUQ9MZBSeFrWzHfuXm5n8HI3yox85sbNLVowDYlbN3Ur99fR61aiqj/720NFKAldJd5s7wiXGLlYnECRo7p2s3xzgJgxidmNcuj96SfdJ+IDaIL6k5AKrU3oC7BK0j/EaNszaK4XpvbjHbij2GICuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkIKr9LX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkIKr9LX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730197376; x=1761733376;
  h=date:from:to:cc:subject:message-id;
  bh=0qSwlsekACUKRRS+SdDnonQhKBDlkOB3K4UMcr04kR0=;
  b=XkIKr9LXzYNQwQFQUmVa5t1gN6hxZV59/59BM2dgV8iVAWgqV3UwW4RZ
   17UgKRZsy5578csWI7XvbDhPpD3JAk1TyQptXKEjUzP+8bFi9UZYx73z9
   fzzm2plkKMH9HaYmb0StT6OIme6JXq0/7SLegYWxVXnu8T4g4P1RM8JLZ
   QSpYuh6rMocIxDvMrjfeb5ATaWLdicVHv0BSBLtxOj+iEskePQFtEYMrM
   k8amn9WxYJEh4HFn2adL0RgIlrpgG6Op4kqi7NeXJWjr/GH3Hf/y6bSSr
   TT5TCpY8I5xzqfWZQBZLHsWyFMl9CIz6GemEKFlEJTxTeMq+bAKKOzvAA
   w==;
X-CSE-ConnectionGUID: rHFsmRxHTmOsi0vztNYbJA==
X-CSE-MsgGUID: 7/sNZsBMQoeIs4F4dIAk5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29793074"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29793074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:22:55 -0700
X-CSE-ConnectionGUID: abuuwZLsS/CuRNCNJbOd7w==
X-CSE-MsgGUID: nHEGwuZMTdKra0u0ARqPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86471882"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2024 03:22:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5jNC-000dWu-36;
	Tue, 29 Oct 2024 10:22:50 +0000
Date: Tue, 29 Oct 2024 18:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 86bcd81d66d63c549e98c9c502ccd3be01a52fe2
Message-ID: <202410291854.MW6n1nCe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 86bcd81d66d63c549e98c9c502ccd3be01a52fe2  Merge branch 'cxl/for-6.12/printf' into cxl-for-next

elapsed time: 725m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                   randconfig-001-20241029    gcc-13.2.0
arc                   randconfig-002-20241029    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    clang-14
arm                          moxart_defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                   randconfig-001-20241029    gcc-14.1.0
arm                   randconfig-002-20241029    gcc-14.1.0
arm                   randconfig-003-20241029    gcc-14.1.0
arm                   randconfig-004-20241029    clang-16
arm                           tegra_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241029    clang-17
arm64                 randconfig-002-20241029    clang-20
arm64                 randconfig-003-20241029    gcc-14.1.0
arm64                 randconfig-004-20241029    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241029    gcc-14.1.0
csky                  randconfig-002-20241029    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241029    clang-20
hexagon               randconfig-002-20241029    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241029    clang-19
i386        buildonly-randconfig-002-20241029    gcc-12
i386        buildonly-randconfig-003-20241029    clang-19
i386        buildonly-randconfig-004-20241029    gcc-12
i386        buildonly-randconfig-005-20241029    clang-19
i386        buildonly-randconfig-006-20241029    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241029    gcc-12
i386                  randconfig-002-20241029    gcc-12
i386                  randconfig-003-20241029    gcc-12
i386                  randconfig-004-20241029    clang-19
i386                  randconfig-005-20241029    clang-19
i386                  randconfig-006-20241029    gcc-12
i386                  randconfig-011-20241029    gcc-12
i386                  randconfig-012-20241029    clang-19
i386                  randconfig-013-20241029    clang-19
i386                  randconfig-014-20241029    clang-19
i386                  randconfig-015-20241029    clang-19
i386                  randconfig-016-20241029    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241029    gcc-14.1.0
loongarch             randconfig-002-20241029    gcc-14.1.0
m68k                             alldefconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq6_defconfig    clang-14
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241029    gcc-14.1.0
nios2                 randconfig-002-20241029    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20241029    gcc-14.1.0
parisc                randconfig-002-20241029    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    clang-20
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20241029    gcc-14.1.0
powerpc               randconfig-002-20241029    clang-20
powerpc               randconfig-003-20241029    gcc-14.1.0
powerpc                     skiroot_defconfig    clang-20
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241029    gcc-14.1.0
powerpc64             randconfig-002-20241029    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241029    clang-20
riscv                 randconfig-002-20241029    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241029    gcc-14.1.0
s390                  randconfig-002-20241029    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20241029    gcc-14.1.0
sh                    randconfig-002-20241029    gcc-14.1.0
sh                            titan_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20241029    gcc-14.1.0
sparc64               randconfig-002-20241029    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-002-20241029    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241029    gcc-12
x86_64      buildonly-randconfig-002-20241029    gcc-12
x86_64      buildonly-randconfig-003-20241029    gcc-12
x86_64      buildonly-randconfig-004-20241029    gcc-12
x86_64      buildonly-randconfig-005-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241029    gcc-12
x86_64                randconfig-002-20241029    clang-19
x86_64                randconfig-003-20241029    gcc-12
x86_64                randconfig-004-20241029    clang-19
x86_64                randconfig-005-20241029    gcc-12
x86_64                randconfig-006-20241029    gcc-12
x86_64                randconfig-011-20241029    clang-19
x86_64                randconfig-012-20241029    clang-19
x86_64                randconfig-013-20241029    clang-19
x86_64                randconfig-014-20241029    clang-19
x86_64                randconfig-015-20241029    gcc-12
x86_64                randconfig-016-20241029    gcc-12
x86_64                randconfig-071-20241029    gcc-12
x86_64                randconfig-072-20241029    gcc-12
x86_64                randconfig-073-20241029    gcc-12
x86_64                randconfig-074-20241029    clang-19
x86_64                randconfig-075-20241029    gcc-12
x86_64                randconfig-076-20241029    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241029    gcc-14.1.0
xtensa                randconfig-002-20241029    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
