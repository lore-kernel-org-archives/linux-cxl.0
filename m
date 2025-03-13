Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105F1F63D6;
	Thu, 13 Mar 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903520; cv=none; b=Z1mET73Arkj4wZir1ian/IJyHVLFDb+0f6FFafHgY8Lwm6x4siGeiuEVHayzQT8QHh7tCO1WsKDuJmFaaW7n2uRTg69UPFrILy0DFk7LKHhdIMsmkX0s1SCBuR7W3JsAkHfXPhf/rLhVvCgFCfyfZVYhwzW7MXxtCkcpfAMhZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903520; c=relaxed/simple;
	bh=/qID/VJTvjXyKUcft2ck54TEmpFJ7EugT3z1mM/v51A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEeXVxnkcjHj1uxa4Ax8zZ0KcLLDqKz8xzLa6XLNI+8iEb7VX5t3F0K7yuW7Ukr16yEGBysxO/I7T2xoVD6Vmt6LUYxTzpI1N3Rrj6lZm3Zp2XLcXnm8syUAHMLzw90MWItNpAWzVBmcx+Y1n6W6tk1iddxS/WytAnxw0E/08mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM7+DADa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM7+DADa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741903518; x=1773439518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qID/VJTvjXyKUcft2ck54TEmpFJ7EugT3z1mM/v51A=;
  b=aM7+DADabt8EiwrQsBnFn0c26NzV4tyfW/zCTuqUkgEsCRf2U446MAKz
   uLyJAqqKRGweQhPKHara9fYz3Aezv/rx8aE/tHCNl+lN44RKLJ/8LKLIi
   VG2Q45MKUx2BvR+VbIeOrlmlkfRMnTehbgc0ePVmwsafz1cpPkkwjzhfP
   U4SMKjf3HXR8HL3wnbRTfZ9SjWBy2gSFiIqBzlHzCPaCiaDSvfDW7nR/l
   dP7hLSfQL5LcDIWMNXEUotpUciD5Fry1hyE1ro1Gbbp/GVQOdum3R10KK
   7NkfAJ4Lq/P85cai7bbZjlMphCGiB0fTTs9UB5KVyuOWesJHw79Mloj7E
   A==;
X-CSE-ConnectionGUID: OHy1MrqIQKqsMtd9JzpB7Q==
X-CSE-MsgGUID: yp47F3FKRfuDNHEOhTQUBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="45813444"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="45813444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:04:40 -0700
X-CSE-ConnectionGUID: EiacCQtMSiy4kHroew28yA==
X-CSE-MsgGUID: jA7u+aJNQsaZZVOWbh/5yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121788862"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.96])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:04:40 -0700
Date: Thu, 13 Mar 2025 15:04:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Add Null check for adev
Message-ID: <Z9NWdob3CSy9UDq5@aschofie-mobl2.lan>
References: <20250313190753.450546-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313190753.450546-1-chenyuan0y@gmail.com>

On Thu, Mar 13, 2025 at 02:07:53PM -0500, Chenyuan Yang wrote:
> Not all devices have an ACPI companion fwnode, so adev might be NULL.
> This is similar to the commit cd2fd6eab480
> ("platform/x86: int3472: Check for adev == NULL").
> 
> Add a check for adev not being set and return -ENODEV in that case to
> avoid a possible NULL pointer deref in cxl_acpi_probe().
> 

Avoiding the NULL ptr deref seems obvious as ACPI_COMPANION() return
is routinely checked throughout the kernel. Why the reference to the
other commit? Do these devices have something in common?

I'm curious as to when *this* specific adev can be NULL.

Looks good to check it like you do here, or if someone chimes in that
it can never be NULL, just add a code comment saying so.

Perhaps emit a message on NULL too.



> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/cxl/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..9195001db3c1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -823,6 +823,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> +	if (!adev)
> +		return -ENODEV;
> +
>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
>  				      &pdev->dev);
> -- 
> 2.34.1
> 
