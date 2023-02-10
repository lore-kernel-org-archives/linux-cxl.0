Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF86C636D4
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Feb 2023 22:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjBJWoL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjBJWoJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 17:44:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE37E3E5
        for <linux-cxl@vger.kernel.org>; Fri, 10 Feb 2023 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676069031; x=1707605031;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cMeedvGQz1ode0qcGNdajTBaEBthyyCJktukdzgPg/U=;
  b=Y2bunfqOJqFQXS3FFAarjDxJl5d9FoxcYMuZ3NeAg+manGTguSkAFvOH
   +v2eXSdnom30lmR82TJXLEdPa5OWuIF+Igo6ggHrajVXyWDyIUzhfPas3
   MwQUwb1K6AGMu+NGXKJ8tzZlrv5Mj0T38y5NdyEb1n7tOVlI2CB5JwkDE
   0YxCdHb9IopNHSkuznkPC+CigPoH1u2FxA6vQAWWcjWN2QDCtUUgwhRbs
   tdgs+5mMzkwjig6gPQIudp8popAqbeuphagmYOG4iRNEyCUkpQqx7H8Yy
   aeK49jrh/MGvOGxPOMAEReO/12EG4t/1Di5Xqdb4A1XjGshyCDPYzWi/G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329176674"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329176674"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997094201"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997094201"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 14:43:49 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQc7Q-00065p-2P;
        Fri, 10 Feb 2023 22:43:48 +0000
Date:   Sat, 11 Feb 2023 06:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD REGRESSION
 58c651c6c4bbf46725502ffbccde2c24b94dc5c0
Message-ID: <63e6c890.ZatB8yr8gndgan6+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: 58c651c6c4bbf46725502ffbccde2c24b94dc5c0  cxl/dax: Create dax devices for CXL RAM regions

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301281217.NvoiwL4w-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302050349.g4NppVCy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302110030.nDFn2KVK-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!
drivers/cxl/core/region.c:2619:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-randconfig-p002-20230210
|   `-- drivers-cxl-core-region.c:warning:Local-variable-rc-shadows-outer-variable-shadowVariable
`-- loongarch-allmodconfig
    `-- ERROR:walk_hmem_resources-drivers-dax-hmem-dax_hmem.ko-undefined
clang_recent_errors
|-- s390-randconfig-r044-20230210
|   `-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-a005
|   `-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-randconfig-a012
|   `-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
`-- x86_64-randconfig-a014
    `-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 785m

configs tested: 101
configs skipped: 3

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                      axs103_smp_defconfig
arc                                 defconfig
arc                        nsimosci_defconfig
arc                  randconfig-r043-20230210
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                             pxa_defconfig
arm                  randconfig-r046-20230210
arm                          simpad_defconfig
arm                        spear6xx_defconfig
arm                           sunxi_defconfig
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
m68k                             allyesconfig
m68k                                defconfig
m68k                        m5272c3_defconfig
m68k                       m5275evb_defconfig
m68k                        mvme147_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                       bmips_be_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                       maple_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                           se7343_defconfig
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
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
hexagon              randconfig-r041-20230210
hexagon              randconfig-r045-20230210
i386                              allnoconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                   lite5200b_defconfig
powerpc                     mpc5200_defconfig
powerpc                    mvme5100_defconfig
powerpc                     skiroot_defconfig
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
