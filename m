Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAEBC77B76
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 11:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjDWLda (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 07:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDWLd3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 07:33:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6310D8
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682249608; x=1713785608;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GC+Mt4/nRVnLXPD/Q2a0L/a5Wt+yyhbrOGc1+3nWUzo=;
  b=e6o3FVDNimwajTZlG6iGQex/wT4aw9TNhpYHLbCqEZ82s9D8ykNmcnSp
   dmmg/cDD6/JXiwbWru9tDqCDuS5R0D+nXG4LU6D4mCgTeWd9tAG35yBob
   XUBxikXvooCPqreomAP+yubjWriEv6OV3T62heBbmMGRnGK1MJOMI91J1
   4cdARawBtPXZvXQaNpVp6ecjwvSb93AoB1JQFz/hD6dkzydsomxmSEa0W
   d/RDj6uf/86c3WvMqxWLCfk/ytizBRBI1m6NKc7cE8Brw5dzqwJdiuS1f
   K2lBfvVsyBjq8kpeStuifac5OnrwGpmgBXV79wcvZzyGE+8eXVTL17jHx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="345029423"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="345029423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 04:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="692757567"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="692757567"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2023 04:33:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqXxr-000hrw-22;
        Sun, 23 Apr 2023 11:33:07 +0000
Date:   Sun, 23 Apr 2023 19:32:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 dde6ba6944eaeef0ec442ebd860726db6fe499c8
Message-ID: <6445174d.zHuFoQXK3NzbAcuD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: dde6ba6944eaeef0ec442ebd860726db6fe499c8  cxl/mbox: Update CMD_RC_TABLE

elapsed time: 722m

configs tested: 115
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230423   gcc  
alpha                randconfig-r026-20230423   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230423   gcc  
arc                  randconfig-r043-20230423   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm          buildonly-randconfig-r004-20230423   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                  randconfig-r006-20230423   clang
arm                  randconfig-r023-20230423   gcc  
arm                  randconfig-r046-20230423   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230423   gcc  
arm64                randconfig-r032-20230423   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230423   gcc  
hexagon              randconfig-r041-20230423   clang
hexagon              randconfig-r045-20230423   clang
i386                             allyesconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230423   gcc  
ia64                 randconfig-r035-20230423   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230423   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r002-20230423   gcc  
microblaze           randconfig-r015-20230423   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips         buildonly-randconfig-r003-20230423   clang
nios2                               defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230423   gcc  
parisc               randconfig-r021-20230423   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc834x_mds_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r014-20230423   clang
riscv                randconfig-r042-20230423   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r036-20230423   gcc  
s390                 randconfig-r044-20230423   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230423   gcc  
sh           buildonly-randconfig-r005-20230423   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r011-20230423   gcc  
sh                   randconfig-r025-20230423   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r002-20230423   gcc  
sparc64              randconfig-r003-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230423   gcc  
xtensa               randconfig-r016-20230423   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
