Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06613C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 20:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDUUZ2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDUUZ1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 16:25:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9487271F
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682108725; x=1713644725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KIwAvpTsCbN0CtCQqDQrxxB80l9my5zLuCMKFdPyS+Q=;
  b=ZTDlElyte5rrnCSGN2bzp05NgIqHz4L0a5NsLu50qEyyobskb2GpSmu3
   Pu8bBCS6coAeHVh6WLhBC2tN022ljkVhK3gDoNk+sws5D9Afj1zJz/N7m
   KmxQSkaHsMljFRgczryA1Zcvj0Wnl4tc2+mKc7HLu06kFXpCoP2btqhia
   E1K87571bHqpwyVrGcDerYZffXfNCFRtjKdCPj7E3kVTzHkUsfOoPybMC
   McT6a5LDrdslqxmAZ0Tqk7USnonT/aturrxr7fLrmUnjnFyQVrFH1IWkf
   yPOW6MwpRY/eahfpx0J4R5SpbmAVz7GFq+CsUaijVOxPFoz976twucL9A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="432350623"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="432350623"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 13:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757013977"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757013977"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2023 13:25:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppxJp-000gmW-26;
        Fri, 21 Apr 2023 20:25:21 +0000
Date:   Sat, 22 Apr 2023 04:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <202304220436.O3l806d0-lkp@intel.com>
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
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230422/202304220436.O3l806d0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b5227afb40297993eba355a804720c834da3fe2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Davidlohr-Bueso/cxl-pci-Allocate-irq-vectors-earlier-in-pci-probe/20230421-175725
        git checkout b5227afb40297993eba355a804720c834da3fe2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220436.O3l806d0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/memdev.c:97:12: error: implicit declaration of function 'readq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
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
