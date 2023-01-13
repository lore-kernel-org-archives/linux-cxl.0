Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62476C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 14:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjAMOFX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbjAMOEu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 09:04:50 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53409820FB
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 06:02:32 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntjj04HHyz689Gt;
        Fri, 13 Jan 2023 21:59:48 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:02:30 +0000
Date:   Fri, 13 Jan 2023 14:02:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 6/8] cxl: create emulated decoders for devices
 without HDM decoders
Message-ID: <20230113140229.000025f1@Huawei.com>
In-Reply-To: <167330063330.975161.12886268473522769039.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330063330.975161.12886268473522769039.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 09 Jan 2023 14:43:54 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3.0 spec 8.1.3
> RCDs may not have HDM register blocks. Create fake decoders based on CXL
> PCIe DVSEC registers. The DVSEC Range Registers provide the memory range
> for these decoder structs. For the RCD, there can be up to 2 decoders
> depending on the DVSEC Capability register HDM_count.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Second half of this patch seems to be an unrelated refactor...
I missed that entirely when reviewing v1. 


> 
> ---
> v2:
> - Refactor to put error case out of line. (Jonathan)
> - kdoc update. (Jonathan)
> - Remove init_emulated_hdm_decoder(), duplicate of
>   cxl_setup_hdm_decoder_from_dvsec().
> ---
>  drivers/cxl/core/hdm.c |   37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 165c0f382ce1..ed5e9ef3aa9b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -747,6 +747,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
> @@ -840,19 +847,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }

I have no problem with what follows, but I can't see a clear connection to rest of
the patch.

>  
> -/**
> - * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> - * @cxlhdm: Structure to populate with HDM capabilities
> - */
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -				struct cxl_endpoint_dvsec_info *info)

Note the docs were wrong before this point...  Probably fix them earlier.

> +static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> -	struct cxl_port *port = cxlhdm->port;
> -	int i, committed;
> -	u64 dpa_base = 0;
> +	int committed, i;
>  	u32 ctrl;
>  
> +	if (!hdm)
> +		return;
> +
>  	/*
>  	 * Since the register resource was recently claimed via request_region()
>  	 * be careful about trusting the "not-committed" status until the commit
> @@ -869,6 +872,22 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  	/* ensure that future checks of committed can be trusted */
>  	if (committed != cxlhdm->decoder_count)
>  		msleep(20);
> +}
> +
> +/**
> + * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> + * @cxlhdm: Structure to populate with HDM capabilities
> + * @info: cached DVSEC range register info
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
> 

