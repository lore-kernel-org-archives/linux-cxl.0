Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15B2E9EDF
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452692; cv=none; b=PDQQcD1/zVnmck7r7Q4VbHZ7/c1bieIIgzBajm131zj47cKfzZM/6W+LxeFcXuxXcrTfat6sflFVLqfg8ti4BG13XBiHHmopUguvwJ4NzmYW5dtMepo96icdcPpS+EmU6masfbtsBEUOBkGrS7Hrsvg4/K0ndblIHOIJaWuVstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452692; c=relaxed/simple;
	bh=dgrLZTaJ01shVASqnWm3rphX31gKhcOHFpmNeMMfF7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkV6WM6LJPw7t8UnvMJDzNdAJAe0TLaUGKRNPTNL7n6CkTpKL9afx7l8B27dWCDqyEvMHNFczcjOxU3vIXbTNCB4DZXWKY1uSSob14liOVpNs0DeIixt6IRzXG5K0FAyUsz+abF1li5qOciJYSlrZWaJ84fIBbt4n7morFm2aN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kC9dMHFu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kC9dMHFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452690; x=1791988690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgrLZTaJ01shVASqnWm3rphX31gKhcOHFpmNeMMfF7s=;
  b=kC9dMHFuLkJZiWd75SFNVhlVB1tuh/nGEdzZqsjI2djxtJrFKX4IkjeP
   5kC83qPHV6K/QsAIGIG5U3xLQIzklFyDdjatmpI2OIxIX8rqvuSmqSlgr
   pGVqqn0cnPQrz4c5c2iOVFNAgd98ed4fpp32uhcFot66l9FHFz8b5jnLM
   GSHibm8LX6qMqWhH65jJ9j7S92Dy0jfwh+HpU2Pd4B9odJbO4T0zjvGQP
   bMZlLyf+5ZXEIAuiQwAcZc3+oEAqmH8hRBJvTYjyn3oTFQHd1yeKzrm3i
   tUEs8xUCaLYo9nuaq6ImORC3eXbMH+zNA6wdX1ETEr4d/CkNE96Co12Tp
   A==;
X-CSE-ConnectionGUID: 5BfyQMgHT1edB6YZaJDYIA==
X-CSE-MsgGUID: AQlAi2kWSlmiN6ADlDMK6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="80246968"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="80246968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:38:09 -0700
X-CSE-ConnectionGUID: B52Bd9fUSZqljpI9WgXAIw==
X-CSE-MsgGUID: ffSxew0mSGCb3MUdgkKbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="186321130"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:38:08 -0700
Message-ID: <0a3201ec-3169-4e08-93e0-87a514d46a61@intel.com>
Date: Tue, 14 Oct 2025 07:38:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Use %pa printk format to emit resource_size_t
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20251014073106.730952-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251014073106.730952-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 12:31 AM, Alison Schofield wrote:
> KASAN reports a stack-out-of-bounds access in validate_region_offset()
> while running the cxl-poison.sh unit test because the printk format
> specifier, %pr format, is not a match for the resource_size_t type of
> the variables. %pr expects struct resource pointers and attempts to
> dereference the structure fields, reading beyond the bounds of the
> stack variables.
> 
> Since these messages emit  an 'A exceeds B' type of message, keep
> the resource_size_t's and use the %pa specifier to be architecture
> safe.
> 
> BUG: KASAN: stack-out-of-bounds in resource_string.isra.0+0xe9a/0x1690
> [] Read of size 8 at addr ffff88800a7afb40 by task bash/1397
> ...
> [] The buggy address belongs to stack of task bash/1397
> []  and is located at offset 56 in frame:
> []  validate_region_offset+0x0/0x1c0 [cxl_core]
> 
> Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e14c1d305b22..4e567f7e06bc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3666,14 +3666,14 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  
>  	if (offset < p->cache_size) {
>  		dev_err(&cxlr->dev,
> -			"Offset %#llx is within extended linear cache %pr\n",
> +			"Offset %#llx is within extended linear cache %pa\n",
>  			offset, &p->cache_size);
>  		return -EINVAL;
>  	}
>  
>  	region_size = resource_size(p->res);
>  	if (offset >= region_size) {
> -		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pr\n",
> +		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pa\n",
>  			offset, &region_size);
>  		return -EINVAL;
>  	}
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

