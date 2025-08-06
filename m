Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AB17736
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516821; cv=none; b=Wf1myHkW8s93sd2Bz+BfDNCxWL9Coql3xANZ0BYb4CSHztUkNZHCUplUuRZFW3O68KzE8HrskrC0UaNNyWKn/rOePyuVk96DAKaMWr7dFRVG1+GW7uSrp4I65UEIvGOp4ImDjLq4i+zw5m3oxNu6G26Yi1HNESjZNgxhGKh+yXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516821; c=relaxed/simple;
	bh=n34HhzOs5x1fkgAGqnTINkXpNX+q+TD/vE4pidYXLBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l64zssbkWm7U2+1U0kPnKffdRVhceHpUsuG99ajTGXygGu/lfAvHqJWUcRIxJCRhdMia74M5V17Ty3UVJK4iGyNTDEh/kCzCCUVxfeAZdhebxaduIQ9n3rDFych6yqS2onnr7tdbBSeYGbfJo1Qh79i/b88Thnd9IKWSX/4kwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByOATuti; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByOATuti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754516819; x=1786052819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n34HhzOs5x1fkgAGqnTINkXpNX+q+TD/vE4pidYXLBQ=;
  b=ByOATutigK/kCmC0VVjKrUfQHNbz/iXfld85MgUYcxGIvDnuAKuN1h6B
   k3HfUh8Ed8VmjdvDaolZOSF4Qeqh1HD9GeG5hDvBMeBIX07X+F9C+0OAi
   ltdZ1TMdv1h1O/4XDB/mshifC4GVkU9i0VOxzRB6pF0i3XHBcr8K2wC4y
   khtq42eH6VpP08IBtK46IE+DB8MJmxtSMTAc9Ws2PUSntvePLAzoVw6Q5
   hhylPE2ur6bAw4lntJDevlfLLP+Eje9uvVQ5WKz7OQWiB8oyI7UTuSerH
   3mc/oK/584Mh2b3NwcQc8onQgZQFnLCDwiQdnmyPd/xR1PxIzcmxfyOHi
   Q==;
X-CSE-ConnectionGUID: lbolqf9iTy+MlQx724iO9Q==
X-CSE-MsgGUID: Ic0u3comTsiuTuSsyBLVkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60477419"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="60477419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:46:59 -0700
X-CSE-ConnectionGUID: obvsypYwSJSWHY3mJc827Q==
X-CSE-MsgGUID: xsSvJjvfQH67mj8kzP7HYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170151476"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.100]) ([10.247.119.100])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:46:55 -0700
Message-ID: <ea832391-3ec1-46db-ae2a-7870074c7179@intel.com>
Date: Wed, 6 Aug 2025 14:46:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250804082357.2590809-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250804082357.2590809-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 1:23 AM, alison.schofield@intel.com wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 712624cba2b6..5154effb0cb2 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -16,6 +16,16 @@ struct cxl_cxims_data {
>  	u64 xormaps[] __counted_by(nr_maps);
>  };
>  
> +/*
> + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
> + * the same host bridge granularity share. The number of maps to apply at address
> + * translation is based on the Host Bridge interleave ways of the CXL Window.
> + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
> + */
> +static const int hbiw_to_nr_maps[] = {
> +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> +};
> +
>  static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> @@ -23,13 +33,13 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  
>  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
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
>  		return hpa;
>  
>  	/*
> @@ -47,7 +57,7 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
>  	 * bits results in val==0, if odd the XOR result is val==1.
>  	 */
>  
> -	for (int i = 0; i < cximsd->nr_maps; i++) {
> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>  		if (!cximsd->xormaps[i])
>  			continue;
>  		pos = __ffs(cximsd->xormaps[i]);
> 
> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f

