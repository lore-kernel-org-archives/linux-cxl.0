Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F3149C56
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154472; cv=none; b=oYOOLL76AiPTtqcJO9xFFpZW5i+wtPAJb6irlQ1yFINYFDWVpxiJmahXedyA78GDMxt2xCFLx9QNhRVKS6UA1w/2UMOIdM3B0XNs/dItu6nrr5pWbtf4moxLtnD19X0bmKV+YhAT8F1aueKrmijg9MJ+NxScFy43oRu563n224s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154472; c=relaxed/simple;
	bh=2dcUa5e/v3kyLDt/rmJgT0mlnFV2uVqd+WsXV1X8Sew=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxpendBJeBkjc3lu+6HkxXFqfx5ETBTClVyvXwKBiaz8vfX3W+kQWTdAJNTDnNcABoJYqTaSaJ0bkeVHYPwlg6yHNVRsgSI9BvLBUt+8uNLGIFabCJXNRF5VfS25934c2MOliW32L5mD/UGuZvnOap2s7KdE+479lCfbYZZqrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8n635fbDz67SnG;
	Wed,  3 Apr 2024 22:23:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 96498140B73;
	Wed,  3 Apr 2024 22:27:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 15:27:45 +0100
Date: Wed, 3 Apr 2024 15:27:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/core/region: check interleave capability
Message-ID: <20240403152744.00003b6b@Huawei.com>
In-Reply-To: <20240403021747.17260-3-yaoxt.fnst@fujitsu.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
	<20240403021747.17260-3-yaoxt.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  2 Apr 2024 22:17:47 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave capability is not checked, a target can be attached to
> region successfully even it does not support the interleave ways or
> interleave granularity.
> 
> When accessing the memory, unexpected behavior occurs due to converting
> HPA to an error DPA:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)
> 
> Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

I argued on the CXL opensource sync call last night that we'd get an
hdm commit fail (on working hardware - unlike current qemu) if this check
wasn't present.  Having thought more I think I was wrong and this is a
necessary fix because a device that doesn't support one of these ways
treats the HDM Decoder n Control Register / Interleave Ways (IW) values
as 'reserved'. Is it guaranteed to not just do that by fixing the higher
bits to zero?

If that's a possible implementation and the decoder was set to 6-way (0x9)
maybe the device would interpret that as 2-way (0x1) and give us the wrong
decode.

With that in mind I think this is a fix and needs a Fixes tag.


> ---
>  drivers/cxl/core/hdm.c    |  4 ++++
>  drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9bb6a256cc6f..1a99b138dbec 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -79,6 +79,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->ig_cap_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->ig_cap_mask |= GENMASK(14, 12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);

Whilst it doesn't matter as such (because they are always valid) I think
we should also st the bits for 1,2,4,8 so that all relevant bits are
enabled.

>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..25d178e14ed1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1786,6 +1786,36 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int
> +check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	u8 eiw;
> +	u16 eig;
> +	int rc;
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw > 3 && !(cxlhdm->iw_cap_mask & BIT(iw))) {
If you have all the bits set then you can avoid using eiw > 3 just
to check we aren't 1,2,4,8

> +		dev_dbg(&cxld->dev, "iw: %d is not supported\n", iw);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	if (!(BIT(eig + 8) & cxlhdm->ig_cap_mask)) {

This seems too simple.  Need to look at the calculations in
IMPLEMENTATON NOTE: CXL Host Bridge and Upstream Switch Port Decode Flow.

For a decode of more than 2 ways you need more bits to be supported.

> +		dev_dbg(&cxld->dev, "ig: %d is not supported\n", ig);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1796,6 +1826,17 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> +				  p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"%s with region iw: %d, ig: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev),
> +			p->interleave_ways,
> +			p->interleave_granularity);
> +		return rc;
> +	}
> +
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..da8a487ededa 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b53f7ae0fdd6..979c22955246 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int ig_cap_mask;
> +	unsigned int iw_cap_mask;
>  	struct cxl_port *port;
>  };
>  

