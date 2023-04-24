Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8BC77B76
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Apr 2023 09:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXJt5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Apr 2023 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjDXJtr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Apr 2023 05:49:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A09E1713
        for <linux-cxl@vger.kernel.org>; Mon, 24 Apr 2023 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682329786; x=1713865786;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ztLijUg8X7vbdsL56P0X8qLLP39ftH/suOWMo25n41E=;
  b=Tg8etTBdvX+8KlX5Iq14DAJGWBc45cJcieeLdOatXX++okl1BgqchAGj
   uM6DzXahZ3mG3txrDsgDawpAZYxU7JJxX6TDz6nfVs4Kikw00ZaO1e4D1
   p7Nx3eDR7YiRKC5iahFhd+evzo+H22mXNFk8rajYMJnLoyWhVeQ8Ic5h3
   QEC5Vcm82p3TXDzfSAqhUnOX5+VrcLSd6A0ZKgZ3A6gCwOI2BRdw2fYoP
   FJPf1sJyxa/RCRafom3n28imHrirUnqVnUa4lIr4YNwApxouL2+f6pGI+
   OjQrCQT82R/DyFbsLE/i54ljlZQolhUzMC/uaJTXuGA0fa4XuMcr07zl0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="374356104"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="374356104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 02:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="1022642719"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="1022642719"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Apr 2023 02:49:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqspL-000iLf-0S;
        Mon, 24 Apr 2023 09:49:43 +0000
Date:   Mon, 24 Apr 2023 17:49:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS bfe58458fd2557c9a81b89bc0ff10eb03d6c0745
Message-ID: <644650ad.6sJWMgzqq2D6G2Fd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: bfe58458fd2557c9a81b89bc0ff10eb03d6c0745  cxl/mbox: Update CMD_RC_TABLE

elapsed time: 796m

configs tested: 209
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230423   gcc  
alpha        buildonly-randconfig-r006-20230423   gcc  
alpha        buildonly-randconfig-r006-20230424   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230423   gcc  
alpha                randconfig-r021-20230423   gcc  
alpha                randconfig-r031-20230424   gcc  
alpha                randconfig-r032-20230423   gcc  
alpha                randconfig-r035-20230424   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230423   gcc  
arc                  randconfig-r022-20230423   gcc  
arc                  randconfig-r043-20230423   gcc  
arc                  randconfig-r043-20230424   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230424   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                  randconfig-r006-20230423   clang
arm                  randconfig-r013-20230424   clang
arm                  randconfig-r025-20230423   gcc  
arm                  randconfig-r046-20230423   gcc  
arm                  randconfig-r046-20230424   clang
arm                           sama7_defconfig   clang
arm                         socfpga_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230423   clang
csky         buildonly-randconfig-r001-20230423   gcc  
csky         buildonly-randconfig-r003-20230423   gcc  
csky         buildonly-randconfig-r005-20230423   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230423   gcc  
csky                 randconfig-r022-20230424   gcc  
csky                 randconfig-r023-20230423   gcc  
csky                 randconfig-r024-20230423   gcc  
hexagon      buildonly-randconfig-r002-20230424   clang
hexagon              randconfig-r006-20230424   clang
hexagon              randconfig-r041-20230423   clang
hexagon              randconfig-r041-20230424   clang
hexagon              randconfig-r045-20230423   clang
hexagon              randconfig-r045-20230424   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230424   clang
i386                 randconfig-a002-20230424   clang
i386                 randconfig-a003-20230424   clang
i386                 randconfig-a004-20230424   clang
i386                 randconfig-a005-20230424   clang
i386                 randconfig-a006-20230424   clang
i386                 randconfig-a011-20230424   gcc  
i386                 randconfig-a012-20230424   gcc  
i386                 randconfig-a013-20230424   gcc  
i386                 randconfig-a014-20230424   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230424   gcc  
i386                 randconfig-a016-20230424   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r015-20230424   gcc  
i386                 randconfig-r016-20230424   gcc  
i386                 randconfig-r034-20230424   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230424   gcc  
ia64                 randconfig-r012-20230424   gcc  
ia64                 randconfig-r025-20230423   gcc  
ia64                 randconfig-r032-20230423   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230424   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230423   gcc  
loongarch            randconfig-r002-20230423   gcc  
loongarch            randconfig-r011-20230424   gcc  
loongarch            randconfig-r013-20230423   gcc  
loongarch            randconfig-r033-20230424   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r002-20230423   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                 randconfig-r004-20230423   gcc  
m68k                 randconfig-r021-20230424   gcc  
m68k                 randconfig-r032-20230424   gcc  
m68k                 randconfig-r036-20230423   gcc  
microblaze   buildonly-randconfig-r006-20230423   gcc  
microblaze           randconfig-r003-20230424   gcc  
microblaze           randconfig-r014-20230423   gcc  
microblaze           randconfig-r016-20230423   gcc  
microblaze           randconfig-r016-20230424   gcc  
microblaze           randconfig-r025-20230424   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                 randconfig-r002-20230423   clang
mips                 randconfig-r005-20230424   gcc  
mips                 randconfig-r014-20230424   clang
mips                 randconfig-r022-20230423   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230423   gcc  
nios2                randconfig-r003-20230423   gcc  
nios2                randconfig-r012-20230424   gcc  
nios2                randconfig-r023-20230424   gcc  
nios2                randconfig-r026-20230423   gcc  
nios2                randconfig-r032-20230424   gcc  
nios2                randconfig-r035-20230423   gcc  
openrisc     buildonly-randconfig-r001-20230423   gcc  
openrisc     buildonly-randconfig-r005-20230423   gcc  
openrisc             randconfig-r013-20230423   gcc  
openrisc             randconfig-r021-20230423   gcc  
openrisc             randconfig-r036-20230424   gcc  
parisc       buildonly-randconfig-r004-20230423   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r005-20230423   gcc  
parisc               randconfig-r014-20230424   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230424   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                mpc7448_hpc2_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r004-20230423   gcc  
powerpc              randconfig-r015-20230423   clang
powerpc              randconfig-r031-20230423   gcc  
powerpc              randconfig-r033-20230424   clang
powerpc                    socrates_defconfig   clang
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r036-20230424   clang
riscv                randconfig-r042-20230423   clang
riscv                randconfig-r042-20230424   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230424   clang
s390                 randconfig-r011-20230423   clang
s390                 randconfig-r015-20230424   gcc  
s390                 randconfig-r044-20230423   clang
s390                 randconfig-r044-20230424   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230424   gcc  
sparc                randconfig-r024-20230423   gcc  
sparc                randconfig-r036-20230423   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r006-20230423   gcc  
sparc64              randconfig-r012-20230423   gcc  
sparc64              randconfig-r026-20230424   gcc  
sparc64              randconfig-r034-20230424   gcc  
sparc64              randconfig-r035-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230424   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230424   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230424   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230424   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230424   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230424   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230424   gcc  
x86_64               randconfig-a012-20230424   gcc  
x86_64               randconfig-a013-20230424   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230424   gcc  
x86_64               randconfig-a015-20230424   gcc  
x86_64               randconfig-a016-20230424   gcc  
x86_64                        randconfig-k001   clang
x86_64               randconfig-r024-20230424   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230424   gcc  
xtensa               randconfig-r011-20230423   gcc  
xtensa               randconfig-r026-20230423   gcc  
xtensa               randconfig-r031-20230424   gcc  
xtensa               randconfig-r033-20230423   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
