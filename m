Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF6C0015E
	for <linux-cxl@archiver.kernel.org>; Sat,  1 Jul 2023 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGALhP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 1 Jul 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGALhP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 1 Jul 2023 07:37:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EF6128
        for <linux-cxl@vger.kernel.org>; Sat,  1 Jul 2023 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688211434; x=1719747434;
  h=date:from:to:cc:subject:message-id;
  bh=0mOkgQPI2LAZNtmhDmiAL+4o6Ffrn6J5DKJT0U3IL64=;
  b=OCq7fuXJk10dbqW3eD9X9jBeZXIDL3bsM/yz9G1dIiq3aKuttGoicZlI
   kGnPCaCghZmhbHBk5shkT+KUYR630SmthPdhov3zFW2JtuScRGcH6Ztzj
   YJYg4fyCRiz2qyZEmkzIHeONq8YPQC89PeRLJKHr2JP37crvZGuWSLSMM
   QMPKn2B7kn/njoLOeErEpyuEfKAyN/MQRxxtV4rhZ9P+ESyPipsAYd82M
   5rza2fuiI0p75+Ko5e746FToedrjYoZJgHlwa0xsgEcuN79/NBpfPZ6d0
   LLL4Qdoxsx8WLQp96zALzuPQrbyYAm6MoZTYJLJD++b4V75bevCNU0Vru
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="393320645"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="393320645"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 04:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="668269271"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="668269271"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2023 04:37:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFYub-000Fzf-2k;
        Sat, 01 Jul 2023 11:37:09 +0000
Date:   Sat, 01 Jul 2023 19:36:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
Message-ID: <202307011920.eJSKroqh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9  cxl: Fix one kernel-doc comment

elapsed time: 723m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230701   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r043-20230630   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                  randconfig-r046-20230630   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230629   clang
csky                                defconfig   gcc  
csky                 randconfig-r034-20230701   gcc  
hexagon              randconfig-r003-20230701   clang
hexagon              randconfig-r041-20230630   clang
hexagon              randconfig-r045-20230630   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230701   gcc  
i386         buildonly-randconfig-r005-20230701   gcc  
i386         buildonly-randconfig-r006-20230701   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230701   clang
i386                 randconfig-i012-20230701   clang
i386                 randconfig-i013-20230701   clang
i386                 randconfig-i014-20230701   clang
i386                 randconfig-i015-20230701   clang
i386                 randconfig-i016-20230701   clang
i386                 randconfig-r013-20230630   clang
i386                 randconfig-r035-20230701   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230630   gcc  
loongarch            randconfig-r032-20230701   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r016-20230630   gcc  
microblaze           randconfig-r002-20230701   gcc  
microblaze           randconfig-r005-20230701   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230629   gcc  
nios2                randconfig-r036-20230701   gcc  
openrisc                         alldefconfig   gcc  
openrisc             randconfig-r014-20230630   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230630   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230630   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r031-20230701   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230629   gcc  
sparc64              randconfig-r006-20230701   gcc  
sparc64              randconfig-r011-20230630   gcc  
sparc64              randconfig-r015-20230630   gcc  
sparc64              randconfig-r023-20230629   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r033-20230701   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230701   gcc  
x86_64       buildonly-randconfig-r002-20230701   gcc  
x86_64       buildonly-randconfig-r003-20230701   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r026-20230629   clang
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
