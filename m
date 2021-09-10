Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD043C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1AC61215
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhIJXpY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhIJXpX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 19:45:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058CC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:44:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q68so3236922pga.9
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFPkdSNVgj9vtS+WUWiMeNuhEc93rsrIiq6pyOPdHgk=;
        b=dcEYfMkHFKasGE/iGvwqLL1StrC7IdbxmO3/8ohq/fFXgyqyyMAH3n7eeEJnGEWoGd
         iySRHMoYmxkBsKS+kJMkZENQfVR5tAEkDPmuLDCLsCDEvYpbdToxvlIcvBuDqV5RcmEv
         Fbe1XfrCq9eDeG1lIRsk8/MCoU0oIfcYJMOsKK4flC8SuFaLSbkUn8rMo86kQZuyU5xv
         Pe50z4w8vheb9FNT12ezJMMMqybQ8HMhuDcn2nW7e/RX0LDR9zInELN6nTo65yBsaBHs
         5TEpQIkZUa6/XLsSJgC8R0LTbLCIKc9hk69f/XR0i+Rc5IDWrdNAuS8wQbAG9vtN9X08
         jAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFPkdSNVgj9vtS+WUWiMeNuhEc93rsrIiq6pyOPdHgk=;
        b=fGNW/zkOlhnPEf1hWr4euFaebngrm6jr0rUVl45BZ92h8VQxa4yyCXJJdz5KWhXnyl
         0q8h+cKKqNTipgGQumoAVdBeW+GvBXuFVqSuCcnhTEt9TMoq4auh5y/DyK9/Jf2v5hcl
         TTLHhzUlyasaadjKhmW/vvEaCQbinuGAb0FrJZKPCkXvt6O0V8Ua7RnKhgsNbGGo48dM
         3MoG/W5dqMJ86P1NF+ZUqFv1NNcxdLGItSrLGJ1pYnu+0ZnWOPBwca2JE42eM+iOdOq8
         ljCiBe0qGiFjSxpO+yhQF0pyarEGovl6wr3C/fY1p20h1XNQrCyRqXG1lKfeTjIwmqGp
         ZgdQ==
X-Gm-Message-State: AOAM533Jwy35KxWj0uu94S1LVsqhI2OwNiqDOEZOTYQDWPyc/KHAiW0R
        pS1ihGb25fExEFnUqtGjjvAjzyvaqQQjxWj55MvUkg==
X-Google-Smtp-Source: ABdhPJyMAuRlUzLP2LY5Tb/FbzT/HpCnNfzvOTck7WP6vLC099VEHT9AysxwCvv17OgRNNXovUJ0A99IDprlYCXgx74=
X-Received: by 2002:a63:3545:: with SMTP id c66mr180872pga.377.1631317451812;
 Fri, 10 Sep 2021 16:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-11-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-11-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 16:44:00 -0700
Message-ID: <CAPcyv4h_cd_jhkJVm6d0vVZfGDem65+KgzhUKcE0O_6Hr4ANTg@mail.gmail.com>
Subject: Re: [PATCH 10/13] cxl/core: Map component registers for ports
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Component registers are implemented for CXL.mem/cache operations. The
> cxl_pci driver handles enumerating CXL devices with the CXL.io protocol.
> The driver for managing CXL.mem/cache operations will need the component
> registers mapped and the mapping cannot be shared across two devices.
>
> For now, it's fine to relinquish this mapping in cxl_pci. CXL IDE is one
> exception (perhaps others will exist) where it might be desirable to
> have the cxl_pci driver do negotiation. For this case, it probably will
> make sense to create an ephemeral mapping. Further looking, there might
> need to be a cxl_core mechanism to allow arbitrating access to the
> component registers.

My reaction to this is to make a single driver responsible for all
component capabilities, don't try to share. If another agent wants to
interact with those registers it must do so through an API provided by
that driver. In this case this seems to want a cxl_port driver.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c | 11 +++++++----
>  drivers/cxl/core/regs.c   |  6 +++---
>  drivers/cxl/cxl.h         |  4 ++++
>  drivers/cxl/cxlmem.h      |  4 +++-
>  drivers/cxl/mem.c         |  3 +--
>  drivers/cxl/pci.c         | 19 +++++++++++++++++--
>  7 files changed, 73 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index f26095b40f5c..01b6fa8373e4 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -310,6 +310,37 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
>         return devm_add_action_or_reset(host, cxl_unlink_uport, port);
>  }
>
> +static int cxl_port_map_component_registers(struct cxl_port *port)
> +{
> +       struct cxl_register_map map;
> +       struct cxl_component_reg_map *comp_map = &map.component_map;
> +       void __iomem *crb;
> +
> +       if (port->component_reg_phys == CXL_RESOURCE_NONE)
> +               return 0;
> +
> +       crb = devm_cxl_iomap_block(&port->dev,
> +                                  port->component_reg_phys,
> +                                  /* CXL_COMPONENT_REG_BLOCK_SIZE */ SZ_64K);

Unless this is being called by a driver for @port->dev then this leaks
the mapping longer than is necessary. The devres_release_all()
callback is triggered after device->driver->remove() and in
device_release().

> +       if (IS_ERR(crb))
> +               return PTR_ERR(crb);
> +
> +       if (!crb) {
> +               dev_err(&port->dev, "No component registers mapped\n");
> +               return -ENXIO;
> +       }
> +
> +       cxl_probe_component_regs(&port->dev, crb, comp_map);
> +       if (!comp_map->hdm_decoder.valid) {
> +               dev_err(&port->dev, "HDM decoder registers invalid\n");
> +               return -ENXIO;
> +       }
> +
> +       port->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> +
> +       return 0;
> +}
> +
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
>                                        resource_size_t component_reg_phys,
>                                        struct cxl_port *parent_port)
> @@ -398,6 +429,13 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>         if (rc)
>                 return ERR_PTR(rc);
>
> +       /* Platform "switch" has no parent port or component registers */
> +       if (parent_port) {
> +               rc = cxl_port_map_component_registers(port);

I don't think this belongs here. Lets keep all register mapping in
drivers, and add a port driver for component register services while
the port is enabled.

> +               if (rc)
> +                       return ERR_PTR(rc);
> +       }
> +
>         return port;
>
>  err:
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0068b5ff5f3e..85fe42abd29b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -185,7 +185,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  }
>
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
> -                                          const struct file_operations *fops)
> +                                          const struct file_operations *fops,
> +                                          unsigned long component_reg_phys)
>  {
>         struct cxl_memdev *cxlmd;
>         struct device *dev;
> @@ -200,6 +201,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
>         if (rc < 0)
>                 goto err;
>         cxlmd->id = rc;
> +       cxlmd->component_reg_phys = component_reg_phys;
>
>         dev = &cxlmd->dev;
>         device_initialize(dev);
> @@ -275,15 +277,16 @@ static const struct file_operations cxl_memdev_fops = {
>         .llseek = noop_llseek,
>  };
>
> -struct cxl_memdev *
> -devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm)
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +                                      struct cxl_mem *cxlm,
> +                                      unsigned long component_reg_phys)
>  {
>         struct cxl_memdev *cxlmd;
>         struct device *dev;
>         struct cdev *cdev;
>         int rc;
>
> -       cxlmd = cxl_memdev_alloc(cxlm, &cxl_memdev_fops);
> +       cxlmd = cxl_memdev_alloc(cxlm, &cxl_memdev_fops, component_reg_phys);

Apologies, the dvsec walking in the previous patch made me think you
were going to re-discover component registers in the cxl_memdev
driver. Ignore that implication, this looks good.

>         if (IS_ERR(cxlmd))
>                 return cxlmd;
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 8535a7b94f28..4ba75fb6779f 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -145,9 +145,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  }
>  EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
>
> -static void __iomem *devm_cxl_iomap_block(struct device *dev,
> -                                         resource_size_t addr,
> -                                         resource_size_t length)
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +                                  resource_size_t length)
>  {
>         void __iomem *ret_val;
>         struct resource *res;
> @@ -166,6 +165,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
>
>         return ret_val;
>  }
> +EXPORT_SYMBOL_GPL(devm_cxl_iomap_block);
>
>  int cxl_map_component_regs(struct pci_dev *pdev,
>                            struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a168520d741b..4585d03a0a67 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -149,6 +149,8 @@ struct cxl_register_map {
>         };
>  };
>
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +                                  resource_size_t length);
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>                               struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -252,6 +254,7 @@ struct cxl_walk_context {
>   * @dports: cxl_dport instances referenced by decoders
>   * @decoder_ida: allocator for decoder ids
>   * @component_reg_phys: component register capability base address (optional)
> + * @regs: Mapped version of @component_reg_phys
>   */
>  struct cxl_port {
>         struct device dev;
> @@ -260,6 +263,7 @@ struct cxl_port {
>         struct list_head dports;
>         struct ida decoder_ida;
>         resource_size_t component_reg_phys;
> +       struct cxl_component_regs regs;
>  };
>
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88264204c4b9..f94624e43b2e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -41,6 +41,7 @@ struct cxl_memdev {
>         struct cdev cdev;
>         struct cxl_mem *cxlm;
>         int id;
> +       unsigned long component_reg_phys;
>  };
>
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -49,7 +50,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
>  }
>
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -                                      struct cxl_mem *cxlm);
> +                                      struct cxl_mem *cxlm,
> +                                      unsigned long component_reg_phys);
>
>  bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9d5a3a29cda1..aba9a07d519f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -73,9 +73,8 @@ static int cxl_mem_probe(struct device *dev)
>         if (!port_dev)
>                 return -ENODEV;
>
> -       /* TODO: Obtain component registers */
>         rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,
> -                                              CXL_RESOURCE_NONE,
> +                                              cxlmd->component_reg_phys,
>                                                to_cxl_port(port_dev)));
>         if (rc)
>                 dev_err(dev, "Unable to add devices upstream port");
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e4b3549c4580..258190febb5a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -382,8 +382,12 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
>
>         switch (map->reg_type) {
>         case CXL_REGLOC_RBI_COMPONENT:
> +#ifndef CONFIG_CXL_MEM

Argh, please no ifdef outside of header. Not even sure why this is
needed. cxl_pci has no use for the component registers, so I would
just expect this case to be deleted altogether.

In fact I don't even think we need to use a struct_group() anymore
with a separate cxl_port driver.

>                 cxl_map_component_regs(pdev, &cxlm->regs.component, map);
>                 dev_dbg(dev, "Mapping component registers...\n");
> +#else
> +               dev_dbg(dev, "Component registers not mapped for %s\n", KBUILD_MODNAME);
> +#endif
>                 break;
>         case CXL_REGLOC_RBI_MEMDEV:
>                 cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
> @@ -493,10 +497,11 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm, struct cxl_register_map maps
>
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +       unsigned long component_reg_phys = CXL_RESOURCE_NONE;
>         struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
>         struct cxl_memdev *cxlmd;
>         struct cxl_mem *cxlm;
> -       int rc;
> +       int rc, i;
>
>         /*
>          * Double check the anonymous union trickery in struct cxl_regs
> @@ -533,7 +538,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (rc)
>                 return rc;
>
> -       cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm);
> +       for (i = 0; i < ARRAY_SIZE(maps); i++) {
> +               struct cxl_register_map *map = &maps[i];
> +
> +               if (map->reg_type != CXL_REGLOC_RBI_COMPONENT)
> +                       continue;
> +
> +               component_reg_phys = pci_resource_start(pdev, map->barno) +
> +                                    map->block_offset;
> +       }
> +
> +       cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm, component_reg_phys);

Perhaps squash this patch with the one that keeps the register map
around longer, I got confused by the lack of diff context about where
devm_cxl_add_memdev() could intercept pulling out the information it
needs.

>         if (IS_ERR(cxlmd))
>                 return PTR_ERR(cxlmd);
>
> --
> 2.33.0
>
