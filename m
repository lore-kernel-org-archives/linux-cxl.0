Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFA19DFA2
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213749; cv=none; b=omRErHzClZKLZCIui9lOkLSKM35M0eLQuN+T0OwC/V0e2GJ7gP4c5ybS1OfJG71moZbe85UY9LOpojan88v4S2qtHcSgpCuR+e3Pb/SJaWf1tDRA35WbDZpX3iDO68jprd9+tN0g8TSq15vGjD8FUHjeUO9eYy65WULxgHU4ykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213749; c=relaxed/simple;
	bh=+FGnWnKGDLF6mcthYNMij/NxEllT9PJkkUtQyMfSvgw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gMbDApCviC9DFVaGyT5y9sh7dgvSkiTz5733DxrsZMH+bJUvlCJYOtOCObHL/eKb+7ODRQUK4CfIigztmDXYlMHL1w6jtPYN24XomWF7jTOX5cWGULxXh3ioz01EEzyZPIabBy2+hzj9G1++aBMzqDPUslbVWHX43AR3wsjKzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQ65E1yw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQ65E1yw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213748; x=1793749748;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+FGnWnKGDLF6mcthYNMij/NxEllT9PJkkUtQyMfSvgw=;
  b=lQ65E1ywxULSj/9oPC/BMdYD2VRnJE1dMTFlvIaIGpWjMVPXmBgwE7jc
   fsgdLg/eire76PXsJQ+zwT5Jcn/RtB0kxZ9V2yeHPxX6X07l3WGne9lvM
   rnyAANEd/77Vvguv4v3jwC3NuTUCf8PWL2SBoFaKuf3MLVVjOGlEdQZJ+
   3OQdcAkPGnpP5KZWMzl6s7qIehyAgVt9bAH9s/RZx5A8pCr4HQrpQIow3
   T70r/ifNkQ8g8cINojT3WPLKsjc0g1bL9I2ztWptw+pYYnA7umEJfL7r9
   LQAhOeNnBPY+Q+s6mdy16Z7IbmmueUzZPBUODBMVGxhxyHK3s+m/l47fn
   w==;
X-CSE-ConnectionGUID: DH5p/SJ2TvyBPUA/VgrsoQ==
X-CSE-MsgGUID: Hre2EW7iQMmveOJ5GlRiPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64185934"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64185934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:49:07 -0800
X-CSE-ConnectionGUID: vdbUvolcTfOXbbx01Vm6kg==
X-CSE-MsgGUID: 4rSbqn2aQY6ID29DHv6P4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186679241"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:49:07 -0800
Message-ID: <81524538-27ce-4070-b096-8a8ff70f6d24@intel.com>
Date: Mon, 3 Nov 2025 16:49:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/region: Add support to indicate region has
 extended linear cache
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251022203052.4078527-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251022203052.4078527-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/25 1:30 PM, Dave Jiang wrote:
> Add a region sysfs attribute to show the size of the extended linear
> cache if there is any. The attribute is invisible when the cache
> size is 0, which indicates it does not exist.
> 
> Moved the cxl_region_visible() location in order to pick up the
> new sysfs attribute definition.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

applied to cxl/next
d6602e25819dea2c239972e98e09ba5db4aebd22

> ---
> v3:
> - refine documentation (Benjamin)
> - Drop helper function to get region group. (Benjamin)
> - Add blank line for better readability. (Benjamin)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 11 ++++-
>  drivers/cxl/core/region.c               | 59 ++++++++++++++++++-------
>  2 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6b4e8c7a963d..c6abce129137 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -496,8 +496,17 @@ Description:
>  		changed, only freed by writing 0. The kernel makes no guarantees
>  		that data is maintained over an address space freeing event, and
>  		there is no guarantee that a free followed by an allocate
> -		results in the same address being allocated.
> +		results in the same address being allocated. If extended linear
> +		cache is present, the size indicates extended linear cach size
> +		plus the CXL region size.
>  
> +What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
> +Date:		October, 2025
> +KernelVersion:	v6.19
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The size of extended linear cache, if there is an extended
> +		linear cache. Otherwise the attribute will not be visible.
>  
>  What:		/sys/bus/cxl/devices/regionZ/mode
>  Date:		January, 2023
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..095f5dcd17a1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -461,21 +461,6 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(commit);
>  
> -static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
> -				  int n)
> -{
> -	struct device *dev = kobj_to_dev(kobj);
> -	struct cxl_region *cxlr = to_cxl_region(dev);
> -
> -	/*
> -	 * Support tooling that expects to find a 'uuid' attribute for all
> -	 * regions regardless of mode.
> -	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
> -		return 0444;
> -	return a->mode;
> -}
> -
>  static ssize_t interleave_ways_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> @@ -754,6 +739,21 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(size);
>  
> +static ssize_t extended_linear_cache_size_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	ssize_t rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +	return sysfs_emit(buf, "%#llx\n", p->cache_size);
> +}
> +static DEVICE_ATTR_RO(extended_linear_cache_size);
> +
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -762,9 +762,34 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_resource.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_extended_linear_cache_size.attr,
>  	NULL,
>  };
>  
> +static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
> +				  int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	/*
> +	 * Support tooling that expects to find a 'uuid' attribute for all
> +	 * regions regardless of mode.
> +	 */
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
> +		return 0444;
> +
> +	/*
> +	 * Don't dispaly extended linear cache attribute if there is no
> +	 * extended linear cache.
> +	 */
> +	if (a == &dev_attr_extended_linear_cache_size.attr &&
> +	    cxlr->params.cache_size == 0)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
>  static const struct attribute_group cxl_region_group = {
>  	.attrs = cxl_region_attrs,
>  	.is_visible = cxl_region_visible,
> @@ -3479,6 +3504,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  			 "Extended linear cache calculation failed rc:%d\n", rc);
>  	}
>  
> +	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
> +	if (rc)
> +		return rc;
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

