Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000B0C433FE
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Oct 2022 10:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJWKp4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Oct 2022 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJWKp4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Oct 2022 06:45:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7746EF3B
        for <linux-cxl@vger.kernel.org>; Sun, 23 Oct 2022 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666521954; x=1698057954;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZCG+dPRMaiVvYAM1xPKWCOs52xh0QXL/j31prNf35z4=;
  b=TLnRHuprSQU4VPxt7gzxJHh32nMQd/CVxgS6fis2hsvCZRhPBwtwqVhx
   KLqBrNa4k9W5nQBRN3yt0MjeE7D3UpghfM4Y7Gs5Rmgix6Z7No7ZNbbdR
   Wb1LaI7i8r4WbhOpQRnWVjuqb+oVWRogU4X78GLHbkd/a1ISUtVp1Zb7a
   KLLZGJwB5fi4M/50eQRWQa9N9Qhj8eCTD7rmkoekSZA10B2/xMA4xBCj9
   jJtgC/SoVlX+ddqaJ7iRBRTkTGkQcrVe+0ws44g+EwlTX4xPi7VcKF5FK
   dYrT1Cq79uVzbxkD+ABk1AWDHLDm6bSAVLpybFh3Yn300N5GzMHxR1yXZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="287652153"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="287652153"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 03:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="664252319"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="664252319"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2022 03:45:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omYUJ-0004KA-0t;
        Sun, 23 Oct 2022 10:45:51 +0000
Date:   Sun, 23 Oct 2022 18:45:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 df4f5aa75d87921d3467942165e3879269e06b33
Message-ID: <63551b5b.bX6o1aa3zoS89luc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: df4f5aa75d87921d3467942165e3879269e06b33  cxl/pmem: Use size_add() against integer overflow

elapsed time: 723m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                                 defconfig
x86_64                           allyesconfig
alpha                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221023
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
sh                               allmodconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
i386                          randconfig-a001
s390                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a003
s390                                defconfig
i386                          randconfig-a014
powerpc                      makalu_defconfig
i386                          randconfig-a005
i386                          randconfig-a012
m68k                        mvme16x_defconfig
sh                     sh7710voipgw_defconfig
i386                          randconfig-a016
powerpc                 mpc8540_ads_defconfig
arc                        nsim_700_defconfig
s390                             allyesconfig
xtensa                    xip_kc705_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
sh                           se7619_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                         apollo_defconfig
powerpc                  iss476-smp_defconfig
m68k                             allyesconfig
parisc                              defconfig
csky                                defconfig
nios2                               defconfig
sparc                               defconfig
x86_64                                  kexec
parisc64                            defconfig
riscv                             allnoconfig
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
i386                          debian-10.3-kvm
riscv                          rv32_defconfig
i386                        debian-10.3-kunit
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
loongarch                         allnoconfig
sparc                            allyesconfig
powerpc                    adder875_defconfig
sparc64                             defconfig
sh                   rts7751r2dplus_defconfig
sh                         ap325rxa_defconfig
arm                          exynos_defconfig
powerpc                   currituck_defconfig
xtensa                           allyesconfig
nios2                            allyesconfig
arm                      footbridge_defconfig
csky                              allnoconfig
sh                          urquell_defconfig
loongarch                           defconfig
parisc                           allyesconfig

clang tested configs:
riscv                randconfig-r042-20221023
hexagon              randconfig-r041-20221023
hexagon              randconfig-r045-20221023
x86_64                        randconfig-a001
s390                 randconfig-r044-20221023
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a011
mips                       lemote2f_defconfig
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                     powernv_defconfig
arm                           spitz_defconfig
powerpc                       ebony_defconfig
i386                          randconfig-a015
mips                        bcm63xx_defconfig
mips                          ath79_defconfig
mips                      maltaaprp_defconfig
mips                      malta_kvm_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-k001
powerpc                      makalu_defconfig
powerpc                 mpc8540_ads_defconfig
hexagon                          alldefconfig
mips                           rs90_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
