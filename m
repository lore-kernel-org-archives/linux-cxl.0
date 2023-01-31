Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A1C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 05:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAaFHm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 00:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaFHl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 00:07:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F8F29173
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 21:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675141660; x=1706677660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=34z+6kRXUbFr/9eQ+vAivH1RVhZIaxh+OjtYFgiOp2Q=;
  b=iCREFjxeu64Q9MXWiwHmesYyN1J7Wl4v3K5W49R6NvC8gwvOPp+7YWG8
   Oq7GINOBhHUIjLtkkeqx0EZyuKBNAtEO11xA5wSIeAjHlYNIbkDfCnXuy
   1M2i68jHLP6oR8Vgs+7ArKALfe9ssER3LNV1voO4r7EUwW6zBFN5FODqd
   dGyjD7ojByvs9r1HbaxqgrzSlE4ZIzCYQrxBQX2vs5P46vQmF1WmlPQA0
   6okTkJ1M7+eZ1t5szNYFWO4ri1ZiacspWcQqZEDTddNu3djmhNDFVzfWT
   /M4fSkfGEyKnnPjyvRp7s29OUSUHAMrgUvU2Kvmjql3sgU8ay1dPdrZyv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392300276"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="392300276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 21:07:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="993137537"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="993137537"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2023 21:07:37 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMiro-0004C6-2R;
        Tue, 31 Jan 2023 05:07:36 +0000
Date:   Tue, 31 Jan 2023 13:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 17/17] ld.lld: error: undefined symbol:
 cxl_add_to_region
Message-ID: <202301311303.f3BvWCnS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   f71922e583ef6b6e17575c87e496b17f91193d37
commit: f71922e583ef6b6e17575c87e496b17f91193d37 [17/17] cxl/region: Add region autodiscovery
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230131/202301311303.f3BvWCnS-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=f71922e583ef6b6e17575c87e496b17f91193d37
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout f71922e583ef6b6e17575c87e496b17f91193d37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cxl_add_to_region
   >>> referenced by port.c:45 (drivers/cxl/port.c:45)
   >>>               drivers/cxl/port.o:(discover_region) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
