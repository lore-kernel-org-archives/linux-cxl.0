Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDCC636BD
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjA1OWj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjA1OWi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 09:22:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9508624105
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674915757; x=1706451757;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ov9q4ataMh/8H65OLQynuwMRhdxThM/6VxM4zfT596M=;
  b=Qp1ifYXNNr8E/a4iUA+RAQvVIbulNnhehTnBwX9T4/SDGWy1Qc9vKaH9
   VjS+h0qPp0u9iHlaOWRTuIRCAn899zLfKjnMxG9m4wrL41Mr7vF0N/iEc
   0KrTA8v3nvfgWLbc9pjCq5Qce44M9NhgXURd2AGVJ8ZTahcpcyHr9Tz0M
   belD+loWBGRu1oRapJd0WoUWq1pKopxHuWwi1DeDPNmUHbKYkbpwt83kq
   g0JH7sAstLg1athaQc1Yw1m/N336g0p9eMcZnyeCK92GsqvJpuDVNvQfF
   gYFbRM8MMcgOJ1jFinmSDC8eEP8hFiJsAdJMTJf79c8qLTpfRU7LOTKju
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389672816"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="389672816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641037437"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641037437"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 06:22:33 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLm6C-0000jo-1H;
        Sat, 28 Jan 2023 14:22:32 +0000
Date:   Sat, 28 Jan 2023 22:22:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [cxl:fixes] BUILD SUCCESS
 19398821b25a9cde564265262e680ae1c2351be7
Message-ID: <63d52f99.KP0ncWG5/NngcliZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 19398821b25a9cde564265262e680ae1c2351be7  cxl/pmem: Fix nvdimm unregistration when cxl_pmem driver is absent

elapsed time: 737m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
arm                                 defconfig
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
arc                  randconfig-r043-20230123
i386                                defconfig
arm                  randconfig-r046-20230123
ia64                             allmodconfig
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a002-20230123
x86_64                              defconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a001-20230123
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a004-20230123
mips                             allyesconfig
x86_64               randconfig-a003-20230123
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a005-20230123
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a006-20230123
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
riscv                randconfig-r042-20230123
i386                 randconfig-a011-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
