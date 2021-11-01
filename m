Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAECC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AADB610E5
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKARzu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:55:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:19868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhKARzt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 13:55:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291909833"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="291909833"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:53:15 -0700
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="500139081"
Received: from ahedgesx-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 10:53:15 -0700
Date:   Mon, 1 Nov 2021 10:53:14 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211101175314.lrq3ccqkts725bjt@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com>
 <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 18:37:36, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >

[snip]

> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index cf07ae6cea17..40b386aaedf7 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += core/
> > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> 
> It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> 

Can you help me understand when CONFIG_CXL_MEM is useful when
#CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
together.

> >  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> > @@ -7,3 +8,4 @@ obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> >  cxl_pci-y := pci.o
> >  cxl_acpi-y := acpi.o
> >  cxl_pmem-y := pmem.o
> > +cxl_port-y := port.o
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index b972abc9f6ef..d61397055e9f 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -491,3 +491,4 @@ static struct platform_driver cxl_acpi_driver = {
> >  module_platform_driver(cxl_acpi_driver);
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_IMPORT_NS(CXL);
> > +MODULE_SOFTDEP("pre: cxl_port");
> 
> Why does cxl_acpi depend on cxl_port being loaded at this point? I
> think this wants to wait for a future patch where cxl_acpi uses port
> driver services.

As of this patch it does use port driver services. cxl/acpi: Map single port
host bridge component registers made that the case.

[snip]

> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > new file mode 100644
> > index 000000000000..ebbfb72ae995
> > --- /dev/null
> > +++ b/drivers/cxl/port.c
> > @@ -0,0 +1,242 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#include "cxlmem.h"
> > +
> > +/**
> > + * DOC: cxl port
> > + *
> > + * The port driver implements the set of functionality needed to allow full
> > + * decoder enumeration and routing. A CXL port is an abstraction of a CXL
> > + * component that implements some amount of CXL decoding of CXL.mem traffic.
> > + * As of the CXL 2.0 spec, this includes:
> > + *
> > + *     .. list-table:: CXL Components w/ Ports
> > + *             :widths: 25 25 50
> > + *             :header-rows: 1
> > + *
> > + *             * - component
> > + *               - upstream
> > + *               - downstream
> > + *             * - Hostbridge
> > + *               - ACPI0016
> > + *               - root port
> > + *             * - Switch
> > + *               - Switch Upstream Port
> > + *               - Switch Downstream Port
> > + *             * - Endpoint (not yet implemented)
> > + *               - Endpoint Port
> > + *               - N/A
> > + *
> > + * The primary service this driver provides is enumerating HDM decoders and
> > + * presenting APIs to other drivers to utilize the decoders.
> > + */
> > +
> > +struct cxl_port_data {
> > +       struct cxl_component_regs regs;
> > +
> > +       struct port_caps {
> > +               unsigned int count;
> > +               unsigned int tc;
> > +               unsigned int interleave11_8;
> > +               unsigned int interleave14_12;
> > +       } caps;
> > +};
> > +
> > +static inline int cxl_hdm_decoder_ig(u32 ctrl)
> 
> No need for plain inline in C files.
> 
> It's not clear why this simple helper needs a "cxl_hdm_decoder"
> namespace prefix?

I had a patch to share this with acpi driver at one point, but I dropped it. Do
you care if I merge those two decoders, or just rename?

> 
> > +{
> > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> > +
> > +       return 8 + val;
> > +}
> 
> Why is this return a power of 2 value...

I don't understand this comment.

> 
> > +
> > +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> > +{
> > +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> > +
> > +       return 1 << val;
> 
> ...while this one is converted to absolute values.
> 
> These could just be:
> 
> unsigned int to_interleave_granularity(u32 ctrl)
> unsigned int to_interleave_ways(u32 ctrl)
> 
> ...and return units in bytes.
> 
> > +}
> > +
> > +static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
> > +{
> > +       void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
> > +       struct port_caps *caps = &cpd->caps;
> > +       u32 hdm_cap;
> > +
> > +       hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> > +
> > +       caps->count = cxl_hdm_decoder_count(hdm_cap);
> > +       caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> > +       caps->interleave11_8 =
> > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> > +       caps->interleave14_12 =
> > +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> > +}
> > +
> > +static int map_regs(struct cxl_port *port, void __iomem *crb,
> > +                   struct cxl_port_data *cpd)
> > +{
> > +       struct cxl_register_map map;
> > +       struct cxl_component_reg_map *comp_map = &map.component_map;
> > +
> > +       cxl_probe_component_regs(&port->dev, crb, comp_map);
> > +       if (!comp_map->hdm_decoder.valid) {
> > +               dev_err(&port->dev, "HDM decoder registers invalid\n");
> > +               return -ENXIO;
> > +       }
> 
> Perhaps promote cxl_probe_regs() from the cxl_pci to the core and make
> it take a dev instead of a pdev, then you can do:
> 
> cxl_probe_regs(&port_dev->dev, CXL_REGLOC_RBI_COMPONENT)
> 
> ...instead of open coding it again?
> 
> > +
> > +       cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> > +
> > +       return 0;
> > +}
> > +
> > +static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
> > +{
> > +       u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
> > +
> > +       if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> > +               return 0;
> > +
> > +       return ioread64_hi_lo(hdm_decoder +
> > +                             CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
> > +}
> > +
> > +static bool is_endpoint_port(struct cxl_port *port)
> > +{
> > +       if (!port->uport->driver)
> > +               return false;
> > +
> > +       return to_cxl_drv(port->uport->driver)->id ==
> > +              CXL_DEVICE_MEMORY_EXPANDER;
> 
> Why does endpoint port device type determination need to reach through
> and read the driver type?
> 

I couldn't figure out a better way at this point in enumeration. I'm open to
suggestions.

[snip]

> > +
> > +       /*
> > +        * Enable HDM decoders for this port.
> > +        *
> > +        * FIXME: If the component was using DVSEC range registers for decode,
> > +        * this will destroy that.
> 
> Yeah, definitely need to check that before this patch can move
> forward. Perhaps a port should not even be registered if DVSEC
> Memory_Size && Mem_Enable are non zero, that device is explicitly
> opting out of being a part of the CXL 2.0 subsystem hierarchy.
> However, we might still need to track it and potentially reserve it
> out of CFMWS capacity to make sure nothing else collides with it. I'll
> also note that "ECN: Devices operating in CXL 1.1 mode with no RCRB"
> was recently published that reads on what the driver should do here.
> 

I believe we want to create the port since we might decide to reset and want
control back over it and as you said, safety check other things. The reason it
was left as a FIXME is because this belongs in the PCI driver which I didn't
really want to touch at this time. I will go back and add that for the next
version.

> > +        */
> > +       ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> > +       ctrl |= CXL_HDM_DECODER_ENABLE;
> > +       writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> 
> I feel like that if the driver finds it enabled it should leave it
> enabled at ->remove() time, as you have it here, as BIOS might not be
> expecting the OS to disable a decoder it set up. However, if the
> driver actually does the enable, then it should pair it with a disable
> at the end of time, so not a blind enable, but one that conditionally
> arranges for the unwind.

My thought was that once we enumerate a port, all of it's architectural state
belongs to the OS. For us that means blanket enable/disable. I don't feel
strongly about this.

> 
> > +
> > +       rc = enumerate_hdm_decoders(port, portdata);
> > +       if (rc) {
> > +               dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
> > +               return rc;
> > +       }
> > +
> > +       dev_set_drvdata(dev, portdata);
> > +       return 0;
> > +}
> > +
> > +static struct cxl_driver cxl_port_driver = {
> > +       .name = "cxl_port",
> > +       .probe = cxl_port_probe,
> > +       .id = CXL_DEVICE_PORT,
> > +};
> > +module_cxl_driver(cxl_port_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(CXL);
> > +MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
> > --
> > 2.33.1
> 
> Proposed infrastructure for a new cxl_port_decoder_autoremove():
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3163167ecc3a..78f8313a1069 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -374,6 +374,11 @@ static int add_root_nvdimm_bridge(struct device
> *match, void *data)
>         return 1;
>  }
> 
> +static void clear_cxl_topology_host(void *data)
> +{
> +       set_cxl_topology_host(NULL);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>         int rc;
> @@ -382,6 +387,11 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         struct acpi_device *adev = ACPI_COMPANION(host);
>         struct cxl_cfmws_context ctx;
> 
> +       set_cxl_topology_host(host);
> +       rc = devm_add_action_or_reset(host, clear_cxl_topology_host, host);
> +       if (rc)
> +               return rc;
> +
>         root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>         if (IS_ERR(root_port))
>                 return PTR_ERR(root_port);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 17a4fff029f8..3146b6aa0a2f 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -3,6 +3,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/rwsem.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -563,6 +564,84 @@ int cxl_decoder_autoremove(struct device *host,
> struct cxl_decoder *cxld)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
> 
> +void trigger_decoder_autoremove(void *data)
> +{
> +       struct cxl_decoder *cxld = data;
> +       struct device *host = get_cxl_topology_host();
> +
> +       /* The topology host driver beat us to the punch */
> +       if (!host)
> +               return;
> +
> +       devm_remove_action(host, cxld_unregister, &cxld->dev);
> +       put_cxl_topology_host(host);
> +}
> +
> +/**
> + * cxl_port_decoder_autoremove - remove decoders discovered by the port driver
> + * @cxld: decoder to remove
> + *
> + * CXL.mem requires an intact port / decoder topology from root level
> + * platform decoders to endpoint decoders. Arrange for decoders
> + * enumerated by the port driver to be removed when either the root is
> + * removed (in which the entire hierarchy is removed), or when an
> + * individual port is disabled, in which case only that port's
> + * sub-section of the hierarchy is removed.
> + */
> +int cxl_port_decoder_autoremove(struct cxl_decoder *cxld)
> +{
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       struct device *host = get_cxl_topology_host();
> +       int rc;
> +
> +       if (!host)
> +               return -ENODEV;
> +
> +       if (!port->dev.driver) {
> +               rc = -ENXIO;
> +               goto out;
> +       }
> +
> +       rc = cxl_decoder_autoremove(host, cxld);
> +       if (rc)
> +               goto out;
> +
> +       rc = devm_add_action_or_reset(&port->dev, trigger_decoder_autoremove,
> +                                       cxld);
> +out:
> +       put_cxl_topology_host(host);
> +       return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_decoder_autoremove, CXL);
> +
> +static DECLARE_RWSEM(cxl_topology_rwsem);
> +static struct device *cxl_topology_host;
> +
> +void set_cxl_topology_host(struct device *dev)
> +{
> +       down_write(&cxl_topology_rwsem);
> +       cxl_topology_host = dev;
> +       up_write(&cxl_topology_rwsem);
> +}
> +EXPORT_SYMBOL_NS_GPL(set_cxl_topology_host, CXL);
> +
> +struct device *get_cxl_topology_host(void)
> +{
> +       down_read(&cxl_topology_rwsem);
> +       if (cxl_topology_host)
> +               return cxl_topology_host;
> +       up_read(&cxl_topology_rwsem);
> +       return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(get_cxl_topology_host, CXL);
> +
> +void put_cxl_topology_host(struct device *dev)
> +{
> +       WARN_ON(dev != cxl_topology_host);
> +       up_read(&cxl_topology_rwsem);
> +}
> +EXPORT_SYMBOL_NS_GPL(put_cxl_topology_host, CXL);
> +
>  /**
>   * __cxl_driver_register - register a driver for the cxl bus
>   * @cxl_drv: cxl driver structure to attach
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5e2e93451928..bd7b008207a4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -302,6 +302,10 @@ struct cxl_decoder *cxl_decoder_alloc(struct
> cxl_port *port, int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> 
> +void set_cxl_topology_host(struct device *dev);
> +struct device *get_cxl_topology_host(void);
> +void put_cxl_topology_host(struct device *dev);
> +
>  extern struct bus_type cxl_bus_type;
> 
>  struct cxl_driver {

As you've seen by now I do implement something like that you have below in a
later patch. I believe it will still be nice to have, but I haven't read through
all of your feedback yet. So I might change my mind.
