Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB95CC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJKQpm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKQpl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 12:45:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75DA4B9B
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 09:45:40 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mn1mV4DRVz688jH;
        Wed, 12 Oct 2022 00:42:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 18:45:37 +0200
Received: from localhost (10.81.205.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 17:45:37 +0100
Date:   Tue, 11 Oct 2022 17:45:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: check decoder count for end device
Message-ID: <20221011174534.000072bb@huawei.com>
In-Reply-To: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
References: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Sep 2022 11:11:07 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> indicates that for devices, only 10 decoders should be advertised. Add
> check on number of decoders greater than 10 for devices and reset to 10 to
> force spec compliance.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave

Seems reasonable.  I'm a bit curious to whether there is an actual problem if
a device is spec non compliant and advertises more decoders?

Either way does no harm and might let us know something fishy is happening.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..1919d99d157e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -71,9 +71,23 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>  static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  {
>  	u32 hdm_cap;
> +	int decoder_count;
> +	struct device *dev = &cxlhdm->port->dev;
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> -	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	/*
> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> +	 * found.
> +	 */
> +	if (is_cxl_endpoint(cxlhdm->port) && decoder_count > 10) {
> +		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
> +			 decoder_count);
> +		decoder_count = 10;
> +	}
> +	cxlhdm->decoder_count = decoder_count;
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> 
> 

