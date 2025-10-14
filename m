Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9502E5404
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478424; cv=none; b=gdPAUnvZ3YBuYQJo4TrQNAZWwnCVkfNeY3MH0QT1RhpkCYCYrFHkb2rVD41cme4t6lnyO6++YM2dBp7JHu4PDbUj0Hw50nYQl65CNIwgANm1v/uJwJzhSTtYV2un5r1JMwmBwPvFIJRC5nSo6MJiZNOhoy/w2ZFBqcbLTMhpgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478424; c=relaxed/simple;
	bh=ZeE9hI0TlnR3i7yNMbl3qdhm3G6PDaermrQ21hTpyj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQj6FVsYRegFcKML9B9+3GVyHKVYR89Ck6/g00X2s/kjwyh9tMqvl9798xYNWvHY4v/E5xtEP0RdQyfnuh4jv34gSiDYj8r8ZJ+y4AOLd78WKBIWgovmRKF1/RijjLPPtb/di3qG3pFumgSS5GgJ40n134dKYGQ7vtb8PHxY60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUUGvRGb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUUGvRGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478423; x=1792014423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZeE9hI0TlnR3i7yNMbl3qdhm3G6PDaermrQ21hTpyj0=;
  b=ZUUGvRGb3Jt0RcwJu5/F5wJ1IN5nZViR+kpikHkjnPzGpgjEGkEYg8hT
   VoHBUArDhENV/oMS7z6XT9lbK702WJaxEo/wPIXZmsq/jKKEgnBbVh+yw
   AobMQFtBqfDygnFV3jkASRKE8AXki05vUlJ4K+LupcPjj1mCQ5G7pT3iL
   I+Yz3sNHz4GofX0gzZyMnayWPRQnVXxis3ZX2wNH8+LbezMsxxfPqrCrp
   5rwNnDZVJI9BnZDZXdPNxRL2Abp8cNkKZ9LQ5kEvH93plRfgmLHic5TMT
   O5mNeVavw5Ol2pLtt5fDZvUcXE058XcSgB8a5i8lBBu3czZJ/7qoK3/+y
   A==;
X-CSE-ConnectionGUID: ozIQkTJjRaCeoezg2Kggaw==
X-CSE-MsgGUID: VwkXNISfQe625VzX3zX8lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62540589"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62540589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:47:02 -0700
X-CSE-ConnectionGUID: +x4NUb4BSVO5o382WkSPvA==
X-CSE-MsgGUID: yRHFHUanTDKV54+xyUhjUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="186001789"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:47:01 -0700
Message-ID: <fc91602f-32b1-4321-8e5b-6a052ea5e5af@intel.com>
Date: Tue, 14 Oct 2025 14:47:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/trace: Subtract to find an hpa_alias0 in cxl_poison
 events
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20251014213852.748018-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251014213852.748018-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 2:38 PM, Alison Schofield wrote:
> Traces of cxl_poison events include an hpa_alias0 field if the poison
> address is in a region configured with an ELC, Extended Linear Cache.
> 
> Since the ELC always comes first in the region, the calculation needs
> to subtract the ELC size from the calculated HPA address.
> 
> Fixes: 8c520c5f1e76 ("cxl: Add extended linear cache address alias emission for cxl events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Good catch
Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a53ec4798b12..a972e4ef1936 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -1068,7 +1068,7 @@ TRACE_EVENT(cxl_poison,
>  			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
>  						      __entry->dpa);
>  			if (__entry->hpa != ULLONG_MAX && cxlr->params.cache_size)
> -				__entry->hpa_alias0 = __entry->hpa +
> +				__entry->hpa_alias0 = __entry->hpa -
>  						      cxlr->params.cache_size;
>  			else
>  				__entry->hpa_alias0 = ULLONG_MAX;
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787


