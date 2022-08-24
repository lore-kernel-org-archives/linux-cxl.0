Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5751C00140
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 14:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiHXO2s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiHXO2q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 10:28:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0257236
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 07:28:44 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCT3P65Wjz683Pb;
        Wed, 24 Aug 2022 22:28:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:28:41 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:28:41 +0100
Date:   Wed, 24 Aug 2022 15:28:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4 6/6] cxl: export intereleave capability as port sysfs
 attribute
Message-ID: <20220824152840.00002eb8@huawei.com>
In-Reply-To: <166077132912.1743055.6028619361637977647.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
        <166077132912.1743055.6028619361637977647.stgit@djiang5-desk4.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Aug 2022 14:22:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export the interleave capability as a sysfs attribute for a port. The
> exported mask is interpreted from the CXL HDM Decoder Capability Register
> (CXL spec v 8.2.4.19.1). Each bit in the mask represents the number of

State which spec in all references (this one is rev3.0)

Otherwise, whilst it's not a particularly intuitive interface, I guess it
works reasonably well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> interleave ways the decoder supports. For example, CXL devices designed
> from CXL spec v2.0 supports 1, 2, 4, and 8 interleave ways. The exported
> mask would show 0x116. The exported sysfs attribute will help user region
> creation to do more valid configuration checking.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   13 +++++++++++++
>  drivers/cxl/port.c                      |   10 ++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c6f533f47e50..5a13806a77ab 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -203,6 +203,19 @@ Description:
>  		Interleave Capable" bit and the "AA14to12 Interleave Capable" bits
>  		are set.
>  
> +What:		/sys/bus/cxl/devices/endpointX/interleave_cap
> +		/sys/bus/cxl/devices/portX/interleave_cap
> +Date:		Aug, 2020
> +KernelVersion:	v6.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Interleave capability mask from the HDM decoder attached to the
> +		port. Each bit in the mask represents the number of interleave ways
> +		the decoder supports. For CXL devices designed from CXL spec v2.0 or
> +		earlier, 1, 2, 4, and 8 interleave ways are supported. With CXL spec
> +		v3.0 or later, the capability register (CXL spec v3 8.2.4.19.1)
> +		indicates 3, 6, and 12 ways supported or 16 ways supported.
> +
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
>  KernelVersion:	v5.20
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 567f62fd4ded..f856a31bec65 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -132,8 +132,18 @@ static ssize_t interleave_mask_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(interleave_mask);
>  
> +static ssize_t interleave_cap_show(struct device *dev, struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%#lx\n", cxlhdm->interleave_cap);
> +}
> +static DEVICE_ATTR_RO(interleave_cap);
> +
>  static struct attribute *cxl_port_info_attributes[] = {
>  	&dev_attr_interleave_mask.attr,
> +	&dev_attr_interleave_cap.attr,
>  	NULL,
>  };
>  
> 
> 

