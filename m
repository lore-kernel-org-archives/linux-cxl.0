Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F1C3DA7A
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Jan 2023 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjAFK3u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 Jan 2023 05:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjAFK31 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 Jan 2023 05:29:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA20B72887
        for <linux-cxl@vger.kernel.org>; Fri,  6 Jan 2023 02:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673000845; x=1704536845;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WUL8bbdzZBGJyLYr0nONz2miCdMu0mtOpK1dxxl75dw=;
  b=X9vCtuP7mlkpWgyjV6AFCCs7uDkEw/AOJLDpOc8+iqrw7JhwPVs3yy/0
   xQSKJ2H1IIs/XXlN43n9FURZgNrh17PpOJa/EqaK1zQvdjowYETjCD3i/
   iDVjGZJQFa3NGzEmTov4RHcjjZW1h2caJyima38QH3/9vWBd8lljlA9t9
   lnoG9j6bwLi3shUj5DBkqcR7kqCxl/SDxpT96S5zI4K2/dzDWzRnSJM1v
   7qv/wiUM8/aS9laq7bgjQ5SUkuF1goRCJ4sLDLwWlrAtdlPELLD792gQa
   VAl907IfuzqEvp9vFU2TzKWMafBH17aFpu4s12ax8+pkOAFBcz4rpXeVq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305968660"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="305968660"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 02:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="829865291"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="829865291"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Jan 2023 02:26:21 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDjvY-0003EY-2J;
        Fri, 06 Jan 2023 10:26:20 +0000
Date:   Fri, 06 Jan 2023 18:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS 589c3357370a596ef7c99c00baca8ac799fce531
Message-ID: <63b7f731.3sbnx216SVhe7kK0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 589c3357370a596ef7c99c00baca8ac799fce531  PCI/CXL: Export native CXL error reporting control

elapsed time: 724m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
m68k                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64                        randconfig-a004
i386                          randconfig-a001
arm                              allyesconfig
i386                          randconfig-a003
sh                               allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                               rhel-8.3
i386                          randconfig-a014
arc                  randconfig-r043-20230105
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                           allyesconfig
mips                             allyesconfig
i386                          randconfig-a012
powerpc                      tqm8xx_defconfig
i386                          randconfig-a016
arc                                 defconfig
ia64                             allmodconfig
s390                 randconfig-r044-20230105
riscv                randconfig-r042-20230105
arc                        nsimosci_defconfig
x86_64                        randconfig-a015
m68k                        mvme16x_defconfig
sh                        sh7785lcr_defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
s390                             allyesconfig
arm                       omap2plus_defconfig
m68k                            q40_defconfig
sh                          landisk_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     stx_gp3_defconfig
sh                             shx3_defconfig
arc                    vdk_hs38_smp_defconfig
arm                           imxrt_defconfig
m68k                          sun3x_defconfig
powerpc                      makalu_defconfig
arm                       imx_v6_v7_defconfig
sh                             sh03_defconfig
nios2                         10m50_defconfig
m68k                        m5307c3_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7780_defconfig
parisc64                            defconfig
powerpc                         ps3_defconfig
loongarch                         allnoconfig
sh                      rts7751r2d1_defconfig
csky                                defconfig
riscv                             allnoconfig
mips                 randconfig-c004-20230105
arm                              allmodconfig
arc                 nsimosci_hs_smp_defconfig
arm                      footbridge_defconfig
i386                          randconfig-c001
powerpc                   motionpro_defconfig
sparc                               defconfig
arm                         cm_x300_defconfig
riscv                    nommu_virt_defconfig
loongarch                           defconfig
riscv                    nommu_k210_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                         assabet_defconfig
sh                   rts7751r2dplus_defconfig
mips                 decstation_r4k_defconfig
i386                                defconfig
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a005
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a011
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
x86_64                        randconfig-a016
x86_64                        randconfig-a003
hexagon              randconfig-r045-20230105
x86_64                        randconfig-a012
arm                        spear3xx_defconfig
i386                          randconfig-a015
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
mips                       rbtx49xx_defconfig
arm                         bcm2835_defconfig
powerpc                     ksi8560_defconfig
powerpc                   lite5200b_defconfig
arm                      pxa255-idp_defconfig
arm                       netwinder_defconfig
arm                         shannon_defconfig
mips                      pic32mzda_defconfig
powerpc                     powernv_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
