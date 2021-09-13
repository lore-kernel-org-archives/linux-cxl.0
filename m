Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF26C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 19:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2B061106
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 19:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhIMTii (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhIMTih (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 15:38:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF17C061574
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 12:37:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so269075pjw.2
        for <linux-cxl@vger.kernel.org>; Mon, 13 Sep 2021 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWNKHcrXqziRNxTg499rEc6v3+Y4TNDX0fEBR/NF7Qw=;
        b=iSHAWFL1vOneJuQp+WStlqmq7EGTcxjXICD466MmzECuGVMyUCbDx2kh/os642YNXF
         6rAnEDgnIxcbqm30tBW4jivH+syGZtg860umNxZIPOq0vKDpEJtlMjYMQCdmc5jfanjo
         fKY208LgN8wIVYrhfs13D6DxNsndpSSqM9lYC659LMB/McmIU4N/2y4cimW4r7WWRltY
         dr3ZlHxVacAuQnQkieomh8+MyalOKWeUyLENW7vAXEc7qiLos9VwUe86qwk4KWcWFIG4
         XKqK6q6UR5h49Mv4oempPKUd7PMoZwReVslcOG+NWQfCSEkSNB4XLmNIHRbZET9KhwkA
         8JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWNKHcrXqziRNxTg499rEc6v3+Y4TNDX0fEBR/NF7Qw=;
        b=w77fknmHj2KzXvTEJZs1ZpEtcqYcn4129NstYHDR3LkXV6OzNc4LDV+C7pJztREH7/
         dwq7SLMEDLiJCLBAHrmDrkV6QmFB/Pq/4VYvqIFeua3iXYlwiSHR74z9QbxZh3SE9QN5
         DmxiQMq9x6h+z91GI25adNYxlbh/1bBea8mSB7HSGIbFrbiHp/L4hRCclJ/BLkgytFbH
         BHzfKk2ZLtLDhLTSOIWmQ8ljiyzEsmIUILeVCHPlhH8hiD9RKcdIA/Xb40MWBeHAXFUU
         ID9smAw+HT4IBmcx2KjPRaGmowGYUDEBGLh193cDFF6GI73u+nfdu63wW7jrpStuKs4I
         rKrg==
X-Gm-Message-State: AOAM533yXL/DyA6AvuEBzYoBTKepjowGnpP5ptaZVWaRqJ6oXXhsj+OQ
        xRiq6GBY/A8z/0GPbvE9ZOtcFlEaFZ922Xv6fIKkFg==
X-Google-Smtp-Source: ABdhPJxmLXJ4G+UT4ZmSRLAYQh1g+IroPkHIn/XI7XNmjrqRPNPJYkBMfXShasZAM20jXoPlCaJtWAAZ/7kHe731AwU=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr1185763pjb.220.1631561841299;
 Mon, 13 Sep 2021 12:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-7-ben.widawsky@intel.com> <CAPcyv4h8hFMWi7Rm7B_L9pk6QzLhLY5-CbrYXN9+qW-a9qCQAw@mail.gmail.com>
 <20210913164653.73u7jrc3movbszw7@intel.com>
In-Reply-To: <20210913164653.73u7jrc3movbszw7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Sep 2021 12:37:10 -0700
Message-ID: <CAPcyv4iDxDhz_5b_fG4S3bgFPSa_HZgeS4QwQM5VqPa8N7Uspw@mail.gmail.com>
Subject: Re: [PATCH 06/13] cxl/mem: Introduce cxl_mem driver
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

On Mon, Sep 13, 2021 at 9:47 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-10 14:32:35, Dan Williams wrote:
> > On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > CXL endpoints that participate in the CXL.mem protocol require extra
> > > control to ensure architectural constraints are met for device
> > > management. The most straight-forward way to achieve control of these
> > > endpoints is with a new driver that can bind to such devices. This
> > > driver will also be responsible for enumerating the switches that
> > > connect the endpoint to the hostbridge.
> > >
> > > cxl_core already understands the concept of a memdev, but the core [by
> > > design] does not comprehend all the topological constraints.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  .../driver-api/cxl/memory-devices.rst         |  3 ++
> > >  drivers/cxl/Makefile                          |  3 +-
> > >  drivers/cxl/core/bus.c                        |  2 +
> > >  drivers/cxl/core/core.h                       |  1 +
> > >  drivers/cxl/core/memdev.c                     |  2 +-
> > >  drivers/cxl/cxl.h                             |  1 +
> > >  drivers/cxl/mem.c                             | 49 +++++++++++++++++++
> > >  7 files changed, 59 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/cxl/mem.c
> > >
> > > diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> > > index a18175bae7a6..00d141071570 100644
> > > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > > @@ -28,6 +28,9 @@ CXL Memory Device
> > >  .. kernel-doc:: drivers/cxl/pci.c
> > >     :internal:
> > >
> > > +.. kernel-doc:: drivers/cxl/mem.c
> > > +   :doc: cxl mem
> > > +
> > >  CXL Core
> > >  --------
> > >  .. kernel-doc:: drivers/cxl/cxl.h
> > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > index d1aaabc940f3..d912ac4e3f0c 100644
> > > --- a/drivers/cxl/Makefile
> > > +++ b/drivers/cxl/Makefile
> > > @@ -1,9 +1,10 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_CXL_BUS) += core/
> > > -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> > > +obj-$(CONFIG_CXL_MEM) += cxl_mem.o cxl_pci.o
> >
> > I'd rather now have a separate CONFIG_CXL_PCI Kconfig symbol for
> > cxl_pci and let CONFIG_CXL_MEM just mean cxl_mem. I.e. maybe there
> > will be a non-cxl_pci agent that registers cxl_memdev objects, or
> > maybe someone will only want manageability and not CXL.mem operation
> > enabled in their kernel.
> >
>
> I would have given an argument you often use and suggest we wait until that
> usage exists since later patches require both exist so that the pci driver can
> give the mem driver the component register location. However, reading ahead it
> sounds like that's going to have to get rewritten.

The PCI driver gives the component information to the device, not the
driver, so the driver need not be enabled to consume the component
registers.

Another alternative if you want to avoid the complexity of another
module in the near term is to move the driver into the core. I.e. make
the core a multi-driver module. The libnvdimm core uses that scheme so
it can make assumptions like "driver guaranteed to be attached after
return from device_add()" as it eliminates the asynchronous module
lookup and loading. I can see that being a useful property for the
port driver, but I think the memdev driver is ok to be either
integrated, or independent. I just don't think it belongs to the same
config as cxl_pci.

>
> >
> > >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> > >
> > > +cxl_mem-y := mem.o
> > >  cxl_pci-y := pci.o
> > >  cxl_acpi-y := acpi.o
> > >  cxl_pmem-y := pmem.o
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 6202ce5a5ac2..256e55dc2a3b 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -641,6 +641,8 @@ static int cxl_device_id(struct device *dev)
> > >                 return CXL_DEVICE_NVDIMM_BRIDGE;
> > >         if (dev->type == &cxl_nvdimm_type)
> > >                 return CXL_DEVICE_NVDIMM;
> > > +       if (dev->type == &cxl_memdev_type)
> > > +               return CXL_DEVICE_ENDPOINT;
> >
> > Perhaps CXL_DEVICE_MEMORY_{INTERFACE,EXPANDER}? "ENDPOINT" seems too generic.
> >
> > >         return 0;
> > >  }
> > >
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > index e0c9aacc4e9c..dea246cb7c58 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -6,6 +6,7 @@
> > >
> > >  extern const struct device_type cxl_nvdimm_bridge_type;
> > >  extern const struct device_type cxl_nvdimm_type;
> > > +extern const struct device_type cxl_memdev_type;
> > >
> > >  extern struct attribute_group cxl_base_attribute_group;
> > >
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index ee61202c7aab..c9dd054bd813 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> > >         NULL,
> > >  };
> > >
> > > -static const struct device_type cxl_memdev_type = {
> > > +const struct device_type cxl_memdev_type = {
> > >         .name = "cxl_memdev",
> > >         .release = cxl_memdev_release,
> > >         .devnode = cxl_memdev_devnode,
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 708bfe92b596..b48bdbefd949 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -315,6 +315,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
> > >
> > >  #define CXL_DEVICE_NVDIMM_BRIDGE       1
> > >  #define CXL_DEVICE_NVDIMM              2
> > > +#define CXL_DEVICE_ENDPOINT            3
> > >
> > >  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
> > >  #define CXL_MODALIAS_FMT "cxl:t%d"
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > new file mode 100644
> > > index 000000000000..978a54b0a51a
> > > --- /dev/null
> > > +++ b/drivers/cxl/mem.c
> > > @@ -0,0 +1,49 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > > +#include <linux/device.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include "cxlmem.h"
> > > +
> > > +/**
> > > + * DOC: cxl mem
> > > + *
> > > + * CXL memory endpoint devices and switches are CXL capable devices that are
> > > + * participating in CXL.mem protocol. Their functionality builds on top of the
> > > + * CXL.io protocol that allows enumerating and configuring components via
> > > + * standard PCI mechanisms.
> > > + *
> > > + * The cxl_mem driver implements enumeration and control over these CXL
> > > + * components.
> > > + */
> > > +
> > > +static int cxl_mem_probe(struct device *dev)
> > > +{
> > > +       return -EOPNOTSUPP;
> >
> > Why not just merge this patch with the one that fills these in? I'm
> > otherwise not understanding the value of having this stopping point in
> > someone's future bisect run. Even commit 4cdadfd5e0a7 ("cxl/mem:
> > Introduce a driver for CXL-2.0-Type-3 endpoints") had a functional
> > probe.
> >
>
> Okay. It serves no purpose for bisection. It was primarily to introduce the
> drivers kdocs and hookup in core. I don't think this is a new thing for our CXL
> patches, but I admit I don't pay close attention to these things.

It's not a major concern, but it's just an extra error message that
won't pop up in someone's bisect run.
