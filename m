Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA263F99F3;
	Thu, 12 Mar 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334153; cv=none; b=RSB2J/wSI57jGO8WgCbB5D/LrtXCpeqCbTke/vbJlDdhUb+tnDZXVAAuoPPj2Pk+8lInu6i88BvX6B405cA9xorNEO6YZeRv/ITXQ6JBRWxsHF3TowCD3kEJ4ANCF2A/y9WJMX+p5SUP5DK76q0SKFqoPgIwb97mKdIyJob9pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334153; c=relaxed/simple;
	bh=XKGUGWrzojWOGD6w7apxfZsLbKlnIbAQKM8CcH1wN3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsE82jMJZ7N/RGfQg4wwRevAoiXFLlodA8gdCW0dT1xj/ODjTB9Xn6+Ek5ggWGPjasD7XliLltPT5c+MnG/KDKiRzduxnwdb3H8LgjXuDfzhibdYlsFcpfgQB13zD7iHQXBvMqjTu7GxkF9MBpQPfDYtekYTQGHR98ThF+IJTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxZ8RuBb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxZ8RuBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773334146; x=1804870146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XKGUGWrzojWOGD6w7apxfZsLbKlnIbAQKM8CcH1wN3o=;
  b=XxZ8RuBb3rnZwLE90onvLS1W0JkKd6unouwCW/YJemxF2MbZofK4/ppv
   44e+duxm2TNdkJpulXC9iycNh9l2rlbxNKFoz0BgLPCuXdXNbLIAlJulW
   xj26ODl5gpMT+e8KGMMQ7OLSOnUWAGxGxGp1V8kFYJgnNkLbQxb0km7J7
   OrmnTXJ6npHDx67/ib2+Is/e8yPQ6nDi5bNFCZcYZXYt/dbeyCUadXte6
   cXki+GE132B8N7eOUA/tUANh+tCcI6BXykQqIEvHwjSK3HVcofsThlvsj
   4th4mr0tA/DF3SdtGTre798Gfzc4AfXYxzD61zEwmFYs+DiBv4GwJ6F8f
   w==;
X-CSE-ConnectionGUID: I+byxeoMRN2Bro+lUo1IbA==
X-CSE-MsgGUID: FH0lcgHhTQGGZ5CytrJD6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74475832"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74475832"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:49:05 -0700
X-CSE-ConnectionGUID: GPNXZ13yTB6kfywbiIVprw==
X-CSE-MsgGUID: HkusyPCxTSCZyyLxG9xhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220948914"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:49:03 -0700
Message-ID: <81141774-89c5-4cb8-a7e7-52ae8c55ca25@intel.com>
Date: Thu, 12 Mar 2026 09:49:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] cxl: Expose cxl subsystem specific functions for
 vfio
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-3-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-3-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Below functions from CXL subsystem will be required in vfio-cxl
> for supporting the type-2 device passthrough:
>     cxl_find_regblock - To find component registers
>     cxl_probe_component_regs - Probe HDM/RAS capabilities
> 
> Make these functions available via declaring them from include header
> instead of subsystem-specific header.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/cxl.h | 4 ----
>  include/cxl/cxl.h | 7 +++++++
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2b1f7d687a0e..10ddab3949ee 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -198,8 +198,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
>  int cxl_map_device_regs(const struct cxl_register_map *map,
> @@ -211,8 +209,6 @@ enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, unsigned int index);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
>  int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 8456177b523e..610711e861d4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -287,4 +287,11 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  
>  int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
>  			 resource_size_t *offset, resource_size_t *size);
> +struct pci_dev;
> +enum cxl_regloc_type;
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map);
> +void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> +			      struct cxl_component_reg_map *map);

I do wonder if this needs an ifdef of CONFIG_CXL_BUS given cxl_core can be made as a module or disabled.


> +
>  #endif /* __CXL_CXL_H__ */

