Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101FC4321E
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFFD6054F
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhJVSjj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhJVSjg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528961"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528961"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854699"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:18 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 19/28] cxl/region: Introduce concept of region configuration
Date:   Fri, 22 Oct 2021 11:37:00 -0700
Message-Id: <20211022183709.1199701-20-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The region creation APIs create a vacant region. Configuring the region
works in the same way as similar subsystems such as devdax. Sysfs attrs
will be provided to allow userspace to configure the region.  Finally
once all configuration is complete, userspace may activate the region.

Introduced here are the most basic attributes needed to configure a
region. Details of these attribute are described in the ABI
Documentation.

A example is provided below:

/sys/bus/cxl/devices/region0.0:0
├── interleave_granularity
├── interleave_ways
├── offset
├── size
├── subsystem -> ../../../../../../bus/cxl
├── target0
├── uevent
└── uuid

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++
 drivers/cxl/core/region.c               | 295 ++++++++++++++++++++++++
 2 files changed, 335 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 5c48d2ed108f..ef9b10d05c59 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -150,3 +150,43 @@ Description:
 		region driver before being deleted. The attributes expects a
 		region in the form "regionX.Y:Z". The region's name, allocated
 		by reading create_region, will also be released.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
+Date:		June, 2021
+KernelVersion:	v5.16
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) A region resides within an address space that is claimed by
+		a decoder. Region space allocation is handled by the driver, but
+		the offset may be read by userspace tooling in order to
+		determine fragmentation, and available size for new regions.
+
+What:
+/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{interleave,size,uuid,target[0-15]}
+Date:		June, 2021
+KernelVersion:	v5.16
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Configuring regions requires a minimal set of parameters in
+		order for the subsequent bind operation to succeed. The
+		following parameters are defined:
+
+		==	========================================================
+		interleave_granularity Mandatory. Number of consecutive bytes
+			each device in the interleave set will claim. The
+			possible interleave granularity values are determined by
+			the CXL spec and the participating devices.
+		interleave_ways Mandatory. Number of devices participating in the
+			region. Each device will provide 1/interleave of storage
+			for the region.
+		size	Manadatory. Phsyical address space the region will
+			consume.
+		target  Mandatory. Memory devices are the backing storage for a
+			region. There will be N targets based on the number of
+			interleave ways that the top level decoder is configured
+			for. Each target must be set with a memdev device ie.
+			'mem1'. This attribute only becomes available after
+			setting the 'interleave' attribute.
+		uuid	Optional. A unique identifier for the region. If none is
+			selected, the kernel will create one.
+		==	========================================================
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 588f0ca65bb2..3b0d74d4dd6c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3,9 +3,12 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/idr.h>
 #include <region.h>
+#include <cxlmem.h>
 #include <cxl.h>
 
 /**
@@ -17,11 +20,300 @@
  * (programming the hardware) is handled by a separate region driver.
  */
 
+struct cxl_region *to_cxl_region(struct device *dev);
+static const struct attribute_group region_interleave_group;
+
+static bool is_region_active(struct cxl_region *region)
+{
+	/* TODO: Regions can't be activated yet. */
+	return false;
+}
+
+static void remove_target(struct cxl_region *region, int target)
+{
+	struct cxl_memdev *cxlmd;
+
+	cxlmd = region->targets[target];
+	if (cxlmd)
+		put_device(&cxlmd->dev);
+	region->targets[target] = NULL;
+}
+
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", region->eniw);
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	int ret, prev_eniw;
+	int val;
+
+	prev_eniw = region->eniw;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (ret < 0 || ret > CXL_DECODER_MAX_INTERLEAVE)
+		return -EINVAL;
+
+	region->eniw = val;
+
+	ret = sysfs_update_group(&dev->kobj, &region_interleave_group);
+	if (ret < 0)
+		goto err;
+
+	sysfs_notify(&dev->kobj, NULL, "target_interleave");
+
+	while (prev_eniw > region->eniw)
+		remove_target(region, --prev_eniw);
+
+	return len;
+
+err:
+	region->eniw = prev_eniw;
+	return ret;
+}
+static DEVICE_ATTR_RW(interleave_ways);
+
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", region->ig);
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	region->ig = val;
+
+	return len;
+}
+static DEVICE_ATTR_RW(interleave_granularity);
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+
+	if (!region->res)
+		return sysfs_emit(buf, "\n");
+
+	return sysfs_emit(buf, "%#llx\n", cxld->res.start - region->res->start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%llu\n", region->size);
+}
+
+static ssize_t size_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	unsigned long long val;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	device_lock(&region->dev);
+	if (is_region_active(region))
+		rc = -EBUSY;
+	else
+		region->size = val;
+	device_unlock(&region->dev);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(size);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &region->uuid);
+}
+
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	ssize_t rc;
+
+	if (len != UUID_STRING_LEN + 1)
+		return -EINVAL;
+
+	device_lock(&region->dev);
+	if (is_region_active(region))
+		rc = -EBUSY;
+	else
+		rc = uuid_parse(buf, &region->uuid);
+	device_unlock(&region->dev);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(uuid);
+
+static struct attribute *region_attrs[] = {
+	&dev_attr_interleave_ways.attr,
+	&dev_attr_interleave_granularity.attr,
+	&dev_attr_offset.attr,
+	&dev_attr_size.attr,
+	&dev_attr_uuid.attr,
+	NULL,
+};
+
+static const struct attribute_group region_group = {
+	.attrs = region_attrs,
+};
+
+static size_t show_targetN(struct cxl_region *region, char *buf, int n)
+{
+	int ret;
+
+	device_lock(&region->dev);
+	if (!region->targets[n])
+		ret = sysfs_emit(buf, "\n");
+	else
+		ret = sysfs_emit(buf, "%s\n",
+				 dev_name(&region->targets[n]->dev));
+	device_unlock(&region->dev);
+
+	return ret;
+}
+
+static size_t set_targetN(struct cxl_region *region, const char *buf, int n,
+			  size_t len)
+{
+	struct device *memdev_dev;
+	struct cxl_memdev *cxlmd;
+
+	device_lock(&region->dev);
+
+	if (len == 1 || region->targets[n])
+		remove_target(region, n);
+
+	/* Remove target special case */
+	if (len == 1) {
+		device_unlock(&region->dev);
+		return len;
+	}
+
+	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
+	if (!memdev_dev)
+		return -ENOENT;
+
+	/* reference to memdev held until target is unset or region goes away */
+
+	cxlmd = to_cxl_memdev(memdev_dev);
+	region->targets[n] = cxlmd;
+
+	device_unlock(&region->dev);
+
+	return len;
+}
+
+#define TARGET_ATTR_RW(n)                                                      \
+	static ssize_t target##n##_show(                                       \
+		struct device *dev, struct device_attribute *attr, char *buf)  \
+	{                                                                      \
+		return show_targetN(to_cxl_region(dev), buf, (n));             \
+	}                                                                      \
+	static ssize_t target##n##_store(struct device *dev,                   \
+					 struct device_attribute *attr,        \
+					 const char *buf, size_t len)          \
+	{                                                                      \
+		return set_targetN(to_cxl_region(dev), buf, (n), len);         \
+	}                                                                      \
+	static DEVICE_ATTR_RW(target##n)
+
+TARGET_ATTR_RW(0);
+TARGET_ATTR_RW(1);
+TARGET_ATTR_RW(2);
+TARGET_ATTR_RW(3);
+TARGET_ATTR_RW(4);
+TARGET_ATTR_RW(5);
+TARGET_ATTR_RW(6);
+TARGET_ATTR_RW(7);
+TARGET_ATTR_RW(8);
+TARGET_ATTR_RW(9);
+TARGET_ATTR_RW(10);
+TARGET_ATTR_RW(11);
+TARGET_ATTR_RW(12);
+TARGET_ATTR_RW(13);
+TARGET_ATTR_RW(14);
+TARGET_ATTR_RW(15);
+
+static struct attribute *interleave_attrs[] = {
+	&dev_attr_target0.attr,
+	&dev_attr_target1.attr,
+	&dev_attr_target2.attr,
+	&dev_attr_target3.attr,
+	&dev_attr_target4.attr,
+	&dev_attr_target5.attr,
+	&dev_attr_target6.attr,
+	&dev_attr_target7.attr,
+	&dev_attr_target8.attr,
+	&dev_attr_target9.attr,
+	&dev_attr_target10.attr,
+	&dev_attr_target11.attr,
+	&dev_attr_target12.attr,
+	&dev_attr_target13.attr,
+	&dev_attr_target14.attr,
+	&dev_attr_target15.attr,
+	NULL,
+};
+
+static umode_t visible_targets(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cxl_region *region = to_cxl_region(dev);
+
+	if (n < region->eniw)
+		return a->mode;
+	return 0;
+}
+
+static const struct attribute_group region_interleave_group = {
+	.attrs = interleave_attrs,
+	.is_visible = visible_targets,
+};
+
+static const struct attribute_group *region_groups[] = {
+	&region_group,
+	&region_interleave_group,
+	NULL,
+};
+
 static void cxl_region_release(struct device *dev);
 
 static const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
+	.groups = region_groups
 };
 
 struct cxl_region *to_cxl_region(struct device *dev)
@@ -38,8 +330,11 @@ static void cxl_region_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
 	struct cxl_region *region = to_cxl_region(dev);
+	int i;
 
 	ida_free(&cxld->region_ida, region->id);
+	for (i = 0; i < region->eniw; i++)
+		remove_target(region, i);
 	kfree(region);
 }
 
-- 
2.33.1

