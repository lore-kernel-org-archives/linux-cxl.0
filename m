Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E7C3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 09:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiLFJbB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiLFJbA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 04:31:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C71D332
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670319060; x=1701855060;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=riFGuCT8GJiTysaBUWtmvzIfivvpA2DSmnXPx291BSY=;
  b=Yo9jENg9bMhwRt0HRLgCk9vniauy1fMx/JKcqZK8vfBXTN1XRKYUtL8G
   y4riTkJSwLg4wYDpKj2N/2ibF6NYWyRy/SDvqR7iRZWlZw7jHFlbmp4q0
   CZYsQNVvsJSMa6Yop5iLZGwl6iwPKPK5D6VH/cH4unv+SchIoyiimJOut
   5yh8+kasro4FV2i63NKEEv847LdC7nrw1E+V5jw+Efvzpe0zSZCiljaWI
   Rm23D2IhTPZgPsUPM//iF7W6k40c7JllzdBEXf6iJYSTVp1fr0WB6S8IY
   C+Y/wF8WhJGuQIXDsvZXRtoq7tkf6bBiojhNl7nP2Be2YcIvvwFyv1QNR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318440409"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318440409"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 01:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="820519005"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="820519005"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 01:30:57 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2UHx-0000oL-0E;
        Tue, 06 Dec 2022 09:30:57 +0000
Date:   Tue, 06 Dec 2022 17:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-rch] BUILD SUCCESS
 da8380bbbe90f69bec4be69af4d0deb7cf2bbcfe
Message-ID: <638f0ba3.uvILkJo2WPBhRx4l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-rch
branch HEAD: da8380bbbe90f69bec4be69af4d0deb7cf2bbcfe  cxl/acpi: Set ACPI's CXL _OSC to indicate RCD mode support

elapsed time: 729m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a011-20221205
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a012-20221205
x86_64               randconfig-a014-20221205
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a013-20221205
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a015-20221205
x86_64               randconfig-a016-20221205
x86_64                               rhel-8.3
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                  randconfig-r046-20221206
ia64                             allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
arm                                 defconfig
arc                  randconfig-r043-20221206
x86_64                           allyesconfig
s390                             allmodconfig
s390                                defconfig
arm                              allyesconfig
i386                 randconfig-a013-20221205
i386                 randconfig-a012-20221205
arm64                            allyesconfig
i386                 randconfig-a011-20221205
i386                 randconfig-a014-20221205
i386                 randconfig-a016-20221205
i386                             allyesconfig
i386                 randconfig-a015-20221205
s390                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                            allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                       m5208evb_defconfig
sh                           se7705_defconfig
i386                 randconfig-c001-20221205
arm                        oxnas_v6_defconfig
microblaze                      mmu_defconfig
arc                           tb10x_defconfig
loongarch                         allnoconfig
xtensa                generic_kc705_defconfig
arm                           stm32_defconfig
openrisc                         alldefconfig
mips                         rt305x_defconfig
mips                           gcw0_defconfig
sh                          rsk7264_defconfig
riscv             nommu_k210_sdcard_defconfig
parisc                              defconfig
x86_64               randconfig-k001-20221205
loongarch                           defconfig
csky                                defconfig
nios2                               defconfig
sparc                               defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a005-20221205
hexagon              randconfig-r045-20221206
hexagon              randconfig-r041-20221206
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
riscv                randconfig-r042-20221206
s390                 randconfig-r044-20221206
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a006-20221205
mips                     loongson1c_defconfig
powerpc                      katmai_defconfig
mips                malta_qemu_32r6_defconfig
arm                        neponset_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1830-neo_defconfig
arm                    vt8500_v6_v7_defconfig
hexagon              randconfig-r041-20221205
arm                  randconfig-r046-20221205
hexagon              randconfig-r045-20221205
riscv                          rv32_defconfig
hexagon              randconfig-r041-20221204
riscv                randconfig-r042-20221204
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
