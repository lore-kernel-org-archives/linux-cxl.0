Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6030C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Dec 2022 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLIJjP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLIJjN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Dec 2022 04:39:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C793A2DD
        for <linux-cxl@vger.kernel.org>; Fri,  9 Dec 2022 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670578752; x=1702114752;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FVtmr2JoyzBzAnOuH7YYnQ/jb+eVbudhxnjyw1KhYGw=;
  b=U96drYMsnivfqNyqGRsJAeOVD/O8UWR8N1N9Agr5sj8Slpkg6zYxFoPD
   aw1H96R3w3B8F4EDZiudbvPHTnOwHkhWTr4tdPV7ri7TUJXEozB9QpH1K
   doxikvB6iMTwG81wRrizdpBbwQjPy/wA/+Ax25GNL6gtr5mNRnD193XNT
   +C7BjhLBBK6cfVQvEP2aN7qa9vpkB2LR12C40TuEqq7Iu74n9Gl0Al8dS
   2MVe3t46bDVkwpW6SsZBH3H+CDNAdRnZ8zSq+R2JY/N9Od0WOfxCi5Vbd
   gKsKbU68OZ788doQ1xSfCwMz1sn/adcg7xVqbCsRn2iWXF5oGqtKGA/gc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="317450035"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="317450035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 01:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="710827881"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="710827881"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2022 01:39:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3ZqX-0001mS-25;
        Fri, 09 Dec 2022 09:39:09 +0000
Date:   Fri, 09 Dec 2022 17:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS f04facfb993de47e2133b2b842d72b97b1c50162
Message-ID: <63930221.zsIVySsXPJsRLWMt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: f04facfb993de47e2133b2b842d72b97b1c50162  cxl/region: Fix memdev reuse check

elapsed time: 723m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a013
powerpc                           allnoconfig
x86_64                        randconfig-a011
um                             i386_defconfig
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a006
x86_64                        randconfig-a015
arc                                 defconfig
s390                             allmodconfig
x86_64                           allyesconfig
alpha                               defconfig
m68k                             allyesconfig
s390                                defconfig
i386                          randconfig-a014
i386                                defconfig
s390                             allyesconfig
i386                          randconfig-a012
arm                              allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
i386                          randconfig-a016
x86_64                            allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
alpha                            allyesconfig
i386                          randconfig-a001
i386                             allyesconfig
i386                          randconfig-a003
arc                  randconfig-r043-20221207
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221207
x86_64                           rhel-8.3-kvm
i386                          randconfig-a005
s390                 randconfig-r044-20221207
i386                          randconfig-c001
m68k                        m5272c3_defconfig
ia64                        generic_defconfig
powerpc                  storcenter_defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                          hp300_defconfig
sh                           se7712_defconfig
i386                          debian-10.3-kvm
m68k                        mvme147_defconfig
powerpc                 canyonlands_defconfig
m68k                          atari_defconfig
sh                         ap325rxa_defconfig
csky                                defconfig
arm                            hisi_defconfig
sh                          urquell_defconfig
sparc                               defconfig
arm                           corgi_defconfig
arm                         lpc18xx_defconfig
x86_64                                  kexec
loongarch                         allnoconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
arm                           h3600_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221207
parisc                              defconfig
loongarch                           defconfig
nios2                               defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                  randconfig-r046-20221207
i386                          randconfig-a002
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                        vexpress_defconfig
arm                                 defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
