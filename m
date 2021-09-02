Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0DC61057
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 22:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347748AbhIBWnU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:43:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:21059 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347805AbhIBWnN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 18:43:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="199493299"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="199493299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 15:42:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="578404244"
Received: from ssirasan-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.143.121])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 15:42:05 -0700
Date:   Thu, 2 Sep 2021 15:42:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 10/13] cxl/core: Map component registers for ports
Message-ID: <20210902224204.xrcoy5secocmwfsv@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-11-ben.widawsky@intel.com>
 <20210902224110.d55rj4cce4sodo7f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902224110.d55rj4cce4sodo7f@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-02 15:41:12, Ben Widawsky wrote:
> On 21-09-02 12:50:14, Ben Widawsky wrote:
> > Component registers are implemented for CXL.mem/cache operations. The
> > cxl_pci driver handles enumerating CXL devices with the CXL.io protocol.
> > The driver for managing CXL.mem/cache operations will need the component
> > registers mapped and the mapping cannot be shared across two devices.
> > 
> > For now, it's fine to relinquish this mapping in cxl_pci. CXL IDE is one
> > exception (perhaps others will exist) where it might be desirable to
> > have the cxl_pci driver do negotiation. For this case, it probably will
> > make sense to create an ephemeral mapping. Further looking, there might
> > need to be a cxl_core mechanism to allow arbitrating access to the
> > component registers.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core/bus.c    | 38 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/memdev.c | 11 +++++++----
> >  drivers/cxl/core/regs.c   |  6 +++---
> >  drivers/cxl/cxl.h         |  4 ++++
> >  drivers/cxl/cxlmem.h      |  4 +++-
> >  drivers/cxl/mem.c         |  3 +--
> >  drivers/cxl/pci.c         | 19 +++++++++++++++++--
> >  7 files changed, 73 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index f26095b40f5c..01b6fa8373e4 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -310,6 +310,37 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
> >  	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
> >  }
> >  
> > +static int cxl_port_map_component_registers(struct cxl_port *port)
> > +{
> > +	struct cxl_register_map map;
> > +	struct cxl_component_reg_map *comp_map = &map.component_map;
> > +	void __iomem *crb;
> > +
> > +	if (port->component_reg_phys == CXL_RESOURCE_NONE)
> > +		return 0;
> > +
> > +	crb = devm_cxl_iomap_block(&port->dev,
> > +				   port->component_reg_phys,
> > +				   /* CXL_COMPONENT_REG_BLOCK_SIZE */ SZ_64K);
> 
> I meant to fix this before sending...
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 55c8440dfe00..0243d9a7fe3a 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -454,7 +454,7 @@ static int cxl_port_map_component_registers(struct cxl_port *port)
> 
>         crb = devm_cxl_iomap_block(&port->dev,
>                                    port->component_reg_phys,
> -                                  /* CXL_COMPONENT_REG_BLOCK_SIZE */ SZ_64K);
> +                                  CXL_COMPONENT_REG_BLOCK_SIZE);
>         if (IS_ERR(crb))
>                 return PTR_ERR(crb);
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e06b1f7d1419..dbbda32ca055 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -17,8 +17,12 @@
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
> 
> +/* CXL 2.0 8.2.4 Table 141 Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>  #define CXL_CM_OFFSET 0x1000
> +#define CXL_CM_SIZE SZ_64K

doh. Ignore.

>  #define CXL_CM_CAP_HDR_OFFSET 0x0
>  #define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
>  #define     CM_CAP_HDR_CAP_ID 1
> 
> > +	if (IS_ERR(crb))
> > +		return PTR_ERR(crb);
> > +
> > +	if (!crb) {
> > +		dev_err(&port->dev, "No component registers mapped\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	cxl_probe_component_regs(&port->dev, crb, comp_map);
> > +	if (!comp_map->hdm_decoder.valid) {
> > +		dev_err(&port->dev, "HDM decoder registers invalid\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	port->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> > +
> > +	return 0;
> > +}
> > +
> >  static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  				       resource_size_t component_reg_phys,
> >  				       struct cxl_port *parent_port)
> > @@ -398,6 +429,13 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > +	/* Platform "switch" has no parent port or component registers */
> > +	if (parent_port) {
> > +		rc = cxl_port_map_component_registers(port);
> > +		if (rc)
> > +			return ERR_PTR(rc);
> > +	}
> > +
> >  	return port;
> >  
> >  err:
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 0068b5ff5f3e..85fe42abd29b 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -185,7 +185,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
> >  }
> >  
> >  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
> > -					   const struct file_operations *fops)
> > +					   const struct file_operations *fops,
> > +					   unsigned long component_reg_phys)
> >  {
> >  	struct cxl_memdev *cxlmd;
> >  	struct device *dev;
> > @@ -200,6 +201,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
> >  	if (rc < 0)
> >  		goto err;
> >  	cxlmd->id = rc;
> > +	cxlmd->component_reg_phys = component_reg_phys;
> >  
> >  	dev = &cxlmd->dev;
> >  	device_initialize(dev);
> > @@ -275,15 +277,16 @@ static const struct file_operations cxl_memdev_fops = {
> >  	.llseek = noop_llseek,
> >  };
> >  
> > -struct cxl_memdev *
> > -devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm)
> > +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> > +				       struct cxl_mem *cxlm,
> > +				       unsigned long component_reg_phys)
> >  {
> >  	struct cxl_memdev *cxlmd;
> >  	struct device *dev;
> >  	struct cdev *cdev;
> >  	int rc;
> >  
> > -	cxlmd = cxl_memdev_alloc(cxlm, &cxl_memdev_fops);
> > +	cxlmd = cxl_memdev_alloc(cxlm, &cxl_memdev_fops, component_reg_phys);
> >  	if (IS_ERR(cxlmd))
> >  		return cxlmd;
> >  
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 8535a7b94f28..4ba75fb6779f 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -145,9 +145,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
> >  
> > -static void __iomem *devm_cxl_iomap_block(struct device *dev,
> > -					  resource_size_t addr,
> > -					  resource_size_t length)
> > +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > +				   resource_size_t length)
> >  {
> >  	void __iomem *ret_val;
> >  	struct resource *res;
> > @@ -166,6 +165,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
> >  
> >  	return ret_val;
> >  }
> > +EXPORT_SYMBOL_GPL(devm_cxl_iomap_block);
> >  
> >  int cxl_map_component_regs(struct pci_dev *pdev,
> >  			   struct cxl_component_regs *regs,
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a168520d741b..4585d03a0a67 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -149,6 +149,8 @@ struct cxl_register_map {
> >  	};
> >  };
> >  
> > +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > +				   resource_size_t length);
> >  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> >  			      struct cxl_component_reg_map *map);
> >  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> > @@ -252,6 +254,7 @@ struct cxl_walk_context {
> >   * @dports: cxl_dport instances referenced by decoders
> >   * @decoder_ida: allocator for decoder ids
> >   * @component_reg_phys: component register capability base address (optional)
> > + * @regs: Mapped version of @component_reg_phys
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -260,6 +263,7 @@ struct cxl_port {
> >  	struct list_head dports;
> >  	struct ida decoder_ida;
> >  	resource_size_t component_reg_phys;
> > +	struct cxl_component_regs regs;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88264204c4b9..f94624e43b2e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -41,6 +41,7 @@ struct cxl_memdev {
> >  	struct cdev cdev;
> >  	struct cxl_mem *cxlm;
> >  	int id;
> > +	unsigned long component_reg_phys;
> >  };
> >  
> >  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> > @@ -49,7 +50,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> >  }
> >  
> >  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> > -				       struct cxl_mem *cxlm);
> > +				       struct cxl_mem *cxlm,
> > +				       unsigned long component_reg_phys);
> >  
> >  bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
> >  
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 9d5a3a29cda1..aba9a07d519f 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -73,9 +73,8 @@ static int cxl_mem_probe(struct device *dev)
> >  	if (!port_dev)
> >  		return -ENODEV;
> >  
> > -	/* TODO: Obtain component registers */
> >  	rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,
> > -					       CXL_RESOURCE_NONE,
> > +					       cxlmd->component_reg_phys,
> >  					       to_cxl_port(port_dev)));
> >  	if (rc)
> >  		dev_err(dev, "Unable to add devices upstream port");
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index e4b3549c4580..258190febb5a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -382,8 +382,12 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
> >  
> >  	switch (map->reg_type) {
> >  	case CXL_REGLOC_RBI_COMPONENT:
> > +#ifndef CONFIG_CXL_MEM
> >  		cxl_map_component_regs(pdev, &cxlm->regs.component, map);
> >  		dev_dbg(dev, "Mapping component registers...\n");
> > +#else
> > +		dev_dbg(dev, "Component registers not mapped for %s\n", KBUILD_MODNAME);
> > +#endif
> >  		break;
> >  	case CXL_REGLOC_RBI_MEMDEV:
> >  		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
> > @@ -493,10 +497,11 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm, struct cxl_register_map maps
> >  
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	unsigned long component_reg_phys = CXL_RESOURCE_NONE;
> >  	struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_mem *cxlm;
> > -	int rc;
> > +	int rc, i;
> >  
> >  	/*
> >  	 * Double check the anonymous union trickery in struct cxl_regs
> > @@ -533,7 +538,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm);
> > +	for (i = 0; i < ARRAY_SIZE(maps); i++) {
> > +		struct cxl_register_map *map = &maps[i];
> > +
> > +		if (map->reg_type != CXL_REGLOC_RBI_COMPONENT)
> > +			continue;
> > +
> > +		component_reg_phys = pci_resource_start(pdev, map->barno) +
> > +				     map->block_offset;
> > +	}
> > +
> > +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm, component_reg_phys);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > -- 
> > 2.33.0
> > 
