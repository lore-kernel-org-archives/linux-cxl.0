Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F94C636D3
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Feb 2023 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBDOsx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Feb 2023 09:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBDOsw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 4 Feb 2023 09:48:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A4633479
        for <linux-cxl@vger.kernel.org>; Sat,  4 Feb 2023 06:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675522131; x=1707058131;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7ikwClZ51ozXmmBMkNwpNEfzbhWHcjDFdghdPBA6wwM=;
  b=Y5/0yFNzyZd/nVwaAyXjhZ8rZHNq877XHWmRh2QY1D1Bpr0+QOjQ7lxQ
   hUNU+ZGGnEc7oUhPeu+Egk3m3UyIIhir0BUm5b+ZyjISSSCSADWdzOUZa
   8lY+sag4r2kP034nMv9DW7UfhoFUw3stDAm2ll6WxIzI9HuIxqiopT/pk
   llPKf1ISZLodFU+3kmpD/SBuk6M34ClrgnfxZbE91xoap9kottnS7BQEq
   goCv8G/4PhfXrNZj7Ba1HDMpmY2vWeeXJ2d5Ezh2d/eH6j0Dsq0sCkcN1
   huY+A7SqltGVgm+15J8kbqm4ybFkh1m7QfAnoYqEO3kYmYDbU7UClMdI9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="331077872"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="331077872"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 06:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="643570993"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="643570993"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2023 06:48:46 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOJqQ-0001Mk-0T;
        Sat, 04 Feb 2023 14:48:46 +0000
Date:   Sat, 04 Feb 2023 22:48:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD SUCCESS
 14acf2db2613dad48f315647c022b15e7dd7b7bd
Message-ID: <63de702a.EbVyVsL6Y80hk1JI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: 14acf2db2613dad48f315647c022b15e7dd7b7bd  cxl/dax: Create dax devices for CXL RAM regions

elapsed time: 722m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
arc                                 defconfig
s390                             allmodconfig
arm                                 defconfig
i386                          randconfig-a001
alpha                               defconfig
i386                          randconfig-a003
arc                  randconfig-r043-20230204
sh                               allmodconfig
s390                                defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
um                           x86_64_defconfig
s390                             allyesconfig
s390                 randconfig-r044-20230204
i386                          randconfig-a005
mips                             allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20230204
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
arc                              allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                           allyesconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a015
i386                          randconfig-a014
m68k                             allyesconfig
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a016
arm                            lart_defconfig
sh                               j2_defconfig
sh                           se7724_defconfig
sh                          urquell_defconfig
powerpc                       eiger_defconfig
loongarch                         allnoconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    adder875_defconfig
sh                           se7705_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
sh                           se7751_defconfig
loongarch                           defconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
parisc                              defconfig
riscv                    nommu_virt_defconfig
csky                                defconfig
loongarch                        allmodconfig
nios2                               defconfig
sparc                               defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                                  kexec
riscv                          rv32_defconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20230204
i386                          randconfig-a002
arm                  randconfig-r046-20230204
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20230204
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005
powerpc                 mpc832x_mds_defconfig
arm                  colibri_pxa270_defconfig
arm                       aspeed_g4_defconfig
mips                      bmips_stb_defconfig
mips                           ip27_defconfig
x86_64                        randconfig-k001
powerpc                      ppc64e_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
