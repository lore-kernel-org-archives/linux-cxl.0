Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5286C4321E
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 19:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLDTcZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 14:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDTcY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 14:32:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70410B70
        for <linux-cxl@vger.kernel.org>; Sun,  4 Dec 2022 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670182344; x=1701718344;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7bjUtZVBB2UAxpH241KtcthFnS6paP8BaHtFXdDTo2M=;
  b=hwigsQ3fkl4e6OKmM2u6iwfWiZ7hYn4xVeqqHHA/hUdYuinHB/5OMPSr
   G0E7qeuSiDbNuGKcst028U2JmSACD7xieJzJClLjsm6RHhiBsBfRnHI/3
   r5VSYApHpphM+bKrTKmcKDu5mlpxsK4v3Enkmm/WbKM778K/bLFlYBpoq
   FWmLIE1aIyVOd5cy/Hvphqe7yRh2TuT2xrucdxVEiT4wqFUh0VSzhmvDg
   9+x58/8ydpoO3wJ79CjGkwiaUijq++BmVcbWlyuilnnX8VR5Hw7vJDhsG
   saARe5abRiCYZLhfbo1HpVawEd4++cE8RLim5c3TZc0ktrl1doyGKF5MY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="343202627"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="343202627"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 11:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="819966056"
X-IronPort-AV: E=Sophos;i="5.96,217,1665471600"; 
   d="scan'208";a="819966056"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2022 11:32:21 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1uiq-0000z0-29;
        Sun, 04 Dec 2022 19:32:20 +0000
Date:   Mon, 05 Dec 2022 03:31:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-xor] BUILD SUCCESS
 7a7e6edfca857f490e3a963198c67620de26b7f0
Message-ID: <638cf595.KvGtgHtIf4HTagBv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-xor
branch HEAD: 7a7e6edfca857f490e3a963198c67620de26b7f0  tools/testing/cxl: Add XOR Math support to cxl_test

elapsed time: 721m

configs tested: 87
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a002
arm                  randconfig-r046-20221204
arc                  randconfig-r043-20221204
x86_64                        randconfig-a004
i386                          randconfig-a001
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                              defconfig
ia64                             allmodconfig
arm                                 defconfig
i386                          randconfig-a003
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a005
i386                          randconfig-a012
x86_64                          rhel-8.3-func
i386                          randconfig-a016
i386                                defconfig
x86_64                        randconfig-a013
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a015
powerpc                           allnoconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arc                        vdk_hs38_defconfig
sh                          r7785rp_defconfig
m68k                           sun3_defconfig
parisc                              defconfig
sh                                  defconfig
arc                        nsimosci_defconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
riscv                             allnoconfig
powerpc                 mpc8540_ads_defconfig
mips                           xway_defconfig
riscv                    nommu_virt_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    adder875_defconfig
sh                          urquell_defconfig
riscv                    nommu_k210_defconfig
arm                        trizeps4_defconfig
arm                            lart_defconfig
loongarch                         allnoconfig
sh                     magicpanelr2_defconfig
riscv                          rv32_defconfig
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a001
hexagon              randconfig-r041-20221204
hexagon              randconfig-r045-20221204
riscv                randconfig-r042-20221204
s390                 randconfig-r044-20221204
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-k001
powerpc                     mpc512x_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          ath25_defconfig
powerpc                     pseries_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
