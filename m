Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB68C1F
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960440; cv=none; b=VtoeTrKRHeWsnlLN1E2OlHGvgmcG2dn8cP3DKvsarc9yMbrYswSkIUSpKJfDGqhmmHxxKANInzXtq8vdKzrc8DvJ9oIeZ7SxqPuDKBvxbixLTwCyScalTHck61Il+kUqqdpUrfyObbpAAaM+kCbKOsIQ2BYiarj7qd8z8VBTfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960440; c=relaxed/simple;
	bh=3BQW59tA+RDcfC1Yg2bTj7n8VLttTRg9cvJULqsBS/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JBqGTE2DBRsFuh6kqEgPRbOD6mAyNWldlTzrbIdpT2tgOkISeO/KHDRJK7Fy+jvarkI6Vs3eHLLGp3PwNK7FhVSjuOioKldgFPjJAh8YpVJsJ/cZBnEZAECAybfWhtixxNApYR3598TIdYelRhDyOxq9cAoYs2Ejl4Vk2cFToiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJlD+umY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJlD+umY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770960438; x=1802496438;
  h=date:from:to:cc:subject:message-id;
  bh=3BQW59tA+RDcfC1Yg2bTj7n8VLttTRg9cvJULqsBS/g=;
  b=ZJlD+umYICjX+muIR5KhyZlUhZa/hncRs4KA3efsbU9lw7DHzeQ/sBqm
   y8wHCzFx5ccaYAW2ivCV8pS/J31NA+7y6MB7C6WwNDyetYLgPwIOt5zgi
   iYmtsyYjP8q/qGJweFO6ilESRWl2hmJfD5st9vfxyz3YSiuUxbsrNnkNg
   65JVyZINY6SuXXU2AFEMEPOXhodF7PTasKxANo6Y6wsbZKtUN5k20SDYs
   8eOl99rK2m8U5F5AN6Ef3g6Jlnnn/NH2+VDSQ4IRzoZDHfEXQc6Cwe/4b
   1TPyn7GpBOv4olztfCxFhTkjqgSI3+zlcZWPMLPO/O8m+jU596SOpHKYE
   w==;
X-CSE-ConnectionGUID: ou+qbewRSBG3F8pV6adGkg==
X-CSE-MsgGUID: hWPsg3iVRSiCWMomnx0rnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83513074"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83513074"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 21:27:18 -0800
X-CSE-ConnectionGUID: obp8wF9JQhu6teGn0w9wCA==
X-CSE-MsgGUID: WvumMXFARP+uun17s4hNgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212850469"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Feb 2026 21:27:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqlhx-00000000v7U-0Zm0;
	Fri, 13 Feb 2026 05:27:13 +0000
Date: Fri, 13 Feb 2026 13:26:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:7.0-merge-test] BUILD SUCCESS
 49d273f81f3dad288b7748c6cfb973705ae026d2
Message-ID: <202602131311.TsCsIZFV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git 7.0-merge-test
branch HEAD: 49d273f81f3dad288b7748c6cfb973705ae026d2  Merge branch 'cxl-for-next' into 7.0-merge-test

elapsed time: 732m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260213    gcc-10.5.0
arc                   randconfig-002-20260213    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20260213    gcc-8.5.0
arm                   randconfig-002-20260213    clang-22
arm                   randconfig-003-20260213    gcc-10.5.0
arm                   randconfig-004-20260213    gcc-14.3.0
arm                           sunxi_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260213    clang-17
arm64                 randconfig-002-20260213    clang-20
arm64                 randconfig-003-20260213    clang-22
arm64                 randconfig-004-20260213    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260213    gcc-15.2.0
csky                  randconfig-002-20260213    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260213    clang-22
hexagon               randconfig-002-20260213    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260213    clang-20
i386        buildonly-randconfig-002-20260213    gcc-12
i386        buildonly-randconfig-003-20260213    clang-20
i386        buildonly-randconfig-004-20260213    clang-20
i386        buildonly-randconfig-005-20260213    gcc-12
i386        buildonly-randconfig-006-20260213    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260213    gcc-14
i386                  randconfig-002-20260213    clang-20
i386                  randconfig-003-20260213    gcc-14
i386                  randconfig-004-20260213    clang-20
i386                  randconfig-005-20260213    clang-20
i386                  randconfig-006-20260213    gcc-14
i386                  randconfig-007-20260213    clang-20
i386                  randconfig-011-20260213    gcc-13
i386                  randconfig-012-20260213    gcc-14
i386                  randconfig-013-20260213    gcc-14
i386                  randconfig-014-20260213    clang-20
i386                  randconfig-015-20260213    clang-20
i386                  randconfig-016-20260213    gcc-14
i386                  randconfig-017-20260213    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260213    clang-22
loongarch             randconfig-002-20260213    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260213    gcc-11.5.0
nios2                 randconfig-002-20260213    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260213    gcc-15.2.0
parisc                randconfig-002-20260213    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20260213    gcc-14.3.0
powerpc               randconfig-002-20260213    clang-20
powerpc64             randconfig-001-20260213    gcc-15.2.0
powerpc64             randconfig-002-20260213    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260213    gcc-11.5.0
riscv                 randconfig-002-20260213    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260213    gcc-11.5.0
s390                  randconfig-002-20260213    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                    randconfig-001-20260213    gcc-14.3.0
sh                    randconfig-002-20260213    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260213    gcc-13.4.0
sparc                 randconfig-002-20260213    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260213    gcc-9.5.0
sparc64               randconfig-002-20260213    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260213    gcc-14
um                    randconfig-002-20260213    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260213    gcc-14
x86_64      buildonly-randconfig-002-20260213    gcc-14
x86_64      buildonly-randconfig-003-20260213    gcc-12
x86_64      buildonly-randconfig-004-20260213    gcc-14
x86_64      buildonly-randconfig-005-20260213    gcc-14
x86_64      buildonly-randconfig-006-20260213    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260213    gcc-14
x86_64                randconfig-002-20260213    clang-20
x86_64                randconfig-003-20260213    gcc-14
x86_64                randconfig-004-20260213    clang-20
x86_64                randconfig-005-20260213    gcc-14
x86_64                randconfig-006-20260213    gcc-14
x86_64                randconfig-011-20260213    gcc-14
x86_64                randconfig-012-20260213    gcc-14
x86_64                randconfig-013-20260213    gcc-14
x86_64                randconfig-014-20260213    gcc-14
x86_64                randconfig-015-20260213    gcc-12
x86_64                randconfig-016-20260213    gcc-14
x86_64                randconfig-071-20260213    clang-20
x86_64                randconfig-072-20260213    gcc-14
x86_64                randconfig-073-20260213    gcc-14
x86_64                randconfig-074-20260213    clang-20
x86_64                randconfig-075-20260213    clang-20
x86_64                randconfig-076-20260213    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260213    gcc-8.5.0
xtensa                randconfig-002-20260213    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
