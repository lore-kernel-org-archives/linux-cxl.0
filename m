Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E4C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B90B6112D
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFRLY6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:24:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3269 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhFRLY6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 07:24:58 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5x9S4GYnz6M4ZR;
        Fri, 18 Jun 2021 19:13:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 13:22:47 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 12:22:46 +0100
Date:   Fri, 18 Jun 2021 12:22:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/6] cxl/region: Introduce concept of region
 configuration
Message-ID: <20210618122237.00005e7f@Huawei.com>
In-Reply-To: <20210617173655.430424-4-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
        <20210617173655.430424-4-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 10:36:52 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The region creation APIs leave a region unconfigured. Configuring the
> region will work in the same way as similar subsystems such as devdax.
> Sysfs attrs will be provided to allow userspace to configure the region.
> Finally once all configuration is complete, userspace may "commit" the
> config. What the kernel decides to do after a config is committed is out
> of scope at this point.
> 
> Introduced here are the most basic attributes needed to configure a
> region.
> 
> A x1 interleave example is provided below:
> 
> decoder1.0
> ├── create_region
> ├── delete_region
> ├── devtype
> ├── locked
> ├── region1.0:0
> │   ├── offset
> │   ├── size
> │   ├── subsystem -> ../../../../../../../bus/cxl
> │   ├── target0
> │   ├── uevent
> │   ├── uuid
> │   └── verify
> ├── size
> ├── start
> ├── subsystem -> ../../../../../../bus/cxl
> ├── target_list
> ├── target_type
> └── uevent
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Hi Ben,

I think some of the sysfs interface needs more detailed docs
and consideration about consistency.

If an interface isn't fairly obvious without reading the docs
(but understanding what it is trying to do) then it's normally
a bad sign...

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  32 ++++
>  drivers/cxl/region.c                    | 223 ++++++++++++++++++++++++
>  2 files changed, 255 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 115a25d2899d..70f9d09385a4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -148,3 +148,35 @@ Description:
>  		Deletes the named region. A region must be unbound from the
>  		region driver before being deleted. The attributes expects a
>  		region in the form "regionX.Y:Z".
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
> +Date:		June, 2021
> +KernelVersion:	v5.14
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) A region resides within an address space that is claimed by
> +		a decoder. Region space allocation is handled by the driver, but
> +		the offset may be read by userspace tooling in order to
> +		determine fragmentation, and available size for new regions.

Side note rather than abotu this patch.  Feels to me like the format definition
of these docs should include something on permissions.  The (RO) bit is fine
but makes the docs less machine readable.  

> +
> +What:
> +/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{size,uuid,target[0-15]}
> +Date:		June, 2021
> +KernelVersion:	v5.14
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) Configuring regions requires a minimal set of parameters in
> +		order for the subsequent bind operation to succeed. The
> +		following parameters are defined:
> +
> +		==	========================================================
> +		size	Manadatory. Phsyical address space the region will

Spell check.

> +			consume.
> +		uuid	Optional. A unique identifier for the region. If none is
> +			selected, the kernel will create one.
> +		target  Mandatory. Memory devices are the backing storage for a
> +			region. There will be N targets based on the number of
> +			interleave ways that the top level decoder is configured
> +			for. Each target must be set with a memdev device ie.
> +			'mem1'.

Document what happens if not set.  'nil' is not obvious.

> +		==	========================================================

The automation looking at these files is increasing, so I wonder if that will
cause some issues with having these all documented in one block.

I don't see a huge disadvantage in breaking this into 3 entries.  Alternatively
wait for someone to scream and refactor it then.

> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 391467e864a2..cf7fd3027419 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -3,7 +3,9 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/uuid.h>
>  #include <linux/idr.h>
>  #include "region.h"
>  #include "cxl.h"
> @@ -21,16 +23,237 @@
>   * relationship between decoder and region when the region is interleaved.
>   */
>  
> +static struct cxl_region *to_cxl_region(struct device *dev);
> +
> +static bool is_region_active(struct cxl_region *region)
> +{
> +	/* TODO: Regions can't be activated yet. */
> +	return false;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> +
> +	if (!region->res)
> +		return sysfs_emit(buf, "\n");
> +
> +	return sysfs_emit(buf, "%#llx\n", cxld->range.start - region->res->start);
> +}
> +static DEVICE_ATTR_RO(offset);
> +
> +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +
> +	if (!region->res)
> +		return sysfs_emit(buf, "*%llu\n", region->requested_size);
> +
> +	return sysfs_emit(buf, "%llu\n", resource_size(region->res));
> +}
> +
> +static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +	unsigned long long val;
> +	ssize_t rc;
> +
> +	rc = kstrtoull(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	device_lock(&region->dev);
> +	if (is_region_active(region)) {
> +		rc = -EBUSY;
> +	} else {
> +		region->requested_size = val;
> +	}
> +	device_unlock(&region->dev);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(size);
> +
> +static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +
> +	return sysfs_emit(buf, "%pUb\n", &region->uuid);
> +}
> +static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct cxl_region *region = to_cxl_region(dev);
> +	ssize_t rc;
> +
> +	if (len != UUID_STRING_LEN + 1)
> +		return -EINVAL;
> +
> +	device_lock(&region->dev);
> +	if (is_region_active(region)) {
> +		rc = -EBUSY;
> +	} else {
> +		rc = uuid_parse(buf, &region->uuid);
> +	}
> +	device_unlock(&region->dev);
> +
> +	return rc ? rc : len;
> +}
> +static DEVICE_ATTR_RW(uuid);
> +
> +static struct attribute *region_attrs[] = {
> +	&dev_attr_offset.attr,
> +	&dev_attr_size.attr,
> +	&dev_attr_uuid.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group region_group = {
> +	.attrs = region_attrs,
> +};
> +
> +static size_t show_targetN(struct cxl_region *region, char *buf, int n)
> +{
> +	int ret;
> +
> +	device_lock(&region->dev);
> +	if (!region->targets[n])
> +		ret = sysfs_emit(buf, "%s\n", dev_name(&region->targets[n]->dev));
> +	else
> +		ret = sysfs_emit(buf, "nil\n");
> +	device_unlock(&region->dev);
> +
> +	return ret;
> +}
> +
> +static size_t set_targetN(struct cxl_region *region, const char *buf, int n, size_t len)
> +{
> +	struct device *memdev_dev;
> +	struct cxl_memdev *cxlmd;
> +	ssize_t rc;
> +	int val;
> +
> +	device_lock(&region->dev);
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	/* Special 'remote' target operation */

remote?

> +	if (!rc && val == 0) {

I'm not sure on logic here.  This seems to be if the value is valid and 0
we do something different?  Why is 0 special? It's not documented as such
and the thing returns nil, not 0.

> +		cxlmd = region->targets[n];
> +		if (cxlmd)
> +			put_device(&cxlmd->dev);
> +		region->targets[n] = NULL;
> +		device_unlock(&region->dev);
> +		return len;
> +	}
> +
> +	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> +	if (!memdev_dev)
> +		return -ENOENT;
> +
> +	cxlmd = to_cxl_memdev(memdev_dev);
> +	get_device(&cxlmd->dev);
> +	region->targets[n] = cxlmd;
> +
> +	device_unlock(&region->dev);
> +
> +	return len;
> +}
> +
> +#define TARGET_ATTR_RW(n)                                                      \
> +	static ssize_t target##n##_show(                                       \
> +		struct device *dev, struct device_attribute *attr, char *buf)  \
> +	{                                                                      \
> +		return show_targetN(to_cxl_region(dev), buf, n);               \
> +	}                                                                      \
> +	static ssize_t target##n##_store(struct device *dev,                   \
> +					 struct device_attribute *attr,        \
> +					 const char *buf, size_t len)          \
> +	{                                                                      \
> +		return set_targetN(to_cxl_region(dev), buf, n, len);           \
> +	}                                                                      \
> +	static DEVICE_ATTR_RW(target##n)
> +
> +TARGET_ATTR_RW(0);
> +TARGET_ATTR_RW(1);
> +TARGET_ATTR_RW(2);
> +TARGET_ATTR_RW(3);
> +TARGET_ATTR_RW(4);
> +TARGET_ATTR_RW(5);
> +TARGET_ATTR_RW(6);
> +TARGET_ATTR_RW(7);
> +TARGET_ATTR_RW(8);
> +TARGET_ATTR_RW(9);
> +TARGET_ATTR_RW(10);
> +TARGET_ATTR_RW(11);
> +TARGET_ATTR_RW(12);
> +TARGET_ATTR_RW(13);
> +TARGET_ATTR_RW(14);
> +TARGET_ATTR_RW(15);
> +
> +static struct attribute *interleave_attrs[] = {
> +	&dev_attr_target0.attr,
> +	&dev_attr_target1.attr,
> +	&dev_attr_target2.attr,
> +	&dev_attr_target3.attr,
> +	&dev_attr_target4.attr,
> +	&dev_attr_target5.attr,
> +	&dev_attr_target6.attr,
> +	&dev_attr_target7.attr,
> +	&dev_attr_target8.attr,
> +	&dev_attr_target9.attr,
> +	&dev_attr_target10.attr,
> +	&dev_attr_target11.attr,
> +	&dev_attr_target12.attr,
> +	&dev_attr_target13.attr,
> +	&dev_attr_target14.attr,
> +	&dev_attr_target15.attr,
> +	NULL,
> +};
> +
> +static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct cxl_region *region = to_cxl_region(dev);
> +
> +	if (n < region->eniw)
> +		return a->mode;
> +	return 0;
> +}
> +
> +static const struct attribute_group region_interleave_group = {
> +	.attrs = interleave_attrs,
> +	.is_visible = visible_targets,
> +};
> +
> +static const struct attribute_group *region_groups[] = {
> +	&region_group,
> +	&region_interleave_group,
> +	NULL,
> +};
> +
>  static void cxl_region_release(struct device *dev);
>  
>  const struct device_type cxl_region_type = {
>  	.name = "cxl_region",
>  	.release = cxl_region_release,
> +	.groups = region_groups
>  };
>  
>  void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
>  {
> +	int i;
> +
>  	ida_free(&cxld->region_ida, region->id);
> +	for (i = 0; i < region->eniw; i++) {
> +		if (region->targets[i])
> +			put_device(&region->targets[i]->dev);
> +	}
> +
>  	kfree(region);
>  }
>  

