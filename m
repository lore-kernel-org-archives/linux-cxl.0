Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57381C04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJYOZc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJYOZa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 10:25:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974719C2E2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666707929; x=1698243929;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OT7jrcE1w07xQit1zgoSt0ZSuuJ+PubsuaN0K5qOyQU=;
  b=kR08H+NVvkU+Kq80xHI0h45OCadq1rFaOBaR1teeGDdBRyTlSKzgcm2n
   gLzIyfFVFAVVUifuLf3SO8OO2FLQMaCqX1uXDX3LlCsWQtgsU+HWFW1hy
   +NEx6GT6ytru+q0VMDuT+KOAc3Nrkq4Epjm8X5EpYvcwrWUkTCE+RqYOw
   wO0ShoN2yvhQnXE90xQdRvbwoMxECEUpLsAjKneosNcr6vQDZYttddBk+
   y+yrYyDNehO/SzTtWomQsZQJOKNVedAXB5shFEaWw7J8pOgv3sIf6Z+er
   58YA9OGtvNk7xplHlfMmH6awoXXZQJBzS/w2iawd/i1+5G/uzTsN7s0dw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308781543"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="308781543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 07:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="774210237"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="774210237"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 07:19:13 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onKls-0006Kv-2i;
        Tue, 25 Oct 2022 14:19:12 +0000
Date:   Tue, 25 Oct 2022 22:19:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 445041d7dacaf56462edad90cbe0372a16274c7b
Message-ID: <6357f05c.G1Z4VWHdo0nze4Nb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: 445041d7dacaf56462edad90cbe0372a16274c7b  cxl/doe: Request exclusive DOE access

elapsed time: 725m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-k001-20221024
x86_64                               rhel-8.3
sh                           se7712_defconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
arm                         vf610m4_defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a011
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                           allyesconfig
powerpc                      cm5200_defconfig
x86_64                        randconfig-a015
arc                                 defconfig
arc                  randconfig-r043-20221024
x86_64                        randconfig-a002
m68k                             allmodconfig
alpha                               defconfig
powerpc                          allmodconfig
arc                              allyesconfig
riscv                randconfig-r042-20221024
s390                             allmodconfig
i386                          randconfig-a014
alpha                            allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221023
i386                          randconfig-a012
mips                             allyesconfig
s390                                defconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
s390                 randconfig-r044-20221024
i386                          randconfig-a016
sh                               allmodconfig
m68k                             allyesconfig
powerpc                 mpc85xx_cds_defconfig
arc                              alldefconfig
arm64                            allyesconfig
s390                             allyesconfig
m68k                       m5475evb_defconfig
sh                          polaris_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
arm                        spear6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs103_defconfig
sh                        dreamcast_defconfig
riscv                    nommu_k210_defconfig
um                               alldefconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a013-20221024
i386                        debian-10.3-kunit
parisc                              defconfig
i386                         debian-10.3-func
i386                          debian-10.3-kvm
arm                              allyesconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
nios2                               defconfig
parisc64                            defconfig

clang tested configs:
arm                      pxa255-idp_defconfig
riscv                            alldefconfig
hexagon              randconfig-r041-20221024
i386                 randconfig-a004-20221024
x86_64                        randconfig-a012
riscv                randconfig-r042-20221023
i386                 randconfig-a001-20221024
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                 randconfig-a002-20221024
hexagon              randconfig-r045-20221024
i386                          randconfig-a015
s390                 randconfig-r044-20221023
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                 randconfig-a005-20221024
x86_64                        randconfig-a001
i386                 randconfig-a003-20221024
hexagon              randconfig-r041-20221023
i386                 randconfig-a006-20221024
hexagon              randconfig-r045-20221023
x86_64                        randconfig-a003
arm                       spear13xx_defconfig
powerpc                        icon_defconfig
powerpc                  mpc866_ads_defconfig
x86_64               randconfig-a005-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a001-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a003-20221024

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
