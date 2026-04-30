Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6C3A1681;
	Thu, 30 Apr 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580467; cv=none; b=A75sOPcrwRiGE3VuzupWNNuaoGynWyK0RrkbM6iUwmwv4JzNod4M2g8hfzvhHryzN7dGWkYRJDwVeWbiz92sP0f7wCPjFOJ4qNQAi/As/2cf6d+vd7AViZnGzxSdpSnhI9QCpod/BLNEa5hDYneEcNqiqew0RkOroavw949+rAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580467; c=relaxed/simple;
	bh=wo6HjFTF2kTZt6yog24uMBP/bo8gaL2bjBUfnOSMymQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjET+JIH4La1ewFNii2o7aKyRxk1VZ/SxzNz0bSuZXk6NUwPg2m6yRRUnrUv62+DvBceBORwseDgahr7I2AWWDCkZM9799u+dfsAZ6DtrP3wxWX4KraX5y8NRhpY0bCUJYX/IN4kl63QBVubunZtY6Bf0W9g/eMKAN2dAaZ47I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5Hrpk6W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Hrpk6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777580466; x=1809116466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wo6HjFTF2kTZt6yog24uMBP/bo8gaL2bjBUfnOSMymQ=;
  b=G5Hrpk6WDYwph5oxbAH3VU3VuxrzyVWe+8cO+QI0vOBsZidch6wy+ud1
   0YkGhI/Q+iyhSRAPALKWrz8tUUTYoUH0lKLNFwSsv8pRMjs5IdLQYLlJo
   rKghc1HDBnnFQbZXAXncJqTvftvhQJeh+HBXd0fME9hCHSHLuXxJUA/YF
   W8Ofx56gx13iHhkPKKu09eYIpSEHwI/NE1Gj8uSYJEOygjup49hON36qE
   Qx8TfTxlMjJiIaPSR+lv8PrQtkja1DJg3AASuKJz530YdxJAdQ1exXEOl
   6wU2z85kb7DnpoK4pJTBzPCiptgO7OJ7h9LbaqhK7yF4J2CLq2l0tT2HH
   g==;
X-CSE-ConnectionGUID: LYwpjbJQR5WsjyoVFGlBhQ==
X-CSE-MsgGUID: ZaZ4mqWcTTSvApoRbvOnDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89141110"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="89141110"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 13:21:06 -0700
X-CSE-ConnectionGUID: AFbg/sSvSs6frVt6p/qVNw==
X-CSE-MsgGUID: iKbJUUXFTHSsGiIrbqLmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="228188202"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 13:21:05 -0700
Message-ID: <6bc8cd86-e37e-4742-994c-6781e8f4ce50@intel.com>
Date: Thu, 30 Apr 2026 13:21:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Use FIELD_MODIFY()
To: Hans Zhang <18255117159@163.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430162718.43536-1-18255117159@163.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260430162718.43536-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/26 9:27 AM, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Hi Hans. Thank you for the submission. For the CXL sub-system, we basically have agreed that we will only take cleanups if there are additional work in the area in order to avoid excessive churn in the code for ease of maintenance and debugging (i.e. git bisect). Appreciate the work though.

DJ
 
> ---
>  drivers/cxl/core/edac.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..a374e8ebac87 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -717,8 +717,7 @@ static int cxl_set_ecs_count_mode(struct device *dev, u8 *log_cap, u16 *config,
>  		return -EINVAL;
>  	}
>  
> -	*config &= ~CXL_ECS_COUNT_MODE_MASK;
> -	*config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, val);
> +	FIELD_MODIFY(CXL_ECS_COUNT_MODE_MASK, config, val);
>  
>  	return 0;
>  }
> @@ -729,8 +728,7 @@ static int cxl_set_ecs_reset_counter(struct device *dev, u8 *log_cap,
>  	if (val != CXL_ECS_RESET_COUNTER)
>  		return -EINVAL;
>  
> -	*config &= ~CXL_ECS_RESET_COUNTER_MASK;
> -	*config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, val);
> +	FIELD_MODIFY(CXL_ECS_RESET_COUNTER_MASK, config, val);
>  
>  	return 0;
>  }
> 
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

