Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071EC6FD1C
	for <linux-cxl@archiver.kernel.org>; Sat, 25 Mar 2023 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCYNJI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 25 Mar 2023 09:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCYNJH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 25 Mar 2023 09:09:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01C11174
        for <linux-cxl@vger.kernel.org>; Sat, 25 Mar 2023 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679749745; x=1711285745;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FWp3IegVXv50ghUegpAYpCWoPoJuHdukew8mGryWMA4=;
  b=LKYdg7aOW2smzrmDLXUM9W+DqIWeiCMpBm5PKjDOOMWYDypXaHdvgNd5
   6uImnRGo63UkQyIpO+Af0SmWn/e7BDP0/fm78Bt06+crNysT92oYdKKoK
   QabYvJlMIG2PI24SJP5klqR7Mn0+3+3roB1UMbtifIL5xhncxHQ8QG87j
   34EcTZDuUBvNYuz8ujiGrffKKfne9Sk+ho52A5sIToDhTq6WEpDL9dpqh
   Kvlq0Egzn6RbzkkstFwZ9vgIOohRiTnxnVg5jxBZ7ZMR214QHhgmWjwq1
   6oO+3kxHSP3pT/Vvz6XGOif+qVLZXLfbntif1dZyz6QRVJ2inCLbMaFCy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="328399113"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="328399113"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 06:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="747480795"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="747480795"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2023 06:09:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg3dl-000GHB-2t;
        Sat, 25 Mar 2023 13:09:01 +0000
Date:   Sat, 25 Mar 2023 21:08:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.4/cxl-type-2] BUILD SUCCESS
 0b80e8b55828313bcd08c4740646689e648de444
Message-ID: <641ef25a.UyHxiuEeKlAjdgup%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.4/cxl-type-2
branch HEAD: 0b80e8b55828313bcd08c4740646689e648de444  tools/testing/cxl: Emulate a CXL accelerator with local memory

Unverified Warning (likely false positive, please contact us if interested):

drivers/cxl/core/memdev.c:414 cxl_acquire_endpoint() warn: inconsistent returns '&cxlmd->dev.mutex'.
drivers/cxl/core/pci.c:493 cxl_probe_link() warn: right shifting more than type allows 16 vs 16

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021
    |-- drivers-cxl-core-memdev.c-cxl_acquire_endpoint()-warn:inconsistent-returns-cxlmd-dev.mutex-.
    `-- drivers-cxl-core-pci.c-cxl_probe_link()-warn:right-shifting-more-than-type-allows-vs

elapsed time: 727m

configs tested: 213
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r001-20230323   gcc  
arc                  randconfig-r013-20230323   gcc  
arc                  randconfig-r034-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arc                  randconfig-r043-20230324   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm          buildonly-randconfig-r001-20230322   clang
arm          buildonly-randconfig-r003-20230324   clang
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                          moxart_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r021-20230322   clang
arm                  randconfig-r023-20230322   clang
arm                  randconfig-r046-20230322   clang
arm                  randconfig-r046-20230324   clang
arm                        shmobile_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230322   clang
arm64        buildonly-randconfig-r006-20230322   clang
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230322   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
csky                 randconfig-r022-20230324   gcc  
hexagon                          alldefconfig   clang
hexagon      buildonly-randconfig-r004-20230322   clang
hexagon              randconfig-r002-20230322   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r035-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r041-20230324   clang
hexagon              randconfig-r045-20230322   clang
hexagon              randconfig-r045-20230324   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230322   gcc  
ia64                 randconfig-r003-20230323   gcc  
ia64                 randconfig-r004-20230322   gcc  
ia64                 randconfig-r005-20230322   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r014-20230323   gcc  
ia64                 randconfig-r031-20230322   gcc  
ia64                 randconfig-r032-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230322   gcc  
loongarch            randconfig-r021-20230322   gcc  
loongarch            randconfig-r024-20230322   gcc  
loongarch            randconfig-r026-20230324   gcc  
loongarch            randconfig-r032-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r015-20230322   gcc  
m68k                 randconfig-r023-20230322   gcc  
microblaze           randconfig-r015-20230322   gcc  
microblaze           randconfig-r024-20230324   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230322   clang
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r023-20230322   clang
mips                 randconfig-r034-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2        buildonly-randconfig-r002-20230324   gcc  
nios2        buildonly-randconfig-r004-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230322   gcc  
nios2                randconfig-r003-20230322   gcc  
nios2                randconfig-r036-20230322   gcc  
openrisc     buildonly-randconfig-r002-20230322   gcc  
openrisc             randconfig-r011-20230323   gcc  
openrisc             randconfig-r015-20230322   gcc  
openrisc             randconfig-r024-20230322   gcc  
openrisc             randconfig-r033-20230322   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230323   gcc  
parisc               randconfig-r003-20230322   gcc  
parisc               randconfig-r004-20230322   gcc  
parisc               randconfig-r011-20230322   gcc  
parisc               randconfig-r012-20230323   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r016-20230322   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-c003-20230322   gcc  
powerpc              randconfig-r004-20230323   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r021-20230322   gcc  
powerpc              randconfig-r025-20230322   gcc  
powerpc                    socrates_defconfig   clang
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230324   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r022-20230322   gcc  
riscv                randconfig-r024-20230322   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                randconfig-r042-20230324   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230324   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230322   gcc  
s390                 randconfig-r016-20230322   gcc  
s390                 randconfig-r023-20230322   gcc  
s390                 randconfig-r031-20230322   clang
s390                 randconfig-r035-20230322   clang
s390                 randconfig-r044-20230322   gcc  
s390                 randconfig-r044-20230324   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230324   gcc  
sh                   randconfig-r005-20230322   gcc  
sh                   randconfig-r013-20230322   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r022-20230322   gcc  
sh                   randconfig-r036-20230322   gcc  
sparc        buildonly-randconfig-r005-20230324   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230322   gcc  
sparc                randconfig-r006-20230323   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc                randconfig-r035-20230322   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r016-20230323   gcc  
sparc64              randconfig-r031-20230322   gcc  
sparc64              randconfig-r035-20230322   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230322   gcc  
xtensa       buildonly-randconfig-r006-20230322   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r001-20230322   gcc  
xtensa               randconfig-r002-20230322   gcc  
xtensa               randconfig-r014-20230322   gcc  
xtensa               randconfig-r025-20230322   gcc  
xtensa               randconfig-r035-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
