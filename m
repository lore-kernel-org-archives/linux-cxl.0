Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D8C4708D
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F700613C9
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 11:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhE1LOY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 May 2021 07:14:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3106 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhE1LOY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 May 2021 07:14:24 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fs1yf32qlz6L5Pd;
        Fri, 28 May 2021 19:03:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 13:12:47 +0200
Received: from localhost (10.52.127.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 28 May
 2021 12:12:47 +0100
Date:   Fri, 28 May 2021 12:10:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Fixup devm_cxl_iomap_block() to take a 'struct
 device *'
Message-ID: <20210528121056.00001eaf@Huawei.com>
In-Reply-To: <162216592374.3833641.13281743585064451514.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162216592374.3833641.13281743585064451514.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.252]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 27 May 2021 18:39:11 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The expectation is that devm functions take 'struct device *' and pci
> functions take 'struct pci_dev *'. Swap out the @pdev argument for @dev
> and fixup related helpers.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Agreed, this fits better with expectations.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> base-commit: 6630d31c912ed2dfbc035caf0f54709b50ce779e
> 
>  drivers/cxl/core.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index f41a38e87606..80e6d65f8652 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -154,15 +154,14 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  }
>  EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
>  
> -static void __iomem *devm_cxl_iomap_block(struct pci_dev *pdev,
> +static void __iomem *devm_cxl_iomap_block(struct device *dev,
>  					  resource_size_t addr,
>  					  resource_size_t length)
>  {
> -	struct device *dev = &pdev->dev;
>  	void __iomem *ret_val;
>  	struct resource *res;
>  
> -	res = devm_request_mem_region(dev, addr, length, pci_name(pdev));
> +	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
>  	if (!res) {
>  		dev_err(dev, "Failed to request region %#llx-%#llx\n",
>  			addr, addr+length);
> @@ -181,6 +180,7 @@ int cxl_map_component_regs(struct pci_dev *pdev,
>  			   struct cxl_component_regs *regs,
>  			   struct cxl_register_map *map)
>  {
> +	struct device *dev = &pdev->dev;
>  	resource_size_t phys_addr;
>  	resource_size_t length;
>  
> @@ -189,7 +189,7 @@ int cxl_map_component_regs(struct pci_dev *pdev,
>  
>  	phys_addr += map->component_map.hdm_decoder.offset;
>  	length = map->component_map.hdm_decoder.size;
> -	regs->hdm_decoder = devm_cxl_iomap_block(pdev, phys_addr, length);
> +	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
>  	if (!regs->hdm_decoder)
>  		return -ENOMEM;
>  
> @@ -201,6 +201,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map)
>  {
> +	struct device *dev = &pdev->dev;
>  	resource_size_t phys_addr;
>  
>  	phys_addr = pci_resource_start(pdev, map->barno);
> @@ -212,7 +213,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.status.offset;
>  		length = map->device_map.status.size;
> -		regs->status = devm_cxl_iomap_block(pdev, addr, length);
> +		regs->status = devm_cxl_iomap_block(dev, addr, length);
>  		if (!regs->status)
>  			return -ENOMEM;
>  	}
> @@ -223,7 +224,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.mbox.offset;
>  		length = map->device_map.mbox.size;
> -		regs->mbox = devm_cxl_iomap_block(pdev, addr, length);
> +		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
>  		if (!regs->mbox)
>  			return -ENOMEM;
>  	}
> @@ -234,7 +235,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  
>  		addr = phys_addr + map->device_map.memdev.offset;
>  		length = map->device_map.memdev.size;
> -		regs->memdev = devm_cxl_iomap_block(pdev, addr, length);
> +		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
>  		if (!regs->memdev)
>  			return -ENOMEM;
>  	}
> 

