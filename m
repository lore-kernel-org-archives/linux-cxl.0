Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A71C47083
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Jun 2021 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DF2613DE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Jun 2021 22:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFBWY5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:24:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:60823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBWY4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 2 Jun 2021 18:24:56 -0400
IronPort-SDR: 3d3pBldNt1Z5E3d0a2VxoQn+DQVpFQwxR0OnA/Z+Uqf8o0ULy9iH/09z7EVtxuyv29TofCIYrP
 qaBsFN4Uyphg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265087486"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="265087486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 15:23:12 -0700
IronPort-SDR: YLXsJF+FUlngUa3xak4+24uuo2DPSwBUy2mokmjGNeZC+ohhOEs7IS5l0EJXO8WJYvGLJ1kv1E
 5ryg5zt4vaZQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="447591519"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 15:23:11 -0700
Date:   Wed, 2 Jun 2021 15:23:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fixup devm_cxl_iomap_block() to take a 'struct
 device *'
Message-ID: <20210602222312.GG3697498@iweiny-DESK2.sc.intel.com>
References: <162216592374.3833641.13281743585064451514.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162216592374.3833641.13281743585064451514.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 27, 2021 at 06:39:11PM -0700, Dan Williams wrote:
> The expectation is that devm functions take 'struct device *' and pci
> functions take 'struct pci_dev *'. Swap out the @pdev argument for @dev
> and fixup related helpers.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>

LGTM, thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
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
