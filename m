Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC5AC636CC
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 08:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBHItD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 03:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBHItC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 03:49:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACBD45893
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675846140; x=1707382140;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XEHNEtxzclmir05S0GOE52sG9+/Kg7LVpk5BCjLAI0s=;
  b=nm1NO8M93rNL3umqAfTgbe7B3pOe/+1zzZ6kSCwPMrFZR0sJx81DCRRi
   p1hxTBhRMpmd+9u6mLLv4PwxArTT0DC3D+FADlk7iKCJfle4B10yDGMEV
   fLk8Pk//IqYHiw6P23p9YZO5xHrZdSaO9FudtjkJ83Q60GrjcqW/N8inH
   DwlDSWBIeWWUa+ZMnxqL3B2BjNm1N8WTptHSp6yMifcnTToT4mRGKA/Jw
   h6DFeETsHS3YQKRiAQYUzI4STbPlsC75jAO9sGdIObuotSyvrdSgpkwU+
   J2qEG6TLM8X+qrAnV0MZ5j07hKNREvZUrNdop4iAKABSt2ObdrZPdSArq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="327441667"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="327441667"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735857151"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="735857151"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 00:48:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPg8P-0004Kw-20;
        Wed, 08 Feb 2023 08:48:57 +0000
Date:   Wed, 08 Feb 2023 16:48:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:pending] BUILD SUCCESS
 3ad0b8d3a98e8c657ad713eca5f4efbb569fc4fd
Message-ID: <63e361ea.PzfaQbUJ82ubuL3G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
branch HEAD: 3ad0b8d3a98e8c657ad713eca5f4efbb569fc4fd  Merge branch 'for-6.3/cxl-ram-region' into cxl/pending

Unverified Warning (likely false positive, please contact us if interested):

drivers/cxl/core/region.c:1357:5: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm-randconfig-p002-20230205
    `-- drivers-cxl-core-region.c:warning:Redundant-initialization-for-rc-.-The-initialized-value-is-overwritten-before-it-is-read.-redundantInitialization

elapsed time: 725m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a013-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a012-20230206
arc                                 defconfig
s390                             allmodconfig
x86_64               randconfig-a013-20230206
alpha                               defconfig
i386                 randconfig-a014-20230206
x86_64                              defconfig
x86_64               randconfig-a011-20230206
i386                 randconfig-a016-20230206
x86_64               randconfig-a012-20230206
i386                 randconfig-a015-20230206
arm                            hisi_defconfig
s390                                defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
ia64                             allmodconfig
nios2                            alldefconfig
s390                             allyesconfig
parisc64                            defconfig
x86_64               randconfig-a014-20230206
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
mips                  maltasmvp_eva_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a015-20230206
x86_64                           rhel-8.3-syz
i386                                defconfig
sparc                            alldefconfig
x86_64               randconfig-a016-20230206
sh                           sh2007_defconfig
powerpc                          allmodconfig
alpha                            allyesconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                      ppc40x_defconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
ia64                         bigsur_defconfig
arc                              allyesconfig
m68k                             allyesconfig
arm                                 defconfig
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
mips                          rb532_defconfig
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                        cerfcube_defconfig
ia64                             alldefconfig
i386                          randconfig-c001
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
nios2                               defconfig
parisc                              defconfig
loongarch                         allnoconfig
csky                                defconfig
sparc                               defconfig
x86_64                                  kexec
loongarch                           defconfig

clang tested configs:
mips                           ip22_defconfig
mips                        bcm63xx_defconfig
x86_64                          rhel-8.3-rust
arm                          pcm027_defconfig
i386                 randconfig-a002-20230206
powerpc                  mpc885_ads_defconfig
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
hexagon              randconfig-r041-20230205
i386                 randconfig-a001-20230206
riscv                randconfig-r042-20230205
i386                 randconfig-a006-20230206
i386                 randconfig-a005-20230206
hexagon              randconfig-r045-20230206
arm                      tct_hammer_defconfig
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a006-20230206
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
