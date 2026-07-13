Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7F2701BB;
	Mon, 13 Jul 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962950; cv=none; b=bnxqhboVy5MEE7v5+PwVKfBAX/jP+dgZ5kCTaGS+WtmY6+9+e8716r+zvGTy2YpJueHMu0NRP5SYHt1gn6VmTUx6+7FuuNBmc+KYYg7CiurkTCz1GfeVj7ZvTNL9n4TEYC5WDKluFbl9rmypZeLS7pwWzr6Se0ObHbPsvGSbjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962950; c=relaxed/simple;
	bh=0ustapUXvgLwlzbOWfPc7QLcExXUPKcD9YTRdfgO1Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W91TkwMF1wi3Oi33jGqud5cyFS/J6w+1U9SdGyAIv0H8VWazyMsNeH5gekoIhRseLxRgBDqWnVbvRpU1h9qzTn/Hk+zOGlHW9Hog6WwZMxShfRn9pgTGk1TAnGTOU+6sZpYPUX+bW9xxmJwW8cjmudwHE6Pl4axMwHZrPVqHEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfD7m4AQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfD7m4AQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783962949; x=1815498949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0ustapUXvgLwlzbOWfPc7QLcExXUPKcD9YTRdfgO1Wk=;
  b=AfD7m4AQUEYmT1GWuvl8/5n4p7vUWlQt8hjfmDJMhbUQoorCQgcWrPh7
   x7bCceMsh+GiW+5iqogxiY0w6MN7GbY7KvTIlbXB3iEnbRNyxKhobrJvk
   Tu6IWJ/2vT8/1wBsKZ40UoGYVXWsNUJD/e5+pztD1TKRnNaoZg9/lQK6H
   g+W2JZEnGwCLIqLXg9vFA2NRENGDWs0nBsTR+xAXQ5HEfV23AiRj+ZlMU
   Buqi87JhLXOLjEB2/iYlbHe+HkKZn2IZJVMT6siWhuunPMLZm0f0NRng2
   /6d8MrMSudv5KQCVHDdc2b1eT6wAJmLM27df+AOa52ksc9PjwK9VuoE2+
   w==;
X-CSE-ConnectionGUID: j0vkbQyeRWmMVopJYyGlpA==
X-CSE-MsgGUID: aJ/bHoUsSm65XRoN0zVXFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88401897"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88401897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:15:48 -0700
X-CSE-ConnectionGUID: Uku1Wnu4Q1WEWv6jy0R0FQ==
X-CSE-MsgGUID: Tg6skEH7SAiSJtTALpJCMQ==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.69]) ([10.125.108.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:15:47 -0700
Message-ID: <a02ecb5e-178a-48df-b188-d84948e25c7f@intel.com>
Date: Mon, 13 Jul 2026 10:15:46 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

