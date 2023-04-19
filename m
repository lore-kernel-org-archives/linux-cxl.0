Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF831C77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjDSHtu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjDSHtr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 03:49:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EB1BC7
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681890585; x=1713426585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QtjGvrdrzfgAG9kWmKHlDzqS+0KELdgMMwPh0DHTLe4=;
  b=PixWbP+FJAgol20ChRptwNijGUla5vlFrif76dSMcBrSqguNAmdF+Qrg
   8tfxOpIhyEnguTbBhs/Me4gJ3bnxd+bVXrVDmTB/gJRb52PW4TYLo0bG+
   WhN+XgnYfZhLBCAlxMwa2nMMt516H4CIZjC4320/4sSJt8IgDNHtjOhwF
   ZCD7fsr+kf6ej3q4ohYJTuYGuWiosWyCj1bAPCjieWCFHMmshdFt4QohM
   uap1vu8oBXqFsdM6/zYo1UnI7xequ7XLTOFS+TZ8aj9WDXAkhR3E0u9zR
   hExxdmXda7EDLzLRtK1aTiKiLeK7snKhSHk72g1uJvS2XUX07wmpRfW0v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431659654"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431659654"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684893838"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="684893838"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2023 00:49:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp2ZR-000eh6-1d;
        Wed, 19 Apr 2023 07:49:41 +0000
Date:   Wed, 19 Apr 2023 15:49:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 c841ecd8277154c9297dd9ac959494f6deb61e76
Message-ID: <643f9d06.JWRpNV31HkMplilT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: c841ecd8277154c9297dd9ac959494f6deb61e76  cxl/hdm: Add more HDM decoder debug messages at startup

elapsed time: 728m

configs tested: 175
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r002-20230418   gcc  
alpha                randconfig-r004-20230417   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230417   gcc  
arc          buildonly-randconfig-r004-20230417   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r021-20230416   gcc  
arc                  randconfig-r023-20230417   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                  randconfig-r043-20230418   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r031-20230418   gcc  
arm                  randconfig-r032-20230416   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                  randconfig-r046-20230418   clang
arm                         s3c6400_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230418   clang
arm64                randconfig-r011-20230418   gcc  
arm64                randconfig-r024-20230418   gcc  
arm64                randconfig-r035-20230417   gcc  
csky         buildonly-randconfig-r006-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230417   gcc  
csky                 randconfig-r021-20230417   gcc  
csky                 randconfig-r023-20230418   gcc  
csky                 randconfig-r032-20230417   gcc  
hexagon              randconfig-r003-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r041-20230418   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
hexagon              randconfig-r045-20230418   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r026-20230416   gcc  
ia64                 randconfig-r036-20230418   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230416   gcc  
loongarch    buildonly-randconfig-r005-20230416   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230418   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r003-20230416   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r016-20230418   gcc  
m68k                 randconfig-r033-20230418   gcc  
microblaze           randconfig-r014-20230418   gcc  
microblaze           randconfig-r022-20230418   gcc  
microblaze           randconfig-r034-20230418   gcc  
microblaze           randconfig-r036-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                 randconfig-r001-20230416   gcc  
mips                 randconfig-r024-20230417   gcc  
mips                 randconfig-r026-20230418   clang
mips                 randconfig-r031-20230417   clang
mips                 randconfig-r033-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230418   gcc  
nios2                randconfig-r021-20230418   gcc  
openrisc     buildonly-randconfig-r003-20230416   gcc  
openrisc             randconfig-r006-20230416   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230417   clang
powerpc              randconfig-r002-20230417   gcc  
powerpc              randconfig-r006-20230418   clang
powerpc              randconfig-r012-20230418   gcc  
powerpc              randconfig-r013-20230418   gcc  
powerpc              randconfig-r015-20230418   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r032-20230418   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230417   clang
riscv                randconfig-r025-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                randconfig-r042-20230418   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230416   clang
s390                 randconfig-r022-20230416   gcc  
s390                 randconfig-r025-20230417   clang
s390                 randconfig-r026-20230417   clang
s390                 randconfig-r034-20230417   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
s390                 randconfig-r044-20230418   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r005-20230417   gcc  
sh                   randconfig-r024-20230416   gcc  
sh                   randconfig-r035-20230416   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230418   gcc  
sparc64              randconfig-r033-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230417   gcc  
xtensa               randconfig-r023-20230416   gcc  
xtensa               randconfig-r034-20230416   gcc  
xtensa               randconfig-r035-20230418   gcc  
xtensa               randconfig-r036-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
