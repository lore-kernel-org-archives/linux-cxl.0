Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AA2E5404
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478575; cv=none; b=mFCT6UVRiQ5InJ+4EGhOZPYPcYH+L89XWWGu9XD1fonYLkKL2jKG0xDVMaUwno6YdLctTvbC/RJ2wqdKQ0nsiu9Hol9LOpwgAOEdJ2XyipY09pFXFJkNeZVnP04u8UXDhNfu3bfdwakKkYiSVKI//6EmfpEAtFKjBTcINJbqZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478575; c=relaxed/simple;
	bh=9GCpsDrO4tobad/PH6zVk90I9njLkSTXqG6uGJn3s7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifcj7gZLofctQ9P00pRwdCoixGyY+QZf70HoB5Rwm2Y396V62YgNNRsRQaZVGVTKZDk7wWWpq8+cn6kZR5aY0Ar8NVr6wF8GGdmjSaF2KM0CqvS1O0wkzUdh+AcIBr4irh+RCd8QOPWPhFQvJeFnyQKa9r8KFCMTUFQI4GMrnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NN0H4T0C; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NN0H4T0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478574; x=1792014574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9GCpsDrO4tobad/PH6zVk90I9njLkSTXqG6uGJn3s7s=;
  b=NN0H4T0C/l8S03FH0xlhjQYPDAdBmi7/k8/N8kIZqifkcXI3vv0tl2F1
   Hlp/wtLrhED26GKM2Q7VSKW+yQ1CpwBE6XdJotHOGJF4a7bvRlgZMJfb3
   +hH9h9pXuGOleS0RSGe1sSTMmThnsZeu/gRNCSpDCnpKE/Ga4MhKwuTgB
   wccvlqwKdLo0d1aXd/SUGNflAI/LtxP4JfxkcMIyUnZL04VPByFVsLu4I
   6XN2HiOMSj9KDSQEAMNSfPfN9xTvy+fKzW6E8kVe4bB/iKdgSW2W0VEPF
   42u0rBpVPpGuHRyB17memx1RU6o/O3d5gj5/AcXmiTt0lHD4uE+mYs+o1
   w==;
X-CSE-ConnectionGUID: 3hdjXMl4Sqmub08THywjFw==
X-CSE-MsgGUID: 2UA9ldi0SDGXWLObQB7zsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73749164"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="73749164"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:49:34 -0700
X-CSE-ConnectionGUID: eHP2HZJmQyS698Qr2RZ0ug==
X-CSE-MsgGUID: fTU/+q5cT4ib+UtmQk2t+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="181993443"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:49:32 -0700
Message-ID: <7e82a6e5-d4c3-4d32-a774-7bce90caa373@intel.com>
Date: Tue, 14 Oct 2025 14:49:31 -0700
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

applied to cxl/fixes

> ---
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

