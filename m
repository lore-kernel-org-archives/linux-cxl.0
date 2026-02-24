Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD513A7838
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949615; cv=none; b=WXn7zxlXb7pZ3pctm/zWm70ueZEB4TCWbkoDQB8NQrjZ4NmxAarzs89Z4HICclKyK5WMsYBjNFv4P9vl+76/sv9rXG+Nt0T3beEQH1VqNENes3MxnG8WH3dccvYoi/obQl+3ukDRmAHVzKXCiP8jUYqTNFfiLLtsZdA+UssyzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949615; c=relaxed/simple;
	bh=XVWp+/qqFQrgD8Wp/k4nzyruwxqTOukitV+viCzdCBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N16trl1jptbIPUCVXVlpHcKX4JfN8rOX5caTP/D5Q7EnzPCa4930OfuXPpsUPlhr6mtpT2R/Pf8r/0d+UR1M6on8yaNEbel/bebN8KL4r3tzWXxtDFEHY5dZri9COYtl2mxoT9MykhhNdsw+9I15cisuJE3cfoHr/cGpOZ4/PxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bk1doSYC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bk1doSYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771949614; x=1803485614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVWp+/qqFQrgD8Wp/k4nzyruwxqTOukitV+viCzdCBg=;
  b=Bk1doSYCVHUs4f84DCMMWGBH/r2BAlMlAoJ4oHLgjhVHBm1g/91M9IVH
   bJFVYkrXOSjCzA2vmroNLBSQjis0Cw8kFfeg0WXW7AFMlUKcFSVfOyFxO
   /P3Erym0ygXFGhsgKJ3KoTDPQjSs6m9mtQFgNCwqARyryloHwmbpLR1Dt
   wGfx56GFKJpvnJrlbSI8NtJ7xwjV51LbDdGaOQ4SfxMQyuU4jzAve70I8
   hxVFbhk46VCaXXiNIj4brbs5QG7xqrDZXhLsn5fCFpzyvuuj5s7/2pOcP
   hiV0ZK41Y/wAsRhGl3WZ/2UFP16oJfIP+obl81xylBBlfIxRrLzolOifS
   Q==;
X-CSE-ConnectionGUID: Xc9lTyUCQw+hFMXyPeNbQw==
X-CSE-MsgGUID: bN7fpYYkRDSF3+0FsN11LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84428337"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="84428337"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:13:33 -0800
X-CSE-ConnectionGUID: F5SoE0i2SMylUeg8XdZw4g==
X-CSE-MsgGUID: 5elCukauSaiFzqf18OwhGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253700353"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.22]) ([10.125.111.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:13:32 -0800
Message-ID: <11ecbc8d-3105-4c65-a444-6bc64530d536@intel.com>
Date: Tue, 24 Feb 2026 09:13:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cxl/region: Factor out interleave granularity
 setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224152645.3441489-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 8:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space

same comment here as for 2/3.

> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave
> granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3ef4ccf1c92b..aed3733490a1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -559,21 +559,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
>  }
>  
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t len)
> +static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>  	u16 ig;
>  
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
> @@ -589,14 +582,33 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>  
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>  		return -EBUSY;
>  
>  	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	rc = set_interleave_granularity(cxlr, val);
> +	if (rc)
> +		return rc;
>  
>  	return len;
>  }

