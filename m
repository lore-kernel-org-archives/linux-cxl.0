Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B877C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E786101A
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhICOxv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:53:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3737 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhICOxu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 10:53:50 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1LMT74HCz67yqX;
        Fri,  3 Sep 2021 22:51:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 16:52:48 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 15:52:48 +0100
Date:   Fri, 3 Sep 2021 15:52:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 06/13] cxl/mem: Introduce cxl_mem driver
Message-ID: <20210903155249.00002b2e@Huawei.com>
In-Reply-To: <20210902195017.2516472-7-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-7-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:10 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

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

Looks fairly standard... FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
>  		return CXL_DEVICE_NVDIMM_BRIDGE;
>  	if (dev->type == &cxl_nvdimm_type)
>  		return CXL_DEVICE_NVDIMM;
> +	if (dev->type == &cxl_memdev_type)
> +		return CXL_DEVICE_ENDPOINT;
>  	return 0;
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
>  	NULL,
>  };
>  
> -static const struct device_type cxl_memdev_type = {
> +const struct device_type cxl_memdev_type = {
>  	.name = "cxl_memdev",
>  	.release = cxl_memdev_release,
>  	.devnode = cxl_memdev_devnode,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 708bfe92b596..b48bdbefd949 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -315,6 +315,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  
>  #define CXL_DEVICE_NVDIMM_BRIDGE	1
>  #define CXL_DEVICE_NVDIMM		2
> +#define CXL_DEVICE_ENDPOINT		3
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
> +	return -EOPNOTSUPP;
> +}
> +
> +static void cxl_mem_remove(struct device *dev)
> +{
> +}
> +
> +static struct cxl_driver cxl_mem_driver = {
> +	.name = "cxl_mem",
> +	.probe = cxl_mem_probe,
> +	.remove = cxl_mem_remove,
> +	.id = CXL_DEVICE_ENDPOINT,
> +};
> +
> +static __init int cxl_mem_init(void)
> +{
> +	return cxl_driver_register(&cxl_mem_driver);
> +}
> +
> +static __exit void cxl_mem_exit(void)
> +{
> +	cxl_driver_unregister(&cxl_mem_driver);
> +}
> +
> +MODULE_LICENSE("GPL v2");
> +module_init(cxl_mem_init);
> +module_exit(cxl_mem_exit);
> +MODULE_IMPORT_NS(CXL);

