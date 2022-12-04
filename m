Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4848AC3A5A7
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 06:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLDGpJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 01:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiLDGpI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 01:45:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240617413
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 22:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670136307; x=1701672307;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=98tukjMlgptHycFmjDOTtA63tLsfnbxRGdlmasRr9Jo=;
  b=Jol7uZu6tiicMPQlOFSjigt280OzVjviLvF/LvhcrVj4yRizj7Ch+ACY
   MiEdda+a0LjeDeuPpYELwbIBR9HDhnnDCQG3qYVW1Il2m9lzk3nJNk9Hq
   Ip2cw932dlYpKgpU7q4wxWfHO02SCxKEGsBc8pquADQRRR1ogEroEFbwh
   y7Wb0qYmHJmd1vk3jYax21Vx1d6aOTK7kP8PS+87zsvfwW9r/2CFSpMBi
   Nzu/kO3quRRKjpxwR+3tAW2KwZmxvrq29KKfHZyBVeSeZ4gsqzpBxwvsO
   bgnoQNDYN39cw1bpzqyD05qSnAkx/8963lI/yDZMRNMB70gnIFYlPE0k4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="402448183"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="402448183"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 22:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="890593771"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="890593771"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2022 22:45:05 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1ikK-0000dN-2P;
        Sun, 04 Dec 2022 06:45:04 +0000
Date:   Sun, 04 Dec 2022 14:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-rch] BUILD SUCCESS
 3713787b9dc731eb41389ec64c4c38dade325c28
Message-ID: <638c41dc.J/f4x0WiwHvwIR0p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-rch
branch HEAD: 3713787b9dc731eb41389ec64c4c38dade325c28  cxl/acpi: Set ACPI's CXL _OSC to indicate RCD mode support

elapsed time: 789m

configs tested: 99
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
x86_64                        randconfig-a015
um                             i386_defconfig
x86_64                              defconfig
arm                  randconfig-r046-20221204
x86_64                        randconfig-a004
arc                  randconfig-r043-20221204
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                                defconfig
i386                          randconfig-a014
ia64                             allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
arm                                 defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
arm                       multi_v4t_defconfig
m68k                             allyesconfig
arc                                 defconfig
openrisc                            defconfig
arc                              allyesconfig
xtensa                              defconfig
i386                          randconfig-a001
alpha                            allyesconfig
s390                             allmodconfig
s390                             allyesconfig
alpha                               defconfig
s390                                defconfig
xtensa                    smp_lx200_defconfig
i386                          randconfig-a003
xtensa                    xip_kc705_defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
nios2                         3c120_defconfig
i386                             allyesconfig
sh                             sh03_defconfig
sh                           se7206_defconfig
mips                    maltaup_xpa_defconfig
arc                            hsdk_defconfig
sh                           se7705_defconfig
i386                          randconfig-c001
riscv                            allyesconfig
parisc                           alldefconfig
ia64                            zx1_defconfig
powerpc                         ps3_defconfig
powerpc                   currituck_defconfig
s390                          debug_defconfig
riscv                               defconfig
parisc                              defconfig
nios2                               defconfig
parisc64                            defconfig
nios2                            allyesconfig
parisc                           allyesconfig
loongarch                         allnoconfig
loongarch                           defconfig
loongarch                        allmodconfig
riscv                            allmodconfig
powerpc                          allyesconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221204
hexagon              randconfig-r045-20221204
x86_64                        randconfig-a005
x86_64                        randconfig-a001
s390                 randconfig-r044-20221204
x86_64                        randconfig-a003
riscv                randconfig-r042-20221204
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
arm                       versatile_defconfig
i386                          randconfig-a004
arm                         hackkit_defconfig
i386                          randconfig-a006
arm                          pcm027_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
