Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE707C38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjA1JT3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 04:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1JT2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 04:19:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA1EC55
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674897567; x=1706433567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GVkFWyIFZyRuaRyCHcCfTgVVzC0XccS2Uz+UtiUvK3A=;
  b=jPaqN46k5j6dvig8i6byGecY7JQPcYrITp9Z0vgqvzzr1HtTuxrX56S3
   RL6CMtmh36sQBuBbHh0OnL6JL1qN3KtyQfSOo71GdceB5Wx9PEzpp3Rf5
   uYu1fMhR+7hob/nh9QYeYeqAtU6mVneZMY0yi2O3/zeQ3fNxy5pVWnCz0
   wH7JHXle/OIYLCKwkueT4A6459Zf5iRxFK+iyOvlWMlhbGjcYGQGwS5t2
   3PeODuOEB4tJTSV4tmMxwsGSyXYq+7N5m3CS2qqzPW1aM+kgK/FhagnLm
   nJwJ8lon78Fq7IbnHk+WNmiWBvuj6dh3UqRCEqU/ixe0B6Llcba1xvyZL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391831891"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391831891"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 01:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693985708"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="693985708"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2023 01:19:25 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLhMq-0000Y9-1P;
        Sat, 28 Jan 2023 09:19:24 +0000
Date:   Sat, 28 Jan 2023 17:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 17/18] ERROR: modpost:
 "cxl_add_to_region" [drivers/cxl/cxl_port.ko] undefined!
Message-ID: <202301281707.ZLMJGwlz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   a7cf664d7e997ac36b0f466af2e2be33464ab598
commit: 3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f [17/18] cxl/region: Add region autodiscovery
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230128/202301281707.ZLMJGwlz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout 3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "is_endpoint_decoder" [drivers/cxl/cxl_port.ko] undefined!
>> ERROR: modpost: "cxl_add_to_region" [drivers/cxl/cxl_port.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
