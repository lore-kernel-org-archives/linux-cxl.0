Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77018DB2A
	for <linux-cxl@vger.kernel.org>; Fri, 23 May 2025 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979551; cv=none; b=LKdiBCGROzMGTulR3y+nOK8iNUvDsQKIustSrR38+0cl658RkMFdGZChT4WWm9RPSTIII2EnjN8OSB8C6P7ruH//hVLHIvqwIqgK66NqkoS0qwCNJYhe1SIdPpEitrkw6qdSgTqvZpkJbhUYUGeTrS6//6kLS2ILL9HbMd00uVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979551; c=relaxed/simple;
	bh=uYZ+8l+gwFvhjudqgM0lRGN9ikaYUSNI0PFO2jYXgMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+vSwm/dAGJZigsYOVmmrADGO+x3fSX+B3uJqa7mPkH9+FCMS5MgzUu61W6V4wWWkBJUVCr03F3lCx+jMH9cJDfqp5EjJtZOeTJkw5RM1eVoQBKOrNv6rVZbSINAVwxa4cYMzOHu34WkCdOZyQVIZEUlnlvNi00Vld0eWVVS1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVPJrmZi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVPJrmZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747979549; x=1779515549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uYZ+8l+gwFvhjudqgM0lRGN9ikaYUSNI0PFO2jYXgMs=;
  b=nVPJrmZievGxqeueh5w8WhjnYoAHm862IF6O8+Oi2uF5pacQiYn2FLQq
   RFIoAYXQJYWaCEo96yWdNVCY1DLInvaS3l+wYvpVfkZ0icGLxmt0vJiLc
   273fM0REApZ/jCCIk/gRcsqHRxsB8vh982PTdA+D7fSbxxrEUSiFkQFe3
   qpa0MJ3CBbOfzbuE2csvntTWv76e9Zdxi6fFXeYLopKTxZ/b3+HZOA1ak
   iBSfhq72GrNYHqo5RH9c/2SHjU5QMJaL03c4BeEIGmQ3h65s5ZPRwm9oo
   LYXmg4dO0miI+3I1qq4+k+3lkg5581OcTwLXM+jsSuW6/fdIxED9SyF7+
   A==;
X-CSE-ConnectionGUID: CXrVUx/tQ/O/UGu4G2xM4w==
X-CSE-MsgGUID: 5QvnaSWJQ+GorZC+ID7Qmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49731310"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49731310"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 22:52:28 -0700
X-CSE-ConnectionGUID: a+29qGMnTQC5qrnCFIUpiA==
X-CSE-MsgGUID: au5FdkSwRLihaa43dNUTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="142018097"
Received: from lslayter-mobl.amr.corp.intel.com (HELO [10.125.23.146]) ([10.125.23.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 22:52:28 -0700
Message-ID: <6a08d9e8-6895-4111-8a5a-1ee698e87de5@linux.intel.com>
Date: Thu, 22 May 2025 22:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
 <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
 <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
 <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
 <20250522145622.00002633@huawei.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <20250522145622.00002633@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-22 06:56, Jonathan Cameron wrote:

> 
> With the below - all 11 tests in ndctl cxl test suite pass for me.
> 
> From b287ff2c5ee7fbe507ef8cb61df3e4e156a9773f Mon Sep 17 00:00:00 2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Thu, 22 May 2025 14:20:42 +0100
> Subject: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tools/testing/cxl/test/cxl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..b4e6c7659ac4 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1328,6 +1328,7 @@ static int cxl_mem_init(void)
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
> +	struct range mappable;
>  
>  	cxl_acpi_test();
>  	cxl_core_test();
> @@ -1342,8 +1343,11 @@ static __init int cxl_test_init(void)
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

Tested-by: Marc Herbert <marc.herbert@linux.intel.com>

cxl-security.sh aside, this patch turns all CXL test results from red to
green and finally fixes the 3 months old
https://github.com/pmem/ndctl/issues/278 which has a ton of relevant
context.

Without Johanthan's fix, Itaru's and everyone else's run should be all
red too. But they are not all red because the current test suite does
not care about kernel errors (!) which causes a lot of false negatives
("green failures").

These serious false negatives are addressed by my patch v2
https://lore.kernel.org/linux-cxl/20250515021730.1201996-3-marc.herbert@linux.intel.com/T/#u

Please help with review and testing it, thanks! This is the perfect
timing to test it.
