Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CCBC25B07
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiHHLEm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiHHLEj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 07:04:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D4E140F1
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 04:04:38 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1YDj2ZrHz67ms2;
        Mon,  8 Aug 2022 19:01:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 13:04:36 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 12:04:35 +0100
Date:   Mon, 8 Aug 2022 12:04:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Move HPA setup to
 cxl_region_attach()
Message-ID: <20220808120434.00000614@huawei.com>
In-Reply-To: <165973126020.1526540.14701949254436069807.stgit@dwillia2-xfh.jf.intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
        <165973126020.1526540.14701949254436069807.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 05 Aug 2022 13:27:40 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent bug fix added the setup of the endpoint decoder interleave
> geometry settings to cxl_region_attach(). Move the HPA setup there as
> well to keep all endpoint decoder parameter setting in a central
> location.
> 
> For symmetry, move endpoint HPA teardown to cxl_region_detach(), and for
> switches move HPA setup / teardown to cxl_port_{setup,reset}_targets().
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not yet hammering the detach path in my local testing, but
this looks unlikely to break anything.

Jonathan

> ---
>  drivers/cxl/core/hdm.c    |   26 ++------------------------
>  drivers/cxl/core/region.c |   24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8143e2615957..e096f74e19df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -499,28 +499,6 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
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
> -static void cxld_clear_hpa(struct cxl_decoder *cxld)
> -{
> -	cxld->hpa_range = (struct range) {
> -		.start = 0,
> -		.end = -1,
> -	};
> -}
> -
>  static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -601,7 +579,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>  	cxld_set_interleave(cxld, &ctrl);
>  	cxld_set_type(cxld, &ctrl);
> -	cxld_set_hpa(cxld, &base, &size);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
>  
>  	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> @@ -674,7 +653,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  
> -	cxld_clear_hpa(cxld);
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 40f04c543e41..e71077beb021 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1044,6 +1044,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	cxld->interleave_ways = iw;
>  	cxld->interleave_granularity = ig;
> +	cxld->hpa_range = (struct range) {
> +		.start = p->res->start,
> +		.end = p->res->end,
> +	};
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
>  		dev_name(&port->dev), iw, ig);
>  add_target:
> @@ -1070,13 +1074,21 @@ static void cxl_port_reset_targets(struct cxl_port *port,
>  				   struct cxl_region *cxlr)
>  {
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_decoder *cxld;
>  
>  	/*
>  	 * After the last endpoint has been detached the entire cxl_rr may now
>  	 * be gone.
>  	 */
> -	if (cxl_rr)
> -		cxl_rr->nr_targets_set = 0;
> +	if (!cxl_rr)
> +		return;
> +	cxl_rr->nr_targets_set = 0;
> +
> +	cxld = cxl_rr->decoder;
> +	cxld->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
>  }
>  
>  static void cxl_region_teardown_targets(struct cxl_region *cxlr)
> @@ -1257,6 +1269,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> @@ -1315,6 +1331,10 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	}
>  	p->targets[cxled->pos] = NULL;
>  	p->nr_targets--;
> +	cxled->cxld.hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
>  
>  	/* notify the region driver that one of its targets has departed */
>  	up_write(&cxl_region_rwsem);
> 

