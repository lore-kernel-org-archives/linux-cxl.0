Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2361FFE
	for <linux-cxl@vger.kernel.org>; Wed, 15 Oct 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524997; cv=none; b=oSD9Xwj0xSmf1qNnW3DbZPDMTil8kJQHKhgRQo79aLTe1n4t89c0lE5VP+cPLIeTrDLeaChpnjU4gWbS2OBaDL3frbWF5bQo7UdtE9YJF7cPNRFSNTzQ9yQwuSc8gjvZNHsWYv4UGxlG0oPbzhIWzhruy3zoEsNdCWjsQqtNCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524997; c=relaxed/simple;
	bh=wlWJnGCM/slARSgbdwx3GVNsvo7l04ZI2aLSarBJbOY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hYIFP0PP18lLAcNOlhk829u/q5J/gttU5oNBIMYvvHvJ9HKX4107aaTLaHiKqJDRKsXbCk1YutvQbc0KfmJQ8PtI+Vnd8Tcv6e6Vt+mtQkJZkBlkhYtIsN0HrCs7e1gX0XLjBn+hrVdNFHwOG9h/+CEVo/Dwl52e40oNyBjQzgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0hyLnD+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0hyLnD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760524995; x=1792060995;
  h=date:from:to:cc:subject:message-id;
  bh=wlWJnGCM/slARSgbdwx3GVNsvo7l04ZI2aLSarBJbOY=;
  b=T0hyLnD+29BrqK9JcZ5mMXwLMvsQjArutC+H/m1LbjpuJ325gocHSBy7
   HrycS4UJe3UZo4SXDLeuI7miWG2nbdk98L0XI8ZJvk12SW+TJikKYC8r6
   L83x0yBmQ5mUH101m15I3gI5qAkuwqOW/ZmDNBNsU3sq9PGcnUWRb+45F
   8yqA+GWspATGWxxxXVtbBRBLEvMH+Z1Lm8P+1lqMfwRUNjVwcPbzh2iJJ
   TC7Y8c2o5kgoTb7txNW2MqOr0274ClrfHkxWmtX+jzJpgj1siJHqKsNCs
   luZtjLysZeDm353zBWMEKgGwdZVatHprp5bdfr7/u06qwvWQlfep30XYD
   A==;
X-CSE-ConnectionGUID: k2Ay9+WiRvC0+cW288JVkw==
X-CSE-MsgGUID: RQQePdXPSu2oQtUoOLOuTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74037056"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="74037056"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:43:15 -0700
X-CSE-ConnectionGUID: ijZ9qx2lR6iUcvCBGnRXAw==
X-CSE-MsgGUID: 7HsQHhcET6SpoonzQrkXzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="219285830"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Oct 2025 03:43:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8yyM-0003jz-1j;
	Wed, 15 Oct 2025 10:43:10 +0000
Date: Wed, 15 Oct 2025 18:42:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 a4bbb493a3247ef32f6191fd8b2a0657139f8e08
Message-ID: <202510151826.nPcNEpQE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: a4bbb493a3247ef32f6191fd8b2a0657139f8e08  cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events

elapsed time: 756m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-002-20251015    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251015    clang-22
arm                   randconfig-002-20251015    clang-22
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-004-20251015    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251015    clang-22
arm64                 randconfig-002-20251015    gcc-13.4.0
arm64                 randconfig-003-20251015    clang-22
arm64                 randconfig-004-20251015    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251015    gcc-15.1.0
csky                  randconfig-002-20251015    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-002-20251015    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251015    gcc-13
i386        buildonly-randconfig-002-20251015    gcc-14
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251015    gcc-15.1.0
loongarch             randconfig-002-20251015    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                           gcw0_defconfig    clang-22
mips                           ip22_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251015    gcc-8.5.0
nios2                 randconfig-002-20251015    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    gcc-9.5.0
parisc                randconfig-002-20251015    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc               randconfig-001-20251015    gcc-15.1.0
powerpc               randconfig-002-20251015    gcc-12.5.0
powerpc               randconfig-003-20251015    clang-22
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251015    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251015    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251015    gcc-12.5.0
s390                  randconfig-002-20251015    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251015    gcc-11.5.0
sh                    randconfig-002-20251015    gcc-11.5.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    gcc-8.5.0
sparc                 randconfig-002-20251015    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-002-20251015    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-002-20251015    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-005-20251015    gcc-14
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251015    gcc-9.5.0
xtensa                randconfig-002-20251015    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
