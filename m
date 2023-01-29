Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA60FC05027
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Jan 2023 12:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjA2MBT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 29 Jan 2023 07:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2MBR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 29 Jan 2023 07:01:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15D126D6
        for <linux-cxl@vger.kernel.org>; Sun, 29 Jan 2023 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674993675; x=1706529675;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S7T9p5gIecojfMSKAFiaSjn0gvGrONu4/L5DmdzVOKo=;
  b=EMA65vfFzvcPmh974OFiA8Vd0kceZhWMZh1IGHUHq2SAAXQk53tJKve8
   eswC1M6YR+oloraalkl1/KFMKRPpk3c5hFNizv23ysA/AwOoVnpxGFgV8
   iKBWLy9dgpFFto29NpLcoVhztxtyNOYGpdp6QLzu/S72TBvy93PRySz9u
   mvngHW+v/2E5LcsUJ5zL0v3MEjDEYvaQTmgPJi7rt3fef00LoOGs+fr08
   ID5wpR3+ALN2zmC9AQT0eFZHMV8hKn1L5yKozWdicXqWR5dRLkJRVG8ms
   tnsZx7SJJ/bjU4NTBR7BisU6aho25qwnVpYVsJjmIvjJRfBerHTtSPxIg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389768608"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="389768608"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 04:01:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="837680280"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="837680280"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2023 04:01:12 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM6Ms-0002mk-1F;
        Sun, 29 Jan 2023 12:01:06 +0000
Date:   Sun, 29 Jan 2023 20:00:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:next] BUILD SUCCESS 623c0751336e4035ab0047f2c152a02bd26b612b
Message-ID: <63d65fe9.l9TnlgpcChpBasMr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 623c0751336e4035ab0047f2c152a02bd26b612b  cxl/mbox: Fix Payload Length check for Get Log command

elapsed time: 723m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
i386                          randconfig-a005
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
m68k                             allyesconfig
i386                          randconfig-a003
m68k                             allmodconfig
i386                          randconfig-a016
i386                                defconfig
arc                                 defconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
powerpc                           allnoconfig
x86_64                           allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a013
s390                             allmodconfig
x86_64                        randconfig-a011
ia64                             allmodconfig
arm                                 defconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
alpha                               defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
arm64                            allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a012
x86_64                          rhel-8.3-func
m68k                       m5208evb_defconfig
sh                               allmodconfig
powerpc                      pcm030_defconfig
xtensa                       common_defconfig
sh                          r7785rp_defconfig
i386                             allyesconfig
powerpc                      tqm8xx_defconfig
sh                           sh2007_defconfig
sh                              ul2_defconfig
xtensa                  audio_kc705_defconfig
parisc                              defconfig
powerpc                    amigaone_defconfig
sh                         apsh4a3a_defconfig
mips                           ci20_defconfig
riscv                             allnoconfig
nios2                               defconfig
sh                        sh7763rdp_defconfig
riscv                    nommu_virt_defconfig
sh                         microdev_defconfig
i386                          randconfig-c001
riscv                    nommu_k210_defconfig
arc                        nsim_700_defconfig
sh                             shx3_defconfig
sh                           se7751_defconfig
mips                           jazz_defconfig
m68k                           virt_defconfig
csky                                defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
parisc64                            defconfig
sparc                               defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
x86_64                        randconfig-c001
i386                         debian-10.3-func
loongarch                        allmodconfig
x86_64                                  kexec
arm                  randconfig-c002-20230129
riscv                               defconfig

clang tested configs:
hexagon              randconfig-r045-20230129
x86_64                        randconfig-a001
riscv                randconfig-r042-20230129
x86_64                        randconfig-a003
s390                 randconfig-r044-20230129
hexagon              randconfig-r041-20230129
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                          rhel-8.3-rust
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                   lite5200b_defconfig
powerpc                     tqm8540_defconfig
arm                     am200epdkit_defconfig
arm                       versatile_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc836x_rdk_defconfig
arm64                            allyesconfig
x86_64                        randconfig-k001
powerpc                          allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
