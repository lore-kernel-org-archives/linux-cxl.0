Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E736482EB
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795792; cv=none; b=PXAXkdIaqYocpjdo87gOjOCb1hD/txrv3rcitz8GqHDSQN5iaQnhFRfOhABdx+GdzvaZjMVPAM1fq6RxyeTno6YOJpCQ4yhlH97CR/UnkfdegGNiSSWgcRBfgGBWPpmvuqpiGvkrRt/8GXdbHRmJ07qX/IvApa1pDVxeyDZQNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795792; c=relaxed/simple;
	bh=/WyYLQkpYlfzj3yfifds9wdHnl6ZDTHD0vRZ2kwUgQ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpgasROai2jLmwtQsGHBmctYRZKB3WIbWaN+hEEMICazQA5hYQ4FYYVkJK17woBIy5/+HJx6y0Le/F52AwOsfYLpMtldz6tpYeHK4mD072CdLEQDT3jY+StSp5ucs27uVQX0Y/Nk9HRIYohHr3CeQNQzC4QQQ/mFvK6PHF+FKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwmYC36T; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwmYC36T"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so148740a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764795789; x=1765400589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LC256SHUkCml7GwBbBY5e3veHzv5ypc1t4cRzd8j1zI=;
        b=VwmYC36TLktCFIm/uKgQwnThk5j71GgWJhyHCrQY+ReWLogFHC1XaYN1JzdjnUBNiH
         fsuym16XFFO1dex+U+hoJ2rAYemVOdcGxniKDH0VxHcNpMlBcgxfZW0MbuYi9w9rHnUI
         FDVk8FwqPFTHPlJ/3Taigtrt4wRgeGvMDN2p9H7iVUiQInqkURqlm6raqKgT2mzcpG9O
         5N2BC2xhs8BhO3DymjRA2n1h9+rkUVpNW52xQlyf1vuhc14w21FSBayfvmmnTXLjeP9k
         ZPbaONhf3/6mK5kxirhs+BwYthS0NQ4DBoKZSvSm+WWA71No6Z9PnDKZekh+O+49L27O
         +xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764795789; x=1765400589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC256SHUkCml7GwBbBY5e3veHzv5ypc1t4cRzd8j1zI=;
        b=psI4ohL1aiCcCK1nU5gckZdoNV6xAX6h1LOHP9L4hOQ3475Al1G9f4FA+E9O1uY1mB
         AgE2WyoTHGwZoXvZ+CPjz3EDUk9oVg/wVTnkGYnn3cYJx96SUYSW66vsTNxqKOowRhy8
         WYO/uZctMdzEdnbIdPbkycAc0vmTqb8DAi7ltlmix+DY3iDBg8K01amJaYCOLb3M+s9u
         Rfh4B/49YyI5/9tp5Pox449gVNasKwtUtG4kPbn911f9lQkIkeApwHJpdbovb8weXGqm
         ZLMPfwWIxUOKpvDaiAx3AS9hNFRYagK5uUAAj70Jlb2cgYflPO0zJj5dn1Z4mrPHhLt2
         iCJg==
X-Gm-Message-State: AOJu0YwMlKRdZNA8qoXpEk4g0YrwulIvn83nPuLhr/V08ZzrQhEPrGxM
	DTeIwr0UsqYAhWbHVIdmJ96I8m+At1inY1lmBPlzuoLXc/wqYWp9YtoXeq7dgA==
X-Gm-Gg: ASbGncuYSJGQ593drM7JJuIbbfmgTd7P8kmUvIjXXpOSJYBYOzHY2wD8IeXnoWuZz7I
	tY/BzPxox5D9dmwaHDVAzYfMIiFGYSNU9mXlhhgaUn8RYEuZakKPjrYtVLa0RWSPHZ9t7yxuV9J
	cRqieLV7m3hCKKqsTszt22Y9ibV6WRR1lG8hQtAKKLuEutqWYioUFtCbcvFlwuGLyEG1PFLt3Hg
	bBso+xaD1LTKqyLam7gODEhIo6dfOV48wbQstAHcDpu7B+ZFk2GXcUGKtoVqBUy+CSknPjg8PCp
	SlM+F9RgaXMdEpKHKom3Bzs1LYLpgvZgFR4ZeY6Q3Eyip2rstbHBz1z++0lDFJvxLxfojFFJRbC
	tewvdvFpiXJJ+eyWXJG8/Qe/ceYwlqsRNPj/IpMC3GjcqiF4iuMl6r1p/K4P5nWU8aFBUnw8aGj
	SMQAM2gSHYsmecSnOQp+aKo8+8k5OAtKBIE6PMXw==
X-Google-Smtp-Source: AGHT+IGK8BNQWoq1ceijo6VP6ZvenpT043PdyDHHV2cEm55QdVP0tjs2sLjbeijui67pw5b0zU67zw==
X-Received: by 2002:a17:90a:ec87:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-349125d0973mr4072482a91.14.1764795789428;
        Wed, 03 Dec 2025 13:03:09 -0800 (PST)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde2350sm18818284a12.9.2025.12.03.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 13:03:09 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 3 Dec 2025 21:03:07 +0000
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 2/3] dax/cxl: add existing dc extents when probing
 dax region
Message-ID: <aTClixkIjKTMJJjA@deb-101020-bm01.eng.stellus.in>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <20251203203540.1091827-3-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203203540.1091827-3-anisa.su887@gmail.com>

On Wed, Dec 03, 2025 at 08:29:12PM +0000, anisa.su887@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add existing dc extents on the device before probing dax region will
> cause the creation of the dax device fail as resource cannot present
> when driver is bound to the device as shown in really_probe().
> 
> We delay the processing of existing dc extents to cxl region driver
> probe.
> 
> Question: the guard() in cxlr_notify_extent() will cause lock issue,
> removed it. Not sure whether it will cause issue or not although no
> issue is observed during test.
> 
Hi Fan, I added the guard() back in when I was testing  and did not run into
any issues when.

Do you recall where you ran into the locking issue?

- Anisa
> Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
> Tested-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> ---
>  drivers/cxl/core/extent.c |  2 +-
>  drivers/cxl/core/region.c |  8 ++------
>  drivers/cxl/cxl.h         |  5 +++++
>  drivers/dax/cxl.c         | 24 +++++++-----------------
>  4 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 3e7295d3e5e2..3b0e4d72d4ac 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -285,7 +285,7 @@ static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
>  	dev_dbg(dev, "Trying notify: type %d HPA %pra\n", event,
>  		&region_extent->hpa_range);
>  
> -	guard(device)(dev);
> +	// guard(device)(dev);
>  
>  	/*
>  	 * The lack of a driver indicates a notification has failed.  No user
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index adab1f338ee9..da3ea3cf8585 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3232,7 +3232,7 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int cxlr_add_existing_extents(struct cxl_region *cxlr)
> +int cxlr_add_existing_extents(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i, latched_rc = 0;
> @@ -3251,6 +3251,7 @@ static int cxlr_add_existing_extents(struct cxl_region *cxlr)
>  
>  	return latched_rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxlr_add_existing_extents, "CXL");
>  
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
> @@ -3287,11 +3288,6 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> -	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
> -		if (cxlr_add_existing_extents(cxlr))
> -			dev_err(&cxlr->dev, "Existing extent processing failed %d\n",
> -				rc);
> -
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>  					cxlr_dax);
>  err:
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d22fe5e50647..3e400dd4f08b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -926,6 +926,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
> +int cxlr_add_existing_extents(struct cxl_region *cxlr);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -948,6 +949,10 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>  {
>  	return 0;
>  }
> +int cxlr_add_existing_extents(struct cxl_region *cxlr)
> +{
> +	return 0;
> +}
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 011bd1dc7691..15fc2de63185 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -18,21 +18,6 @@ static int __cxl_dax_add_resource(struct dax_region *dax_region,
>  	return dax_region_add_resource(dax_region, dev, start, length);
>  }
>  
> -static int cxl_dax_add_resource(struct device *dev, void *data)
> -{
> -	struct dax_region *dax_region = data;
> -	struct region_extent *region_extent;
> -
> -	region_extent = to_region_extent(dev);
> -	if (!region_extent)
> -		return 0;
> -
> -	dev_dbg(dax_region->dev, "Adding resource HPA %pra\n",
> -		&region_extent->hpa_range);
> -
> -	return __cxl_dax_add_resource(dax_region, region_extent);
> -}
> -
>  static int cxl_dax_region_notify(struct device *dev,
>  				 struct cxl_notify_data *notify_data)
>  {
> @@ -66,6 +51,7 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct dev_dax_data data;
>  	resource_size_t dev_size;
>  	unsigned long flags;
> +	int rc;
>  
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
> @@ -80,8 +66,12 @@ static int cxl_dax_region_probe(struct device *dev)
>  		return -ENOMEM;
>  
>  	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A) {
> -		device_for_each_child(&cxlr_dax->dev, dax_region,
> -				      cxl_dax_add_resource);
> +		rc = cxlr_add_existing_extents(cxlr);
> +		/* If adding existing extents fails, continue with only an error
> +		 * message ?? */
> +		if (rc)
> +			dev_err(&cxlr->dev, "Existing extent processing failed %d\n",
> +				rc);
>  		/* Add empty seed dax device */
>  		dev_size = 0;
>  	} else {
> -- 
> 2.51.0
> 
