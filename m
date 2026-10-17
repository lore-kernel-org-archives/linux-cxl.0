Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F437E5E8
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208197; cv=none; b=uiKGmqX8JNMNFg8/4GaYqtddPWqNpm1HjTbpCKolMXAkNvpRdGImZV5407oJFzeohXML6EwS9fDB1Km6dcQQTSJN8IYRwhtO3Hyq/pAMyeOQt9O5fjSVjney/+adr8KPn6PcAE/X3q+GtzbHnqmE9VU/j6hc8QRYAeyj3ZtHaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208197; c=relaxed/simple;
	bh=vKv1Ccaedd+ArCw5nXd/1INX3PiMzasr2GRpCbocBHs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TtVlHhj6cqRBsiBqNaY9PsDlRfvVMkijf0TVC6YIvW2gsLRcdbAO6HvntyYhJ6Zq69LA8ZRqAK9ZceUS5u8yqZNIn2UjkhbbN5Kwm1ahp77rtG4qQqTu3YmHMfs113deSo+d1j/OqYnKhwPd7ETR0c+QL1xQMJOMOGJNYKZQffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCXCURAC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCXCURAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792208194; x=1823744194;
  h=date:from:to:cc:subject:message-id;
  bh=vKv1Ccaedd+ArCw5nXd/1INX3PiMzasr2GRpCbocBHs=;
  b=bCXCURAC1rk0e3PqGEdbUIMBKSuge3/Nh29Fqt0xY6q8MWQojJz5JB9O
   pCUjBvPI2KBpsx1LFk8eGyneJKmOL/fwlG0GiXPpy8Xy5o1jx0cXyGk9Z
   nQPxA7DhPr6v5GcxkZd1wLCOR/PFRop+RRqVF6TAMzx4wGRnrWPPZrMFl
   mtiEJ8oE3ze5llKpDng09Jg6hSdGY84Rw58yhtS3wSc0yRRw1+PPALBBN
   EZm50LPQkhXe26EGR5KExGONeRPRdFtRjHcZOesIF1Y2YZG7kAtx8EF0q
   ru/NmqXFgWkfSQGYOvcAGm5qA1OdhaMfRucVYwFv3ZC4LjHTHUrllDYk/
   w==;
X-CSE-ConnectionGUID: QdIJ7c56SsaERW/0Uj/laQ==
X-CSE-MsgGUID: hJ16RpkWR+y894E2DhCxZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="973684"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="973684"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 20:36:33 -0700
X-CSE-ConnectionGUID: nmwuRsw1Qr+DU0BMQMn2Aw==
X-CSE-MsgGUID: r709PeOxRKqr6LboRxMkqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2087044"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Oct 2026 20:36:31 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHvDh-00000000J10-2q7Z;
	Sat, 17 Oct 2026 03:36:29 +0000
Date: Sat, 17 Oct 2026 11:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 cf15f9f2361dd4002203716b7b878393c0eee4bf
Message-ID: <202610171155.wMkeppWH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: cf15f9f2361dd4002203716b7b878393c0eee4bf  Merge branch 'for-7.4/cxl-fixes' into cxl-for-next

elapsed time: 843m

configs tested: 322
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1000-20261017    gcc-12.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261015    gcc-9.5.0
arc                   randconfig-2001-20261015    gcc-15.2.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1000-20261017    gcc-8.5.0
arm                   randconfig-1001-20261017    clang-20
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    clang-22
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261015    gcc-11.5.0
arm                   randconfig-2001-20261015    gcc-8.5.0
arm                  randconfig-r2100-20261015    clang-17   cocci
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1000-20261017    gcc-11.5.0
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1001-20261017    gcc-13.4.0
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-1003-20261017    gcc-8.5.0
arm64                 randconfig-2000-20261015    clang-17
arm64                 randconfig-2001-20261015    clang-17
arm64                randconfig-r2104-20261015    gcc-14.3.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1000-20261017    gcc-16.1.0
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-1001-20261017    gcc-14.3.0
csky                  randconfig-2000-20261015    gcc-13.4.0
csky                  randconfig-2001-20261015    gcc-16.1.0
csky                 randconfig-r2107-20261015    gcc-16.1.0 cocci
csky                 randconfig-r2305-20261015    gcc-16.1.0 sparse
csky                 randconfig-r2307-20261015    gcc-16.1.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-2000-20261015    clang-19
hexagon               randconfig-2001-20261015    clang-24
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261016    gcc-14
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261016    gcc-13
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261016    gcc-14
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261016    gcc-12
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261015    clang-22
i386                  randconfig-2001-20261015    clang-22
i386                  randconfig-2100-20261015    gcc-14     cocci
i386                  randconfig-2101-20261015    gcc-14     cocci
i386                  randconfig-2102-20261015    gcc-14     cocci
i386                  randconfig-2103-20261015    gcc-12     cocci
i386                  randconfig-2104-20261015    gcc-14     cocci
i386                  randconfig-2105-20261015    gcc-14     cocci
i386                  randconfig-2200-20261015    clang-22   smatch
i386                  randconfig-2300-20261015    clang-22   sparse
i386                  randconfig-2301-20261015    gcc-14     sparse
i386                  randconfig-2302-20261015    gcc-14     sparse
i386                 randconfig-r2303-20261015    gcc-14     sparse
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1000-20261017    gcc-15.2.0
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-1001-20261017    gcc-16.1.0
loongarch             randconfig-2000-20261015    clang-24
loongarch             randconfig-2001-20261015    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                 randconfig-r2103-20261015    gcc-15.2.0 cocci
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2109-20261015    gcc-15.2.0 cocci
microblaze           randconfig-r2308-20261015    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1000-20261017    gcc-11.5.0
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-1001-20261017    gcc-10.5.0
nios2                 randconfig-2000-20261015    gcc-8.5.0
nios2                 randconfig-2001-20261015    gcc-8.5.0
nios2                randconfig-r2300-20261015    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2306-20261015    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-10.5.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-1001-20261017    gcc-8.5.0
parisc                randconfig-2000-20261015    gcc-11.5.0
parisc                randconfig-2001-20261015    gcc-8.5.0
parisc               randconfig-r2106-20261015    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                       chrp32_defconfig    clang-24
powerpc               randconfig-1000-20261017    clang-17
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-2000-20261015    clang-24
powerpc               randconfig-2001-20261015    gcc-10.5.0
powerpc              randconfig-r2111-20261015    clang-18   cocci
powerpc64             randconfig-1000-20261017    clang-20
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261017    gcc-8.5.0
powerpc64             randconfig-2000-20261015    clang-19
powerpc64             randconfig-2001-20261015    gcc-8.5.0
powerpc64            randconfig-r2105-20261015    gcc-10.5.0 cocci
powerpc64            randconfig-r2304-20261015    gcc-14.3.0 sparse
powerpc64            randconfig-r2309-20261015    clang-24   sparse
powerpc64            randconfig-r2311-20261015    gcc-11.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-1001-20261017    clang-24
riscv                 randconfig-2000-20261015    gcc-8.5.0
riscv                 randconfig-2001-20261015    clang-24
riscv                randconfig-r2302-20261015    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1000-20261017    clang-24
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-1001-20261017    clang-24
s390                  randconfig-2000-20261015    clang-24
s390                  randconfig-2001-20261015    gcc-14.3.0
s390                 randconfig-r2102-20261015    gcc-8.5.0  cocci
s390                 randconfig-r2110-20261015    gcc-8.5.0  cocci
s390                 randconfig-r2202-20261015    gcc-9.5.0  smatch
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1000-20261017    gcc-16.1.0
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-1001-20261017    gcc-10.5.0
sh                    randconfig-2000-20261015    gcc-9.5.0
sh                    randconfig-2001-20261015    gcc-15.2.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1000-20261017    gcc-16.1.0
sparc                 randconfig-1001-20261017    gcc-14.3.0
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-2000-20261015    gcc-13.4.0
sparc                 randconfig-2001-20261015    gcc-15.2.0
sparc                        sparc32_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1000-20261017    gcc-8.5.0
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-2000-20261015    clang-20
sparc64               randconfig-2001-20261015    gcc-8.5.0
sparc64              randconfig-r2101-20261015    clang-21   cocci
sparc64              randconfig-r2310-20261015    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    clang-17
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1001-20261017    gcc-14
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-2000-20261015    clang-24
um                    randconfig-2001-20261015    gcc-14
um                   randconfig-r2108-20261015    clang-24   cocci
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-1006-20261017    clang-22
x86_64                randconfig-1008-20261017    gcc-12
x86_64                randconfig-1009-20261017    gcc-14
x86_64                randconfig-1010-20261017    gcc-13
x86_64                randconfig-1011-20261017    clang-22
x86_64                randconfig-1012-20261017    clang-22
x86_64                randconfig-1013-20261017    clang-22
x86_64                randconfig-1014-20261017    gcc-14
x86_64                randconfig-1015-20261017    clang-22
x86_64                randconfig-1016-20261017    clang-22
x86_64                randconfig-1017-20261017    clang-22
x86_64                randconfig-2000-20261015    gcc-14
x86_64                randconfig-2001-20261015    clang-22
x86_64                randconfig-2200-20261015    clang-22   smatch
x86_64                randconfig-2300-20261015    clang-22   sparse
x86_64                randconfig-2301-20261015    clang-22   sparse
x86_64                randconfig-2302-20261015    gcc-12     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20261017    gcc-14.3.0
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261017    gcc-8.5.0
xtensa                randconfig-2000-20261015    gcc-11.5.0
xtensa                randconfig-2001-20261015    gcc-8.5.0
xtensa               randconfig-r2200-20261015    gcc-11.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
