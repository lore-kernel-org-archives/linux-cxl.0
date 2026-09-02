Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BB4A5C3B
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363537; cv=none; b=rpmXlxkfi1pI4DES6O9rW/K/RRHfXuj0CNF30rQQHzSCNbkQTtvce6y0m3Iva3nFY/uvkXGU90c4My+rlWvc0K1TW7jIFc30ZNR126Fzx00ixS/Ug/V7q2ShsP8cSY/x1Ghf8VXkQeg7RlwBUUgRod4jDrrjnyhU/6g+2objrmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363537; c=relaxed/simple;
	bh=RAdaQMC02UZ8M9q3kLMms+I0Fi+k/Q4jqE+pb90qMjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFofF+/lY9I60CF068l5tLXNa5zDv7tA7s/p6io+vCe5Akq52xme1MxAKRet3ZJ6kVAEcRhH9vQvlztleHFbENH1ckpXF3Johw+YJxMOqnljCNq0JoCVmMNtZffWpY9Gx4t2NzKw/RPBKuLlMPoHD8FQCyPLFcNyg6wN/pbuo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmyPWKzb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmyPWKzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363535; x=1819899535;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=RAdaQMC02UZ8M9q3kLMms+I0Fi+k/Q4jqE+pb90qMjA=;
  b=RmyPWKzb5k7sXucxv3jxa8yFVbpcke/FF3b6yn17kS19s+C066aGSSrA
   H6YgRzwKhNJDSPHw29We7PgbbMXhGFmRApDstUS5hCutVtkfFLSP/OKHy
   U3f2+clA3En8WRFKSrAS8mdRw4BUE5FaEJqh0etVxvtiOvN10e6qwxlag
   pQwRvzPjNgqEVUKOz5pl7HpIjQzc3RcsFvRmKpk08lTagsNdOhM2gIiLo
   Hb6MxIo6/3OE1N064P0XHnHVAuYjxZMk34kQMNZy2SlsaHyqk8GJ29Z4T
   6GO7T6X28DiBIpuImCMm2B7pifTb9Jigth1udScxFDBraZtopPVOAbeOS
   g==;
X-CSE-ConnectionGUID: BQwOn7ZXQ8Surm0tfWIMeg==
X-CSE-MsgGUID: 1GFU29x5T3C5p1doZ2Rljw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99425956"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99425956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:38:53 -0700
X-CSE-ConnectionGUID: SGFhgqXYQfaowAJOtEJ/7A==
X-CSE-MsgGUID: 2Y8U0ZGqR4uF4bYZ+DS2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274719203"
Received: from sxiong-mobl3.amr.corp.intel.com (HELO [10.125.110.132]) ([10.125.110.132])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:38:53 -0700
Message-ID: <da5d796f-ae5e-454f-8a40-4ef50a9a8436@intel.com>
Date: Wed, 2 Sep 2026 08:38:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Pass the PCI device's struct device to
 match_memdev_by_parent()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 ming.li@zohomail.com, terry.bowman@amd.com
References: <20260828215726.1077498-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260828215726.1077498-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/26 2:57 PM, Dave Jiang wrote:
> cxl_cper_handle_prot_err() hands bus_find_device() the 'struct pci_dev'
> where match_memdev_by_parent() expects the embedded 'struct device'. The
> comparison never matches. The lookup always fails and CXL endpoint
> protocol errors reported via CPER are dropped without a trace event,
> leaving only the root port, downstream and upstream cases reporting.
> 
> Pass &pdev->dev, and rename the callback parameter to match what it is.
> 
> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
977eaad352ba

> ---
>  drivers/cxl/core/ras.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index c91db125a971..a2c7c9479f2b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -70,9 +70,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>  }
>  
> -static int match_memdev_by_parent(struct device *dev, const void *uport)
> +static int match_memdev_by_parent(struct device *dev, const void *parent)
>  {
> -	if (is_cxl_memdev(dev) && dev->parent == uport)
> +	if (is_cxl_memdev(dev) && dev->parent == parent)
>  		return 1;
>  	return 0;
>  }
> @@ -108,7 +108,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  
>  	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> +		&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
>  	if (!mem_dev)
>  		return;
>  
> 
> base-commit: 751627a8c5cde68e0b396126449749e8bfbe592d

