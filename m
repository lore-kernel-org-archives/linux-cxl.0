Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D561253340;
	Thu,  1 Oct 2026 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893969; cv=none; b=TFWSAyalP7Gx7Rv0LpZ35uJPPkJXA5y+EIflyyCqKwIgKvrqcgMVep5joA3fzN/uGd+pbKdl7dYHb4uQvyBUr/R/djmlKvn0nuq1EpL0GNsOqZJXTD8/PNQ2C6XXGj8horz4zxLifBB2/2j555dJ3J642/s3YzOccozmgGMZynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893969; c=relaxed/simple;
	bh=7PibkbXh3xA/OwJnGgVcXj3KoVam4LZyHo2cKQg6cM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9et5Zc0DTmzLR3gOa226UHrsG2ei5Fv5OAhHT27bPsMes5POiRqeC5TDumfochUg4H7We9HT44Q0Rc95MRSrAsA/Uijhc9tib9vbBehKT1kXKnyKoTjxkwVsUFSfAyzQaXyOjN8ibKJUXWwMLs1ju9hQQN1A+8QkO55ZxhD7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9yorOmF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9yorOmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893967; x=1822429967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7PibkbXh3xA/OwJnGgVcXj3KoVam4LZyHo2cKQg6cM8=;
  b=G9yorOmFZvGfGx/RjwjlDvcIn1Fu3ymmnqiBICplczmPrFK4/tzw5Aeo
   Qbi2SgyD7EdRSjgfrFk2tSvyJKlzAsk4K6YylQeuDlfO0aJD7jRm4r01F
   mOAtcU1is3fRKsivNxHsHx03UbGPrvjZ9ZP0pjS/q15lp3lBWkxvmVwSF
   hmsxw2MA99GCvFDiO5cLupWuFNwW5SF0Ccj88ger0Cue1Ll3vy7E6Unah
   OZhlyVIpkyIUzQdafeK8Q3TXeTxXjwkZnbDkh0zaWmMkLwxDBfjAD9PQl
   A8yYh54rawgVoKDtAM8REmuo/6SggNzAB+qU60PJvkRq7ORU2bS9rxFUv
   g==;
X-CSE-ConnectionGUID: w0T+RyMESaKN9eoG17koCw==
X-CSE-MsgGUID: xuoZfs/CQmajrcWoaUCxaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102189484"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102189484"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:32:47 -0700
X-CSE-ConnectionGUID: FnA1GwFbRX+J0RFA2D6wLQ==
X-CSE-MsgGUID: UofenAz7SNaqmm2KOempqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="280859767"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:32:46 -0700
Message-ID: <57254762-04e8-4a98-9265-5376f75a6f3c@intel.com>
Date: Thu, 1 Oct 2026 15:32:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] sfc: add multipf support
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-5-alucerop@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001132023.17032-5-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 6:20 AM, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use CXL core accelerator API for linking a non-PF0 PF to the CXL region
> its related PF0 CXL memdev is attached to, allowing non-PF0 PF release if
> such a CXL region is released itself. This can occur in different
> scenarios like PF0 release or CXL memdev release.
> 
> Obtain the CXL HPA region to work with and the ioremap based on such
> HPA and an offset based on the PF index.
> 
> Refactor CXL initialization with different code paths for PF0 and non
> PF0 PFs.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 100 ++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 348d7404cd7a..f884580cb528 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -13,8 +13,69 @@
>  #include "efx_cxl.h"
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
>  
> -int efx_cxl_init(struct efx_probe_data *probe_data)
> +static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
> +		   u64 devfn, struct range cxl_pio_range)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	u64 cxl_pio_pf_start;
> +
> +	cxl_pio_pf_start = cxl_pio_range.start +
> +			   devfn * EFX_CTPIO_BUFFER_PER_PF_SIZE;
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
> +				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static int efx_cxl_non_pf0_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
> +	struct efx_cxl *cxl;
> +	u64 devfn;
> +
> +	devfn = PCI_FUNC(pci_dev->devfn);

I think you will want to use pci_dev->devfn directly. If you do this, devfn is 2:0 and PCI_SLOT() will evaluate to 0.

Also, does this device need to handle ARI?
> +
> +	struct pci_dev *pf0_pci_dev __free(pci_dev_put) =
> +		pci_get_slot(pci_dev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
> +
> +	/* This should not happen! */
> +	if (!pf0_pci_dev)
> +		return 0;
> +
> +	/* Is the PF0 device configured with and using CXL? */
> +	if (!pcie_is_cxl(pf0_pci_dev))
> +		return 0;
> +
> +	if (!cxl_get_range_and_link(&pf0_pci_dev->dev, &pci_dev->dev,
> +				    &cxl_pio_range))

Is this error check inverted?

DJ

> +		return  -EPROBE_DEFER;
> +
> +	cxl = kzalloc_obj(*cxl, GFP_KERNEL);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	if (cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
> +		kfree(cxl);
> +		return -ENOMEM;
> +	}
> +
> +	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;
> +
> +	return 0;
> +}
> +
> +static int efx_cxl_pf0_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> @@ -80,26 +141,47 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> -	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> -				    range_len(&cxl_pio_range));
> -	if (!cxl->ctpio_cxl) {
> -		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> -			&cxl_pio_range);
> +	if (cxl_map(probe_data, cxl, 0, cxl_pio_range))
>  		return -ENOMEM;
> -	}
>  
> -	probe_data->cxl_pio_initialised = true;
>  	probe_data->cxl = cxl;
> -
> +	probe_data->cxl_pio_initialised = true;
>  	return 0;
>  }
>  
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	u8 devfn;
> +
> +	if (efx->type->is_vf)
> +		return 0;
> +
> +	/* are we PF0? */
> +	devfn = PCI_FUNC(pci_dev->devfn);
> +	if (devfn == 0)
> +		return efx_cxl_pf0_init(probe_data);
> +	else
> +		return efx_cxl_non_pf0_init(probe_data);
> +}
> +
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	u8 devfn;
> +
>  	if (!probe_data->cxl)
>  		return;
>  
>  	iounmap(probe_data->cxl->ctpio_cxl);
> +
> +	devfn = PCI_FUNC(pci_dev->devfn);
> +	if (devfn == 0)
> +		return;
> +
> +	kfree(probe_data->cxl);
>  }
>  
>  MODULE_IMPORT_NS("CXL");

