Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A6C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDDOuz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjDDOuy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Apr 2023 10:50:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721F3A9C
        for <linux-cxl@vger.kernel.org>; Tue,  4 Apr 2023 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680619851; x=1712155851;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/BCTyqiI1hF2IVstWkz9SeYAyF7EGdlKGkoCKsR0jLg=;
  b=Zdj+BaaTnCWb2EcKMRlRlb1AIld4lG3JpcNB6ytKebVm0ogFo32nDXau
   Cc9Ou59u8vIfBLf0lowwSW6tjA/DpFjZ8RNHshPFLDHNQcLePIPWRo7ph
   0oYBAC7SF8MrrH5JYvm8XwllrOzzEdaIugIgPvZCWexGMH5dTJ/1YBSC1
   dBErIq1kl7EHKJVLRioCmIVXDC9KEk8mZJLGOfO7EwxYRXzgPdV5DaQ3Q
   B70Tp/uIeRVlp0T+3g/ElOyuxl9s6bhHwuvGGFpVmzRGgzOm6Ix7ctxbx
   KOyUy2hLkalI9frZMSQaOEpYwGuJ/Jp+WeIb88SP0mm7Qf6sHrR+7Ui8V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="340935625"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="340935625"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 07:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="663636435"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="663636435"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2023 07:50:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjhzS-000Pnj-0i;
        Tue, 04 Apr 2023 14:50:30 +0000
Date:   Tue, 04 Apr 2023 22:49:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-rr-fixes] BUILD SUCCESS
 1b7ebcaaf1cb58feefa7164e44a6f714c69efd7b
Message-ID: <642c390b.WPVHZJvgnGcIo3sG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-rr-fixes
branch HEAD: 1b7ebcaaf1cb58feefa7164e44a6f714c69efd7b  cxl/hdm: Extend DVSEC range register emulation for region enumeration

elapsed time: 725m

configs tested: 101
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r026-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230403   gcc  
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r035-20230403   clang
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k         buildonly-randconfig-r002-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230403   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230403   gcc  
nios2                randconfig-r032-20230403   gcc  
parisc       buildonly-randconfig-r004-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230403   clang
powerpc              randconfig-r005-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230403   clang
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64               randconfig-r025-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r031-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
