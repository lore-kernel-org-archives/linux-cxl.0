Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B1AC2B9F8
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC726140E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 09:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEYJz4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 May 2021 05:55:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3943 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhEYJzk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 May 2021 05:55:40 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fq8VC4lNbzBwVY;
        Tue, 25 May 2021 17:51:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:54:06 +0800
Received: from localhost (10.52.120.147) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 10:54:03 +0100
Date:   Tue, 25 May 2021 10:52:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] cxl/mem: Map registers based on capabilities
Message-ID: <20210525105214.00005e54@Huawei.com>
In-Reply-To: <20210522001154.2680157-4-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
        <20210522001154.2680157-4-ira.weiny@intel.com>
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

On Fri, 21 May 2021 17:11:52 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The information required to map registers based on capabilities is
> contained within the bars themselves.  This means the bar must be mapped
> to read the information needed and then unmapped to map the individual
> parts of the BAR based on capabilities.
> 
> Change cxl_setup_device_regs() to return a new cxl_register_map, change
> the name to cxl_probe_device_regs().  Allocate and place
> cxl_register_maps on a list while processing all of the specified
> register blocks.
> 
> After probing all the register blocks go back and map smaller registers
> blocks based on their capabilities and dispose of the cxl_register_maps.
> 
> NOTE: pci_iomap() is not managed automatically via pcim_enable_device()
> so be careful to call pci_iounmap() correctly.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
A couple of really minor queries inline, but otherwise looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for v2:
> 	Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=pending
> 	Squash in length read from previous patch which was dropped
> 	because it was not needed in a separate patch.
> 	Adjust to changes from previous patches
> ---
>  drivers/cxl/core.c |  73 +++++++++++++++++++++++------
>  drivers/cxl/cxl.h  |  33 ++++++++++++--
>  drivers/cxl/pci.c  | 111 ++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 177 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 38979c97158d..add66a6ec875 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -3,6 +3,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include "cxl.h"
>  
>  /**
> @@ -12,19 +13,13 @@
>   * point for cross-device interleave coordination through cxl ports.
>   */
>  
> -/**
> - * cxl_setup_device_regs() - Detect CXL Device register blocks
> - * @dev: Host device of the @base mapping
> - * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
> - * @regs: Base pointers for device register blocks (see CXL_DEVICE_REGS())
> - */

Nice to keep docs given this is an exported function.

> -void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_regs *regs)
> +void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> +			   struct cxl_device_reg_map *map)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
>  
> -	*regs = (struct cxl_device_regs) { 0 };
> +	*map = (struct cxl_device_reg_map){ 0 };
>  
>  	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
>  	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> @@ -35,29 +30,38 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
>  
>  	for (cap = 1; cap <= cap_count; cap++) {
>  		void __iomem *register_block;
> -		u32 offset;
> +		u32 offset, length;
>  		u16 cap_id;
>  
>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>  				   readl(base + cap * 0x10));
>  		offset = readl(base + cap * 0x10 + 0x4);
> +		length = readl(base + cap * 0x10 + 0x8);
> +
>  		register_block = base + offset;
>  
>  		switch (cap_id) {
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> -			regs->status = register_block;
> +
> +			map->status.valid = true;
> +			map->status.offset = offset;
> +			map->status.size = length;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> -			regs->mbox = register_block;
> +			map->mbox.valid = true;
> +			map->mbox.offset = offset;
> +			map->mbox.size = length;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> -			regs->memdev = register_block;
> +			map->memdev.valid = true;
> +			map->memdev.offset = offset;
> +			map->memdev.size = length;
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -68,7 +72,48 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(cxl_setup_device_regs);
> +EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
> +
> +int cxl_map_device_regs(struct pci_dev *pdev,
> +			struct cxl_device_regs *regs,
> +			struct cxl_register_map *map)
> +{
> +	struct device *dev = &pdev->dev;
> +	resource_size_t phys_addr;
> +
> +	phys_addr = pci_resource_start(pdev, map->barno);
> +	phys_addr += map->block_offset;
> +
> +	if (map->device_map.status.valid) {
> +		resource_size_t addr;
> +		resource_size_t length;
> +
> +		addr = phys_addr + map->device_map.status.offset;
> +		length = map->device_map.status.size;
> +		regs->status = devm_ioremap(dev, addr, length);
> +	}
> +
> +	if (map->device_map.mbox.valid) {
> +		resource_size_t addr;
> +		resource_size_t length;
> +
> +		addr = phys_addr + map->device_map.mbox.offset;
> +		length = map->device_map.mbox.size;
> +		regs->mbox = devm_ioremap(dev, addr, length);
> +	}
> +
> +	if (map->device_map.memdev.valid) {
> +		resource_size_t addr;
> +		resource_size_t length;
> +
> +		addr = phys_addr + map->device_map.memdev.offset;
> +		length = map->device_map.memdev.size;
> +		regs->memdev = devm_ioremap(dev, addr, length);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_map_device_regs);
>  
>  struct bus_type cxl_bus_type = {
>  	.name = "cxl",
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d49e0cb679fa..ae4b4c96c6b5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -53,9 +53,7 @@ struct cxl_device_regs {
>  /*
>   * Note, the anonymous union organization allows for per
>   * register-block-type helper routines, without requiring block-type
> - * agnostic code to include the prefix. I.e.
> - * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
> - * The specificity reads naturally from left-to-right.
> + * agnostic code to include the prefix.
>   */
>  struct cxl_regs {
>  	union {
> @@ -66,8 +64,33 @@ struct cxl_regs {
>  	};
>  };
>  
> -void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_regs *regs);
> +struct cxl_reg_map {
> +	bool valid;
> +	unsigned long offset;
> +	unsigned long size;
> +};
> +
> +struct cxl_device_reg_map {
> +	struct cxl_reg_map status;
> +	struct cxl_reg_map mbox;
> +	struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_register_map {
> +	struct list_head list;
> +	u64 block_offset;
> +	u8 reg_type;
> +	u8 barno;
> +	union {
> +		struct cxl_device_reg_map device_map;
> +	};
> +};
> +
> +void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> +			   struct cxl_device_reg_map *map);
> +int cxl_map_device_regs(struct pci_dev *pdev,
> +			struct cxl_device_regs *regs,
> +			struct cxl_register_map *map);
>  
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33fc6e1634e3..3ffd5fad74b4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
> +#include <linux/list.h>
>  #include <linux/cdev.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> @@ -936,7 +937,7 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
>  		return IOMEM_ERR_PTR(-ENXIO);
>  	}
>  
> -	addr = pcim_iomap(pdev, bar, 0);
> +	addr = pci_iomap(pdev, bar, 0);
>  	if (!addr) {
>  		dev_err(dev, "failed to map registers\n");
>  		return addr;
> @@ -945,7 +946,12 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
>  	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
>  		bar, offset);
>  
> -	return pcim_iomap_table(pdev)[bar] + offset;
> +	return addr;
> +}
> +
> +static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
> +{
> +	pci_iounmap(cxlm->pdev, base);
>  }
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> @@ -971,6 +977,52 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
> +			  struct cxl_register_map *map)
> +{
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct cxl_device_reg_map *dev_map;
> +
> +	switch (map->reg_type) {
> +	case CXL_REGLOC_RBI_MEMDEV:
> +		dev_map = &map->device_map;
> +		cxl_probe_device_regs(dev, base, dev_map);
> +		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> +		    !dev_map->memdev.valid) {
> +			dev_err(dev, "registers not found: %s%s%s\n",
> +				!dev_map->status.valid ? "status " : "",
> +				!dev_map->mbox.valid ? "status " : "",
> +				!dev_map->memdev.valid ? "status " : "");
> +			return -ENXIO;
> +		}
> +
> +		dev_dbg(dev, "Probing device registers...\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
> +{
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct device *dev = &pdev->dev;
> +
> +	switch (map->reg_type) {
> +	case CXL_REGLOC_RBI_MEMDEV:
> +		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
> +		dev_dbg(dev, "Probing device registers...\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
>  				      u8 *bar, u64 *offset, u8 *reg_type)
>  {
> @@ -991,12 +1043,14 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
>   */
>  static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  {
> -	struct cxl_regs *regs = &cxlm->regs;
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
>  	u32 regloc_size, regblocks;
>  	void __iomem *base;
>  	int regloc, i;
> +	struct cxl_register_map *map, *n;
> +	LIST_HEAD(register_maps);
> +	int ret = 0;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
>  	if (!regloc) {
> @@ -1020,7 +1074,14 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		u64 offset;
>  		u8 bar;
>  
> -		/* "register low and high" contain other bits */
> +		map = kzalloc(sizeof(*map), GFP_KERNEL);
> +		if (!map) {
> +			ret = -ENOMEM;
> +			goto free_maps;
> +		}
> +
> +		list_add(&map->list, &register_maps);
> +
>  		pci_read_config_dword(pdev, regloc, &reg_lo);
>  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
>  
> @@ -1030,30 +1091,38 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
>  			bar, offset, reg_type);
>  
> -		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> -			base = cxl_mem_map_regblock(cxlm, bar, offset);
> -			if (!base)
> -				return -ENOMEM;
> -			break;
> +		base = cxl_mem_map_regblock(cxlm, bar, offset);
> +		if (!base) {
> +			ret = -ENOMEM;
> +			goto free_maps;
>  		}
> -	}
>  
> -	if (i == regblocks) {
> -		dev_err(dev, "Missing register locator for device registers\n");
> -		return -ENXIO;

Do we have or need an equivalent of this check somewhere else?

> +		map->barno = bar;
> +		map->block_offset = offset;
> +		map->reg_type = reg_type;
> +
> +		ret = cxl_probe_regs(cxlm, base + offset, map);
> +
> +		/* Always unmap the regblock regardless of probe success */
> +		cxl_mem_unmap_regblock(cxlm, base);
> +
> +		if (ret)
> +			goto free_maps;
>  	}
>  
> -	cxl_setup_device_regs(dev, base, &regs->device_regs);
> +	list_for_each_entry(map, &register_maps, list) {
> +		ret = cxl_map_regs(cxlm, map);
> +		if (ret)
> +			goto free_maps;
> +	}
>  
> -	if (!regs->status || !regs->mbox || !regs->memdev) {
> -		dev_err(dev, "registers not found: %s%s%s\n",
> -			!regs->status ? "status " : "",
> -			!regs->mbox ? "mbox " : "",
> -			!regs->memdev ? "memdev" : "");
> -		return -ENXIO;
> +free_maps:
> +	list_for_each_entry_safe(map, n, &register_maps, list) {
> +		list_del(&map->list);
> +		kfree(map);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static struct cxl_memdev *to_cxl_memdev(struct device *dev)

