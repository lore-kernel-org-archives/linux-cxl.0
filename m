Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63055C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 09:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiLFJbB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFJbA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 04:31:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C811D325
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670319060; x=1701855060;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v8a5p54D9tds2DykczrGHVg+1GyzOGOftgAs8w4Z/9s=;
  b=YIJ7XpGa11b2wkCYZCNrMRfCFb11MpO+LWT5fOqi/1BxX5UZJ+2lMMqO
   /IkuFDIeVjroZ9CDcVPqIkGeevr0IsaQWOEvBpWRsUzoQYxWtzy/zSKIc
   +xgoISRudWJNn5+s3MD76on+hC9qGH1nLSqOkJaRowD6LKdbzX1j4vQoP
   JtfL3C2qf8AYlTH86h3AEDIIKJoFNMlcn14/snIkUue9Oz8xx6u7IMehu
   FjH2/xooJ2+r5Z9yCizAR0/D7qGGhDqUp7tYheIuTzR5B9wQPTfYx4D0J
   Q+++X37W4XOYt8p4KsBlVSbQFS4TmHE4aOc6Rw8A10dnsV1CyNnpBH96h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315290817"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="315290817"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 01:30:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709600923"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="709600923"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2022 01:30:57 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2UHx-0000oT-0a;
        Tue, 06 Dec 2022 09:30:57 +0000
Date:   Tue, 06 Dec 2022 17:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS 02fedf1466567424c336cd11cf368dcf78f2af33
Message-ID: <638f0ba9.IU9F81xICx7Actwx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 02fedf1466567424c336cd11cf368dcf78f2af33  Merge branch 'for-6.2/cxl-xor' into for-6.2/cxl

elapsed time: 729m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64               randconfig-a011-20221205
x86_64               randconfig-a012-20221205
x86_64               randconfig-a013-20221205
alpha                               defconfig
arc                                 defconfig
arc                  randconfig-r043-20221205
powerpc                           allnoconfig
s390                                defconfig
s390                             allmodconfig
i386                                defconfig
arm                                 defconfig
s390                 randconfig-r044-20221205
x86_64                              defconfig
m68k                             allyesconfig
um                             i386_defconfig
i386                 randconfig-a014-20221205
um                           x86_64_defconfig
riscv                randconfig-r042-20221205
i386                          randconfig-a014
i386                 randconfig-a012-20221205
i386                 randconfig-a015-20221205
i386                 randconfig-a011-20221205
x86_64                               rhel-8.3
alpha                            allyesconfig
i386                          randconfig-a012
i386                 randconfig-a013-20221205
m68k                             allmodconfig
i386                          randconfig-a016
sh                               allmodconfig
i386                 randconfig-a016-20221205
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
x86_64               randconfig-a014-20221205
s390                             allyesconfig
x86_64               randconfig-a015-20221205
x86_64                          rhel-8.3-func
x86_64               randconfig-a016-20221205
arm64                            allyesconfig
mips                             allyesconfig
arm                              allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                 randconfig-c001-20221205
i386                             allyesconfig
m68k                       m5208evb_defconfig
nios2                               defconfig
arm                        oxnas_v6_defconfig
sh                         microdev_defconfig
sh                           se7705_defconfig
microblaze                      mmu_defconfig
xtensa                generic_kc705_defconfig
arc                           tb10x_defconfig
loongarch                         allnoconfig
arc                               allnoconfig
sh                          rsk7264_defconfig
m68k                            mac_defconfig
riscv                            allyesconfig
s390                       zfcpdump_defconfig
loongarch                           defconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
loongarch                        allmodconfig
parisc                              defconfig
i386                              debian-10.3
riscv                          rv32_defconfig
csky                                defconfig
x86_64                                  kexec
riscv                               defconfig
sparc                               defconfig
parisc64                            defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
m68k                                defconfig

clang tested configs:
x86_64               randconfig-a003-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a005-20221205
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a006-20221205
hexagon              randconfig-r045-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a004-20221205
arm                  randconfig-r046-20221205
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r041-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a006-20221205
i386                          randconfig-a015
powerpc                      katmai_defconfig
powerpc                     ppa8548_defconfig
mips                     loongson1c_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        neponset_defconfig
mips                           rs90_defconfig
powerpc                     tqm5200_defconfig
powerpc                      ppc44x_defconfig
mips                     loongson2k_defconfig
hexagon              randconfig-r041-20221206
riscv                randconfig-r042-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221204
riscv                randconfig-r042-20221204
hexagon              randconfig-r045-20221204
s390                 randconfig-r044-20221204

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
