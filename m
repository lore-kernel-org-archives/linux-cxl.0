Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF92F7EF9
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227013; cv=none; b=pk07whyT4FuZYoPAKCiVI9MHEGo08zV5Sx+OPx5FP5+K22Lt6bSxaCOrWoGd7zEpwYo0sUDwXBO/603Iad6dT2hRuIkcQLUDfc05zmawy2XvtDiRnKYaxXUwPTTEYGqGD7q0VALCJUJRSrIun/MUghc/Qj7qq8K0/w95CH9sKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227013; c=relaxed/simple;
	bh=eoq6Ajz2XPcI0l1ASZFPIMGrx4XCpkADsVOpCgsgt9E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lJhp0GFlCzYxEX7oQSSpz4rhMNdjGNBmSkDTaKzc34eOoKovkFZ1IqmIu7arcMFQDHsxjPTVxWmyohyQSmD5ezDALxyI//F7fXGioziAoAhks8lw+S9oOBloYpw+KbVKBR6sqos2K4kAagESIDPxO/LxkyGAK13sgGmJedOLwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9guF45b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9guF45b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227011; x=1812763011;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=eoq6Ajz2XPcI0l1ASZFPIMGrx4XCpkADsVOpCgsgt9E=;
  b=D9guF45bExtxE7qbgYACY2Z7rzZtB5QYhR4hBrURpHCBCB+3uS3dS0LC
   3SiLH3fAXuD3gF+JT337W6ZhxEmbITJljaTwCku6wuofPu0W1745DPPAf
   RhrT2AYFIqEOZby4fo921ZkjhkN1rGzHvHNhNCFm41wOPqQRa0bGaeGEb
   RbhP1+LnbtgdRbsP0s89PXqgoQTtLY6SVSZKHnJ/wLts3iGKA9tDjIkhM
   xZYOgMq5RKB+A/k4lAcQnPzbnvoczJJOdujnmF1lGNOl+758c2kjCIcGm
   JWFZQOdN6g25ZKbOoFYBtJsWq9trljC5DM9fOSVG/W5n4Z6c+Q92Vwix/
   A==;
X-CSE-ConnectionGUID: uoXPCHXMTZmbbNqd6QmzmQ==
X-CSE-MsgGUID: GUTYGEzTSdCTFUeO6IuNPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82118617"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82118617"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:16:50 -0700
X-CSE-ConnectionGUID: pGqccRCkQDy9w3ttTHJCXg==
X-CSE-MsgGUID: Yd//bpL1RoyxMelLwGnSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246555940"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:16:51 -0700
Message-ID: <0d025ae2-7f10-40a6-bf9f-fbbe2e448948@intel.com>
Date: Thu, 11 Jun 2026 18:16:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Add check after kzalloc() memory in
 alloc_mock_res()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260611230305.197390-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260611230305.197390-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 4:03 PM, Dave Jiang wrote:
> alloc_mock_res() calls kzalloc() without checking the return value.
> Add scope based resource management to deal with the allocated memory
> cleanly.
> 
> Reported-by: sashiko-bot
> Fixes: 67dcdd4d3b83 ("tools/testing/cxl: Introduce a mocked-up CXL port hierarchy")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
dfe28c859253

> ---
>  tools/testing/cxl/test/cxl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6..e6f68dba85d1 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -433,12 +433,16 @@ static void depopulate_all_mock_resources(void)
>  
>  static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  {
> -	struct cxl_mock_res *res = kzalloc(sizeof(*res), GFP_KERNEL);
>  	struct genpool_data_align data = {
>  		.align = align,
>  	};
>  	unsigned long phys;
>  
> +	struct cxl_mock_res *res __free(kfree) = kzalloc(sizeof(*res),
> +							 GFP_KERNEL);
> +	if (!res)
> +		return NULL;
> +
>  	INIT_LIST_HEAD(&res->list);
>  	phys = gen_pool_alloc_algo(cxl_mock_pool, size,
>  				   gen_pool_first_fit_align, &data);
> @@ -453,7 +457,7 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  	list_add(&res->list, &mock_res);
>  	mutex_unlock(&mock_res_lock);
>  
> -	return res;
> +	return no_free_ptr(res);
>  }
>  
>  /* Only update CFMWS0 as this is used by the auto region. */
> 
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48

