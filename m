Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457B1B86FD
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282545; cv=none; b=ZXcz7QNJuTseQO1fF7YW6FtUmAm9L+R2JTn/BIB22GzHnwFJr4OVZGCinlOyamzqFOVgyFaowamGiUl0kU2oTIC5yrng41VZdaccqKy2jAWmAL4zGa6YOadPxrvZO708vcTzf8HKkil0KdCnbvdhcjmYBGQcp4EDJOJNFRxF3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282545; c=relaxed/simple;
	bh=cYXtnsioSc4Pl6V5YDhqkA6NmXeB94doeYP07UaYUn0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pfoF+hGbtWtpKVqPgOY61pvkk6f+2kPX843r8PcFZ1V1i+rma8Ild3BI/rv/OAlR8HZRoJGR072CGWI6IMu8vBHihobWQToz7756D8Z00kw3liVzQgATc0fveiYXeLOJCxLGAmuGUFt2OK2LqwrdKYebVYomCQp08glcfPnb08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZarK8xnU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZarK8xnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721282544; x=1752818544;
  h=date:from:to:cc:subject:message-id;
  bh=cYXtnsioSc4Pl6V5YDhqkA6NmXeB94doeYP07UaYUn0=;
  b=ZarK8xnUd/eEw0EoUZUIpOl3SmXz3jANH0Hm12pe4M1xB/mGaxCX/8OQ
   TtDtP7pNTTpucTb9lVwO82ZKoxnLXoAu86APnTv7NZ4uDG4gj6ImEEM1P
   ByT1pjSNqLjxn4cywm2DATBZkUwl3jo/MXL1XHVI5Qj5Olz/SMCmIhuLw
   mP+owp+p8i561P0ipQNeRdnH3X+7okPKQFO1RxfClAqHuNaChcLFOExXx
   Etwbu+ms6gWrChYOSV0ivBgabuN2cQMiTqBE/x2Cwlwn6xjSkmMja+9xU
   NmT1KNdjbHE9uzcMgTXPCcmnzubrXUHx2/rZ55nw/w7gtpXcKc2fYqN+H
   w==;
X-CSE-ConnectionGUID: j1xupMxJSqm0YXdb/o2btA==
X-CSE-MsgGUID: 4kmJHUSGSG2UQ7mBJJFssw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29435546"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="29435546"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 23:02:23 -0700
X-CSE-ConnectionGUID: G11zgDvHSCmdoFiz5e6Qig==
X-CSE-MsgGUID: 221Cqf4pQ3CHrNe/Qr8Y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="88133518"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Jul 2024 23:02:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUKDa-000h0A-2T;
	Thu, 18 Jul 2024 06:02:18 +0000
Date: Thu, 18 Jul 2024 14:02:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 a0328b397f3339d8d17a6ec356e94b3c110b010c
Message-ID: <202407181412.DwnEknNA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: a0328b397f3339d8d17a6ec356e94b3c110b010c  cxl/core/pci: Move reading of control register to immediately before usage

elapsed time: 732m

configs tested: 307
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240718   gcc-13.2.0
arc                   randconfig-002-20240718   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.3.0
arm                          moxart_defconfig   gcc-14.1.0
arm                         nhk8815_defconfig   clang-19
arm                   randconfig-001-20240718   clang-19
arm                   randconfig-001-20240718   gcc-13.2.0
arm                   randconfig-002-20240718   gcc-13.2.0
arm                   randconfig-002-20240718   gcc-14.1.0
arm                   randconfig-003-20240718   clang-19
arm                   randconfig-003-20240718   gcc-13.2.0
arm                   randconfig-004-20240718   gcc-13.2.0
arm                   randconfig-004-20240718   gcc-14.1.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           spitz_defconfig   gcc-13.3.0
arm                       versatile_defconfig   gcc-13.3.0
arm                        vexpress_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240718   clang-15
arm64                 randconfig-001-20240718   gcc-13.2.0
arm64                 randconfig-002-20240718   clang-19
arm64                 randconfig-002-20240718   gcc-13.2.0
arm64                 randconfig-003-20240718   gcc-13.2.0
arm64                 randconfig-003-20240718   gcc-14.1.0
arm64                 randconfig-004-20240718   clang-19
arm64                 randconfig-004-20240718   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240718   gcc-13.2.0
csky                  randconfig-001-20240718   gcc-14.1.0
csky                  randconfig-002-20240718   gcc-13.2.0
csky                  randconfig-002-20240718   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240718   clang-19
hexagon               randconfig-002-20240718   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-11
i386         buildonly-randconfig-002-20240718   gcc-7
i386         buildonly-randconfig-003-20240718   gcc-11
i386         buildonly-randconfig-003-20240718   gcc-13
i386         buildonly-randconfig-004-20240718   clang-18
i386         buildonly-randconfig-004-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-11
i386         buildonly-randconfig-005-20240718   gcc-9
i386         buildonly-randconfig-006-20240718   gcc-11
i386         buildonly-randconfig-006-20240718   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240718   gcc-11
i386                  randconfig-001-20240718   gcc-13
i386                  randconfig-002-20240718   gcc-11
i386                  randconfig-002-20240718   gcc-13
i386                  randconfig-003-20240718   clang-18
i386                  randconfig-003-20240718   gcc-11
i386                  randconfig-004-20240718   clang-18
i386                  randconfig-004-20240718   gcc-11
i386                  randconfig-005-20240718   clang-18
i386                  randconfig-005-20240718   gcc-11
i386                  randconfig-006-20240718   clang-18
i386                  randconfig-006-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-11
i386                  randconfig-011-20240718   gcc-13
i386                  randconfig-012-20240718   gcc-11
i386                  randconfig-012-20240718   gcc-13
i386                  randconfig-013-20240718   gcc-10
i386                  randconfig-013-20240718   gcc-11
i386                  randconfig-014-20240718   clang-18
i386                  randconfig-014-20240718   gcc-11
i386                  randconfig-015-20240718   clang-18
i386                  randconfig-015-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-11
i386                  randconfig-016-20240718   gcc-13
loongarch                        alldefconfig   gcc-14.1.0
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240718   gcc-13.2.0
loongarch             randconfig-001-20240718   gcc-14.1.0
loongarch             randconfig-002-20240718   gcc-13.2.0
loongarch             randconfig-002-20240718   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
m68k                           virt_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         cobalt_defconfig   gcc-13.3.0
mips                         db1xxx_defconfig   clang-19
mips                           ip27_defconfig   gcc-13.3.0
mips                        maltaup_defconfig   clang-19
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240718   gcc-13.2.0
nios2                 randconfig-001-20240718   gcc-14.1.0
nios2                 randconfig-002-20240718   gcc-13.2.0
nios2                 randconfig-002-20240718   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240718   gcc-13.2.0
parisc                randconfig-001-20240718   gcc-14.1.0
parisc                randconfig-002-20240718   gcc-13.2.0
parisc                randconfig-002-20240718   gcc-14.1.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.3.0
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   gcc-13.3.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                  mpc866_ads_defconfig   clang-19
powerpc                      ppc64e_defconfig   gcc-14.1.0
powerpc                      ppc6xx_defconfig   gcc-13.3.0
powerpc               randconfig-001-20240718   clang-17
powerpc               randconfig-001-20240718   gcc-13.2.0
powerpc               randconfig-002-20240718   clang-19
powerpc               randconfig-002-20240718   gcc-13.2.0
powerpc               randconfig-003-20240718   gcc-13.2.0
powerpc               randconfig-003-20240718   gcc-14.1.0
powerpc                     tqm8548_defconfig   gcc-13.3.0
powerpc                      walnut_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240718   clang-19
powerpc64             randconfig-001-20240718   gcc-13.2.0
powerpc64             randconfig-002-20240718   gcc-13.2.0
powerpc64             randconfig-002-20240718   gcc-14.1.0
powerpc64             randconfig-003-20240718   clang-19
powerpc64             randconfig-003-20240718   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240718   clang-17
riscv                 randconfig-001-20240718   gcc-13.2.0
riscv                 randconfig-002-20240718   clang-19
riscv                 randconfig-002-20240718   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240718   clang-19
s390                  randconfig-001-20240718   gcc-13.2.0
s390                  randconfig-002-20240718   gcc-13.2.0
s390                  randconfig-002-20240718   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         apsh4a3a_defconfig   gcc-13.3.0
sh                        apsh4ad0a_defconfig   gcc-13.3.0
sh                                  defconfig   gcc-14.1.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-14.1.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240718   gcc-13.2.0
sh                    randconfig-001-20240718   gcc-14.1.0
sh                    randconfig-002-20240718   gcc-13.2.0
sh                    randconfig-002-20240718   gcc-14.1.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.3.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240718   gcc-13.2.0
sparc64               randconfig-001-20240718   gcc-14.1.0
sparc64               randconfig-002-20240718   gcc-13.2.0
sparc64               randconfig-002-20240718   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240718   clang-19
um                    randconfig-001-20240718   gcc-13.2.0
um                    randconfig-002-20240718   clang-15
um                    randconfig-002-20240718   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240718   gcc-11
x86_64       buildonly-randconfig-002-20240718   clang-18
x86_64       buildonly-randconfig-002-20240718   gcc-11
x86_64       buildonly-randconfig-003-20240718   clang-18
x86_64       buildonly-randconfig-003-20240718   gcc-11
x86_64       buildonly-randconfig-004-20240718   clang-18
x86_64       buildonly-randconfig-004-20240718   gcc-11
x86_64       buildonly-randconfig-005-20240718   clang-18
x86_64       buildonly-randconfig-005-20240718   gcc-11
x86_64       buildonly-randconfig-006-20240718   clang-18
x86_64       buildonly-randconfig-006-20240718   gcc-11
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240718   gcc-11
x86_64                randconfig-001-20240718   gcc-13
x86_64                randconfig-002-20240718   gcc-11
x86_64                randconfig-002-20240718   gcc-13
x86_64                randconfig-003-20240718   clang-18
x86_64                randconfig-003-20240718   gcc-11
x86_64                randconfig-004-20240718   gcc-11
x86_64                randconfig-004-20240718   gcc-13
x86_64                randconfig-005-20240718   clang-18
x86_64                randconfig-005-20240718   gcc-11
x86_64                randconfig-006-20240718   clang-18
x86_64                randconfig-006-20240718   gcc-11
x86_64                randconfig-011-20240718   clang-18
x86_64                randconfig-011-20240718   gcc-11
x86_64                randconfig-012-20240718   gcc-11
x86_64                randconfig-012-20240718   gcc-9
x86_64                randconfig-013-20240718   clang-18
x86_64                randconfig-013-20240718   gcc-11
x86_64                randconfig-014-20240718   clang-18
x86_64                randconfig-014-20240718   gcc-11
x86_64                randconfig-015-20240718   clang-18
x86_64                randconfig-015-20240718   gcc-11
x86_64                randconfig-016-20240718   clang-18
x86_64                randconfig-016-20240718   gcc-11
x86_64                randconfig-071-20240718   clang-18
x86_64                randconfig-071-20240718   gcc-11
x86_64                randconfig-072-20240718   clang-18
x86_64                randconfig-072-20240718   gcc-11
x86_64                randconfig-073-20240718   clang-18
x86_64                randconfig-073-20240718   gcc-11
x86_64                randconfig-074-20240718   gcc-11
x86_64                randconfig-074-20240718   gcc-9
x86_64                randconfig-075-20240718   clang-18
x86_64                randconfig-075-20240718   gcc-11
x86_64                randconfig-076-20240718   clang-18
x86_64                randconfig-076-20240718   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240718   gcc-13.2.0
xtensa                randconfig-001-20240718   gcc-14.1.0
xtensa                randconfig-002-20240718   gcc-13.2.0
xtensa                randconfig-002-20240718   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
