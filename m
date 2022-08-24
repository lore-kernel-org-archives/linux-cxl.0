Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4435AC00140
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 14:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiHXOfF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiHXOfC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 10:35:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D7FD03
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 07:35:01 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCT7B75Qfz67Cvm;
        Wed, 24 Aug 2022 22:31:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:34:59 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:34:59 +0100
Date:   Wed, 24 Aug 2022 15:34:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v4 5/6] cxl: export interleave address mask as port
 sysfs attribute
Message-ID: <20220824153458.00001148@huawei.com>
In-Reply-To: <166077132400.1743055.3807533324287792337.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
        <166077132400.1743055.3807533324287792337.stgit@djiang5-desk4.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Aug 2022 14:22:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export the interleave address mask as a sysfs attribute for a port. The
> interleave address mask is created based off the CXL HDM Decoder Capability
> Register (CXL spec v3 8.2.4.19.1) and sets the bits indicated by th "A11to8

the

> Interleave Capable" bit and the "A14to12 Interleave Capable" bit. It
> indicates the decoder supports interleaveing based on those address bits.
interleaving (spelling from the spec.)

> The exported sysfs attribute will help user region creation to do more
> valid configuration checking.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Looks good other than needing a spell check (not that I can take the high
ground on spelling, or remembering to spell check patches ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>  drivers/cxl/port.c                      |   19 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8494ef27e8d2..c6f533f47e50 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -191,6 +191,17 @@ Description:
>  		the data is 0 reading the CDAT data failed.  Otherwise the CDAT
>  		data is reported.
>  
> +What:		/sys/bus/cxl/devices/endpointX/interleave_mask
> +		/sys/bus/cxl/devices/portX/interleave_mask
> +Date:		Aug, 2020
> +KernelVersion:	v6.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Interleve address mask from the HDM decoder attached to the
Interleave
> +		port. The address bits are set depending on the CXL HDM Decoder
> +		Capability Register (CXL spec v3 8.2.4.19.1) where the "A11to8
rev3.0

Technically it's version 1 of revision 3

> +		Interleave Capable" bit and the "AA14to12 Interleave Capable" bits
> +		are set.
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c4aa073b7e31..567f62fd4ded 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -123,8 +123,27 @@ static struct attribute_group cxl_cdat_attribute_group = {
>  	.is_bin_visible = cxl_port_bin_attr_is_visible,
>  };
>  
> +static ssize_t interleave_mask_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%#x\n", cxlhdm->interleave_mask);
> +}
> +static DEVICE_ATTR_RO(interleave_mask);
> +
> +static struct attribute *cxl_port_info_attributes[] = {
> +	&dev_attr_interleave_mask.attr,
> +	NULL,

I'd not put a comma after a NULL terminator, but just did a grep
and this inline with rest of drivers/cxl so fair enough.

> +};
> +
> +static struct attribute_group cxl_port_info_attribute_group = {
> +	.attrs = cxl_port_info_attributes,
> +};
> +
>  static const struct attribute_group *cxl_port_dynamic_attr_groups[] = {
>  	&cxl_cdat_attribute_group,
> +	&cxl_port_info_attribute_group,
>  	NULL,
>  };
>  
> 
> 

