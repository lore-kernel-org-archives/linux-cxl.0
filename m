Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D67C49EA2
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E4A613E1
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhFQRjO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:39:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:2462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhFQRjN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:13 -0400
IronPort-SDR: rpM/BPwmNyV8JmoOSnOaza4YvWkDtGpgKYIB7VuzGK5bwrVtNh1FtTAlDNQUXoFIeBGwxKbNMn
 5vYqDHavJN4w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732191"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732191"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:04 -0700
IronPort-SDR: vedFzUAGgmkiYV42RF0CyosdN+vlslrCIx4dsThCm2LEAJvgDw0o0sYNuMrxtIOtOyIaD4YV99
 mrFEyvcV5qPA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944108"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/6] cxl/region: Introduce concept of region configuration
Date:   Thu, 17 Jun 2021 10:36:52 -0700
Message-Id: <20210617173655.430424-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617173655.430424-1-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
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

decoder1.0
├── create_region
├── delete_region
├── devtype
├── locked
├── region1.0:0
│   ├── offset
│   ├── size
│   ├── subsystem -> ../../../../../../../bus/cxl
│   ├── target0
│   ├── uevent
│   ├── uuid
│   └── verify
├── size
├── start
├── subsystem -> ../../../../../../bus/cxl
├── target_list
├── target_type
└── uevent

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  32 ++++
 drivers/cxl/region.c                    | 223 ++++++++++++++++++++++++
 2 files changed, 255 insertions(+)

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
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 391467e864a2..cf7fd3027419 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -3,7 +3,9 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/idr.h>
 #include "region.h"
 #include "cxl.h"
@@ -21,16 +23,237 @@
  * relationship between decoder and region when the region is interleaved.
  */
 
+static struct cxl_region *to_cxl_region(struct device *dev);
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
+	return sysfs_emit(buf, "%#llx\n", cxld->range.start - region->res->start);
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
+	if (is_region_active(region)) {
+		rc = -EBUSY;
+	} else {
+		region->requested_size = val;
+	}
+	device_unlock(&region->dev);
+
+	return len;
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
+	if (is_region_active(region)) {
+		rc = -EBUSY;
+	} else {
+		rc = uuid_parse(buf, &region->uuid);
+	}
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
+		ret = sysfs_emit(buf, "%s\n", dev_name(&region->targets[n]->dev));
+	else
+		ret = sysfs_emit(buf, "nil\n");
+	device_unlock(&region->dev);
+
+	return ret;
+}
+
+static size_t set_targetN(struct cxl_region *region, const char *buf, int n, size_t len)
+{
+	struct device *memdev_dev;
+	struct cxl_memdev *cxlmd;
+	ssize_t rc;
+	int val;
+
+	device_lock(&region->dev);
+
+	rc = kstrtoint(buf, 0, &val);
+	/* Special 'remote' target operation */
+	if (!rc && val == 0) {
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
+		return show_targetN(to_cxl_region(dev), buf, n);               \
+	}                                                                      \
+	static ssize_t target##n##_store(struct device *dev,                   \
+					 struct device_attribute *attr,        \
+					 const char *buf, size_t len)          \
+	{                                                                      \
+		return set_targetN(to_cxl_region(dev), buf, n, len);           \
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
 
 const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
+	.groups = region_groups
 };
 
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
 
-- 
2.32.0

