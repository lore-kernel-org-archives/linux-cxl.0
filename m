Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C67C4332F
	for <linux-cxl@archiver.kernel.org>; Sat,  3 Dec 2022 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCWCI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 3 Dec 2022 17:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCWCH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 3 Dec 2022 17:02:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A71A3AF
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670104926; x=1701640926;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RvXyKJBpg1lC8vxxEEixtzyk+dx5dogzoMObc9z5Tf4=;
  b=ZLwm0Z80fxF8VYEAM0NRXENlF2mYzuyHHKCkpFPYyBOtwn0/dhg/Mlc8
   5sV3YIKK6uxUefdDyP+SzGUucnA1cJ2Bch4RKkRPg93u39/5UQ3SGdLye
   j5bEtn46GyniboHwKTOsHIg38b9Y17sDM7BeVuGgOQ2YE4ce3Vea1zcMr
   j7DZKQpSSYhvJx+yZJOAtNWys+zAIUDqeU0oOgpEoMK3JF4vmcaJZssru
   mdnL7zpPs1LenPRNX2cv5LPRjYPrdyZu8xg6qIwJRNV7dW/iV4doQcjoY
   zbmOhVF1JAlEu3rguNgD9IVDR5G07Zwh92X7R5qJATrXWNbBzBQ6pXi2k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="343128656"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="343128656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 14:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="751699229"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="751699229"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2022 14:01:57 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1aa1-0000NX-0v;
        Sat, 03 Dec 2022 22:01:53 +0000
Date:   Sun, 04 Dec 2022 06:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS 7b05fa9e15194a77e9db8685eac24678f4aff865
Message-ID: <638bc74c.pQQYmiv4gccB3DOm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 7b05fa9e15194a77e9db8685eac24678f4aff865  Merge branch 'for-6.2/cxl-security' into for-6.2/cxl

elapsed time: 721m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
s390                 randconfig-r044-20221201
sh                               allmodconfig
x86_64                        randconfig-a004
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
m68k                             allyesconfig
s390                                defconfig
mips                             allyesconfig
x86_64                            allnoconfig
i386                          randconfig-a012
x86_64                        randconfig-a013
m68k                             allmodconfig
arc                  randconfig-r043-20221201
i386                          randconfig-a001
powerpc                          allmodconfig
i386                             allyesconfig
ia64                             allmodconfig
i386                          randconfig-a003
x86_64                        randconfig-a011
arc                              allyesconfig
s390                             allyesconfig
riscv                randconfig-r042-20221201
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
arc                         haps_hs_defconfig
arc                               allnoconfig
sh                          r7785rp_defconfig
powerpc                      pasemi_defconfig
sh                   sh7724_generic_defconfig
sparc                       sparc64_defconfig
x86_64                        randconfig-c001
sh                          kfr2r09_defconfig
sh                          lboxre2_defconfig
sparc64                             defconfig
arm                  randconfig-c002-20221201
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
ia64                        generic_defconfig
mips                     loongson1b_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7206_defconfig
arm                        cerfcube_defconfig
m68k                                defconfig
mips                    maltaup_xpa_defconfig
arc                            hsdk_defconfig
riscv                             allnoconfig
sh                           se7705_defconfig
riscv                    nommu_virt_defconfig
arm                            xcep_defconfig
loongarch                         allnoconfig
parisc                              defconfig
parisc                           alldefconfig
openrisc                         alldefconfig
powerpc                 mpc8540_ads_defconfig
ia64                            zx1_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_k210_defconfig
powerpc                         ps3_defconfig
powerpc                   currituck_defconfig
riscv                          rv32_defconfig
s390                          debug_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20221204
nios2                               defconfig

clang tested configs:
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a012
i386                          randconfig-a006
hexagon              randconfig-r045-20221201
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-k001
arm                       spear13xx_defconfig
arm                          ep93xx_defconfig
arm                         bcm2835_defconfig
powerpc                          allyesconfig
powerpc                     akebono_defconfig
i386                              allnoconfig
arm                          pcm027_defconfig
arm                         hackkit_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
