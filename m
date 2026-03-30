Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889E3A759C;
	Mon, 30 Mar 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907856; cv=none; b=Hm7FY+Z3ifeDqTtiig1z5aXwZ6Ye9Hj0KtpMCg5cwu3zmlQqSU0/QMocS60cHkXGJIAJIV7+44C6k+cl8u90NV5UH5mT3HQ6O3PC8S9U/XVaDH1qxvJFoFpekv/F2MsrIYDRs3zTWpZzXuUU3xBTFYrG8Ro2mU8lfbOHghGcS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907856; c=relaxed/simple;
	bh=muYD7jFJI97iEOkcsFKVgSPuum0T8vTQ2ItgQJ70GLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmUX6fFAVl/l3aWzF4dUt+sGET7btih3sFRmAvRq/E+EM35ooM+c3+6XW59FHYT+AbDJGYVCVKSzTltYgcylAWG97ZvfOUH53sjd2gdpYspw6DIXULqlMdy1CBzGlxeOGGQXrPC3lQ/qQpI6vZ1xzgI24x2YvOgTdniIw/qgPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JREjZght; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JREjZght"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774907854; x=1806443854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=muYD7jFJI97iEOkcsFKVgSPuum0T8vTQ2ItgQJ70GLc=;
  b=JREjZght1BH1iL6lvzFL0JgcBNJZKu8H+utwclOpjq+1BXQy6/rOUiw+
   37/UOo+PmHH+6Pr/I2+PQNxxgRYo6Mvh33+QBeugVm15e+4GvsgvcQDH7
   VAEE1acVb2VOUqUIUy/Am1ARFI7JfyuazOy8UAQdBM7Ly6gaA9eNYzv1x
   DqxkSYa2+Q6X25d8pJtGrm/zhEaiuDi1CfmZzHnmZaW/FAR6lXfh2RcVS
   W6SbVNxcVkyNrzPM7Co0dALlxfpG+fyGY1lotlwTZzU/ZyIcjLOA0uvVd
   ODwVIpZEv7RsVsbSAWQI7JxfoOlbVflQmAgK6IVdsyTga1uevqfxiqYio
   g==;
X-CSE-ConnectionGUID: heUVXrv/Sgm/WvJjFGxQaA==
X-CSE-MsgGUID: 9YTkf+1MSj+X2XRQ1MhwRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76021543"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="76021543"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:57:33 -0700
X-CSE-ConnectionGUID: ZtWKgCkOT4CNy/bGeUxbtQ==
X-CSE-MsgGUID: gwbnVHiuTAOOAM2k9x0PCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225342361"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.4]) ([10.125.111.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:57:32 -0700
Message-ID: <ae49db35-811a-45d4-9c61-05cddce81372@intel.com>
Date: Mon, 30 Mar 2026 14:57:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Add a region sysfs interface for region lock
 status
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/29/26 7:44 AM, Li Ming wrote:
> If a region is created on a root decoder with Fixed Device Confiuration
> attribute, the region will be locked , meaning region destroy
> operations are not permitted. CXL region driver returns -EPERM for
> region destroy operations.
> 
> Although the locked status of the corresponding root decoder implies the
> region is also locked, exposing the region lock status directly to
> userspace improves usability for users who may not be aware of this
> relationship.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++++
>  drivers/cxl/core/region.c               | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..50bf7334465b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -508,6 +508,16 @@ Description:
>  		(RO) The size of extended linear cache, if there is an extended
>  		linear cache. Otherwise the attribute will not be visible.
>  
> +
> +What:		/sys/bus/cxl/devices/regionZ/locked
> +Date:		Mar, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The lock status of the region, region destroy operations
> +		are not permitted if the region is locked.
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
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260329-expose_region_locked_status-b05c4b8f97d6
> 
> Best regards,

