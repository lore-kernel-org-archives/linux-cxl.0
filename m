Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B824C61DA4
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Feb 2023 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBDP76 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Feb 2023 10:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDP75 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 4 Feb 2023 10:59:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2833451
        for <linux-cxl@vger.kernel.org>; Sat,  4 Feb 2023 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675526396; x=1707062396;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fgYX3cYd0TzLQDRbjAWCDs22kbvbmXyASl/83mcPrcU=;
  b=LeEu2gSHzOxZmE0vgxxw+Feu93RwZrWXsTyLuHDGZiok3c2ZcVCAv61m
   xi5oxW9Vifmpf18Wrk4m5UoB5KdaeG9amiUorOA+4tjT6qutBtgnDU+Md
   ikIOIFRaj6/YG75p7G6TRLKbrk3zyOsbqjNqHrkDqKCvBH4Ld3Vp7KT27
   0ISSu6HHFQeXZl+g4nGoXmnU7lDDhl3LznDn/OWzUqpEGEi5Jdqrj+nhb
   w3XhPob9duDf+J/aC0ayufyyQQv9aFi0wm0LCZociMTlxBzlnexbomlK1
   X/dScDbA+HO2X7DGmZBK4XpgS/YrrVBqyO2jLUwJWGwC8rploVeWSWxkG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="415169752"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="415169752"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 07:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="666051772"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="666051772"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2023 07:59:53 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOKxA-0001PK-0s;
        Sat, 04 Feb 2023 15:59:48 +0000
Date:   Sat, 04 Feb 2023 23:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS bed259ea85f54b4ebc1f8de61b5ffafd23acd126
Message-ID: <63de80da.WhbgLeflO6jMC9Vz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: bed259ea85f54b4ebc1f8de61b5ffafd23acd126  Merge branch 'for-6.3/cxl-events' into cxl/next

elapsed time: 720m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20230204
arc                                 defconfig
s390                             allmodconfig
s390                 randconfig-r044-20230204
sh                               allmodconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                            allnoconfig
x86_64                        randconfig-a004
riscv                randconfig-r042-20230204
ia64                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-a002
s390                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
x86_64                               rhel-8.3
arm                                 defconfig
i386                          randconfig-a003
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                           allyesconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
i386                          randconfig-a016
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allyesconfig
powerpc                      mgcoge_defconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                 mpc85xx_cds_defconfig
alpha                            alldefconfig
mips                 decstation_r4k_defconfig
sh                   sh7724_generic_defconfig
powerpc                         ps3_defconfig
sh                           se7705_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
parisc                              defconfig
nios2                               defconfig
sh                           se7724_defconfig
csky                                defconfig
sh                          urquell_defconfig
sparc                               defconfig
parisc64                            defconfig

clang tested configs:
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                        randconfig-a001
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
powerpc                     kilauea_defconfig
arm                     am200epdkit_defconfig
powerpc                    mvme5100_defconfig
arm                         lpc32xx_defconfig
mips                           ip27_defconfig
x86_64                        randconfig-k001
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
