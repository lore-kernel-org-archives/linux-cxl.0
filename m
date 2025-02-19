Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9121420A;
	Wed, 19 Feb 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985286; cv=none; b=nuuhEjXOb17TuhXeg+nXsg2Jl4kzOjSJxP0xZ95rt0rkx6HLxlnFtm6uu7YRTziRNtAfj/p4Ehgp7/iQDDSbzJEADppOQhawqqbvMOzthv3s4zXE5aCaFRsrTzo2c+PXIE7BbeDTg0TkX+DRp3zXVEHfehq1jQGWCR7lHCa030E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985286; c=relaxed/simple;
	bh=Od+FBfOB+x7pT+x4vDKsZzziEAc6W/wj751OaJ9+uxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERIS2EqjihxOKAF1mr1nTE+ps/pA5thYmTZ+6q4glFcyLsfTkQw0kZBwdFYuiTQSOXW6WEnV11IQa8lq/zWawkdj95MLiM8BLEjQ0HOOuI7LIDabDRI12xTAEtyA97PxMhIPFvOEv47OzV6lEw6xTiZTDbOfWcYpsW19dX/g5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTjUL0gH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTjUL0gH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985286; x=1771521286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Od+FBfOB+x7pT+x4vDKsZzziEAc6W/wj751OaJ9+uxA=;
  b=lTjUL0gHIXahoe06zU8KCdBNtlcJY7TaG2Cyk0E/CLilwPim5KciALB4
   TI6pFswGurCefnSptfny+sVyUtUkOGjBgwl6b3ReJfzaQ5cRhfv+E1UuN
   0SLh4eSpeYUsiFvcG9KDysfOgaCsnpV3Co/iI9JeThqkgDkR+Gvtmosh0
   mGJ43g8+xy3/WvxW8kWakpMv4M7PjvbU12qZmrmGQ3ik1ATPD1TIljdIa
   GQC1EHazxJ0j/u/D6pJE0YDn33zEvhOaAKIQB0LkLxxJbV9GzHknX14Gj
   72dpoTGvhEFj86L7UTnKeqoMBEKcfqrbeqqTcx8VzEJIFXzcwmEZMuoh2
   w==;
X-CSE-ConnectionGUID: +Yioe6FsRwaiLtoac8zUDQ==
X-CSE-MsgGUID: UpeUXpXATw2Ln/LKINCVcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40448713"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40448713"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:14:45 -0800
X-CSE-ConnectionGUID: X2+0Pn9UQemUXt5F5t1BTg==
X-CSE-MsgGUID: xk5Kc6bGT4KXULZj2LY64g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114711764"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:13:02 -0800
Message-ID: <77226007-502c-4e80-9ea3-62409a928e17@intel.com>
Date: Wed, 19 Feb 2025 10:12:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] cxl/core: cxl_mem_sanitize() cleanup
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-3-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-3-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> In cxl_mem_sanitize(), the down_read() and up_read() for
> cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
> local variable 'rc' can be removed.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..0601297af0c9 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1222,23 +1222,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_port  *endpoint;
> -	int rc;
>  
>  	/* synchronize with cxl_mem_probe() and decoder write operations */
>  	guard(device)(&cxlmd->dev);
>  	endpoint = cxlmd->endpoint;
> -	down_read(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
>  	/*
>  	 * Require an endpoint to be safe otherwise the driver can not
>  	 * be sure that the device is unmapped.
>  	 */
>  	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
> -		rc = __cxl_mem_sanitize(mds, cmd);
> -	else
> -		rc = -EBUSY;
> -	up_read(&cxl_region_rwsem);
> +		return __cxl_mem_sanitize(mds, cmd);
>  
> -	return rc;
> +	return -EBUSY;
>  }
>  
>  static int add_dpa_res(struct device *dev, struct resource *parent,

