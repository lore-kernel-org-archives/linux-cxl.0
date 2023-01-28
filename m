Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A395C38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 16:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjA1QIu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjA1QIt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 11:08:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E62BEF9
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674922123; x=1706458123;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8zU8lgeqjyBetwfG+fiy0XPuh9j3E7mtMirLDGqT/6o=;
  b=f3FDlNXqHQ+QyZIE6G3t4+OMLoorghIQ6v3rx9kU9kxDqo06hO9DZHh5
   ecZHqBPc3j0HIFkWEWrZ8CVv1zcexBV9u1uJjmyBYFxT3ktfKl34sqEwe
   S3BZQ9IKrCug48ywPH8d20jpL1YRrAiUjBO2NOmn2DDbY3x8P9fL0S5gY
   Bbk5kvweI5DMpYOeDeoXTVX6QIbtogmbstOp8EUKVwsmXffg2lKzeFDuE
   JioqelTqZJWMg5b/VYJ+FzsS8swzbZQp8Qi3bHDv4sXI3D+ofznnKDHw5
   fAOW47YUbHWDGeqmqtW7y6z1l2X+4c4OgiAE2TNL4VLv6Ecz1vsCLeqGs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="306953358"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="306953358"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 08:08:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="663618804"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="663618804"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2023 08:08:40 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLnkt-0000si-2W;
        Sat, 28 Jan 2023 16:08:39 +0000
Date:   Sun, 29 Jan 2023 00:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 172738bbccdb4ef76bdd72fc72a315c741c39161
Message-ID: <63d54875.zmDlcBFaamD+qQPF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: 172738bbccdb4ef76bdd72fc72a315c741c39161  cxl/port: Link the 'parent_dport' in portX/ and endpointX/ sysfs

elapsed time: 842m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
arm                                 defconfig
x86_64                              defconfig
i386                                defconfig
sh                               allmodconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a004-20230123
arm64                            allyesconfig
i386                 randconfig-a005-20230123
x86_64                        randconfig-a004
arm                              allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
i386                 randconfig-a006-20230123
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20230123
i386                             allyesconfig
m68k                             allyesconfig
arm                  randconfig-r046-20230123
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64                        randconfig-a006
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
sh                        sh7763rdp_defconfig
sh                          rsk7264_defconfig
arc                      axs103_smp_defconfig
m68k                        stmark2_defconfig
mips                      fuloong2e_defconfig
m68k                       m5475evb_defconfig
arm                          exynos_defconfig
powerpc                    sam440ep_defconfig
mips                     loongson1b_defconfig
xtensa                  nommu_kc705_defconfig
sh                          rsk7269_defconfig
powerpc              randconfig-c003-20230123
i386                 randconfig-c001-20230123
x86_64               randconfig-a002-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a006-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a004-20230123
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                         amcore_defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
m68k                          amiga_defconfig
mips                          rb532_defconfig
arc                        nsim_700_defconfig
sh                           se7724_defconfig
sh                            shmin_defconfig
i386                          randconfig-c001
xtensa                    smp_lx200_defconfig
s390                          debug_defconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
hexagon              randconfig-r041-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a011-20230123
x86_64                        randconfig-a001
x86_64               randconfig-a015-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a016-20230123
s390                 randconfig-r044-20230123
hexagon              randconfig-r045-20230123
riscv                randconfig-r042-20230123
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      walnut_defconfig
arm                        mvebu_v5_defconfig
arm                           sama7_defconfig
hexagon              randconfig-r041-20230124
hexagon              randconfig-r045-20230124
arm                  randconfig-r046-20230124
x86_64               randconfig-k001-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
