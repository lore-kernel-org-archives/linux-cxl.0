Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03572C05027
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Feb 2023 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBFNfG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Feb 2023 08:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBFNfE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Feb 2023 08:35:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A05C1
        for <linux-cxl@vger.kernel.org>; Mon,  6 Feb 2023 05:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675690503; x=1707226503;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UR1Lu1rrgVfY89oNUzt+CBFDIFhYEaXv4U1nf6mRjJo=;
  b=ZvU2uO5I70UrRSIb5VfEy6nbH9dyygg7OCeClXFJ5m5UGatSI4XnSSF3
   pSk22/gDih1IXkJsbrFE5S9Dyhncc8QuPZBKw4PWWzkIeEnug92boZz4h
   nDE1bfH3aWQ4C4XblG7OQvvEGCtgGPLgdqgwBB3f9Ab6Td7r7ye6l/AOY
   4TVIgd/HwZE495XLsS9N1+/INPtjEe37+9/WD6skSEvRRvI/ez5iAC07R
   P7EhgmSyFFDlXyW2a298dUoXvW7it+RJeMKgriKb4tGVQBxtJpZPuSdnJ
   mYiEGfm1LhQcKz4d5Gt0k7k0rFYpdXFFL8hVEnhvGm6IUi/M9HQz8uz7i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="327838095"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327838095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 05:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="730008953"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="730008953"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2023 05:34:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP1e6-0002Yu-13;
        Mon, 06 Feb 2023 13:34:58 +0000
Date:   Mon, 06 Feb 2023 21:33:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD REGRESSION
 665cfd1aff915a3c33685b313dacfa00809f9a85
Message-ID: <63e101c7.r1+eX/6UK7xD/a0Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: 665cfd1aff915a3c33685b313dacfa00809f9a85  cxl/dax: Create dax devices for CXL RAM regions

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302050349.g4NppVCy-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- loongarch-allmodconfig
    `-- ERROR:walk_hmem_resources-drivers-dax-hmem-dax_hmem.ko-undefined

elapsed time: 725m

configs tested: 100
configs skipped: 3

gcc tested configs:
powerpc                           allnoconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
arm                                 defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                                 defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
i386                 randconfig-a011-20230206
alpha                               defconfig
i386                 randconfig-a014-20230206
x86_64                           allyesconfig
i386                 randconfig-a016-20230206
s390                                defconfig
i386                 randconfig-a013-20230206
arm64                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a014-20230206
x86_64               randconfig-a013-20230206
csky                                defconfig
riscv                randconfig-r042-20230204
x86_64               randconfig-a011-20230206
m68k                             allmodconfig
s390                 randconfig-r044-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a012-20230206
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
mips                             allyesconfig
sparc                               defconfig
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
x86_64               randconfig-a016-20230206
m68k                             allyesconfig
s390                 randconfig-r044-20230204
arc                              allyesconfig
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20230206
alpha                            allyesconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
x86_64                                  kexec
loongarch                         allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
parisc                              defconfig
arm                          badge4_defconfig
powerpc                 canyonlands_defconfig
nios2                               defconfig
sh                 kfr2r09-romimage_defconfig
arm                       multi_v4t_defconfig
csky                             alldefconfig
sh                        sh7763rdp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
parisc64                            defconfig
loongarch                           defconfig
powerpc                     redwood_defconfig
arc                      axs103_smp_defconfig
m68k                        m5307c3_defconfig
powerpc                     tqm8541_defconfig
riscv                               defconfig
loongarch                        allmodconfig

clang tested configs:
x86_64               randconfig-a001-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
hexagon              randconfig-r045-20230206
x86_64               randconfig-a003-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
x86_64                          rhel-8.3-rust
i386                 randconfig-a002-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
x86_64                        randconfig-k001
i386                 randconfig-a006-20230206
arm                         lpc32xx_defconfig
arm                       aspeed_g4_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
