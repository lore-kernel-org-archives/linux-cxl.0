Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E226120A
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhIJVd7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIJVd6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 17:33:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC316C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 14:32:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so2431085pjr.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCYgFtulwP8ofE00dhW9GD/hVj9ylQhjxKe8WUvdMQI=;
        b=QSsdZpFlW8O760hlvhfW70upiwIbv6Dxi3Zwndf4q327GsqSXwzww+/bQV30AKUObv
         08SBajZu8rXfhHMKYrtqCwWDm2PJm9hGKo7VxqdZwt3qFpwjs5ct2KoD2bvuUFJ76Q03
         Axd16s62Dl923fA7MbbzHsGup1ZHK9rI2Iyef9HJwijkoJfvtfil8mycAOjji5pug0vw
         6yD+46F03hMDCgyhktpAqa6lXuB1Ak69wUwxC4mCbLxIkJyqYlz3B4jJF49Z4FxpUiKD
         qm5GhqEDRjJzhJbXiK7Gck09sWLUY1PHqkUZc9I8PAMvIm/jHXSClG3L+e8iCfGIrk9F
         B0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCYgFtulwP8ofE00dhW9GD/hVj9ylQhjxKe8WUvdMQI=;
        b=1XQyosa/yRbnLZIPoFAuq8NX9WHvpItbbC0Ct79Pfu6q2+imqIkyyj6l6fbDjjL29c
         UU48Ut0AjNLYTfm4/3TpwtRQFKU7ZmCqCqBVVTRjIbzObSlFAdEZp1RRVZi/8N6uQt1m
         D7zRkGX3+Pvlv2CxzUPWfjmyHCz4WBWMfaHbAXuqAn4fPbllx3KWZZPVit+g6Ef9zpaM
         JukajntM4R43D5d7XE1OLdouUhkMcFLqSkMEkUhkNsbOAPh5SxP1JIgibvc+G5QBuA8l
         qRBAuthth9+itR/UwDr6ZTScgCvydgJVMfUBR8j4m+E6lK7lJ1cpyH+H2YjtdBiovYVF
         qTTA==
X-Gm-Message-State: AOAM532ERvqbGquM8F4Piqd6D3YOCwifq7BpgNZ+4ac5dYzfdEGqag7M
        VT9cf4DiS/2QxYCIYRBCFTXlEd94JwAsWjoCZ2R1/w==
X-Google-Smtp-Source: ABdhPJyCHbzLiLnJkTor+coDTOlgEN/AoOYNtTt9DUzeknjIQU1ONF299jnSzhuK9UQWT+r5fwgOpxH4CmsNtDGqsjg=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr11742310pjb.220.1631309566067;
 Fri, 10 Sep 2021 14:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-7-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-7-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 14:32:35 -0700
Message-ID: <CAPcyv4h8hFMWi7Rm7B_L9pk6QzLhLY5-CbrYXN9+qW-a9qCQAw@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL endpoints that participate in the CXL.mem protocol require extra
> control to ensure architectural constraints are met for device
> management. The most straight-forward way to achieve control of these
> endpoints is with a new driver that can bind to such devices. This
> driver will also be responsible for enumerating the switches that
> connect the endpoint to the hostbridge.
>
> cxl_core already understands the concept of a memdev, but the core [by
> design] does not comprehend all the topological constraints.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  .../driver-api/cxl/memory-devices.rst         |  3 ++
>  drivers/cxl/Makefile                          |  3 +-
>  drivers/cxl/core/bus.c                        |  2 +
>  drivers/cxl/core/core.h                       |  1 +
>  drivers/cxl/core/memdev.c                     |  2 +-
>  drivers/cxl/cxl.h                             |  1 +
>  drivers/cxl/mem.c                             | 49 +++++++++++++++++++
>  7 files changed, 59 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/mem.c
>
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index a18175bae7a6..00d141071570 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -28,6 +28,9 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>
> +.. kernel-doc:: drivers/cxl/mem.c
> +   :doc: cxl mem
> +
>  CXL Core
>  --------
>  .. kernel-doc:: drivers/cxl/cxl.h
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d1aaabc940f3..d912ac4e3f0c 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += core/
> -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o cxl_pci.o

I'd rather now have a separate CONFIG_CXL_PCI Kconfig symbol for
cxl_pci and let CONFIG_CXL_MEM just mean cxl_mem. I.e. maybe there
will be a non-cxl_pci agent that registers cxl_memdev objects, or
maybe someone will only want manageability and not CXL.mem operation
enabled in their kernel.


>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>
> +cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 6202ce5a5ac2..256e55dc2a3b 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -641,6 +641,8 @@ static int cxl_device_id(struct device *dev)
>                 return CXL_DEVICE_NVDIMM_BRIDGE;
>         if (dev->type == &cxl_nvdimm_type)
>                 return CXL_DEVICE_NVDIMM;
> +       if (dev->type == &cxl_memdev_type)
> +               return CXL_DEVICE_ENDPOINT;

Perhaps CXL_DEVICE_MEMORY_{INTERFACE,EXPANDER}? "ENDPOINT" seems too generic.

>         return 0;
>  }
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e0c9aacc4e9c..dea246cb7c58 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> +extern const struct device_type cxl_memdev_type;
>
>  extern struct attribute_group cxl_base_attribute_group;
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ee61202c7aab..c9dd054bd813 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>         NULL,
>  };
>
> -static const struct device_type cxl_memdev_type = {
> +const struct device_type cxl_memdev_type = {
>         .name = "cxl_memdev",
>         .release = cxl_memdev_release,
>         .devnode = cxl_memdev_devnode,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 708bfe92b596..b48bdbefd949 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -315,6 +315,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>
>  #define CXL_DEVICE_NVDIMM_BRIDGE       1
>  #define CXL_DEVICE_NVDIMM              2
> +#define CXL_DEVICE_ENDPOINT            3
>
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..978a54b0a51a
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +#include "cxlmem.h"
> +
> +/**
> + * DOC: cxl mem
> + *
> + * CXL memory endpoint devices and switches are CXL capable devices that are
> + * participating in CXL.mem protocol. Their functionality builds on top of the
> + * CXL.io protocol that allows enumerating and configuring components via
> + * standard PCI mechanisms.
> + *
> + * The cxl_mem driver implements enumeration and control over these CXL
> + * components.
> + */
> +
> +static int cxl_mem_probe(struct device *dev)
> +{
> +       return -EOPNOTSUPP;

Why not just merge this patch with the one that fills these in? I'm
otherwise not understanding the value of having this stopping point in
someone's future bisect run. Even commit 4cdadfd5e0a7 ("cxl/mem:
Introduce a driver for CXL-2.0-Type-3 endpoints") had a functional
probe.

> +}
> +
> +static void cxl_mem_remove(struct device *dev)
> +{
> +}
> +
> +static struct cxl_driver cxl_mem_driver = {
> +       .name = "cxl_mem",
> +       .probe = cxl_mem_probe,
> +       .remove = cxl_mem_remove,

Empty ->remove() callbacks don't need to be registered.

> +       .id = CXL_DEVICE_ENDPOINT,
> +};
> +
> +static __init int cxl_mem_init(void)
> +{
> +       return cxl_driver_register(&cxl_mem_driver);
> +}
> +
> +static __exit void cxl_mem_exit(void)
> +{
> +       cxl_driver_unregister(&cxl_mem_driver);
> +}
> +
> +MODULE_LICENSE("GPL v2");
> +module_init(cxl_mem_init);
> +module_exit(cxl_mem_exit);

Perhaps, before this adds more boilerplate, go define a:

#define module_cxl_driver(__cxl_driver) \
        module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)

...as a lead-in patch?
