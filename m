Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A322652D
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948488; cv=none; b=AvE89NEzLeZ4aVv/76rRfNIePji51swBM+pjnvXHMxBwriPhYm1LQk+cVzY15NXAcb1B19BhFO05iwM/xMRhwiO/ic3TaKC38O6RhMJvJLRBMMYocVJGJ2DvKw2TJHr3EYVYzkspgYF8ME/XF9OBieDjr6yie4RBUNxa8hA2BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948488; c=relaxed/simple;
	bh=80LmEBzIW+EPcO6oq4fx6IHv4NUWCNvqFuPHpvP+p+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEaeMHpdBYIimuMhc7O/toqnQZIhsBV8SBcz4hy6Qn9CNYWredOAm+wQdI5vHlhaoYJFUTYCP+KzRtPUfPYbBHRFKvViWI26JKCetLMCdIHp4oub7a+MdyEfjtx10AX1GnqSVpjxA6CpvCOQfIRoOTly4HVYI5AEQ9UQmepnups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdS0tmBS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdS0tmBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771948486; x=1803484486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80LmEBzIW+EPcO6oq4fx6IHv4NUWCNvqFuPHpvP+p+0=;
  b=NdS0tmBSEmlO9iVcyON32xWD5oWT0umWKB7DtleebwnNZUtkqNqBDHuj
   +z3lJ+H9qhXyyvejdtbCER8PFiaABPIQdMFtjP29LEVQLsb7b8FAYkyX5
   bdpUHvM7nOGO0dQUiD9/EaAYkSEtAgs0Nzzlh8Q/yqu6NjV1WdiaAkerq
   ypUH2P2ZDKnfmvjYmeRm6G+6WtdY+7LcKt6ZVorWQZgj5TwcK63dEY3ZX
   ogupApZszDkgeFPE8HlCHQgUeQ3gm9YxpyRARhBF8OqrTBYf7NyVm/mt5
   7IxFHXO06yh/hBJIs3KBmV51s7DPYBNyBpTCPq9oEC74urFEBJP/d12lr
   Q==;
X-CSE-ConnectionGUID: XOJSnou0RaOPgKO8WZu+mA==
X-CSE-MsgGUID: QtijHuJfT56lB4AOgi9iSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76831631"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76831631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:54:45 -0800
X-CSE-ConnectionGUID: T1bg5xhSQOKyZtmmcGnTdQ==
X-CSE-MsgGUID: K0H7sPzQSUGoklcEmZbZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253694978"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.22]) ([10.125.111.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:54:44 -0800
Message-ID: <0e6a60ab-8b7b-4432-b22e-336c68b328e5@intel.com>
Date: Tue, 24 Feb 2026 08:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cxl/region: Factor out interleave ways setup
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 8:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space

s/is/can be/

Since there's also auto region creation.

> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cac33c99fe6a..3ef4ccf1c92b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static const struct attribute_group *get_cxl_region_target_group(void);
>  
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;
>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>  
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>  		return -EBUSY;
> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> -	if (rc) {
> +	if (rc)
>  		p->interleave_ways = save;
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
> +	if (rc)
>  		return rc;
> -	}
>  
>  	return len;
>  }

