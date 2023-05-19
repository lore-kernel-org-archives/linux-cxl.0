Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93BC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 12:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjESMyO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjESMyM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 08:54:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFD106
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684500851; x=1716036851;
  h=date:from:to:cc:subject:message-id;
  bh=GmumKTzBkMHHg2a1G5EHaazHKZPcmxecvvfs2/17YSc=;
  b=ALeCE9FRwqlsxftDg0UHRNSXVh1vigFb9ncU6T5ev2UDOZuw/C4zr9r/
   S4XOlGwl9p74xoE748zOtrnyy8QqA9twvfBuwN+7NhJ9TrKoT66nz1JnS
   CXX1dAoQRBu7ZliDkd0NsnNUhZzBAJumTm0nhVvfHjN7ClaB/NXQ0FO2x
   uk1Sp+Afqlt/39mT5yCpyMNAI57nefD/N1s6r+q4LTiX5pD1L9XHjtlmT
   DWQE7DALzKstJKr3ZjUtIp77KZOQBAwVrioNdOEZDoUxooy9uN3aMeFrh
   RevvynNcGql1L4s9zgxxNs4pamo1bjnWOmERde+S3yYX3Cn2yi7VTERm7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354717030"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="354717030"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 05:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814722380"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="814722380"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2023 05:54:09 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzzcW-000ApM-1K;
        Fri, 19 May 2023 12:54:08 +0000
Date:   Fri, 19 May 2023 20:53:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 e764f12208b99ac7892c4e3f6bf88d71ca71036f
Message-ID: <20230519125323.9qdrm%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/cxl
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: e764f12208b99ac7892c4e3f6bf88d71ca71036f  cxl: Move cxl_await_media_ready() to before capacity info retrieval

elapsed time: 721m

configs tested: 131
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230517   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230517   gcc  
arc                  randconfig-r022-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230517   gcc  
csky                 randconfig-r026-20230517   gcc  
hexagon              randconfig-r031-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                             allyesconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r025-20230517   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r003-20230517   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r015-20230517   clang
mips                 randconfig-r032-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r012-20230517   gcc  
powerpc              randconfig-r014-20230517   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230517   gcc  
s390                 randconfig-r023-20230517   gcc  
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh           buildonly-randconfig-r005-20230517   gcc  
sh                           se7751_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230517   gcc  
sparc64              randconfig-r024-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230517   gcc  
xtensa               randconfig-r002-20230517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
