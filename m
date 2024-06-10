Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503AA953
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016210; cv=none; b=s9b8mjXKFD5cEBxOyeruPdG83UTjrtg7VZDesJmn8GSf+nRmapWDWZRUNzgvphItyxoJPQGEpTvEwsNMgb+4NqIWEhB4Sf9PyM5FGkawCGaVB8aKgVKqot8SbMDpLTq4A4O/+cNEPqu5C+L3drT55RD7BBOcYO/LgnEbCUved94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016210; c=relaxed/simple;
	bh=5WntI0ShJWcHSAd/jxwASZn0VwfiVnTDWSDsLw26WVk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAz65VZ1UaMgPuwJZzgf5kUe3r7ggHjqUMYeVmDt6zT85fXOGl2H8lNFyoMFmzD2Xqp9HU2uWGtKM4eAm8SXb94biyN5N8HqZAVessOL1ObVa+HdTMcteiOzXXA0usBksG7Ec51ABHWwwZgbzL2oGOk3TmlzqyJ3lNWCWS1l/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VySzd6GPTz6K98D;
	Mon, 10 Jun 2024 18:42:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C697140B2F;
	Mon, 10 Jun 2024 18:43:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 11:43:23 +0100
Date: Mon, 10 Jun 2024 11:43:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
 at __rcrb_to_component()
Message-ID: <20240610114322.000031b8@Huawei.com>
In-Reply-To: <20240610082222.22772-2-kobayashi.da-06@fujitsu.com>
References: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
	<20240610082222.22772-2-kobayashi.da-06@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 17:22:21 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_pcie_cap and its initialization at __rcrb_to_component() to cache
> the offset of cxl1.1 device link status information. By caching it, avoid 
> the walking memory map area to find the offset when output the register value.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Hi.

This is getting closer, but a few minor comments inline on the implementation.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/core.h |  4 ++++
>  drivers/cxl/core/regs.c | 26 +++++++++++++++++++++++++-
>  drivers/cxl/cxl.h       |  9 +++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..42e3483b4a14 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -75,6 +75,10 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..cc1ce5e032e2 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	u32 bar0, bar1;
>  	u16 cmd;
>  	u32 id;
> +	u16 offset;
> +	u32 cap_hdr;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> @@ -537,6 +539,17 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K)
> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}
> +	if (offset)
If offset > SZ_4K?  

I'd make it 0 at the check inside the loop.

> +		ri->rcd_pcie_cap = offset;
> +
>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> @@ -572,8 +585,19 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
>  {
> +	void __iomem *dport_pcie_cap = NULL;
> +	resource_size_t rcd_pcie_offset, ret;
blank line here.

I'd also reduce the scope of rcd_pcie_offset.

>  	if (!dport->rch)
>  		return CXL_RESOURCE_NONE;
> -	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
> +
> +	ret = __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
> +	if (dport->rcrb.rcd_pcie_cap) {
> +		rcd_pcie_offset = dport->rcrb.base + dport->rcrb.rcd_pcie_cap;
> +		dport_pcie_cap = devm_cxl_iomap_block(dev, rcd_pcie_offset,
> +											  sizeof(u8) * 0x42);

Something odd here with alignment. I guess tab width 4 rather than 8 in your editor?
Also, add a define for the 0x42 I think.

Directly assign into dport->regs.rcd_pcie_cap having made change suggested below.



> +	}
> +	dport->regs.rcd_pcie_cap = dport_pcie_cap;
Why not move this in the brackets?  I think you can rely on the regs
structuring being initialized to zero for the 'else' path.

> +
> +	return ret;
>  }

>  

