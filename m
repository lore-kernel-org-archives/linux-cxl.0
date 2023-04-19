Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2200BC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 07:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjDSHvw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjDSHvb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 03:51:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267EC179
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681890657; x=1713426657;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S5CfpguJa4vH85O8Y4swGu1LbV/BcBxJA34BCnV1Pjs=;
  b=dN/1cUtlzrlYEBausJX/kt7dsa0RdRCs3O1LY4oRzX/YeBwRtmEuZbzL
   bx72DNGIkwO5oEu2Rh0uBTsBNiMomJbbGagt24iuzjLKb1aH5iEqLOn6P
   tWlHKiekMRcanZBs3LIssojPL1r3XyAucUstU6FfWs39CipSJPVyKCmhi
   ZrZ5Uspml/F4t+KmSH6Eqc2vlcSjFMvvD975o4rrOqwqnaRvnwk3RyjXi
   ur6nCP10cnM/UWkDZawQYYFmrDyhUs1IsLJj/+h0hoXSp8O7H7WSMaAy7
   twsATF3owF9RjID7mLTAbAdFm+JtDQ3CvJZuxXqI2az78+7La0kbovb/y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="348134198"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="348134198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865717217"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="865717217"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2023 00:50:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp2aP-000ehf-2h;
        Wed, 19 Apr 2023 07:50:41 +0000
Date:   Wed, 19 Apr 2023 15:49:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS f960e57dca9fa3653d9e9c0a9e1386d2241e0aad
Message-ID: <643f9d17.9z11Vf4ci7IgPK9h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: f960e57dca9fa3653d9e9c0a9e1386d2241e0aad  cxl/pci: Rightsize CDAT response allocation

elapsed time: 726m

configs tested: 165
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230417   gcc  
alpha        buildonly-randconfig-r002-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r016-20230415   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230417   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r035-20230417   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r012-20230413   gcc  
arm                  randconfig-r021-20230416   clang
arm                  randconfig-r035-20230416   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230416   clang
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230417   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230417   gcc  
hexagon              randconfig-r012-20230411   clang
hexagon              randconfig-r014-20230415   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
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
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230416   gcc  
ia64         buildonly-randconfig-r004-20230417   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230416   gcc  
ia64                 randconfig-r005-20230418   gcc  
ia64                 randconfig-r016-20230411   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230417   gcc  
loongarch            randconfig-r015-20230411   gcc  
loongarch            randconfig-r036-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r011-20230413   gcc  
m68k                 randconfig-r032-20230416   gcc  
m68k                 randconfig-r033-20230416   gcc  
microblaze           randconfig-r001-20230416   gcc  
microblaze           randconfig-r011-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r005-20230417   clang
mips                  cavium_octeon_defconfig   clang
mips                 randconfig-r015-20230417   gcc  
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230418   gcc  
nios2                randconfig-r012-20230415   gcc  
nios2                randconfig-r014-20230413   gcc  
nios2                randconfig-r014-20230417   gcc  
nios2                randconfig-r015-20230413   gcc  
nios2                randconfig-r015-20230415   gcc  
openrisc     buildonly-randconfig-r006-20230417   gcc  
openrisc             randconfig-r006-20230416   gcc  
openrisc             randconfig-r013-20230415   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r004-20230418   gcc  
parisc               randconfig-r013-20230411   gcc  
parisc               randconfig-r026-20230416   gcc  
parisc               randconfig-r031-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r002-20230418   clang
powerpc              randconfig-r023-20230416   gcc  
powerpc              randconfig-r034-20230416   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230416   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230417   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230418   clang
s390                 randconfig-r013-20230413   clang
s390                 randconfig-r022-20230416   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r001-20230418   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230417   gcc  
sparc64              randconfig-r024-20230416   gcc  
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
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-k001-20230417   clang
x86_64               randconfig-r016-20230417   clang
x86_64               randconfig-r031-20230417   gcc  
x86_64               randconfig-r032-20230417   gcc  
x86_64               randconfig-r036-20230417   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
