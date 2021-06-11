Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEF9C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85E7611C9
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFKNdt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:33:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3222 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhFKNdr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 09:33:47 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1hMy5f80z6L7Tm;
        Fri, 11 Jun 2021 21:22:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 15:31:48 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 14:31:47 +0100
Date:   Fri, 11 Jun 2021 14:31:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 1/4] cxl/region: Add region creation ABI
Message-ID: <20210611143143.00001342@Huawei.com>
In-Reply-To: <20210610185725.897541-2-ben.widawsky@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
        <20210610185725.897541-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.251]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Jun 2021 11:57:22 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Regions are created as a child of the decoder that encompasses an
> address space with constraints. Regions only exist for persistent
> capacities.
> 
> As an example, creating a region with:
> echo 1 > /sys/bus/cxl/devices/decoder1.0/create_region
> 
> Will yield /sys/bus/cxl/devices/decoder1.0/region1.0:0
> 
> That region may then be deleted with:
> echo "region1.0:0 > /sys/bus/cxl/devices/decoder1.0/delete_region
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Minor stuff inline.

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  19 +++
>  .../driver-api/cxl/memory-devices.rst         |   8 +
>  drivers/cxl/Makefile                          |   2 +-
>  drivers/cxl/core.c                            |  71 ++++++++
>  drivers/cxl/cxl.h                             |  11 ++
>  drivers/cxl/mem.h                             |  19 +++
>  drivers/cxl/region.c                          | 155 ++++++++++++++++++
>  7 files changed, 284 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cxl/region.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 0b6a2e6e8fbb..5bcbefd4ea38 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -127,3 +127,22 @@ Description:
>  		memory (type-3). The 'target_type' attribute indicates the
>  		current setting which may dynamically change based on what
>  		memory regions are activated in this decode hierarchy.
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_region
> +Date:		June, 2021
> +KernelVersion:	v5.14
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		Writing a value of '1' will create a new uninitialized region
> +		that will be mapped by the CXL decoderX.Y. Reading from this
> +		node will return the last created region. Regions must be
> +		subsequently configured and bound to a region driver before they
> +		can be used.
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> +Date:		June, 2021
> +KernelVersion:	v5.14
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		Deletes the named region. A region must be unbound from the
> +		region driver before being deleted.

Perhaps call out an example of what a name looks like?

> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 487ce4f41d77..3066638b087f 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -39,6 +39,14 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/core.c
>     :doc: cxl core
>  
> +CXL Regions
> +-----------
> +.. kernel-doc:: drivers/cxl/region.c
> +   :doc: cxl region
> +
> +.. kernel-doc:: drivers/cxl/region.c
> +   :identifiers:
> +
>  External Interfaces
>  ===================
>  
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index a29efb3e8ad2..2b9dd9187788 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -4,6 +4,6 @@ obj-$(CONFIG_CXL_MEM) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> -cxl_core-y := core.o
> +cxl_core-y := core.o region.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 1b9ee0b08384..cda09a9cd98e 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include "cxl.h"
> +#include "mem.h"

This seems to be breaking the nice separation in cxl.
Perhaps add a region.h instead?

>  
>  /**
>   * DOC: cxl core
> @@ -119,7 +120,68 @@ static ssize_t target_list_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(target_list);
>  
> +static ssize_t create_region_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	int rc;
> +
> +	device_lock(dev);
> +	rc = sprintf(buf, "%s\n",
> +		     cxld->youngest ? dev_name(&cxld->youngest->dev) : "");
> +	device_unlock(dev);
> +
> +	return rc;
> +}
> +
> +static ssize_t create_region_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	struct cxl_region *region;
> +	ssize_t rc;
> +	int val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	region = cxl_alloc_region(cxld);
> +	if (IS_ERR(region))
> +		return PTR_ERR(region);
> +
> +	rc = cxl_add_region(cxld, region);
> +	if (rc) {
> +		cxl_free_region(cxld, region);
> +		return rc;
> +	}
> +
> +	cxld->youngest = region;

Care needed I think if a delete is called on whatever
is the youngest region then this file read.

> +	return len;
> +}
> +static DEVICE_ATTR_RW(create_region);
> +
> +static ssize_t delete_region_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +	int rc;
> +
> +	rc = cxl_delete_region(cxld, buf);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(delete_region);
> +
>  static struct attribute *cxl_decoder_base_attrs[] = {
> +	&dev_attr_create_region.attr,
> +	&dev_attr_delete_region.attr,
>  	&dev_attr_start.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_locked.attr,
> @@ -170,7 +232,13 @@ static void cxl_decoder_release(struct device *dev)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  	struct cxl_port *port = to_cxl_port(dev->parent);
> +	struct cxl_region *region;
>  
> +	list_for_each_entry(region, &cxld->regions, list) {
> +		cxl_delete_region(cxld, dev_name(&region->dev));
> +	}

Nitpick, brackets not needed.

> +	dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
> +		      "Lost track of a region");
>  	ida_free(&port->decoder_ida, cxld->id);
>  	kfree(cxld);
>  }
> @@ -475,8 +543,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>  		.interleave_ways = interleave_ways,
>  		.interleave_granularity = interleave_granularity,
>  		.target_type = type,
> +		.regions = LIST_HEAD_INIT(cxld->regions),
>  	};
>  
> +	ida_init(&cxld->region_ida);
> +
>  	/* handle implied target_list */
>  	if (interleave_ways == 1)
>  		cxld->target[0] =
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b988ea288f53..1ffc5e07e24d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include <linux/uuid.h>
>  
>  /**
>   * DOC: cxl objects
> @@ -182,6 +183,9 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> + * @region_ida: allocator for region ids.
> + * @regions: List of regions mapped (may be disabled) by this decoder.
> + * @youngest: Last region created for this decoder.
>   * @target: active ordered target list in current decoder configuration
>   */
>  struct cxl_decoder {
> @@ -192,6 +196,9 @@ struct cxl_decoder {
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
>  	unsigned long flags;
> +	struct ida region_ida;
> +	struct list_head regions;
> +	struct cxl_region *youngest;
>  	struct cxl_dport *target[];
>  };
>  
> @@ -231,6 +238,10 @@ struct cxl_dport {
>  	struct list_head list;
>  };
>  
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld);
> +void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region);
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region);
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 13868ff7cadf..4c4eb06a966b 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -3,6 +3,8 @@
>  #ifndef __CXL_MEM_H__
>  #define __CXL_MEM_H__
>  
> +#include <linux/cdev.h>

Unrelated?

> +
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
>  #define CXLMDEV_STATUS_OFFSET 0x0
>  #define   CXLMDEV_DEV_FATAL BIT(0)
> @@ -46,6 +48,23 @@ struct cxl_memdev {
>  	int id;
>  };
>  
> +/**
> + * struct cxl_region - CXL region
> + * @dev: This region's device.
> + * @id: This regions id. Id is globally unique across all regions.
> + * @res: Address space consumed by this region.
> + * @list: Node in decoders region list.
> + * @targets: The memory devices comprising the region.
> + */
> +struct cxl_region {
> +	struct device dev;
> +	int id;
> +	struct resource res;
> +	struct list_head list;
> +	struct cxl_memdev *targets[];
> +};
> +
> +

One line only.

>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> new file mode 100644
> index 000000000000..1f47bc17bd50
> --- /dev/null
> +++ b/drivers/cxl/region.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include "cxl.h"
> +#include "mem.h"
> +
> +/**
> + * DOC: cxl region
> + *
> + * A CXL region encompasses a chunk of host physical address space that may be
> + * consumed by a single device (x1 interleave aka linear) or across multiple
> + * devices (xN interleaved). A region is a child device of a &struct
> + * cxl_decoder. There may be multiple active regions under a single &struct
> + * cxl_decoder. The common case for multiple regions would be several linear,
> + * contiguous regions under a single decoder. Generally, there will be a 1:1
> + * relationship between decoder and region when the region is interleaved.
> + */
> +
> +static void cxl_region_release(struct device *dev);
> +
> +static const struct device_type cxl_region_type = {
> +	.name = "cxl_region",
> +	.release = cxl_region_release,
> +};
> +
> +static struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> +			  "not a cxl_region device\n"))
> +		return NULL;
> +
> +	return container_of(dev, struct cxl_region, dev);
> +}
> +
> +void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
> +{
> +	ida_free(&cxld->region_ida, region->id);
> +	kfree(region->targets);
> +	kfree(region);
> +}
> +
> +static void cxl_region_release(struct device *dev)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> +	struct cxl_region *region;
	struct cxl_region *region = to_cxl_region(dev);
?
Or just roll it into one line.

cxl_free_region(to_cxl_decoder(dev->parent), to_cxl_region(dev));

Of course may be affected by later patches so this doesn't make sense
but I'm too lazy to check!

> +
> +	region = to_cxl_region(dev);
> +	cxl_free_region(cxld, region);
> +}
> +
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld)
> +{
> +	struct cxl_region *region;
> +	int rc;
> +
> +	region = kzalloc(struct_size(region, targets, cxld->interleave_ways),
> +			 GFP_KERNEL);
> +	if (!region) {
> +		pr_err("No memory\n");

Drop, or move to dev_err? 

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
> +	if (rc < 0) {
> +		dev_err(&cxld->dev, "Couldn't get a new id\n");
> +		kfree(region);
> +		return ERR_PTR(rc);
> +	}
> +	region->id = rc;
> +
> +	return region;
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
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct device *dev = &region->dev;
> +	struct resource *res;
> +	int rc;
> +
> +	device_initialize(dev);
> +	dev->parent = &cxld->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_region_type;

Probably doesn't want the pm controls.

> +	rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, region->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	res = &region->res;
> +	res->name = "Persistent Memory";
> +	res->start = 0;
> +	res->end = -1;
> +	res->flags = IORESOURCE_MEM;
> +	res->desc = IORES_DESC_PERSISTENT_MEMORY;
> +
> +	dev_dbg(dev, "Added %s to %s\n", dev_name(dev), dev_name(&cxld->dev));
> +
> +	return 0;
> +
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> +
> +static struct cxl_region *
> +cxl_find_region_by_name(struct cxl_decoder *cxld, const char *name)
> +{
> +	struct device *region_dev;
> +
> +	region_dev = device_find_child_by_name(&cxld->dev, name);
> +	if (!region_dev)
> +		return ERR_PTR(-ENOENT);
> +
> +	return to_cxl_region(region_dev);
> +}
> +
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
> +{
> +	struct cxl_region *region;
> +
> +	region = cxl_find_region_by_name(cxld, region_name);
> +	if (IS_ERR(region))
> +		return PTR_ERR(region);
> +
> +	dev_dbg(&cxld->dev, "Requested removal of %s from %s\n",
> +		dev_name(&region->dev), dev_name(&cxld->dev));
> +
> +	device_unregister(&region->dev);
> +	put_device(&region->dev);
> +
> +	return 0;
> +}

