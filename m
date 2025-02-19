Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4A21421F
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984757; cv=none; b=FzFwXZgERLUeh6RcjXVX4TaBVxwga62uI/62JTVdf5WaUFlRCzZ+ST/HnQpYpFYe2VjBg0uQ2EeRulqFu5zXQg/ULJ5h+eEotFm/Gtl3O0aeX1XWvF6QIOpUZYb2d9sZ6gXld5HI0Q/eYkJH6RwQtCSCp0MPQvVCxzs8sQmVHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984757; c=relaxed/simple;
	bh=b+1cFOJXiHlUOawwa0ftb9POWcoBrAfpm8Lpkicei+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsnQwiOL+jl2gUlftRsVvzN3McUd9/hkYFxqNtk6kZ3zoNAhdNGkVmEVE4BtuJFYU5ura9uhOvCfJx5057HEBJ26pZCZOvZShb2EB4iJTkXDOaPua6gguOfoCu2UP3F7yUgwqxF0lFb2Uy3I+dOA4W1R9Pj3MVbmM3zrDwHHOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYuTWmhM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYuTWmhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739984753; x=1771520753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b+1cFOJXiHlUOawwa0ftb9POWcoBrAfpm8Lpkicei+I=;
  b=OYuTWmhMuqWWUVSWbkzPaUfFJ1Q2sicSdbhTw946kWX7nesaB0CU7ULa
   pHaYul4Td4oWpShLsXDULowIF6cwyT7otQM5O959t3AvnawO7xbWK0gco
   7VhawH2KTv6WuTRHRp1UT47RApoOnhKYwphfC6wQ/t+1AbpnYxFWecOWY
   Iy8DSLwD6Gfe3p1BTFfVu/2kumIbxBGtCK83VT/FWh+vQZsM2l3hrCk03
   yziKhnJOyHYXRm1Nn4b5+EiR44FqAHRqNuAvyvKraDNXsKGf/hmakOIac
   CRkeaA+EpqLIoFIQkkjs+7L2Fpu+BTMDjuMhnJizmcZoR9j3QkvYOYdbR
   w==;
X-CSE-ConnectionGUID: qGJSD2Y3SQWmdAKzQYXjXw==
X-CSE-MsgGUID: DJc4QP52Q/eDa+dPI6INrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44380677"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44380677"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:05:45 -0800
X-CSE-ConnectionGUID: MfVroJnmQ/CfIw4S/zEOAQ==
X-CSE-MsgGUID: yd3ogXfKTZK4cfaQjU204Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115252521"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:05:12 -0800
Message-ID: <588f9606-495c-4a4d-a62d-a4ceec517f06@intel.com>
Date: Wed, 19 Feb 2025 10:05:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl: Plug typos in ABI doc
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 ira.weiny@intel.com, alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <20250218224853.67457-1-dave@stgolabs.net>
 <20250218224853.67457-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218224853.67457-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 3:48 PM, Davidlohr Bueso wrote:
> Trivially update where necessary.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a..7bdf0eb79d7c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -1,5 +1,5 @@
>  What:		/sys/bus/cxl/flush
> -Date:		Januarry, 2022
> +Date:		January, 2022
>  KernelVersion:	v5.18
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
> @@ -33,7 +33,7 @@ Date:		May, 2023
>  KernelVersion:	v6.8
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
> -		(RO) For CXL host platforms that support "QoS Telemmetry"
> +		(RO) For CXL host platforms that support "QoS Telemetry"
>  		this attribute conveys a comma delimited list of platform
>  		specific cookies that identifies a QoS performance class
>  		for the volatile partition of the CXL mem device. These
> @@ -60,7 +60,7 @@ Date:		May, 2023
>  KernelVersion:	v6.8
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
> -		(RO) For CXL host platforms that support "QoS Telemmetry"
> +		(RO) For CXL host platforms that support "QoS Telemetry"
>  		this attribute conveys a comma delimited list of platform
>  		specific cookies that identifies a QoS performance class
>  		for the persistent partition of the CXL mem device. These
> @@ -423,7 +423,7 @@ Date:		May, 2023
>  KernelVersion:	v6.5
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
> -		(RO) For CXL host platforms that support "QoS Telemmetry" this
> +		(RO) For CXL host platforms that support "QoS Telemetry" this
>  		root-decoder-only attribute conveys a platform specific cookie
>  		that identifies a QoS performance class for the CXL Window.
>  		This class-id can be compared against a similar "qos_class"

