Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C922C4338F
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F071F610F7
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 02:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhHNCUG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Aug 2021 22:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHNCUG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Aug 2021 22:20:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFDCC061756
        for <linux-cxl@vger.kernel.org>; Fri, 13 Aug 2021 19:19:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso18625548pjb.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Aug 2021 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MTMVAL8TYiKFp9EAmX/wctyTdEF/FBSwyd0a/8Yo0I=;
        b=dl4ORpFceBI5Df7wDHzKwp9V2KzGkHImeCT3a4/lPraZD9+WfVhGIZPXlNUjenUod8
         Nvy9ncpWKe0mnFZWRwCjFDzzHkSZ/3+wDkt/bFCSD1l3SSIuZjBoF2eKXDkyzoyhLQZp
         Pxyom7XqHBsrm+pMd7YPt0N05rq54m5UEpb/j6pNk5mIQO0w8vEfQxTarpMJre3MfF81
         ZpknnPnIcFZfJtbreQ3YNDqCDIxoVSQa7LHz99gN0GU9wG1hcw2WL6iXLT+XJw5H5YjJ
         WcP1hXaMC25Eqrlps4gGMiXCXWUuJVbrBlGxpeqZ17ja95dTokmC9eOoRfL2whSStut8
         hfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MTMVAL8TYiKFp9EAmX/wctyTdEF/FBSwyd0a/8Yo0I=;
        b=crMMURHjg577qKOoKEZ5Ptq+mDCQERBqGkbOGE+Bnt6zQsV0ZUKIIXZWSSGKvJ/g+u
         QbQ7NZv/V3e4U0g85pxhQiVTupogz8u0CP4GnARes6/J0m91RTkN3ltenViD7UmFcOKy
         1BWdaRRXySl3iYc9LdvSdjWmSFp2fMRKOztglZMR067uw7ZLHDUI2H/wVq63wDjUf9c5
         eZl3t9k3qQkJBIPDWKpIF3bBH2WZLxyudE1z7ZBEfPDyF2FfMxU51Jf6dk3Ix/cMVP3V
         nicjLdJjFWXA7b4oBInBoCe8ea3ILvE3TRdoAQOZhr32UNuLXwo+bFhya/md0SEOvmd6
         pcVA==
X-Gm-Message-State: AOAM530aHW+sNiKKge8QdjAHrtLgRFDpTwnGLHue1Wk89UivMp77Lw48
        SK6NaaSPDEtZ3Pn1JqRGsjGj0F7fGiWwxMZfXGpCMw==
X-Google-Smtp-Source: ABdhPJymr7J244Za/Ip00bt6oa/46wfXYoHNw59kcBqKEW+Uz42iZP0rb+36Fji5R+XnTBpHmrDv8IWZ8HKqWSywi+8=
X-Received: by 2002:a17:902:e545:b0:12d:7e4e:ac28 with SMTP id
 n5-20020a170902e54500b0012d7e4eac28mr4248412plf.79.1628907578072; Fri, 13 Aug
 2021 19:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210723210623.114073-1-ben.widawsky@intel.com> <20210723210623.114073-13-ben.widawsky@intel.com>
In-Reply-To: <20210723210623.114073-13-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Aug 2021 19:19:28 -0700
Message-ID: <CAPcyv4g_VBTAo1VQ5V_rFCJT=30_ujqOqnpPMdhZKmOonMbp3Q@mail.gmail.com>
Subject: Re: [PATCH 12/23] cxl/region: Add region creation ABI
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

On Fri, Jul 23, 2021 at 2:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Regions are created as a child of the decoder that encompasses an
> address space with constraints. Regions only exist for persistent
> capacities.

Maybe I am misinterpreting, but regions need to exist for volatile
capacities too, otherwise what's the interface for enumerating and
reconfiguring volatile interleaves? The only difference is one is
recorded in labels.

Perhaps before creating regions we should write the code to enumerate
volatile regions that might be present since boot. We'll need that
anyway to determine how much CFMWS space is available for dynamic
creation. Once happy with the read side then proceed to the write
side. Thoughts?

>
> When regions are created, the number of desired interleave ways must be
> known. To enable this, the sysfs attribute will take the desired ways as
> input. This interface intentionally allows creation of
> impossible-to-enable regions based on interleave constraints in the
> topology. The reasoning is to create new regions through the kernel
> interfaces which may become possible on reboot under a variety of
> circumstances.
>
> As an example, creating a x1 region with:
> echo 1 > /sys/bus/cxl/devices/decoder0.0/create_region

This proposal has lost its luster for me since I last saw it, and I
must belatedly apologize to you and Jonathan for not internalizing his
critique of this. My previous concern [1] was that tooling would be
surprised by sysfs_update_group() causing attributes to pop into
existence. However, I think the asymmetry is more surprising,
especially when it comes to reconfiguring an existing interleave to be
a different width. There should just be one sysfs attribute that
controls the width of a region.

This allows for additional symmetry where userspace must explicitly
request the next region device name, like so:

# region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
# echo $region
region0.0:0
# echo $region > /sys/bus/cxl/devices/decoder0.0/create_region

If userspace races itself 2 threads will attempt
# echo region0.0:0 > /sys/bus/cxl/devices/decoder0.0/create_region
...and one thread will win. This solves the long standing "next seed"
problem (in libnvdimm and device-dax) with a way to atomically get the
next region, and send colliding threads to create another region.


[1]: https://lore.kernel.org/r/CAPcyv4iF1m+xGMaph+K8VJ0+tCvUML9-pUuAWymXoOrvY1jV1w@mail.gmail.com


>
> Will yield /sys/bus/cxl/devices/decoder0.0/region0.0:0
>
> That region may then be deleted with:
> echo region0.0:0 > /sys/bus/cxl/devices/decoder0.0/delete_region
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  21 +++
>  .../driver-api/cxl/memory-devices.rst         |  11 ++
>  drivers/cxl/Makefile                          |   1 +
>  drivers/cxl/core/Makefile                     |   2 +-
>  drivers/cxl/core/bus.c                        |  70 ++++++++
>  drivers/cxl/core/core.h                       |   1 +
>  drivers/cxl/core/region.c                     | 158 ++++++++++++++++++
>  drivers/cxl/cxl.h                             |  14 ++
>  drivers/cxl/region.h                          |  30 ++++
>  9 files changed, 307 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cxl/core/region.c
>  create mode 100644 drivers/cxl/region.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 0b6a2e6e8fbb..115a25d2899d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -127,3 +127,24 @@ Description:
>                 memory (type-3). The 'target_type' attribute indicates the
>                 current setting which may dynamically change based on what
>                 memory regions are activated in this decode hierarchy.
> +
> +What:          /sys/bus/cxl/devices/decoderX.Y/create_region
> +Date:          June, 2021
> +KernelVersion: v5.14
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               Creates a new CXL region of N interleaved ways. Writing a value
> +               of '2' will create a new uninitialized region with 2x interleave
> +               that will be mapped by the CXL decoderX.Y. Reading from this
> +               node will return the last created region. Regions must be
> +               subsequently configured and bound to a region driver before they
> +               can be used.
> +
> +What:          /sys/bus/cxl/devices/decoderX.Y/delete_region
> +Date:          June, 2021
> +KernelVersion: v5.14
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               Deletes the named region. A region must be unbound from the
> +               region driver before being deleted. The attributes expects a
> +               region in the form "regionX.Y:Z".
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 46847d8c70a0..96a1f8be7940 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -45,6 +45,17 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/core/regs.c
>     :internal:
>
> +CXL Regions
> +-----------
> +.. kernel-doc:: drivers/cxl/region.h
> +   :identifiers:
> +
> +.. kernel-doc:: drivers/cxl/core/region.c
> +   :doc: cxl core region
> +
> +.. kernel-doc:: drivers/cxl/core/region.c
> +   :identifiers:
> +
>  External Interfaces
>  ===================
>
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d1aaabc940f3..d19d22a19966 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>
> +cxl_acpi-y := acpi.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1503d8bf5e9a..4d034900e22c 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -2,4 +2,4 @@
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
>
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I./drivers/cxl
> -cxl_core-y := bus.o memdev.o pmem.o regs.o
> +cxl_core-y := bus.o memdev.o pmem.o region.o regs.o
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index e2166f43aefc..3b2bcc091523 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -131,7 +131,68 @@ static ssize_t target_list_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(target_list);
>
> +static ssize_t create_region_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       int rc;
> +
> +       device_lock(dev);
> +       rc = sprintf(buf, "%s\n",
> +                    cxld->youngest ? dev_name(&cxld->youngest->dev) : "");

Youngest goes away if userspace explicitly knows which region it
atomically created.

> +       device_unlock(dev);
> +
> +       return rc;
> +}
> +
> +static ssize_t create_region_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t len)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       struct cxl_region *region;
> +       ssize_t rc;
> +       int val;
> +
> +       rc = kstrtoint(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +       if (val < 0 || val > 16)
> +               return -EINVAL;
> +
> +       region = cxl_alloc_region(cxld, val);
> +       if (IS_ERR(region))
> +               return PTR_ERR(region);
> +
> +       rc = cxl_add_region(cxld, region);
> +       if (rc) {
> +               cxl_free_region(cxld, region);
> +               return rc;
> +       }
> +
> +       cxld->youngest = region;
> +       return len;
> +}
> +static DEVICE_ATTR_RW(create_region);
> +
> +static ssize_t delete_region_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t len)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       int rc;
> +
> +       rc = cxl_delete_region(cxld, buf);
> +       if (rc)
> +               return rc;
> +
> +       return len;
> +}
> +static DEVICE_ATTR_WO(delete_region);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
> +       &dev_attr_create_region.attr,
> +       &dev_attr_delete_region.attr,
>         &dev_attr_start.attr,
>         &dev_attr_size.attr,
>         &dev_attr_locked.attr,
> @@ -188,7 +249,13 @@ static void cxl_decoder_release(struct device *dev)
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>         struct cxl_port *port = dev->parent ? to_cxl_port(dev->parent) : NULL;
> +       struct cxl_region *region;
>
> +       list_for_each_entry(region, &cxld->regions, list)
> +               cxl_delete_region(cxld, dev_name(&region->dev));

The decoder already has a list of child devices, no need to duplicate
that, i.e. do something like:

device_for_each_child(&cxld->dev, cxld, cxl_delete_region);

> +
> +       dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
> +                     "Lost track of a region");
>         if (port)
>                 ida_free(&port->decoder_ida, cxld->id);
>         else
> @@ -516,8 +583,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>                 .interleave_ways = interleave_ways,
>                 .interleave_granularity = interleave_granularity,
>                 .target_type = type,
> +               .regions = LIST_HEAD_INIT(cxld->regions),

This goes away...

>         };
>
> +       ida_init(&cxld->region_ida);
> +
>         /* handle implied target_list */
>         if (port)
>                 if (interleave_ways == 1)
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5e5862e4d6af..eb1a17103e5d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>
>  #include <cxl.h>
>  #include <mem.h>
> +#include <region.h>
>
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> new file mode 100644
> index 000000000000..caa34f59a62d
> --- /dev/null
> +++ b/drivers/cxl/core/region.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core region
> + *
> + * Regions are managed through the Linux device model. Each region instance is a
> + * unique struct device. CXL core provides functionality to create, destroy, and
> + * configure regions. This is all implemented here. Binding a region
> + * (programming the hardware) is handled by a separate region driver.
> + */
> +
> +static void cxl_region_release(struct device *dev);
> +
> +static const struct device_type cxl_region_type = {
> +       .name = "cxl_region",
> +       .release = cxl_region_release,
> +};
> +
> +bool is_cxl_region(struct device *dev)
> +{
> +       return dev->type == &cxl_region_type;
> +}
> +EXPORT_SYMBOL_GPL(is_cxl_region);
> +
> +struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +       if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> +                         "not a cxl_region device\n"))
> +               return NULL;
> +
> +       return container_of(dev, struct cxl_region, dev);
> +}
> +EXPORT_SYMBOL_GPL(to_cxl_region);
> +
> +void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
> +{
> +       ida_free(&cxld->region_ida, region->id);
> +       kfree(region);
> +}
> +
> +static void cxl_region_release(struct device *dev)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> +       struct cxl_region *region = to_cxl_region(dev);
> +
> +       cxl_free_region(cxld, region);
> +}
> +
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
> +                                   int interleave_ways)
> +{
> +       struct cxl_region *region;
> +       int rc;
> +
> +       region = kzalloc(struct_size(region, targets, interleave_ways),
> +                        GFP_KERNEL);
> +       if (!region)
> +               return ERR_PTR(-ENOMEM);
> +
> +       region->eniw = interleave_ways;
> +
> +       rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
> +       if (rc < 0) {
> +               dev_err(&cxld->dev, "Couldn't get a new id\n");
> +               kfree(region);
> +               return ERR_PTR(rc);
> +       }
> +       region->id = rc;
> +
> +       return region;
> +}
> +
> +/**
> + * cxl_add_region - Adds a region to a decoder
> + * @cxld: Parent decoder.
> + * @region: Region to be added to the decoder.
> + *
> + * This is the second step of region initialization. Regions exist within an
> + * address space which is mapped by a @cxld, and that @cxld enforces constraints
> + * upon the region as it is configured. Regions may be added to a @cxld but not
> + * activated and therefore it is possible to have more regions in a @cxld than
> + * there are interleave ways in the @cxld. Regions exist only for persistent
> + * capacities.
> + *
> + * Return: zero if the region was added to the @cxld, else returns negative
> + * error code.
> + */
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region)
> +{
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       struct device *dev = &region->dev;
> +       int rc;
> +
> +       device_initialize(dev);
> +       dev->parent = &cxld->dev;
> +       device_set_pm_not_required(dev);
> +       dev->bus = &cxl_bus_type;
> +       dev->type = &cxl_region_type;
> +       rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, region->id);
> +       if (rc)
> +               goto err;
> +
> +       rc = device_add(dev);
> +       if (rc)
> +               goto err;
> +
> +       dev_dbg(dev, "Added %s to %s\n", dev_name(dev), dev_name(&cxld->dev));
> +
> +       return 0;
> +
> +err:
> +       put_device(dev);
> +       return rc;
> +}
> +
> +static struct cxl_region *
> +cxl_find_region_by_name(struct cxl_decoder *cxld, const char *name)
> +{
> +       struct device *region_dev;
> +
> +       region_dev = device_find_child_by_name(&cxld->dev, name);
> +       if (!region_dev)
> +               return ERR_PTR(-ENOENT);
> +
> +       return to_cxl_region(region_dev);
> +}
> +
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
> +{
> +       struct cxl_region *region;
> +
> +       device_lock(&cxld->dev);
> +
> +       region = cxl_find_region_by_name(cxld, region_name);
> +       if (IS_ERR(region)) {
> +               device_unlock(&cxld->dev);
> +               return PTR_ERR(region);
> +       }
> +
> +       dev_dbg(&cxld->dev, "Requested removal of %s from %s\n",
> +               dev_name(&region->dev), dev_name(&cxld->dev));
> +
> +       cmpxchg(&cxld->youngest, region, NULL);
> +
> +       device_unregister(&region->dev);
> +       device_unlock(&cxld->dev);
> +
> +       put_device(&region->dev);

What get_device() does this pair with?

> +
> +       return 0;
> +}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index dcf2d1a59271..448abc5c7918 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -191,6 +191,9 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> + * @region_ida: allocator for region ids.
> + * @regions: List of regions mapped (may be disabled) by this decoder.
> + * @youngest: Last region created for this decoder.
>   * @target: active ordered target list in current decoder configuration
>   */
>  struct cxl_decoder {
> @@ -201,6 +204,9 @@ struct cxl_decoder {
>         int interleave_granularity;
>         enum cxl_decoder_type target_type;
>         unsigned long flags;
> +       struct ida region_ida;
> +       struct list_head regions;
> +       struct cxl_region *youngest;
>         struct cxl_dport *target[];
>  };
>
> @@ -263,6 +269,14 @@ struct cxl_dport {
>         struct list_head list;
>  };
>
> +bool is_cxl_region(struct device *dev);
> +struct cxl_region *to_cxl_region(struct device *dev);
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
> +                                   int interleave_ways);
> +void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region);
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region);
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
> +
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>                                    resource_size_t component_reg_phys,
> diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
> new file mode 100644
> index 000000000000..c8ed3a8bd1e0
> --- /dev/null
> +++ b/drivers/cxl/region.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2021 Intel Corporation. */
> +#ifndef __CXL_REGION_H__
> +#define __CXL_REGION_H__
> +
> +#include <linux/uuid.h>
> +
> +/**
> + * struct cxl_region - CXL region
> + * @dev: This region's device.
> + * @id: This regions id. Id is globally unique across all regions.
> + * @res: Address space consumed by this region.
> + * @requested_size: Size of the region determined from LSA or userspace.
> + * @uuid: The UUID for this region.
> + * @list: Node in decoders region list.
> + * @eniw: Number of interleave ways this region is configured for.
> + * @targets: The memory devices comprising the region.
> + */
> +struct cxl_region {
> +       struct device dev;
> +       int id;
> +       struct resource *res;
> +       u64 requested_size;

Why requested_size, and not size? Perhaps this instead should be a
pointer to a 'struct cxl_region_label' where the LSA data is cached.

I think we'll want struct cxl_volatile_region and struct
cxl_persistent_region wrapping a common struct cxl_region.

> +       uuid_t uuid;
> +       struct list_head list;
> +       int eniw;
> +       struct cxl_memdev *targets[];
> +};
> +
> +#endif
> --
> 2.32.0
>
