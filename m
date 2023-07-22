Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07CFEB64DA
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Jul 2023 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGVHVl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Jul 2023 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGVHVk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Jul 2023 03:21:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A29B
        for <linux-cxl@vger.kernel.org>; Sat, 22 Jul 2023 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690010499; x=1721546499;
  h=date:from:to:cc:subject:message-id;
  bh=b2rkb5h4SihAwembpWcLg62oXAzDBQr9sqgUMPy6yEo=;
  b=ltboFDgxkJ1V8sE/R6E0Ks7ksecqyf0RLFyarDhT/gw4X32j0lMehu9G
   ep7Sm3u2m5wWNi9sSJMgFsUbHHXO5tXiEp7dsQmRqC+2vw6Mnl94VDlN6
   cUiD2T30y09AvxR9OxcFGCM7dsdmoOG1i46LSg8vbbZr6mLxFPgL3c6xD
   RmNq53uz3bCp12Kdh2OPiwIp3ODrjFwXe6znMSKKsXdmABuwvxyruItso
   huG+PyTPSe9jFz8lgDdTGOFjrXVG0+4DNMOtULp/3hhdl80Q10Vx5QeqO
   MxI/xIZ6PDxTTaub2LmUFOPRj5YTJ3D0EnT3vMTgp26P8GtvXvAeR4Qiq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="367202410"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="367202410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 00:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="702284214"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="702284214"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2023 00:21:36 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN6vn-00087P-2K;
        Sat, 22 Jul 2023 07:21:35 +0000
Date:   Sat, 22 Jul 2023 15:20:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 70d49bbf962ce4579bebd82938ef7f265bc3e6ae
Message-ID: <202307221547.j9f8BzOM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 70d49bbf962ce4579bebd82938ef7f265bc3e6ae  tools/testing/cxl: Remove unused SZ_512G macro

elapsed time: 1431m

configs tested: 179
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230720   gcc  
alpha                randconfig-r022-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r004-20230720   gcc  
arc                  randconfig-r011-20230720   gcc  
arc                  randconfig-r015-20230721   gcc  
arc                  randconfig-r022-20230720   gcc  
arc                  randconfig-r036-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r002-20230720   clang
arm                  randconfig-r004-20230720   clang
arm                  randconfig-r005-20230720   clang
arm                  randconfig-r011-20230721   clang
arm                  randconfig-r014-20230720   gcc  
arm                  randconfig-r031-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm                  randconfig-r046-20230721   clang
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230720   gcc  
arm64                randconfig-r013-20230720   clang
arm64                randconfig-r021-20230720   clang
arm64                randconfig-r032-20230720   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230720   gcc  
csky                 randconfig-r035-20230720   gcc  
hexagon              randconfig-r023-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r041-20230721   clang
hexagon              randconfig-r045-20230720   clang
hexagon              randconfig-r045-20230721   clang
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r004-20230721   clang
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386         buildonly-randconfig-r006-20230721   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i011-20230721   gcc  
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i012-20230721   gcc  
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i013-20230721   gcc  
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i014-20230721   gcc  
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i015-20230721   gcc  
i386                 randconfig-i016-20230720   clang
i386                 randconfig-i016-20230721   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r012-20230720   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r003-20230720   gcc  
microblaze           randconfig-r006-20230720   gcc  
microblaze           randconfig-r013-20230721   gcc  
microblaze           randconfig-r023-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                        omega2p_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r004-20230720   clang
mips                 randconfig-r005-20230720   clang
mips                 randconfig-r016-20230720   gcc  
mips                 randconfig-r025-20230720   gcc  
mips                 randconfig-r026-20230720   gcc  
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230721   gcc  
openrisc             randconfig-r001-20230720   gcc  
openrisc             randconfig-r024-20230720   gcc  
openrisc             randconfig-r036-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r031-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                     powernv_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r021-20230720   gcc  
sh                   randconfig-r025-20230720   gcc  
sh                   randconfig-r026-20230720   gcc  
sh                          rsk7201_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230721   gcc  
sparc                randconfig-r034-20230720   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230720   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r024-20230720   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r001-20230721   clang
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230721   clang
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230721   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r033-20230720   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230720   gcc  
xtensa               randconfig-r011-20230721   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
