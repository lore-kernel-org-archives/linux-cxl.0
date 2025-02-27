Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C571AA1F4;
	Thu, 27 Feb 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673314; cv=none; b=SJm3ywrhOQl9EZUoXo/poJj9WV1E8jKYf///9XRWuSKfhSPoutLsVppVpfPh1O45PcO0+2xZT2UIXK8PLbr+rRlOLltFdlYoedtI6vlC8MIvSnOmXKFgT7Mgdw9OJKY53u650u46x8wFWatFdjg9SVUlcmo/WI1nKFKD4Zezl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673314; c=relaxed/simple;
	bh=YYoL9mXCjZe3ny9jvBdlXUqa1NlA6Q8+VWa6MkUbp5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyOKWAMe+cNqgo0rkz4pxkjvG3WiPE/JPf9T9YhQFh+TPP/XoNCHVdcAFAD1wyEpmucE/7TuthPpocghHPrEJ/+2BXxKtTYjZXlMPtHXXYjasgkB/o3wq2b82pnDcqoleHSIlCQdgq+4SQ4GMrW3qS/KC+BwNhfq4mRbV8faP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAQfOw3z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAQfOw3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740673314; x=1772209314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YYoL9mXCjZe3ny9jvBdlXUqa1NlA6Q8+VWa6MkUbp5g=;
  b=jAQfOw3zcvjjT8PlfQVBehOdI3jS3LEVEtUwFpGusiZtF8AAqkAOl2Bt
   f8nBYIDEmYMIFtwx+N4x9wNqx2uc+FYf/MR4DEgFESFDt2iY0OnoWnUPR
   KL8k/44LQDEznoJF7mwS06WDLUCnTuSY5rd9r+nCWhzc+PTd5T46vf3bL
   iKasirni8mucyRIj4mm+eVoaK/yX1y1qE2k/hVIZXoldyTLZM5pJFmKZc
   4xaZcpxJnKfqOgDzy/k862g/h/AxfEMGbljbT/hEDYRaG+wjwm0kPGcpS
   Ee0k/IDGgMikbOpereqFKB3EgB5ey77/TcrLvWqz5sjbKpJh4vl0RvlOR
   g==;
X-CSE-ConnectionGUID: DRa/fQ7ZSRaWz4dt+YvJhA==
X-CSE-MsgGUID: R4XM10wDTv2j1igdsfVOVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="58987922"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="58987922"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:21:53 -0800
X-CSE-ConnectionGUID: z4BTEjR0TbS+jzRY3gjvtg==
X-CSE-MsgGUID: yfCOwU0oR4248qzn6o5DbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122085511"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 08:21:52 -0800
Message-ID: <e5670ca8-e4ad-400f-8e46-6fd9a9637f96@intel.com>
Date: Thu, 27 Feb 2025 09:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/mem: Do not return error if CONFIG_CXL_MCE
 unset
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227101848.388595-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250227101848.388595-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/25 3:18 AM, Li Ming wrote:
> CONFIG_CXL_MCE depends on CONFIG_MEMORY_FAILURE, if
> CONFIG_CXL_MCE is not set, devm_cxl_register_mce_notifier() will return
> an -EOPNOTSUPP, it will cause cxl_mem_state_create() failure , and then
> cxl pci device probing failed. In this case, it should not break cxl pci
> device probing.
> 
> Add a checking in cxl_mem_state_create() to check if the returned value
> of devm_cxl_register_mce_notifier() is -EOPNOTSUPP, if yes, just output
> a warning log, do not let cxl_mem_state_create() return an error.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next

thanks!
> ---
> I hit this issue on my cxl_test environment with latest cxl-next. If
> CONFIG_MEMORY_FAILURE is unset, all cxl pci devices will fail to probe.
> 
> ...
> [    6.337952] cxl_mock_mem cxl_mem.6: probe with driver cxl_mock_mem failed with error -95
> [    6.338880] cxl_mock_mem cxl_mem.4: probe with driver cxl_mock_mem failed with error -95
> [    6.339593] cxl_mock_mem cxl_mem.9: probe with driver cxl_mock_mem failed with error -95
> [    6.340588] cxl_mock_mem cxl_mem.2: probe with driver cxl_mock_mem failed with error -95
> [    6.340914] cxl_mock_mem cxl_mem.0: probe with driver cxl_mock_mem failed with error -95
> [    6.345762] cxl_mock_mem cxl_rcd.10: probe with driver cxl_mock_mem failed with error -95
> [    6.345793] cxl_mock_mem cxl_mem.7: probe with driver cxl_mock_mem failed with error -95
> ...
> [    6.519824] cxl_pci 0000:c4:00.0: probe with driver cxl_pci failed with error -95
> [    6.520178] cxl_pci 0000:38:00.0: probe with driver cxl_pci failed with error -95
> ...
> 
> base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
> ---
>  drivers/cxl/core/mbox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 13cac98846bc..d72764056ce6 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1503,7 +1503,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
> -	if (rc)
> +	if (rc == -EOPNOTSUPP)
> +		dev_warn(dev, "CXL MCE unsupported\n");
> +	else if (rc)
>  		return ERR_PTR(rc);
>  
>  	return mds;

