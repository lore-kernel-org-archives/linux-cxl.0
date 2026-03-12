Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA1324B24;
	Thu, 12 Mar 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349134; cv=none; b=BzMz7O64XVI/eV8/ivKjqETD7K6plptv1QDXL1nAQF1V2JiHhRFtA2eE90mZd7D3qVl/RGCHFjaOHEFAgDqx3lTGLiMEp251mzWag9MP/FzrHuI5hZmn7TkpS6bKG7Z+uAubjf08ovoeaHNE5b034CVr13GpHNoB/eCEpeSql58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349134; c=relaxed/simple;
	bh=sb7xDLVUUc8cUss4nZ6J23r5fUq+MvYpVJwcLhUkFXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8ISzmoikQJhKDOojUUwnQeM7xsDWgwMYk8k7mvZye/JwFFyW7SKjEE/gp7FJcwA/Mkizar6ppTLC9k2eXmdE0LLk8Oss1pAIY3z0HeQQiLDudIgbSoP1GorIIzFWTPTMMJpwoWesILnPOsCtNWNrfXRhlegmJA9oWMaBqlh/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2kEylsT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2kEylsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349132; x=1804885132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sb7xDLVUUc8cUss4nZ6J23r5fUq+MvYpVJwcLhUkFXI=;
  b=f2kEylsTuF43fhdXGcthp3Igmfu2cQ7/wCYcM3t7YA6426IkVDs8lU4O
   nDKcNwkZO2N9gTo4FSEvfP2tfCnWc3aM0xEMSZk5RTHnoMHHwye5S8Kok
   Hk3AirdDdvLCs0MdTCAM7k9p9fZUGQtVlDBpIx6SuxXw2zLUWsugSQE4X
   i0ptVOByTLzAJsPGY4mPb45vpP83cbrsPInubmD7BrqdQnzUH9Mbjmzhh
   /tIRWYbpFncWsq8Mx2NeaIETrAPCPNCeOjGLkzrBXWeF1PJrh5Hr9ukGx
   8Du+mJI2cVBw0pHKJD4Z/oheXMA/Jq6C059HJ4vtOWTWyEppjbu4oRgPx
   Q==;
X-CSE-ConnectionGUID: iMqWGnxeTTSItfC7y1YhdA==
X-CSE-MsgGUID: 3z4rXswQSNGnacqhIbiw7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78348730"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78348730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:58:51 -0700
X-CSE-ConnectionGUID: Sjb99sKmQmyzdQCEOdsHNA==
X-CSE-MsgGUID: 1o0Lasd1QHSDQORYNd+5lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="217019549"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:58:49 -0700
Message-ID: <3e31fbc0-997b-4edc-b9d4-20a10e53a5e7@intel.com>
Date: Thu, 12 Mar 2026 13:58:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] cxl: Expose BAR index and offset from register map
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-6-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-6-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> The Register Locator DVSEC (CXL 2.0 8.1.9) describes register blocks by

CXL r4.0

Let's keep it to the latest spec version.

> BAR index (BIR) and offset within the BAR. CXL core currently only
> stores the resolved HPA (resource + offset) in struct cxl_register_map,
> so callers that need to use pci_iomap() or report the BAR to userspace
> must reverse-engineer the BAR from the HPA.
> 
> Add bar_index and bar_offset to struct cxl_register_map and fill them
> in cxl_decode_regblock() when the regblock is BAR-backed (BIR 0-5).
> Add cxl_regblock_get_bar_info() so callers (e.g. vfio-cxl) can get BAR
> index and offset directly and use pci_iomap() instead of ioremap(HPA).
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/regs.c | 29 +++++++++++++++++++++++++++++
>  include/cxl/cxl.h       | 11 +++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..720eb6eb5a45 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -287,9 +287,37 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	map->reg_type = reg_type;
>  	map->resource = pci_resource_start(pdev, bar) + offset;
>  	map->max_size = pci_resource_len(pdev, bar) - offset;
> +	map->bar_index = (bar >= 0 && bar < PCI_STD_NUM_BARS) ? (u8)bar : 0xFF;

map->bar_index = bar should be fine. Otherwise the pci_resource_start() and pci_resource_len() would also be invalid.


> +	map->bar_offset = offset;
>  	return true;
>  }
>  
> +/**
> + * cxl_regblock_get_bar_info() - Get BAR index and offset for a BAR-backed regblock
> + * @map: Register map from cxl_find_regblock() or cxl_find_regblock_instance()
> + * @bar_index: Output BAR index (0-5). Optional, may be NULL.
> + * @bar_offset: Output offset within the BAR. Optional, may be NULL.
> + *
> + * When the register block was found via the Register Locator DVSEC and
> + * lives in a PCI BAR (BIR 0-5), this returns the BAR index and the offset
> + * within that BAR. Callers can use pci_iomap(pdev, bar_index, size) and
> + * base + bar_offset instead of ioremap(map->resource).
> + *
> + * Return: 0 if the regblock is BAR-backed (bar_index <= 5), -EINVAL otherwise.
> + */
> +int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
> +			      resource_size_t *bar_offset)
> +{
> +	if (!map || map->bar_index > PCI_STD_NUM_BARS - 1)

map->bar_index == 0xff? Otherwise it's probably a hardware issue right?

DJ

> +		return -EINVAL;
> +	if (bar_index)
> +		*bar_index = map->bar_index;
> +	if (bar_offset)
> +		*bar_offset = map->bar_offset;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_regblock_get_bar_info, "CXL");
> +
>  /*
>   * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
>   * Use CXL_INSTANCES_COUNT for @index if counting instances.
> @@ -308,6 +336,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
> +		.bar_index = 0xFF,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 684603799fb1..08e327a929ba 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -134,9 +134,16 @@ struct cxl_pmu_reg_map {
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
>   * @reg_type: see enum cxl_regloc_type
> + * @bar_index: PCI BAR index (0-5) when regblock is BAR-backed; 0xFF otherwise
> + * @bar_offset: offset within the BAR; only valid when bar_index <= 5
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
>   * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + *
> + * When the register block is described by the Register Locator DVSEC with
> + * a BAR Indicator (BIR 0-5), bar_index and bar_offset are set so callers can
> + * use pci_iomap(pdev, bar_index, size) and base + bar_offset instead of
> + * ioremap(resource).
>   */
>  struct cxl_register_map {
>  	struct device *host;
> @@ -144,6 +151,8 @@ struct cxl_register_map {
>  	resource_size_t resource;
>  	resource_size_t max_size;
>  	u8 reg_type;
> +	u8 bar_index;
> +	resource_size_t bar_offset;
>  	union {
>  		struct cxl_component_reg_map component_map;
>  		struct cxl_device_reg_map device_map;
> @@ -319,6 +328,8 @@ int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
>  			 resource_size_t *offset, resource_size_t *size);
>  struct pci_dev;
>  enum cxl_regloc_type;
> +int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
> +			      resource_size_t *bar_offset);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,

