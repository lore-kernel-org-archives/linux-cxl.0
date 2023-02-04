Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F86C61DA4
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Feb 2023 19:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjBDTU6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Feb 2023 14:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBDTU6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 4 Feb 2023 14:20:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FC22781
        for <linux-cxl@vger.kernel.org>; Sat,  4 Feb 2023 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675538456; x=1707074456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Afid3zaFp4mpWRXkdxce1eCKZmyROBHMlXwaq+EaIvI=;
  b=OglWlUdQVqhnGhuvzWkXcAJDnO0b/ZEgicCcCxdWpFJuxgZbG7zmVDcy
   XBodjil3ahB3Mm3137wA66/xmg8I4r3OXJ8O7SGo9k5pn6HsqFfugLNQp
   k9fT5php7Elhp91BXKHvyjUrECmvpiX9OnlVJsdXa9QRyqgP+lkX5eSil
   6tMBPvMwodJY/Xefw7ZQaMjwNy6hFor2Ai8A4th5E1C/TppaJHGOqxnZw
   OTCJ7dn/FcELhhtMywi1nGhEkq2QSUlEfT4djqvVWxao0pCoW2WFNNj3P
   8e0sed3C5UF9bhVC65GyJZrVximw6JFJ3B6qkicdQ3aCHS9q1L4jFBUWc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="312636198"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="312636198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 11:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="754825743"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="754825743"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2023 11:20:54 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOO5m-0001Uq-0f;
        Sat, 04 Feb 2023 19:20:54 +0000
Date:   Sun, 5 Feb 2023 03:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 23/25] ERROR: modpost:
 "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!
Message-ID: <202302050349.g4NppVCy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   14acf2db2613dad48f315647c022b15e7dd7b7bd
commit: 1404bbe617dc40d32c8f7b772bb17f9309a33a26 [23/25] dax/hmem: Move hmem device registration to dax_hmem.ko
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230205/202302050349.g4NppVCy-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=1404bbe617dc40d32c8f7b772bb17f9309a33a26
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout 1404bbe617dc40d32c8f7b772bb17f9309a33a26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "walk_hmem_resources" [drivers/dax/hmem/dax_hmem.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
