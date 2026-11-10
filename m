Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311158;
	b=4YQ82ZJiuwOoiNIXpaB5HlCeK3jd0sYC5BaaXA5Jrc/2gb7ip1VxCRYmqaBKrtCHrULF
	 Fs1VWlKpT5pg0Rnd95Ahogc8f/PZ+HA8IPCDOQIYJXpEljhPPeX2uPVHAjKbKfqZ+R8W6
	 xQi5dgbwC1NcklyXJlg12pIro84DrVvpgdDwBBsT0wUR3yDJo/wXUfMYw4M3/Bef258oy
	 uDUUcq+c4EnSZcmjrAupFXxAru+jGJQe44UR9ehqlh+qjpsx7KmVfW5BvuXWBH6uGVS21
	 2bx/fyU2kAkjJmLzZgtynX2OtCzV3JwWWr0SNG96TgIa2kOxed3Qkd1dp6TWSKDxJLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=aefNEKjHRE/GHfMxkVaaQ5kN3ihI5MCXImeFaAbZj74=;
	b=imbRmso0b9eRDHUvnkPGKYD4UedgrzsTWXBYKxApuVqm/aKrfErfYWsa1Dz+P0ZodkOS
	 j2zgf3cdVjzrXRohl6QGP6jhouQqzmNK9memsDH7JbMBJ0C7xzlHrD/k9UxI0d1WL6UVZ
	 NVkS+WyZaSw+08j9j/h6mohJRZgmy7CeDrF9So6ZoVzMvEpYjrLJhyRe1y60YdyHWq6ZJ
	 VjDVk3MxWNNl6SE4nx42dgovu65IbQwm1+NHF8VQt4NIYruAcqJzZzfwVGfm9HeR3eWsS
	 ag8GoL7pMf1Ycr+GAWAhMR7/Y/DagycObFm7Qiduli3rQ1lkYHFAla32M8MssVzpjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GvyZDDux;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40F606A325
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 11:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA40F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GvyZDDux
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794311157; x=1825847157;
  h=date:from:to:cc:subject:message-id;
  bh=ezly8qpjXFbX9S+O1wFt5/vBxhAhVPNHMsP7X09cGPA=;
  b=GvyZDDux+St2bviy/d+DlLK4Nai4sDhZC6bdAOseiTsqdPQwSK37KQrp
   SLmjsH4196l4z7DtWX6CKNIVFou9rSS2dciGJmn6wIzBy6DyVNGdvj5ba
   guJl/3+Ut2HiR16NfltbsWERl7SUe2b0Bwc3iyh9RogtEWU+3TzhyIVgb
   UsMHWdYmVbvT3PAsKRwbao1V9Zb6IHuP9P/AEcS8JeGOA7N3sqda+hx+N
   EyGRhXsh0jS8AOCHLLOu3bJNNFD3x2poQYhN5MEE+LheLBXG20N7Hndrs
   rZIlFS6dXqKT5U1A82CR3cU+c0TFQUzknOKxBHwvrt4S4o06Xcu/zdnqO
   w==;
X-CSE-ConnectionGUID: sON031B8TYWV3anhvCLlrw==
X-CSE-MsgGUID: nSb+6emGSuOnBQx/bAlu7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3054753"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3054753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:45:54 -0800
X-CSE-ConnectionGUID: FM5lAGHbTOy+y/YmTeq85w==
X-CSE-MsgGUID: N6jYAoDtShmFJrTCzf7xCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8002655"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Nov 2026 03:45:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQkIQ-00000000wkN-2fqX;
	Tue, 10 Nov 2026 11:45:50 +0000
Date: Tue, 10 Nov 2026 19:44:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 34481a753340d56e8ab2e1067ad3a54391728d26
Message-ID: <20261110194456.4EZonXX5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 34481a753340d56e8ab2e1067ad3a54391728d26  Merge branch 'for-7.5/cxl-back-invalidate' into cxl-for-next

elapsed time: 742m

configs tested: 385
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261110    gcc-11.5.0
alpha                 randconfig-2001-20261110    gcc-13.5.0
alpha                 randconfig-2200-20261110    gcc-9.5.0  smatch
alpha                randconfig-r2108-20261110    gcc-15.3.0 cocci
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261110    gcc-10.5.0
arc                   randconfig-1001-20261110    gcc-10.5.0
arc                   randconfig-2000-20261110    gcc-8.5.0
arc                   randconfig-2001-20261110    gcc-13.5.0
arc                   randconfig-2001-20261110    gcc-8.5.0
arc                   randconfig-2002-20261110    gcc-15.3.0
arc                   randconfig-2002-20261110    gcc-8.5.0
arc                   randconfig-2003-20261110    gcc-13.5.0
arc                   randconfig-2003-20261110    gcc-8.5.0
arc                   randconfig-2004-20261110    gcc-11.5.0
arc                   randconfig-2004-20261110    gcc-8.5.0
arc                   randconfig-2005-20261110    gcc-13.5.0
arc                   randconfig-2005-20261110    gcc-8.5.0
arc                   randconfig-2200-20261110    gcc-8.5.0  smatch
arc                  randconfig-r2101-20261110    gcc-10.5.0 cocci
arc                  randconfig-r2107-20261110    gcc-8.5.0  cocci
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       jornada720_defconfig    clang-24
arm                   randconfig-1000-20261110    gcc-10.5.0
arm                   randconfig-1001-20261110    gcc-10.5.0
arm                   randconfig-1002-20261110    gcc-10.5.0
arm                   randconfig-1003-20261110    gcc-10.5.0
arm                   randconfig-2000-20261110    clang-24
arm                   randconfig-2001-20261110    clang-19
arm                   randconfig-2001-20261110    clang-24
arm                   randconfig-2002-20261110    clang-24
arm                   randconfig-2002-20261110    gcc-10.5.0
arm                   randconfig-2200-20261110    gcc-11.5.0 smatch
arm                  randconfig-r2101-20261110    gcc-12.5.0 cocci
arm                  randconfig-r2109-20261110    clang-24   cocci
arm                         shmobile_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261110    clang-24
arm64                 randconfig-1000-20261110    gcc-12.5.0
arm64                 randconfig-1001-20261110    gcc-12.5.0
arm64                 randconfig-1001-20261110    gcc-13.5.0
arm64                 randconfig-1002-20261110    gcc-12.5.0
arm64                 randconfig-1002-20261110    gcc-15.3.0
arm64                 randconfig-1003-20261110    gcc-12.5.0
arm64                 randconfig-1003-20261110    gcc-13.5.0
arm64                 randconfig-2000-20261110    clang-24
arm64                 randconfig-2000-20261110    gcc-8.5.0
arm64                 randconfig-2001-20261110    clang-24
arm64                 randconfig-2002-20261110    clang-17
arm64                 randconfig-2002-20261110    clang-24
arm64                 randconfig-2200-20261110    clang-24   smatch
arm64                randconfig-r2108-20261110    clang-24   cocci
arm64                randconfig-r2110-20261110    gcc-15.3.0 cocci
arm64                randconfig-r2300-20261110    clang-17   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261110    gcc-12.5.0
csky                  randconfig-1001-20261110    gcc-12.5.0
csky                  randconfig-1001-20261110    gcc-16.2.0
csky                  randconfig-2200-20261110    gcc-16.2.0 smatch
csky                 randconfig-r2108-20261110    clang-20   cocci
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261110    clang-17
hexagon               randconfig-1001-20261110    clang-17
hexagon               randconfig-2200-20261110    clang-24   smatch
hexagon              randconfig-r2104-20261110    gcc-12.5.0 cocci
hexagon              randconfig-r2109-20261110    clang-17   cocci
hexagon              randconfig-r2304-20261110    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261110    clang-22
i386        buildonly-randconfig-1001-20261110    clang-22
i386        buildonly-randconfig-1002-20261110    clang-22
i386        buildonly-randconfig-1003-20261110    clang-22
i386        buildonly-randconfig-1004-20261110    clang-22
i386        buildonly-randconfig-1005-20261110    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1007-20261110    clang-22
i386                  randconfig-1008-20261110    clang-22
i386                  randconfig-1009-20261110    clang-22
i386                  randconfig-1010-20261110    clang-22
i386                  randconfig-1011-20261110    clang-22
i386                  randconfig-1012-20261110    clang-22
i386                  randconfig-1013-20261110    clang-22
i386                  randconfig-2000-20261110    clang-22
i386                  randconfig-2001-20261110    clang-22
i386                  randconfig-2002-20261110    clang-22
i386                  randconfig-2003-20261110    clang-22
i386                  randconfig-2004-20261110    clang-22
i386                  randconfig-2005-20261110    clang-22
i386                  randconfig-2100-20261110    gcc-14     cocci
i386                  randconfig-2101-20261110    gcc-14     cocci
i386                  randconfig-2102-20261110    gcc-14     cocci
i386                  randconfig-2103-20261110    gcc-14     cocci
i386                  randconfig-2104-20261110    gcc-14     cocci
i386                  randconfig-2105-20261110    gcc-14     cocci
i386                  randconfig-2200-20261110    gcc-13     smatch
i386                  randconfig-2300-20261110    clang-22   sparse
i386                  randconfig-2301-20261110    clang-22   sparse
i386                  randconfig-2302-20261110    clang-22   sparse
i386                 randconfig-r2106-20261110    gcc-14     cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261110    clang-17
loongarch             randconfig-1001-20261110    clang-17
loongarch             randconfig-2000-20261110    clang-24
loongarch             randconfig-2000-20261110    gcc-11.5.0
loongarch             randconfig-2001-20261110    gcc-11.5.0
loongarch             randconfig-2001-20261110    gcc-16.2.0
loongarch             randconfig-2200-20261110    clang-24   smatch
loongarch            randconfig-r2111-20261110    clang-24   cocci
loongarch            randconfig-r2302-20261110    gcc-12.5.0 sparse
loongarch            randconfig-r2308-20261110    gcc-16.2.0 sparse
loongarch            randconfig-r2310-20261110    gcc-11.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261110    gcc-8.5.0
m68k                  randconfig-2001-20261110    gcc-12.5.0
m68k                  randconfig-2200-20261110    gcc-16.2.0 smatch
m68k                 randconfig-r2105-20261110    gcc-9.5.0  cocci
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2001-20261110    gcc-8.5.0
microblaze            randconfig-2200-20261110    gcc-8.5.0  smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-24
mips                            ci20_defconfig    clang-24
mips                      eyeq6lplus_defconfig    clang-24
mips                            jazz_defconfig    clang-24
mips                  randconfig-2000-20261110    gcc-16.2.0
mips                  randconfig-2001-20261110    gcc-16.2.0
mips                  randconfig-2002-20261110    gcc-16.2.0
mips                  randconfig-2200-20261110    clang-17   smatch
mips                 randconfig-r2102-20261110    gcc-12.5.0 cocci
mips                 randconfig-r2105-20261110    gcc-12.5.0 cocci
mips                 randconfig-r2107-20261110    clang-24   cocci
mips                 randconfig-r2111-20261110    clang-20   cocci
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261110    clang-17
nios2                 randconfig-1001-20261110    clang-17
nios2                 randconfig-2000-20261110    gcc-11.5.0
nios2                 randconfig-2001-20261110    gcc-11.5.0
nios2                 randconfig-2200-20261110    gcc-11.5.0 smatch
nios2                randconfig-r2106-20261110    clang-20   cocci
nios2                randconfig-r2308-20261110    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.2.0
openrisc          de0_nano_multicore_defconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261110    gcc-16.2.0
openrisc              randconfig-2001-20261110    gcc-16.2.0
openrisc              randconfig-2002-20261110    gcc-16.2.0
openrisc              randconfig-2200-20261110    gcc-9.5.0  smatch
openrisc             randconfig-r2309-20261110    gcc-11.5.0 sparse
openrisc             randconfig-r2310-20261110    gcc-16.2.0 sparse
openrisc             randconfig-r2311-20261110    gcc-16.2.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.2.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261110    gcc-14.4.0
parisc                randconfig-1001-20261110    gcc-14.4.0
parisc                randconfig-2000-20261110    gcc-11.5.0
parisc                randconfig-2000-20261110    gcc-13.5.0
parisc                randconfig-2001-20261110    gcc-11.5.0
parisc                randconfig-2200-20261110    gcc-15.3.0 smatch
parisc               randconfig-r2103-20261110    gcc-12.5.0 cocci
parisc               randconfig-r2309-20261110    gcc-10.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.2.0
powerpc                       mgcoge_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-1000-20261110    gcc-14.4.0
powerpc               randconfig-1001-20261110    gcc-14.4.0
powerpc               randconfig-2000-20261110    clang-24
powerpc               randconfig-2001-20261110    clang-24
powerpc               randconfig-2002-20261110    clang-17
powerpc               randconfig-2200-20261110    clang-24   smatch
powerpc              randconfig-r2111-20261110    gcc-9.5.0  cocci
powerpc              randconfig-r2305-20261110    clang-18   sparse
powerpc              randconfig-r2307-20261110    gcc-11.5.0 sparse
powerpc64             randconfig-1000-20261110    gcc-14.4.0
powerpc64             randconfig-1001-20261110    gcc-14.4.0
powerpc64             randconfig-2000-20261110    gcc-8.5.0
powerpc64             randconfig-2001-20261110    gcc-10.5.0
powerpc64             randconfig-2002-20261110    clang-21
powerpc64            randconfig-r2107-20261110    clang-20   cocci
powerpc64            randconfig-r2301-20261110    clang-24   sparse
riscv                             alldefconfig    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.2.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_k210_defconfig    clang-24
riscv                 randconfig-1000-20261110    clang-24
riscv                 randconfig-1001-20261110    clang-24
riscv                 randconfig-2000-20261110    clang-21
riscv                 randconfig-2000-20261110    gcc-12.5.0
riscv                 randconfig-2001-20261110    clang-24
riscv                 randconfig-2001-20261110    gcc-12.5.0
riscv                 randconfig-2002-20261110    gcc-10.5.0
riscv                 randconfig-2002-20261110    gcc-12.5.0
riscv                 randconfig-2003-20261110    gcc-12.5.0
riscv                 randconfig-2004-20261110    clang-24
riscv                 randconfig-2004-20261110    gcc-12.5.0
riscv                 randconfig-2005-20261110    gcc-12.5.0
riscv                 randconfig-2005-20261110    gcc-16.2.0
riscv                 randconfig-2200-20261110    gcc-8.5.0  smatch
riscv                randconfig-r2102-20261110    clang-24   cocci
riscv                randconfig-r2109-20261110    clang-20   cocci
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261110    clang-24
s390                  randconfig-1001-20261110    clang-24
s390                  randconfig-2000-20261110    clang-20
s390                  randconfig-2000-20261110    gcc-14.4.0
s390                  randconfig-2001-20261110    clang-17
s390                  randconfig-2001-20261110    clang-20
s390                  randconfig-2002-20261110    clang-17
s390                  randconfig-2002-20261110    clang-20
s390                  randconfig-2003-20261110    clang-19
s390                  randconfig-2003-20261110    clang-20
s390                  randconfig-2004-20261110    clang-17
s390                  randconfig-2004-20261110    clang-20
s390                  randconfig-2005-20261110    clang-20
s390                  randconfig-2200-20261110    clang-18   smatch
s390                 randconfig-r2110-20261110    clang-20   cocci
s390                 randconfig-r2303-20261110    clang-24   sparse
s390                 randconfig-r2306-20261110    gcc-16.2.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.2.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261110    clang-24
sh                    randconfig-1001-20261110    clang-24
sh                    randconfig-2000-20261110    gcc-16.2.0
sh                    randconfig-2000-20261110    gcc-9.5.0
sh                    randconfig-2001-20261110    gcc-9.5.0
sh                    randconfig-2002-20261110    gcc-16.2.0
sh                    randconfig-2002-20261110    gcc-9.5.0
sh                    randconfig-2003-20261110    gcc-13.5.0
sh                    randconfig-2003-20261110    gcc-9.5.0
sh                    randconfig-2004-20261110    gcc-15.3.0
sh                    randconfig-2004-20261110    gcc-9.5.0
sh                    randconfig-2005-20261110    gcc-9.5.0
sh                    randconfig-2200-20261110    gcc-16.2.0 smatch
sh                   sh7785lcr_32bit_defconfig    clang-24
sh                             shmin_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.2.0
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261110    gcc-12.5.0
sparc                 randconfig-1001-20261110    gcc-12.5.0
sparc                 randconfig-2000-20261110    gcc-11.5.0
sparc                 randconfig-2000-20261110    gcc-14
sparc                 randconfig-2001-20261110    gcc-14
sparc                 randconfig-2001-20261110    gcc-8.5.0
sparc                 randconfig-2200-20261110    gcc-13.5.0 smatch
sparc                randconfig-r2104-20261110    gcc-11.5.0 cocci
sparc                randconfig-r2311-20261110    gcc-11.5.0 sparse
sparc                        sparc64_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261110    gcc-12.5.0
sparc64               randconfig-1001-20261110    gcc-12.5.0
sparc64               randconfig-2000-20261110    gcc-14
sparc64               randconfig-2000-20261110    gcc-14.4.0
sparc64               randconfig-2001-20261110    gcc-14
sparc64               randconfig-2001-20261110    gcc-8.5.0
sparc64               randconfig-2200-20261110    clang-24   smatch
sparc64              randconfig-r2307-20261110    gcc-14.4.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261110    gcc-12.5.0
um                    randconfig-1001-20261110    gcc-12.5.0
um                    randconfig-2000-20261110    gcc-14
um                    randconfig-2001-20261110    gcc-14
um                    randconfig-2200-20261110    gcc-14     smatch
um                   randconfig-r2106-20261110    clang-24   cocci
um                   randconfig-r2110-20261110    clang-24   cocci
um                   randconfig-r2306-20261110    gcc-11.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261110    gcc-14
x86_64      buildonly-randconfig-1001-20261110    gcc-14
x86_64      buildonly-randconfig-1002-20261110    gcc-14
x86_64      buildonly-randconfig-1003-20261110    gcc-14
x86_64      buildonly-randconfig-1004-20261110    gcc-14
x86_64      buildonly-randconfig-1005-20261110    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261110    gcc-14
x86_64                randconfig-1001-20261110    gcc-14
x86_64                randconfig-1002-20261110    gcc-14
x86_64                randconfig-1003-20261110    gcc-14
x86_64                randconfig-1004-20261110    gcc-14
x86_64                randconfig-1005-20261110    gcc-14
x86_64                randconfig-1006-20261110    gcc-14
x86_64                randconfig-1007-20261110    gcc-14
x86_64                randconfig-1008-20261110    gcc-14
x86_64                randconfig-1009-20261110    gcc-14
x86_64                randconfig-1010-20261110    gcc-14
x86_64                randconfig-1011-20261110    gcc-14
x86_64                randconfig-1012-20261110    gcc-14
x86_64                randconfig-1013-20261110    gcc-14
x86_64                randconfig-1014-20261110    gcc-14
x86_64                randconfig-1015-20261110    gcc-14
x86_64                randconfig-1016-20261110    gcc-14
x86_64                randconfig-1017-20261110    gcc-14
x86_64                randconfig-2200-20261110    gcc-14     smatch
x86_64                randconfig-2300-20261110    clang-22   sparse
x86_64                randconfig-2301-20261110    clang-22   sparse
x86_64                randconfig-2302-20261110    clang-22   sparse
x86_64               randconfig-r2100-20261110    clang-22   cocci
x86_64               randconfig-r2100-20261110    gcc-12.5.0 cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.2.0
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261110    gcc-12.5.0
xtensa                randconfig-1001-20261110    gcc-12.5.0
xtensa                randconfig-2200-20261110    gcc-11.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
