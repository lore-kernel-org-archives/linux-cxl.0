Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8EC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 03:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjA1DpV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 22:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1DpU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 22:45:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B92367F6
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 19:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674877519; x=1706413519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h32LmsvSZfjCKQsuylyirI79cTR32P8MwDTfo/7mPRw=;
  b=JrU8I7cU+xFINPjbFaTY7QwabmIecwzKtHUUEpEQzhxXpiT2W5Hj5Ley
   Tz2F9Hv7kgfnA9fdI3gzlcIc+zqKJQQzU9b4mtfJZsLH2DicSNCf7M2f6
   uXVW20wsnook2MWgdDbvYmFjMR0y7LRw3Z4Ux3id/LJkl7yElV7C4mT0D
   39Fuya1nOnkQTxinCtFTcLj0R4MnCOau07xtaVwXnP/ch3fJFAD6hozpV
   WmWZgPwv5QFGaBafskZxBFBQ/nmTYHAJqyVxVG2gXnCaPEnjJ1TSuZYqk
   5n6HFm58o2TWovewHcZ1q7JeqmX/PDa+0FIRavA1zXuKlO7sOV+lDjoka
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="324951610"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="324951610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 19:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="837363096"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="837363096"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2023 19:45:16 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLc9T-0000Mx-2S;
        Sat, 28 Jan 2023 03:45:15 +0000
Date:   Sat, 28 Jan 2023 11:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 14/18]
 drivers/cxl/core/region.c:1479:21: warning: variable 'rc' set but not used
Message-ID: <202301281148.CS4njyXr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   a7cf664d7e997ac36b0f466af2e2be33464ab598
commit: d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d [14/18] cxl/region: Refactor attach_target() for autodiscovery
config: alpha-randconfig-r024-20230123 (https://download.01.org/0day-ci/archive/20230128/202301281148.CS4njyXr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/cxl/core/region.c: In function 'store_targetN':
>> drivers/cxl/core/region.c:1479:21: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
    1479 |                 int rc;
         |                     ^~


vim +/rc +1479 drivers/cxl/core/region.c

  1469	
  1470	static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
  1471				    size_t len)
  1472	{
  1473		int rc;
  1474	
  1475		if (sysfs_streq(buf, "\n"))
  1476			rc = detach_target(cxlr, pos);
  1477		else {
  1478			struct device *dev;
> 1479			int rc;
  1480	
  1481			dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
  1482			if (!dev)
  1483				return -ENODEV;
  1484	
  1485			if (!is_endpoint_decoder(dev)) {
  1486				rc = -EINVAL;
  1487				goto out;
  1488			}
  1489	
  1490			rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
  1491					   TASK_INTERRUPTIBLE);
  1492	out:
  1493			put_device(dev);
  1494		}
  1495	
  1496		if (rc < 0)
  1497			return rc;
  1498		return len;
  1499	}
  1500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
