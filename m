Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBA377559
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929537; cv=none; b=lMDNj5Lopi8jWYogJD7yfCV1ygfsJ03yPaYFGICYURIGMqX2lXYZV+4PFfw+fu79Vtu5tx3PWsRMAyoKSDwhoaHotFrjSBT9rSL1+DxYAM/GGh3+PqYlTaEvi4e3xE0R52Hnf1g5m1BlqRHT026aQxjJzl2iDKPqJlXZEZFXXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929537; c=relaxed/simple;
	bh=tLp+B45gDJB0rsS/f5FeGIOHJS+kTNq+xH7/osM750M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lm7ox+Ns5BcJCSlGRwdfLCIcLwet6t/CBstt9b5JajO4sbtFREKoBsZaU1YCHQKUI8YUlhh2xG9s9n1qi3RJ1UwSqaebkf/YcvKiGAt5388Lcqlg8FK/tjl3/Do68TzCHiYXVtsHQuFWrTu2vHwOZnbcxnDJZODtQPOAOzaY4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HD075iR8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HD075iR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782929535; x=1814465535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLp+B45gDJB0rsS/f5FeGIOHJS+kTNq+xH7/osM750M=;
  b=HD075iR84SOFgQSAogbNaCSd23CbTMcltusOlQ5nU4FjBEpYVCY6pSLh
   YTmnikPMlgDUek2vz3Ls3U3BRD/A3gz2GxU67a91FHMch1aDRC7scvZ3v
   vfOz6RK6Qmekm0Tv32kC1Zqmpgz/gE1GiuKWz1oxT9qsZp4c/+kp35ba7
   Mh/fd6JnssveuTE+eFkPdIbKD7Agfxbhz/2aDON0v/x2Mwe1hEiIK4nNd
   5g2cugKLCNspLX4I2ouUtoLQzwy5daAe81qF5EQnyj45hdnMdJy+XggVX
   kKScWtCOC3ZGG3HaEqYhgRwc8omYHXRWAEZsUbP2tCFxVr8p+UpHoVIu7
   A==;
X-CSE-ConnectionGUID: RGEC4isVQ268x/q7HdXo1A==
X-CSE-MsgGUID: 1KI8o018RYejLPnm75MhNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94271214"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="94271214"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:12:14 -0700
X-CSE-ConnectionGUID: K2b0tnXJQoeaLRfGv4ZpRw==
X-CSE-MsgGUID: 3JLems1gSx23YArDzWFeoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="254570949"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.66]) ([10.125.110.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:12:13 -0700
Message-ID: <ceb03250-79c6-4f94-b37c-ef1d6818c163@intel.com>
Date: Wed, 1 Jul 2026 11:12:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] cxl/hdm: Rename decoder coherency flags
To: Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, icheng@nvidia.com,
 alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
 dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-6-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260615145529.13848-6-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/26 7:55 AM, Davidlohr Bueso wrote:
> Align with the ACPI CXL Window restriction naming and convert
> CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
> Type3 coherency models were named prior to Back-Invalidate.
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/acpi.c      |  6 +++---
>  drivers/cxl/core/port.c | 12 ++++++------
>  drivers/cxl/cxl.h       |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 6a9ba82719e9..087dd1e86d40 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -143,9 +143,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
> -		flags |= CXL_DECODER_F_TYPE2;
> +		flags |= CXL_DECODER_F_DEVMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
> -		flags |= CXL_DECODER_F_TYPE3;
> +		flags |= CXL_DECODER_F_HOSTONLY;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> @@ -445,7 +445,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = (cxld->flags & CXL_DECODER_F_TYPE2) ?
> +	cxld->target_type = (cxld->flags & CXL_DECODER_F_DEVMEM) ?
>  		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 71801dfd614b..63005cf0fa91 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -128,8 +128,8 @@ static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLY);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>  CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
>  
> @@ -357,8 +357,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>  	unsigned long hdm_h, hdm_db;
>  
> -	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> -	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
> +	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
> +	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
>  
>  	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
> @@ -368,8 +368,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>  	unsigned long hdm_h, hdm_db;
>  
> -	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> -	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
> +	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
> +	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
>  
>  	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 29231d0db470..b0b4ea4ff8a5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -282,8 +282,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   */
>  #define CXL_DECODER_F_RAM   BIT(0)
>  #define CXL_DECODER_F_PMEM  BIT(1)
> -#define CXL_DECODER_F_TYPE2 BIT(2)
> -#define CXL_DECODER_F_TYPE3 BIT(3)
> +#define CXL_DECODER_F_DEVMEM BIT(2)
> +#define CXL_DECODER_F_HOSTONLY BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)

