Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741EC43217
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C4060F36
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhIMQss (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:48:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:3173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238552AbhIMQsQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 13 Sep 2021 12:48:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221776729"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221776729"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:46:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="543342047"
Received: from dvannith-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.128.229])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:46:55 -0700
Date:   Mon, 13 Sep 2021 09:46:53 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 06/13] cxl/mem: Introduce cxl_mem driver
Message-ID: <20210913164653.73u7jrc3movbszw7@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-7-ben.widawsky@intel.com>
 <CAPcyv4h8hFMWi7Rm7B_L9pk6QzLhLY5-CbrYXN9+qW-a9qCQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h8hFMWi7Rm7B_L9pk6QzLhLY5-CbrYXN9+qW-a9qCQAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-10 14:32:35, Dan Williams wrote:
> On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL endpoints that participate in the CXL.mem protocol require extra
> > control to ensure architectural constraints are met for device
> > management. The most straight-forward way to achieve control of these
> > endpoints is with a new driver that can bind to such devices. This
> > driver will also be responsible for enumerating the switches that
> > connect the endpoint to the hostbridge.
> >
> > cxl_core already understands the concept of a memdev, but the core [by
> > design] does not comprehend all the topological constraints.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  .../driver-api/cxl/memory-devices.rst         |  3 ++
> >  drivers/cxl/Makefile                          |  3 +-
> >  drivers/cxl/core/bus.c                        |  2 +
> >  drivers/cxl/core/core.h                       |  1 +
> >  drivers/cxl/core/memdev.c                     |  2 +-
> >  drivers/cxl/cxl.h                             |  1 +
> >  drivers/cxl/mem.c                             | 49 +++++++++++++++++++
> >  7 files changed, 59 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/cxl/mem.c
> >
> > diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> > index a18175bae7a6..00d141071570 100644
> > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > @@ -28,6 +28,9 @@ CXL Memory Device
> >  .. kernel-doc:: drivers/cxl/pci.c
> >     :internal:
> >
> > +.. kernel-doc:: drivers/cxl/mem.c
> > +   :doc: cxl mem
> > +
> >  CXL Core
> >  --------
> >  .. kernel-doc:: drivers/cxl/cxl.h
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index d1aaabc940f3..d912ac4e3f0c 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,9 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += core/
> > -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> > +obj-$(CONFIG_CXL_MEM) += cxl_mem.o cxl_pci.o
> 
> I'd rather now have a separate CONFIG_CXL_PCI Kconfig symbol for
> cxl_pci and let CONFIG_CXL_MEM just mean cxl_mem. I.e. maybe there
> will be a non-cxl_pci agent that registers cxl_memdev objects, or
> maybe someone will only want manageability and not CXL.mem operation
> enabled in their kernel.
> 

I would have given an argument you often use and suggest we wait until that
usage exists since later patches require both exist so that the pci driver can
give the mem driver the component register location. However, reading ahead it
sounds like that's going to have to get rewritten.

> 
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> >
> > +cxl_mem-y := mem.o
> >  cxl_pci-y := pci.o
> >  cxl_acpi-y := acpi.o
> >  cxl_pmem-y := pmem.o
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 6202ce5a5ac2..256e55dc2a3b 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -641,6 +641,8 @@ static int cxl_device_id(struct device *dev)
> >                 return CXL_DEVICE_NVDIMM_BRIDGE;
> >         if (dev->type == &cxl_nvdimm_type)
> >                 return CXL_DEVICE_NVDIMM;
> > +       if (dev->type == &cxl_memdev_type)
> > +               return CXL_DEVICE_ENDPOINT;
> 
> Perhaps CXL_DEVICE_MEMORY_{INTERFACE,EXPANDER}? "ENDPOINT" seems too generic.
> 
> >         return 0;
> >  }
> >
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index e0c9aacc4e9c..dea246cb7c58 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -6,6 +6,7 @@
> >
> >  extern const struct device_type cxl_nvdimm_bridge_type;
> >  extern const struct device_type cxl_nvdimm_type;
> > +extern const struct device_type cxl_memdev_type;
> >
> >  extern struct attribute_group cxl_base_attribute_group;
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index ee61202c7aab..c9dd054bd813 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> >         NULL,
> >  };
> >
> > -static const struct device_type cxl_memdev_type = {
> > +const struct device_type cxl_memdev_type = {
> >         .name = "cxl_memdev",
> >         .release = cxl_memdev_release,
> >         .devnode = cxl_memdev_devnode,
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 708bfe92b596..b48bdbefd949 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -315,6 +315,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
> >
> >  #define CXL_DEVICE_NVDIMM_BRIDGE       1
> >  #define CXL_DEVICE_NVDIMM              2
> > +#define CXL_DEVICE_ENDPOINT            3
> >
> >  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
> >  #define CXL_MODALIAS_FMT "cxl:t%d"
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > new file mode 100644
> > index 000000000000..978a54b0a51a
> > --- /dev/null
> > +++ b/drivers/cxl/mem.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +
> > +#include "cxlmem.h"
> > +
> > +/**
> > + * DOC: cxl mem
> > + *
> > + * CXL memory endpoint devices and switches are CXL capable devices that are
> > + * participating in CXL.mem protocol. Their functionality builds on top of the
> > + * CXL.io protocol that allows enumerating and configuring components via
> > + * standard PCI mechanisms.
> > + *
> > + * The cxl_mem driver implements enumeration and control over these CXL
> > + * components.
> > + */
> > +
> > +static int cxl_mem_probe(struct device *dev)
> > +{
> > +       return -EOPNOTSUPP;
> 
> Why not just merge this patch with the one that fills these in? I'm
> otherwise not understanding the value of having this stopping point in
> someone's future bisect run. Even commit 4cdadfd5e0a7 ("cxl/mem:
> Introduce a driver for CXL-2.0-Type-3 endpoints") had a functional
> probe.
> 

Okay. It serves no purpose for bisection. It was primarily to introduce the
drivers kdocs and hookup in core. I don't think this is a new thing for our CXL
patches, but I admit I don't pay close attention to these things.

> > +}
> > +
> > +static void cxl_mem_remove(struct device *dev)
> > +{
> > +}
> > +
> > +static struct cxl_driver cxl_mem_driver = {
> > +       .name = "cxl_mem",
> > +       .probe = cxl_mem_probe,
> > +       .remove = cxl_mem_remove,
> 
> Empty ->remove() callbacks don't need to be registered.
> 
> > +       .id = CXL_DEVICE_ENDPOINT,
> > +};
> > +
> > +static __init int cxl_mem_init(void)
> > +{
> > +       return cxl_driver_register(&cxl_mem_driver);
> > +}
> > +
> > +static __exit void cxl_mem_exit(void)
> > +{
> > +       cxl_driver_unregister(&cxl_mem_driver);
> > +}
> > +
> > +MODULE_LICENSE("GPL v2");
> > +module_init(cxl_mem_init);
> > +module_exit(cxl_mem_exit);
> 
> Perhaps, before this adds more boilerplate, go define a:
> 
> #define module_cxl_driver(__cxl_driver) \
>         module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> 
> ...as a lead-in patch?

Okay.

