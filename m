Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F3C38142
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 06:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBAGqP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 01:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBAGqP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 01:46:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7E135240
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 22:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675233974; x=1706769974;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rRrmyW4d31XnFLSluMJpcOrLSd/ZDr33tyr6yrceMZM=;
  b=QBQkNmR+bgR0eH4uw296M/jDskjjPFrAXzmpQi5M374LWU0SrWYoVioT
   GkpeJm5ZiFPbBSLyQwWYHwSflS9TARBFE4Wnra7dFr6qNPBOevl29E2eB
   SBy0zEEJ6cfyh74MeH/1B+a9vKdyjf5qOjnOksH3JStG5T8qypGsy2raw
   NriCzFvjNBMI0CVsMuS+XyWrkWJ4FZCya3EIGZ0Ln+9h7YLJQvYC0tM8b
   unBTQDfiNILs4xPkMliqoJAEARuLqzy4A0hfSGO7VUvGGcM5EKVKwOUp8
   PgwfuTyP43uoM9ArDjOdNNfjvU4nK/4rFUWOXJbfwg+tG7rrFQC7Sqs6Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="355395163"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="355395163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="733448408"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="733448408"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 22:46:11 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN6sk-0005Az-0r;
        Wed, 01 Feb 2023 06:46:10 +0000
Date:   Wed, 01 Feb 2023 14:45:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD REGRESSION
 c30a50b37b7808284c3796e0866e939017bb05b2
Message-ID: <63da0a8f.iBfkEgr+J1kQGuHd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: c30a50b37b7808284c3796e0866e939017bb05b2  tools/testing/cxl: Define a fixed volatile configuration to parse

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301281643.cInr5zLC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281707.ZLMJGwlz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302010823.qvzx7Yf8-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "cxl_add_to_region" [drivers/cxl/cxl_port.ko] undefined!
arceb-elf-ld: port.c:(.text+0x9c): undefined reference to `cxl_add_to_region'
drivers/cxl/port.c:34: undefined reference to `cxl_add_to_region'
drivers/cxl/port.c:45: undefined reference to `cxl_add_to_region'
port.c:(.text+0x108): undefined reference to `cxl_add_to_region'
port.c:(.text+0x144): undefined reference to `cxl_add_to_region'
port.c:(.text+0x158): undefined reference to `cxl_add_to_region'
port.c:(.text+0x3e): undefined reference to `cxl_add_to_region'
port.c:(.text+0x68): undefined reference to `cxl_add_to_region'
port.c:(.text+0x9c): undefined reference to `cxl_add_to_region'
port.c:(.text.discover_region+0x84): undefined reference to `cxl_add_to_region'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-buildonly-randconfig-r004-20230130
|   |-- arceb-elf-ld:port.c:(.text):undefined-reference-to-cxl_add_to_region
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- arm-allmodconfig
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
|-- arm-allyesconfig
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- arm-randconfig-c002-20230130
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- i386-allyesconfig
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- i386-randconfig-m021
|   `-- drivers-cxl-port.c:undefined-reference-to-cxl_add_to_region
|-- loongarch-randconfig-c003-20230129
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- mips-allmodconfig
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
|-- mips-allyesconfig
|   `-- port.c:(.text.discover_region):undefined-reference-to-cxl_add_to_region
|-- parisc-randconfig-r004-20230201
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- powerpc-allmodconfig
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
`-- xtensa-buildonly-randconfig-r005-20230129
    `-- drivers-cxl-port.c:undefined-reference-to-cxl_add_to_region

elapsed time: 724m

configs tested: 111
configs skipped: 4

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a002-20230130
arm                                 defconfig
arc                                 defconfig
i386                 randconfig-a001-20230130
s390                             allmodconfig
i386                 randconfig-a004-20230130
x86_64                            allnoconfig
alpha                               defconfig
i386                 randconfig-a003-20230130
s390                                defconfig
i386                 randconfig-a006-20230130
x86_64                           rhel-8.3-syz
s390                             allyesconfig
powerpc                           allnoconfig
ia64                             allmodconfig
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
i386                                defconfig
arc                  randconfig-r043-20230129
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a001-20230130
m68k                             allyesconfig
i386                 randconfig-a005-20230130
x86_64               randconfig-a003-20230130
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64               randconfig-a004-20230130
x86_64                          rhel-8.3-func
x86_64                              defconfig
alpha                            allyesconfig
arm                  randconfig-r046-20230129
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
arm                  randconfig-r046-20230130
x86_64                               rhel-8.3
arc                  randconfig-r043-20230130
nios2                               defconfig
i386                             allyesconfig
powerpc                      mgcoge_defconfig
arm                         cm_x300_defconfig
sh                               allmodconfig
powerpc                         ps3_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                          amiga_defconfig
parisc                generic-32bit_defconfig
loongarch                           defconfig
x86_64                           allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc837x_mds_defconfig
sparc                       sparc32_defconfig
sparc64                             defconfig
arm                        shmobile_defconfig
arc                        nsim_700_defconfig
powerpc                      cm5200_defconfig
xtensa                  audio_kc705_defconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
parisc                              defconfig
parisc64                            defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                                defconfig
i386                 randconfig-c001-20230130
arm64                               defconfig
m68k                                defconfig
sparc                               defconfig
nios2                            allyesconfig
ia64                                defconfig
parisc                           allyesconfig
x86_64               randconfig-c001-20230130
arm                  randconfig-c002-20230130
mips                             allmodconfig
arm                              allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
i386                 randconfig-a013-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a012-20230130
s390                 randconfig-r044-20230129
x86_64               randconfig-a014-20230130
s390                 randconfig-r044-20230130
x86_64               randconfig-a012-20230130
i386                 randconfig-a014-20230130
x86_64               randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
mips                        bcm63xx_defconfig
x86_64                        randconfig-k001
arm                        magician_defconfig
i386                             allyesconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
