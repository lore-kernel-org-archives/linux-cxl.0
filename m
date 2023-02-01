Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586DC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBAJMA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjBAJL7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 04:11:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565FE3433C
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 01:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675242698; x=1706778698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uqXlT+Xg15k4VpWdD0CJpRQuzrNg5oTDihQukvjG8W0=;
  b=n8YfoUmiSCq3OxQCbEBewJSX4ENvhdDEiVdaD3VQlK0D5oUbZHjmer15
   IZZXCCrn7R4CNfhoqLuiWH/lbbCRyGx1hEOZMpQWWEWLFsg/B9Z0xLqKl
   w81HEzkUR1sicoVimsd2fQ4I0E6qNJb/cfP7yWFJPCtukbhvk2+2oZ1sP
   3vYIFIoIrXxwGO/R51+NagdRr/cR12cPVRxBo1HADwv5iF2WtYebfkW1P
   RjGz0HGNz3mxrXPYYG1qpanlIwp0+PF/TY45BlpClbv3C9XKv+eTBRMlj
   qYIzNnUeZxTKd/omYgMqt5m1zNsMbAOgRdwc9TgQ2dXGIkTGFxgrM42ig
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="328103570"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="328103570"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 01:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910264269"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="910264269"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2023 01:11:19 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN99C-0005IV-1e;
        Wed, 01 Feb 2023 09:11:18 +0000
Date:   Wed, 1 Feb 2023 17:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 17/18] port.c:undefined reference to
 `cxl_add_to_region'
Message-ID: <202302011700.R8sickqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   c30a50b37b7808284c3796e0866e939017bb05b2
commit: f71922e583ef6b6e17575c87e496b17f91193d37 [17/18] cxl/region: Add region autodiscovery
config: arm-randconfig-c002-20230130 (https://download.01.org/0day-ci/archive/20230201/202302011700.R8sickqk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=f71922e583ef6b6e17575c87e496b17f91193d37
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout f71922e583ef6b6e17575c87e496b17f91193d37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/cxl/port.o: in function `discover_region':
>> port.c:(.text+0x144): undefined reference to `cxl_add_to_region'
   `.exit.text' referenced in section `.alt.smp.init' of drivers/mtd/ubi/gluebi.o: defined in discarded section `.exit.text' of drivers/mtd/ubi/gluebi.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
