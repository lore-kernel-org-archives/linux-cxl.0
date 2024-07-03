Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF411822CA;
	Wed,  3 Jul 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025750; cv=none; b=tmlxng1dMBkOOVSXv6/yn5sYyg9ofRwzOF6lFGUCrbv9eBpe1RmzP6m+A1KNlR8Hm3/eXohni54udDm6nDLYHO60A/QdgVTCfsuO5yuETxCU8lkOwC4Lb3JC+j5Gp64DQf7ddOjip3bbW5+SAd1ODWUh031qmkLbkmRjpW4ePwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025750; c=relaxed/simple;
	bh=vZUBlhySW0RHV3fvklmfKPM6YDzdvbxtH19w5yjdr/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuDgeyueYz7dAtFqMzKo6/uSC+MXijuEsq8SktdGinI+Ylgz0V2c5btGitfEKo0EbMV+nnW/CmCTk4v37Zuj2nxi/sLkAVJaBo1zz8kTKExBmrAje0iIaEFN6f2ZHaIFGVIDOOuse+NFCRpf+WZUlKAwPpnonpUYCUkP7tXj4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hy6rwH0+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hy6rwH0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720025748; x=1751561748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZUBlhySW0RHV3fvklmfKPM6YDzdvbxtH19w5yjdr/0=;
  b=hy6rwH0+XTtK7Y2iQL6ex0qILrrsqr2Y64eMRb62NUQcMs9W+EZiG5kN
   9IJU3h8muJmK+9foCSllxL+4vnIWB6iSZZl1lqeXo0ke6KVTsgg4DBPXc
   4Jkn/9Phjmo8u6jek8kZ6IpLiyTzrDootRSTldB82CKsO4loh/xcdAGMM
   XRH+HwSwjfl4EWvbuh0HVnRvMg37i2G5vxg0VKHfkscnYqUv4y7v+x3L8
   MgU5lVa8NFzwpXCpbmB1rZtf2ULKX6bMCCrUf2yCyXlnjR8IRomHalC8A
   zgwOT2ocj2PtaobcO1j0LUXbOTTHr/gdn1LUk5swGQ9H6VU77vnmXtKK7
   w==;
X-CSE-ConnectionGUID: Gg6HiygLT4isIZuFmHl1Ug==
X-CSE-MsgGUID: k33UORmWT2OGt0cbW2flRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="34809455"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="34809455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:55:43 -0700
X-CSE-ConnectionGUID: gzS9zEpwQbK2l8ws/JgXsw==
X-CSE-MsgGUID: oz3RIjf6QTqbYfGQBOMT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50912361"
Received: from mrlemay-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.55.113])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:55:42 -0700
Date: Wed, 3 Jul 2024 09:55:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: simplify returning pointer without cleanup
Message-ID: <ZoWCjAHSOKQLDkF2@aschofie-mobl2>
References: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>

On Wed, Jul 03, 2024 at 10:30:55AM +0200, Krzysztof Kozlowski wrote:
> Use 'return_ptr' helper for returning a pointer without cleanup for
> shorter code.
> 

My first thought on this was that I prefer the explicitness
of pairing __free(kfree) with no_free_ptr as was done here.

cleanup.h defines this: 
#define return_ptr(p)   return no_free_ptr(p)

I did read the comments and am still confused. I see you posted a
handful of no_free_ptr to return_ptr patches. What is your selection
process for changing these?

--Alison


> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..1e4bed8a933e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -339,7 +339,7 @@ static struct resource *alloc_cxl_resource(resource_size_t base,
>  	if (!res->name)
>  		return NULL;
>  
> -	return no_free_ptr(res);
> +	return_ptr(res);
>  }
>  
>  static int add_or_reset_cxl_resource(struct resource *parent, struct resource *res)
> -- 
> 2.43.0
> 
