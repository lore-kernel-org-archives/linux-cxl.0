Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876E40856
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120164; cv=none; b=ek5rS970yX25Zh7Z2FEpQbJ60hdA1UclKDaDkGMYyBTVosVkForJmFcQ3sSFgr/OlTFTR/40rtHSDZFdFbl6H6TRt23aErZKnxvZiCCLpe4JK7actPbmjN/M1lPtIjTj/yLu0aWjWaYM/qjC2RFV0erB4DjbcVdvjfqkZDCjs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120164; c=relaxed/simple;
	bh=pTkJKPTrJxljd9mplZUMx6fDKzR+x1mjVaPqFUwT7U4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLSUcp3PlaTSjF435GNO7+b2B40cztll9v8EuqnPQm8/Qr1aZASP+xu7EbZ7YL8/9fsBXdKa9AqZYLC3NmQtiu/AUVsTJmRR8SPi064N6uYVyu4cavnCZualb27tHYywdUiVtwKvCV/mx6BycFRAyDFwkLQDg1xzWk8yyeoClak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzCLr5MxQz6HJZW;
	Tue, 11 Jun 2024 23:31:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AEB81400CD;
	Tue, 11 Jun 2024 23:35:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 16:35:52 +0100
Date: Tue, 11 Jun 2024 16:35:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v10 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
 at __rcrb_to_component()
Message-ID: <20240611163550.00003d6f@Huawei.com>
In-Reply-To: <20240611055254.61203-2-kobayashi.da-06@fujitsu.com>
References: <20240611055254.61203-1-kobayashi.da-06@fujitsu.com>
	<20240611055254.61203-2-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 11 Jun 2024 14:52:53 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_pcie_cap and its initialization at __rcrb_to_component() to cache
> the offset of cxl1.1 device link status information. By caching it, avoid 
> the walking memory map area to find the offset when output the register 
> value.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Hi. The basic functionality now looks good, but I'm not convinced by
the 'where' of the calls.  Even though it will require an additional
ioremap/iounmap() pair I don't think you should bury this in code
doing something largely unrelated.

> ---
>  drivers/cxl/core/core.h |  5 +++++
>  drivers/cxl/core/regs.c | 27 ++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h       |  9 +++++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..66778c3ce3b7 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -75,6 +75,11 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +#define RCRB_PCIECAP_LEN			0x3c
> +
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..5ce831ca05ca 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	u32 bar0, bar1;
>  	u16 cmd;
>  	u32 id;
> +	u32 cap_hdr;
> +	u16 offset;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> @@ -537,6 +539,19 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));

Similarly to below, this is putting unrelated functionality in __rcrb_to_component()
I think you need to be more smilar to cxl_rcrb_to_aer() which does it's
own iomap of the rcrb. That allows it to keep to doing just one thing.

So I would have a cxl_rcrb_to_lnkcap() and call that from 
cxl_pci_setup_regs()


> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K) {
> +			offset = 0;
> +			break;
> +		}
> +		cap_hdr = readl(addr + offset);
> +	}
> +	if (offset)
> +		ri->rcd_pcie_cap = offset;
> +
>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> @@ -572,8 +587,18 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)

This has gone from being a 'find me one of these' function to one
that does rather more inside.  Doesn't feel like the right place
to locate this capability.

I would wrap the mapping code up in a function similar to the aer_cap
code in cxl_dport_map_rch_aer() called something like
cxl_dport_map_rcd_lnkcap(), and call that directly from cxl_pci_setup_regs()
under the same check as is use for calling cxl_rcrb_get_comp_regs()


>  {
> +	resource_size_t rcd_pcie_offset, ret;
> +
>  	if (!dport->rch)
>  		return CXL_RESOURCE_NONE;
> -	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
> +
> +	ret = __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
> +	if (dport->rcrb.rcd_pcie_cap) {
> +		rcd_pcie_offset = dport->rcrb.base + dport->rcrb.rcd_pcie_cap;
> +		dport->regs.rcd_pcie_cap = devm_cxl_iomap_block(dev, rcd_pcie_offset,
> +								sizeof(u8) * RCRB_PCIECAP_LEN);
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..fc9e0dbd5932 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -230,6 +230,14 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_rch_regs, rch_regs,
>  		void __iomem *dport_aer;
>  	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -646,6 +654,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  
>  struct cxl_rcrb_info {
>  	resource_size_t base;
> +	u16 rcd_pcie_cap;
>  	u16 aer_cap;
>  };
>  

