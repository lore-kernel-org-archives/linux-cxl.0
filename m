Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8405C636CB
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 14:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjA1OYj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 09:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjA1OYi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 09:24:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB001BE8
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 06:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674915877; x=1706451877;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KdBQXzczus19e9OaTQ0zI6GBIH6B8knzQC1uWnL3NQk=;
  b=DftZq4tbq7hqT2OrJwwAa822MEhgNfbbYz4fVIcVqgHM3yWOoip/znkg
   Gf67VImd/xFBTvrXiiAsdu0WyvSv7GQpUTMJyX8svqC8bzcfAnoFf9O9g
   Du0tgDxTawVdURREmLGhq1puwkUEm4Q2Vthc5HvPO1txm6j/0q8evJLzv
   by00LH5fuF++whhlEuiChBho7gmfG6eAyq13THyk8ShHhy7f/gnob/PvS
   nZEsZP2g9oqQfFuZXTKnlcuCmJpOsKbs8IYYD+fxQ2iuOIU/mPznUT8zy
   q465sbbKnDzhLU7l3KK9wr/3kCmEXdtm58BA+RirxHgnyD0NGSXn3L8JV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="391848048"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="391848048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="908982177"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="908982177"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 06:24:34 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLm89-0000mO-1o;
        Sat, 28 Jan 2023 14:24:33 +0000
Date:   Sat, 28 Jan 2023 22:24:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.3/cxl-ram-region] BUILD REGRESSION
 a7cf664d7e997ac36b0f466af2e2be33464ab598
Message-ID: <63d53009.e1q5ns0tAYsZhYTG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
branch HEAD: a7cf664d7e997ac36b0f466af2e2be33464ab598  tools/testing/cxl: Define a fixed volatile configuration to parse

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202301281148.CS4njyXr-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281217.NvoiwL4w-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281313.kVrIreUj-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281329.fAZb07Lx-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281339.j8qhil5k-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281643.cInr5zLC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281707.ZLMJGwlz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202301281924.bar72HY6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "cxl_add_to_region" [drivers/cxl/cxl_port.ko] undefined!
drivers/cxl/core/region.c:1479:21: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
drivers/cxl/core/region.c:1479:7: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
drivers/cxl/core/region.c:1482:7: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/cxl/core/region.c:1772:21: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
drivers/cxl/core/region.c:1772:7: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
drivers/cxl/core/region.c:1775:7: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/cxl/core/region.c:2404:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
drivers/cxl/port.c:47: undefined reference to `cxl_add_to_region'
ld.lld: error: undefined symbol: cxl_add_to_region
lib/stackinit_kunit.c:333:1: error: too many arguments to function call, expected 2, have 4
lib/stackinit_kunit.c:34:13: error: conflicting types for 'range_contains'
lib/stackinit_kunit.c:34:13: error: conflicting types for 'range_contains'; have 'bool(char *, size_t,  char *, size_t)' {aka '_Bool(char *, long unsigned int,  char *, long unsigned int)'}
lib/stackinit_kunit.c:34:13: error: conflicting types for 'range_contains'; have 'bool(char *, size_t,  char *, size_t)' {aka '_Bool(char *, unsigned int,  char *, unsigned int)'}
port.c:(.text+0x1e4): undefined reference to `cxl_add_to_region'
port.c:(.text+0x68): undefined reference to `cxl_add_to_region'
port.c:(.text.discover_region+0x84): undefined reference to `cxl_add_to_region'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- alpha-randconfig-r024-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- arm-allyesconfig
|   `-- port.c:(.text):undefined-reference-to-cxl_add_to_region
|-- arm64-allyesconfig
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- i386-allyesconfig
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-unsigned-int-char-unsigned-int)
|-- i386-buildonly-randconfig-r003-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- i386-randconfig-c001-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- ia64-allmodconfig
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- ia64-randconfig-m041-20230123
|   `-- drivers-cxl-port.c:undefined-reference-to-cxl_add_to_region
|-- loongarch-allmodconfig
|   |-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- mips-allyesconfig
|   `-- port.c:(.text.discover_region):undefined-reference-to-cxl_add_to_region
|-- powerpc-allmodconfig
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
|-- s390-allmodconfig
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- s390-allyesconfig
|   |-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- s390-randconfig-r001-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- s390-randconfig-r005-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- s390-randconfig-r036-20230123
|   |-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- sparc-allyesconfig
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- sparc64-randconfig-c44-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- x86_64-buildonly-randconfig-r005-20230123
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
|-- x86_64-randconfig-a001-20230123
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- x86_64-rhel-8.3-kunit
|   `-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains-have-bool(char-size_t-char-size_t)-aka-_Bool(char-long-unsigned-int-char-long-unsigned-int)
clang_recent_errors
|-- i386-randconfig-a012-20230123
|   |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-true
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- i386-randconfig-a013-20230123
|   `-- ERROR:cxl_add_to_region-drivers-cxl-cxl_port.ko-undefined
|-- riscv-randconfig-r042-20230123
|   `-- ld.lld:error:undefined-symbol:cxl_add_to_region
|-- s390-randconfig-r016-20230125
|   |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
|   |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-true
|   `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used
|-- s390-randconfig-r026-20230123
|   |-- lib-stackinit_kunit.c:error:conflicting-types-for-range_contains
|   `-- lib-stackinit_kunit.c:error:too-many-arguments-to-function-call-expected-have
`-- x86_64-randconfig-r021-20230123
    |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-false
    |-- drivers-cxl-core-region.c:warning:variable-rc-is-used-uninitialized-whenever-if-condition-is-true
    `-- drivers-cxl-core-region.c:warning:variable-rc-set-but-not-used

elapsed time: 738m

configs tested: 105
configs skipped: 3

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arm                                 defconfig
arc                                 defconfig
x86_64               randconfig-a002-20230123
powerpc                           allnoconfig
x86_64               randconfig-a001-20230123
alpha                               defconfig
x86_64               randconfig-a004-20230123
m68k                             allmodconfig
ia64                             allmodconfig
x86_64               randconfig-a003-20230123
arc                              allyesconfig
x86_64               randconfig-a005-20230123
alpha                            allyesconfig
x86_64               randconfig-a006-20230123
m68k                             allyesconfig
arc                  randconfig-r043-20230123
x86_64                              defconfig
arm                  randconfig-r046-20230123
arm                              allyesconfig
arm64                            allyesconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                               rhel-8.3
i386                 randconfig-a003-20230123
powerpc                          allmodconfig
mips                             allyesconfig
i386                 randconfig-a002-20230123
x86_64                         rhel-8.3-kunit
s390                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                           rhel-8.3-bpf
i386                 randconfig-a001-20230123
s390                             allmodconfig
x86_64                           rhel-8.3-syz
s390                             allyesconfig
i386                 randconfig-a005-20230123
i386                             allyesconfig
openrisc                       virt_defconfig
arm                           imxrt_defconfig
i386                 randconfig-a006-20230123
arm                          iop32x_defconfig
i386                 randconfig-a004-20230123
alpha                            alldefconfig
sh                        dreamcast_defconfig
arm64                            alldefconfig
arm                           corgi_defconfig
xtensa                    smp_lx200_defconfig
mips                           ip32_defconfig
nios2                         3c120_defconfig
i386                 randconfig-c001-20230123
parisc                              defconfig
loongarch                         allnoconfig
powerpc                      ep88xc_defconfig
riscv                             allnoconfig
nios2                               defconfig
arm                            xcep_defconfig
csky                                defconfig
arm                             pxa_defconfig
mips                     decstation_defconfig
riscv                    nommu_virt_defconfig
sparc                               defconfig
riscv                    nommu_k210_defconfig
parisc64                            defconfig
x86_64                                  kexec
nios2                            allyesconfig
riscv                          rv32_defconfig
i386                              debian-10.3
parisc                           allyesconfig
loongarch                           defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          debian-10.3-kvm
riscv                               defconfig
sparc                            allyesconfig
xtensa                           allyesconfig
loongarch                        allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
i386                 randconfig-a015-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
i386                 randconfig-a016-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
mips                        maltaup_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         palmz72_defconfig
powerpc                    gamecube_defconfig
x86_64               randconfig-k001-20230123
arm                           omap1_defconfig
powerpc                          allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
