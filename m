Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C482DEA86;
	Thu, 12 Mar 2026 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333185; cv=none; b=tZ74+xB7LI+nMhC1gEMPvcY5GPsWzmJePti9RuGJTVTUjOs6oo5oJ6TkONdITFmTjki2RSj/be5fZ484aMts1E0vh90U359Z97ojiwLbrdrCkyfJGO8qXr4pm97fdoTS+NpTJDHRlprxnaM1klAkztCce1dI6DJRXzEoUoj7VXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333185; c=relaxed/simple;
	bh=FvkMkdd2WY78WOrTr9C43jJ/XSvAs77Z9VGY5C6pX3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0CzLsMylCVv1E7Rw5z6UdBK3hM4moa6ydhELcp8sk8o4Bf8Nf/JblUe8EM3BjOnJ/qBfEBClCiDh4QpEdAuyn5tm3rulaWHoFHNn9WeFCmy1DIxF4b+nryEHNFTSnPgmqArakkOUAo4fRhAUTFXFHEnWjINXVNrdQeV6Na6SC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evq7K/UB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evq7K/UB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773333183; x=1804869183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FvkMkdd2WY78WOrTr9C43jJ/XSvAs77Z9VGY5C6pX3s=;
  b=evq7K/UBQFLuOg9brCi5L30lGkxsAXsVpdl3/1DGzu1csYCZxn8V2YDp
   SLRQn9hPgXEeNN7Uaf4sjIWSaGdL3kF3S9aFsH0X4GIkvygn9FXVuhjnv
   ADBj3he4Ab8A+BaNNpz+hKq9MxSunCkOt6Cz/QqUSRA3iUS0rD0Ceg5Dq
   ep94sFv8PjcNtv49T13/vPM20aXukHYem0Np2NvvtQb3fvPSMa9PZ8gA/
   IjQJeAc6PW9AeevoaeUpH3fu2wB2ZSn0RmRPBQXWC4aYYZGXSziZ6lVQz
   Dn8tF5qZIJVnvnQDp64b4qlapZpRnki1AExUWY5+L4hBTr/0YI5SECKoe
   Q==;
X-CSE-ConnectionGUID: zuCfs58tR36/jxzYXSPvAQ==
X-CSE-MsgGUID: paixOC6cTRKvLoM+PVNHQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74474011"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74474011"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:33:03 -0700
X-CSE-ConnectionGUID: yAKYAbfFTLSl7UrlyLt0Og==
X-CSE-MsgGUID: VtaxTvo3QluO+Mcc6RKp1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220945872"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:33:02 -0700
Message-ID: <b1a71b7d-4997-4449-b77d-ad317bd7644d@intel.com>
Date: Thu, 12 Mar 2026 09:33:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] cxl: Introduce cxl_get_hdm_reg_info()
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-2-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-2-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL core has the information of what CXL register groups a device has.
> When initializing the device, the CXL core probes the register groups
> and saves the information. The probing sequence is quite complicated.
> 
> vfio-cxl requires the HDM register information to emulate the HDM decoder

/register/register block/

Otherwise it implies a single register.

> registers.
> 
> Introduce cxl_get_hdm_reg_info() for vfio-cxl to leverage the HDM
> register information in the CXL core. Thus, it doesn't need to implement

same here. "register block"

> its own probing sequence.
> 
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index ba2d393c540a..52ed0b4f5e78 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -449,6 +449,51 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
>  
> +/**
> + * cxl_get_hdm_reg_info - Get HDM decoder register block location and count

cxl_get_hdm_info() to be consistent with CXL core naming convention.

> + * @cxlds: CXL device state (must have component regs enumerated)
> + * @count: Output: number of HDM decoders (from DVSEC cap). Only set when
> + *         the device has a valid HDM decoder capability.
> + * @offset: Output: byte offset of the HDM decoder register block within the
> + *          component register BAR. Only set when valid.
> + * @size: Output: size in bytes of the HDM decoder register block. Only set
> + *        when valid.
> + *
> + * Reads the CXL component register map and DVSEC capability to return the
> + * Host Managed Device Memory (HDM) decoder register block offset and size,
> + * and the number of HDM decoders. This function requires cxlds->cxl_dvsec
> + * to be non-zero.
> + *
> + * Return: 0 on success. A negative errno is returned when config read
> + * failure or when the decoder registers are not valid.
> + */
> +int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,

u8 for count probably sufficient as Jonathan mentioned. Decoder cap is only 4 bits for count.

> +			 resource_size_t *offset, resource_size_t *size)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_component_reg_map *map =
> +		&cxlds->reg_map.component_map;
> +	int d = cxlds->cxl_dvsec;

Name it dvsec for easier correlation when reading the code.

> +	u16 cap;
> +	int rc;
> +
> +	/* HDM decoder registers not implemented */
> +	if (!map->hdm_decoder.valid || !d)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev,
> +				  d + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return rc;
> +
> +	*count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);

This is not the correct place to find number of decoders. You should be looking at CXL HDM Decoder Capability Register (CXL r4.0 8.2.4.20.1) for the 'Decoder Count' field.

DJ

> +	*offset = map->hdm_decoder.offset;
> +	*size = map->hdm_decoder.size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hdm_reg_info, "CXL");
> +
>  #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
>  #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
>  #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 50acbd13bcf8..8456177b523e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -284,4 +284,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     struct cxl_endpoint_decoder **cxled,
>  				     int ways);
> +
> +int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
> +			 resource_size_t *offset, resource_size_t *size);
>  #endif /* __CXL_CXL_H__ */

