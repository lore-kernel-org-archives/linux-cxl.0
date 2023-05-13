Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14379C7EE26
	for <linux-cxl@archiver.kernel.org>; Sat, 13 May 2023 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjEMUpV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 13 May 2023 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjEMUpT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 13 May 2023 16:45:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498930C0
        for <linux-cxl@vger.kernel.org>; Sat, 13 May 2023 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684010718; x=1715546718;
  h=date:from:to:cc:subject:message-id;
  bh=VwdELyduWWs5DMjEe9jsLbnd1o3OcrpW+09CnursZlw=;
  b=jx2EjYj9JXstR1UXo0u8GCYf3YbG0LOikLlbDPJBLcXGgNWikRRMj6ZB
   3+eaZgEjXH2EizRPieM2BqYiUxFisJB3u8Ftba1ZzUwNwLAdi+No+Qn9A
   C2BGjfok9OpIRUixcOcINzyHyEGI9txat8d0ukkFJGnz+OFl0MtD+mzlo
   P+/wKKuqkzD2uFf2ZC6VoJdEXXfDTbpwSRJmVdU9gxZb6pq3UftTYlvDI
   e8IA6wCeYxxQGsbX8KVgpC575gboFS81QkepVCi4bZR2aIp+C3a1oDH6v
   cBhhByIrzzLOMVq+xm5SzWSmIZy6h8PCl6JK3VPP1y2zRmA7cWFg1jsRS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="348480801"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="348480801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 13:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="844774067"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="844774067"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2023 13:45:16 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxw7A-0005fq-08;
        Sat, 13 May 2023 20:45:16 +0000
Date:   Sun, 14 May 2023 04:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 764d102ef94e880ca834a7fe3968a00a05b1fb12
Message-ID: <20230513204419.pqWDI%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 764d102ef94e880ca834a7fe3968a00a05b1fb12  cxl: Add missing return to cdat read error path

elapsed time: 791m

configs tested: 201
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230513   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230513   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230509   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230513   gcc  
arc                  randconfig-r023-20230513   gcc  
arc                  randconfig-r033-20230511   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arc                  randconfig-r043-20230513   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r006-20230511   gcc  
arm                  randconfig-r015-20230513   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                  randconfig-r046-20230513   clang
arm                         s3c6400_defconfig   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r005-20230511   clang
arm64                randconfig-r026-20230513   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230511   gcc  
csky                 randconfig-r016-20230513   gcc  
csky                 randconfig-r021-20230511   gcc  
csky                 randconfig-r025-20230513   gcc  
csky                 randconfig-r026-20230511   gcc  
csky                 randconfig-r035-20230511   gcc  
hexagon              randconfig-r002-20230509   clang
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r033-20230513   clang
hexagon              randconfig-r034-20230509   clang
hexagon              randconfig-r035-20230513   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r041-20230513   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
hexagon              randconfig-r045-20230513   clang
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
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                         bigsur_defconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230513   gcc  
ia64                 randconfig-r013-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230513   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r001-20230509   gcc  
m68k         buildonly-randconfig-r002-20230511   gcc  
m68k         buildonly-randconfig-r003-20230513   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230509   gcc  
m68k                 randconfig-r006-20230509   gcc  
m68k                 randconfig-r016-20230511   gcc  
m68k                 randconfig-r033-20230509   gcc  
m68k                 randconfig-r036-20230511   gcc  
microblaze           randconfig-r032-20230513   gcc  
microblaze           randconfig-r034-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                          ath25_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r003-20230511   gcc  
mips                          rm200_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2        buildonly-randconfig-r003-20230511   gcc  
nios2        buildonly-randconfig-r004-20230513   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230511   gcc  
openrisc             randconfig-r011-20230511   gcc  
openrisc             randconfig-r022-20230513   gcc  
openrisc             randconfig-r024-20230513   gcc  
openrisc             randconfig-r031-20230513   gcc  
openrisc             randconfig-r035-20230509   gcc  
parisc       buildonly-randconfig-r001-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230513   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc               randconfig-r024-20230511   gcc  
parisc               randconfig-r032-20230511   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc      buildonly-randconfig-r005-20230513   gcc  
powerpc                        icon_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc8560_ads_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r001-20230509   gcc  
powerpc              randconfig-r036-20230509   gcc  
powerpc                      walnut_defconfig   clang
powerpc                        warp_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230509   clang
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230509   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                randconfig-r042-20230513   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230513   gcc  
s390         buildonly-randconfig-r004-20230509   clang
s390                                defconfig   gcc  
s390                 randconfig-r022-20230511   gcc  
s390                 randconfig-r031-20230511   clang
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
s390                 randconfig-r044-20230513   gcc  
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r001-20230511   gcc  
sh                   randconfig-r006-20230513   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230509   gcc  
sparc        buildonly-randconfig-r005-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230513   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc                randconfig-r021-20230513   gcc  
sparc64      buildonly-randconfig-r006-20230511   gcc  
sparc64              randconfig-r034-20230513   gcc  
um                               alldefconfig   gcc  
um                                  defconfig   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230511   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r005-20230513   gcc  
xtensa               randconfig-r015-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
