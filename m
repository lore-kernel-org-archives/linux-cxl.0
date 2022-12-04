Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E8CC4321E
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 07:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLDHGK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 02:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiLDHGJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 02:06:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BB18346
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670137568; x=1701673568;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IHX96mutiF5wIIRgJM0Gg9Pi4qaQmkl8pu3hYZ1PqHM=;
  b=kqtHpnkoPoaET3JLcP5xPN9QjXXmAKOLpSe9wAcHOY9TP/HUCWb7NkNL
   MfEJ74l+wzE1uiNak9h9Y67dcNXJzQ3ZUmq4QAAYCm8swn1lGZ0oM0I4L
   7abWOJFWTNpaF3ek/8RI/0JHVEQQYNE2fzRJjYq6F+c2FOMa2gmFu4Swr
   V08CP/I8HhiYVTr3rQtpmGzcXJS55aOarBjpw4zILsfQgNjvGftEsL9P9
   rGVvLU0PRUkFgg+QeftuSBO360m5TXPkWCWMb7kQiiV0nJkbgK9QutqJp
   MlM7vrjQps2iLbQ4IqoerOtorljTJWUAZsGGHIQtAyshNTA9xNJ/EvgCz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="314878280"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="314878280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 23:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="751782888"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="751782888"
Received: from lkp-server01.sh.intel.com (HELO 4d912534d779) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2022 23:06:06 -0800
Received: from kbuild by 4d912534d779 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1j4f-0000e9-1M;
        Sun, 04 Dec 2022 07:06:05 +0000
Date:   Sun, 04 Dec 2022 15:05:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-security] BUILD SUCCESS
 d18bc74aced65e4ad68a30ac8db883398141e918
Message-ID: <638c46d5.U6XwFKpAaU8a/vcG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-security
branch HEAD: d18bc74aced65e4ad68a30ac8db883398141e918  cxl/region: Manage CPU caches relative to DPA invalidation events

elapsed time: 810m

configs tested: 100
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                              defconfig
s390                             allmodconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a001
sh                               allmodconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
arm                  randconfig-r046-20221204
m68k                             allmodconfig
arm64                            allyesconfig
i386                          randconfig-a012
sh                          r7785rp_defconfig
i386                          randconfig-a016
x86_64                           allyesconfig
x86_64                        randconfig-a004
arc                  randconfig-r043-20221204
arm                              allyesconfig
x86_64                        randconfig-a006
arm                           stm32_defconfig
powerpc                          allmodconfig
i386                             allyesconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
parisc                              defconfig
i386                          randconfig-c001
sh                        dreamcast_defconfig
powerpc                    klondike_defconfig
arm                             rpc_defconfig
xtensa                  cadence_csp_defconfig
m68k                        mvme147_defconfig
powerpc                       eiger_defconfig
mips                           gcw0_defconfig
parisc                           alldefconfig
ia64                            zx1_defconfig
powerpc                         ps3_defconfig
powerpc                   currituck_defconfig
s390                          debug_defconfig
nios2                               defconfig
riscv                               defconfig
riscv                             allnoconfig
i386                          debian-10.3-kvm
csky                                defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_k210_defconfig
sparc                               defconfig
riscv                    nommu_virt_defconfig
parisc64                            defconfig
loongarch                         allnoconfig
arm                           imxrt_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
loongarch                           defconfig
loongarch                        allmodconfig
x86_64                                  kexec
riscv                          rv32_defconfig
i386                              debian-10.3
nios2                            allyesconfig
parisc                           allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20221204
i386                          randconfig-a002
s390                 randconfig-r044-20221204
hexagon              randconfig-r045-20221204
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a006
riscv                randconfig-r042-20221204
x86_64                        randconfig-a005
i386                          randconfig-a004
arm                     davinci_all_defconfig
mips                        maltaup_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
