Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6A12E4E
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262765; cv=none; b=To3woGZwNFlOjggjo4uSDaLUwaB4NmCM+7DfrpS2+4wWy6gIMoOVvLmfLlYKYNF5aEBFPepK+7g1LrGk9bqgRvhtXyEWmflPeu+nOpqZHU1Hs7ECUCI9R9bddfXYXQ7+cOn4Nk5acQEly8RXCgleqY1KE8zBtVGLjr7KfOPpvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262765; c=relaxed/simple;
	bh=GUKOQ5qw97NeYwZjClJ/EBr9ZpEK6fVx30QhH47eUtY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PtGYSWb5yp/KVSIwjMjxZrUF/8/ynFjeOHfsQ/peknEiLGDYD7RM9lVvdLKgGhrYBdE0X7/77/7/QKyAKOsL0eSk2u7mIf2Fbxbz4ogm38qY/o6JAp4DKz7Gp1hUtyif/i8HNcBIzjBrbV1JFdCmrcFuE9wNJeHJnfHFcZUoqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghIv5/ak; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghIv5/ak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706262764; x=1737798764;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GUKOQ5qw97NeYwZjClJ/EBr9ZpEK6fVx30QhH47eUtY=;
  b=ghIv5/akUjI08qCcX76V2FUn8IKD8tLXa+njWeSG1MAyDo/Q45IjZ326
   +VRwoFwFGvYVjAcxebva22TTOomgWvgfGqyD6D/e2Mz3c0JL0d/M+czHB
   NYHhKjQrsfT/iGOgDWR0d2Eyzb+/yCPxbGs6wrvOgQiCcgY8SVOKk8elk
   BtMiEmbUhwUlDdCxbPNbbMRUqpXLQXz94lvAqyKxe6YV7gHxI+kw+d+iC
   MJEbO1qfQpsbiBPmJ4eAVlrobj4HlMLx69pAMiSEosL36XEE4HyAOZAKC
   OKK4UW7GdA+ej0/uJVMKcRln2uEv7UJA5SLOemr1LtJnwZ2k3DPwu0pOx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9817405"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9817405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930327734"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930327734"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2024 01:52:40 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTIt4-0000u4-2d;
	Fri, 26 Jan 2024 09:52:38 +0000
Date: Fri, 26 Jan 2024 17:51:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 d76779dd3681c01a4c6c3cae4d0627c9083e0ee6
Message-ID: <202401261747.FobfsFK4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fi=
xes
branch HEAD: d76779dd3681c01a4c6c3cae4d0627c9083e0ee6  cxl/region=EF=BC=9AF=
ix overflow issue in alloc_hpa()

elapsed time: 743m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc =20
alpha                            allyesconfig   gcc =20
alpha                               defconfig   gcc =20
arc                              allmodconfig   gcc =20
arc                               allnoconfig   gcc =20
arc                              allyesconfig   gcc =20
arc                                 defconfig   gcc =20
arc                   randconfig-001-20240126   gcc =20
arc                   randconfig-002-20240126   gcc =20
arc                           tb10x_defconfig   gcc =20
arm                              allmodconfig   gcc =20
arm                               allnoconfig   gcc =20
arm                              allyesconfig   gcc =20
arm                                 defconfig   clang
arm                   randconfig-001-20240126   clang
arm                   randconfig-002-20240126   clang
arm                   randconfig-003-20240126   clang
arm                   randconfig-004-20240126   clang
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc =20
arm64                               defconfig   gcc =20
arm64                 randconfig-001-20240126   clang
arm64                 randconfig-002-20240126   clang
arm64                 randconfig-003-20240126   clang
arm64                 randconfig-004-20240126   clang
csky                             allmodconfig   gcc =20
csky                              allnoconfig   gcc =20
csky                             allyesconfig   gcc =20
csky                                defconfig   gcc =20
csky                  randconfig-001-20240126   gcc =20
csky                  randconfig-002-20240126   gcc =20
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240126   clang
hexagon               randconfig-002-20240126   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240126   clang
i386         buildonly-randconfig-002-20240126   clang
i386         buildonly-randconfig-003-20240126   clang
i386         buildonly-randconfig-004-20240126   clang
i386         buildonly-randconfig-005-20240126   clang
i386         buildonly-randconfig-006-20240126   clang
i386                                defconfig   gcc =20
i386                  randconfig-001-20240126   clang
i386                  randconfig-002-20240126   clang
i386                  randconfig-003-20240126   clang
i386                  randconfig-004-20240126   clang
i386                  randconfig-005-20240126   clang
i386                  randconfig-006-20240126   clang
i386                  randconfig-011-20240126   gcc =20
i386                  randconfig-012-20240126   gcc =20
i386                  randconfig-013-20240126   gcc =20
i386                  randconfig-014-20240126   gcc =20
i386                  randconfig-015-20240126   gcc =20
i386                  randconfig-016-20240126   gcc =20
loongarch                        allmodconfig   gcc =20
loongarch                         allnoconfig   gcc =20
loongarch                           defconfig   gcc =20
loongarch             randconfig-001-20240126   gcc =20
loongarch             randconfig-002-20240126   gcc =20
m68k                             allmodconfig   gcc =20
m68k                              allnoconfig   gcc =20
m68k                             allyesconfig   gcc =20
m68k                                defconfig   gcc =20
m68k                        mvme147_defconfig   gcc =20
m68k                        stmark2_defconfig   gcc =20
microblaze                       allmodconfig   gcc =20
microblaze                        allnoconfig   gcc =20
microblaze                       allyesconfig   gcc =20
microblaze                          defconfig   gcc =20
mips                              allnoconfig   clang
mips                             allyesconfig   gcc =20
nios2                            allmodconfig   gcc =20
nios2                             allnoconfig   gcc =20
nios2                            allyesconfig   gcc =20
nios2                               defconfig   gcc =20
nios2                 randconfig-001-20240126   gcc =20
nios2                 randconfig-002-20240126   gcc =20
openrisc                          allnoconfig   gcc =20
openrisc                         allyesconfig   gcc =20
openrisc                            defconfig   gcc =20
parisc                           allmodconfig   gcc =20
parisc                            allnoconfig   gcc =20
parisc                           allyesconfig   gcc =20
parisc                              defconfig   gcc =20
parisc                generic-32bit_defconfig   gcc =20
parisc                randconfig-001-20240126   gcc =20
parisc                randconfig-002-20240126   gcc =20
parisc64                            defconfig   gcc =20
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc =20
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc =20
powerpc                      bamboo_defconfig   gcc =20
powerpc                      chrp32_defconfig   gcc =20
powerpc                     ep8248e_defconfig   gcc =20
powerpc                          g5_defconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc               randconfig-001-20240126   clang
powerpc               randconfig-002-20240126   clang
powerpc               randconfig-003-20240126   clang
powerpc64             randconfig-001-20240126   clang
powerpc64             randconfig-002-20240126   clang
powerpc64             randconfig-003-20240126   clang
riscv                            allmodconfig   gcc =20
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc =20
riscv                               defconfig   gcc =20
riscv                 randconfig-001-20240126   clang
riscv                 randconfig-002-20240126   clang
s390                             allmodconfig   gcc =20
s390                              allnoconfig   gcc =20
s390                             allyesconfig   gcc =20
s390                                defconfig   gcc =20
s390                  randconfig-001-20240126   gcc =20
s390                  randconfig-002-20240126   gcc =20
sh                               allmodconfig   gcc =20
sh                                allnoconfig   gcc =20
sh                               allyesconfig   gcc =20
sh                                  defconfig   gcc =20
sh                        edosk7760_defconfig   gcc =20
sh                    randconfig-001-20240126   gcc =20
sh                    randconfig-002-20240126   gcc =20
sh                      rts7751r2d1_defconfig   gcc =20
sh                             sh03_defconfig   gcc =20
sparc                            allmodconfig   gcc =20
sparc                             allnoconfig   gcc =20
sparc                               defconfig   gcc =20
sparc64                          allmodconfig   gcc =20
sparc64                          allyesconfig   gcc =20
sparc64                             defconfig   gcc =20
sparc64               randconfig-001-20240126   gcc =20
sparc64               randconfig-002-20240126   gcc =20
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc =20
um                             i386_defconfig   gcc =20
um                    randconfig-001-20240126   clang
um                    randconfig-002-20240126   clang
um                           x86_64_defconfig   gcc =20
x86_64                            allnoconfig   gcc =20
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240126   clang
x86_64       buildonly-randconfig-002-20240126   clang
x86_64       buildonly-randconfig-003-20240126   clang
x86_64       buildonly-randconfig-004-20240126   clang
x86_64       buildonly-randconfig-005-20240126   clang
x86_64       buildonly-randconfig-006-20240126   clang
x86_64                              defconfig   gcc =20
x86_64                randconfig-001-20240126   gcc =20
x86_64                randconfig-002-20240126   gcc =20
x86_64                randconfig-003-20240126   gcc =20
x86_64                randconfig-004-20240126   gcc =20
x86_64                randconfig-005-20240126   gcc =20
x86_64                randconfig-006-20240126   gcc =20
x86_64                randconfig-011-20240126   clang
x86_64                randconfig-012-20240126   clang
x86_64                randconfig-013-20240126   clang
x86_64                randconfig-014-20240126   clang
x86_64                randconfig-015-20240126   clang
x86_64                randconfig-016-20240126   clang
x86_64                randconfig-071-20240126   clang
x86_64                randconfig-072-20240126   clang
x86_64                randconfig-073-20240126   clang
x86_64                randconfig-074-20240126   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc =20
xtensa                randconfig-001-20240126   gcc =20
xtensa                randconfig-002-20240126   gcc =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
