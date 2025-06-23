Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118D78F5E;
	Mon, 23 Jun 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690778; cv=none; b=dPnnBDykf4h9v2yb0EqbrBa2e3VwE8U89G1oFRcwT+rOJliKmfp+ueLOSzS3Cu3d8vJMLnGzypVX4fH90YcJDfDxS0+DeBB3+49UHFXmgAm3nW2k5U6TTghPY0QMwHdK3veE4jAM4cf+a0EZneeVfr7GeZ4vBcdwSb2nBvlThIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690778; c=relaxed/simple;
	bh=1gQR+7ppPqLmDzPW8pQde6K5GiVPwdBj7HlNy1QF6RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV0+mOTttsWQitPPpzXfT+Y95SFm2UPM2zOnIA7UcHoWzKZhN32qMjT9koklPLqEfB73ZW6NkNHHgP9E4A/+H1wO9GwsIjDngvIY8FFazODnwmAfgFd6OVL4lKG0nJiHSVyVnMCjZf3CR9uojfqp+r2oiE7YHW8D6bEMIr/sygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQIQitU6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQIQitU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690777; x=1782226777;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1gQR+7ppPqLmDzPW8pQde6K5GiVPwdBj7HlNy1QF6RY=;
  b=gQIQitU6fPikJXdMV4NYIoMtwbnO1NRbdQE0lvDxYv0FQF/JZR27rQCA
   OXas4SbaObHDKA8ixrOqtsiru5zj0EpXoor0egCf1lswpYvDl7tt9K9lZ
   K8eUbTgVM4uY0SknCVXZtT/50MdWBXogrfy2gjfCL6vUbGttzlg2tI1eH
   IcytAmrTAKsXkHlGNvOcjCeTF4i23k08ovJM9HiwFhksgSwGbvVxTmM+d
   tAD7v7tWj3qCampuQ6LpWwxxyoy9X2u2IXkvAK2tOEKdsKRgnI/0tRIxX
   MBXvicPxA19r2g7colfXtGbveGwSCLLahXdrydFEGVMV6e6reMyfg0cNw
   Q==;
X-CSE-ConnectionGUID: 4kUsllYVSkq6AZzGDkg4qw==
X-CSE-MsgGUID: rVVanHbiRBGCfATmsuljtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53043251"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53043251"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:59:36 -0700
X-CSE-ConnectionGUID: D0GH7/nBTZOm9NGfxdjruQ==
X-CSE-MsgGUID: VVcyVcPuTiS2pHCroFKYjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151771362"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.178]) ([10.125.108.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:59:35 -0700
Message-ID: <c98590aa-1ad8-48f7-8dfb-a343987d769c@intel.com>
Date: Mon, 23 Jun 2025 07:59:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] cxl/region: Split commit_store() into __commit()
 and queue_reset() helpers
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-6-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250619050416.782871-6-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/25 10:04 PM, Dan Williams wrote:
> The complexity of dropping the lock is removed in favor of splitting commit
> operations to a helper, and leaving all the complexities of "decommit" for
> commit_store() to coordinate the different locking contexts.
> 
> The CPU cache-invalidation in the decommit path is solely handled now by
> cxl_region_decode_reset(). Previously the CPU caches were being needlessly
> flushed twice in the decommit path where the first flush had no guarantee
> that the memory would not be immediately re-dirtied.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..3a77aec2c447 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> -			    const char *buf, size_t len)
> +static int queue_reset(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	bool commit;
> -	ssize_t rc;
> +	int rc;
>  
> -	rc = kstrtobool(buf, &commit);
> +	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	/* Already in the requested state? */
> +	if (p->state < CXL_CONFIG_COMMIT)
> +		goto out;
> +
> +	p->state = CXL_CONFIG_RESET_PENDING;
> +
> +out:
> +	up_write(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +static int __commit(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
>  	/* Already in the requested state? */
> -	if (commit && p->state >= CXL_CONFIG_COMMIT)
> -		goto out;
> -	if (!commit && p->state < CXL_CONFIG_COMMIT)
> +	if (p->state >= CXL_CONFIG_COMMIT)
>  		goto out;
>  
>  	/* Not ready to commit? */
> -	if (commit && p->state < CXL_CONFIG_ACTIVE) {
> +	if (p->state < CXL_CONFIG_ACTIVE) {
>  		rc = -ENXIO;
>  		goto out;
>  	}
> @@ -385,31 +397,60 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  	if (rc)
>  		goto out;
>  
> -	if (commit) {
> -		rc = cxl_region_decode_commit(cxlr);
> -		if (rc == 0)
> -			p->state = CXL_CONFIG_COMMIT;
> -	} else {
> -		p->state = CXL_CONFIG_RESET_PENDING;
> -		up_write(&cxl_region_rwsem);
> -		device_release_driver(&cxlr->dev);
> -		down_write(&cxl_region_rwsem);
> -
> -		/*
> -		 * The lock was dropped, so need to revalidate that the reset is
> -		 * still pending.
> -		 */
> -		if (p->state == CXL_CONFIG_RESET_PENDING) {
> -			cxl_region_decode_reset(cxlr, p->interleave_ways);
> -			p->state = CXL_CONFIG_ACTIVE;
> -		}
> -	}
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc == 0)
> +		p->state = CXL_CONFIG_COMMIT;
>  
>  out:
>  	up_write(&cxl_region_rwsem);
>  
> +	return rc;
> +}
> +
> +static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	bool commit;
> +	ssize_t rc;
> +
> +	rc = kstrtobool(buf, &commit);
>  	if (rc)
>  		return rc;
> +
> +	if (commit) {
> +		rc = __commit(cxlr);
> +		if (rc)
> +			return rc;
> +		return len;
> +	}
> +
> +	rc = queue_reset(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Unmap the region and depend the reset-pending state to ensure
> +	 * it does not go active again until post reset
> +	 */
> +	device_release_driver(&cxlr->dev);
> +
> +	/*
> +	 * With the reset pending take cxl_region_rwsem unconditionally
> +	 * to ensure the reset gets handled before returning.
> +	 */
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +
> +	/*
> +	 * Revalidate that the reset is still pending in case another
> +	 * thread already handled this reset.
> +	 */
> +	if (p->state == CXL_CONFIG_RESET_PENDING) {
> +		cxl_region_decode_reset(cxlr, p->interleave_ways);
> +		p->state = CXL_CONFIG_ACTIVE;
> +	}
> +
>  	return len;
>  }
>  

