Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CBC77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 10:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjEOKwy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbjEOKwx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 06:52:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B710F3
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 03:52:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKblr0LLnz67qBF;
        Mon, 15 May 2023 18:51:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:52:48 +0100
Date:   Mon, 15 May 2023 11:52:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/hdm: Add more HDM decoder debug messages at
 startup
Message-ID: <20230515115247.00002e45@Huawei.com>
In-Reply-To: <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
        <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 14 Apr 2023 11:54:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent debug session yielded a couple debug messages that were useful
> for determining the reason why the driver was or was not falling back
> to CXL range register emulation, and for identifying decoder setting
> enumeration problems.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
FWIW makes sense.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index abe3877cfa63..7889ff203a34 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -130,6 +130,14 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	 */
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
>  		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		dev_dbg(&info->port->dev,
> +			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> +			info->port->id, i,
> +			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
>  			return false;
>  	}
> @@ -868,6 +876,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> +	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
> +		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
> +		cxld->interleave_ways, cxld->interleave_granularity);
> +
>  	if (!info) {
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> 

