Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7921423F;
	Wed, 19 Feb 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985197; cv=none; b=tPEdZzGm3GgD+wm77LgRQ+xFwq5j+sTy3fPAyTwa77arpuubNKuhqN/mlqnxCxsjELqvcWPRRDaddOeS4oxLakMNhTD6aXHlEa/yvFdO213Y9iyZzheLT0W6WdH+Y2SXY4phAmfXfI5A6ARFPVRDwHzbI5tZNQCdsZPZoEFhVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985197; c=relaxed/simple;
	bh=lsc0gz9YSDXMyvjHdL3ZogpVzSdRxSp7vMCEF4c7Z74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmJVZQiSiiJJmayeGGO8OJPQrORk3bvsV7k5cetjuFUGV9bJ1cTa4wOXCo2qO3tK2/kAqU5HM9Zq0jRXNIkp7qRxKN0CEGCDUHTSg+u81oeR7KpXBwSPUxsQD2oBip3yzA2WMz8s7P9l9KW8Q879sHLSYkUSYQEicgu4YpV7Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXAMIDB+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXAMIDB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739985196; x=1771521196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lsc0gz9YSDXMyvjHdL3ZogpVzSdRxSp7vMCEF4c7Z74=;
  b=DXAMIDB+Jm0vHfN+FfxmapzY7BpEOpLl/jgfha54iyd/QZlhaaJJNIi+
   7TKaqns9pzAaMMtNW6lffFQu2wrgOBP0TJW4wLytoOG19oO896ReUiOBB
   NTudoZc7vyJvG2/7mJsEIIib0unGILQfxB+xi181jWB7QMzfomhPuGD0S
   k4qmIPOnmuNO2BpAIcUZWrooRgB/sg1dJr7LzDgGPqn4c6FcZPfalPwXp
   BY2A+SamadqH12svWpMNBvJE1hiUfuSJf0qTIB5LlEUh1TMs/NgYiSC+f
   thNxPweK3KxFYDU0L8FCpkwYgXfwmhzSl/CrNOhS+STHHK+unqp9v/29H
   g==;
X-CSE-ConnectionGUID: F9ZB1YjvTtCx8u3LkSANiA==
X-CSE-MsgGUID: MAte8ovfSMWlGHoS57pIvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40448520"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40448520"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:13:15 -0800
X-CSE-ConnectionGUID: Rn081jpNS9eMndBMyw3fLw==
X-CSE-MsgGUID: FRpfmNCnRi64D9YPychMSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114711217"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:11:56 -0800
Message-ID: <dc97ea3c-b0f5-46c9-9e6e-ae24878c11b0@intel.com>
Date: Wed, 19 Feb 2025 10:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] cxl/core: Use guard() to replace open-coded
 down_read/write()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-2-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> Some down/up_read() and down/up_write() cases can be replaced by a
> guard() simply to drop explicit unlock invoked. It helps to align coding
> style with current CXL subsystem's.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Drop some local variables. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c    | 15 +++++----------
>  drivers/cxl/core/memdev.c |  9 +++------
>  drivers/cxl/core/port.c   |  8 ++------
>  drivers/cxl/core/region.c |  8 +++-----
>  4 files changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 50e6a45b30ba..4a578092377e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -213,13 +213,12 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  {
>  	struct resource *p1, *p2;
>  
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
>  		__cxl_dpa_debug(file, p1, 0);
>  		for (p2 = p1->child; p2; p2 = p2->sibling)
>  			__cxl_dpa_debug(file, p2, 1);
>  	}
> -	up_read(&cxl_dpa_rwsem);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>  
> @@ -250,9 +249,8 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  
>  static void cxl_dpa_release(void *cxled)
>  {
> -	down_write(&cxl_dpa_rwsem);
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	__cxl_dpa_release(cxled);
> -	up_write(&cxl_dpa_rwsem);
>  }
>  
>  /*
> @@ -362,14 +360,11 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
>  
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t size = 0;
> -
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  	if (cxled->dpa_res)
> -		size = resource_size(cxled->dpa_res);
> -	up_read(&cxl_dpa_rwsem);
> +		return resource_size(cxled->dpa_res);
>  
> -	return size;
> +	return 0;
>  }
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..98c05426aa4a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -564,10 +564,9 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds)
>  {
> -	down_write(&cxl_memdev_rwsem);
> +	guard(rwsem_write)(&cxl_memdev_rwsem);
>  	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
>  		  CXL_MEM_COMMAND_ID_MAX);
> -	up_write(&cxl_memdev_rwsem);
>  }
>  EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
>  
> @@ -579,10 +578,9 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds)
>  {
> -	down_write(&cxl_memdev_rwsem);
> +	guard(rwsem_write)(&cxl_memdev_rwsem);
>  	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
>  		      CXL_MEM_COMMAND_ID_MAX);
> -	up_write(&cxl_memdev_rwsem);
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, "CXL");
>  
> @@ -590,9 +588,8 @@ static void cxl_memdev_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
> -	down_write(&cxl_memdev_rwsem);
> +	guard(rwsem_write)(&cxl_memdev_rwsem);
>  	cxlmd->cxlds = NULL;
> -	up_write(&cxl_memdev_rwsem);
>  }
>  
>  static void cxl_memdev_unregister(void *_cxlmd)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..2c59d65bc18b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -549,13 +549,9 @@ static ssize_t decoders_committed_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
> -	int rc;
> -
> -	down_read(&cxl_region_rwsem);
> -	rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
> -	up_read(&cxl_region_rwsem);
>  
> -	return rc;
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
>  }
>  
>  static DEVICE_ATTR_RO(decoders_committed);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e8d11a988fd9..d8a71f9f9fa5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3208,7 +3208,6 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	const struct range *r = data;
> -	int rc = 0;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
> @@ -3216,12 +3215,11 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	cxlr = to_cxl_region(dev);
>  	p = &cxlr->params;
>  
> -	down_read(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
>  	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		rc = 1;
> -	up_read(&cxl_region_rwsem);
> +		return 1;
>  
> -	return rc;
> +	return 0;
>  }
>  
>  /* Establish an empty region covering the given HPA range */

