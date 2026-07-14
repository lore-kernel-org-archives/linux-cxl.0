Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E9238D54;
	Tue, 14 Jul 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047744; cv=none; b=VrevogfwfqetMowk9MjJNbtwO6rMdswfzud5JjJS0ZDEIQFuMXDc4qrpzjvNXGf/vIr4hknjiqxRBIt5LETarfaO7Qne5Sn6od3qhoIbiF5EOjDapbBs2UWQyYzoDXcYq0n/JZ60uFspgvTnyqvzAlc1gxfsUOrWbVOtMstt7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047744; c=relaxed/simple;
	bh=luQU9g/ssR2Lmq1+kE82E0EOheySBxZGo+mMHRl5r9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJVsnczzCioPt8ZWhnz+UHUlaeU+3lseVO7ruKqH78/h8yKR0JqemzZnvJqaFmjAAiaWl1WL5kt/7AMDE/MzSl5GAwBwLI0GLOObJklv4g1APOtqijlUFSCZ2D82HZFy5wSbOsFBLLaBIyc5kde3vKDpwYg+VkqtMRbw3F0AVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APHOaFJK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APHOaFJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784047742; x=1815583742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=luQU9g/ssR2Lmq1+kE82E0EOheySBxZGo+mMHRl5r9k=;
  b=APHOaFJKv738RD0GbJAIPOS0g30B5IcWYsY12mv8WcGqZT2dpiSX9zFQ
   KGi5NN7Qp2/jY4ftNIndzZZRT+F3JlNrgIMP4Lep7DsVcuP5KnfwW3Wl8
   EY0T9mYjlnT+5O6lXkES+stzI20uXQlPZbhjg/j0Q+rOIrLdp3Ohe4IWU
   v1SVOJlO75VA/9ckDPfy10Mtd0U77Bq5JMAFjfngdv3KgK9sCZ/i9n6xv
   3j/503H7+ZwV8csbmClNjsJKt/k4jL4yt1b0Gdkp/y+8MY6SPAwByzSYQ
   QX1d/fwvdoux7X4c4DQjaJaHpO33jTbWQzuFZTMsD9lyoU+p0Lrzx9jRy
   w==;
X-CSE-ConnectionGUID: tSkkY1/ZRv69R5ZBW7HPLw==
X-CSE-MsgGUID: ORRNKWE3SXGpc1b2f6lfKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84530807"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84530807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:49:01 -0700
X-CSE-ConnectionGUID: Z/xrciAqT/SXyLq59E198w==
X-CSE-MsgGUID: BeKqHUotQ7ey86afVFJJmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252518777"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:48:59 -0700
Message-ID: <cba4bed5-2639-4b50-86a3-67d698ab049a@intel.com>
Date: Tue, 14 Jul 2026 09:48:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/test: Rework cxl_type2_mem_init() to use
 cxl_mock_platform_device_add()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713061531.56322-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260713061531.56322-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/26 11:15 PM, Li Ming wrote:
> cxl_type2_mem_init() is used to set up mock CXL type2 memory device for
> cxl testing, it introduces a known bug fixed by the following commit:
> 
> commit d90f236f8b9e ("cxl/test: Update mock dev array before calling platform_device_add()")
> 
> Mock CXL devices require updating the mock device array prior to
> platform_device_add(), otherwise, the CXL subsystem could fail to
> recognize the newly added mock device. Switch to
> cxl_mock_platform_device_add() helper to resolve this ordering issue.
> 
> Besides, this patch also includes two minor changes.
> 1. Preserve the original error code returned by
>    cxl_mock_platform_device_add(), rather than unconditionally
>    overriding it with -ENOMEM.
> 2. Drop redundant NULL check before platform_device_unregister(), as the
>    function internally handles NULL pointer.
> 
> Fixes: 6b2e585142e6 ("cxl/test: Add hierarchy enumeration support for type2 device")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next
9515af581da976911aea820175afb05be803ae8c

> ---
> base-commit: 31adec5c3dc489966e6061cbe427dddb81d2e6b5 cxl/next
> ---
>  tools/testing/cxl/test/cxl.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8ab2ce1262f3..62bd92b3be45 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1947,25 +1947,16 @@ static int cxl_type2_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> -		rc = platform_device_add(pdev);
> -		if (rc) {
> -			rc = -ENOMEM;
> -			platform_device_put(pdev);
> +		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
> +		if (rc)
>  			goto err_mem;
> -		}
> -		cxl_mem[i] = pdev;
>  	}
>  
>  	return 0;
>  
>  err_mem:
> -	for (i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
> -		struct platform_device *pdev = cxl_mem[i];
> -
> -		if (!pdev)
> -			continue;
> -		platform_device_unregister(pdev);
> -	}
> +	for (i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--)
> +		platform_device_unregister(cxl_mem[i]);
>  	return rc;
>  }
>  

