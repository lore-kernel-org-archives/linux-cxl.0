Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D221EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 01:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjF0BUp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjF0BUo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 26 Jun 2023 21:20:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858D1998
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jun 2023 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828843; x=1719364843;
  h=date:from:to:cc:subject:message-id;
  bh=LE9TlgIGkuu162gUugWzGHuLM/7cEaJspGLfr8YFDlU=;
  b=IUJ2BguyYCohNo37FWG6rvIYN7EGIsLSL5xS9PlfS7xLam1OMZUDRX7l
   2FWW0bdHC/CqkH2KkuO0tp6XDFG/nI4R3n2xuRIzzNsVLp88E73fNYCfZ
   hXnNBcrAQbCncksemI4DipjVvonH3pROMdog0NerpxN4f99oDYu+IswZp
   BvgdSkzADsfIwuNNFLCGRA49CnHoEEXGn/x1Wl0ZbJBHAOk5dERxcVbM3
   JOpo6wF5tt+yhIT9tFrFLoHCq5Q+Gv5VjDy3sk5fSKhrcmbcKbmezMr1K
   mR2N8js9fxGRUtsE9a5GrCM7UCYIkkuoyr+PCPSp1fIDlXZrsZBOUz4GN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="391879256"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="391879256"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719592958"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="719592958"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 18:20:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxNo-000BMP-0N;
        Tue, 27 Jun 2023 01:20:40 +0000
Date:   Tue, 27 Jun 2023 09:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:pending] BUILD SUCCESS
 0c0df63177e37ae826d803280eb2c5b6b6a7a9a4
Message-ID: <202306270936.vhP4DCnP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: 0c0df63177e37ae826d803280eb2c5b6b6a7a9a4  Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl

elapsed time: 1308m

configs tested: 142
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230626   gcc  
alpha                randconfig-r036-20230626   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230626   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r001-20230626   gcc  
arm                  randconfig-r016-20230626   clang
arm                  randconfig-r034-20230626   gcc  
arm                  randconfig-r046-20230626   clang
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230626   clang
arm64                randconfig-r036-20230626   clang
csky                                defconfig   gcc  
csky                 randconfig-r013-20230626   gcc  
hexagon              randconfig-r041-20230626   clang
hexagon              randconfig-r045-20230626   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230626   gcc  
i386                 randconfig-r002-20230626   clang
i386                 randconfig-r021-20230626   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r011-20230626   gcc  
m68k                 randconfig-r015-20230626   gcc  
m68k                 randconfig-r024-20230626   gcc  
microblaze           randconfig-r021-20230626   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                 randconfig-r006-20230626   gcc  
mips                 randconfig-r035-20230626   gcc  
mips                          rb532_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230626   gcc  
nios2                randconfig-r024-20230626   gcc  
nios2                randconfig-r032-20230626   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r026-20230626   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r004-20230626   gcc  
parisc               randconfig-r012-20230626   gcc  
parisc               randconfig-r023-20230626   gcc  
parisc               randconfig-r031-20230626   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                     redwood_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r022-20230626   gcc  
riscv                randconfig-r025-20230626   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230626   gcc  
s390                 randconfig-r044-20230626   gcc  
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                   randconfig-r001-20230626   gcc  
sh                   randconfig-r003-20230626   gcc  
sh                   randconfig-r005-20230626   gcc  
sh                   randconfig-r006-20230626   gcc  
sh                   randconfig-r014-20230626   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230626   gcc  
sparc                randconfig-r003-20230626   gcc  
sparc64              randconfig-r013-20230626   gcc  
sparc64              randconfig-r016-20230626   gcc  
sparc64              randconfig-r022-20230626   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230626   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r004-20230626   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
