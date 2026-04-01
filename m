Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C73F0A95;
	Wed,  1 Apr 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064048; cv=none; b=LavOmPKO80jV6IZaakM1/2SbdgN/PWWvxwLgmR/eZHYzXfbHK9jlr0KsRuEvYrpG4LBJkW2/Uw3bHF7EesPbptdOhq+nZYDJl8W/A8wpwtom+vrj2cfhUJTwsN2F5asQ+fSBKXFgC7SCzkChK1+zIwJEkorqIMms/zieQ3MO6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064048; c=relaxed/simple;
	bh=UwgN1XAH5ZT0uhXUPLs4fnBQUIDhlEcFmFHiwn3tluA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjKDPM7vCKieDEUPMImOprOZvpV0y81Fk5SoDqKSzJ/aWZEwjZR/vrDPQEFEHjfjFdGuwrkq9sZtkYhaIk+qe7N5OH/5ASXoenGYD9v/zTx3wBj4bT8vdBnN5Cuha2yz+LbKCcXsblQhmIEx0i3XQ3LwjgI8c5fblWzQmrHZa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWmSukAo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWmSukAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775064047; x=1806600047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UwgN1XAH5ZT0uhXUPLs4fnBQUIDhlEcFmFHiwn3tluA=;
  b=JWmSukAohGk4OWK8FDg0kqqk6E6XPd1UgxOwZ7HZaQVQS+nzaPMiYTco
   AVQ/Ujn7PT0YymWpJvVdebtn0myJZGFRwvJh7M24wssrxtHgfOi79xc7R
   jcADSfKvJ2SlOGtSvtm33OsEfOaTGMtmPtc0EtUgvWTdFbyj51NjYirgD
   W2N0b/G6/oLbzd6r/t5YtJiw4Llk7O8tYNxfXRcQue4ip2QOcoGSyznEM
   RgkST7Do5tNXyCtJ3cs+PhcJdkCb8Z2pDG3eE6FTuw2x0uHGmRPFwMKbh
   6Q6eTq3mABVHM3ShC3+3kCgav3o+aY6jAjNjJ4T2z/VShOYu0eC9fRBgl
   A==;
X-CSE-ConnectionGUID: DeQla1RfRUK6MyMzep9yOA==
X-CSE-MsgGUID: q7w1yx+dRhuThtfbXKEBag==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78707126"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78707126"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:20:46 -0700
X-CSE-ConnectionGUID: 2vs+ADngRWughIu5qiGEcA==
X-CSE-MsgGUID: irXV1wzzTsixA4sXteAbog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225883585"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.111.126]) ([10.125.111.126])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:20:46 -0700
Message-ID: <1bcd3fbb-1908-4275-83cb-2661cd048ad4@intel.com>
Date: Wed, 1 Apr 2026 10:20:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/region: Add a region sysfs interface for
 region lock status
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alejandro Lucero <alucerop@amd.com>
References: <20260401124951.1290041-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260401124951.1290041-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/26 5:49 AM, Li Ming wrote:
> If a region is created on a root decoder with Fixed Device Confiuration
> attribute, the region will be locked, meaning region destroy
> operations are not permitted. CXL region driver returns -EPERM for
> region destroy operations.
> 
> Although the locked status of the corresponding root decoder implies the
> region is also locked, exposing the region lock status directly to
> userspace improves usability for users who may not be aware of this
> relationship.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Applied to cxl/next with commit log ammended per Alison.
d585bc86fb9f

> ---
> v2:
> * Add more info to the interface description. (Alison)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++++
>  drivers/cxl/core/region.c               | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..16a9b3d2e2c0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -508,6 +508,19 @@ Description:
>  		(RO) The size of extended linear cache, if there is an extended
>  		linear cache. Otherwise the attribute will not be visible.
>  
> +
> +What:		/sys/bus/cxl/devices/regionZ/locked
> +Date:		Mar, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The CXL driver has the capability to lock a region based on
> +		a BIOS or platform dependent configuration. Regions created as
> +		locked are never permitted to be destroyed. Resets to participating
> +		decoders will not result in a region destroy and will not free the
> +		decoder resources.
> +
> +
>  What:		/sys/bus/cxl/devices/regionZ/mode
>  Date:		January, 2023
>  KernelVersion:	v6.3
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 42874948b589..95d81816008e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -767,6 +767,22 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(extended_linear_cache_size);
>  
> +static ssize_t locked_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +
> +	rc = test_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +static DEVICE_ATTR_RO(locked);
> +
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -776,6 +792,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_locked.attr,
>  	NULL,
>  };
>  

