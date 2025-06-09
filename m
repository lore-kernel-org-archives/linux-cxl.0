Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA554A3C
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489946; cv=none; b=I0AY99/oJtT8Jphx/wXdMJlkrXQjJjAlpH/NrSoCy1E+tUVqmDTXB8asc92EnKMYLZl/QWmo0kPCwjFQENCt/JYChDPExp4c4udQjGnFMTh6P9G57fywwQE0cN1cQYF/1x69UwBiwMtxbQw/X8B0HmBSRpIiSqpdtFMQ5jgg/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489946; c=relaxed/simple;
	bh=GpegMALV/0PmgP+yuXN7foTmbOBMxRlj+DJAHs1ZEOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV0bSJHvwBitUIKY51//478s/31HbFzsjPWMf4V1cIlmybK9N3T2r2OvZzkZVvfooeaNzuuwdnGN+VQAiTNjnkUff0bWBYdF9M3Ous4e1J8SXunaMH64oJ5BT4Be9vhX3xIhqAjV/4bNSVDZvrFfIsiKMrEzYAUSGuYAFkGCk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QB8ZESsa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QB8ZESsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749489944; x=1781025944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GpegMALV/0PmgP+yuXN7foTmbOBMxRlj+DJAHs1ZEOA=;
  b=QB8ZESsaKCFCero710yuinHW3TPiZ+tTCh7lC97bfnqJRSWHtsLnKHVS
   EL9ICK9lHwK3p5rc2oqNIrB7qC+uvfodlSZnrQ6LLhofjlcm/6lMiChAx
   E2l8YyS4NlNqagT4PTUZkmo1czp5sf0G4qRXBHkYPmwhkcZ3TAZHY99RH
   MYU7psdhb0QMEi5d0ZFSfU2wS2EhlTHHZ1oT2QQg60AHjlDA4xgKGmItc
   RpkTSpZ57aPUpO4lD5K07mEdcn4SV3m4r6PxoAKQ2UPmJnV5bJ9mO/iYd
   VMzt2UeE4j7YkfPpBbKc2CWDkHwiTBIWPAsD9h2PzWCQJANsFf6NTFMVS
   Q==;
X-CSE-ConnectionGUID: NpxPAL2jQMGMzLzpRrzguA==
X-CSE-MsgGUID: Uudc9CxKSPe+4ww9VY2JVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51671072"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="51671072"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:25:43 -0700
X-CSE-ConnectionGUID: 18XIU7RlTuaXW9mfZp8uWw==
X-CSE-MsgGUID: 0GuiNuFaRw6kd0Sakqeh3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="151713918"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:25:42 -0700
Message-ID: <8b53e8e1-8b9f-4db5-952f-0a961942dfeb@intel.com>
Date: Mon, 9 Jun 2025 10:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Dan Williams <dan.j.williams@intel.com>,
 Marc Herbert <marc.herbert@linux.intel.com>,
 Alison Schofield <alison.schofield@intel.com>, linuxarm@huawei.com
References: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/25 8:34 AM, Jonathan Cameron wrote:
> Some architectures (e.g. arm64) only support memory hotplug operations on
> a restricted set of physical addresses. This applies even when we are
> faking some CXL fixed memory windows for the purposes of cxl_test.
> That range can be queried with mhp_get_pluggable_range(true). Use the
> minimum of that the top of that range and iomem_resource.end to establish
> the 64GiB region used by cxl_test.
> 
> From thread #2 which was related to the issue in #1.
> 
> Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.com/ #2
> Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
> Closes: https://github.com/pmem/ndctl/issues/278 #1
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>
> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to cxl/next

Added the config check from Alison

> 
> ---
> I haven't given this a fixes tag because it never worked on arm64.
> So it isn't a regression fix, and I'm not sure we want to back port this
> which a fixes tag might well trigger.  If people want one shout and I'll
> try and figure out what is appropriate.
> ---
>  tools/testing/cxl/test/cxl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..6a25cca5636f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -2,6 +2,7 @@
>  // Copyright(c) 2021 Intel Corporation. All rights reserved.
>  
>  #include <linux/platform_device.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/genalloc.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
> +	struct range mappable;
>  
>  	cxl_acpi_test();
>  	cxl_core_test();
> @@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
>  		rc = -ENOMEM;
>  		goto err_gen_pool_create;
>  	}
> +	mappable = mhp_get_pluggable_range(true);
>  
> -	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> +	rc = gen_pool_add(cxl_mock_pool,
> +			  min(iomem_resource.end + 1 - SZ_64G,
> +			      mappable.end + 1 - SZ_64G),
>  			  SZ_64G, NUMA_NO_NODE);
>  	if (rc)
>  		goto err_gen_pool_add;

