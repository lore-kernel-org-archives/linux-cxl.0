Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556003D903A
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227989; cv=none; b=phTYtxCl2H2XsuopIONZ2U1r9VTEttejO752oe7tO3NGgyah93QkNqLFnyIpUXNJCKu7CCuCaV8u0ST+15VzwoVAm/FjDmoBcy2P4MSKPp8wAq1M/+4rzA9nkLFngS9yB2DGV1Oqnkm/R8kIgknllBGWJ6FHYVrv0aZDiOBeR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227989; c=relaxed/simple;
	bh=RoPG6YIFjhAiVlNOVv6FzPR/BhZbc60TC3uOk8/n724=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umOVGTkBTX7VSTVnrOSdjxyAplJHnAR42jhS5VBVTTTvXteCZW10qqP1Bd3JETpguOJrSmLbEnovoLEByiXmdWMAbablsKrtWntILLHMVnl2hYoMT1JY04CFUfo19SH6c/I0LeCzqAmVe9bsWqqkrpuE5upp5FrZ7GCUVPtYaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmyL5hDv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmyL5hDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779227987; x=1810763987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RoPG6YIFjhAiVlNOVv6FzPR/BhZbc60TC3uOk8/n724=;
  b=NmyL5hDvE7tXVCKPxJyVmSYT1PhIyTnwkXhThTRb7FnXHDazYI6lTAoE
   DFcKqGbg5W9cYCJcWTE+sCd/TL/6TOMAyPBJR0q8iC2a3WqBW3LjOaly8
   S4EBH6j87uw0RT041H8pZ6svWOZ8wrWVxO2T/zUJXq0XsU5vwh6ypPR2T
   N58XM3FDHywPB/oe7sptZaVTWoHdl81KBcw1UAAb+qOLuaa1UVpXWDwyl
   DR2xd0skK3tg6GU5NAvhYsqEo/MReZTF6L1FKUkA+mC5CQR/81OdCvk1j
   dvPPCJ/fN9S+ahKDu3kHh2rF517JneXudI6AOgdgOqnrlWeb/U2gRABkM
   A==;
X-CSE-ConnectionGUID: WjKh5Je5T5GdSU+GWxl9Bg==
X-CSE-MsgGUID: 4HNhjl7aQ2aDmmF/N0rPTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80293005"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80293005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 14:59:47 -0700
X-CSE-ConnectionGUID: BO/Xl4qHQK2xca5gfcTdgg==
X-CSE-MsgGUID: WPKnabhISd+HbU9jk8oCTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244878381"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 14:59:46 -0700
Message-ID: <f90fac65-4ee4-44cf-851d-aad7afd282f8@intel.com>
Date: Tue, 19 May 2026 14:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cxl/region: Block region delete during region
 creation
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-2-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519210158.1499795-2-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:01 PM, Dan Williams wrote:
> Expand the range lock, rename it "regions_lock", to disable region deletion
> in the critical period between construct_region() and attach_target(), as
> well as the period between device_add() and registering the remove actions.
> 
> Otherwise, userspace can confuse the kernel. It can violate the assumption
> the region stays registered through the completion of cxl_add_to_region().
> It can violate the assumption that devm_add_action_or_reset() is working
> with a live 'struct cxl_region'.
> 
> It is ok for the region to disappear outside of those windows as that
> mirrors device hotplug flows where the proper locks are held.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxl.h         |  4 ++--
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/core/region.c | 12 ++++++++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..3900a0778571 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -359,7 +359,7 @@ struct cxl_rd_ops {
>   * @cache_size: extended linear cache size if exists, otherwise zero.
>   * @region_id: region id for next region provisioning event
>   * @platform_data: platform specific configuration data
> - * @range_lock: sync region autodiscovery by address range
> + * @regions_lock: sync region discovery, construction, and deletion
>   * @qos_class: QoS performance class cookie
>   * @ops: CXL root decoder operations
>   * @cxlsd: base cxl switch decoder
> @@ -369,7 +369,7 @@ struct cxl_root_decoder {
>  	resource_size_t cache_size;
>  	atomic_t region_id;
>  	void *platform_data;
> -	struct mutex range_lock;
> +	struct mutex regions_lock;
>  	int qos_class;
>  	struct cxl_rd_ops ops;
>  	struct cxl_switch_decoder cxlsd;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..6e7a70d51cfe 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2016,7 +2016,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  		return ERR_PTR(rc);
>  	}
>  
> -	mutex_init(&cxlrd->range_lock);
> +	mutex_init(&cxlrd->regions_lock);
>  
>  	cxld = &cxlsd->cxld;
>  	cxld->dev.type = &cxl_decoder_root_type;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..b5601e89e302 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2779,6 +2779,10 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> +	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
> +		return rc;
> +
>  	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
> @@ -2838,6 +2842,11 @@ static ssize_t delete_region_store(struct device *dev,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_region *cxlr;
> +	int rc;
> +
> +	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
> +		return rc;
>  
>  	cxlr = cxl_find_region_by_name(cxlrd, buf);
>  	if (IS_ERR(cxlr))
> @@ -3776,12 +3785,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 * for the HPA range, one does the construction and the others
>  	 * add to that.
>  	 */
> -	mutex_lock(&cxlrd->range_lock);
> +	guard(mutex)(&cxlrd->regions_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
>  		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, &ctx);
> -	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
>  	if (rc)

