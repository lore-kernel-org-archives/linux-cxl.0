Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62692C61DA4
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Feb 2023 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBRLoC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 18 Feb 2023 06:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRLoB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 18 Feb 2023 06:44:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A42F13D59
        for <linux-cxl@vger.kernel.org>; Sat, 18 Feb 2023 03:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676720641; x=1708256641;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=n7a5J2p62v4rKz3vbl+Zr76iju2bWKDgYid6VcBjKO4=;
  b=nS2emRl2u2nkxKounpqQQ321YdbW+ZKHQMAEABicSYpd6YMWv7AT92OK
   cfNG4oCgEcA5JgPzxuVqSLHdw8W2OSPswzi2j8PP5Ov+hPyjNdRqp+Tcd
   B5gbjSz3l4w60rt64Z8cHyAGscLCd+cRa9sUQLtKfdY/k6UlaXA9yBESN
   SLN8gwvsMH6I7J+5KnXmyAZQB8i7K2bo/LNQUzaly21mngY0kWMMjw0+W
   HhcJaKWhiLLmjg9Cfr8+0MzfvabPb4qHMxJeR7aIvvKxStlLzsiuGPTGe
   x8b8/ON+w8hetfZo+teJXezaoxcXQtJ+wMPZ1yYIycdBEiWgEd/58FS0a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="359619897"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="359619897"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 03:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="648370070"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="648370070"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Feb 2023 03:43:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTLdF-000CLl-2W;
        Sat, 18 Feb 2023 11:43:57 +0000
Date:   Sat, 18 Feb 2023 19:43:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS e686c32590f40bffc45f105c04c836ffad3e531a
Message-ID: <63f0b9ea.rqylXyCXNcIF9kF1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: e686c32590f40bffc45f105c04c836ffad3e531a  dax/kmem: Fix leak of memory-hotplug resources

elapsed time: 724m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                         haps_hs_defconfig
arc                  randconfig-r043-20230217
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                       multi_v4t_defconfig
arm                         nhk8815_defconfig
arm                            pleb_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                         debian-10.3-func
i386                   debian-10.3-kselftests
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                       m5208evb_defconfig
m68k                            mac_defconfig
m68k                        mvme147_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                 decstation_r4k_defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                         alldefconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                       maple_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230217
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230217
sh                               allmodconfig
sh                         ecovec24_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
xtensa                    xip_kc705_defconfig

clang tested configs:
arm                  randconfig-r046-20230217
hexagon              randconfig-r041-20230217
hexagon              randconfig-r045-20230217
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                      maltaaprp_defconfig
powerpc                   lite5200b_defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
