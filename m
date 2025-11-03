Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AF26B0BE
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213421; cv=none; b=INayk+tZ7x0kPGRyCUov+dbXUxQgpRQXbP7E4+ejbGBg+r5FW6aLJO4/o5wX8vTTfi7YuzDscGuoFCArEyveby7iKzZqhsbedfvdgihYNdn+5KAbQAyKk88FFA92fHoqJvW0OJAHA3X2YdOpWwjaX5eMaOuKG3ScmbLUA6klmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213421; c=relaxed/simple;
	bh=JuEgmWHrcPl2bPIi2IudV1QB47+SgG/yBqxiplWeCPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TenO6HHE1Y4ZiutzeNOflPNnDP2edCtWwqz/iZGQxrOzsvxRqdZWpWVCmNoZy0Q01hAKO6rcg8A88aLdAgQJhVZw93gn76itapMjCrbEOfdxuWfrTZBnTJsk1tnYUrR3px4WW5PMJQ6w95lhNiXr2mPKlxXJReyRVUObWcNgsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGINp3Wd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGINp3Wd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213420; x=1793749420;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JuEgmWHrcPl2bPIi2IudV1QB47+SgG/yBqxiplWeCPY=;
  b=hGINp3WdXfts8yvB8pwy6JkNMdJD13at0M8UXgugirhn0rZ7XToh3A0U
   vi5ahQzAgIuoMGxVa1AV0cZLTSX+82DVvr5krk5Pa8Lc3ENMSP0qvTAxV
   BS2Wgd9SAUbsDqqGMtUuPHrAoJG94B5KJYYKV0g5ZIW+yGhOIri1qGonI
   Lq4HNjJvNiZ4BNK5qooEdibES7XvI+pUFwHOKvM0jYVpavICbzCl0ikv7
   bq8S2eH34mFaNDl2Ug5t5sFOqfThVcm8yiqU10d61Zh/ZCfRKOSCcALDs
   5VlxdBdNO4hNv/f1YC+OPIopZa5pdyBV2sfXRxvTSVh373MVq1hNSR2H4
   Q==;
X-CSE-ConnectionGUID: B9tVbfz7TsutmTm+/HaEHg==
X-CSE-MsgGUID: ix4oRMXmTNy42j2tgyLimA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89761868"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="89761868"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:40 -0800
X-CSE-ConnectionGUID: bGMlXkJKSUakS92Mwsu7sw==
X-CSE-MsgGUID: 2ksWidk5QbqD3lA+M+oy6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186678505"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:43:39 -0800
Message-ID: <07177d90-f588-4b98-a457-a0ba580d9d54@intel.com>
Date: Mon, 3 Nov 2025 16:43:38 -0700
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

Applied to cxl/next
040acb49bf862dd851144bfc0872555d4ac4ffd5

> ---
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

