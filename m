Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD1C4167B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLSRAl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLSRAh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 12:00:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9D12D1E
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 09:00:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbQpW002Wz67JwR;
        Tue, 20 Dec 2022 00:56:34 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 17:00:32 +0000
Date:   Mon, 19 Dec 2022 17:00:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 6/8] cxl: create emulated decoders for devices
 without HDM decoders
Message-ID: <20221219170031.00000193@Huawei.com>
In-Reply-To: <166984996963.2805382.2390204746333079984.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984996963.2805382.2390204746333079984.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3.0 spec 8.1.3
> RCDs may not have HDM register blocks. Create fake decoders based on CXL
> PCIe DVSEC registers. The DVSEC Range Regiters provide the memory range for

Spell check (not that I can talk about spelling ;)

> these decoder structs. For the RCD, there can be up to 2 decoders depending
> on the DVSEC Capability register HDM_count.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few trivial things inline. LGTM otherwise.

> ---
>  drivers/cxl/core/hdm.c |   59 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3a9e9b854587..60b6c141f514 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -721,6 +721,29 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static int init_emulated_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> +				     struct cxl_endpoint_dvsec_info *info, int which)
> +{
> +	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
> +		return -ENODEV;
> +
> +	cxld->hpa_range = (struct range) {
> +		.start = info->dvsec_range[which].start,
> +		.end = info->dvsec_range[which].end,
> +	};
> +
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxld->target_type = CXL_DECODER_ACCELERATOR;

Why accelerator? Comment needed.
blank line

> +	if (cxld->id != port->commit_end + 1) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Committed out of order\n",
> +			 port->id, cxld->id);
> +		return -ENXIO;
> +	}
blank line

> +	port->commit_end = cxld->id;
blank line.
> +	return 0;
> +}
> +
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> @@ -739,6 +762,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (is_endpoint_decoder(&cxld->dev))
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  
> +	if (!hdm) {
> +		if (cxled)
> +			return init_emulated_hdm_decoder(port, cxld, info, which);
> +		else
> +			return -EINVAL;

		if (!cxled)
			return -EINVAL;

		return init_emulated_hdm_decoder(....);

I'd prefer puting the error case out of line and normal one in main flow
as much as possible.

> +	}
> +
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>  	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> @@ -832,19 +862,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }
>  

> +
> +/**
> + * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> + * @cxlhdm: Structure to populate with HDM capabilities

Docs update got missed somewhere.

> + */
> +int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> +				struct cxl_endpoint_dvsec_info *info)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_port *port = cxlhdm->port;
> +	int i;
> +	u64 dpa_base = 0;
> +
> +	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
>  		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
> 
> 

