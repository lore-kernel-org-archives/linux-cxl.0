Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CF8C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjEXKhJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 06:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEXKhD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 06:37:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6180184
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684924621; x=1716460621;
  h=date:from:to:cc:subject:message-id;
  bh=6TVRUHTwNUwm4DJ+yux5j2NPACfwvN32rQ4lUZYFppU=;
  b=bVOFQ1AEeYHew/SYOJe2i2a2vGrD3kk0YQUo2T2e0GFW5nx2AVILTc87
   rvwOw8J5D19/f+eE3av6epCeQuisx7Mrg0TLRiwcD/V3ZACpDthMKrz+B
   Iot96xsyettdEMior807JnhiC0hjJ604zmMI7rSjVl6CT8LoZjjRW8/o+
   qBubECxAS3IWdKFtBrD0XKHJ0Yun+gCMxsEBDg5Tn6My1knrJFd+tWE7P
   pydGblAZiUlSCRZN+NgkFO1qZEpjgoVMIdsSBeVBONibmd3VD/vi0y84B
   H0IuKxtda2fLliZcS4x6otT7fuZYV0JPY1wqIQyYoRM7QJZL1EpGZVwJ2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="351037009"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="351037009"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 03:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848694105"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="848694105"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2023 03:36:59 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1lrW-000EgG-2q;
        Wed, 24 May 2023 10:36:58 +0000
Date:   Wed, 24 May 2023 18:36:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:pending] BUILD SUCCESS
 ccadf1310fb0bc8d2cbcd14f94a6279c12ea9bee
Message-ID: <20230524103622.Xz9DF%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230524154417/lkp-src/repo/*/cxl
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: ccadf1310fb0bc8d2cbcd14f94a6279c12ea9bee  cxl/mbox: Add background cmd handling machinery

elapsed time: 721m

configs tested: 267
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230522   gcc  
alpha                randconfig-r004-20230522   gcc  
alpha                randconfig-r006-20230522   gcc  
alpha                randconfig-r034-20230521   gcc  
alpha                randconfig-r036-20230522   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc          buildonly-randconfig-r004-20230521   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r006-20230522   gcc  
arc                  randconfig-r012-20230522   gcc  
arc                  randconfig-r015-20230522   gcc  
arc                  randconfig-r024-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r004-20230522   gcc  
arm          buildonly-randconfig-r005-20230521   clang
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                       imx_v6_v7_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r004-20230521   gcc  
arm                  randconfig-r005-20230521   gcc  
arm                  randconfig-r014-20230522   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230521   clang
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230522   clang
arm64                randconfig-r021-20230521   gcc  
arm64                randconfig-r023-20230521   gcc  
arm64                randconfig-r023-20230522   clang
csky         buildonly-randconfig-r003-20230522   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230522   gcc  
csky                 randconfig-r022-20230522   gcc  
csky                 randconfig-r024-20230521   gcc  
csky                 randconfig-r025-20230521   gcc  
csky                 randconfig-r026-20230521   gcc  
csky                 randconfig-r035-20230521   gcc  
hexagon      buildonly-randconfig-r001-20230521   clang
hexagon      buildonly-randconfig-r002-20230521   clang
hexagon              randconfig-r004-20230522   clang
hexagon              randconfig-r031-20230521   clang
hexagon              randconfig-r032-20230521   clang
hexagon              randconfig-r033-20230522   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-i051-20230523   clang
i386                 randconfig-i052-20230523   clang
i386                 randconfig-i053-20230523   clang
i386                 randconfig-i054-20230523   clang
i386                 randconfig-i055-20230523   clang
i386                 randconfig-i056-20230523   clang
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
i386                 randconfig-r016-20230522   clang
i386                 randconfig-r034-20230522   gcc  
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230522   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r004-20230521   gcc  
ia64                 randconfig-r014-20230523   gcc  
ia64                 randconfig-r023-20230521   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230521   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230521   gcc  
loongarch            randconfig-r005-20230522   gcc  
loongarch            randconfig-r012-20230521   gcc  
loongarch            randconfig-r014-20230521   gcc  
loongarch            randconfig-r016-20230523   gcc  
loongarch            randconfig-r022-20230521   gcc  
loongarch            randconfig-r026-20230521   gcc  
loongarch            randconfig-r033-20230522   gcc  
loongarch            randconfig-r034-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230522   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230521   gcc  
m68k                 randconfig-r022-20230522   gcc  
m68k                 randconfig-r024-20230522   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r002-20230522   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230522   clang
mips         buildonly-randconfig-r006-20230521   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r036-20230521   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230522   gcc  
nios2                randconfig-r013-20230523   gcc  
nios2                randconfig-r025-20230521   gcc  
nios2                randconfig-r033-20230521   gcc  
nios2                randconfig-r036-20230521   gcc  
openrisc     buildonly-randconfig-r001-20230522   gcc  
openrisc             randconfig-r003-20230522   gcc  
openrisc             randconfig-r015-20230522   gcc  
openrisc             randconfig-r021-20230522   gcc  
openrisc             randconfig-r031-20230522   gcc  
openrisc             randconfig-r032-20230521   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r032-20230522   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                      walnut_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230523   gcc  
riscv                randconfig-r013-20230521   gcc  
riscv                randconfig-r025-20230522   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230522   clang
s390                                defconfig   gcc  
s390                 randconfig-r005-20230522   gcc  
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r032-20230522   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r004-20230521   gcc  
sh           buildonly-randconfig-r005-20230522   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r001-20230521   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                   randconfig-r016-20230521   gcc  
sh                   randconfig-r034-20230522   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230522   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230521   gcc  
sparc                randconfig-r014-20230521   gcc  
sparc                randconfig-r022-20230521   gcc  
sparc                randconfig-r023-20230522   gcc  
sparc                randconfig-r033-20230521   gcc  
sparc                randconfig-r035-20230522   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r002-20230521   gcc  
sparc64              randconfig-r002-20230522   gcc  
sparc64              randconfig-r006-20230521   gcc  
sparc64              randconfig-r013-20230522   gcc  
sparc64              randconfig-r026-20230522   gcc  
sparc64              randconfig-r035-20230521   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230522   clang
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230522   clang
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230522   clang
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230522   clang
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230522   clang
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r011-20230522   clang
x86_64               randconfig-r036-20230522   gcc  
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64                        randconfig-x081   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64                        randconfig-x082   clang
x86_64               randconfig-x083-20230522   gcc  
x86_64                        randconfig-x083   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64                        randconfig-x084   clang
x86_64               randconfig-x085-20230522   gcc  
x86_64                        randconfig-x085   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                        randconfig-x086   clang
x86_64               randconfig-x091-20230523   gcc  
x86_64               randconfig-x092-20230523   gcc  
x86_64               randconfig-x093-20230523   gcc  
x86_64               randconfig-x094-20230523   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230521   gcc  
xtensa               randconfig-r011-20230522   gcc  
xtensa               randconfig-r012-20230523   gcc  
xtensa               randconfig-r014-20230522   gcc  
xtensa               randconfig-r031-20230522   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
