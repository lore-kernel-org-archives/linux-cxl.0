Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4308CC6379F
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBHItE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 03:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBHItC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 03:49:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECA45891
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675846140; x=1707382140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=83dLHERuq3yPeTYiA31qJdYY8EFB6ZqsjtE6ydQ3r60=;
  b=kTaGuFtOIpQg0Zc3YII6fT4HsHpTigh0EuEcSvR2yzDudLl7Kuqmpea6
   Nekrh5l+KZbiA50x/Iea/maPwgrPTghL4f5K0rNyQIwtA8gySPJignn4q
   865qFaSPSsv6PygbtEQOT7aOyuE4z6fvJXYhMy1lnooriEyDZUWXAjlwz
   iEB63EMPr1h80XINMjwv/qAzavqRE5tQpWtK6elvI9P7Ne/dSK6xtmeHu
   K3L92K7ig6C5N6DWIuRLlxxuyoiF5UaHVeZsE2kYdwmxFKIzmyTo6JKlJ
   ZPdRGJCepGLXRUwcBL2m1J1K4XyExsdmYVHFIicGUS6P4qcUAnGQEQBki
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327441666"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="327441666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735857150"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735857150"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 00:48:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPg8P-0004Ku-1r;
        Wed, 08 Feb 2023 08:48:57 +0000
Date:   Wed, 08 Feb 2023 16:48:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 711442e29f16f0d39dd0e2460c9baacfccb9d5a7
Message-ID: <63e361e6.g/uqAf/6upM/2x05%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 711442e29f16f0d39dd0e2460c9baacfccb9d5a7  cxl/region: Fix passthrough-decoder detection

elapsed time: 726m

configs tested: 88
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
i386                                defconfig
s390                             allmodconfig
x86_64                              defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
s390                             allyesconfig
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
ia64                             allmodconfig
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20230206
m68k                             allyesconfig
x86_64                          rhel-8.3-func
m68k                             allmodconfig
i386                 randconfig-a013-20230206
arm64                            allyesconfig
arc                              allyesconfig
i386                 randconfig-a016-20230206
mips                             allyesconfig
arm                              allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20230205
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
powerpc                          allmodconfig
x86_64                        randconfig-a011
i386                 randconfig-a015-20230206
sh                           se7780_defconfig
arm                  randconfig-r046-20230205
arm                        mini2440_defconfig
arm                          gemini_defconfig
x86_64                        randconfig-a015
i386                          randconfig-c001
powerpc              randconfig-c003-20230205
sh                           sh2007_defconfig
ia64                         bigsur_defconfig
sparc                            alldefconfig
powerpc                      ppc40x_defconfig
arc                        nsim_700_defconfig
sh                          polaris_defconfig
arc                            hsdk_defconfig
sh                          rsk7201_defconfig
arm                              allmodconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a002-20230206
i386                 randconfig-a005-20230206
x86_64               randconfig-a002-20230206
x86_64                        randconfig-a014
x86_64               randconfig-a004-20230206
i386                 randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
x86_64                        randconfig-a016
i386                 randconfig-a006-20230206
x86_64               randconfig-a005-20230206
x86_64                        randconfig-a012
hexagon              randconfig-r045-20230205
x86_64               randconfig-a006-20230206
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205
arm                          pcm027_defconfig
powerpc                  mpc885_ads_defconfig
arm                      tct_hammer_defconfig
arm                         orion5x_defconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
