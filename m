Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF988C38142
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBAA0g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 19:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBAA0f (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 19:26:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F023D83
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 16:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675211194; x=1706747194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9jA05kZuOK5q0m+oLderwH5f8b3rkG6mbHVH8xjbwvE=;
  b=dBG4A/MIMMdBdXAN0vt6uWZE/NytERxuTtK7XSvvyo5AFM5xIxaf/a/g
   pMRDC9MwDLEunNc3JPifUsAUpvExaITZ5cQvt0p7DAo2w9SG1/9MG9KLi
   tumiKNyBqz5auYkRvUMXVmrZQcYRomk2+eIkjgyBP0+urRCu3LYFMUk6N
   cBNRFRMzBWtc+pOgWSif/NDw722Jq7bgquvdaLJX9R6Qf6pXgHjvjpQCF
   CXvYG9NmnuSPJc+YBdopEYzziHrclqMNPYBtt+Rbm2R6oh8ffEk8ucWHR
   a6P/ySOH9nJ9okSXoMmbQ94jouoxCwaP9erKCyFnB/HRBNS7KT8zYvyTH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308344618"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308344618"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 16:26:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910107545"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="910107545"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 16:26:32 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN0xL-0004q7-1S;
        Wed, 01 Feb 2023 00:26:31 +0000
Date:   Wed, 1 Feb 2023 08:26:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 17/18] arceb-elf-ld: port.c:undefined
 reference to `cxl_add_to_region'
Message-ID: <202302010823.qvzx7Yf8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   c30a50b37b7808284c3796e0866e939017bb05b2
commit: f71922e583ef6b6e17575c87e496b17f91193d37 [17/18] cxl/region: Add region autodiscovery
config: arc-buildonly-randconfig-r004-20230130 (https://download.01.org/0day-ci/archive/20230201/202302010823.qvzx7Yf8-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=f71922e583ef6b6e17575c87e496b17f91193d37
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout f71922e583ef6b6e17575c87e496b17f91193d37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: drivers/cxl/port.o: in function `discover_region':
   port.c:(.text+0x9c): undefined reference to `cxl_add_to_region'
>> arceb-elf-ld: port.c:(.text+0x9c): undefined reference to `cxl_add_to_region'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
