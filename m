Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39D1C84D0;
	Thu, 18 Jun 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823940; cv=none; b=KL4XzUCYaWwBcWKoxwfP+7/7TAHpdARtrhWNNNjJyY/o/UKE4Qku35oG3NJ7cXNidIDXkdn9t83gSWdvEkJQyX51Z0hG6ShnIulyTxENHfZuW2Pza49XBJH8AHU6qNhl9qkPdjShvOhgfqmN8dUcxQ725jodtfZpWchsU1gLd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823940; c=relaxed/simple;
	bh=tElRv3eJ68Z79JYMlHYB6Dj6M9qcHLm3sybTj29bNz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGZO5ChAUAqEFEthWBLSYPzSYzcYWnmoLSkMHgWpGDBfJ/GpvWFUss6wX/DlEiiPWeVyi8mnEu5jRLf/qG/I9yEMgbLpCx0M+of/9/B9Zek8NhvqvZIFMcvSn/kp/xU8rk7vQK68e5rEHKRxmbmQLOFISM9+O4sCUgfCr54Gkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iid4GY6N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iid4GY6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781823939; x=1813359939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tElRv3eJ68Z79JYMlHYB6Dj6M9qcHLm3sybTj29bNz0=;
  b=Iid4GY6Neoe9///Po7i5zLiv2PKnjodNnA2oeLDX38iiK3/e6IVKZyuh
   P83DAXRLX+/DNSO+XnAk8MjMhFal6Woyk1cDgJFLMqmKpuGUTG8Bh6khd
   lU3/OV9i+zUDSFxNDqhz0QFhW76WVY1EviDmk5TwQV9rkbz/YEnEIjxZV
   /eavapXkCOfeyDizyvLTo5iD3NWUJOy08EC5KTcmtRtKuj/XNjMeJ7v1z
   Zqra2gAU96HLmWKduwuGbDw/2VZSqEYioYeF/tX6E4dcVS6ZQ/a14B4Es
   qWyHX7NS6LCyylqm0HCoDjzesZnp7ohixbxWZdZsCDj+jdMP05OKyLNDo
   g==;
X-CSE-ConnectionGUID: oxRrAke6Q6S7mE4DnB2MJA==
X-CSE-MsgGUID: yukxw6A7QhWEf3EZvu7mzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100229741"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="100229741"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 16:05:38 -0700
X-CSE-ConnectionGUID: gvT1tbOgTzC5WNUxDHwJxw==
X-CSE-MsgGUID: ckC08dD8SbORXTGUo6I8og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="253476397"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 16:05:37 -0700
Message-ID: <3ac903a2-1a29-4c27-9cd3-72889d9769a0@intel.com>
Date: Thu, 18 Jun 2026 16:05:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 11:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/net/ethernet/sfc/efx.c     |  2 ++
>  drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index da008462096d..abfa0ce2b4d1 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
>  
>  	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
>  
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
> @@ -1244,6 +1245,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>   fail3:
>  	efx_fini_io(efx);
>   fail2:
> +	efx_cxl_exit(probe_data);
>  	efx_fini_struct(efx);
>   fail1:
>  	WARN_ON(rc > 0);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 18b535b3ea40..3e7c950f83e9 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> +				    range_len(&cxl_pio_range));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  }
>  
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +}
> +
>  MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 04e46278464d..3e2705cb063f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -20,10 +20,13 @@ struct efx_probe_data;
>  struct efx_cxl {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
> +	void __iomem *ctpio_cxl;
>  };
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>  #else
>  static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
>  #endif
>  #endif

