Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C18FC88
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353836; cv=none; b=cN9b5wIybMgPn2vCRkdk1wxuHakRYv7CvyrbGpfXxCkeUQc1QTvY5KvEQ75tfNZFEf5KWU4ycMqnHIeSztrnjCsr9Wiw0tFka02oVqHg8QUF+NLK/blXjxbloKo7ytTTgqbqqiMdxnmP5ucWkBxd+hv5UdFfH2EMowZA1WZXDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353836; c=relaxed/simple;
	bh=IwcpzGr3uysgqt7JcJWnnB6SaETohGtCyNhLqjeHiug=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVtUK55qhzVhba8WF/OXBHR8l6XlNrrbGKg+bw/9NINJlX0cQ7BD9QW2BLWuONbE1j9kurOzEJbawh0R4r6VWNlfM31s0iGbzUw+EAUhaEzmep8xaF5m2GqZlV55zkr5rtuLRZI/Xari7P7JgQAv1GIAbwJs6TlWRuaZHsAMy30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0smT500yz6J9qS;
	Fri, 14 Jun 2024 16:25:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 00DCA1400D9;
	Fri, 14 Jun 2024 16:30:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 09:30:28 +0100
Date: Fri, 14 Jun 2024 09:30:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v12 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <20240614093027.0000251f@Huawei.com>
In-Reply-To: <20240614045611.58658-2-kobayashi.da-06@fujitsu.com>
References: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
	<20240614045611.58658-2-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 13:56:10 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Hi.

A couple more change inline.  Problem with evolving code is that as a reviewer
I sometime forget to check my expectations.  This now stores a variable
in a core structure just to use it once a few lines later. No point in keeping it.
Looking at that made me notice the error returns were wrong and unhandled.

> ---
>  drivers/cxl/core/core.h |  6 ++++
>  drivers/cxl/core/regs.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       | 10 +++++++
>  drivers/cxl/pci.c       |  7 +++--
>  4 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..69006bde7ad5 100644
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
> +#define PCI_CAP_EXP_SIZEOF		0x3c

I'd like a follow up patch making these defines apply for all usage
of these fields in the PCI core code.  Right now there are pointless
hard coded values.

>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..96c2a289cfb7 100644
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

If you hit this then the value returned will be all fs.
We are treating and offset of 0 as the error return below.

> +	}
> +
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K) {
> +			offset = 0;

			offset = CXL_RESOURCE_NONE; 

> +			break;
> +		}
> +		cap_hdr = readl(addr + offset);
> +	}
> +	if (offset)
> +		dport->rcrb.rcd_pcie_cap = offset;

As below - this storage in the rcrb structure no longer has
any purpose. We can use the returned value from this function
to get to it in the one place it is used.



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
> +	resource_size_t rcd_pcie_offset;
> +	struct cxl_rcrb_info *ri;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;
> +
> +	cxl_rcrb_to_linkcap(&pdev->dev, dport);

Sorry - with all the changes I'd missed this previously.
There is no longer any point in storing the rcd_pcie_cap
in ri.  Just use the return value from the above to fill
a local variable and map that here.

	ri = &dport->rcrb;
	rcd_pcie_offset = cxl_rcrb_to_link_cap(&pdev->dev, dpor);
	if (rcd_pcie_offset != CXL_RESOURCE_NONE)
		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev,
						      ri->base + rcd_pcie_offset,
						      PCI_CAP_EXP_SIZEOF);

	dport->regs.rcd_pcie_cap = dport_pcie_cap;

	return 0;


> +
> +	ri = &dport->rcrb;
> +	if (dport->rcrb.rcd_pcie_cap) {
> +		rcd_pcie_offset = ri->base + ri->rcd_pcie_cap;
> +		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev, rcd_pcie_offset,
> +						      PCI_CAP_EXP_SIZEOF);
> +	}
> +
> +	dport->regs.rcd_pcie_cap = dport_pcie_cap;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
> +
>  resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..b1fca98ddf8c 100644
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
> @@ -299,6 +307,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -646,6 +655,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  
>  struct cxl_rcrb_info {
>  	resource_size_t base;
> +	u16 rcd_pcie_cap;

This is no longer needed I think after the suggested change above.

>  	u16 aer_cap;
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..62343a5a39ff 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -512,10 +512,13 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	 * is an RCH and try to extract the Component Registers from
>  	 * an RCRB.
>  	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>  		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +		if (rc)
> +			return rc;
>  
> -	if (rc)
> +		cxl_dport_map_rcd_linkcap(pdev);
> +	} else if (rc)
>  		return rc;
Style wise, I'd put {} round this second leg as well.  It's common to do
this when we have a mixture of single line and multiline legs.
There are several examples of this in this file already so we should
match local style.

>  
>  	return cxl_setup_regs(map);

