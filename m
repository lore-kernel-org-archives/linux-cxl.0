Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A63C27C76
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjA1QB7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1QB6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 11:01:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A624C97
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674921717; x=1706457717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDZ+x21iwuL/L0OLLk1RjPwQJdiPzcmQYtfCMtrysy4=;
  b=meq4ixn+mJdlTCeCsHs1cWUVTJZi2KY6ne4oVAuLjzqOUSkZJjkXEV+v
   CGPxa9a6IX6SwhacHbBqc5KhVQlKnENmxwK22F0oo9FR3UOg980H1xDYp
   rHr6iHSS0fUwXrqnoRNZdPRR7kOF8EhOl34hxv4tYI4rPpqAT4jLfetuM
   PkYfd7ApRdhhYuWznV+Z3lb2U+Q8fwOY8zAj+Ugtw0yvYU7ZNe5BHQx0F
   7U6TxQKHFrlN+/L9CzvEALRovUCTK6Ciz+2+tF5vwdgMWl4QYN5Z7TZKs
   upiSVvQjAdBPh3kA4bNolURgpVSOTX96dUg1wmsyOxMvtl7+C/WpyoVHs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="354612618"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354612618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 08:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="837496576"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="837496576"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2023 08:01:39 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLne7-0000rl-0U;
        Sat, 28 Jan 2023 16:01:39 +0000
Date:   Sun, 29 Jan 2023 00:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <202301282342.2ZTowY3a-lkp@intel.com>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 172738bbccdb4ef76bdd72fc72a315c741c39161]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
base:   172738bbccdb4ef76bdd72fc72a315c741c39161
patch link:    https://lore.kernel.org/r/20230126180458.5145-1-Jonathan.Cameron%40huawei.com
patch subject: [PATCH] cxl/pci: Set the device timestamp
config: powerpc-randconfig-s032-20230123 (https://download.01.org/0day-ci/archive/20230128/202301282342.2ZTowY3a-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f36cca050cf662048001b7b7686040270e4a8c00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
        git checkout f36cca050cf662048001b7b7686040270e4a8c00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/cxl/core/mbox.c:834:18: sparse: sparse: cast to non-scalar
   drivers/cxl/core/mbox.c:834:18: sparse: sparse: cast from non-scalar
>> drivers/cxl/core/mbox.c:874:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] timestamp @@     got unsigned long long [usertype] ts @@
   drivers/cxl/core/mbox.c:874:22: sparse:     expected restricted __le64 [usertype] timestamp
   drivers/cxl/core/mbox.c:874:22: sparse:     got unsigned long long [usertype] ts

vim +874 drivers/cxl/core/mbox.c

   861	
   862	int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
   863	{
   864		struct cxl_mbox_cmd mbox_cmd;
   865		struct cxl_mbox_set_timestamp_in pi;
   866	
   867		/*
   868		 * Command is optional and functionality should not be affected if
   869		 * the command is not available.
   870		 */
   871		if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
   872			return 0;
   873	
 > 874		pi.timestamp = ts;
   875		mbox_cmd = (struct cxl_mbox_cmd) {
   876			.opcode = CXL_MBOX_OP_SET_TIMESTAMP,
   877			.size_in = sizeof(pi),
   878			.payload_in = &pi,
   879		};
   880	
   881		return cxl_internal_send_cmd(cxlds, &mbox_cmd);
   882	}
   883	EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
   884	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
