Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7772DC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 10:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjBHK5I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 05:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBHK5H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 05:57:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946EF761
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675853826; x=1707389826;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9LbYEFJP3iiRXLXVXatcQs+IBG+AM7WgEjoD+3gAMtI=;
  b=C2HsCAOLH0EewDhI4k0muuAVEPWkJjW1wxsq8wU51Fg4J/vIEY43TDgY
   79L1ADdi7ABCxgsZcPzVbM0spxGbv7M5i9ewxReIKPbwlGtrTajVXYS8H
   a/xzVgFNZ9vga1A79IBCACrIgcyo/5geEJObZUWpDWVF57UNSOcZZ5r2Z
   YRjrlF1iI1ZNv7odzfO7Cq6F5QZcKX2plA8c9UmalFhB8Mt3xtLmolsih
   ssRypHJEnZX7o/yJQR5kym6i2gDynd6iqi68wLYQCO9w1tUUpmdOaBEC+
   LxQxWrdKChoYRyUMH9quxJJBbuppw8+L0XT42+9RVoc19woYc7cwdZkcm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357157464"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357157464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 02:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617163456"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617163456"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2023 02:57:03 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPi8M-0004PO-0q;
        Wed, 08 Feb 2023 10:57:02 +0000
Date:   Wed, 08 Feb 2023 18:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS dbe9f7d1e155b97a42f7da81e22acc98fe0a9072
Message-ID: <63e37fc8.16OsVMy42gFTsBgD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: dbe9f7d1e155b97a42f7da81e22acc98fe0a9072  Merge branch 'for-6.3/cxl-events' into cxl/next

elapsed time: 853m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
ia64                             allmodconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64               randconfig-a014-20230206
x86_64               randconfig-a013-20230206
powerpc                           allnoconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
arm                                 defconfig
m68k                             allyesconfig
x86_64               randconfig-a011-20230206
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a015-20230206
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a012-20230206
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a016-20230206
x86_64                        randconfig-a006
i386                             allyesconfig
arm                            hisi_defconfig
x86_64                           allyesconfig
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
mips                  maltasmvp_eva_defconfig
nios2                            alldefconfig
i386                          randconfig-c001
arm64                            allyesconfig
i386                 randconfig-a012-20230206
i386                 randconfig-a016-20230206
parisc64                            defconfig
arm                              allyesconfig
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
sparc                            alldefconfig
powerpc                      ppc40x_defconfig
ia64                         bigsur_defconfig
arm                         vf610m4_defconfig
m68k                        mvme147_defconfig
powerpc                         wii_defconfig
parisc                generic-32bit_defconfig
microblaze                      mmu_defconfig
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
csky                                defconfig
parisc                              defconfig
sparc                               defconfig
x86_64                                  kexec
i386                        debian-10.3-kunit
riscv                               defconfig
i386                         debian-10.3-func
i386                          debian-10.3-kvm
loongarch                         allnoconfig
powerpc                  iss476-smp_defconfig
sh                          r7785rp_defconfig
powerpc                      cm5200_defconfig
mips                        vocore2_defconfig
sh                        edosk7705_defconfig
powerpc                          allmodconfig
m68k                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a003
x86_64                        randconfig-a005
mips                           ip22_defconfig
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a002-20230206
mips                        bcm63xx_defconfig
i386                 randconfig-a003-20230206
i386                 randconfig-a006-20230206
arm                      tct_hammer_defconfig
powerpc                  mpc885_ads_defconfig
arm                         orion5x_defconfig
s390                             alldefconfig
arm                          ep93xx_defconfig
arm                                 defconfig
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
