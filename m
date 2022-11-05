Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8793C433FE
	for <linux-cxl@archiver.kernel.org>; Sat,  5 Nov 2022 11:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKELLb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 5 Nov 2022 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKELL3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 5 Nov 2022 07:11:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E85101F5
        for <linux-cxl@vger.kernel.org>; Sat,  5 Nov 2022 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667646688; x=1699182688;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eBCKUYjScYZHD+Hy4J3s+A/Es0YZs5BNoeD139acrxA=;
  b=S615Nuj3aJZBpHTVEQrxOBA8M3EXyAdZg165lgloniXbRqYfeSp6808v
   h5YNzIBaul3O+rqtGPe5SvviTsmdyoVrzOxhs+jhEeO0NUknyqAc8nOVi
   TRmQQ3BB9onNdD5jyVX3Em4ftk3m6YIFT1+pgRKvPj6INsYnI5DYUYEqv
   8BYPd5H9efmonrJo6mHj7NXbX5bs4Fql8VBtZomxOoG1smrC33M0SfAdy
   lupHDns7pa7/xfoSmQuvMpxOW9vXZP8N4War5nlMuNMli5edwXWpqciEs
   9mIVyVDsIdQVm3YmJd/JrncLdiWzE8G06g6IHPQcj36liy1CilOf6NNev
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289881736"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="289881736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 04:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="964628867"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="964628867"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2022 04:11:26 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orH5B-000HvY-2y;
        Sat, 05 Nov 2022 11:11:25 +0000
Date:   Sat, 05 Nov 2022 19:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 8f401ec1c8975eabfe4c089de91cbe058deabf71
Message-ID: <636644c7.nVK9YMCbHSauUvZ+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 8f401ec1c8975eabfe4c089de91cbe058deabf71  cxl/region: Recycle region ids

elapsed time: 724m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
i386                                defconfig
alpha                               defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
s390                                defconfig
arc                  randconfig-r043-20221104
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                              defconfig
nios2                         10m50_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                               rhel-8.3
m68k                           sun3_defconfig
x86_64                        randconfig-a011
riscv                randconfig-r042-20221104
x86_64                        randconfig-a006
s390                             allyesconfig
arc                              allyesconfig
csky                                defconfig
i386                          randconfig-a016
m68k                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a015
arm                                 defconfig
powerpc                          allmodconfig
s390                 randconfig-r044-20221104
i386                          randconfig-a012
mips                             allyesconfig
m68k                        m5407c3_defconfig
arm                              allyesconfig
i386                          randconfig-a014
sh                               allmodconfig
i386                          randconfig-c001
sh                          r7780mp_defconfig
arm64                            allyesconfig
loongarch                        alldefconfig
xtensa                  cadence_csp_defconfig
arm                         cm_x300_defconfig
m68k                          multi_defconfig
powerpc                 linkstation_defconfig
i386                             allyesconfig
ia64                             allmodconfig
powerpc                      ppc40x_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                           se7705_defconfig
powerpc                      pasemi_defconfig
parisc64                         alldefconfig
mips                           jazz_defconfig
arm                         at91_dt_defconfig
arm                       multi_v4t_defconfig
arm                         s3c6400_defconfig
arc                      axs103_smp_defconfig
m68k                       bvme6000_defconfig
sh                             espt_defconfig
powerpc                     taishan_defconfig
sh                             shx3_defconfig
arm                         axm55xx_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                      ppc6xx_defconfig
mips                     loongson1b_defconfig
arm                           viper_defconfig
nios2                               defconfig
parisc                              defconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                        debian-10.3-kunit
x86_64                        randconfig-c001
i386                         debian-10.3-func
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
powerpc                   currituck_defconfig
i386                          debian-10.3-kvm
loongarch                         allnoconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
arm                            qcom_defconfig
parisc64                            defconfig
arm                  randconfig-c002-20221104
nios2                            allyesconfig
parisc                           allyesconfig
loongarch                           defconfig
sparc                               defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20221104
x86_64                        randconfig-a001
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221104
powerpc                   bluestone_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
powerpc                     powernv_defconfig
arm                           omap1_defconfig
mips                        bcm63xx_defconfig
mips                  cavium_octeon_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     akebono_defconfig
powerpc                     mpc512x_defconfig
mips                        omega2p_defconfig
powerpc                     ksi8560_defconfig
arm                         s3c2410_defconfig
mips                       lemote2f_defconfig
mips                        qi_lb60_defconfig
arm                      tct_hammer_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
