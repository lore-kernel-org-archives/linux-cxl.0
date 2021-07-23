Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674BC19F2F
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052D660F25
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhGWU0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhGWU0H (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671205"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671205"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436156"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 13/23] cxl/region: Introduce concept of region configuration
Date:   Fri, 23 Jul 2021 14:06:13 -0700
Message-Id: <20210723210623.114073-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The region creation APIs leave a region unconfigured. Configuring the
region will work in the same way as similar subsystems such as devdax.
Sysfs attrs will be provided to allow userspace to configure the region.
Finally once all configuration is complete, userspace may "commit" the
config. What the kernel decides to do after a config is committed is out
of scope at this point.

Introduced here are the most basic attributes needed to configure a
region.

A x1 interleave example is provided below:

decoder0.0
├── create_region
├── delete_region
├── devtype
├── locked
├── region0.0:0
│   ├── offset
│   ├── size
│   ├── subsystem -> ../../../../../../../bus/cxl
│   ├── target0
│   ├── uevent
│   ├── uuid
├── size
├── start
├── subsystem -> ../../../../../../bus/cxl
├── target_list
├── target_type
└── uevent

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  32 ++++
 drivers/cxl/core/memdev.c               |   5 -
 drivers/cxl/core/region.c               | 222 ++++++++++++++++++++++++
 drivers/cxl/mem.h                       |   5 +
 4 files changed, 259 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 115a25d2899d..70f9d09385a4 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -148,3 +148,35 @@ Description:
 		Deletes the named region. A region must be unbound from the
 		region driver before being deleted. The attributes expects a
 		region in the form "regionX.Y:Z".
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/offset
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) A region resides within an address space that is claimed by
+		a decoder. Region space allocation is handled by the driver, but
+		the offset may be read by userspace tooling in order to
+		determine fragmentation, and available size for new regions.
+
+What:
+/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{size,uuid,target[0-15]}
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Configuring regions requires a minimal set of parameters in
+		order for the subsequent bind operation to succeed. The
+		following parameters are defined:
+
+		==	========================================================
+		size	Manadatory. Phsyical address space the region will
+			consume.
+		uuid	Optional. A unique identifier for the region. If none is
+			selected, the kernel will create one.
+		target  Mandatory. Memory devices are the backing storage for a
+			region. There will be N targets based on the number of
+			interleave ways that the top level decoder is configured
+			for. Each target must be set with a memdev device ie.
+			'mem1'.
+		==	========================================================
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dce43e03a05b..bdf811c02b4d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -9,11 +9,6 @@
 
 static DEFINE_IDA(cxl_memdev_ida);
 
-static struct cxl_memdev *to_cxl_memdev(struct device *dev)
-{
-	return container_of(dev, struct cxl_memdev, dev);
-}
-
 static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index caa34f59a62d..8ed513951730 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3,7 +3,9 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/idr.h>
 #include "core.h"
 
@@ -16,11 +18,224 @@
  * (programming the hardware) is handled by a separate region driver.
  */
 
+struct cxl_region *to_cxl_region(struct device *dev);
+
+static bool is_region_active(struct cxl_region *region)
+{
+	/* TODO: Regions can't be activated yet. */
+	return false;
+}
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
+	return sysfs_emit(buf, "%#llx\n",
+			  cxld->range.start - region->res->start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	if (!region->res)
+		return sysfs_emit(buf, "*%llu\n", region->requested_size);
+
+	return sysfs_emit(buf, "%llu\n", resource_size(region->res));
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
+		region->requested_size = val;
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
+	/* Remove target special case */
+	if (len == 1) {
+		cxlmd = region->targets[n];
+		if (cxlmd)
+			put_device(&cxlmd->dev);
+		region->targets[n] = NULL;
+		device_unlock(&region->dev);
+		return len;
+	}
+
+	memdev_dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
+	if (!memdev_dev)
+		return -ENOENT;
+
+	cxlmd = to_cxl_memdev(memdev_dev);
+	get_device(&cxlmd->dev);
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
 
 bool is_cxl_region(struct device *dev)
@@ -41,7 +256,14 @@ EXPORT_SYMBOL_GPL(to_cxl_region);
 
 void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
 {
+	int i;
+
 	ida_free(&cxld->region_ida, region->id);
+	for (i = 0; i < region->eniw; i++) {
+		if (region->targets[i])
+			put_device(&region->targets[i]->dev);
+	}
+
 	kfree(region);
 }
 
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 3730e3509ab6..7765f59c890d 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -57,6 +57,11 @@ devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
 		    const struct file_operations *fops,
 		    void (*shutdown)(struct cxl_memdev *cxlmd));
 
+static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_memdev, dev);
+}
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
-- 
2.32.0

