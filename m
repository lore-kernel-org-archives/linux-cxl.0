Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C9C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 15:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiHCPZ6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiHCPZ5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 11:25:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A549D32BB2
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 08:25:56 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LybCx5V1Wz687SB;
        Wed,  3 Aug 2022 23:21:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 17:25:54 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 16:25:54 +0100
Date:   Wed, 3 Aug 2022 16:25:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 2/4] cxl/region: Move HPA setup to cxl_region_attach()
Message-ID: <20220803162552.00002de2@huawei.com>
In-Reply-To: <165951146924.967013.13625127756930271590.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
        <165951146924.967013.13625127756930271590.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 03 Aug 2022 00:24:29 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent bug fix added the setup of the endpoint decoder interleave
> geometry settings to cxl_region_attach(). Move the HPA setup there as
> well to keep all endpoint decoder parameter setting in a central
> location.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Makes sense to me plus works for the random test I hit it with.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c    |   17 ++---------------
>  drivers/cxl/core/region.c |    4 ++++
>  2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8143e2615957..5aadefd670d1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -499,20 +499,6 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  			  CXL_HDM_DECODER0_CTRL_TYPE);
>  }
>  
> -static void cxld_set_hpa(struct cxl_decoder *cxld, u64 *base, u64 *size)
> -{
> -	struct cxl_region *cxlr = cxld->region;
> -	struct cxl_region_params *p = &cxlr->params;
> -
> -	cxld->hpa_range = (struct range) {
> -		.start = p->res->start,
> -		.end = p->res->end,
> -	};
> -
> -	*base = p->res->start;
> -	*size = resource_size(p->res);
> -}
> -
>  static void cxld_clear_hpa(struct cxl_decoder *cxld)
>  {
>  	cxld->hpa_range = (struct range) {
> @@ -601,7 +587,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>  	cxld_set_interleave(cxld, &ctrl);
>  	cxld_set_type(cxld, &ctrl);
> -	cxld_set_hpa(cxld, &base, &size);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8e6ff3f39755..a073f16355ca 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1296,6 +1296,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  	cxled->cxld.interleave_ways = p->interleave_ways;
>  	cxled->cxld.interleave_granularity = p->interleave_granularity;
> +	cxled->cxld.hpa_range = (struct range) {
> +		.start = p->res->start,
> +		.end = p->res->end,
> +	};
>  
>  	return 0;
>  
> 

