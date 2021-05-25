Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A7AC2B9F8
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D8E6142A
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEYKDB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 May 2021 06:03:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6705 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhEYKC7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 May 2021 06:02:59 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq8dr0VKkzlYSQ;
        Tue, 25 May 2021 17:57:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 18:01:27 +0800
Received: from localhost (10.52.120.147) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 11:01:25 +0100
Date:   Tue, 25 May 2021 10:59:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] cxl/mem: Reserve individual register block
 regions
Message-ID: <20210525105937.00000696@Huawei.com>
In-Reply-To: <20210522001154.2680157-5-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
        <20210522001154.2680157-5-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.147]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 May 2021 17:11:53 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Now that individual register blocks are mapped; those blocks regions
> should be reserved individually.
> 
> Remove general pci device management and create managed region
> reservations based on the individual register blocks.

Would be good to include a bit more of the 'reason why' in the actual
patch descriptions.  Afterall, who ever goes looking for the cover letter
after patches are applied ;)

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for V2:
> 	New patch
> ---
>  drivers/cxl/core.c | 36 ++++++++++++++++++++++++++++++++----
>  drivers/cxl/pci.c  |  6 ++----
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index add66a6ec875..ae38f17be1e7 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -74,11 +74,33 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  }
>  EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
>  
> +static void __iomem *cxl_ioremap_block(struct pci_dev *pdev,
> +				       resource_size_t addr,
> +				       resource_size_t length)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *ret_val;
> +	struct resource *res;
> +
> +	res = devm_request_mem_region(dev, addr, length, pci_name(pdev));
> +	if (!res) {
> +		dev_err(dev, "Failed to request region %#llx-%#llx\n",
> +			addr, addr+length);
> +		return NULL;
> +	}
> +
> +	ret_val = devm_ioremap(dev, addr, length);
> +	if (!ret_val)
> +		dev_err(dev, "Failed to map region %#llx-%#llx\n",
> +			addr, addr+length);
> +
> +	return ret_val;
> +}
> +
>  int cxl_map_device_regs(struct pci_dev *pdev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map)
>  {
> -	struct device *dev = &pdev->dev;
>  	resource_size_t phys_addr;
>  
>  	phys_addr = pci_resource_start(pdev, map->barno);
> @@ -90,7 +112,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.status.offset;
>  		length = map->device_map.status.size;
> -		regs->status = devm_ioremap(dev, addr, length);
> +		regs->status = cxl_ioremap_block(pdev, addr, length);
> +		if (!regs->status)
> +			return -ENOMEM;
>  	}
>  
>  	if (map->device_map.mbox.valid) {
> @@ -99,7 +123,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.mbox.offset;
>  		length = map->device_map.mbox.size;
> -		regs->mbox = devm_ioremap(dev, addr, length);
> +		regs->mbox = cxl_ioremap_block(pdev, addr, length);
> +		if (!regs->mbox)
> +			return -ENOMEM;
>  	}
>  
>  	if (map->device_map.memdev.valid) {
> @@ -108,7 +134,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.memdev.offset;
>  		length = map->device_map.memdev.size;
> -		regs->memdev = devm_ioremap(dev, addr, length);
> +		regs->memdev = cxl_ioremap_block(pdev, addr, length);
> +		if (!regs->memdev)
> +			return -ENOMEM;
>  	}
>  
>  	return 0;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3ffd5fad74b4..776cb8e28c2d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1110,6 +1110,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  			goto free_maps;
>  	}
>  
> +	pci_release_mem_regions(pdev);
> +
>  	list_for_each_entry(map, &register_maps, list) {
>  		ret = cxl_map_regs(cxlm, map);
>  		if (ret)
> @@ -1547,10 +1549,6 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_mem *cxlm;
>  	int rc;
>  
> -	rc = pcim_enable_device(pdev);
> -	if (rc)
> -		return rc;
> -
>  	cxlm = cxl_mem_create(pdev);
>  	if (IS_ERR(cxlm))
>  		return PTR_ERR(cxlm);

