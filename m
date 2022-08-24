Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA3C00140
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 15:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiHXPQu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHXPQt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 11:16:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46549837E
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 08:16:46 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCV6r3ZPlz67Qtq;
        Wed, 24 Aug 2022 23:16:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:16:44 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 16:16:43 +0100
Date:   Wed, 24 Aug 2022 16:16:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <20220824161642.00006833@huawei.com>
In-Reply-To: <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
References: <cover.1660079951.git.alison.schofield@intel.com>
        <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
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

On Tue,  9 Aug 2022 14:44:10 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the CFMWS is using XOR math, parse the corresponding
> CXIMS structure and store the xormaps in the root decoder.
> Use the xormaps in a new lookup, cxl_hb_xor(), to discover
> a targets entry in a host bridge interleave target list.
> 
> Defined in CXL Spec 3.0 Section: 9.17.1

9.17.1.4 ?  Not important though as I'm sure people can scan
down a few pages from the CEDT start.

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
One question inline - I think I know the answer but could be wrong!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h  |  2 +
>  drivers/cxl/acpi.c | 96 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..0a17a7007bff 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
> + * @platform_data: platform specific configuration data
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
>  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> +	void *platform_data;

I guess left as void * to allow for mocking easily?

>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..6ac6751c7f4e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,79 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +struct cxims_data {
> +	int nr_maps;
> +	u64 xormaps[];
> +};
> +
p> +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxims_data *cximsd = cxlrd->platform_data;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int ig = cxld->interleave_granularity;
> +	int i, n = 0;
> +	u64 hpa;
> +
> +	if (dev_WARN_ONCE(&cxld->dev,
> +			  cxld->interleave_ways != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +	/*
> +	 * Find this targets entry (n) in the host bridge interleave
> +	 * list. Defined in CXL Spec 3.0 Section 9.17.1.3 Table 9-22
> +	 */
> +	hpa = cxlrd->res->start + pos * ig;
> +	for (i = 0; i < cximsd->nr_maps; i++)
> +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> +
> +	return cxlrd->cxlsd.target[n];
> +}
> +
> +struct cxl_cxims_context {
> +	struct device *dev;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> +			   const unsigned long end)
> +{
> +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> +	struct cxl_cxims_context *ctx = arg;
> +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct device *dev = ctx->dev;
> +	struct cxims_data *cximsd;
> +	unsigned int hbig;
> +	u8 eiw;
> +	int rc;
> +
> +	rc = cxl_to_granularity(cxims->hbig, &hbig);
> +	if (rc)
> +		return rc;
> +
> +	rc = ways_to_cxl(cxld->interleave_ways, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (hbig == cxld->interleave_granularity) {
> +		if (cxims->nr_xormaps < eiw) {
> +			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
> +				cxims->nr_xormaps, eiw);
> +			return -ENXIO;
> +		}
> +
> +		cximsd = devm_kzalloc(dev, struct_size(cximsd, xormaps, eiw),
> +				      GFP_KERNEL);
> +		memcpy(cximsd->xormaps, cxims->xormap_list,
> +		       eiw * sizeof(*cximsd->xormaps));
> +		cximsd->nr_maps = eiw;
> +		cxlrd->platform_data = cximsd;
> +		cxlrd->calc_hb = cxl_hb_xor;
> +	}
> +	return 0;
> +}
> +
>  static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
> @@ -33,11 +106,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  	int rc, expected_len;
>  	unsigned int ways;
>  
> -	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> -		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> -		return -EINVAL;
> -	}
> -
>  	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
>  		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
>  		return -EINVAL;
> @@ -84,6 +152,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_cfmws_context *ctx = arg;
>  	struct cxl_port *root_port = ctx->root_port;
>  	struct resource *cxl_res = ctx->cxl_res;
> +	struct cxl_cxims_context cxims_ctx;
>  	struct cxl_root_decoder *cxlrd;
>  	struct device *dev = ctx->dev;
>  	struct acpi_cedt_cfmws *cfmws;
> @@ -148,7 +217,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		ig = CXL_DECODER_MIN_GRANULARITY;
>  	cxld->interleave_granularity = ig;
>  
> +	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> +		cxims_ctx = (struct cxl_cxims_context) {
> +			.dev = dev,
> +			.cxlrd = cxlrd,
> +		};
> +		rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
> +					   cxl_parse_cxims, &cxims_ctx);
> +		if (rc < 0)
> +			goto err_xormap;
> +
> +		if (cxlrd->calc_hb != cxl_hb_xor) {
> +			rc = -ENXIO;
> +			goto err_xormap;
> +		}
> +	}
>  	rc = cxl_decoder_add(cxld, target_map);
> +
> +err_xormap:
>  	if (rc)
>  		put_device(&cxld->dev);
>  	else

