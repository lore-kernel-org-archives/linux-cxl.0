Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8042DC636D3
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 12:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAaMFL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAaMFJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 07:05:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0DD4DBFD
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 04:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675166695; x=1706702695;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U6VG7azw7ngfFNAWx8BFUIjKWp1LdLe4X0nCebgmamI=;
  b=Y0orSI8AVO7V6YuLQhUKDqwxJXiFG8jEqqO2pcD+2QI+1/m/e56jTnb/
   xFACKVjHGSpjNqNEl/TpTIXxFu6BAC3HegErGA55Xc9En6ieAIPBnos4f
   2C+1RLHj1/pU7tygOHy2xPzpffAL5hxIvtkLuQEHWzPfUpgr+L+G8/9wA
   yTLk2taDIi4WiC2hU7hH/G3sBvvQudEvsYmOHcd6dOP3jUneN2EajpCF+
   n38mX+rumoriiBtyrTlIKPA2gyUAlC7f3pZbut8vWstJ7VlvkBiFrHfpF
   NYUaGqDXc7CsKaTLmyb+EAtpayak1aOZl3HMiYaGPsXplydxfFJevi+vi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308166434"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308166434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909883368"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="909883368"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 04:04:52 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMpNb-0004Pk-28;
        Tue, 31 Jan 2023 12:04:51 +0000
Date:   Tue, 31 Jan 2023 20:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD REGRESSION
 f71922e583ef6b6e17575c87e496b17f91193d37
Message-ID: <63d903cc.NwPbWjuK3mJ/AdEv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: f71922e583ef6b6e17575c87e496b17f91193d37  cxl/region: Add region autodiscovery

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301281643.cInr5zLC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281707.ZLMJGwlz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301311303.f3BvWCnS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "cxl_add_to_region" [drivers/cxl/cxl_port.ko] undefined!
drivers/cxl/port.c:45: undefined reference to `cxl_add_to_region'
ld.lld: error: undefined symbol: cxl_add_to_region
port.c:(.text+0x144): undefined reference to `cxl_add_to_region'
port.c:(.text+0x3e): undefined reference to `cxl_add_to_region'
port.c:(.text+0x68): undefined reference to `cxl_add_to_region'
port.c:(.text+0xac): undefined reference to `cxl_add_to_region'
port.c:(.text.discover_region+0x84): undefined reference to `cxl_add_to_region'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allyesconfig
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- arm-randconfig-c002-20230130
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- i386-allyesconfig
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- i386-randconfig-m021
|   `-- drivers-cxl-port.c:undefined-reference-to-cxl_add_to_region
|-- i386-randconfig-r004-20230130
|   `-- drivers-cxl-port.c:undefined-reference-to-cxl_add_to_region
|-- mips-allyesconfig
|   `-- port.c:(.text.discover_region):undefined-reference-to-cxl_add_to_region
|-- powerpc-allmodconfig
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
`-- riscv-randconfig-r003-20230129
    `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
clang_recent_errors
|-- i386-randconfig-a004
|   `-- ld.lld:error:undefined-symbol:cxl_add_to_region
|-- i386-randconfig-a013
|   `-- ld.lld:error:undefined-symbol:cxl_add_to_region
`-- i386-randconfig-a015
    `-- ld.lld:error:undefined-symbol:cxl_add_to_region

elapsed time: 727m

configs tested: 110
configs skipped: 3

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                               rhel-8.3
alpha                               defconfig
arm                                 defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
x86_64               randconfig-a001-20230130
i386                             allyesconfig
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
s390                             allmodconfig
x86_64               randconfig-a006-20230130
m68k                             allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a005
arm                              allyesconfig
s390                                defconfig
x86_64               randconfig-a005-20230130
powerpc                          allmodconfig
arc                              allyesconfig
mips                             allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20230129
i386                          randconfig-a014
i386                          randconfig-a012
s390                             allyesconfig
csky                                defconfig
i386                          randconfig-a016
m68k                             allyesconfig
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-kvm
i386                          randconfig-c001
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
sparc                               defconfig
powerpc                       maple_defconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                 randconfig-c001-20230130
powerpc                     mpc83xx_defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
powerpc                     sequoia_defconfig
i386                              debian-10.3
x86_64                                  kexec
mips                           ci20_defconfig
openrisc                 simple_smp_defconfig
openrisc                            defconfig
sh                          landisk_defconfig
s390                       zfcpdump_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                 mpc834x_itx_defconfig
arc                     nsimosci_hs_defconfig
x86_64               randconfig-c001-20230130
arm                           sama5_defconfig
arm                  randconfig-c002-20230129
arm                  randconfig-c002-20230130
loongarch                         allnoconfig
parisc                              defconfig
nios2                               defconfig
parisc64                            defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
x86_64               randconfig-a014-20230130
x86_64               randconfig-a013-20230130
i386                          randconfig-a006
i386                          randconfig-a013
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
i386                          randconfig-a011
hexagon              randconfig-r041-20230129
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
riscv                randconfig-r042-20230129
i386                          randconfig-a015
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
powerpc                   bluestone_defconfig
arm                         shannon_defconfig
x86_64                        randconfig-k001
powerpc                     mpc512x_defconfig
powerpc                      pmac32_defconfig
arm                         s3c2410_defconfig
powerpc                    mvme5100_defconfig
mips                           rs90_defconfig
powerpc                          allmodconfig
arm                          pcm027_defconfig
powerpc                     powernv_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
