Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C137416E;
	Thu, 12 Mar 2026 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349448; cv=none; b=uZSlXvMAPGZQYYbLSKEFYKIN0L5mIOXutLLrWpXEN3L/X18cc46+Xzaw3QSfPSULHTL46CHFhpLmDzn3FAWMq5nFsh3dYLj/esPRKIobBz2paJHhGyKrwe+65OLcLlDFAyuv7DeyGUIaH90Exhrbz1+otj6XpNMCXrPEKm8sPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349448; c=relaxed/simple;
	bh=j1FNz4LXByPf2nqns5m0LbNxXiwrtitDRF+AOO76vRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBFyz9cxoXRKAE1vDxp0krT+gcyZwL41mIlK55KcDqOMk09htbwAKlUF/5UkgFI+tkVoPw6+pwa08H88uzIsxPrqKbMEpJxHZJRfV1mSLA1dZR93lUChy1M+il8sT81hSSPW6ZpuTAXCs2SxQhsijpznIavEYIW1PFIN+krOHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HK7H0hSM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HK7H0hSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349447; x=1804885447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j1FNz4LXByPf2nqns5m0LbNxXiwrtitDRF+AOO76vRU=;
  b=HK7H0hSMGtWRsxlGI1K3q+jIBuoXb6/HLmS5iBI3Lv2Non+HwSxYlAvy
   m+wPkM2AOFawUxcv4IjgqMABwtiQtfcXTmjGX2kkYiH9gxNSbQ+6fENU3
   VNgCpugamGpj22cZeeA0dEIPAlG2Yme/C0DEvnAS8pVJh45F/wrJmFmi6
   E6G2FC5cszdOXmbp86qUqIFpXoFOFocb4KaWZ/E6RjAztAbIq1sXNnRzn
   PflOqE2J5zproKSOzr1tq+H4Irac2OW1rM4G/Dk6wtoKqA1QxMaUslzYX
   VbLMCRQPuRXdcITnh+3gOr+8+txgLk51KsF7B2MUR4SDmhlLrmAzF02k/
   g==;
X-CSE-ConnectionGUID: 5XdeMZK1SuqGkuHURykGqw==
X-CSE-MsgGUID: k65fXViqQjGxrrW1qILWuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74349453"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74349453"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:04:06 -0700
X-CSE-ConnectionGUID: TwkPglvKQpKLCE/h+eme/w==
X-CSE-MsgGUID: 3B7qsr79TH+bHy5bvDLznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="217021235"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:04:04 -0700
Message-ID: <40033fce-2fba-4841-8983-037da1f39bd4@intel.com>
Date: Thu, 12 Mar 2026 14:04:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] vfio/cxl: Add UAPI for CXL Type-2 device
 passthrough
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-7-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-7-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL capabilities include:
> - hdm_count: Number of HDM decoders available
> - capacity: Total device memory (DPA)
> - flags: COMMITTED, PRECOMMITTED
> 
> This UAPI enables VMMs like QEMU to passthrough CXL Type-2 devices
> (GPUs, accelerators) with coherent memory to VMs.
> 
> Also added user-kernel API definitions for CXL Type-2 device passthrough.
> Document how VFIO_DEVICE_FLAGS_CXL relates to VFIO_DEVICE_FLAGS_PCI
> and VFIO_DEVICE_FLAGS_CAPS, and add field and flag descriptions
> for the CXL capability.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ac2329f24141..7ec0f96cc2d9 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -215,6 +215,13 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
>  #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
>  #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
> +/*
> + * CXL Type-2 device (memory coherent; e.g. GPU, accelerator). When set,
> + * VFIO_DEVICE_FLAGS_PCI is also set (same device is a PCI device). The
> + * capability chain (VFIO_DEVICE_FLAGS_CAPS) contains VFIO_DEVICE_INFO_CAP_CXL
> + * describing HDM decoders, DPA size, and CXL-specific options.
> + */
> +#define VFIO_DEVICE_FLAGS_CXL   (1 << 9)        /* Device supports CXL */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  	__u32   cap_offset;	/* Offset within info struct of first cap */
> @@ -257,6 +264,39 @@ struct vfio_device_info_cap_pci_atomic_comp {
>  	__u32 reserved;
>  };
>  
> +/*
> + * VFIO_DEVICE_INFO_CAP_CXL - CXL Type-2 device capability
> + *
> + * Present in the device info capability chain when VFIO_DEVICE_FLAGS_CXL
> + * is set. Describes Host Managed Device Memory (HDM) layout and CXL
> + * memory options so that userspace (e.g. QEMU) can expose the CXL region
> + * and component registers correctly to the guest.
> + */
> +#define VFIO_DEVICE_INFO_CAP_CXL		6
> +struct vfio_device_info_cap_cxl {
> +	struct vfio_info_cap_header header;
> +	__u8  hdm_count; /* Number of HDM decoders */
> +	__u8  hdm_regs_bar_index; /* PCI BAR containing HDM registers */
> +	__u16 pad;
> +	__u32 flags;
> +/* Decoder was committed by host firmware/BIOS */

I'm confused by COMMITTED vs PRECOMMITTED. Should it just say "Decoder is committed" here? Otherwise what is the difference? Also can you explain a little the usage for COMMITTED vs PRECOMMITTED in the commit log please? i.e why does VFIO CXL needs to know a decoder is pre-committed?

DJ

> +#define VFIO_CXL_CAP_COMMITTED		(1 << 0)
> +/*
> + * Memory was pre-committed (firmware-programmed); VMM need not allocate
> + * from CXL pool
> + */
> +#define VFIO_CXL_CAP_PRECOMMITTED	(1 << 1)
> +	__u64 hdm_regs_size; /* Size in bytes of HDM register block */
> +	__u64 hdm_regs_offset; /* Byte offset within the BAR to the HDM decoder block */
> +	__u64 dpa_size; /* Device Physical Address (DPA) size in bytes */
> +	/*
> +	 * Region indices for the two CXL VFIO device regions.
> +	 * Avoids forcing userspace to scan all regions by type/subtype.
> +	 */
> +	__u32  dpa_region_index;       /* VFIO_REGION_SUBTYPE_CXL */
> +	__u32  comp_regs_region_index; /* VFIO_REGION_SUBTYPE_CXL_COMP_REGS */
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
>   *				       struct vfio_region_info)
> @@ -370,6 +410,18 @@ struct vfio_region_info_cap_type {
>   */
>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>  
> +/* 1e98 vendor PCI sub-types (CXL Consortium) */
> +/*
> + * CXL memory region. Use with region type
> + * (PCI_VENDOR_ID_CXL | VFIO_REGION_TYPE_PCI_VENDOR_TYPE).
> + * DPA memory region (fault+zap mmap)
> + */
> +#define VFIO_REGION_SUBTYPE_CXL                 (1)
> +/*
> + * HDM decoder register emulation region (read/write only, no mmap).
> + */
> +#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS       (2)
> +
>  /* sub-types for VFIO_REGION_TYPE_GFX */
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>  

