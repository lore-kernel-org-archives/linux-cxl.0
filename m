Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D3C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 12:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjC3MKO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjC3MKM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 08:10:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D307A5CC
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 05:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680178211; x=1711714211;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YEnwg9gah47XLYGhN0dcMoo72kh+CXozgKg2bmBjYng=;
  b=GsE+M0/QciaP8o8ibSKv+Btv2btM/0E6p9karW354j7o0T2P0kpJM7AK
   NLXRrqvYZJpFBrWaGPo9TMGpQDSNXTWvyRubA2gpNkqprE8J26ZHA7Nao
   3ArKnCccST3T5sgKBtZSHrxFp8/9kJLqyf3VRYtUA7crmOmQDYegl8loy
   wY48igNKfHjN3ZbJYBcZGqiiCzodKW7cw5OFSYL1XH7M9gaedrfDl6h+6
   MPWirrVTCNu3UASsjgvXwWblA9V7slKr4FF3AhKWNS/NYf0fah5S9cd7z
   261M25xL7jUoVohQbCYDlKrHoQzsWbYbY1y6tBAjC9nLlhdehDPnMMEoi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427425633"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427425633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 05:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753977000"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="753977000"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2023 05:09:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phr6G-000KpU-0q;
        Thu, 30 Mar 2023 12:09:52 +0000
Date:   Thu, 30 Mar 2023 20:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/fixes] BUILD SUCCESS
 573d8b8fbc8c9764c957ac0df7f62b68cab86af5
Message-ID: <64257bdb.rJDKtXUFopEPRsWe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/fixes
branch HEAD: 573d8b8fbc8c9764c957ac0df7f62b68cab86af5  cxl/hdm: Extend DVSEC range register emulation for region enumeration

elapsed time: 789m

configs tested: 231
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha        buildonly-randconfig-r004-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230329   gcc  
alpha                randconfig-r006-20230329   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r026-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                             mxs_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                  randconfig-r023-20230329   gcc  
arm                  randconfig-r046-20230329   gcc  
arm                        realview_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230329   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r002-20230329   gcc  
arm64                randconfig-r003-20230329   gcc  
arm64                randconfig-r025-20230329   clang
arm64                randconfig-r026-20230329   clang
arm64                randconfig-r032-20230329   gcc  
arm64                randconfig-r036-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230329   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r023-20230329   gcc  
csky                 randconfig-r026-20230330   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon      buildonly-randconfig-r003-20230329   clang
hexagon              randconfig-r016-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230329   gcc  
ia64         buildonly-randconfig-r006-20230329   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r003-20230329   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r006-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r026-20230329   gcc  
ia64                 randconfig-r033-20230329   gcc  
ia64                 randconfig-r035-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230329   gcc  
loongarch    buildonly-randconfig-r004-20230329   gcc  
loongarch    buildonly-randconfig-r006-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230329   gcc  
loongarch            randconfig-r004-20230329   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r013-20230329   gcc  
loongarch            randconfig-r015-20230329   gcc  
loongarch            randconfig-r021-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r002-20230329   gcc  
m68k         buildonly-randconfig-r004-20230329   gcc  
m68k         buildonly-randconfig-r006-20230329   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r014-20230329   gcc  
m68k                 randconfig-r022-20230329   gcc  
m68k                 randconfig-r025-20230329   gcc  
m68k                 randconfig-r031-20230329   gcc  
microblaze   buildonly-randconfig-r001-20230329   gcc  
microblaze           randconfig-r016-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r031-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                      bmips_stb_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r001-20230329   clang
mips                 randconfig-r012-20230329   gcc  
mips                 randconfig-r015-20230329   gcc  
mips                 randconfig-r021-20230329   gcc  
mips                 randconfig-r021-20230330   gcc  
mips                 randconfig-r033-20230329   clang
nios2        buildonly-randconfig-r003-20230329   gcc  
nios2        buildonly-randconfig-r004-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230329   gcc  
nios2                randconfig-r012-20230329   gcc  
nios2                randconfig-r016-20230329   gcc  
nios2                randconfig-r025-20230329   gcc  
nios2                randconfig-r031-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
nios2                randconfig-r035-20230329   gcc  
openrisc     buildonly-randconfig-r002-20230329   gcc  
openrisc             randconfig-r006-20230329   gcc  
openrisc             randconfig-r021-20230329   gcc  
openrisc             randconfig-r034-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230329   gcc  
parisc               randconfig-r004-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc               randconfig-r022-20230330   gcc  
parisc               randconfig-r023-20230330   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r024-20230329   clang
powerpc              randconfig-r026-20230329   clang
powerpc              randconfig-r032-20230329   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230329   gcc  
riscv                randconfig-r006-20230329   gcc  
riscv                randconfig-r016-20230329   clang
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r031-20230329   gcc  
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230329   clang
s390         buildonly-randconfig-r003-20230329   clang
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r003-20230329   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r014-20230329   clang
s390                 randconfig-r022-20230329   clang
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r004-20230329   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                   randconfig-r006-20230329   gcc  
sh                   randconfig-r021-20230329   gcc  
sh                   randconfig-r023-20230329   gcc  
sh                          rsk7264_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230329   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc                randconfig-r024-20230329   gcc  
sparc                randconfig-r024-20230330   gcc  
sparc                randconfig-r036-20230329   gcc  
sparc64      buildonly-randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r006-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
sparc64              randconfig-r013-20230329   gcc  
sparc64              randconfig-r022-20230329   gcc  
sparc64              randconfig-r024-20230329   gcc  
sparc64              randconfig-r034-20230329   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
