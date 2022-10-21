Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941BC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJUM0T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUM0R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 08:26:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99017EF0F
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666355175; x=1697891175;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/xngK0uWFxK3krgPo55BKXlxheHtWXmPU9RQMETlkJU=;
  b=CIam0aUl5uwgfIOFOo1B9UOyQGRc6AQLVLtQgVDbypMpaBvNfgUmwcqw
   1oR4Zv283d9hTnrH+StHjqev6uNOQbg69ymvHhCGjhx7gsJRoX5jVJfMA
   PNrE8QbSxrINm5c6LqEW1MN9BjIuw462fAK5BhytW+3x4HfTE6udzdmtP
   e1m8AY+JzLhbiRmi2tdiksHbqZVO4qIdM0+bUnkB+7fWzfNldxdY8QG16
   iZMc8AWBxw8Sk7BJBpmfIoJgPyoqnGW7gsRwsUktBK5O07MQmY0S+QdKn
   dKtEcXhJ3YU7VuQo0bkZE/uwNwsp5Gk3lFSoqo7nLO+zJ18O/mb0o/Qkf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287393528"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287393528"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 05:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="661581888"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661581888"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2022 05:26:12 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olr6J-0002aT-39;
        Fri, 21 Oct 2022 12:26:11 +0000
Date:   Fri, 21 Oct 2022 20:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 f010c75c05299ecd65adfd31a7841eea3476ce1f
Message-ID: <63528fd3.gxQfPZs7TqrKZ70h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: f010c75c05299ecd65adfd31a7841eea3476ce1f  cxl/pmem: Fix failure to account for 8 byte header for writes to the device LSA.

elapsed time: 725m

configs tested: 135
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                           x86_64_defconfig
mips                             allyesconfig
sh                               allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                          rhel-8.3-func
i386                                defconfig
openrisc                         alldefconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                              defconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
powerpc                       holly_defconfig
arc                  randconfig-r043-20221019
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
arc                              allyesconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20221020
x86_64                        randconfig-a015
s390                 randconfig-r044-20221020
alpha                            allyesconfig
i386                          randconfig-a005
riscv                randconfig-r042-20221020
i386                             allyesconfig
mips                       bmips_be_defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
loongarch                           defconfig
m68k                        mvme16x_defconfig
powerpc                 linkstation_defconfig
sparc                               defconfig
arm                      integrator_defconfig
arm64                               defconfig
sh                             espt_defconfig
arm                      footbridge_defconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
ia64                             allmodconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                ecovec24-romimage_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
parisc                              defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
nios2                               defconfig
riscv                             allnoconfig
mips                      loongson3_defconfig
xtensa                generic_kc705_defconfig
nios2                            alldefconfig
riscv                    nommu_virt_defconfig
i386                              debian-10.3
riscv                    nommu_k210_defconfig
arm                  randconfig-c002-20221019
riscv                          rv32_defconfig
x86_64                        randconfig-c001
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
parisc64                            defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
openrisc                            defconfig
arm                  randconfig-c002-20221020

clang tested configs:
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig
i386                 randconfig-a011-20221017
x86_64                        randconfig-a005
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221020
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221020
i386                 randconfig-a013-20221017
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221019
x86_64                        randconfig-a012
i386                 randconfig-a012-20221017
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r041-20221019
i386                 randconfig-a014-20221017
x86_64                        randconfig-a014
i386                 randconfig-a016-20221017
i386                          randconfig-a006
s390                 randconfig-r044-20221019
i386                          randconfig-a004
i386                 randconfig-a015-20221017
mips                           rs90_defconfig
arm                           omap1_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          ep93xx_defconfig
arm                                 defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
powerpc                 mpc836x_rdk_defconfig
mips                      malta_kvm_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
x86_64                        randconfig-k001
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
