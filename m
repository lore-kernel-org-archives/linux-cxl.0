Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D98C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 15:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjA3PKL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjA3PKK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 10:10:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986D35245
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 07:10:08 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5BR9002nz6J9W6;
        Mon, 30 Jan 2023 23:09:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 15:10:06 +0000
Date:   Mon, 30 Jan 2023 15:10:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <20230130151005.000069f6@Huawei.com>
In-Reply-To: <202301281915.t1bQicuY-lkp@intel.com>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
        <202301281915.t1bQicuY-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 28 Jan 2023 19:32:20 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jonathan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on 172738bbccdb4ef76bdd72fc72a315c741c39161]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
> base:   172738bbccdb4ef76bdd72fc72a315c741c39161
> patch link:    https://lore.kernel.org/r/20230126180458.5145-1-Jonathan.Cameron%40huawei.com
> patch subject: [PATCH] cxl/pci: Set the device timestamp
> config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281915.t1bQicuY-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/f36cca050cf662048001b7b7686040270e4a8c00
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
>         git checkout f36cca050cf662048001b7b7686040270e4a8c00
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/cxl/pci.c:5:
> >> include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'  
>       67 | extern ktime_t ktime_get(void);

I should be including ktime.h not timekeeping.h here.  Will fix for v2.
