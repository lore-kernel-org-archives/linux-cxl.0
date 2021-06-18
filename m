Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB1C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A655613D5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFRLvd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:51:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3277 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhFRLvd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 07:51:33 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5xq94DGvz6G7ct;
        Fri, 18 Jun 2021 19:42:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 13:49:21 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 12:49:21 +0100
Date:   Fri, 18 Jun 2021 12:49:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 4/6] cxl/region: Introduce a cxl_region driver
Message-ID: <20210618124911.00002b3b@Huawei.com>
In-Reply-To: <20210617211329.626507-1-ben.widawsky@intel.com>
References: <20210617173655.430424-5-ben.widawsky@intel.com>
        <20210617211329.626507-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 14:13:29 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The cxl_region driver is responsible for managing the HDM decoder
> programming in the CXL topology. Once a region is created it must be
> configured and bound to the driver in order to activate it.
> 
> The following is a sample of how such controls might work:
> 
> echo 1 > /sys/bus/cxl/devices/decoder0.0/create_region
> echo $((256<<20)) > /sys/bus/cxl/devices/decoder0.0/region0.0:0/size
> echo mem0 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target0
> echo region0.0:0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
> In order to handle the eventual rise in failure modes of binding a
> region, a new trace event is created to help track these failures for
> debug and reconfiguration paths in userspace.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> 
> v2 Is updated to take into account the static region_type.
> 
> ---
>  drivers/cxl/Makefile |   2 +-
>  drivers/cxl/core.c   |  15 +++++-
>  drivers/cxl/cxl.h    |   1 +
>  drivers/cxl/mem.h    |   1 +
>  drivers/cxl/region.c | 109 ++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/region.h |  11 +++++
>  drivers/cxl/trace.h  |  33 +++++++++++++
>  7 files changed, 158 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/cxl/trace.h
> 
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index c3151198c041..f35077c073b8 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  
> -ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(src)
>  cxl_core-y := core.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index d8d7ca85e110..be65a1a1493e 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -1086,6 +1086,8 @@ static int cxl_device_id(struct device *dev)
>  		return CXL_DEVICE_NVDIMM_BRIDGE;
>  	if (dev->type == &cxl_nvdimm_type)
>  		return CXL_DEVICE_NVDIMM;
> +	if (is_cxl_region(dev))
> +		return CXL_DEVICE_REGION;
>  	return 0;
>  }
>  
> @@ -1102,7 +1104,18 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
>  
>  static int cxl_bus_probe(struct device *dev)
>  {
> -	return to_cxl_drv(dev->driver)->probe(dev);
> +	int id = cxl_device_id(dev);
> +
> +	if (id == CXL_DEVICE_REGION) {
> +		struct cxl_region *region = to_cxl_region(dev);
> +
> +		if (cxl_is_region_configured(region))
> +			return to_cxl_drv(dev->driver)->probe(dev);
> +	} else {
> +		return to_cxl_drv(dev->driver)->probe(dev);
> +	}
you could express this as a sanity check followed by common path. 

	if (id == CXL_DEVICE_REGION) {
		struct cxl_region *region = to_cxl_region(dev);

		if (!cxl_is_region_configured(region))
			return -ENODEV;  //perhaps not a great error code for this case.
	}

	return to_cxl_drv(dev->driver)->probe(dev);
>  }

A little simpler, but whether it makes sense depends a bit on whether
we expect to see other flows in this function as more features are added.

>  
>  static int cxl_bus_remove(struct device *dev)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8b27a07d7d0f..90107b21125b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -325,6 +325,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  
>  #define CXL_DEVICE_NVDIMM_BRIDGE	1
>  #define CXL_DEVICE_NVDIMM		2
> +#define CXL_DEVICE_REGION		3
>  
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index fe12ef3c3dde..ff1f9c57e089 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -83,4 +83,5 @@ struct cxl_mem {
>  	struct range pmem_range;
>  	struct range ram_range;
>  };
> +

Tidy that up.

>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 41299bd6da53..74d6f6c06608 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -11,6 +11,9 @@
>  #include "cxl.h"
>  #include "mem.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +
>  /**
>   * DOC: cxl region
>   *
> @@ -27,8 +30,24 @@ static struct cxl_region *to_cxl_region(struct device *dev);
>  
>  static bool is_region_active(struct cxl_region *region)
>  {
> -	/* TODO: Regions can't be activated yet. */
> -	return false;
> +	return region->active;
> +}
> +
> +/*
> + * Most sanity checking is left up to region binding. This does the most basic
> + * check to determine whether or not the core should try probing the driver.
> + */
> +bool cxl_is_region_configured(struct cxl_region *region)
> +{
> +	/* zero sized regions aren't a thing. */

Nitpick.  Make these sentences or not.  Either option is fine.

> +	if (region->requested_size <= 0)
> +		return false;
> +
> +	/* all regions have at least 1 target */
> +	if (region->targets[0])
> +		return false;
> +
> +	return true;
>  }
>  
>  static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> @@ -249,16 +268,6 @@ bool is_cxl_region(struct device *dev)
>  	return dev->type == &cxl_region_type;
>  }
>  
> -static struct cxl_region *to_cxl_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> -			  "not a cxl_region device\n"))
> -		return NULL;
> -
> -	return container_of(dev, struct cxl_region, dev);
> -}
> -
> -
>  void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
>  {
>  	int i;
> @@ -383,3 +392,79 @@ int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
>  
>  	return 0;
>  }
> +
> +static int bind_region(struct cxl_region *region)
> +{
> +	int i;
> +
> +	if (dev_WARN_ONCE(&region->dev, !cxl_is_region_configured(region),
> +			  "unconfigured regions can't be probed (race?)\n")) {

Given this check is in here, why do we need the earlier one before we call
probe?  Easier to just have one path given it's not performance sensitive or
anything.

> +		return -ENXIO;
> +	}
> +
> +	if (region->requested_size % (SZ_256M * region->eniw)) {
> +		trace_cxl_region_bind(region, "Invalid size. Must be multiple of NIW");
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < region->eniw; i++)
> +		if (!region->targets[i]) {
> +			trace_cxl_region_bind(region, "Missing memory device target");
> +			return -ENXIO;
> +		}
> +
> +	/* TODO: Allocate from decoder's address space */
> +
> +	/* TODO: program HDM decoders */
> +
> +	if (uuid_is_null(&region->uuid))
> +		uuid_gen(&region->uuid);
> +
> +	trace_cxl_region_bind(region, "Region binding succeeded.");

nitpick, blank line here nice for readability.

> +	return 0;
> +}
> +
> +static int cxl_region_probe(struct device *dev)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +	int ret;
> +
> +	if (region->active)
> +		return -EBUSY;
> +
> +	device_lock(&region->dev);
> +	ret = bind_region(region);
> +	if (!ret)
> +		region->active = true;
> +	device_unlock(&region->dev);
> +
> +	return ret;
> +}
> +
> +static void cxl_region_remove(struct device *dev)
> +{
> +	/* Remove region from the decoder's address space */
> +}
> +
> +static struct cxl_driver cxl_region_driver = {
> +	.name = "cxl_region",
> +	.probe = cxl_region_probe,
> +	.remove = cxl_region_remove,
> +	.id = CXL_DEVICE_REGION,
> +};
> +
> +static __init int cxl_region_init(void)
> +{
> +	return cxl_driver_register(&cxl_region_driver);
> +}
> +
> +static __exit void cxl_region_exit(void)
> +{
> +	cxl_driver_unregister(&cxl_region_driver);
> +}
> +
> +MODULE_LICENSE("GPL v2");
> +module_init(cxl_region_init);
> +module_exit(cxl_region_exit);
> +MODULE_IMPORT_NS(CXL);
> +MODULE_ALIAS_CXL(CXL_REGION);
> diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
> index f2c37a6f1192..7f7331d9029b 100644
> --- a/drivers/cxl/region.h
> +++ b/drivers/cxl/region.h
> @@ -14,6 +14,7 @@
>   * @uuid: The UUID for this region.
>   * @list: Node in decoders region list.
>   * @eniw: Number of interleave ways this region is configured for.
> + * @active: If the region has been activated.
>   * @targets: The memory devices comprising the region.
>   */
>  struct cxl_region {
> @@ -24,10 +25,20 @@ struct cxl_region {
>  	uuid_t uuid;
>  	struct list_head list;
>  	int eniw;
> +	bool active;
>  	struct cxl_memdev *targets[];
>  };
>  
>  bool is_cxl_region(struct device *dev);
>  bool cxl_is_region_configured(struct cxl_region *region);
>  
> +static inline struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_region(dev),
> +			  "not a cxl_region device\n"))
> +		return NULL;
> +
> +	return container_of(dev, struct cxl_region, dev);
> +}
> +
>  #endif
> diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
> new file mode 100644
> index 000000000000..fe9576ec2cde
> --- /dev/null
> +++ b/drivers/cxl/trace.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
> +#define __CXL_TRACE_H__
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(cxl_region_bind,
> +	TP_PROTO(struct cxl_region *region, char *status),
> +	TP_ARGS(region, status),
> +	TP_STRUCT__entry(
> +		__field(struct cxl_region *, region)
> +		__string(status, status)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->region = region;
> +		__assign_str(status, status);
> +	),
> +
> +	TP_printk("%s failed to bind (%s)", dev_name(&__entry->region->dev), __get_str(status))

Is that safe? A quick grep suggests it's not done elsewhere.
From what I recall TP_printk can be called a lot later than where the trace data got pushed.
More than possible region went away in the meantime.

If you want to print this, put the string in the trace point itself.

> +);
> +
> +#endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE trace
> +#include <trace/define_trace.h>

