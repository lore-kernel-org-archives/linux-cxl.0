Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95C13A249;
	Thu,  1 Aug 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475354; cv=none; b=u9HoTLTeY3gtSqLixEdxBDCEQJsbnpDjo1tHRwODmG9hk5PLzHwoOrsU28IUy5crVjC68VeJW9Wa7q0dOXKKZgc1/xjTSjLKtgulmHffCvp8JaV6zchxCYgomZd88L26pOzTqOIxispMUKFeoRS56Tft2qumDaokx8+F2W2aM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475354; c=relaxed/simple;
	bh=pGgzCNEQpoQTVGCg1pM0uGdSwgXRZRMoaaVlghFUpfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTB1TeIUvTM8p1wkxRUPXNRDyA8hNg3eYIAhgWeqJ3DsAbm7aSTlz4x94R8wucuQzCujZJu0AumQfSDGiYSJYORIKAMlmRQ8uOOEDtbyKO83BPCTVNM2CRvPZ4mz3VCmR+xCQDx8DJG1MsVcnyhT9iZFMHrymPt76VUxy0dyLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8LWoIin; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8LWoIin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722475352; x=1754011352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pGgzCNEQpoQTVGCg1pM0uGdSwgXRZRMoaaVlghFUpfs=;
  b=U8LWoIinIpsh6mV5YKbXJlWKwMgFR7vDmuii5lCQ/R8hsdmYSofy8TOq
   Rs1LVnJimBO41Mbto5rtZiaX+2clfJQHBsbs5vgng3yB4B4vQFYdWlAFm
   sL9yuxaBqvqswa5Bu7gqJFwWK245Z2jFUi7z9Ktyky4m/OZrX7+Czcden
   UUHwP14EpSgHb6jDptlFLqlBbYAboUhkTaH9wSDb76YOAhyM7KfQZf1tP
   tXkBRRYMe/FqaDwMcFPzuglXP/jToMaWkyGpqW5syyyoIbfx50K3BLT1q
   FAR5/nTD5Lo3UNCvwn5T4HkLI6z24DZMVzTVR7WkkMMq8bOrZvsIijlom
   w==;
X-CSE-ConnectionGUID: iniWuk8cTXmWDtDhyVHI8A==
X-CSE-MsgGUID: BJTWeviMRsOqLAi4G8rw0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="19977149"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="19977149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:22:30 -0700
X-CSE-ConnectionGUID: zq/SBxTKRJaZUlCol+8aeg==
X-CSE-MsgGUID: 4iESZe+ZRc+W5LQKg7DvAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59655057"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.57])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:22:30 -0700
Date: Wed, 31 Jul 2024 18:22:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH 1/3] cxl: Set target type of root decoder based on CFMWS
 restrictions
Message-ID: <ZqrjU+552rs7VuLy@aschofie-mobl2>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084611.502889-2-ying.huang@intel.com>

On Mon, Jul 29, 2024 at 04:46:09PM +0800, Ying Huang wrote:
> Now, the target type of root decoder is hard-coded to HOSTONLYMEM,
> because only type3 expanders are supported.  To support type2
> accelerators, set the target type of root decoder based on the
> window restrictions field of CFMWS entry.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..40c92ad29122 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -382,7 +382,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (cxld->flags & CXL_DECODER_F_TYPE2)
> +		cxld->target_type = CXL_DECODER_DEVMEM;
> +	else
> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> -- 
> 2.39.2
> 
