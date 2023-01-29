Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A1C05027
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Jan 2023 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjA2UIc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 29 Jan 2023 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjA2UIc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 29 Jan 2023 15:08:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29B199DC
        for <linux-cxl@vger.kernel.org>; Sun, 29 Jan 2023 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675022911; x=1706558911;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=67gdAYdRBIN5ZPeU0GIIBMaCr94oFr80CAR9QMZXL4g=;
  b=b+9iK7W0zrrulhSX7DiL2trYaKnJ3YPfEkJVd/7pU7XvtpnX1gfpGTK5
   GKES21YibPbteO2lo5BCzFt5fPPrhHJnOWPHy2E5uUVbJxsCAmYmbzNEH
   j4hK3OENxG8oTWeUhw40jpRjCEXB/VvmlkPSMQJJubMTk1zVlV/ttt5vq
   OIMDV5JRQq13NIg207qgn9VQCnqlHJ/DTb+KVGJhtET2GXjrx0oFeq+wi
   eos0v0UEEMNvyvYZD05JjomeprlfwbMZOODdlVZlShOltIIW/PKuz9L+0
   ackwEZRA0rDXKRwobnJqdRdQ5kGi4LwFTyEx/A6J+sC6/Q5vWJTG/hZBn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="311051738"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="311051738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 12:08:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="696185111"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="696185111"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2023 12:08:28 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMDyV-000352-0t;
        Sun, 29 Jan 2023 20:08:27 +0000
Date:   Mon, 30 Jan 2023 04:07:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 ace4b76d4ab70335cffb5a1c8450d3b34c16771a
Message-ID: <63d6d217.cczNSAYsG/GKnK3G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: ace4b76d4ab70335cffb5a1c8450d3b34c16771a  Merge branch 'for-6.3/cxl-events' into next

Unverified Warning (likely false positive, please contact us if interested):

drivers/cxl/pci.c:511:8-33: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- microblaze-randconfig-c043-20230129
|   `-- drivers-cxl-pci.c:WARNING:Threaded-IRQ-with-no-primary-handler-requested-without-IRQF_ONESHOT-(unless-it-is-nested-IRQ)
`-- x86_64-randconfig-c022
    `-- drivers-cxl-pci.c:WARNING:Threaded-IRQ-with-no-primary-handler-requested-without-IRQF_ONESHOT-(unless-it-is-nested-IRQ)

elapsed time: 911m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
x86_64                            allnoconfig
um                             i386_defconfig
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
i386                          randconfig-a014
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
arc                              allyesconfig
arc                                 defconfig
ia64                             allmodconfig
s390                             allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
x86_64                               rhel-8.3
alpha                               defconfig
s390                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
i386                          randconfig-a012
s390                                defconfig
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                           rhel-8.3-bpf
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                        randconfig-a006
i386                          randconfig-c001
sh                           sh2007_defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a015
sh                              ul2_defconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                       m5208evb_defconfig
i386                             allyesconfig
xtensa                  audio_kc705_defconfig
xtensa                       common_defconfig
powerpc                      pcm030_defconfig
mips                           jazz_defconfig
m68k                           virt_defconfig
loongarch                        allmodconfig
arm                        shmobile_defconfig
i386                          debian-10.3-kvm
arm                        realview_defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           tegra_defconfig
powerpc                     pq2fads_defconfig
arm                  randconfig-c002-20230129
x86_64                        randconfig-c001
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                               defconfig
powerpc                          allmodconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r045-20230129
i386                          randconfig-a002
i386                          randconfig-a011
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
hexagon              randconfig-r041-20230129
x86_64                        randconfig-a005
i386                          randconfig-a006
riscv                randconfig-r042-20230129
x86_64                        randconfig-a001
i386                          randconfig-a015
i386                          randconfig-a004
s390                 randconfig-r044-20230129
x86_64                        randconfig-a016
x86_64                        randconfig-a003
arm                       versatile_defconfig
arm                  colibri_pxa270_defconfig
x86_64                        randconfig-a012
arm64                            allyesconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     mpc512x_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
