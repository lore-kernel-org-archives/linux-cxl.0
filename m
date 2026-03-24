Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BC01CFBA;
	Tue, 24 Mar 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371421; cv=none; b=tzx1noAKzBs7Affj72knY24EMVhPKea7l3cuxsXDOSx9IYHIQ0gg5Mj4tr0LETRDa7Wt8E/OJ3r8nTM7FqqkJjKZkQarBr0XHItPi4LgDD9WlLY5lE2oOfvBHK6x4b+dYeAA2TTV/ApOhcVTSwGIDiKgR209P16FfX47EVNT7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371421; c=relaxed/simple;
	bh=Ul7TSdrlyuC9i6AALJ7cANLJMisO310wBioiNNm7LcQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFX5Rh95klH4+4nHpuPyW/v7EOc1k/4CQDLEDY17Rg7TWTlfMxiMqcwTwJtaZsoYalZFJplp48HY662YQs0eo1quvFKH8kAYElyW09eQDVnyQOGRJBStKKG7G4FuZKr4eXlC6YTVk5azSIYUHqb9zx7LqYoWjGX74M1/edCwHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgGR649WCzJ468m;
	Wed, 25 Mar 2026 00:56:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BE3BD40584;
	Wed, 25 Mar 2026 00:56:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 16:56:56 +0000
Date: Tue, 24 Mar 2026 16:56:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, Alejandro Lucero <alucerop@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: Re: [PATCH v24 09/11] sfc: obtain decoder and region if committed
 by firmware
Message-ID: <20260324165655.00006ae8@huawei.com>
In-Reply-To: <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
	<20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Mar 2026 11:31:15 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 22a7d1d95425..78f926300943 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -82,6 +83,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
> +	if (!cxl->cxled || !cxl->efx_region)
> +		return -ENODEV;
> +
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev,
> +			"CXL getting regions params from a committed decoder failed");
> +		return rc;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		return -ENOMEM;
> +	}
> +
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -89,6 +108,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +	cxl_unregister_region(probe_data->cxl->efx_region);

When something called cxl_unregister_region() is called in exit() I look for
where cxl_register_region() is....  and I can't find it (more than possible
I'm failing to search the code though!  What is this undoing?

>  }
>  
>  MODULE_IMPORT_NS("CXL");

