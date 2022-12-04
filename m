Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4716C47089
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 19:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLDTc0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 14:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLDTcY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 14:32:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60510B63
        for <linux-cxl@vger.kernel.org>; Sun,  4 Dec 2022 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670182344; x=1701718344;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ET0vFkv1MQZAKQ9GxqhnO4H+a+jY1DtI/8BaO0CBjFo=;
  b=mj9sdTvytSzJO/oAqRDq9INucjXfmOmdYjumih4GQwarkO1MwPxt39Au
   VMiDiRR1e9uJMbkzHnJIba6omCXEbXQhlQv62D+d/3HNTv4dDxm61sUti
   +78/4VH94w2lT+VKEsByFbQ9q1/ffJmSeQsZ1nIuAeCtWw8RqvDzzB6gs
   oepB/SUnS0g2HSxQhtF2O76igAazCSEYlRJ9GPyPSG79XYAoOlbOh41n2
   gieG62URqmB8NV6AEmfdGPTSpjkiLS/TSUeD5lqatcGAGHTY0Ji7GTfwQ
   Laxrhc1XoYIKJ9P2dQo8bIJ0XzTzOmK+AakU0uPpuyQ4w9uRoDGYP5lRq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="296572956"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="296572956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 11:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="645585604"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="645585604"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2022 11:32:21 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1uiq-0000yw-1y;
        Sun, 04 Dec 2022 19:32:20 +0000
Date:   Mon, 05 Dec 2022 03:31:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 d72a5b810410c076d4dd63fe542a5a4d6c145cfa
Message-ID: <638cf592.c5/E4aIXV4VAMryb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: d72a5b810410c076d4dd63fe542a5a4d6c145cfa  Merge branch 'for-6.2/cxl-xor' into for-6.2/cxl

elapsed time: 721m

configs tested: 84
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
s390                             allmodconfig
arm                                 defconfig
s390                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                        randconfig-a013
s390                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
m68k                             allmodconfig
i386                          randconfig-a016
i386                          randconfig-a005
arc                              allyesconfig
x86_64                        randconfig-a015
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
m68k                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
mips                     loongson1b_defconfig
mips                           jazz_defconfig
arm                        cerfcube_defconfig
sh                           se7722_defconfig
arc                     nsimosci_hs_defconfig
i386                          randconfig-c001
mips                           xway_defconfig
mips                 randconfig-c004-20221204
powerpc                    adder875_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
sh                            shmin_defconfig
loongarch                         allnoconfig
loongarch                           defconfig
arm                        spear6xx_defconfig
arm                           sama5_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
loongarch                        allmodconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
i386                              debian-10.3
riscv                          rv32_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a003
s390                 randconfig-r044-20221204
riscv                randconfig-r042-20221204
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-k001
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
