Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B46C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiLBJvU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 04:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiLBJvL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 04:51:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B984CAF89
        for <linux-cxl@vger.kernel.org>; Fri,  2 Dec 2022 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669974671; x=1701510671;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tlDVujS2qA+eWTgiZoXp077R0NGtRnLNt7r9ck+7Uq0=;
  b=mQnZbOtXi/khn1LNsSW8RfMi+YkFq7AOOO4+LaoP3UpdBS1RTwX3w7r8
   83ty8L0WAXwNYpqPWH3AXEYL6zSqLb+Ajw+emAm2VichuIgp/zI08XjHR
   FRpjmtlAzFMlX7kGRS1OyUeZrgbI4S9PscAZ/xkYQ4Mpsl2Ec3k5yuW15
   KocFTg1w9JI9xKYZqCoAUAw4BzQglCI9U1TDC672mxsuRkaiazadmIcfr
   1x9DdYxt0e9JHjVU29Qck0phQ6GXHMARl2pP5oQPOnY2BcXZN94PyXTc1
   zb3uUm7FnIUFtGdrAcdhsYrHnYJKQPPJAzLh7VY8QgZCNUgje25fJcH7F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313561478"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="313561478"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 01:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769560189"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="769560189"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2022 01:51:08 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p12hH-000DVh-1n;
        Fri, 02 Dec 2022 09:51:07 +0000
Date:   Fri, 02 Dec 2022 17:51:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-rch] BUILD SUCCESS
 d8830bcf806092b93c45585c7020aff5a57a8d45
Message-ID: <6389ca85.Q/mKOPtFbdXRsdGw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-rch
branch HEAD: d8830bcf806092b93c45585c7020aff5a57a8d45  cxl/acpi: Set ACPI's CXL _OSC to indicate RCD mode support

elapsed time: 724m

configs tested: 85
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                                 defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
arm                                 defconfig
i386                          randconfig-a012
powerpc                          allmodconfig
i386                          randconfig-a016
ia64                             allmodconfig
x86_64                            allnoconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                        randconfig-a015
s390                             allmodconfig
x86_64                        randconfig-a002
sh                               allmodconfig
x86_64                              defconfig
s390                                defconfig
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                        randconfig-a004
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a001
alpha                            allyesconfig
s390                             allyesconfig
arc                              allyesconfig
i386                          randconfig-a003
arc                  randconfig-r043-20221201
i386                          randconfig-a005
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
sh                   sh7770_generic_defconfig
arc                        vdk_hs38_defconfig
parisc64                            defconfig
i386                          randconfig-c001
x86_64                        randconfig-c001
microblaze                      mmu_defconfig
xtensa                  cadence_csp_defconfig
parisc                           alldefconfig
arm                  randconfig-c002-20221201
riscv                             allnoconfig
arm                             rpc_defconfig
riscv                    nommu_virt_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
xtensa                    xip_kc705_defconfig
riscv                          rv32_defconfig
i386                              debian-10.3
csky                                defconfig
loongarch                         allnoconfig
sparc                               defconfig
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r041-20221201
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221201
mips                      maltaaprp_defconfig
powerpc                      acadia_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
