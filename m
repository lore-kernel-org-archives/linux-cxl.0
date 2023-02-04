Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5AC61DA4
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Feb 2023 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBDOsw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Feb 2023 09:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBDOsv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 4 Feb 2023 09:48:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056033477
        for <linux-cxl@vger.kernel.org>; Sat,  4 Feb 2023 06:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675522129; x=1707058129;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QBP0r2vJJ7pe5D2eGOAGW0LWLHh7s/T5WpIyUHGIovo=;
  b=M31GeOWfpVhH8EWCxPbVhEHPOlRs21+faJWCv9RihX3oMAsEtQE1qIhr
   7TexuDMlzj2M3P4WKrxc4WIu88RnA0BRNxp/6tk5m6+crtl3lRZEV3JPm
   UixBEdYdRM4IiPj0MJBaSYp4QZCfHm1eqbAJbwCxl/oMcLCQZwQhaH/3X
   J6EjuPlOs7BGSSH2h2x1ANJicAQPu/wUu2Ru6hkpM1p03N9rmmYm6RtB4
   TwycodfGKOlDW4pkBinnExBebNYm21fE2akl/eZRUBg/QtPGmsB4LZJ2p
   lXACH2HFDDSRheLvpRZJUgfEJfSU/WFcXkDyiJR7RpB35oeT6aXqADIqG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="331077871"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="331077871"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 06:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="643570991"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="643570991"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2023 06:48:46 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOJqQ-0001Mi-0N;
        Sat, 04 Feb 2023 14:48:46 +0000
Date:   Sat, 04 Feb 2023 22:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 01d2cb2593b17b36e69a697567cb493f0a096c73
Message-ID: <63de7025.cIFw3l3R1PULLWZo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 01d2cb2593b17b36e69a697567cb493f0a096c73  cxl/region: Fix null pointer dereference for resetting decoder

elapsed time: 722m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
arc                  randconfig-r043-20230204
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                 randconfig-r044-20230204
s390                             allmodconfig
riscv                randconfig-r042-20230204
alpha                               defconfig
s390                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
s390                             allyesconfig
um                             i386_defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                        randconfig-a011
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
x86_64                        randconfig-a015
alpha                            allyesconfig
sh                               allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
mips                             allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a016
arm                              allyesconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc85xx_cds_defconfig
alpha                            alldefconfig
sh                   sh7724_generic_defconfig
mips                 decstation_r4k_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
sh                           se7705_defconfig
sh                           se7724_defconfig
parisc                              defconfig
sh                          urquell_defconfig
nios2                               defconfig
parisc64                            defconfig
csky                                defconfig
sparc                               defconfig
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r041-20230204
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
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
