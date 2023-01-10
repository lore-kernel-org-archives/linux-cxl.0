Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6EBC54EBE
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 11:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjAJLaA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAJL37 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 06:29:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E81482B9
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673350198; x=1704886198;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v00mcTKsUSyoee+vPGjG7dMd/q8mFIs0JWjlbDmIv5U=;
  b=QOYD6yeWutc0jdeS9kOI75qUq6X1aBo6wKf4wmE0SGfDVz+1nDDvnxQY
   cisc0/5Hh75/J639bHx1/XUejgEcwSVBnO+9RK5VaESMiTtx9366/DbtA
   sFQFKR4fRD5wdmthMbgp/rponLzNozLiEL3kGR4W7iJqOCykZWh4ygbiT
   knKpvNzxzTU4AOTy+B71p1cmTC50HqodRZB9S5wgIeO/zojcBbOfdtN/F
   rPczAolvavEMoZMFLdAtbEwqurP/Q8T29y6gr4Van6KqFqh1NSmwgUl8e
   rNkhcfuNHr7bhpzSVMuDdE7utwmvSUHx1wo1RLX3kfarp5+P7kT1eQ78K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306635715"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306635715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 03:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="764703727"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="764703727"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2023 03:29:54 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFCpE-0007vA-1y;
        Tue, 10 Jan 2023 11:29:53 +0000
Date:   Tue, 10 Jan 2023 19:29:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 2ec1b17f745b08526220f3c169d2eb9799a9be39
Message-ID: <63bd4c1e.iuGgWkjslPsYeTXH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 2ec1b17f745b08526220f3c169d2eb9799a9be39  cxl: fix cxl_report_and_clear() RAS UE addr mis-assignment

elapsed time: 726m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
powerpc                          allmodconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
arc                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
ia64                             allmodconfig
x86_64               randconfig-a011-20230109
s390                                defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a013-20230109
i386                 randconfig-a011-20230109
x86_64               randconfig-a012-20230109
x86_64                           allyesconfig
x86_64               randconfig-a014-20230109
i386                 randconfig-a013-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a015-20230109
s390                             allyesconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20230109
x86_64                        randconfig-a004
mips                           jazz_defconfig
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
arc                         haps_hs_defconfig
i386                 randconfig-a014-20230109
x86_64                        randconfig-a006
arm64                            allyesconfig
sparc64                          alldefconfig
i386                 randconfig-a016-20230109
i386                 randconfig-a015-20230109
arm                              allyesconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
riscv                randconfig-r042-20230109
powerpc                         ps3_defconfig
sparc                            alldefconfig
sh                          polaris_defconfig
s390                 randconfig-r044-20230109
arm                             pxa_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
arm                  randconfig-r046-20230108
arm                           corgi_defconfig
arc                  randconfig-r043-20230108
arm                           sama5_defconfig
arc                  randconfig-r043-20230109
arm64                               defconfig
i386                        debian-10.3-kunit
powerpc                     asp8347_defconfig
i386                         debian-10.3-func
xtensa                    xip_kc705_defconfig
i386                          debian-10.3-kvm
i386                          randconfig-c001

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230109
x86_64                        randconfig-a005
arm                  randconfig-r046-20230109
x86_64                        randconfig-a001
riscv                randconfig-r042-20230108
x86_64                        randconfig-a003
mips                      pic32mzda_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
i386                 randconfig-a005-20230109
hexagon              randconfig-r045-20230108
i386                 randconfig-a004-20230109
s390                 randconfig-r044-20230108
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a006-20230109
mips                     loongson1c_defconfig
i386                 randconfig-a001-20230109
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
