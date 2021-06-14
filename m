Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EAC48BE6
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942F261356
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhFNQU4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 12:20:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:61361 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233643AbhFNQU4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 14 Jun 2021 12:20:56 -0400
IronPort-SDR: X9ZABs64vysTVz8mx0hYtlK1xqYIje0Y7xc5wLpvofbiKBQVwymdkXNGbj8bCygcjmo2vZbj62
 kTAYnm6P8XsA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205656364"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205656364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 09:18:53 -0700
IronPort-SDR: 2Fn/3/lnAaaRb/N120KP+iqYkGekth6TR74+/13VHcM3wNURR/S2sSVht01YN6Rv81w41y1gcm
 tG/fY5C9jblw==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="636830949"
Received: from smothe-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.124])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 09:18:53 -0700
Date:   Mon, 14 Jun 2021 09:18:51 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce concept of region
 configuration
Message-ID: <20210614161851.iipfwo5dvxkht7yw@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <20210610185725.897541-5-ben.widawsky@intel.com>
 <20210611145206.00003c50@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611145206.00003c50@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-11 14:52:06, Jonathan Cameron wrote:
> On Thu, 10 Jun 2021 11:57:25 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The region creation APIs leave a region unconfigured. Configuring the
> > region will work in the same way as similar subsystems such as devdax.
> > Sysfs attrs will be provided to allow userspace to configure the region.
> > Finally once all configuration is complete, userspace may "commit" the
> > config. What the kernel decides to do after a config is committed is out
> > of scope at this point.
> > 
> > Introduced here are the most basic attributes needed to configure a
> > region.
> > 
> > A x1 interleave example is provided below:
> > 
> > decoder1.0
> > ├── create_region
> > ├── delete_region
> > ├── devtype
> > ├── locked
> > ├── region1.0:0
> > │   ├── offset
> > │   ├── size
> > │   ├── subsystem -> ../../../../../../../bus/cxl
> > │   ├── target0
> > │   ├── uevent
> > │   ├── uuid
> > │   └── verify
> > ├── size
> > ├── start
> > ├── subsystem -> ../../../../../../bus/cxl
> > ├── target_list
> > ├── target_type
> > └── uevent
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |  27 +++
> >  drivers/cxl/mem.h                       |   2 +
> >  drivers/cxl/region.c                    | 227 +++++++++++++++++++++++-
> >  3 files changed, 255 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 699c8514fd7b..d7174a84f70d 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -159,3 +159,30 @@ Description:
> >  		integer is returned describing the first error found in the
> >  		configuration. A verified region can still fail binding due to
> >  		lack of resources.
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{offset,size}
> 
> I missed this before, but why do we need X.Y in the region naming given it's
> always inside decoderX.Y.  Seems like RegionZ would work.
> 

Yes. There are two options, either we do X.Y:Z, or Z where Z is globally unique
across all decoders. The reason for this is the devices are symlinked into sysfs
and so you can't have the same Z for multiple regions in different decoders.

My preference is to have regionX.y:[0-n] for each decoder, rather than the globally
unique. I'll entertain an argument the other way though.

> > +Date:		June, 2021
> > +KernelVersion:	v5.14
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		A region resides within an address space that is claimed by a
> > +		decoder. The region will be of some size within the address
> > +		space and at some offset that must also reside within the
> > +		address space. The size and position of the region is specified
> > +		by these attributes.
> Could perhaps reword this.  Something like.
> 
> 		The region defined by size and offset must be fully contained
> 		within the address space.
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/uuid
> > +Date:		June, 2021
> > +KernelVersion:	v5.14
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		The unique identifier for the region.
> > +
> > +What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/target[0-15]
> > +Date:		June, 2021
> > +KernelVersion:	v5.14
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		Memory devices are the backing storage for a region. Each target
> > +		must be populated with a memdev in order for the region to be
> > +		eligible to be activated.
> 
> How do you do that?  What is written to this file?

A name of the dev is written here, ie "mem0". I can add this to the
documentation...

> 
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 9795aa924035..059fbf084fa1 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -58,6 +58,7 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> >   * @dev: This region's device.
> >   * @id: This regions id. Id is globally unique across all regions.
> >   * @res: Address space consumed by this region.
> > + * @uuid: The UUID for this region.
> >   * @list: Node in decoders region list.
> >   * @targets: The memory devices comprising the region.
> >   */
> > @@ -65,6 +66,7 @@ struct cxl_region {
> >  	struct device dev;
> >  	int id;
> >  	struct resource res;
> > +	uuid_t uuid;
> >  	struct list_head list;
> >  	struct cxl_memdev *targets[];
> >  };
> > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > index ea1ac848c713..a69ee00514cb 100644
> > --- a/drivers/cxl/region.c
> > +++ b/drivers/cxl/region.c
> > @@ -3,7 +3,9 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/sizes.h>
> >  #include <linux/slab.h>
> > +#include <linux/uuid.h>
> >  #include <linux/idr.h>
> >  #include "cxl.h"
> >  #include "mem.h"
> > @@ -20,15 +22,130 @@
> >   * relationship between decoder and region when the region is interleaved.
> >   */
> >  
> > +static struct cxl_region *to_cxl_region(struct device *dev);
> > +
> > +#define cxl_region_ways(region)                                                \
> > +	to_cxl_decoder((region)->dev.parent)->interleave_ways
> > +
> >  static ssize_t verify_show(struct device *dev, struct device_attribute *attr, char *buf)
> >  {
> > +	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +	struct resource decode_res;
> > +	int i;
> > +
> > +	decode_res = (struct resource)DEFINE_RES_MEM(cxld->range.start,
> > +						     range_len(&cxld->range));
> > +
> > +	/* Invalid region size */
> > +	if (!resource_contains(&decode_res, &region->res))
> > +		return sysfs_emit(buf, "size");
> 
> Perhaps "outside region"?  Size might be fine, but not the offset.
> Also, docs say a negative integer is returned for this attribute.
> Those docs need to call out the full list of things that might be returned
> so that userspace can know what to expect.

Okay.

> 
> > +
> > +	if (resource_size(&region->res) % (SZ_256M * cxld->interleave_ways))
> > +		return sysfs_emit(buf, "alignment");
> > +
> > +	/* Missing target memory device */
> > +	for (i = 0; i < cxld->interleave_ways; i++)
> > +		if (!region->targets[i])
> > +			return sysfs_emit(buf, "memdev");
> > +
> >  	return sysfs_emit(buf, "0");
> >  }
> >  
> >  static DEVICE_ATTR_RO(verify);
> >  
> > +static bool is_region_active(struct cxl_region *region)
> > +{
> > +	/* TODO: Regions can't be activated yet. */
> > +	return false;
> > +}
> > +
> > +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +
> > +	return sysfs_emit(buf, "%#llx\n", region->res.start);
> > +}
> > +
> > +static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
> > +			    const char *buf, size_t len)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +	unsigned long long val;
> > +	ssize_t rc;
> > +
> > +	rc = kstrtoull(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (is_region_active(region)) {
> > +		/* TODO: */
> > +	} else {
> > +		region->res.start = val;
> > +	}
> > +
> > +	return len;
> > +}
> > +
> > +static DEVICE_ATTR_RW(offset);
> > +
> > +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> > +			 char *buf)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +
> > +	return sysfs_emit(buf, "%llu\n", resource_size(&region->res));
> > +}
> > +
> > +static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> > +			  const char *buf, size_t len)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +	unsigned long long val;
> > +	ssize_t rc;
> > +
> > +	rc = kstrtoull(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (is_region_active(region)) {
> > +		/* TODO: */
> > +	} else {
> > +		region->res.end = region->res.start + val - 1;
> > +	}
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_RW(size);
> > +
> > +static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> > +			 char *buf)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +
> > +	return sysfs_emit(buf, "%pUb\n", &region->uuid);
> > +}
> > +static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> > +			  const char *buf, size_t len)
> > +{
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +	ssize_t rc;
> > +
> > +	if (len != UUID_STRING_LEN + 1)
> > +		return -EINVAL;
> > +
> > +	rc = uuid_parse(buf, &region->uuid);
> > +
> > +	return rc ? rc : len;
> > +}
> > +static DEVICE_ATTR_RW(uuid);
> > +
> >  static struct attribute *region_attrs[] = {
> >  	&dev_attr_verify.attr,
> > +	&dev_attr_offset.attr,
> > +	&dev_attr_size.attr,
> > +	&dev_attr_uuid.attr,
> >  	NULL,
> >  };
> >  
> > @@ -36,8 +153,111 @@ static const struct attribute_group region_group = {
> >  	.attrs = region_attrs,
> >  };
> >  
> > +static size_t show_targetN(struct cxl_region *region, char *buf, int n)
> > +{
> > +	if (region->targets[n])
> > +		return sysfs_emit(buf, "%s\n", dev_name(&region->targets[n]->dev));
> > +	else
> > +		return sysfs_emit(buf, "nil\n");
> 
> This needs documenting in the ABI docs. I'd I guessed it would return an empty
> string.

Okay.

> 
> > +}
> > +
> > +static size_t set_targetN(struct cxl_region *region, const char *buf, int n, size_t len)
> > +{
> > +	struct device *memdev_dev;
> > +	struct cxl_memdev *cxlmd;
> > +	ssize_t rc;
> > +	int val;
> > +
> > +	rc = kstrtoint(buf, 0, &val);
> > +	if (!rc && val == 0) {
> > +		cxlmd = region->targets[n] = cxlmd;
> > +		if (cxlmd)
> > +			put_device(&cxlmd->dev);
> > +		region->targets[n] = NULL;
> > +		return len;
> > +	}
> > +
> > +	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > +	if (!memdev_dev)
> > +		return -ENOENT;
> > +
> > +	cxlmd = to_cxl_memdev(memdev_dev);
> > +	get_device(&cxlmd->dev);
> > +	region->targets[n] = cxlmd;
> > +
> > +	return len;
> > +}
> > +
> > +#define TARGET_ATTR_RW(n)                                                      \
> > +	static ssize_t target##n##_show(                                       \
G> > +		struct device *dev, struct device_attribute *attr, char *buf)  \
> > +	{                                                                      \
> > +		return show_targetN(to_cxl_region(dev), buf, n);               \
> > +	}                                                                      \
> > +	static ssize_t target##n##_store(struct device *dev,                   \
> > +					 struct device_attribute *attr,        \
> > +					 const char *buf, size_t len)          \
> > +	{                                                                      \
> > +		return set_targetN(to_cxl_region(dev), buf, n, len);           \
> > +	}                                                                      \
> > +	static DEVICE_ATTR_RW(target##n)
> > +
> > +TARGET_ATTR_RW(0);
> > +TARGET_ATTR_RW(1);
> > +TARGET_ATTR_RW(2);
> > +TARGET_ATTR_RW(3);
> > +TARGET_ATTR_RW(4);
> > +TARGET_ATTR_RW(5);
> > +TARGET_ATTR_RW(6);
> > +TARGET_ATTR_RW(7);
> > +TARGET_ATTR_RW(8);
> > +TARGET_ATTR_RW(9);
> > +TARGET_ATTR_RW(10);
> > +TARGET_ATTR_RW(11);
> > +TARGET_ATTR_RW(12);
> > +TARGET_ATTR_RW(13);
> > +TARGET_ATTR_RW(14);
> > +TARGET_ATTR_RW(15);
> > +
> > +static struct attribute *interleave_attrs[] = {
> > +	&dev_attr_target0.attr,
> > +	&dev_attr_target1.attr,
> > +	&dev_attr_target2.attr,
> > +	&dev_attr_target3.attr,
> > +	&dev_attr_target4.attr,
> > +	&dev_attr_target5.attr,
> > +	&dev_attr_target6.attr,
> > +	&dev_attr_target7.attr,
> > +	&dev_attr_target8.attr,
> > +	&dev_attr_target9.attr,
> > +	&dev_attr_target10.attr,
> > +	&dev_attr_target11.attr,
> > +	&dev_attr_target12.attr,
> > +	&dev_attr_target13.attr,
> > +	&dev_attr_target14.attr,
> > +	&dev_attr_target15.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct cxl_region *region = to_cxl_region(dev);
> > +
> > +	if (n < cxl_region_ways(region))
> > +		return a->mode;
> > +	return 0;
> > +}
> > +
> > +static const struct attribute_group region_interleave_group = {
> > +	.attrs = interleave_attrs,
> > +	.is_visible = visible_targets,
> > +};
> > +
> >  static const struct attribute_group *region_groups[] = {
> >  	&region_group,
> > +	&region_interleave_group,
> > +	NULL,
> >  };
> >  
> >  static void cxl_region_release(struct device *dev);
> > @@ -58,8 +278,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
> >  
> >  void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
> >  {
> > +	int i;
> > +
> >  	ida_free(&cxld->region_ida, region->id);
> > -	kfree(region->targets);
> 
> This line looks like a bug in earlier patch as targets is allocated
> as part of the allocation of region.

Yep, thanks.

> 
> > +	for (i = 0; i < cxld->interleave_ways; i++) {
> > +		if (region->targets[i])
> > +			put_device(&region->targets[i]->dev);
> > +	}
> >  	kfree(region);
> >  }
> >  
> 
