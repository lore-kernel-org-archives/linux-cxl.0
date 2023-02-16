Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7066C6379F
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Feb 2023 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBPSF6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBPSF5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Feb 2023 13:05:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686524D626
        for <linux-cxl@vger.kernel.org>; Thu, 16 Feb 2023 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676570756; x=1708106756;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gTA11u4h29Q7hK3QylBLGAOfaAYJxFNhv8VwEogsvlQ=;
  b=mhh0NUI8ywz19454RsvH5IKB/PjysSxdxUH6VUng7xTRKWOttMyfC6Ko
   dEuDhUECSD21OISuLWvevMITgSgpKpNiAagzcnuDzIwEFBxyRxqtjzXnS
   dmtjoge+NkwV9KYmrq7YcKqrsWjPKukpnPbi03xbWt0zrTMe1m1ZkttWw
   po6bf0jNo6NOd86u/iGKpNRwofrVM4vbsOpC57rl12+VR7vIDg0zksmc3
   92ACftvQKva86xzK+xlqomMU0fYq46ryL0Aq7q8OFZ2w4uRVzb/yLxx9H
   kvEsjyfvqg+7+PLpDGMvFQUNNxV3ZCa+VfNe+EekJTwB/RYsOrO4bXDkG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="315499240"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="315499240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="794135240"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="794135240"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2023 10:05:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSidR-000APp-0W;
        Thu, 16 Feb 2023 18:05:33 +0000
Date:   Fri, 17 Feb 2023 02:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS a5fcd228ca1db9810ba1ed461c90b6ee933b9daf
Message-ID: <63ee7035.pD7MEAb1dG6tAXl4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: a5fcd228ca1db9810ba1ed461c90b6ee933b9daf  Merge branch 'for-6.3/cxl-rr-emu' into cxl/next

elapsed time: 817m

configs tested: 115
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arm                              allmodconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                                 defconfig
arm                         lubbock_defconfig
arm                  randconfig-c002-20230212
arm                  randconfig-r046-20230212
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                         debian-10.3-func
i386                   debian-10.3-kselftests
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                       m5475evb_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                 randconfig-c004-20230212
nios2                               defconfig
openrisc                            defconfig
openrisc                 simple_smp_defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                     asp8347_defconfig
powerpc                      chrp32_defconfig
powerpc                      tqm8xx_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sh                           se7206_defconfig
sh                   sh7724_generic_defconfig
sh                          urquell_defconfig
sparc                            allyesconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                        randconfig-c001
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
xtensa                              defconfig

clang tested configs:
arm                         palmz72_defconfig
arm                  randconfig-r046-20230213
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
mips                        bcm63xx_defconfig
mips                  cavium_octeon_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc832x_mds_defconfig
riscv                randconfig-r042-20230212
s390                 randconfig-r044-20230212
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
