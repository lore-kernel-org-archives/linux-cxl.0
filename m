Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D81E7D27F
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjIZLH6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjIZLH5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 07:07:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDC95
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 04:07:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvxjj18Phz6D9YK;
        Tue, 26 Sep 2023 19:05:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 26 Sep
 2023 12:07:48 +0100
Date:   Tue, 26 Sep 2023 12:07:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add committed sysfs attribute to CXL decoder
Message-ID: <20230926120747.0000462f@Huawei.com>
In-Reply-To: <169566515694.3697523.714600762835841180.stgit@djiang5-mobl3>
References: <169566515694.3697523.714600762835841180.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 25 Sep 2023 11:05:56 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Expose the committed status of a CXL decoder. The status assists CXL CLI in
> determining as a sure way whether a region is active. Of coruse this is

Spell check.

> still best effort as it's a snapshot of the state and not atomic for the
> user region disable operation.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One passing comment inline.

Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
>  drivers/cxl/core/port.c                 |   11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 087f762ebfd5..ef3fc9fe9d0d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -369,6 +369,13 @@ Description:
>  		provided it is currently idle / not bound to a driver.
>  
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/committed
> +Date:		Sep, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Indicates whether the decoder is committed.
> +
>  What:		/sys/bus/cxl/devices/regionZ/uuid
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..ab5b9bc26d56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -277,12 +277,23 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(interleave_ways);
>  
> +static ssize_t committed_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	return sysfs_emit(buf, "%d\n", !!(cxld->flags & CXL_DECODER_F_ENABLE));

Could use FIELD_GET() though as it's not been used for these
before that I could quickly find, fair enough to maintain
consistent style

> +}
> +
> +static DEVICE_ATTR_RO(committed);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_locked.attr,
>  	&dev_attr_interleave_granularity.attr,
>  	&dev_attr_interleave_ways.attr,
> +	&dev_attr_committed.attr,
>  	NULL,
>  };
>  
> 
> 

