Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE5202C40
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227294; cv=none; b=GqC1YZWzz7bQXO+e5ln3BL89Q5gt8pg9VcfQPMaTn7C+HggO5aE222Pirf5X1ry1gbXBrSUIWQV6y+S0vLGAJwbHrjmwUBa+a3U6wRoruEgDexU7hovTlM/so74bme58B0vnplxQz5SS4m52ZvN9HBggBGqumNTmHbvNLWwuNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227294; c=relaxed/simple;
	bh=vhWJLK40awTP/wwAl79XICQhX+g8zz1SDz49QKj5cqo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SaL50fSw52CweAW3v9KyioUDsdTn0+9EyPI/i1RsgLD66/IAI88LEfD7wJkMh/3iAxhPLOHgk6ktAX9HYd0OKw1uzJalmo1pFsljIfyLEDc1RfLXo/Ws0mWW7unK58oU+ATQoAgQAbUMR9sM8Og9kylod9BE4JRqJNPAFq7YvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezxaQR1f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezxaQR1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744227292; x=1775763292;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vhWJLK40awTP/wwAl79XICQhX+g8zz1SDz49QKj5cqo=;
  b=ezxaQR1fwhdjyzWTT/AnsZIfxxULGO1NF/MivoNXJ23ZuPVhQg/LGJBI
   MflmiFmQRuJKs4dMr8erw7K9gLTqn8CmfsD41uJf7rfhanc8iH9cq8hCg
   l6cwtIkKNgjIsJsZGmBzHOq3QLk+KRKmfE9gwJW0ou1g4wEa7bLgzTINa
   K4KXRe8uGtNd34DE4ole8hReWe96m0GsXK60bQYgXV/eRr3gs6osgDQLl
   trny5X9qq0jhkGp4baFvv7W/BWWt/XIs0peH8hyXXyhkuCruqTLysPWKc
   tabQzAgO3aPwWFf29kGwu9vz22pcg6cb4Ea6SNyK4iMViXH67riHPcTvb
   A==;
X-CSE-ConnectionGUID: Jreq2xoPTBG6ggiz92FQ3Q==
X-CSE-MsgGUID: P1FemkW2QdOPd78r+zd0Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56362661"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56362661"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:34:48 -0700
X-CSE-ConnectionGUID: 8hcMZQ5MScKtq5RIbxu1WA==
X-CSE-MsgGUID: nbftHBNyQAGImQ80M6uK5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129030309"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:34:47 -0700
Message-ID: <11fe0e92-fa3b-4640-8521-c0df1b1bde54@intel.com>
Date: Wed, 9 Apr 2025 12:34:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Remove always true condition for
 cxlctl_validate_hw_command()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, danj.williams@intel.com,
 kernel test robot <lkp@intel.com>
References: <20250404165418.3032414-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250404165418.3032414-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/4/25 9:54 AM, Dave Jiang wrote:
> smatch warnings:
> drivers/cxl/core/features.c:441 cxlctl_validate_hw_command() warn: always true condition '(scope >= 0) => (0-u32max >= 0)'
> 
> Remove the check entirely as it has no effect. Expectation is both of these
> operations should be allowed for all check levels. They are read only and
> have no change effects.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504041033.2HBboAZR-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next

> ---
>  drivers/cxl/core/features.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index caf92e9cea21..594f290042e9 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -614,11 +614,7 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>  	switch (opcode) {
>  	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>  	case CXL_MBOX_OP_GET_FEATURE:
> -		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
> -			return false;
> -		if (scope >= FWCTL_RPC_CONFIGURATION)
> -			return true;
> -		return false;
> +		return cxl_mbox->feat_cap >= CXL_FEATURES_RO;
>  	case CXL_MBOX_OP_SET_FEATURE:
>  		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
>  			return false;

