Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C8227BB9;
	Fri, 12 Sep 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697438; cv=none; b=QlszI6XLWQBTzQH69iIIhas5TpR7mM5P0lvmm/SpFdXF+UbGRctnsSnrYv9kHoupmWmcZGF8MhkJ4R345Ego850dC7TWpFNWL+rxvs7oQ9X4uag5bz78pIWhkeXjd1ZaqbFAmgR4+06WxKOB1xNMJqWg4xIJsnYZprEWpNM+NUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697438; c=relaxed/simple;
	bh=u/yVwKnakRNHsmfFIwesBmBc+b/wOH34do+VG5ATfkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqNeKa+9OVWHbc5eQaRBjpJXdjDBaPJiWbIHSx/8d0xbe2jGsaSzQ7w7A34rGOk3UXFTrXx0KZNp3K92vGhQTE42x5K2muAv/8nDJAZ6rZSU2BSKTodst6ZzplwnOzAbX4+pECflgpL31BFDeHVLGNuy6ujEKS2yieIl68jSDi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Ho9eZW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Ho9eZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757697437; x=1789233437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u/yVwKnakRNHsmfFIwesBmBc+b/wOH34do+VG5ATfkE=;
  b=Z7Ho9eZWU7PBRcwS3dknhYzbfwMqnIeDvwDR5w2TJOoX0KJ/kchZrLtk
   RH1SlXyhQT1LYDUxEI9monpKV5iYb/NV2pXn79iY8KabDr8pHhlK8WXcI
   wAQAf/aKGIJOupWlLuSn6pquv3yfG7chBHSKGBCteIfezxj2cp9S0SqH4
   OpQpa37Drd1E9N23q4rbTHTTbT2fNM+qJX/j7FYpchgUD2lEmRt/bK1Pv
   SHVmj7N46hctJZwPJdgKKumygQjhsoWcXcPtJTemLEBneyRAPnor70I85
   yuNv1GOayZkMubzQDx0BRoqH7WmvuVHNzJp17zAUIQZGD7KaTrXULgJRL
   Q==;
X-CSE-ConnectionGUID: cFgoFtJpQBeSp4CrP3vLEw==
X-CSE-MsgGUID: ZGuxs5q1SPeh5lULYTS/SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="70669549"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="70669549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:17:16 -0700
X-CSE-ConnectionGUID: PWELuoxASPCNbcsvnrO5qg==
X-CSE-MsgGUID: l3Ww9IV7Q0y2JBLSLx85VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="178332169"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 10:17:15 -0700
Message-ID: <fd4fc0f6-03a9-4134-9703-60705ec6898c@intel.com>
Date: Fri, 12 Sep 2025 10:17:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-3-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-3-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Just a nit below. Otherwise looks ok

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 17 +++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2c37c060d983..777d04870180 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  		return PTR_ERR(res);
>  	}
>  
> +	cxlr->hpa_range = (struct range) {
> +		.start = res->start,
> +		.end = res->end,
> +	};
> +
>  	p->res = res;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> @@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
>  	if (p->state >= CXL_CONFIG_ACTIVE)
>  		return -EBUSY;
>  
> +	cxlr->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
> +
>  	cxl_region_iomem_release(cxlr);
>  	p->state = CXL_CONFIG_IDLE;
> +

stray blank line
>  	return 0;
>  }
>  
> @@ -2400,6 +2411,11 @@ static void unregister_region(void *_cxlr)
>  	for (i = 0; i < p->interleave_ways; i++)
>  		detach_target(cxlr, i);
>  
> +	cxlr->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
> +
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> @@ -3458,6 +3474,7 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> +	cxlr->hpa_range = *hpa;
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 350ccd6949b3..f182982f1c14 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -518,6 +518,7 @@ enum cxl_partition_mode {
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
>   * @cxlrd: Region's root decoder
> + * @hpa_range: Address range occupied by the region
>   * @mode: Operational mode of the mapped capacity
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> @@ -532,6 +533,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	struct cxl_root_decoder *cxlrd;
> +	struct range hpa_range;
>  	enum cxl_partition_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;

