Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319D1DE89C
	for <linux-cxl@vger.kernel.org>; Fri, 18 Apr 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994259; cv=none; b=kNjZIKH+Xfkr5YO2lu49oYnJeIIcnHrGr0Fr5lLCMf9JzabY2WhRjWCVTsr6bUG7a87Dk8UpU9s+SXcq0j/tcFeWcBRMqgY+1fvKNYqYl4Ax+Lf8OM71+tQu7QcYD47SSIYt4PNzOa5ZZRE3PBNGiwP2h7d3k55lB4QzMnDXHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994259; c=relaxed/simple;
	bh=lV4lnCGoVt7vlT/aQyjg7yqnq2Z/liLMMJsG95qnOMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uEL3l2fORfYZlX8NP2Fak7DQs2OZ5+jsL6abEnkscrDbNYsFo+ngywC5ax8SIBY5zGlWcnmIy6006Hk++Szvx08BzWhuKgyvfFSYVkjjlmOoFycizE+Ynplk1IKEJsmzyzDK/vSGZN1i3cF39hh+NqaAKCOV/GmBMxis7QgZol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKgcuks5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKgcuks5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994258; x=1776530258;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=lV4lnCGoVt7vlT/aQyjg7yqnq2Z/liLMMJsG95qnOMk=;
  b=XKgcuks5e1xZtZlYJgs9o5X3Ts44G3tM90bAKHpo0az4vh4CioxUvnJ/
   iYsMUuf2gDF8PuylpskHPMyfEWJ8BqFJFN9wDwa4rA0+xSuIbY/Oqfk2r
   B/hmxW83XVoNQ/yKSbmLwwEQW0kwK0AZ8L4RMi8dk64Q7jF5h4PkbsYZA
   cy9H+mZiDdoG1+cEsTUM/YvAUmEgkKID/Ilc7IuLVJpx0//rucjQW92IX
   2mxJcdvq1Fhyqi//D3wyJvWTmWXxWMmzmPI1QGObkKQOZtt/63Bs7tiZ3
   2e0/bXVLabMDjCk5lxk77N88rcxyyHLXXeShl/z5XsaETCYx+7pRxxW5r
   g==;
X-CSE-ConnectionGUID: a2LaesRLRVaDjArEz8bLTg==
X-CSE-MsgGUID: yIWchtHrTS2IcfCyFy7D9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="57287722"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="57287722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:37:38 -0700
X-CSE-ConnectionGUID: EFEjACRjTpeDGI9jUaZZSg==
X-CSE-MsgGUID: bJrUmGXjQzOcDQeswU4eGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="132046418"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.182]) ([10.125.110.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:37:38 -0700
Message-ID: <c6a21d00-b268-4488-bccc-d4be270033e5@intel.com>
Date: Fri, 18 Apr 2025 09:37:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix devm device for cxl_fwctl initialization
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250418002933.406439-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250418002933.406439-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/25 5:29 PM, Dave Jiang wrote:
> Testing revealed error message of for a CXL memdev that has Feature support:
> [   56.690430] cxl mem0: Resources present before probing
> 
> Attach the allocation of cxl_fwctl to the parent device of cxl_memdev.
> devm_add_* calls for cxl_memdev should not happen before the memdev
> probe function or outside the scope of the memdev driver.
> 
> Fixes: 858ce2f56b52 ("cxl: Add FWCTL support to CXL")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/fixes

> ---
>  drivers/cxl/core/features.c  | 4 ++--
>  drivers/cxl/pci.c            | 2 +-
>  include/cxl/features.h       | 5 +++--
>  tools/testing/cxl/test/mem.c | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..150a1776480a 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -677,7 +677,7 @@ static void free_memdev_fwctl(void *_fwctl_dev)
>  	fwctl_put(fwctl_dev);
>  }
>  
> -int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
> +int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_features_state *cxlfs;
> @@ -700,7 +700,7 @@ int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
> +	return devm_add_action_or_reset(host, free_memdev_fwctl,
>  					no_free_ptr(fwctl_dev));
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fwctl, "CXL");
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b14a154463c..785aa2af5eaa 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1018,7 +1018,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = devm_cxl_setup_fwctl(cxlmd);
> +	rc = devm_cxl_setup_fwctl(&pdev->dev, cxlmd);
>  	if (rc)
>  		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
>  
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index a3bb34694c06..5f7f842765a5 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -66,7 +66,7 @@ struct cxl_memdev;
>  #ifdef CONFIG_CXL_FEATURES
>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
> -int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd);
> +int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
>  #else
>  static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>  {
> @@ -78,7 +78,8 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
> +static inline int devm_cxl_setup_fwctl(struct device *host,
> +				       struct cxl_memdev *cxlmd)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index f2957a3e36fe..bf9caa908f89 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1780,7 +1780,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	rc = devm_cxl_setup_fwctl(cxlmd);
> +	rc = devm_cxl_setup_fwctl(&pdev->dev, cxlmd);
>  	if (rc)
>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>  

