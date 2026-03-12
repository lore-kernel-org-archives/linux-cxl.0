Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682873FF1;
	Thu, 12 Mar 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354669; cv=none; b=pG+ze8WOwP0kz9qVjr636XIKsRzO0951dCGjpvfRM1w0Kj0D61nM8ieVAtCZWqECAZ/s/9j+PdJCAwpORUuTvUFOQF4sVOBu5YFk5sC6jRMXs2AeH8qitP/AdTDgnb/Kuta2Qg0TSho/GMm40jFeLyuChRmLsyV7R0yZXnz5sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354669; c=relaxed/simple;
	bh=iqVxDsBv64pck64O0Ll+2uZI3/QL8ArXPzimLzg/EXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/PgR5Ki9NlgWB3Q+PZ1vDZUI0RoFyTKO9VWZrh6LnmZaoefsRCYkAIwgftc81FtpCsxieXhzBlL94qksQBWekg7BZatYczO5UV/Ci846O/VtCNduVfkpk52eWt4fkKyQmhOLc4hiDXVwvjKpOzpuqQoo5MRWsipYa/Kj8BnKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZYfVJ9u; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZYfVJ9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773354668; x=1804890668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iqVxDsBv64pck64O0Ll+2uZI3/QL8ArXPzimLzg/EXY=;
  b=BZYfVJ9uoLu39+CFwNJXvwNGccSy98MKC5CmSE0XodlNP4GpL0TAaSiO
   R5FdNNh4Hib9pfh4Z1lqKPI1Uq6wssC7ML8qxBZVloD0132tvQ6Sjtd18
   q9TNLssiKxR7G0MiEPVhBJctr5pI1Jpz+KHMij5Rm1CMO45J6TKud4j9o
   DLYMoD0VKbgiacvm8Yoh2B0HyH0wkIaBQU2pjvSfXJTQn1kFUSFN2MHB4
   eiOZ2EgMcI67VqQgFcv72IvSgA0DWalyusfNKK56lFBFj9d3rMDUzQ7y6
   3D38MC08OcFraIm4ComFa57GabvC+zq6wEUrVRpJ0/iFPgoAEfxAbFFvG
   A==;
X-CSE-ConnectionGUID: Q8VBY/nxRWGpezXn8LihNg==
X-CSE-MsgGUID: 8iIW1PGQRtehBwamT18fXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85942627"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="85942627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:31:07 -0700
X-CSE-ConnectionGUID: q77RrV/XSlm3AV9cvV31FQ==
X-CSE-MsgGUID: 2AyNSjorQE+bYHg+VgSqzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="215969882"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 15:31:05 -0700
Message-ID: <26be5ee3-d7ba-4bea-9824-c514341cf324@intel.com>
Date: Thu, 12 Mar 2026 15:31:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] vfio/cxl: Implement CXL device detection and HDM
 register probing
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-10-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-10-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Implement the core CXL Type-2 device detection and component register
> probing logic in vfio_pci_cxl_detect_and_init().
> 
> Three private helpers are introduced:
> 
>   vfio_cxl_create_device_state() allocates the per-device
>   vfio_pci_cxl_state structure using devm_cxl_dev_state_create() so
>   that lifetime is tied to the PCI device binding.
> 
>   vfio_cxl_find_bar() locates the PCI BAR that contains a given HPA
>   range, returning the BAR index and offset within it.
> 
>   vfio_cxl_setup_regs() uses the CXL core helpers cxl_find_regblock()
>   and cxl_probe_component_regs() to enumerate the HDM decoder register
>   block, then records its BAR index, offset and size in the CXL state.
> 
> vfio_pci_cxl_detect_and_init() orchestrates detection:
>   1. Check for CXL DVSEC via pcie_is_cxl() + pci_find_dvsec_capability().
>   2. Allocate CXL device state.
>   3. Temporarily call pci_enable_device_mem() for ioremap, then disable.
>   4. Probe component registers to find the HDM decoder block.
> 
> On any failure vdev->cxl is devm_kfree'd so that device falls back to
> plain PCI mode transparently.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 151 +++++++++++++++++++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   8 ++
>  2 files changed, 159 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 7698d94e16be..2da6da1c0605 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -18,6 +18,114 @@
>  
>  MODULE_IMPORT_NS("CXL");
>  
> +static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
> +					u16 dvsec)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct vfio_pci_cxl_state *cxl;
> +	bool cxl_mem_capable, is_cxl_type3;
> +	u16 cap_word;
> +
> +	/*
> +	 * The devm allocation for the CXL state remains for the entire time
> +	 * the PCI device is bound to vfio-pci. From successful CXL init
> +	 * in probe until the device is released on unbind.
> +	 * No extra explicit free is needed; devm handles it when
> +	 * pdev->dev is released.
> +	 */
> +	vdev->cxl = devm_cxl_dev_state_create(dev,
> +					      CXL_DEVTYPE_DEVMEM,
> +					      pdev->dev.id, dvsec,
> +					      struct vfio_pci_cxl_state,
> +					      cxlds, false);
> +	if (!vdev->cxl)
> +		return -ENOMEM;
> +
> +	cxl = vdev->cxl;
> +	cxl->dvsec = dvsec;
> +
> +	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
> +			     &cap_word);
> +
> +	cxl_mem_capable = !!(cap_word & CXL_DVSEC_MEM_CAPABLE);
> +	is_cxl_type3 = ((pdev->class >> 8) == PCI_CLASS_MEMORY_CXL);

Both of these can use FIELD_GET().

> +
> +	/*
> +	 * Type 2 = CXL memory capable but NOT Type 3 (e.g. accelerator/GPU)
> +	 * Unsupported for non cxl type-2 class of devices.
> +	 */
> +	if (!(cxl_mem_capable && !is_cxl_type3)) {
> +		devm_kfree(&pdev->dev, vdev->cxl);
> +		vdev->cxl = NULL;
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	struct cxl_register_map *map = &cxl->cxlds.reg_map;
> +	resource_size_t offset, bar_offset, size;
> +	struct pci_dev *pdev = vdev->pdev;
> +	void __iomem *base;
> +	u32 count;
> +	int ret;
> +	u8 bar;
> +
> +	if (WARN_ON_ONCE(!pci_is_enabled(pdev)))
> +		return -EINVAL;
> +
> +	/* Find component register block via Register Locator DVSEC */
> +	ret = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, map);
> +	if (ret)
> +		return ret;
> +
> +	/* Temporarily map the register block */
> +	base = ioremap(map->resource, map->max_size);

Request the mem region before mapping it?

DJ

> +	if (!base)
> +		return -ENOMEM;
> +
> +	/* Probe component register capabilities */
> +	cxl_probe_component_regs(&pdev->dev, base, &map->component_map);
> +
> +	/* Unmap immediately */
> +	iounmap(base);
> +
> +	/* Check if HDM decoder was found */
> +	if (!map->component_map.hdm_decoder.valid)
> +		return -ENODEV;
> +
> +	pci_dbg(pdev,
> +		"vfio_cxl: HDM decoder at offset=0x%lx, size=0x%lx\n",
> +		map->component_map.hdm_decoder.offset,
> +		map->component_map.hdm_decoder.size);
> +
> +	/* Get HDM register info */
> +	ret = cxl_get_hdm_reg_info(&cxl->cxlds, &count, &offset, &size);
> +	if (ret)
> +		return ret;
> +
> +	if (!count || !size)
> +		return -ENODEV;
> +
> +	cxl->hdm_count = count;
> +	cxl->hdm_reg_offset = offset;
> +	cxl->hdm_reg_size = size;
> +
> +	ret = cxl_regblock_get_bar_info(map, &bar, &bar_offset);
> +	if (ret)
> +		return ret;
> +
> +	cxl->comp_reg_bar = bar;
> +	cxl->comp_reg_offset = bar_offset;
> +	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
>  /**
>   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
>   * @vdev: VFIO PCI device
> @@ -28,8 +136,51 @@ MODULE_IMPORT_NS("CXL");
>   */
>  void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
>  {
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct vfio_pci_cxl_state *cxl;
> +	u16 dvsec;
> +	int ret;
> +
> +	if (!pcie_is_cxl(pdev))
> +		return;
> +
> +	dvsec = pci_find_dvsec_capability(pdev,
> +					  PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return;
> +
> +	ret = vfio_cxl_create_device_state(vdev, dvsec);
> +	if (ret)
> +		return;
> +
> +	cxl = vdev->cxl;
> +
> +	/*
> +	 * Required for ioremap of the component register block and
> +	 * calls to cxl_probe_component_regs().
> +	 */
> +	ret = pci_enable_device_mem(pdev);
> +	if (ret)
> +		goto failed;
> +
> +	ret = vfio_cxl_setup_regs(vdev);
> +	if (ret) {
> +		pci_disable_device(pdev);
> +		goto failed;
> +	}
> +
> +	pci_disable_device(pdev);
> +
> +	return;
> +
> +failed:
> +	devm_kfree(&pdev->dev, vdev->cxl);
> +	vdev->cxl = NULL;
>  }
>  
>  void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
>  {
> +	if (!vdev->cxl)
> +		return;
>  }
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> index 818a83a3809d..57fed39a80da 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> @@ -26,4 +26,12 @@ struct vfio_pci_cxl_state {
>  	u8                           comp_reg_bar;
>  };
>  
> +/*
> + * CXL DVSEC for CXL Devices - register offsets within the DVSEC
> + * (CXL 2.0+ 8.1.3).
> + * Offsets are relative to the DVSEC capability base (cxl->dvsec).
> + */
> +#define CXL_DVSEC_CAPABILITY_OFFSET 0xa
> +#define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
> +
>  #endif /* __LINUX_VFIO_CXL_PRIV_H */

