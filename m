Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7753E31
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291276; cv=none; b=sTyf3594D+HucAVH6WSZ/eiQajBSBkXTRpGTLtNFyLN+1irE6xM3gjMWYBL1VYRE0umgkgTqBOHZMRroAxIbMeLqCeA+MdsPpqjUwbMZBlGtlzXCToeuZThIQRZYbNjwMLG+KOPm99FupZF9TJp1N3NDiv9oVoCYqBOpY21BWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291276; c=relaxed/simple;
	bh=/cnLWSt5C75RbdrNEkuYjd+svyPXtwFI4skckvjQs5Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvtuE/UfFtpSl2HVxaom/15URb6/fM/QS4251lv3oq8AXNWJvD7Z65ueWAfUbSTFE0jvZerkiy2oyrOiQxD3IoKl5j9bb0bT540p6MEAqhIvd82C/iXO4x3egTeQLbnchw1TYdNCcv4dJqsFtiTPsmzmTXp80GMbGXTHEpTWUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Qcy5Cs3z6HJZX;
	Thu, 13 Jun 2024 23:02:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78E931400CF;
	Thu, 13 Jun 2024 23:07:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 16:07:23 +0100
Date: Thu, 13 Jun 2024 16:07:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <20240613160722.00000e67@Huawei.com>
In-Reply-To: <20240612075940.92500-2-kobayashi.da-06@fujitsu.com>
References: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
	<20240612075940.92500-2-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 16:59:38 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Getting close, but I a few PCI general things look like they are CXL
specific in here and we should fix that and some error handling
has ended up incorrect.

Jonathan


> ---
>  drivers/cxl/core/core.h |  6 ++++
>  drivers/cxl/core/regs.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       | 10 +++++++
>  drivers/cxl/pci.c       |  4 ++-
>  4 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..e71600380a22 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -74,6 +74,12 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport);
> +
> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)

> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +#define RCRB_PCIECAP_LEN		0x3c

this is normal PCI Express capability stuff.  Currently PCI doesn't
have defines for these, bt I think that's an omission rather than a feature!

So __pci_find_next_cap_ttl() for instance should use masks to get the
various fields and those should be in include/uapi/linux/pci_regs.h

I'd prefer to see that done as part of this patch set but we could move
form a local define in the c file, not this head to a global definition
in a future patch set.

I'd include a PCI_CAP_EXP_SIZEOF 0x3c
to be inline with the existing equivalents.
 
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..d86ac9c64e0c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -505,6 +505,68 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  	return offset;
>  }
>  
> +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
> +{
> +	resource_size_t rcrb = dport->rcrb.base;
> +	void __iomem *addr;
> +	u32 cap_hdr;
> +	u16 offset;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		release_mem_region(rcrb, SZ_4K);
> +		return CXL_RESOURCE_NONE;
> +	}
> +
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
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
> +		dport->rcrb.rcd_pcie_cap = offset;
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return offset;
> +}
> +
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev)
> +{
> +	void __iomem *dport_pcie_cap = NULL;
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct cxl_rcrb_info *ri;
> +	resource_size_t rcd_pcie_offset;

Local style thing: CXL tends to do reverse xmas tree.

> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	cxl_rcrb_to_linkcap(&pdev->dev, dport);
> +
> +	ri = &dport->rcrb;
> +	if (dport->rcrb.rcd_pcie_cap) {
> +		rcd_pcie_offset = ri->base + ri->rcd_pcie_cap;
> +		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev, rcd_pcie_offset,
> +						      sizeof(u8) * RCRB_PCIECAP_LEN);
sizeof(u8) isn't particularly helpful so I'd drop that.

Is the PCIECAP a different length from normal?   I'd drop the RCRB prefix if not.

> +	}
> +
> +	dport->regs.rcd_pcie_cap = dport_pcie_cap;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..8e7674c1b8f0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -512,8 +512,10 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	 * is an RCH and try to extract the Component Registers from
>  	 * an RCRB.
>  	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>  		rc = cxl_rcrb_get_comp_regs(pdev, map);
If the above errored out we should not continue.

		if (rc)
			return rc;

> +		cxl_dport_map_rcd_linkcap(pdev);

		

> +	}
	} else if (rc) {
		return rc;
	}
>  
>  	if (rc)
>  		return rc;

