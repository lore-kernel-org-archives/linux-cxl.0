Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D662F1FED;
	Thu, 12 Mar 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347361; cv=none; b=QBliZDxUcjNTJnwgOalx+OgSM7q5lkAQjmDBgIBIk5Tqrh5ecbZeuCZCZUQ91SvRDaNYlx9ZaXfga8a0UQkPtNchOaMLnjok5o3G4jBw5O1kkh80HFUyRadJ3CVu2Kd5iO36v4tISjVGtU/zvKevSSkgZgEDh6IQumvQzQAVj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347361; c=relaxed/simple;
	bh=IyZHDCCxKeisSMgVv3T6sHm4m90C9xfIq+Espy/Tdto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcCuSnmqrm8W9j0oSsVSpW3TqNA7OwdpT/38/W1hFsXCBMw0Z1zlmC6DCOcN8Tr71bd7fg6qpG2ThtRjaMFwXJslrgZOVJPjlsaEEz8OOegq9MCNsuhL4G18KvGAO4/nLdwgAtoLEYx/oudKv2Wnjnkw6u06jI0wy27kE1iYIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoA1f1lp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoA1f1lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773347360; x=1804883360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IyZHDCCxKeisSMgVv3T6sHm4m90C9xfIq+Espy/Tdto=;
  b=GoA1f1lp//x4X1BSHUBTymzH73I0jqTxc+s9tCgyBPfwsLOYIqo0uaxC
   lJTkR92z+rnven5pKK0ul8bEz6dinVOlAZoJ+5C8j+IXRAbyDjUDmBkXU
   26DEqMIirzdK4P9nsXeasgg2/InlWjLymGcsMCYLfotCIehhxdJuReJqd
   3ihylzJ056LUUIQXDBfxNCmXkLvzNQesMfNz4NN5CKF/E8sLxVSySsvRt
   iVgRzxMwomTWaAae7cch5xcqitSk0OFJqEu+zyxn3tX1Gb8ELS1fNZk5i
   DEuu6XGoLIY13KUwIvJJmxsno71juHgHKwo3EYk4Ha38IbCZQmsn3uWBR
   w==;
X-CSE-ConnectionGUID: CU6vE4IBSeS8mwjPg8lRWw==
X-CSE-MsgGUID: /mxuLFqJQruMDurirPsTKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74336370"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74336370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:29:20 -0700
X-CSE-ConnectionGUID: DsAUIsTrQd6xRhbuc/pRQg==
X-CSE-MsgGUID: 4ur4z8S5QRalRgW3O0oz1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="243976516"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:29:17 -0700
Message-ID: <6ea7cc03-59d2-489e-9506-65f8759dfdbd@intel.com>
Date: Thu, 12 Mar 2026 13:29:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] cxl: Media ready check refactoring
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-5-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-5-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Before accessing CXL device memory after reset/power-on, the driver
> must ensure media is ready. Not every CXL device implements the CXL
> Memory Device register group (many Type-2 devices do not).
> cxl_await_media_ready() reads cxlds->regs.memdev; calling it
> on a Type-2 without that block can result in kernel panic.

please consider:
Access the memory device registers on a Type-2 device may result in kernel panic.

> 
> This commit refactors the HDM range based check in a new function which
> can be safely used for type-2 and type-3 devices. cxl_await_media_ready
> still uses the same format of checking the HDM range and memory device
> register status.
> 
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 35 ++++++++++++++++++++++++++++++-----
>  include/cxl/cxl.h      |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 52ed0b4f5e78..2b7e4d73a6dd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -142,16 +142,24 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  	return 0;
>  }
>  
> -/*
> - * Wait up to @media_ready_timeout for the device to report memory
> - * active.
> +/**
> + * cxl_await_range_active - Wait for all HDM DVSEC memory ranges to be active
> + * @cxlds: CXL device state (DVSEC and HDM count must be valid)
> + *
> + * For each HDM decoder range reported in the CXL DVSEC capability, waits for
> + * the range to report MEM INFO VALID (up to 1s per range), then MEM ACTIVE
> + * (up to media_ready_timeout seconds per range, default 60s). Used by
> + * cxl_await_media_ready() and by callers that only need range readiness
> + * without checking the memory device status register.
> + *
> + * Return: 0 if all ranges become valid and active, -ETIMEDOUT if a timeout
> + * occurs, or a negative errno from config read on failure.
>   */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +int cxl_await_range_active(struct cxl_dev_state *cxlds)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	int rc, i, hdm_count;
> -	u64 md_status;
>  	u16 cap;
>  
>  	rc = pci_read_config_word(pdev,
> @@ -172,6 +180,23 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  			return rc;
>  	}
>  
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_await_range_active, "CXL");
> +
> +/*
> + * Wait up to @media_ready_timeout for the device to report memory
> + * active.
> + */
> +int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	u64 md_status;
> +	int rc;
> +
> +	rc = cxl_await_range_active(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!CXLMDEV_READY(md_status))
>  		return -EIO;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 27c006fa53c3..684603799fb1 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -323,5 +323,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
> +int cxl_await_range_active(struct cxl_dev_state *cxlds);
>  
>  #endif /* __CXL_CXL_H__ */

