Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141F4A23;
	Tue, 19 May 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211095; cv=none; b=aFNZ6gRkwaOMnfuqRGITDhIeArXTts6hDy16XwCesFZtZWPWkNTzO20iMkSioRoJ5bVVPS85mZV+Uuh66JsoPXMKhM39eqNpOIExgkyHwAuC471Rlqu6FWSR7asJvvwBNFZU8wjia+JJH+ALyo859hO10oK8IUHz+/lQfIUkSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211095; c=relaxed/simple;
	bh=xZ7SaWzHuJ/AFLLKsF5v6gnLJIrz0hhjq+cFHxK5WB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0W2DITxTa7W/DADxYRDk2UEn59cwmiDDMobejaFK+h0FscJjwkh2MVO2ndgFdmXew80GhOhuPw0pa+0OBT4gbsnXgbzfitlFU50Is3ghPi7BgVju415jey1+hXo7o24jBg6UqivQQwXcOxoOi5FNx+VTwPgqHeL2uN6cqEFXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhrpabqV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhrpabqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779211093; x=1810747093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xZ7SaWzHuJ/AFLLKsF5v6gnLJIrz0hhjq+cFHxK5WB8=;
  b=VhrpabqVbL32Bx8RiBwL+4h0hVHAdivqT724AU4F0bjpDtywvZ6jjugq
   HNoNdC0MCU0F5t8XMib67HuW9H18YyEcYnnX1o0s1aWTyUYPFo0/gBS9/
   R0xXYSnx8As6Kb4YwLwEGw2wZxi+S0RjEzLfIknjJmB8iOfKJwDJ+4/Zk
   rYAAZytAb8ULRlKwuX6hnvaiEW5NccxJ1P4v1RECE7uuEs/WdhreseQc2
   cLW288OONQYeKx/OOz4QUaIEywdx7z0ms95cFeNtU/pTSfl2JKMUxFuvQ
   C8RE3dM2i7ILuEn65c667zjkAa+irPVV0u7Q4CRGrR9DlC9+PzgFfbDgq
   g==;
X-CSE-ConnectionGUID: NcOvrH29SLGuxRXVrZD4RQ==
X-CSE-MsgGUID: jFxqTygWT2O+ZawmHBcAtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90398782"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90398782"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:18:12 -0700
X-CSE-ConnectionGUID: v37Jv/RETlCdH8/UseEnrQ==
X-CSE-MsgGUID: YbUO2YBCR2mt8cZNvVnKtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239890202"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 10:18:12 -0700
Message-ID: <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
Date: Tue, 19 May 2026 10:18:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 6:23 AM, Li Ming wrote:
> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in

It can be set to other error codes I think? I would just s/-ENXIO/negative errno/

> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> causes the driver to use a negative index to access p->targets[],
> resulting in out-of-bounds access.
> 
> Fix it by walking p->targets[] instead of using cxled->pos directly.

Does the comment in cxl_region_sort_targets() need to be updated with the new changes?

> 
> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

The rest LGTM

DJ

> ---
>  drivers/cxl/core/region.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..551228bc91f5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2202,18 +2202,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> @@ -2222,25 +2234,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
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
> 
> ---
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> change-id: 20260519-fix_out_of_bounds_access-8838759ee5a6
> 
> Best regards,

