Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DDBC7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 20:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjDUUE3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUUE1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 16:04:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35FD110
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682107466; x=1713643466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tyIuJWVgOap+WQetz8gIdZ7l9WAs+BgOlfzmXyOh82M=;
  b=CKQXPYHban7XYorSHhab0fuwqdwzMJAC8SKpJMMtmY5vVxFVzCLVzRBB
   Yk1EpO7LbM/px3Cu0LRbnAI6zvrp/q/sGBtfZE946haL0A1UF1HFpGk+h
   f4fc6G9tK6f9oFCLqEE3qMp+9zhqrHrbXpBAiI+LKs3A4Rx2K/kYUBLv7
   1lxmQ21UfWqaIq7fJMLLdobsUK1wz2Qyb3LF+LY4rEl7BDBEGFOCmC+uQ
   9YEu5KXKxzgfe+Og42ClT3g3B9EH0jeKmoAwiM/ki3PUgZtY2tFIfHIZ5
   RVbw0RpWPPTItVwN9mLR38kPX+O+1H3SPbOvJ18N2CxUGYzxRLA/t7C59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411341482"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="411341482"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 13:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="695052628"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="695052628"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2023 13:04:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppwzV-000gmG-1Y;
        Fri, 21 Apr 2023 20:04:21 +0000
Date:   Sat, 22 Apr 2023 04:04:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <202304220358.PInFhQmP-lkp@intel.com>
References: <20230421092321.12741-5-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421092321.12741-5-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Davidlohr,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7 next-20230420]
[cannot apply to cxl/next cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Davidlohr-Bueso/cxl-pci-Allocate-irq-vectors-earlier-in-pci-probe/20230421-175725
base:   linus/master
patch link:    https://lore.kernel.org/r/20230421092321.12741-5-dave%40stgolabs.net
patch subject: [PATCH 4/7] cxl/mem: Wire up Sanitation support
config: powerpc-buildonly-randconfig-r006-20230421 (https://download.01.org/0day-ci/archive/20230422/202304220358.PInFhQmP-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b5227afb40297993eba355a804720c834da3fe2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Davidlohr-Bueso/cxl-pci-Allocate-irq-vectors-earlier-in-pci-probe/20230421-175725
        git checkout b5227afb40297993eba355a804720c834da3fe2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220358.PInFhQmP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/memdev.c:97:12: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
                     ^
   1 error generated.


vim +/readq +97 drivers/cxl/core/memdev.c

    88	
    89	static struct device_attribute dev_attr_pmem_size =
    90		__ATTR(size, 0444, pmem_size_show, NULL);
    91	
    92	static ssize_t security_sanitize_show(struct device *dev,
    93					      struct device_attribute *attr, char *buf)
    94	{
    95		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
    96		struct cxl_dev_state *cxlds = cxlmd->cxlds;
  > 97		u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
    98		u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
    99		u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
   100	
   101		if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
   102			return sysfs_emit(buf, "sanitize\n");
   103		else
   104			return sysfs_emit(buf, "disabled\n");
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
