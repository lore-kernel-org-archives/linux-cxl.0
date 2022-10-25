Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A777C04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 11:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJYLIt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiJYLIr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 07:08:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E2188AAF
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 04:08:45 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxTfL5ypcz6H73s;
        Tue, 25 Oct 2022 19:06:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:08:43 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:08:43 +0100
Date:   Tue, 25 Oct 2022 12:08:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3] cxl: check decoder count for end device
Message-ID: <20221025120842.00003c29@huawei.com>
In-Reply-To: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
References: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 24 Oct 2022 08:43:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> indicates that for devices, only 10 decoders should be advertised. Add
> check on number of decoders greater than 10 for devices and emit warning.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I wonder... Should warning say CXL r3.0 spec violation?

Seems possible this might grow in future versions and so it
might be nice to give a hint that it 'might' be valid in a higher spec version?

I don't care strongly either way though.

FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v3:
> - Fix commit header and output message to reflect code change from v2.
> 
> v2:
> - Remove decoder count reassignment from violation (Dan)
> 
>  drivers/cxl/core/hdm.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..c3b756f93261 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>  static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  {
>  	u32 hdm_cap;
> +	struct device *dev = &cxlhdm->port->dev;
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	/*
> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> +	 * found.
> +	 */
> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> +		dev_warn(dev, "Endpoint decoder count (%d) > 10, spec violation!\n",
> +			 cxlhdm->decoder_count);
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> 
> 

