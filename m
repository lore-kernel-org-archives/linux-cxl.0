Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602D2BDC32
	for <linux-cxl@vger.kernel.org>; Tue, 21 Oct 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085815; cv=none; b=I9gcuqkKDYs+9gZZAdHGEbzzTCwNBw8rcRwglnXd+nFEMkWXSkp6byGBXgu4FRXefRBD8hr3St+jo8VPZEW0FJE0UO+VU1yo5M7LHEZdufIgpiCajmQK3I+eC3R5kZ1s7TyLNz6N91YvuY/ww9nRLf1P+SGi3HX+Aav2ZDzQv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085815; c=relaxed/simple;
	bh=pWRNtTFpZZaCi5Xldb5KkvQ+OnSSQ04gDHgWuZSfeSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W71ywUjTjYkGYg0HHPkBnoy2DU1yUSJ4OwgL4N54wMFyTfsIMe4I5OnYWZKd/ddgasaMc6jh7mt90l5v0MAS+OdfP2bKVCF/9+XvQVQp0iwZIMoG+914+vSMJ2fGRBKy0gU1BYLvOX/7piNzwkRwotU6QnYPFH9hpqjyFheWC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDlfTXXP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDlfTXXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761085813; x=1792621813;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pWRNtTFpZZaCi5Xldb5KkvQ+OnSSQ04gDHgWuZSfeSk=;
  b=jDlfTXXP/gEJeDYLYK3G9MdE7bmUOTjEv5bSa4gp6mU9CVWys3cpr621
   +aMmm2QXx91M+guoo2hZ21SFphpfsCq7gkAdzolxbyYDztX6hG0DFX7AT
   jaZjjaUwKZo1LcNHkT7T7fkFjdNaKPLrlt6M7GYV2QJkqUGzz0LWtnzNF
   ke1zZjj+0ihc1yALu3vV4OEF0+2sRnG6G8/HEq8E2rnBKe/AFKK6ZLJ3P
   qLxENGITUSfnWlCwq1W0zvs71vArkJFNwQMc2CXa5I+FD4eg1ZX0v1No7
   u5a25uRimN3E/U/H/DPzt4zT5mmrVxF7rq+MY687zCsXBn0TyiXW5u658
   g==;
X-CSE-ConnectionGUID: BImAu6VpQMCpj4iN4v6NEg==
X-CSE-MsgGUID: lwDpVUgMR8ms+lbdrDdnBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62432529"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="62432529"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 15:30:11 -0700
X-CSE-ConnectionGUID: U9HQbEb0QQ6zk4PEufYQog==
X-CSE-MsgGUID: Wi/jngEFRumGDviza/PZZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="188110325"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 15:30:10 -0700
Message-ID: <99d1884e-3586-468f-b232-6a40fd656887@intel.com>
Date: Tue, 21 Oct 2025 15:30:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Add support to indicate region has
 extended linear cache
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org
References: <20251017222536.4160645-1-dave.jiang@intel.com>
 <beb4a761-c7f8-44d2-80c0-99ef0a20e811@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <beb4a761-c7f8-44d2-80c0-99ef0a20e811@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 12:53 PM, Cheatham, Benjamin wrote:
> On 10/17/2025 5:25 PM, Dave Jiang wrote:
>> Add a region sysfs attribute to show the size of the extended linear
>> cache if there is any. The attribute is invisible when the cache
>> size is 0, which indicates it does not exist.
>>
>> Moved the cxl_region_visible() location in order to pick up the
>> new sysfs attribute definition.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Add documentation. (Alison)
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
>>  drivers/cxl/core/region.c               | 63 +++++++++++++++++++------
>>  2 files changed, 56 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 6b4e8c7a963d..8d529d68dfcd 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -498,6 +498,14 @@ Description:
>>  		there is no guarantee that a free followed by an allocate
>>  		results in the same address being allocated.
>>  
>> +What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
>> +Date:		October, 2025
>> +KernelVersion:	v6.19
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The size of extended linear cache if there is one present.
> 
> s/if there is one present/if present

ok

> 
>> +		The region 'size' attribute would reflect the total size where
>> +		the CXL region size plus the extended linear cache size.
> 
> Bit messy, maybe: "The region 'size' attribute is the CXL region size plus the extended linear cache size."

ok

> 
> You should probably add a blurb to the size attribute's description about the extended linear cache size.
> Changing the meaning of the size attribute outside its own description seems wrong.
> 
> At that point you could probably drop the second sentence altogether (I'll leave that one up to you though).

I'll add something to 'size' and drop the additional stuff here.

> 
>>  
>>  What:		/sys/bus/cxl/devices/regionZ/mode
>>  Date:		January, 2023
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b06fee1978ba..531f790b9510 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -461,21 +461,6 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RW(commit);
>>  
>> -static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>> -				  int n)
>> -{
>> -	struct device *dev = kobj_to_dev(kobj);
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>> -
>> -	/*
>> -	 * Support tooling that expects to find a 'uuid' attribute for all
>> -	 * regions regardless of mode.
>> -	 */
>> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
>> -		return 0444;
>> -	return a->mode;
>> -}
>> -
>>  static ssize_t interleave_ways_show(struct device *dev,
>>  				    struct device_attribute *attr, char *buf)
>>  {
>> @@ -754,6 +739,21 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RW(size);
>>  
>> +static ssize_t extended_linear_cache_size_show(struct device *dev,
>> +					       struct device_attribute *attr,
>> +					       char *buf)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	ssize_t rc;
>> +
>> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>> +		return rc;
>> +	return sysfs_emit(buf, "%#llx\n", p->cache_size);
>> +}
>> +static DEVICE_ATTR_RO(extended_linear_cache_size);
>> +
>>  static struct attribute *cxl_region_attrs[] = {
>>  	&dev_attr_uuid.attr,
>>  	&dev_attr_commit.attr,
>> @@ -762,14 +762,44 @@ static struct attribute *cxl_region_attrs[] = {
>>  	&dev_attr_resource.attr,
>>  	&dev_attr_size.attr,
>>  	&dev_attr_mode.attr,
>> +	&dev_attr_extended_linear_cache_size.attr,
>>  	NULL,
>>  };
>>  
>> +static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>> +				  int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +
>> +	/*
>> +	 * Support tooling that expects to find a 'uuid' attribute for all
>> +	 * regions regardless of mode.
>> +	 */
>> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
>> +		return 0444;
>> +
>> +	/*
>> +	 * Don't dispaly extended linear cache attribute if there is no
>> +	 * extended linear cache.
>> +	 */
>> +	if (a == &dev_attr_extended_linear_cache_size.attr &&
>> +	    cxlr->params.cache_size == 0)
>> +		return 0;
>> +
>> +	return a->mode;
>> +}
>> +
>>  static const struct attribute_group cxl_region_group = {
>>  	.attrs = cxl_region_attrs,
>>  	.is_visible = cxl_region_visible,
>>  };
>>  
>> +static const struct attribute_group *get_cxl_region_group(void)
>> +{
>> +	return &cxl_region_group;
>> +}
>> +
> 
> Why introduce this function instead of using &cxl_region_group directly? I see there's
> a precedent with the target group functions, but only get_cxl_region_target_group() needs
> the function. The other two (get_cxl_region_accessX_group()) are only ever called after
> the attribute definition and should probably get cleaned up at some point.

Yeah I can drop that.

> 
>>  static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>  {
>>  	struct cxl_region_params *p = &cxlr->params;
>> @@ -3478,6 +3508,9 @@ static int __construct_region(struct cxl_region *cxlr,
>>  		dev_warn(cxlmd->dev.parent,
>>  			 "Extended linear cache calculation failed rc:%d\n", rc);
>>  	}
>> +	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_group());
> 
> Missing whitespace above this line?

yes.

Thanks for the review Ben.

DJ

> 
> Thanks,
> Ben
> 
>> +	if (rc)
>> +		return rc;
>>  
>>  	rc = insert_resource(cxlrd->res, res);
>>  	if (rc) {
>>
>> base-commit: a4bbb493a3247ef32f6191fd8b2a0657139f8e08
> 


