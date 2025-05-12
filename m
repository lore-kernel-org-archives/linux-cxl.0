Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7D1DDC37;
	Mon, 12 May 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090064; cv=none; b=ch7I0V8DXsvmBdsSUSM4m0O9++/i63GJY9zkNpxz81a09NGxsmdIwTGghZYFDzwaQyToXov1JUAaRL8VPoKE199pttfH7c6EJ6AeBBxzI/K1EbQPbd5tXOiaSJPcsWzz3pvwosK3qgjs4al5svuUlUiwISpD8CmsQ1G1Erydpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090064; c=relaxed/simple;
	bh=/WDeTO1BzKYDL6uUG4viBsI/A++mqIRtzI8HsjPf29s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa3IKxqH0+6AZQ3fv3ObTyMG7YfAazJWQgM7yMb0yuw/GOgMczdpymOLESLYV+yb0O2HDdGgYFIw1y3OOc9uJIsByVy1Pgl4IR3G9XJ7xaKjd/N34ILmEK59SFs+9B3HQYgYMkpi0L5F/gXqOL1M/ilb3QrNw4CR6XR0Q5WCCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD9ml4F+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD9ml4F+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747090063; x=1778626063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/WDeTO1BzKYDL6uUG4viBsI/A++mqIRtzI8HsjPf29s=;
  b=QD9ml4F+LPB7vhh2jONduWnTtO422tnbVrSULMNA8VI/+qt0uVCLXvMx
   gUhFge9DNFsS8WVF+kfi3b7xYDtInuumC7lgI7SM91kSsOgDT+JI2L7Pe
   09vwt8TAS7C0NX6GTkkX11rZ/kykUWnSxYaad1pOrlkorx8gBee6F1J04
   Sos+1/+Y3fO405OOyWapFGngqppkLHQICe5ldSWd9OrgBgTTCz7h3X0yA
   NPKvl2JaBMxgF9bbC2MJKd9ice/ekzDjjvzILBHLUMDRKlpllCXSRW704
   fcQgNVgDMct3w/4OY19qwZ8w229Fq02NM+7C7nuVSq1Iwy6hh8EcsUjDr
   g==;
X-CSE-ConnectionGUID: 8fxM68fISjit2o6qPncMlA==
X-CSE-MsgGUID: z1xiHUnxSHCcCnQvqQ02pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52563695"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="52563695"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:47:43 -0700
X-CSE-ConnectionGUID: 10MhjjqTRGGZHLtU/HjSgA==
X-CSE-MsgGUID: LVtBGWCHSLajtKz44Qe+GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="137530913"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:47:41 -0700
Message-ID: <3be8c20d-d08c-4f77-b1e9-2647e7da50b4@intel.com>
Date: Mon, 12 May 2025 15:47:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] cxl: docs - access-coordinates doc fixups
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net,
 Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-3-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Place the hierarchy diagram in access-coordinates.rst in a code block.
> 
> Fix a few grammar issues.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  .../cxl/linux/access-coordinates.rst          | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> index b07950ea30c9..e408ecbc4038 100644
> --- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> @@ -26,20 +26,20 @@ There can be multiple switches under an RP. There can be multiple RPs under
>  a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
>  Window Structure (CFMWS).
>  
> -An example hierarchy:
> +An example hierarchy::
>  
> ->                CFMWS 0
> ->                  |
> ->         _________|_________
> ->        |                   |
> ->    ACPI0017-0          ACPI0017-1
> -> GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> ->    |          |        |           |
> ->   RP0        RP1      RP2         RP3
> ->    |          |        |           |
> ->  SW 0       SW 1     SW 2        SW 3
> ->  |   |      |   |    |   |       |   |
> -> EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> +                CFMWS 0
> +                  |
> +         _________|_________
> +        |                   |
> +    ACPI0017-0          ACPI0017-1
> + GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> +    |          |        |           |
> +   RP0        RP1      RP2         RP3
> +    |          |        |           |
> +  SW 0       SW 1     SW 2        SW 3
> +  |   |      |   |    |   |       |   |
> + EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
>  
>  Computation for the example hierarchy:
>  
> @@ -82,8 +82,8 @@ this point all the bandwidths are aggregated per each host bridge, which is
>  also the index for the resulting xarray.
>  
>  The next step is to take the min() of the per host bridge bandwidth and the
> -bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved
> -via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same
> +bandwidth from the Generic Port (GP). The bandwidths for the GP are retrieved
> +via ACPI tables SRAT/HMAT. The minimum bandwidth are aggregated under the same
>  ACPI0017 device to form a new xarray.
>  
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated

