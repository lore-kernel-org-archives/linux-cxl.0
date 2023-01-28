Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F4C38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 04:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjA1ErY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 23:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjA1ErX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 23:47:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2077FA00
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 20:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674881240; x=1706417240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TMaPEK/flWHkegvDhPNIMpyJEF1mxwCi9JdCIBlRCTg=;
  b=Ca1NweFkBwTlzu68M33B5KsMKAEMuSrVaARYT8mKrdWrRyo5rsUxwijl
   M/OpLMX5scjxiQSOM2dyq6AaL8GNxXzxud5KRXL2KVJ8KhECnZ0wkV33g
   nTGj1iDz1LfB/xafgctT+WGd2Fxy3TAqfFz6j4UI721lUdEg1RR01YDQL
   eFsJRXj8co8wIJAplQAe26l/nK+/pUeV722kyHbo95MTuBQ8lIRdazRYH
   23+cBBwQlhPgHFpRmTSLT0MLz8cVOvJ8GGrEPb7qKlxWRa7kNW7rtklGN
   ZZOApOHY/8KL/WlDbaG0cNB9wwms+EeN0wf6ppCoIPmICMYX8cZ1lZpG7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="328549689"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="328549689"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 20:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="665486817"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="665486817"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 20:47:17 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLd7V-0000Oz-0I;
        Sat, 28 Jan 2023 04:47:17 +0000
Date:   Sat, 28 Jan 2023 12:46:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 14/18] drivers/cxl/core/region.c:1479:7:
 warning: variable 'rc' set but not used
Message-ID: <202301281217.NvoiwL4w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   a7cf664d7e997ac36b0f466af2e2be33464ab598
commit: d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d [14/18] cxl/region: Refactor attach_target() for autodiscovery
config: i386-randconfig-a012-20230123 (https://download.01.org/0day-ci/archive/20230128/202301281217.NvoiwL4w-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout d5c71004c2cb69354ab7f1bb9b0a33ae9f7edf9d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/region.c:1479:7: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
                   int rc;
                       ^
>> drivers/cxl/core/region.c:1482:7: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (!dev)
                       ^~~~
   drivers/cxl/core/region.c:1496:6: note: uninitialized use occurs here
           if (rc < 0)
               ^~
   drivers/cxl/core/region.c:1482:3: note: remove the 'if' if its condition is always true
                   if (!dev)
                   ^~~~~~~~~
   drivers/cxl/core/region.c:1473:8: note: initialize the variable 'rc' to silence this warning
           int rc;
                 ^
                  = 0
   2 warnings generated.


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
> 1482			if (!dev)
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
