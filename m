Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B711C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 17:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJUR2s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJUR2s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 13:28:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5F45078
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666373327; x=1697909327;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/Cq/WlWWxRLwBfmHSiea1GNuNX2frrYwiQUuy+auVqE=;
  b=V0/MNlBfhRvge/LesnSBRTtVXtlG5DNMl9ioJUEn18sxD1BpZO9yWD5W
   EVwtqngeU8OKkF8uawyBVT7s4GB7fdSBNyrS1MZeAdqNgQwSZ5bamB3hL
   IuI+PXLWW0VkNBgN+0He+fJImereIWjw5VoP+0e/CJF81FfK544CtdLcy
   hvWl/GziD7H4RMgu/zxzEtcpyjz5F4UQSj6S49xJe9i82JBbkEwvRM4uP
   PQPIn/JdO0Lw/cS/bHqRPda1HwhFmwWYLJQ00h/lsEErG6yiQm7+bVkas
   Fh4+1y1uZf7p5Ed4tZqvCmDkZpeOXQYKIM4zfroLI87E31DMTmLwEkLTO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333636814"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="333636814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="630582772"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="630582772"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 10:28:44 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olvp6-0002oW-08;
        Fri, 21 Oct 2022 17:28:44 +0000
Date:   Sat, 22 Oct 2022 01:27:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:rch] BUILD SUCCESS 2b76fc22aefd39820c0520255875f99b326ede99
Message-ID: <6352d699.jbBXHFPfkC9muUrq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git rch
branch HEAD: 2b76fc22aefd39820c0520255875f99b326ede99  cxl/acpi: Improve debug messages in cxl_acpi_probe()

elapsed time: 728m

configs tested: 146
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a014
nios2                         10m50_defconfig
i386                          randconfig-a012
i386                                defconfig
i386                          randconfig-a016
sh                           se7343_defconfig
sh                           se7750_defconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
x86_64                              defconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                        randconfig-a015
i386                          randconfig-a003
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
i386                          randconfig-a005
powerpc                           allnoconfig
powerpc                          allmodconfig
arm                              allyesconfig
m68k                       m5475evb_defconfig
arm64                            allyesconfig
arc                  randconfig-r043-20221020
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
s390                                defconfig
arm                          badge4_defconfig
s390                 randconfig-r044-20221020
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
mips                             allyesconfig
riscv                randconfig-r042-20221020
arm                      integrator_defconfig
sparc                            alldefconfig
i386                             allyesconfig
sh                             espt_defconfig
xtensa                              defconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
ia64                             allmodconfig
arm                      footbridge_defconfig
m68k                             allyesconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
powerpc                      ppc40x_defconfig
loongarch                         allnoconfig
loongarch                           defconfig
loongarch                        allmodconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
arc                  randconfig-r043-20221019
i386                          randconfig-c001
i386                         debian-10.3-func
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
mips                           ci20_defconfig
m68k                        mvme147_defconfig
openrisc                            defconfig
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
riscv                             allnoconfig
arm                  randconfig-c002-20221019
riscv                    nommu_virt_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
riscv                    nommu_k210_defconfig
parisc                              defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
x86_64                        randconfig-c001
parisc64                            defconfig
arm64                               defconfig
powerpc                 linkstation_defconfig
m68k                        mvme16x_defconfig
arm                        oxnas_v6_defconfig
csky                                defconfig
sparc                               defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                     mpc512x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
hexagon              randconfig-r041-20221020
i386                          randconfig-a002
hexagon              randconfig-r045-20221020
i386                          randconfig-a006
arm                          pxa168_defconfig
i386                          randconfig-a004
arm                           omap1_defconfig
x86_64                        randconfig-a016
x86_64                        randconfig-a012
arm                                 defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
mips                      malta_kvm_defconfig
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
mips                          ath25_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-k001
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                       mainstone_defconfig
powerpc                          allmodconfig
arm                         s3c2410_defconfig
mips                           ip28_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
powerpc                    gamecube_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                        magician_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
