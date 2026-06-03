Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA21C5F27
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jun 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530934; cv=none; b=YxpDDhDE38eyQrOOeOZF97QN/H8efjlCoUNn0nwBiyJSIJBSghMAQd8QuDSmyXMKv//WPvWPGOY5KfyGJsl3d+3cHPwBhJ3qShJWz6DSFAMqFUF6WDW5FeotKDuvviRAYOoUmfhvQSuLN3G7OMTnYM+j6fwwczKatHVnmT9HJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530934; c=relaxed/simple;
	bh=qqWvtV5zIshjWamEC7ri0y/1sSFXs/zo4uLIjRRBqzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEXmEZWQ0Dekc3cq/RoFbOXzcU4xm7bUfknQWrJzjn+dPiMEUBID87tHsOC8zZ1HXW1YAygHjXT/K03w0Yp21rBb0rRQZU5yNUyM5XQgLkBVlOPO+Ry/5wQQbZUXb9OUltkgIpRpVvWw73D2ncGG6iLQm8U68TerKwyL0OQpQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7CbfsZF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7CbfsZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780530933; x=1812066933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qqWvtV5zIshjWamEC7ri0y/1sSFXs/zo4uLIjRRBqzo=;
  b=E7CbfsZF7cNCq5/3kApxoDFtYoU4vcZ3eqSkicnMtcVias9Nr0c27b01
   RtEVyPPr/aXmZXScrPGq0qBGjwQlJIEIl7i+7jiU/urME+QW2M9QT3U4I
   vAfLe5rIf4kBIIM/GuBv1Q5g/oW4DXKFd2/QUy363YwoX6eYSOXVkZZFH
   fGDO1jD+fhDCl9ASZv/I+kcdeMrKmmQ+TbryvJdpgzdgDOUjCkS8xZzJ/
   TCwJguLuSuAzJNdBmRjrYFZ58FWh7PUk7WWzrzmNVohE6X+47+tv4w3Ln
   f8TArezeAnNSWzzLjYAXrCoJgva6Joa6qmXgJMQfJj9ccSTm8LiozkHR3
   g==;
X-CSE-ConnectionGUID: HBeqdNHTSvW8LTOIQQpiVQ==
X-CSE-MsgGUID: iYi9LLamQJOw7C/hKYntgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81330214"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81330214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:55:32 -0700
X-CSE-ConnectionGUID: fo8u9W7sR6OboH1PKdL8Sg==
X-CSE-MsgGUID: vKfPDu5rTeiq274gAYxPgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244500649"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.116]) ([10.125.108.116])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:55:31 -0700
Message-ID: <94fb1064-b476-4990-ba5d-b03a7245395a@intel.com>
Date: Wed, 3 Jun 2026 16:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cxl/region: Validate mixed-granularity at sysfs and
 attach gates
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1780095671.git.alison.schofield@intel.com>
 <aad9e586a2184f1e9a1ebec04c3809edc6268cbe.1780095671.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aad9e586a2184f1e9a1ebec04c3809edc6268cbe.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/26 5:00 PM, Alison Schofield wrote:
> User-created regions are validated at sysfs write through
> set_interleave_granularity(). Auto regions skip that path. Both
> need the same mixed-granularity rule applied before the per-port
> selector walk runs.
> 
> Replace the same-granularity sysfs check with is_ig_allowed(),
> which permits any region granularity not greater than the root
> granularity. Call the same helper at attach time so auto regions
> get the same rule.
> 
> 3-way-family roots (3, 6, and 12 ways) need an additional check.
> A 3-way interleave consumes no selector bits, so selector containment
> alone cannot prove that the root and region cover the same address
> span. Add an explicit ways*gran span equality check in
> cxl_region_attach() for these roots.
> 
> Endpoint decoder capability is still checked at attach time by
> check_interleave_cap().
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

A nit below.

> ---
>  drivers/cxl/core/region.c | 57 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cc8ab2ad5228..61e6bb73249e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -559,10 +559,29 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
>  }
>  
> +/**
> + * is_ig_allowed() - Validate region interleave granularity
> + * @cxlrd: root decoder
> + * @ig: proposed region interleave granularity in bytes
> + *
> + * Callers must have validated @ig through granularity_to_eig() first.
> + *
> + * Return: true for a non-interleaving root or any region granularity
> + * not larger than the root granularity.
> + */
> +static inline bool is_ig_allowed(struct cxl_root_decoder *cxlrd, int ig)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +
> +	if (cxld->interleave_ways <= 1)
> +		return true;
> +
> +	return ig <= cxld->interleave_granularity;
> +}
> +
>  static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc;
>  	u16 ig;
> @@ -571,15 +590,7 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	if (!is_ig_allowed(cxlrd, val))
>  		return -EINVAL;
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);
> @@ -2128,6 +2139,32 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/* Apply the sysfs granularity rule to auto regions too. */
> +	if (!is_ig_allowed(cxlrd, p->interleave_granularity)) {
> +		dev_dbg(&cxlr->dev,
> +			"ig %d incompatible with root ways %d ig %d\n",
> +			p->interleave_granularity,
> +			cxlrd->cxlsd.cxld.interleave_ways,
> +			cxlrd->cxlsd.cxld.interleave_granularity);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Selector containment cannot prove span equality for 3-way family
> +	 * roots because a 3-way interleave consumes no selector bits.
> +	 */
> +	if (!is_power_of_2(cxlrd->cxlsd.cxld.interleave_ways) &&
> +	    (u64)p->interleave_ways * p->interleave_granularity !=
> +	    (u64)cxlrd->cxlsd.cxld.interleave_ways *
> +		    cxlrd->cxlsd.cxld.interleave_granularity) {

Looks like cxlrd->cxlsd.cxld.interleave_ways and interleave_granularity used in a few different places. Maybe use a local var to not having to keep referencing them?

DJ

> +		dev_dbg(&cxlr->dev,
> +			"region ways*gran (%d*%d) != root ways*gran (%d*%d)\n",
> +			p->interleave_ways, p->interleave_granularity,
> +			cxlrd->cxlsd.cxld.interleave_ways,
> +			cxlrd->cxlsd.cxld.interleave_granularity);
> +		return -ENXIO;
> +	}
> +
>  	if (p->nr_targets >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
>  			p->nr_targets);

