Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE45DC77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 15:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjFFPb1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbjFFPb0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 11:31:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50DA6
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 08:31:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbDvs4yq7z6J6fX;
        Tue,  6 Jun 2023 23:31:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 16:31:22 +0100
Date:   Tue, 6 Jun 2023 16:31:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 18/19] cxl/region: Define a driver interface for region
 creation
Message-ID: <20230606163121.000031b6@Huawei.com>
In-Reply-To: <168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:33:18 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Scenarios like recreating persistent memory regions from label data and
> establishing new regions for CXL attached accelerators with local memory
> need a kernel internal facility to establish new regions.

Could probably make the label data one a userspace problem, but I agree
that it 'might' be done entirely in kernel.

> 
> Introduce cxl_create_region() that takes an array of endpoint decoders
> with reserved capacity and a root decoder object to establish a new
> region.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  drivers/cxl/core/region.c |  107 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      |    3 +
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a41756249f8d..543c4499379e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2878,6 +2878,104 @@ construct_region_begin(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	if (ways < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto out;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		if (!cxled[i]->dpa_res)
> +			break;
> +		size += resource_size(cxled[i]->dpa_res);
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (i < ways)
> +		goto out;
> +
> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		rc = cxl_region_attach(cxlr, cxled[i], i);
> +		if (rc)
> +			break;
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto out;
> +
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
> +	return cxlr;
> +}
> +

>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3085,6 +3183,15 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +
> +		/*
> +		 * HDM-D[B] (device-memory) regions have accelerator
> +		 * specific usage, skip device-dax registration.
> +		 */

As before - I'm not yet convinced that is always the case for HDM-DB
Particularly given you support interleaving which may never make sense
for accelerators.

> +		if (cxlr->type == CXL_DECODER_DEVMEM)
> +			return 0;
> +
> +		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);

