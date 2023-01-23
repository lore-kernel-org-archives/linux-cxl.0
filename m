Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D81EC54EB4
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 14:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjAWOI3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjAWOI2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 09:08:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739B24127
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 06:07:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0sNy4TKyz67HtH;
        Mon, 23 Jan 2023 22:07:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 14:07:52 +0000
Date:   Mon, 23 Jan 2023 14:07:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3 6/8] cxl: create emulated decoders for devices
 without HDM decoders
Message-ID: <20230123140751.00007fe4@Huawei.com>
In-Reply-To: <167406535137.1455071.12470540886828540377.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
        <167406535137.1455071.12470540886828540377.stgit@djiang5-mobl3.local>
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

On Wed, 18 Jan 2023 11:09:12 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3.0 spec 8.1.3
> 
> RCDs may not have HDM register blocks. Create fake decoders based on CXL
> PCIe DVSEC registers. The DVSEC Range Registers provide the memory range
> for these decoder structs. For the RCD, there can be up to 2 decoders
> depending on the DVSEC Capability register HDM_count.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v3:
> - Drop unrelated bits from patch. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 86fe1be2e961..cbec955db4c9 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -748,6 +748,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (is_endpoint_decoder(&cxld->dev))
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  
> +	if (!hdm) {
> +		if (!cxled)
> +			return -EINVAL;
> +
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +	}
> +
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>  	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> 
> 

