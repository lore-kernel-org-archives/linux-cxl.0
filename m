Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480AC48BE6
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D2613FF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFJS7g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:59:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:35899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFJS7f (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 14:59:35 -0400
IronPort-SDR: wKSeCN5Wwmp/avNoSCq/Fo7tS3//qiDAPEUFF/TG35VvuptWK20MddAp0XO2nfh/DPun18MtLn
 nVvGmgYKavig==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266527362"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266527362"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:38 -0700
IronPort-SDR: STed1BdFswKKvwfvCZqbv4Fj2gIca2nB2fWATAflHIfW4QCOUKTYPWfNs4K3jSTpiS8y01fL/+
 6RU2KVaabdyA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="482963782"
Received: from millers-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.140.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 4/4] cxl/region: Introduce concept of region configuration
Date:   Thu, 10 Jun 2021 11:57:25 -0700
Message-Id: <20210610185725.897541-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610185725.897541-1-ben.widawsky@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
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
 Documentation/ABI/testing/sysfs-bus-cxl |  27 +++
 drivers/cxl/mem.h                       |   2 +
 drivers/cxl/region.c                    | 227 +++++++++++++++++++++++-
 3 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 699c8514fd7b..d7174a84f70d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -159,3 +159,30 @@ Description:
 		integer is returned describing the first error found in the
 		configuration. A verified region can still fail binding due to
 		lack of resources.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/{offset,size}
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		A region resides within an address space that is claimed by a
+		decoder. The region will be of some size within the address
+		space and at some offset that must also reside within the
+		address space. The size and position of the region is specified
+		by these attributes.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/uuid
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		The unique identifier for the region.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/target[0-15]
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Memory devices are the backing storage for a region. Each target
+		must be populated with a memdev in order for the region to be
+		eligible to be activated.
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 9795aa924035..059fbf084fa1 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -58,6 +58,7 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
  * @dev: This region's device.
  * @id: This regions id. Id is globally unique across all regions.
  * @res: Address space consumed by this region.
+ * @uuid: The UUID for this region.
  * @list: Node in decoders region list.
  * @targets: The memory devices comprising the region.
  */
@@ -65,6 +66,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct resource res;
+	uuid_t uuid;
 	struct list_head list;
 	struct cxl_memdev *targets[];
 };
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index ea1ac848c713..a69ee00514cb 100644
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
 #include "cxl.h"
 #include "mem.h"
@@ -20,15 +22,130 @@
  * relationship between decoder and region when the region is interleaved.
  */
 
+static struct cxl_region *to_cxl_region(struct device *dev);
+
+#define cxl_region_ways(region)                                                \
+	to_cxl_decoder((region)->dev.parent)->interleave_ways
+
 static ssize_t verify_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *region = to_cxl_region(dev);
+	struct resource decode_res;
+	int i;
+
+	decode_res = (struct resource)DEFINE_RES_MEM(cxld->range.start,
+						     range_len(&cxld->range));
+
+	/* Invalid region size */
+	if (!resource_contains(&decode_res, &region->res))
+		return sysfs_emit(buf, "size");
+
+	if (resource_size(&region->res) % (SZ_256M * cxld->interleave_ways))
+		return sysfs_emit(buf, "alignment");
+
+	/* Missing target memory device */
+	for (i = 0; i < cxld->interleave_ways; i++)
+		if (!region->targets[i])
+			return sysfs_emit(buf, "memdev");
+
 	return sysfs_emit(buf, "0");
 }
 
 static DEVICE_ATTR_RO(verify);
 
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
+
+	return sysfs_emit(buf, "%#llx\n", region->res.start);
+}
+
+static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	unsigned long long val;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	if (is_region_active(region)) {
+		/* TODO: */
+	} else {
+		region->res.start = val;
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(offset);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%llu\n", resource_size(&region->res));
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
+	if (is_region_active(region)) {
+		/* TODO: */
+	} else {
+		region->res.end = region->res.start + val - 1;
+	}
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
+	rc = uuid_parse(buf, &region->uuid);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_RW(uuid);
+
 static struct attribute *region_attrs[] = {
 	&dev_attr_verify.attr,
+	&dev_attr_offset.attr,
+	&dev_attr_size.attr,
+	&dev_attr_uuid.attr,
 	NULL,
 };
 
@@ -36,8 +153,111 @@ static const struct attribute_group region_group = {
 	.attrs = region_attrs,
 };
 
+static size_t show_targetN(struct cxl_region *region, char *buf, int n)
+{
+	if (region->targets[n])
+		return sysfs_emit(buf, "%s\n", dev_name(&region->targets[n]->dev));
+	else
+		return sysfs_emit(buf, "nil\n");
+}
+
+static size_t set_targetN(struct cxl_region *region, const char *buf, int n, size_t len)
+{
+	struct device *memdev_dev;
+	struct cxl_memdev *cxlmd;
+	ssize_t rc;
+	int val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (!rc && val == 0) {
+		cxlmd = region->targets[n] = cxlmd;
+		if (cxlmd)
+			put_device(&cxlmd->dev);
+		region->targets[n] = NULL;
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
+	if (n < cxl_region_ways(region))
+		return a->mode;
+	return 0;
+}
+
+static const struct attribute_group region_interleave_group = {
+	.attrs = interleave_attrs,
+	.is_visible = visible_targets,
+};
+
 static const struct attribute_group *region_groups[] = {
 	&region_group,
+	&region_interleave_group,
+	NULL,
 };
 
 static void cxl_region_release(struct device *dev);
@@ -58,8 +278,13 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 
 void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
 {
+	int i;
+
 	ida_free(&cxld->region_ida, region->id);
-	kfree(region->targets);
+	for (i = 0; i < cxld->interleave_ways; i++) {
+		if (region->targets[i])
+			put_device(&region->targets[i]->dev);
+	}
 	kfree(region);
 }
 
-- 
2.32.0

