Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDD2D7DF6
	for <linux-cxl@vger.kernel.org>; Mon, 13 Oct 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381619; cv=none; b=Uj0GzVoso2RTem9jOEZIhrQqPCfiveuxJO8gFJ2gWeZp+nl3hJiRru4THdujGnPu/Js27xgmewojqOr0Uvx5UQL+8CvbWBgVyI/eCjlIZxbMXyIdpXDtuw6OHuhQsYnUEcrwnQgwmoXOfaa+vkpjoBLh3fMa5Z7MZqj0QVfGMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381619; c=relaxed/simple;
	bh=FDt+T6MO1Mv1ItOPOtwIIByVdHPUT8W1JqbXnLA2OvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mon8zs82d8cCTXr5MtR4aqHk9QqeLe16NoI3CSxaCq6r2qVC1ZUmerr9AFfbbCDoM3T2l0yN1TpgP0BCSchVTsNSR7uqictfbA6Lt2xmrOarVVVU/ljmPY2XAM8AtE3uINTZcEP/Lxloi8/VbnK497IIWVolwhe4pf8l6C+BLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDuvb4WP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDuvb4WP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760381617; x=1791917617;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FDt+T6MO1Mv1ItOPOtwIIByVdHPUT8W1JqbXnLA2OvQ=;
  b=XDuvb4WPrEvpz/rPNFC+0hz81vfEZXcJZb+HSetmvkqmZBisBOSBL0L3
   aIn2TF4wscwjhsw/fYJSqbpOsF01I8pFHU0xbpuSFhp11k0yf/wrcKS9+
   CIjXLDDMKwhXiPsjpGlPosWLmRsoxtgjCBH/26fID9Vsx3SbX95IaGxGZ
   560UfFvq41eivdMcjOyKSIaM7zqZCvIn9O9Bj4VombHwjHky1LIVZa9JE
   edJ1CV52H7zq3gb+RtwDVmx32Qu6cLzhXS637q61iV1D2Hi2dQOFOOdLQ
   pWQ7Bmyd/xiM+dAO1FiL5pdt9p5S0Pv3jY8C5FazxfCU3khKZVLgK9Snp
   Q==;
X-CSE-ConnectionGUID: uBEbLl/rRJih0UrAzzoZyQ==
X-CSE-MsgGUID: NcZBvSnNSJCRV3DmW/miwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73634286"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="73634286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:53:36 -0700
X-CSE-ConnectionGUID: ocFL1b/eTwasMHKV9V5IBA==
X-CSE-MsgGUID: RiiVTh26QBKN0p5TNKrLdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="212296596"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.111.141]) ([10.125.111.141])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 11:53:36 -0700
Message-ID: <39194f34-1434-49e2-8d7f-22bcbe9be2c6@intel.com>
Date: Mon, 13 Oct 2025 11:53:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: fix typos in cdat.c comments
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20251011183050.616325-1-alok.a.tiwari@oracle.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251011183050.616325-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/25 11:30 AM, Alok Tiwari wrote:
> - Corrected spelling of "bandwdith" -> "bandwidth"
> - Fixed "wht" -> "with"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

thank you

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/cdat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index c4bd6e8a0cf0..7120b5f2e31f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -826,7 +826,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
>  		cxl_coordinates_combine(coords, coords, ctx->coord);
>  
>  		/*
> -		 * Take the min of the calculated bandwdith and the upstream
> +		 * Take the min of the calculated bandwidth and the upstream
>  		 * switch SSLBIS bandwidth if there's a parent switch
>  		 */
>  		if (!is_root)
> @@ -949,7 +949,7 @@ static struct xarray *cxl_hb_gather_bandwidth(struct xarray *xa)
>  /**
>   * cxl_region_update_bandwidth - Update the bandwidth access coordinates of a region
>   * @cxlr: The region being operated on
> - * @input_xa: xarray holds cxl_perf_ctx wht calculated bandwidth per ACPI0017 instance
> + * @input_xa: xarray holds cxl_perf_ctx with calculated bandwidth per ACPI0017 instance
>   */
>  static void cxl_region_update_bandwidth(struct cxl_region *cxlr,
>  					struct xarray *input_xa)


