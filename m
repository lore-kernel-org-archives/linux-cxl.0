Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35F20F08C;
	Tue, 13 Jan 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339023; cv=none; b=Nr/bMDXVkFoNK28FydLJFOFBAeu7NdIO4w633EASueKBlkVvNWaXQYJQ48iruPKeawUVNPqaGYIQqZFSBKmLF2tfr986+sIgVFQ/vxSIeiwXSQlCKSmTqAtaT826M+1Ye+j8Jl4/8ok0Q71tV0I3BHvftB4T3qbcBUl/9YU8xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339023; c=relaxed/simple;
	bh=flcsyrUVVOSy7k/aNesdlItNkFbKvqmN1T2fDn9iZjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLDpJ5mrkqExqGW/AAYa6BDLMguMaIYRRGVJhh/O433OEhF0u6HVugx8gXI+LusueH9nlDgMJZUseX8Ih+Ho8VbSuRZdiUoK2eIeN3oPUQ8X355fnkx27V4XCGoBcJaHKxj5b0Uh2Rw1O1V1TVLiO7D32Sdt4Y8Z8gz7GNBqEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUFAxVf9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUFAxVf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768339021; x=1799875021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=flcsyrUVVOSy7k/aNesdlItNkFbKvqmN1T2fDn9iZjI=;
  b=YUFAxVf902HtyoREyJbJu4pkyrsojkwwoRL0CvdqxpYJ+RBTL3awd90K
   wnDWqfu+IMXdV5uiHuowQMdZisOXz3V9VYAhncrKEruJluG8MvcKGSq4r
   3udVKVTc2qZxn+bSYGiM7hlVMb6lJjjKahuUreSzVxaNrQrF3tymfCl8x
   K6l/YsfRoALYx9fOMLZJHL2SsMWFBu5TtfTVxwun+YZpBuIQMHMHbU2oq
   6OV+HAmdcQnIvt7eOOsBJ+xrKMMak22MHmEKDn2JDuTQ5Cu+e/dC11Fni
   jQg/M0vyMEfsIQQrZ2R+sjscC9QDOK08yqrIQN3I7rEBg5PT4R+LkSDY8
   Q==;
X-CSE-ConnectionGUID: R7T8AfAvRM2JDbaihJ1BPg==
X-CSE-MsgGUID: ZDuc81o7Tda72NTQG9bouw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69796228"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69796228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:17:01 -0800
X-CSE-ConnectionGUID: SozGsFdJREaPyX/veXETtg==
X-CSE-MsgGUID: 0pvmqxjhTW+xhEnzkfZtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208654726"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:17:00 -0800
Message-ID: <21bdac12-135a-4420-a1df-98b41269d74f@intel.com>
Date: Tue, 13 Jan 2026 14:16:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field for
 cxl_region
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260113202138.3021093-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/26 1:21 PM, Gregory Price wrote:
> The CXL driver presently has 3 modes of managing a cxl_region:
>   - no specific driver (bios-onlined SystemRAM)
>   - dax_region (all other RAM regions, for now)
>   - pmem_region (all PMEM regions)
> 
> Formalize these into specific "region drivers".
> 
> enum cxl_region_driver {
> 	CXL_REGION_DRIVER_NONE,
> 	CXL_REGION_DRIVER_DAX,
> 	CXL_REGION_DRIVER_PMEM
> };
> 
> $cat regionN/region_driver
> [none,dax,pmem]
> 
> The intent is to clarify how to to add additional drivers (sysram,
> dynamic_capacity, etc) in the future, and to allow switching the
> driver selection via a sysfs entry `regionN/region_driver`.
> 
> All RAM regions will be defaulted to CXL_CONTROL_DAX.
> 
> Auto-regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.  This will be discovered at probe time.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 113 ++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |   8 +++
>  2 files changed, 98 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..f8262d2169ea 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -626,6 +626,57 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static ssize_t region_driver_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		desc = "none";
> +		break;
> +	case CXL_REGION_DRIVER_DAX:
> +		desc = "dax";
> +		break;
> +	case CXL_REGION_DRIVER_PMEM:
> +		desc = "pmem";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", desc);
> +}
> +
> +static ssize_t region_driver_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	if (p->state >= CXL_CONFIG_COMMIT)
> +		return -EBUSY;
> +
> +	/* PMEM drivers cannot be changed */
> +	if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		return -EBUSY;
> +
> +	/* NONE type is not a valid selection for manually probed regions */
> +	if (sysfs_streq(buf, "dax"))
> +		cxlr->driver = CXL_REGION_DRIVER_DAX;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(region_driver);
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -772,6 +823,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_region_driver.attr,
>  	NULL,
>  };
>  
> @@ -2599,6 +2651,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	cxlr->mode = mode;
>  	cxlr->type = type;
>  
> +	/*
> +	 * PMEM regions only have 1 driver: pmem_region
> +	 * RAM regions default to DAX, but if the memory is already onlined by
> +	 * BIOS as 'System-RAM', the DAX driver will be dropped during probe.
> +	 */
> +	if (mode == CXL_PARTMODE_PMEM)
> +		cxlr->driver = CXL_REGION_DRIVER_PMEM;
> +	else
> +		cxlr->driver = CXL_REGION_DRIVER_DAX;
> +
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
>  	if (rc)
> @@ -3951,33 +4013,38 @@ static int cxl_region_probe(struct device *dev)
>  			return rc;
>  	}
>  
> -	switch (cxlr->mode) {
> -	case CXL_PARTMODE_PMEM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> +	if (cxlr->mode > CXL_PARTMODE_PMEM) {
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> +			cxlr->mode);
> +		return -ENXIO;
> +	}
>  
> -		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_PARTMODE_RAM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> +	/*
> +	 * The region can not be managed by CXL if any portion of
> +	 * it is already online as 'System RAM'.
> +	 */
> +	if (walk_iomem_res_desc(IORES_DESC_NONE,
> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0) {
> +		cxlr->driver = CXL_REGION_DRIVER_NONE;
> +		return 0;
> +	}
>  
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> -			return 0;
> +	rc = devm_cxl_region_edac_register(cxlr);
> +	dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d %s\n",
> +			cxlr->id, rc ? "failed" : "succeeded");
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		return 0;
> +	case CXL_REGION_DRIVER_DAX:
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_REGION_DRIVER_PMEM:
> +		return devm_cxl_add_pmem_region(cxlr);
>  	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region driver: %d\n",
> +			cxlr->driver);
>  		return -ENXIO;
>  	}
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..e8256099de29 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,13 @@ enum cxl_partition_mode {
>  	CXL_PARTMODE_PMEM,
>  };
>  
> +
> +enum cxl_region_driver {
> +	CXL_REGION_DRIVER_NONE,
> +	CXL_REGION_DRIVER_DAX,
> +	CXL_REGION_DRIVER_PMEM,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -543,6 +550,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	enum cxl_partition_mode mode;
> +	enum cxl_region_driver driver;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;

