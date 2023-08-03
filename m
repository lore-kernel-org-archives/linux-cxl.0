Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D74EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Aug 2023 14:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjHCOO1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjHCOOH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Aug 2023 10:14:07 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE01728
        for <linux-cxl@vger.kernel.org>; Thu,  3 Aug 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691072027; x=1722608027;
  h=date:from:to:cc:subject:message-id;
  bh=KBSLL+e/hfn+T9Bxb7I2u9blFbfmRqhOLZfXl1U3sXM=;
  b=Ndu2xCiZ7Foc82mKhY9OLEKF8fRqwVgM9rt2pZBefbGEuTC17lTtoadm
   ekg9zEHNxDFlE76gQR3ujYDZXcPjgkcUNxJifo3uiFETKNqyPvaj/I9oU
   4LdKmcXE4gEMpb2xdXjqRF437KmaiFRfc4ewiDLAm8w2BTIfi2sQoSID4
   GlNMhOhpjfMo9mgimiNQkWpy1ekoyF1rxuP/aTZNIZmM+BbLQrWd64Brq
   Yi5HBr+YZ+CVy/tpnCVumwCtB959+g2Q4aqvfVonTrVZvp9lhBwVGQ647
   BeZLdXk7YUs6pq2XVK4x7OfA4jyuC7V2+fxDeQF84URdEnygX/gpEOe4q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373518398"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373518398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="843592235"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="843592235"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2023 06:43:27 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRYbu-000289-20;
        Thu, 03 Aug 2023 13:43:26 +0000
Date:   Thu, 03 Aug 2023 21:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 ad64f5952ce3ea565c7f76ec37ab41df0dde773a
Message-ID: <202308032148.V6BRZ4MP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: ad64f5952ce3ea565c7f76ec37ab41df0dde773a  cxl/memdev: Only show sanitize sysfs files when supported

elapsed time: 722m

configs tested: 151
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230731   gcc  
alpha                randconfig-r036-20230801   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230802   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r023-20230731   gcc  
arm                  randconfig-r046-20230802   clang
arm                        realview_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230801   gcc  
hexagon              randconfig-r016-20230801   clang
hexagon              randconfig-r041-20230802   clang
hexagon              randconfig-r045-20230802   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230801   clang
i386                 randconfig-r025-20230731   clang
i386                 randconfig-r035-20230731   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230731   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230801   gcc  
m68k                 randconfig-r006-20230801   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r013-20230801   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                 randconfig-r001-20230801   clang
mips                 randconfig-r002-20230731   clang
mips                 randconfig-r011-20230801   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230801   gcc  
openrisc             randconfig-r003-20230801   gcc  
openrisc             randconfig-r031-20230731   gcc  
openrisc             randconfig-r032-20230731   gcc  
openrisc             randconfig-r034-20230801   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r014-20230801   clang
powerpc              randconfig-r022-20230731   clang
powerpc              randconfig-r026-20230731   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230802   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230801   gcc  
s390                 randconfig-r015-20230801   clang
s390                 randconfig-r044-20230802   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230801   gcc  
sparc64              randconfig-r031-20230801   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
