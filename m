Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA05BC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Oct 2021 01:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79C760F57
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Oct 2021 01:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJ3BkS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 21:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJ3BkR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 21:40:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C6C061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 18:37:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f8so7901211plo.12
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J51j/eUdTf8z81pb/UyOQZYfAwcplhsXcI3Til8v88=;
        b=1apNV0WO0+TGrC89Y9GkpgkovVI7bzG4aCwGBCbj9dPqiBOHgs+wMhgMSVOubLJ4xj
         ViP3PzM5Q/6HSgEcdrKQicS9e+Lo8l+p7tc3MnVVAeb0Uxct2YQGwb6Vzwy02ze/SmOw
         mYRsh/PCOoHPRjbVXJyx1S2T94AAjQEv0RTd3KdKdwWwTONu5n4L/S1aNDnCX9lJ++5L
         fV9wV3sfu3Pd3m7Do0aepH38yVxP6tOJhxaWf1HbooUtAcWFrHr7S6k67bF7/mWDjP4l
         U3x/xqNlvhiISs3Da6Vth1PTg+0r+iQG7IvvbHU5aQYgM6MfBkwG49TJZdVqc5yPvezY
         jQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J51j/eUdTf8z81pb/UyOQZYfAwcplhsXcI3Til8v88=;
        b=Fk27wJeg1iGrRKp7PLLSyLLQhp7oql7+uZMjbNbjwfeABptY3rIpUhemp/VGLePObD
         dPnP+9RfVqD2mkZCy+DsN6rDxXMybNtKq1LjBSVo2jY+/TTo7+/gNrIyYNNRMk26tsgN
         jWVBZv1Mvi/43zmQZrJiWouqUVsEIJvFH7R/7vTVWUqWAVMAfks9euU1RzPeYFzvNd14
         D5lO7N/zwAYp5VfRsmgckc36Mt0T7DhUm7beBICZiMo9TY/pIobrvOwI2E2nZz3MxrGn
         9yrHXDmFYBIyQwQ5PriMIaFQ7LfWe9klLpymT20NA5Y75WQIEeIn8aOgjREqXB8wCOYx
         z51w==
X-Gm-Message-State: AOAM531oTADt5cmqG9xsLiM4CYDvBNcYAda314D0tHxQ1zmdRJEpor8R
        GQrrdhmMvbRcFPeI14CJCSatymOtTC9q3xwPaY9MDg==
X-Google-Smtp-Source: ABdhPJyQM+rl8gdIy8i1sdsoHmGiQ+fPCpMkIN0ujNK1VLudRCdSl4IwKcMB3Kb54NsYMOOQoZxsf9duHnvjAG2V8fo=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr14771066pjb.93.1635557867960;
 Fri, 29 Oct 2021 18:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-9-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-9-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 18:37:36 -0700
Message-ID: <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The CXL port driver will be responsible for managing the decoder

Small quibble to use present tense, the future is now with this patch!

> resources contained within the port. It will also provide APIs that
> other drivers will consume for managing these resources.
>
> Since the port driver is responsible for instantiating new decoders, and
> it does so during probe(), a new API is needed to add decoders for
> callers which already hold the device lock of the port.
>
> This patch has no functional change because no driver is registering new
> ports and the root ports that are already registered should be skipped.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  .../driver-api/cxl/memory-devices.rst         |   5 +
>  drivers/cxl/Makefile                          |   2 +
>  drivers/cxl/acpi.c                            |   1 +
>  drivers/cxl/core/bus.c                        |  44 +++-
>  drivers/cxl/core/regs.c                       |   6 +-
>  drivers/cxl/cxl.h                             |  31 ++-
>  drivers/cxl/port.c                            | 242 ++++++++++++++++++
>  7 files changed, 315 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/cxl/port.c
>
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 3b8f41395f6b..fbf0393cdddc 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -28,6 +28,11 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>
> +CXL Port
> +--------
> +.. kernel-doc:: drivers/cxl/port.c
> +   :doc: cxl port
> +
>  CXL Core
>  --------
>  .. kernel-doc:: drivers/cxl/cxl.h
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index cf07ae6cea17..40b386aaedf7 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += core/
> +obj-$(CONFIG_CXL_MEM) += cxl_port.o

It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?

>  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> @@ -7,3 +8,4 @@ obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o
> +cxl_port-y := port.o
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b972abc9f6ef..d61397055e9f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -491,3 +491,4 @@ static struct platform_driver cxl_acpi_driver = {
>  module_platform_driver(cxl_acpi_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
> +MODULE_SOFTDEP("pre: cxl_port");

Why does cxl_acpi depend on cxl_port being loaded at this point? I
think this wants to wait for a future patch where cxl_acpi uses port
driver services.

> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 5f2bde47a5c2..dffbd0ac64af 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -266,6 +266,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
>                 return NULL;
>         return container_of(dev, struct cxl_port, dev);
>  }
> +EXPORT_SYMBOL_GPL(to_cxl_port);
>
>  static void unregister_port(void *_port)
>  {
> @@ -537,11 +538,21 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
>
> -int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> +/**
> + * cxl_decoder_add_locked() - Adds a decoder with port locked.
> + * @cxld: Decoder to be added
> + * @target_map: Downstream port array of port ids
> + *
> + * The parent port owning the @cxld must have its device mutex locked before
> + * calling this function.
> + *
> + * Returns 0 if successful; otherwise, a negative error code is returned.
> + */
> +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
>  {
>         struct cxl_port *port;
>         struct device *dev;
> -       int rc = 0;
> +       int rc;
>
>         if (WARN_ON_ONCE(!cxld))
>                 return -EINVAL;
> @@ -556,12 +567,11 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>
>         port = to_cxl_port(cxld->dev.parent);
>
> -       device_lock(&port->dev);
> -       if (!is_endpoint_decoder(dev))
> +       if (!is_endpoint_decoder(dev)) {
>                 rc = decoder_populate_targets(cxld, port, target_map);
> -       device_unlock(&port->dev);
> -       if (rc)
> -               return rc;
> +               if (rc)
> +                       return rc;
> +       }

Yeah, this hunk is proof that the api change belongs in the previous patch.

>
>         rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
>         if (rc)
> @@ -569,6 +579,24 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>
>         return device_add(dev);
>  }
> +EXPORT_SYMBOL_GPL(cxl_decoder_add_locked);
> +
> +int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> +{
> +       int rc;
> +
> +       if (WARN_ON_ONCE(!cxld))
> +               return -EINVAL;
> +
> +       if (WARN_ON_ONCE(IS_ERR(cxld)))
> +               return PTR_ERR(cxld);
> +
> +       device_lock(&to_cxl_port(cxld->dev.parent)->dev);
> +       rc = cxl_decoder_add_locked(cxld, target_map);
> +       device_unlock(&to_cxl_port(cxld->dev.parent)->dev);

I don't like that this converts the parent device twice, especially
since to_cxl_port() does extra work for type validation, so please add
a local @port variable.

> +
> +       return rc;
> +}
>  EXPORT_SYMBOL_GPL(cxl_decoder_add);
>
>  static void cxld_unregister(void *dev)
> @@ -627,6 +655,8 @@ static int cxl_device_id(struct device *dev)
>                 return CXL_DEVICE_NVDIMM_BRIDGE;
>         if (dev->type == &cxl_nvdimm_type)
>                 return CXL_DEVICE_NVDIMM;
> +       if (dev->type == &cxl_port_type)
> +               return CXL_DEVICE_PORT;
>         return 0;
>  }
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 40598905c080..c8ab8880b81b 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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
> @@ -180,6 +179,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
>
>         return ret_val;
>  }
> +EXPORT_SYMBOL_GPL(devm_cxl_iomap_block);

I think it's well past time to convert all the EXPORT_SYMBOL_GPL in
the core to EXPORT_SYMBOL_NS_GPL($symbol, CXL).

>
>  int cxl_map_component_regs(struct pci_dev *pdev,
>                            struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 91b8fd54bc93..ad22caf9135c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -17,6 +17,9 @@
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>  #define CXL_CM_OFFSET 0x1000
>  #define CXL_CM_CAP_HDR_OFFSET 0x0
> @@ -36,11 +39,22 @@
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
> -#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
> @@ -164,6 +178,8 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  enum cxl_regloc_type;
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>                       struct cxl_register_map *map);
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +                                  resource_size_t length);
>
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -178,7 +194,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  #define CXL_DECODER_F_TYPE2 BIT(2)
>  #define CXL_DECODER_F_TYPE3 BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
> -#define CXL_DECODER_F_MASK  GENMASK(4, 0)
> +#define CXL_DECODER_F_EN    BIT(5)

Spell out ENABLE.

> +#define CXL_DECODER_F_MASK  GENMASK(5, 0)
>
>  enum cxl_decoder_type {
>         CXL_DECODER_ACCELERATOR = 2,
> @@ -295,6 +312,7 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>                                       unsigned int nr_targets);
> +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>
> @@ -323,6 +341,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>
>  #define CXL_DEVICE_NVDIMM_BRIDGE       1
>  #define CXL_DEVICE_NVDIMM              2
> +#define CXL_DEVICE_PORT                        3
>
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> new file mode 100644
> index 000000000000..ebbfb72ae995
> --- /dev/null
> +++ b/drivers/cxl/port.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "cxlmem.h"
> +
> +/**
> + * DOC: cxl port
> + *
> + * The port driver implements the set of functionality needed to allow full
> + * decoder enumeration and routing. A CXL port is an abstraction of a CXL
> + * component that implements some amount of CXL decoding of CXL.mem traffic.
> + * As of the CXL 2.0 spec, this includes:
> + *
> + *     .. list-table:: CXL Components w/ Ports
> + *             :widths: 25 25 50
> + *             :header-rows: 1
> + *
> + *             * - component
> + *               - upstream
> + *               - downstream
> + *             * - Hostbridge
> + *               - ACPI0016
> + *               - root port
> + *             * - Switch
> + *               - Switch Upstream Port
> + *               - Switch Downstream Port
> + *             * - Endpoint (not yet implemented)
> + *               - Endpoint Port
> + *               - N/A
> + *
> + * The primary service this driver provides is enumerating HDM decoders and
> + * presenting APIs to other drivers to utilize the decoders.
> + */
> +
> +struct cxl_port_data {
> +       struct cxl_component_regs regs;
> +
> +       struct port_caps {
> +               unsigned int count;
> +               unsigned int tc;
> +               unsigned int interleave11_8;
> +               unsigned int interleave14_12;
> +       } caps;
> +};
> +
> +static inline int cxl_hdm_decoder_ig(u32 ctrl)

No need for plain inline in C files.

It's not clear why this simple helper needs a "cxl_hdm_decoder"
namespace prefix?

> +{
> +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> +
> +       return 8 + val;
> +}

Why is this return a power of 2 value...

> +
> +static inline int cxl_hdm_decoder_iw(u32 ctrl)
> +{
> +       int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> +
> +       return 1 << val;

...while this one is converted to absolute values.

These could just be:

unsigned int to_interleave_granularity(u32 ctrl)
unsigned int to_interleave_ways(u32 ctrl)

...and return units in bytes.

> +}
> +
> +static void get_caps(struct cxl_port *port, struct cxl_port_data *cpd)
> +{
> +       void __iomem *hdm_decoder = cpd->regs.hdm_decoder;
> +       struct port_caps *caps = &cpd->caps;
> +       u32 hdm_cap;
> +
> +       hdm_cap = readl(hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> +
> +       caps->count = cxl_hdm_decoder_count(hdm_cap);
> +       caps->tc = FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> +       caps->interleave11_8 =
> +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap);
> +       caps->interleave14_12 =
> +               FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap);
> +}
> +
> +static int map_regs(struct cxl_port *port, void __iomem *crb,
> +                   struct cxl_port_data *cpd)
> +{
> +       struct cxl_register_map map;
> +       struct cxl_component_reg_map *comp_map = &map.component_map;
> +
> +       cxl_probe_component_regs(&port->dev, crb, comp_map);
> +       if (!comp_map->hdm_decoder.valid) {
> +               dev_err(&port->dev, "HDM decoder registers invalid\n");
> +               return -ENXIO;
> +       }

Perhaps promote cxl_probe_regs() from the cxl_pci to the core and make
it take a dev instead of a pdev, then you can do:

cxl_probe_regs(&port_dev->dev, CXL_REGLOC_RBI_COMPONENT)

...instead of open coding it again?

> +
> +       cpd->regs.hdm_decoder = crb + comp_map->hdm_decoder.offset;
> +
> +       return 0;
> +}
> +
> +static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
> +{
> +       u32 ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(n));
> +
> +       if (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +               return 0;
> +
> +       return ioread64_hi_lo(hdm_decoder +
> +                             CXL_HDM_DECODER0_SIZE_LOW_OFFSET(n));
> +}
> +
> +static bool is_endpoint_port(struct cxl_port *port)
> +{
> +       if (!port->uport->driver)
> +               return false;
> +
> +       return to_cxl_drv(port->uport->driver)->id ==
> +              CXL_DEVICE_MEMORY_EXPANDER;

Why does endpoint port device type determination need to reach through
and read the driver type?

> +}
> +
> +static int enumerate_hdm_decoders(struct cxl_port *port,
> +                                 struct cxl_port_data *portdata)
> +{
> +       int i = 0;
> +
> +       for (i = 0; i < portdata->caps.count; i++) {
> +               int iw = 1, ig = 0, rc, target_count = portdata->caps.tc;
> +               void __iomem *hdm_decoder = portdata->regs.hdm_decoder;
> +               enum cxl_decoder_type type = CXL_DECODER_EXPANDER;
> +               struct resource res = DEFINE_RES_MEM(0, 0);
> +               struct cxl_decoder *cxld;
> +               int *target_map = NULL;
> +               u64 size;
> +
> +               if (is_endpoint_port(port))
> +                       target_count = 0;
> +
> +               cxld = cxl_decoder_alloc(port, target_count);
> +               if (IS_ERR(cxld)) {
> +                       dev_warn(&port->dev,
> +                                "Failed to allocate the decoder\n");
> +                       return PTR_ERR(cxld);
> +               }
> +
> +               size = get_decoder_size(hdm_decoder, i);
> +               if (size != 0) {
> +                       int temp[CXL_DECODER_MAX_INTERLEAVE];
> +                       u64 target_list, base;
> +                       u32 ctrl;
> +                       int j;
> +
> +                       target_map = temp;
> +                       ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +                       base = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i));
> +                       res = (struct resource)DEFINE_RES_MEM(base, size);
> +
> +                       cxld->flags = CXL_DECODER_F_EN;
> +                       iw = cxl_hdm_decoder_iw(ctrl);
> +                       ig = cxl_hdm_decoder_ig(ctrl);
> +
> +                       if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0)
> +                               type = CXL_DECODER_ACCELERATOR;
> +
> +                       target_list = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_TL_LOW(i));
> +                       for (j = 0; j < iw; j++)
> +                               target_map[j] = (target_list >> (j * 8)) & 0xff;

Perhaps this can be cleaned up with:

union {
    u64 value;
    char target_id[8];
} target_list;

target_list.value = ioread64_hi_lo(hdm_decoder + CXL_HDM_DECODER0_TL_LOW(i));
for (j = 0; j < interleave_ways; j++)
    target_map[j] = target_list.target_id[j];

> +               }
> +
> +               cxld->target_type = type;
> +               cxld->res = res;
> +               cxld->interleave_ways = iw;
> +               cxld->interleave_granularity = ig;
> +
> +               rc = cxl_decoder_add_locked(cxld, target_map);
> +               if (rc)
> +                       put_device(&cxld->dev);
> +               else
> +                       rc = cxl_decoder_autoremove(port->uport->parent, cxld);

This looks broken to me.

With the assumption that the CXL subsystem wants the property that the
entire port object hierarchy is removed when cxl_acpi is removed, and
for a subset of the hierarchy to be removed when an individual port is
disabled (detached from the cxl_port driver) then I believe we want
something like the patch at the bottom of this mail... only compile
tested:

> +               if (rc)
> +                       dev_err(&port->dev, "Failed to add decoder\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static int cxl_port_probe(struct device *dev)
> +{
> +       struct cxl_port *port = to_cxl_port(dev);
> +       struct cxl_port_data *portdata;
> +       void __iomem *crb;
> +       u32 ctrl;
> +       int rc;
> +
> +       if (port->component_reg_phys == CXL_RESOURCE_NONE)
> +               return 0;
> +
> +       portdata = devm_kzalloc(dev, sizeof(*portdata), GFP_KERNEL);
> +       if (!portdata)
> +               return -ENOMEM;
> +
> +       crb = devm_cxl_iomap_block(&port->dev, port->component_reg_phys,
> +                                  CXL_COMPONENT_REG_BLOCK_SIZE);
> +       if (IS_ERR_OR_NULL(crb)) {

devm_cxl_iomap_block() does not return an ERR_PTR so this should just
be a plain NULL check.

> +               dev_err(&port->dev, "No component registers mapped\n");
> +               return -ENXIO;
> +       }
> +
> +       rc = map_regs(port, crb, portdata);
> +       if (rc)
> +               return rc;
> +
> +       get_caps(port, portdata);
> +       if (portdata->caps.count == 0) {
> +               dev_err(&port->dev, "Spec violation. Caps invalid\n");
> +               return -ENXIO;
> +       }
> +
> +       /*
> +        * Enable HDM decoders for this port.
> +        *
> +        * FIXME: If the component was using DVSEC range registers for decode,
> +        * this will destroy that.

Yeah, definitely need to check that before this patch can move
forward. Perhaps a port should not even be registered if DVSEC
Memory_Size && Mem_Enable are non zero, that device is explicitly
opting out of being a part of the CXL 2.0 subsystem hierarchy.
However, we might still need to track it and potentially reserve it
out of CFMWS capacity to make sure nothing else collides with it. I'll
also note that "ECN: Devices operating in CXL 1.1 mode with no RCRB"
was recently published that reads on what the driver should do here.

> +        */
> +       ctrl = readl(portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);
> +       ctrl |= CXL_HDM_DECODER_ENABLE;
> +       writel(ctrl, portdata->regs.hdm_decoder + CXL_HDM_DECODER_CTRL_OFFSET);

I feel like that if the driver finds it enabled it should leave it
enabled at ->remove() time, as you have it here, as BIOS might not be
expecting the OS to disable a decoder it set up. However, if the
driver actually does the enable, then it should pair it with a disable
at the end of time, so not a blind enable, but one that conditionally
arranges for the unwind.

> +
> +       rc = enumerate_hdm_decoders(port, portdata);
> +       if (rc) {
> +               dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
> +               return rc;
> +       }
> +
> +       dev_set_drvdata(dev, portdata);
> +       return 0;
> +}
> +
> +static struct cxl_driver cxl_port_driver = {
> +       .name = "cxl_port",
> +       .probe = cxl_port_probe,
> +       .id = CXL_DEVICE_PORT,
> +};
> +module_cxl_driver(cxl_port_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
> --
> 2.33.1

Proposed infrastructure for a new cxl_port_decoder_autoremove():

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3163167ecc3a..78f8313a1069 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -374,6 +374,11 @@ static int add_root_nvdimm_bridge(struct device
*match, void *data)
        return 1;
 }

+static void clear_cxl_topology_host(void *data)
+{
+       set_cxl_topology_host(NULL);
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
        int rc;
@@ -382,6 +387,11 @@ static int cxl_acpi_probe(struct platform_device *pdev)
        struct acpi_device *adev = ACPI_COMPANION(host);
        struct cxl_cfmws_context ctx;

+       set_cxl_topology_host(host);
+       rc = devm_add_action_or_reset(host, clear_cxl_topology_host, host);
+       if (rc)
+               return rc;
+
        root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
        if (IS_ERR(root_port))
                return PTR_ERR(root_port);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 17a4fff029f8..3146b6aa0a2f 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -3,6 +3,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -563,6 +564,84 @@ int cxl_decoder_autoremove(struct device *host,
struct cxl_decoder *cxld)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);

+void trigger_decoder_autoremove(void *data)
+{
+       struct cxl_decoder *cxld = data;
+       struct device *host = get_cxl_topology_host();
+
+       /* The topology host driver beat us to the punch */
+       if (!host)
+               return;
+
+       devm_remove_action(host, cxld_unregister, &cxld->dev);
+       put_cxl_topology_host(host);
+}
+
+/**
+ * cxl_port_decoder_autoremove - remove decoders discovered by the port driver
+ * @cxld: decoder to remove
+ *
+ * CXL.mem requires an intact port / decoder topology from root level
+ * platform decoders to endpoint decoders. Arrange for decoders
+ * enumerated by the port driver to be removed when either the root is
+ * removed (in which the entire hierarchy is removed), or when an
+ * individual port is disabled, in which case only that port's
+ * sub-section of the hierarchy is removed.
+ */
+int cxl_port_decoder_autoremove(struct cxl_decoder *cxld)
+{
+       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+       struct device *host = get_cxl_topology_host();
+       int rc;
+
+       if (!host)
+               return -ENODEV;
+
+       if (!port->dev.driver) {
+               rc = -ENXIO;
+               goto out;
+       }
+
+       rc = cxl_decoder_autoremove(host, cxld);
+       if (rc)
+               goto out;
+
+       rc = devm_add_action_or_reset(&port->dev, trigger_decoder_autoremove,
+                                       cxld);
+out:
+       put_cxl_topology_host(host);
+       return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_decoder_autoremove, CXL);
+
+static DECLARE_RWSEM(cxl_topology_rwsem);
+static struct device *cxl_topology_host;
+
+void set_cxl_topology_host(struct device *dev)
+{
+       down_write(&cxl_topology_rwsem);
+       cxl_topology_host = dev;
+       up_write(&cxl_topology_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(set_cxl_topology_host, CXL);
+
+struct device *get_cxl_topology_host(void)
+{
+       down_read(&cxl_topology_rwsem);
+       if (cxl_topology_host)
+               return cxl_topology_host;
+       up_read(&cxl_topology_rwsem);
+       return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(get_cxl_topology_host, CXL);
+
+void put_cxl_topology_host(struct device *dev)
+{
+       WARN_ON(dev != cxl_topology_host);
+       up_read(&cxl_topology_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(put_cxl_topology_host, CXL);
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5e2e93451928..bd7b008207a4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -302,6 +302,10 @@ struct cxl_decoder *cxl_decoder_alloc(struct
cxl_port *port, int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);

+void set_cxl_topology_host(struct device *dev);
+struct device *get_cxl_topology_host(void);
+void put_cxl_topology_host(struct device *dev);
+
 extern struct bus_type cxl_bus_type;

 struct cxl_driver {
