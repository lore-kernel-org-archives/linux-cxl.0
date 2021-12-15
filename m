Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6FC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Dec 2021 17:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhLORrq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:47:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4298 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLORrp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Dec 2021 12:47:45 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDjJl5fbZz67m6y;
        Thu, 16 Dec 2021 01:43:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 18:47:24 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 17:47:23 +0000
Date:   Wed, 15 Dec 2021 17:47:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 19/28] cxl/region: Introduce concept of region
 configuration
Message-ID: <20211215174722.00000861@huawei.com>
In-Reply-To: <20211022183709.1199701-20-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-20-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 22 Oct 2021 11:37:00 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The region creation APIs create a vacant region. Configuring the region
> works in the same way as similar subsystems such as devdax. Sysfs attrs
> will be provided to allow userspace to configure the region.  Finally
> once all configuration is complete, userspace may activate the region.
> 
> Introduced here are the most basic attributes needed to configure a
> region. Details of these attribute are described in the ABI
> Documentation.
> 
> A example is provided below:
> 
> /sys/bus/cxl/devices/region0.0:0
> ├── interleave_granularity
> ├── interleave_ways
> ├── offset
> ├── size
> ├── subsystem -> ../../../../../../bus/cxl
> ├── target0
> ├── uevent
> └── uuid
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---

Not a proper review, but just one thing noticed whilst messing around with this.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 588f0ca65bb2..3b0d74d4dd6c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3,9 +3,12 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/uuid.h>
>  #include <linux/idr.h>
>  #include <region.h>
> +#include <cxlmem.h>
>  #include <cxl.h>
>  
> +
> +static size_t set_targetN(struct cxl_region *region, const char *buf, int n,
> +			  size_t len)
> +{
> +	struct device *memdev_dev;
> +	struct cxl_memdev *cxlmd;
> +
> +	device_lock(&region->dev);
> +
> +	if (len == 1 || region->targets[n])
> +		remove_target(region, n);
> +
> +	/* Remove target special case */
> +	if (len == 1) {
> +		device_unlock(&region->dev);
> +		return len;
> +	}
> +
> +	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> +	if (!memdev_dev)

device_unlock()?

> +		return -ENOENT;
> +
> +	/* reference to memdev held until target is unset or region goes away */
> +
> +	cxlmd = to_cxl_memdev(memdev_dev);
> +	region->targets[n] = cxlmd;
> +
> +	device_unlock(&region->dev);
> +
> +	return len;
> +}

J

