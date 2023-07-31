Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B05C001DC
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Jul 2023 05:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGaFEQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jul 2023 01:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaFEP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jul 2023 01:04:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8741BF
        for <linux-cxl@vger.kernel.org>; Sun, 30 Jul 2023 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690779854; x=1722315854;
  h=date:from:to:cc:subject:message-id;
  bh=BXnFWXXKeItgMihbwPhsoBGvYUJCD8XV4Yt408gjiXg=;
  b=kqj2L5WE6NqqBZ0OoZrfxffFtOKSjm3CI4QrqXZUTwdK2G2fV5NyPjlO
   CmpiSSHAsZLF4pBu+gB1M8PSaxXtAGiJ5HHBk9YyWBvXVSk++Rs3Y6jql
   6hprCrhHjYswNmI64JuOLBXwZavNm2UUILHLfTkVmzDlWGFn2xPb6xuWu
   j2Jfe1Mqmvq7mDDmKTPoG8QhaFLGz6/HVhb9tUMqyHS550QsHo3depnie
   F46fLz7KTgOjxPfOGH5zIaHO8v4AobPbzSL5F5rlgGjtlpHlsnrWd1Val
   viqexh6tJtcqG5hdWCZzkU+hdJx59Kn4XA5SXj7vAuAKoPAXOzU4vNyzu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399868501"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="399868501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 22:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="757809447"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="757809447"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2023 22:04:07 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQL4Q-0004wN-0T;
        Mon, 31 Jul 2023 05:03:53 +0000
Date:   Mon, 31 Jul 2023 13:03:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 c4b53e8ad3a7452392f3ecd882f06f3416a021e0
Message-ID: <202307311334.HJr6uuow-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: c4b53e8ad3a7452392f3ecd882f06f3416a021e0  cxl/region: Remove else after return statement

elapsed time: 720m

configs tested: 123
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230731   gcc  
arc                  randconfig-r014-20230731   gcc  
arc                  randconfig-r043-20230730   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                  randconfig-r046-20230730   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230730   clang
arm64                randconfig-r016-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r034-20230730   gcc  
hexagon              randconfig-r035-20230730   clang
hexagon              randconfig-r041-20230730   clang
hexagon              randconfig-r045-20230730   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-r002-20230730   clang
i386                 randconfig-r024-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r015-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                 randconfig-r022-20230731   gcc  
mips                 randconfig-r032-20230730   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r036-20230730   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r003-20230730   gcc  
parisc               randconfig-r026-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r006-20230730   clang
riscv                randconfig-r025-20230731   clang
riscv                randconfig-r042-20230730   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230731   clang
s390                 randconfig-r044-20230730   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r033-20230730   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r012-20230731   gcc  
xtensa               randconfig-r013-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
