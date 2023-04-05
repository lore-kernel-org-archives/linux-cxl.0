Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532ECC761A6
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Apr 2023 14:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbjDEOLx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbjDEOLk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Apr 2023 10:11:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E826E81
        for <linux-cxl@vger.kernel.org>; Wed,  5 Apr 2023 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680703870; x=1712239870;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=frr4WhsxAoPOXLjHPFujIChwBmnmmHTNgFGkMY9L/8g=;
  b=G2VpJP67JcyhzarTMgtckRk/K3L04iFSVxLg0MHIve+ciqPA5x9qJcOh
   26bww8mnhdRZiNnPFaTNqc71BvPttyRUfkKN/Z4CMq9hY4DzuVHtSv4Tr
   +iJvTFKF+XYTXdIm7weX1ZTqWpO7s7w0+wYkpliNy6VT4be5dUSPV1b/F
   z+6FX2dL046xJrOPbr5NytPpejj5eIsi0T9C68/G2Q9w5XEsF46S1I6Pd
   FOGI4oF7ksnjV6q6GF0Dj6x51Q59U0evJ2vsbZTQRjdorINgRBc9kwtIf
   L0n3AGAGGvh/cKotUzRPLQWistUA7PUBDea0AYhTzDBWuZF4cM2BOQp8l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="428745346"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428745346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 07:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="717055116"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="717055116"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2023 07:10:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pk3q2-000QZG-2o;
        Wed, 05 Apr 2023 14:10:14 +0000
Date:   Wed, 05 Apr 2023 22:09:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 ca712e47054678c5ce93a0e0f686353ad5561195
Message-ID: <642d811a.gy9Rjf8psCxwgvnP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: ca712e47054678c5ce93a0e0f686353ad5561195  Merge branch 'for-6.3/cxl-doe-fixes' into for-6.3/cxl

elapsed time: 853m

configs tested: 249
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r006-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r021-20230403   gcc  
arc                  randconfig-r022-20230403   gcc  
arc                  randconfig-r032-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm          buildonly-randconfig-r003-20230403   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                        realview_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230403   clang
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r013-20230403   gcc  
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r026-20230403   gcc  
arm64                randconfig-r032-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
csky                 randconfig-r015-20230403   gcc  
csky                 randconfig-r021-20230404   gcc  
csky                 randconfig-r033-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r004-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r014-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230403   gcc  
ia64                 randconfig-r022-20230403   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r024-20230403   gcc  
ia64                 randconfig-r026-20230404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r025-20230403   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r031-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r011-20230403   gcc  
microblaze           randconfig-r015-20230403   gcc  
microblaze           randconfig-r016-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips         buildonly-randconfig-r004-20230403   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r004-20230403   gcc  
mips                 randconfig-r015-20230403   clang
mips                 randconfig-r021-20230403   clang
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r022-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
nios2                randconfig-r035-20230403   gcc  
openrisc                         alldefconfig   gcc  
openrisc     buildonly-randconfig-r003-20230403   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r016-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc       buildonly-randconfig-r005-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc               randconfig-r034-20230403   gcc  
parisc               randconfig-r035-20230403   gcc  
parisc               randconfig-r036-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                     pq2fads_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r015-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230403   clang
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r006-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r022-20230404   gcc  
sparc                randconfig-r031-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r004-20230403   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r021-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r005-20230403   clang
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r013-20230403   gcc  
x86_64               randconfig-r016-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230403   gcc  
xtensa               randconfig-r024-20230404   gcc  
xtensa               randconfig-r026-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
