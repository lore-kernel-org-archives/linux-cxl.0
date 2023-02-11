Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F3C61DA4
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Feb 2023 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBKQwY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Feb 2023 11:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKQwX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 11 Feb 2023 11:52:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB94171F
        for <linux-cxl@vger.kernel.org>; Sat, 11 Feb 2023 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676134342; x=1707670342;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/8ESLU6g3GsJ7tXfK6lw619mAkViRjdhFa+ARb1EVLw=;
  b=V1i3e/bvKFHQNlPs0ZemNMawBC4icB2UvVG8JTVmQaBJtH0aHIDiw6cG
   eFRnZDjKW/u9RCAH4Rru7B9iRaoMCV2yzRT3KpBYzOapsV+AD5+EXMKeF
   65anPMyvNOzug65u9l15FpkLMgaRKOk2X9Sw9RsTKxzafGe128BlbRwjk
   Av2NgzJcSBnC/PhtEYEG1n5ztTz8wrcN0M/uNpaSq+r52tWXi0dgYC1Jg
   odRMxZITdTxnY31JcWIlA3q0AW6my+u837zLwoiYZBu0iMZ9wSU2fjqTO
   bC5H4dZMpR8T5g4Hd6iyGvGhBsa0So/PIeLKXg/Fp2PkTkaz4o8ABUy8w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="393028541"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="393028541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 08:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="661715698"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="661715698"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2023 08:52:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQt6p-0006gz-1D;
        Sat, 11 Feb 2023 16:52:19 +0000
Date:   Sun, 12 Feb 2023 00:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS b8b9ffced017528bcdd262730ab10bc5084c3bb4
Message-ID: <63e7c79c.AnOvlF2tRUWTbSfq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: b8b9ffced017528bcdd262730ab10bc5084c3bb4  Merge branch 'for-6.3/cxl-ram-region' into cxl/next

Unverified Warning (likely false positive, please contact us if interested):

drivers/cxl/core/region.c:1634:5: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- ia64-randconfig-p002-20230210
    `-- drivers-cxl-core-region.c:warning:Redundant-initialization-for-rc-.-The-initialized-value-is-overwritten-before-it-is-read.-redundantInitialization

elapsed time: 808m

configs tested: 101
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230210
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                            hisi_defconfig
arm                          lpd270_defconfig
arm                       multi_v4t_defconfig
arm                  randconfig-r046-20230210
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                        bcm47xx_defconfig
mips                       bmips_be_defconfig
mips                      maltasmvp_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      pcm030_defconfig
powerpc                     tqm8555_defconfig
powerpc                        warp_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv             nommu_k210_sdcard_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                     magicpanelr2_defconfig
sh                          r7780mp_defconfig
sh                        sh7757lcr_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3
xtensa                         virt_defconfig
xtensa                    xip_kc705_defconfig

clang tested configs:
arm                       cns3420vb_defconfig
arm                         orion5x_defconfig
arm                        spear3xx_defconfig
hexagon                             defconfig
hexagon              randconfig-r041-20230210
hexagon              randconfig-r045-20230210
i386                             allyesconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                           ip27_defconfig
mips                           mtx1_defconfig
powerpc                 xes_mpc85xx_defconfig
riscv                randconfig-r042-20230210
s390                 randconfig-r044-20230210
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
