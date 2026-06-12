Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE63655DF
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297552; cv=none; b=odcz1R3FrNHC3TGl0HdIQl8K4dkiKokNPxx31yquSl3suBEAbzmL1Xya4GeihG9KMku50xTXEsnPqZikfkK0NBkch5N3/Vzt8HJnX6ZDVe/19AD+1J6XIKEBDRXiUwwEX2/hNeLOvk3XxN31lMQsH1B86DIV0yQ60EpOerLK5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297552; c=relaxed/simple;
	bh=5i1txt5bEl16TZ8ihuHhP27U9e0ro945Niq7zTB0r9s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QLXLXcngHjuWbmdTxAY8PpGfVOWR/Q6au9OEA1R0AN5h4lAeyqvijXrLxMSgzTd4FYgusZCDUx0WxM1j8kkk6AbYXBEqtMw0/DZuIjxdL+J6YeKlxTdA0vPgdAdd5O9PF6IthD7bUhbxSd83xPHA4Uo8Q9GiSD+sYdPQs91Vjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg0l6Ivp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg0l6Ivp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781297552; x=1812833552;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5i1txt5bEl16TZ8ihuHhP27U9e0ro945Niq7zTB0r9s=;
  b=Lg0l6IvpZF97fkZgE/eMud6dYD1+VvKUNpopwxb3BWFdzGsgTyMjT8ha
   dMWmfyLU1HNGMfRFQknHO0eonNFgRfsfvm21O7c4IJtDtX1Tj2IwGccXe
   amnmFwX27G7iOsSu6wHH5iIW8zjSyjNdngefy49uHjClL9+7GCfky48AY
   UmXYCNMJl1mKcJov7BjFs2dnIVU+iVdusqTwg6iU3tdkAtiSYdBL3JOTq
   lH7DalkBG4qYoCVxr3X/j672tdWvac0I/de7gcCHRWpJ7wrVdLXi9VASs
   dCbjXmaS1Irh8MW3pN972ZGjlu+c2efhB5bjIVzESRqiyzZpovwBwWz2D
   w==;
X-CSE-ConnectionGUID: E7Tr12VfSUS1MnLVN31z1w==
X-CSE-MsgGUID: 9thqhtJQRvW/CDSr4xECpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="104807321"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="104807321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 13:52:31 -0700
X-CSE-ConnectionGUID: S3s3hNvvSX6spf84qZUyBQ==
X-CSE-MsgGUID: 9pqLZ8BvQB6VyLYZlgAQUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="252016376"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 13:52:30 -0700
Message-ID: <393b32b7-775e-4e50-9c60-782b073b78f6@intel.com>
Date: Fri, 12 Jun 2026 13:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add dummy function for cxl_memdev_attach_region for
 !CONFIG_CXL_REGION
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, kernel test robot <lkp@intel.com>
References: <20260610001324.260268-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260610001324.260268-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 5:13 PM, Dave Jiang wrote:
> Add a dummy function that returns -EOPNOTSUPP for cxl_memdev_attach_region
> when CONFIG_CXL_REGION is not enabled. This allow sbuilding when
> cxl/core/region.o isn't built.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9b1e70e8f9ec ("cxl/region: Introduce devm_cxl_probe_mem()")
> https://lore.kernel.org/oe-kbuild-all/202606100401.GOjzpKHo-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
383f69656359

> ---
> 
> Fix is against last patch of Dan's [1] series for Introduce
> devm_cxl_probe_mem() and fix region deletion.
> 
> [1]: https://lore.kernel.org/linux-cxl/48834616-6e75-4936-89be-9224a6dedefa@intel.com/T/#t
> ---
>  drivers/cxl/cxlmem.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index d3bdd00f94b3..ed419d0c59f2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -115,7 +115,14 @@ struct cxl_attach_region {
>  	struct range hpa_range;
>  };
>  
> +#ifdef CONFIG_CXL_REGION
>  int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +#else
> +static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  
>  struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> 
> base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686

