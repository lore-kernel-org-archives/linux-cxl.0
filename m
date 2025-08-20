Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01F2E8B8F
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704686; cv=none; b=TF1LzYTjxR4ynFcG3ODRRjtqevsQb0wSrOIUrINm3Hx9yBLqNPZdkIFDozdeplyC70lgQa2JIaQLs8fjRa4u4cjo8BvRKPX8K+yaVV+d1MYkMfZKPVvBocQw39vyRYhl7KNnukgvo9C6RUyYVHnEzxo3BCRTrDYM8KEohRTreUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704686; c=relaxed/simple;
	bh=edXe1F3FjERPvJX0OS+2pCyBhaazirg1GSJ2HksoAag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkY0MPyypBLVe8Wfsbzn8A2G+syV0/qwhO2YBAabgXanV7IJG0bOkG+W83MSRPLCSJqYuxGP/xRdfWCiCO+jX+ZAAi2d2pBzhts3d7OLghjlAfg5fPCjWokLUZttsok8MMnymySbGGg4gyH6+JiODpLWu/UyUAiRi1ISKYJYEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1478YO1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1478YO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755704684; x=1787240684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=edXe1F3FjERPvJX0OS+2pCyBhaazirg1GSJ2HksoAag=;
  b=k1478YO1mLuzS2d+lfg4w8mPMpjPS2HlypfeWytzxo3T7dNQzwT6IdMq
   OUG7cc5i4Y71LMUuO9L4wzzVrpvN6nHjU6p+ieFYSiuUdOfu+g76eslDS
   r2SVbxdw6CDH+s6hyFSCU5CIwuVajAtOApvBxFWlzM6rq22Fh+vvTCa48
   lamc2iLPgpgJGK9e09qqKjVhcRaeM26qM/63Wud0xTNBHqlyi1NdzsA1o
   yt/bL5er1WPL9GeVd0gj5oXsgflcg7nUsmoNIQWbY3rr7/Ts4YNHBgeiD
   mgxeu0sBApp9BQ8dguGlBHdPpjhdI+rXEQJeCCVzVHpuq7lhQlMCsAGq7
   g==;
X-CSE-ConnectionGUID: 4ciDD+Y5Qnm27QpCmOWdBA==
X-CSE-MsgGUID: XEFVxLDnTIGFEgGYuGYnKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58040037"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58040037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:44:43 -0700
X-CSE-ConnectionGUID: Bu4DN5fpQxuGsKgPihKImQ==
X-CSE-MsgGUID: UHhSmh2CRJmllHV/R+ih/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172421440"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.205]) ([10.247.119.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:44:39 -0700
Message-ID: <d18a9fa9-ccd6-4fe8-83d1-e9838b15c5dd@intel.com>
Date: Wed, 20 Aug 2025 08:44:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/acpi: Limit XOR map application based on host
 bridge ways
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250813032918.2899852-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250813032918.2899852-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 8:29 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL specification defines one set of XOR maps per Host Bridge
> Interleave Granularity (HBIG), but the number of maps to apply
> depends on the Host Bridge Interleave Ways (HBIW) for each region.
> 
> Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
> XOR maps regardless of the region's host bridge interleave ways.
> This causes incorrect address translations when multiple CXL regions
> with the same HBIG but different HBIW's coexist.
> 
> Example scenario with 3 XOR maps defined for 256-byte granularity:
> - 4-way interleave region:  should apply 2 maps (was applying 3)
> - 8-way interleave region:  should apply 3 maps (correct)
> - 12-way interleave region: should apply 2 maps (was applying 3)
> 
> Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
> a lookup table to determine the correct number of XOR maps based
> on host bridge interleave ways.
> 
> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Applied to cxl/next
c7ad33d50282168fbfed1c6662503b0d979a67c8

> ---
> 
> Changes in v2:
> - Use CXL_DECODER_MAX_INTERLEAVE in hbiw_to_nr_maps[] definition (Dan)
> - Rebase onto latest cxl/next
> 
> 
>  drivers/cxl/acpi.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f1625212b08b..26c494704437 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -16,19 +16,31 @@ struct cxl_cxims_data {
>  	u64 xormaps[] __counted_by(nr_maps);
>  };
>  
> +/*
> + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
> + * the same host bridge granularity share. The number of maps to apply at address
> + * translation is based on the Host Bridge interleave ways of the CXL Window.
> + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
> + */
> +#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
> +
> +static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
> +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> +};
> +
>  static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
>  static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>  {
> +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
>  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> -	int hbiw = cxlrd->cxlsd.nr_targets;
>  	u64 val;
>  	int pos;
>  
>  	/* No xormaps for host bridge interleave ways of 1 or 3 */
> -	if (hbiw == 1 || hbiw == 3)
> +	if (!nr_maps_to_apply)
>  		return addr;
>  
>  	/*
> @@ -50,7 +62,7 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>  	 * bits results in val==0, if odd the XOR result is val==1.
>  	 */
>  
> -	for (int i = 0; i < cximsd->nr_maps; i++) {
> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>  		if (!cximsd->xormaps[i])
>  			continue;
>  		pos = __ffs(cximsd->xormaps[i]);
> 
> base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1

