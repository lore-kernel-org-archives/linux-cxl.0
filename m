Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF59C63703
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 16:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLGQHH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 11:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLGQHD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 11:07:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F04E405
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670429222; x=1701965222;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CgKkgAktmjhNwLGWPsTRz6970KRaUmJCxJe5G3v+Pgc=;
  b=PDIRX4BzdazpGEr+z+ZLC/KYZW/NgE9sXepLW+7eivVt9eORpegmdp7w
   VTGKcBBn2UGz8jV1KNNszVOSGTRevujk5HfHqDlMW7cs6UYcY0glPfuqv
   bzX3SN111mu+GXrRfbXnNt1RPSLaQAnvDJ+A/FitfY5ac/AMibHuWp3/8
   jrsXzRWhXJRcbS/GMUlBirB6kCwekCKBHjhcg8KMUMRSg9+lfxgeqoVkW
   H6jqK8EwjDYR3kcmRnbnjG116vdlcAjJlx1LLm8dDYeJmjOF0zNM5s88E
   xHEcpdNhjZZhsh8zF7zvnA/R8MdBN8tw1/PrYp4PGc+Zp2uwDvoSnYEsP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="300346070"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="300346070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710112028"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710112028"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 08:03:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2wt4-0000Nj-0I;
        Wed, 07 Dec 2022 16:03:10 +0000
Date:   Thu, 08 Dec 2022 00:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:for-6.2/cxl-fixes] BUILD SUCCESS
 9b5f77efb0dc71d95403b528756e39b6cae0b948
Message-ID: <6390b916.WYGSJCAKaKlfWYHI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.2/cxl-fixes
branch HEAD: 9b5f77efb0dc71d95403b528756e39b6cae0b948  cxl/pci: Remove endian confusion

elapsed time: 722m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                              defconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                               rhel-8.3
s390                             allyesconfig
i386                          randconfig-a016
sh                               allmodconfig
i386                          randconfig-a012
x86_64                           allyesconfig
x86_64                        randconfig-a004
ia64                             allmodconfig
i386                          randconfig-a001
m68k                             allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a003
powerpc                          allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
arc                              allyesconfig
x86_64                        randconfig-a011
alpha                            allyesconfig
i386                          randconfig-a005
arm                  randconfig-r046-20221206
arc                  randconfig-r043-20221206
arm                                 defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
mips                  decstation_64_defconfig
parisc64                         alldefconfig
parisc64                            defconfig
riscv                    nommu_k210_defconfig
i386                          randconfig-c001
arc                  randconfig-r043-20221207
riscv                randconfig-r042-20221207
s390                 randconfig-r044-20221207

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
s390                 randconfig-r044-20221206
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221206
hexagon              randconfig-r045-20221206
riscv                randconfig-r042-20221206
powerpc                  mpc866_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
