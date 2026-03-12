Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049653FF1;
	Thu, 12 Mar 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773356137; cv=none; b=Z3RYQV6+I3WfaOF4xsT7P5drZIML2Cr1huiNvtxITuMPLxG9goWNqfmqoxeY4la3N4WkPovDm+roHzmZSwlPcwjJScV9sVB0OiEnklv5YTUXCMXDLPBZjxaH/crM/bKQQ24B3chHyP/hkqGlYU/frVFY9TcrUIgafmyqTPrSNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773356137; c=relaxed/simple;
	bh=xFQpRYhU7gb4gCQsGWiB/6KgXlgA1UVU7m0SGVzlISM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYbAP4Xonr5ezB+Nm/bIBekPR85gmWLw4XAfFXrD/hppvLANss7t36Pz8P2i7gErBpA0vUb+FsqRtqvdgCu+ZsJDY5KvRbiQVA1wsNP3czSBYcxmJnLVlLMBnsUbXpB0XS7Pmy6DAMCDIQWpph1sBQLDa6XobQBSmlv6ocwYkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy0L6NgL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy0L6NgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773356135; x=1804892135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xFQpRYhU7gb4gCQsGWiB/6KgXlgA1UVU7m0SGVzlISM=;
  b=Dy0L6NgLW6CohdLhmteHInCbyZb5W4WrpZb7LMnUMju0OUlk2Y2uqo7G
   qAYCDcfdqryoShIV+CnC5z476T2SoDtO/WK48Wygmy2rimVBiBGQ1ADI0
   MPAOnFAMqfDR5cM9hhKjg665EJTMotTGjr0sgfx4xgpM7S2pi4zD6Iu6n
   To/X+JMNZlx5jJFIHyA2zWCwQtu+o3sUElhIZpeWMDY+SWuFhyTNks0Ye
   LYSReQaN5HKpjgwI18QTYTIc/kwm4NE6VElC53bXwAqtx68AOIhNkF+GN
   OznsvR6XBBmSBV//O7ukAJAjSt9iFsS+Z//kfQ9dtGlp0FpIFk91tH++n
   g==;
X-CSE-ConnectionGUID: hJIg16ZtROq78ZlBoqz4pA==
X-CSE-MsgGUID: MQwkHrulRNyFgNDDrzhjJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85546911"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="85546911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:55:35 -0700
X-CSE-ConnectionGUID: H5753Q9mSFe3JJJGTnXJOg==
X-CSE-MsgGUID: WGm0fgUNSh2EqKtlxPwNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="225939927"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:55:33 -0700
Message-ID: <e2eaa470-c57b-4fa5-9810-4224ed314445@intel.com>
Date: Thu, 12 Mar 2026 15:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] vfio/cxl: CXL region management
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-11-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-11-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Add CXL region management for future guest access.
> 
> Region Management makes use of APIs provided by CXL_CORE as below:
> 
> CREATE_REGION flow:
> 1. Validate request (size, decoder availability)
> 2. Allocate HPA via cxl_get_hpa_freespace()
> 3. Allocate DPA via cxl_request_dpa()
> 4. Create region via cxl_create_region() - commits HDM decoder!
> 5. Get HPA range via cxl_get_region_range()
> 
> DESTROY_REGION flow:
> 1. Detach decoder via cxl_decoder_detach()
> 2. Free DPA via cxl_dpa_free()
> 3. Release root decoder via cxl_put_root_decoder()
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 118 ++++++++++++++++++++++++++-
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   5 ++
>  drivers/vfio/pci/vfio_pci_priv.h     |   8 ++
>  3 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 2da6da1c0605..9c71f592e74e 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -126,6 +126,112 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
>  	return 0;
>  }
>  
> +int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev, resource_size_t size)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	resource_size_t max_size;
> +	int ret;
> +
> +	if (cxl->precommitted)
> +		return 0;
> +
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM |
> +					   CXL_DECODER_F_TYPE2,
> +					   &max_size);

Not sure what VFIO subsystem's policy is on scoped base resource cleanup, but a __free() here can get you out of managing put() of the root decoder.

> +	if (IS_ERR(cxl->cxlrd))
> +		return PTR_ERR(cxl->cxlrd);
> +
> +	/* Insufficient HPA space */
> +	if (max_size < size) {
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		cxl->cxlrd = NULL;
> +		return -ENOSPC;
> +	}
> +
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM, size);

Same comment here about __free().

> +	if (IS_ERR(cxl->cxled)) {
> +		ret = PTR_ERR(cxl->cxled);
> +		goto err_free_hpa;
> +	}
> +
> +	cxl->region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
> +	if (IS_ERR(cxl->region)) {
> +		ret = PTR_ERR(cxl->region);
> +		goto err_free_dpa;
> +	}
> +
> +	return 0;
> +
> +err_free_dpa:
> +	cxl_dpa_free(cxl->cxled);
> +err_free_hpa:
> +	if (cxl->cxlrd)
> +		cxl_put_root_decoder(cxl->cxlrd);
> +
> +	return ret;
> +}
> +
> +void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +
> +	if (!cxl->region)
> +		return;
> +
> +	cxl_unregister_region(cxl->region);
> +	cxl->region = NULL;
> +
> +	if (cxl->precommitted)
> +		return;
> +
> +	cxl_dpa_free(cxl->cxled);
> +	cxl_put_root_decoder(cxl->cxlrd);
> +}
> +
> +static int vfio_cxl_create_region_helper(struct vfio_pci_core_device *vdev,
> +					 resource_size_t capacity)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	struct pci_dev *pdev = vdev->pdev;
> +	int ret;
> +
> +	if (cxl->precommitted) {
> +		cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd,
> +						       &cxl->region);
> +		if (IS_ERR(cxl->cxled))
> +			return PTR_ERR(cxl->cxled);
> +	} else {
> +		ret = vfio_cxl_create_cxl_region(vdev, capacity);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (cxl->region) {

Maybe if you do 'if (!cxl->region)' first and just exit, then you don't need to indent the normal code path.

> +		struct range range;
> +
> +		ret = cxl_get_region_range(cxl->region, &range);
> +		if (ret)
> +			goto failed;
> +
> +		cxl->region_hpa = range.start;
> +		cxl->region_size = range_len(&range);
> +
> +		pci_dbg(pdev, "Precommitted decoder: HPA 0x%llx size %lu MB\n",
> +			cxl->region_hpa, cxl->region_size >> 20);
> +	} else {
> +		pci_err(pdev, "Failed to create CXL region\n");
> +		ret = -ENODEV;
> +		goto failed;
> +	}
> +
> +	return 0;
> +
> +failed:
> +	vfio_cxl_destroy_cxl_region(vdev);
> +	return ret;
> +}
> +
>  /**
>   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
>   * @vdev: VFIO PCI device
> @@ -172,6 +278,12 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
>  
>  	pci_disable_device(pdev);
>  
> +	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);

Maybe a comment on why this size?

DJ

> +	if (ret)
> +		goto failed;
> +
> +	cxl->precommitted = true;
> +
>  	return;
>  
>  failed:
> @@ -181,6 +293,10 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
>  
>  void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
>  {
> -	if (!vdev->cxl)
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +
> +	if (!cxl || !cxl->region)
>  		return;
> +
> +	vfio_cxl_destroy_cxl_region(vdev);
>  }
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> index 57fed39a80da..985680842a13 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> @@ -17,6 +17,10 @@ struct vfio_pci_cxl_state {
>  	struct cxl_memdev           *cxlmd;
>  	struct cxl_root_decoder     *cxlrd;
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region	    *region;
> +	resource_size_t		     region_hpa;
> +	size_t			     region_size;
> +	void __iomem		    *region_vaddr;
>  	resource_size_t              hdm_reg_offset;
>  	size_t                       hdm_reg_size;
>  	resource_size_t              comp_reg_offset;
> @@ -24,6 +28,7 @@ struct vfio_pci_cxl_state {
>  	u32                          hdm_count;
>  	u16                          dvsec;
>  	u8                           comp_reg_bar;
> +	bool                         precommitted;
>  };
>  
>  /*
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index d7df5538dcde..818d99f098bf 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -137,6 +137,9 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
>  
>  void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev);
>  void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
> +int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
> +			       resource_size_t size);
> +void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev);
>  
>  #else
>  
> @@ -144,6 +147,11 @@ static inline void
>  vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev) { }
>  static inline void
>  vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev) { }
> +static inline int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
> +					     resource_size_t size)
> +{ return 0; }
> +static inline void
> +vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev) { }
>  
>  #endif /* CONFIG_VFIO_CXL_CORE */
>  

