Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E753F0750;
	Fri, 29 May 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072788; cv=none; b=QkSIWpN99qEK5+Sfmro1xdsHjIFIBO5SKmdGORYQ8i73qrrF3SYNQDTJfKRIAtzmD/jtzs7zk0XS85K6JsUR6K5GODLLJyJaxSHVCxaKLLmgM6UF+zpW5epF9pxu4rcybnbWmslI1mSpVwqBu80GrFOkGaSU9Xs6m8Hq95n0OUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072788; c=relaxed/simple;
	bh=0lDFVf8kc8bF0CfoVfXw8FtTrY0OqM9jhpFXC2oTxTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjYvlDiLT3tu9xmdXneaeE9hZzm2JnFHyp6oSdzlocNrt1ziI+ncJL5Eca2OWXJxV/kmbza7Mq1uSnU1wiAsnHD7fVxe/z1pH+1gfWarErb6xCCGO9qR+TIC3KR0mkKNViC1EvpuerA5IgD/sIeQuv8NKBoXEvdGGny17bklDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsIqSLCI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsIqSLCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780072783; x=1811608783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0lDFVf8kc8bF0CfoVfXw8FtTrY0OqM9jhpFXC2oTxTc=;
  b=nsIqSLCIgQ7wwvlfuopsHVTERU/DFaJaXxjNXlPyx4ML1e/joxJ8YK6s
   rPDcqPWlTHhC9mIA1wWkYJroUsfVWrWX46Rw6rG83DoeDCNcGaUqsStVt
   XGG75kN91VgsACyz2BDemlxP7NwMl8nbPTBbVKmX8mYuzuRb9IqeBvPFr
   YYDELyiPsBIjuVPvjbe9BuVib8tj/4ALhkBmT3vIfXTWFpE1WNKZKyHeW
   zC0cRGbyeSNVYmBe3Lw8G59j04h9VkgC6JnRZyoTE6SP5Un1cc26aSXGm
   pDP0gNKUgVctqCMd9f7h6DhMFrvlgFDHH4f85nkkoHaqVyTYOcZvEFIuo
   w==;
X-CSE-ConnectionGUID: C/2/JsMuR+SV0gT38muXjA==
X-CSE-MsgGUID: 2O56VVwiRDGMiTulCN9OMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80780857"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80780857"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:39:43 -0700
X-CSE-ConnectionGUID: PB1OS2fDQBajpq65+/vDyw==
X-CSE-MsgGUID: vvcFBA6fS4GWXul6dulOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="244726348"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.151]) ([10.125.111.151])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:39:42 -0700
Message-ID: <0ae559b3-5408-4290-b7ea-ef964fd880cf@intel.com>
Date: Fri, 29 May 2026 09:39:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260529132533.1144383-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260529132533.1144383-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/26 6:25 AM, Li Ming wrote:
> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> accessing p->targets[]. However, cxled->pos can be set to negative errno
> in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> causes the driver to use a negative index to access p->targets[],
> resulting in out-of-bounds access.
> 
> Fix it by walking p->targets[] instead of using cxled->pos directly.
> 
> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next
809ccef5385fa1779c7db3de43272f3fc6a87a45

> ---
> Changes from v2:
> - Revert "Fix potential 'hole' issue." changes. (Alison)
> 
> Changes from v1:
> - Update commit log. (Dave)
> - Update comment in cxl_region_sort_targets(). (Dave)
> - Fix potential 'hole' issue. (Alison & Sashiko review)
> ---
>  drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..eb96cb3cae83 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
> -		 * cxled->pos so that follow-on code paths can reliably
> -		 * do p->targets[cxled->pos] to self-reference their entry.
> +		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> +		 * dev_dbg() for every member. which is useful for auto
> +		 * discovery debug.
>  		 */
>  		if (cxled->pos < 0)
>  			rc = -ENXIO;
> @@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static int cxl_region_by_target(struct device *dev, const void *data)
> +static int cxl_region_remove_target(struct device *dev, void *data)
>  {
> -	const struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> +	int i;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
>  
>  	cxlr = to_cxl_region(dev);
>  	p = &cxlr->params;
> -	return p->targets[cxled->pos] == cxled;
> +	for (i = 0; i < p->nr_targets; i++) {
> +		if (p->targets[i] == cxled) {
> +			p->nr_targets--;
> +			cxled->state = CXL_DECODER_STATE_AUTO;
> +			cxled->pos = -1;
> +			p->targets[i] = NULL;
> +
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
>   */
>  static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
> -	int pos = cxled->pos;
> -
>  	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
>  		return;
>  
> -	struct device *dev __free(put_device) =
> -		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
> -	if (!dev)
> -		return;
> -
> -	cxlr = to_cxl_region(dev);
> -	p = &cxlr->params;
> -
> -	p->nr_targets--;
> -	cxled->state = CXL_DECODER_STATE_AUTO;
> -	cxled->pos = -1;
> -	p->targets[pos] = NULL;
> +	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
>  }
>  
>  static struct cxl_region *

