Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72C3C2762;
	Thu, 12 Mar 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314895; cv=none; b=BjZumL2nWC1LheQOY7XJ6ggtTO1qtmahpyciUhroBhckQbkVRPgA52wMvoItcCHE0mco5nTUHrdeHIJg0dqQwdO9G7CNfdiikvRhQFr4AFPWYzQbY7BRdI3plPXGSe7TD1U8Y4ImLj/HX1XE4XlhENbEZZD7L7RuZlmILniR+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314895; c=relaxed/simple;
	bh=rUjVJSUqo4ecSZYNtsm+AH+OGZ4luNAz2CE7ZWLNiLE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc7mho5iSCBIjcwOCQYBnZRUFI0hQdC/X5540gIPOxXfFzgx0pVlB75Ya+Fog+WSKTHkXU0Og9URCiRIIygOJ35AFLAWme7OU1gjoeuokuOE86StEtrsMtP4NLY6tpiGp1ZfwuHb+pLXl9PTABmP2nDr2yj3cS38MB12P0AvCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWljC3y0bzHnGj0;
	Thu, 12 Mar 2026 19:27:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C74C40589;
	Thu, 12 Mar 2026 19:28:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 11:28:07 +0000
Date: Thu, 12 Mar 2026 11:28:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <mhonap@nvidia.com>
CC: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 01/20] cxl: Introduce cxl_get_hdm_reg_info()
Message-ID: <20260312112806.00004117@huawei.com>
In-Reply-To: <20260311203440.752648-2-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-2-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 12 Mar 2026 02:04:21 +0530
mhonap@nvidia.com wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL core has the information of what CXL register groups a device has.
> When initializing the device, the CXL core probes the register groups
> and saves the information. The probing sequence is quite complicated.
> 
> vfio-cxl requires the HDM register information to emulate the HDM decoder
> registers.
> 
> Introduce cxl_get_hdm_reg_info() for vfio-cxl to leverage the HDM
> register information in the CXL core. Thus, it doesn't need to implement
> its own probing sequence.
> 
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Hi Manish, Zhi,

Taking a first pass look at this so likely comments will be trivial
whilst I get my head around it.

Jonathan

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
> + * and the number of HDM decoders.

No it doesn't, see below.

> This function requires cxlds->cxl_dvsec
> + * to be non-zero.
> + *
> + * Return: 0 on success. A negative errno is returned when config read
> + * failure or when the decoder registers are not valid.
> + */
> +int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,

If we are going to use a fixed size for count (which is fine) maybe pick a
smaller one.  It's never bigger than a u8.  Actually never bigger than 2...
See below.

> +			 resource_size_t *offset, resource_size_t *size)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_component_reg_map *map =
> +		&cxlds->reg_map.component_map;

Trivial: Fits on one < 80 char line.

> +	int d = cxlds->cxl_dvsec;
> +	u16 cap;
> +	int rc;
> +
> +	/* HDM decoder registers not implemented */
> +	if (!map->hdm_decoder.valid || !d)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev,
> +				  d + PCI_DVSEC_CXL_CAP, &cap);

Single line.

Why do you want this?  You are using HDM decoders, but checking the
number of ranges. Historical artifact before the HDM Decoder stuff
was added to the spec. That could really do with a rename!

In theory the spec recommends keeping these HDM ranges aligned
with the first 2 HDM decoders, but it doesn't require it and
functionally that doesn't matter so I'd not bother.

> +	if (rc)
> +		return rc;
> +
> +	*count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
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

