Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F7C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiLBJwW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 04:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiLBJwN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 04:52:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C1CA7A9
        for <linux-cxl@vger.kernel.org>; Fri,  2 Dec 2022 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669974731; x=1701510731;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yWHdKKcvvXgWyDFdPFoapFLW1B/ceKwUyHrYRqONzsE=;
  b=HTdYyjmF/faDJG4TjQGbAG1tcSTIzN1D9twqUh0VV7vs5INcW1FGbKzs
   5ErH9aLbTkwc8LqmH6tefwH02BTSB81bu8OVHk0RWM3N7LA7G6qD5PgOW
   w9thDS23H8o4kLhc47L9oOElIOtgN2j48ppXI8O2Vmb/Y/uKuHZBC6RQR
   Cnr3ARmM2jQiKYtbmMQQ9f7xSKH8hcfenYWUqYmaJGDUkSozRHhBb7gtE
   A3a9JfK7BqYbKhLGQZ7kYweCbXxoBv5Ua2pA/7OQoAkDDQvmtp5IiM0jG
   HChriH4w/xO7Pji47g558fyAoY+HTs/5ky/3c8gYFe7BKrcMdSF29GEb0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342856729"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342856729"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 01:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644978288"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="644978288"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 01:52:08 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p12iF-000DVs-26;
        Fri, 02 Dec 2022 09:52:07 +0000
Date:   Fri, 02 Dec 2022 17:51:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-security] BUILD SUCCESS
 15a8348707ffd2a37516db9bede88cc0bb467e0b
Message-ID: <6389ca8b.cTlSSppx6vMGzuqS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-security
branch HEAD: 15a8348707ffd2a37516db9bede88cc0bb467e0b  libnvdimm: Introduce CONFIG_NVDIMM_SECURITY_TEST flag

elapsed time: 723m

configs tested: 91
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
x86_64                        randconfig-a013
riscv                randconfig-r042-20221201
x86_64                        randconfig-a011
x86_64                            allnoconfig
x86_64                        randconfig-a015
arc                                 defconfig
arm                                 defconfig
i386                          randconfig-a014
ia64                             allmodconfig
x86_64                        randconfig-a002
x86_64                              defconfig
i386                          randconfig-a012
x86_64                        randconfig-a006
s390                             allmodconfig
i386                                defconfig
i386                          randconfig-a016
x86_64                        randconfig-a004
alpha                               defconfig
i386                          randconfig-a001
s390                                defconfig
sh                               allmodconfig
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
arc                              allyesconfig
arm64                            allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
nios2                         3c120_defconfig
arm                        trizeps4_defconfig
loongarch                         allnoconfig
m68k                       m5249evb_defconfig
arc                               allnoconfig
mips                         cobalt_defconfig
sh                          rsk7201_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
arm                             ezx_defconfig
microblaze                          defconfig
x86_64                        randconfig-c001
riscv                               defconfig
riscv                             allnoconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
arm                  randconfig-c002-20221201
riscv                          rv32_defconfig
i386                              debian-10.3
csky                                defconfig
sparc                               defconfig
x86_64                                  kexec
i386                         debian-10.3-func
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit

clang tested configs:
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                      acadia_defconfig
mips                      maltaaprp_defconfig
arm                          pxa168_defconfig
riscv                             allnoconfig
arm                       spear13xx_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
