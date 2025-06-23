Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5126D4E7;
	Mon, 23 Jun 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690867; cv=none; b=iM18P2FUTTh3mC6MGUbr8aU/zWVmhw0O1Nzdu13uDUBF+uEBOtUkAGRAQBE3FazyvxrBR/uVclecsTG+Ayv8sVnYG3QKj9hD80OSO4neLKy7YRoTDbgtD56BaRXmcY1scQX2IEwHI7Jw0W7hITjN1CZ+R2ujYMe7zxx8pqsV79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690867; c=relaxed/simple;
	bh=JN12mAqzTSh0bYgfT8fjsVd+tu+xINaWmEHCRlPeB7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FilarpH8rIMoC3HBnBnBe4U5TAz2z7T7BNnw0H4kWKExcvvkl2uY+OIZuu5PYhlh0xduf0/4XTcBW4UB+OE3fo/V85TpWnI1gTXg82GBj4UnOwbNWyvOC6yVPwAT9LNjzWvY+4r2baft65i08mA20tH+OJ4OWB8aNoZrAos/hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlDTYJ7S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlDTYJ7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690866; x=1782226866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JN12mAqzTSh0bYgfT8fjsVd+tu+xINaWmEHCRlPeB7Y=;
  b=VlDTYJ7SvSHW8+Ew/jODWDOE3l8lVkcIsyk+xplFhroCzyfPv5XqNGer
   AjgdKz2WLcqL764wQQM4GR/i4ogZHs1Vemvz9/PaowgPEnNyi/Cx+iIb9
   xGGswv6rjjZHlFjV98w3QiIAyg7qkrnO60Q7HK6NNBEjNY5PJ5+Iw+xil
   qllq+79IntKAREfh7EbnhRB+dvcaLzUZQ+OWOBzNj/X55Sm1FqtZ9i0HA
   48lxMhVtnGYoxTfqHln+4apz552lpyElus6OrhucOMHJkXCG16bcgE7K3
   bnUq6/M+7Elr0F604J+sxkQV0pGXR75d9sloWjq5ihf4MONf45ygJTC7l
   w==;
X-CSE-ConnectionGUID: TCXZ6krbTM+ju07ps+lYmw==
X-CSE-MsgGUID: vCnoF6/8SFqZzyBp5t2TgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53043475"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53043475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:01:05 -0700
X-CSE-ConnectionGUID: vG/M1yqCQwaBfW7kdL58Kg==
X-CSE-MsgGUID: LkL7E6OCSmig7VPDpAoLQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151772143"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.178]) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:01:04 -0700
Message-ID: <42ab17a8-dec7-4cc5-b2b0-8b00605a9505@intel.com>
Date: Mon, 23 Jun 2025 08:01:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] cxl/region: Move ready-to-probe state check to a
 helper
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-7-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250619050416.782871-7-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/25 10:04 PM, Dan Williams wrote:
> Rather than unlocking the region rwsem in the middle of cxl_region_probe()
> create a helper for determining when the region is ready-to-probe.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3a77aec2c447..2a97fa9a394f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
>  	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>  }
>  
> -static int cxl_region_probe(struct device *dev)
> +static int cxl_region_can_probe(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc;
>  
> @@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> -	/*
> -	 * From this point on any path that changes the region's state away from
> -	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> -	 */
>  out:
>  	up_read(&cxl_region_rwsem);
>  
>  	if (rc)
>  		return rc;
> +	return 0;
> +}
> +
> +static int cxl_region_probe(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	rc = cxl_region_can_probe(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * From this point on any path that changes the region's state away from
> +	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> +	 */
>  
>  	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>  	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;

