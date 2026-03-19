Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719630C356;
	Thu, 19 Mar 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931655; cv=none; b=JWp7ipfxflLt91NwN6DCcbQf6JEvAOXGZjLXGzOlTRr97y0GLlw05fyy2B45E1Y54rvmMYBLv5oRg+bh9dPm6WpM9HcXoYLcx01eR8gji7BOkFcI1z/G1ppcWNofZxi8BkaiQhhJbm5Wdiu6oazW/Z84swywol768/mtkxTg5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931655; c=relaxed/simple;
	bh=dJXaUboAOHhqDiW2HWdbSDzOrdm42TNBFLOocv5hCvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBMQKLFAldZro54bYY7vuBZSaP1e7hfg120xG0kaw2MQzXEQrPsK8UCAW0A50ReBvNhgJDqCS8U6y79LGZy3cJIZff1XVmd2ouQ7zubOcXopfg80GDNesUtk5fimFIXjs/REvZ2iiSNyU92gktYOfBEBNGn9cunTomx8x/UqbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHZA+gfH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHZA+gfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773931653; x=1805467653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dJXaUboAOHhqDiW2HWdbSDzOrdm42TNBFLOocv5hCvQ=;
  b=CHZA+gfHvS/8XDBtPis0Rx0gYe3TzUBS4qyo7xcVx8sWwIgFurkOAbRq
   h2Iw9WBhqGw8xNTE7JSRXr49RNHWIP9b27gWN1Zr3IjM/l1LafC4+XcBe
   0s/ztURf98Yj/9fh+V5JqDxUiyBHkahk0P0xVx5Cg0aQKBN9CdjEv7BvF
   XjsCgMYsEBaSpPxyFjxskrxUJn5Y0TKoJejnzZ07rDYi0llGwJJB7o2QA
   VCXz0M+Hf/9cGbeO1QkRkYBzk5kUHUGDp78wXosx76nWpyhltInzLMDLl
   mxdsF1KeCWK4H2s5jGnySe3xkxctZx+OhHHQlra4ZyI9GXu+WD4hsnPrU
   w==;
X-CSE-ConnectionGUID: UFuxx66RT1igg4N8xkrSKA==
X-CSE-MsgGUID: vj/uRinWSHuwlgq+638y3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100465424"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="100465424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 07:47:32 -0700
X-CSE-ConnectionGUID: CfSoO/hhRfGz2XW7t+iwNA==
X-CSE-MsgGUID: kUoGBlhnRpKN+EIpWFvsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="222085354"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.49]) ([10.125.109.49])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 07:47:32 -0700
Message-ID: <f31a9a08-27dd-4cf1-bf35-d1b992e2f75e@intel.com>
Date: Thu, 19 Mar 2026 07:47:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Hold memdev lock during region poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/26 7:12 AM, Li Ming wrote:
> cxl_dpa_to_region() has expectations that cxlmd->endpoint remains valid
> for the duration of the call. When userspace performs poison injection
> or clearing on a region via debugfs, holding cxl_rwsem.region and
> cxl_rwsem.dpa alone is insufficient, these locks do not prevent the
> retrieved CXL memdev from being destroyed, nor do they protect against
> concurrent driver detachment. Therefore, hold CXL memdev lock in the
> debugfs callbacks to ensure the cxlmd->dev.driver remains stable for the
> entire execution of the callback functions.
> 
> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
> for avoiding deadlock. the interfaces have to find out the correct CXL
> memdev at first, holding lock in the sequence then checking if the DPA
> data has been changed before holding locks.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

This is the patch I dropped right? I see the review tags are dropped. Does it need to be re-reviewed? Are there new changes?

DJ

> ---
>  drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 88 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f24b7e754727..1a509acc52a3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4101,12 +4101,70 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  	return 0;
>  }
>  
> +static int __cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
> +				      struct dpa_result *res)
> +{
> +	int rc;
> +
> +	*res = (struct dpa_result){ .dpa = ULLONG_MAX, .cxlmd = NULL };
> +
> +	if (validate_region_offset(cxlr, offset))
> +		return -EINVAL;
> +
> +	offset -= cxlr->params.cache_size;
> +	rc = region_offset_to_dpa_result(cxlr, offset, res);
> +	if (rc || !res->cxlmd || res->dpa == ULLONG_MAX) {
> +		dev_dbg(&cxlr->dev,
> +			"Failed to resolve DPA for region offset %#llx rc %d\n",
> +			offset, rc);
> +
> +		return rc ? rc : -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
> +				    struct dpa_result *res)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	rc = __cxl_region_poison_lookup(cxlr, offset, res);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Hold the device reference in case
> +	 * the device is destroyed after that.
> +	 */
> +	get_device(&res->cxlmd->dev);
> +	return 0;
> +}
> +
>  static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  {
> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>  	struct cxl_region *cxlr = data;
> +	struct dpa_result res1, res2;
>  	int rc;
>  
> +	/* To retrieve the correct memdev */
> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
> +	if (rc)
> +		return rc;
> +
> +	struct device *dev __free(put_device) = &res1.cxlmd->dev;
> +	ACQUIRE(device_intr, devlock)(dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -4115,20 +4173,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
>  
> -	if (validate_region_offset(cxlr, offset))
> -		return -EINVAL;
> -
> -	offset -= cxlr->params.cache_size;
> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +	/*
> +	 * Retrieve memdev and DPA data again in case that the data
> +	 * has been changed before holding locks.
> +	 */
> +	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
>  		dev_dbg(&cxlr->dev,
> -			"Failed to resolve DPA for region offset %#llx rc %d\n",
> -			offset, rc);
> -
> -		return rc ? rc : -EINVAL;
> +			"Error injection raced region reconfiguration: %d", rc);
> +		return -ENXIO;
>  	}
>  
> -	return cxl_inject_poison_locked(result.cxlmd, result.dpa);
> +	return cxl_inject_poison_locked(res2.cxlmd, res2.dpa);
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
> @@ -4136,10 +4192,20 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
>  
>  static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  {
> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>  	struct cxl_region *cxlr = data;
> +	struct dpa_result res1, res2;
>  	int rc;
>  
> +	/* To retrieve the correct memdev */
> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
> +	if (rc)
> +		return rc;
> +
> +	struct device *dev __free(put_device) = &res1.cxlmd->dev;
> +	ACQUIRE(device_intr, devlock)(dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -4148,20 +4214,18 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
>  
> -	if (validate_region_offset(cxlr, offset))
> -		return -EINVAL;
> -
> -	offset -= cxlr->params.cache_size;
> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +	/*
> +	 * Retrieve memdev and DPA data again in case that the data
> +	 * has been changed before holding locks.
> +	 */
> +	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
>  		dev_dbg(&cxlr->dev,
> -			"Failed to resolve DPA for region offset %#llx rc %d\n",
> -			offset, rc);
> -
> -		return rc ? rc : -EINVAL;
> +			"Error clearing raced region reconfiguration: %d", rc);
> +		return -ENXIO;
>  	}
>  
> -	return cxl_clear_poison_locked(result.cxlmd, result.dpa);
> +	return cxl_clear_poison_locked(res2.cxlmd, res2.dpa);
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> 
> ---
> base-commit: d5f9bfc37906bbb737790af11f1537593f8778a5
> change-id: 20260319-hold_memdev_lock_for_region_poison_inject-clear-4b8020d84662
> 
> Best regards,

