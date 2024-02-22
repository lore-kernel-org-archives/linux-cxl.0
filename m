Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93741157E7B
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625515; cv=none; b=l66/yD78z7AITtSIODXQ3e7erwW4AEKoc7VES+4SZ14HUZarpWhsUhI/jOYSLQgGiUyWvdOgut+KSNSiNYTEEdTrE3/rAduLbf2OG50SWeAUUHyPUYBR4t9Me9T43GxrPQXOegmJUaaNHHUP+7KAOQMrETljh9BVXSCr6PlWoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625515; c=relaxed/simple;
	bh=CjD7OM/7tZy5nlzTvd1cKzKrON1q/7ZSLfRQTgUydf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBxOFAZOZAwfE7WR0eB/dWZ7uhoFeTlg3EQXElqvzYC3nbZ4u5Hy6K8gud3I5djGOHLw+Tt9y6fWLlSPh4kyuxXpRBzVdLg7n3S/njv03MKIGY3XN1yfCPSSVLVnUaaTAEuO4Wg97wY3SDHjR64PqVZ/4YJWIKdZ9uplDzJ8u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmMa94VV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmMa94VV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708625514; x=1740161514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CjD7OM/7tZy5nlzTvd1cKzKrON1q/7ZSLfRQTgUydf4=;
  b=HmMa94VVi6ebjOGdnRZY6xfiB4YSvYHVEC8q1+k5V/I3KDsDWE9ziVoD
   U9hrhfS6pS1twELzqyo3vHA3iR7TkwJZHhgUFr0EplKpb1ALZhTk0vsYH
   oiUMKFQbeqCMgfBzWVSPiYvz8B666rU48SzVgtGi4p7one6sAiwt+dmHN
   f2WY+8zIg68aocJhWokfcvw+lNI/LVpsXzEMQjd/rNhzEvU9jYKJCrf06
   sHM3W4iHPO9m+Bm7fjnAXRftqFuDderBcUccwW4sqm3DAYFSCjl5aV28+
   ++xrfo6hlSL7tWWX+3UOWwxasX+Q4c2mTKSQHWr0elH2YbHlSenYZBWOW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2755027"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2755027"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5968359"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.114.198]) ([10.246.114.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:11:05 -0800
Message-ID: <3088022b-c9e3-4ff3-985a-c3c2834c59df@intel.com>
Date: Thu, 22 Feb 2024 11:11:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Allow out of order assembly of autodiscovered
 regions
Content-Language: en-US
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Neha Agrawal <neha.agrawal@intel.com>
References: <20240126045446.1750854-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240126045446.1750854-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 9:54 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Autodiscovered regions can fail to assemble if they are not discovered
> in HPA decode order. The user will see failure messages like:
> 
> [] cxl region0: endpoint5: HPA order violation region1
> [] cxl region0: endpoint5: failed to allocate region reference
> 
> The check that is causing the failure helps the CXL driver enforce
> a CXL spec mandate that decoders be committed in HPA order. The
> check is needless for autodiscovered regions since their decoders
> are already programmed. Trying to enforce order in the assembly of
> these regions is useless because they are assembled once all their
> member endpoints arrive, and there is no guarantee on the order in
> which endpoints are discovered during probe.
> 
> Keep the existing check, but for autodiscovered regions, allow the
> out of order assembly after a sanity check that the lowered numbered
> decoder has the lower HPA starting address.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Neha Agrawal <neha.agrawal@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

s/autodiscovered/auto-discovered/?

> ---
> 
> Changes since RFC:
> - Declare auto_order_ok() as static (lkp)
> - Add Tested-by tag (Neha)
> Link to RFC: https://lore.kernel.org/linux-cxl/20240113050421.1622533-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..f6a49fd01ae9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -753,6 +753,37 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>  	return to_cxl_decoder(dev);
>  }
>  
> +static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
> +			  struct cxl_region *cxlr_b)
> +{
> +	struct cxl_region_ref *cxl_rr;
> +	struct cxl_decoder *cxld_a, *cxld_b;
> +
> +	/*
> +	 * Allow the out of order assembly of auto-discovered regions as
> +	 * long as correct decoder programming order can be verified.
> +	 *
> +	 * Per CXL Spec 3.1 8.2.4.20.12 Committing Decoder Programming,
> +	 * software must commit decoders in HPA order. Therefore it is
> +	 * sufficient to sanity check that the lowered number decoder
> +	 * has the lower HPA starting address.
> +	 */
> +	if (!test_bit(CXL_REGION_F_AUTO, &cxlr_a->flags))
> +		return false;
> +
> +	cxld_a = cxl_region_find_decoder(port, cxlr_a);
> +	cxl_rr = cxl_rr_load(port, cxlr_b);
> +	cxld_b = cxl_rr->decoder;
> +
> +	if (cxld_b->id > cxld_a->id) {
> +		dev_dbg(&cxlr_a->dev,
> +			"allow out of order region ref alloc\n");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  					       struct cxl_region *cxlr)
>  {
> @@ -767,7 +798,8 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  		if (!ip->res)
>  			continue;
>  
> -		if (ip->res->start > p->res->start) {
> +		if (ip->res->start > p->res->start &&
> +		    (!auto_order_ok(port, cxlr, iter->region))) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: HPA order violation %s:%pr vs %pr\n",
>  				dev_name(&port->dev),
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
