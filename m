Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326AAC43217
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FC46054F
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhJVSji (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:5584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhJVSjg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528960"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854688"
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
Subject: [RFC PATCH v2 18/28] cxl/region: Add region creation ABI
Date:   Fri, 22 Oct 2021 11:36:59 -0700
Message-Id: <20211022183709.1199701-19-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Regions are created as a child of the decoder that encompasses an
address space with constraints. Regions have a number of attributes that
must be configured before the region can be activated.

The ABI is not meant to be secure, but is meant to avoid accidental
races. As a result, a buggy process may create a region by name that was
allocated by a different process. However, multiple processes which are
trying not to race with each other shouldn't need special
synchronization to do so.

// Allocate a new region name
region = $(cat /sys/bus/cxl/devices/decoder0.0/create_region)

// Create a new region by name
echo $region > /sys/bus/cxl/devices/decoder0.0/create_region

// Region now exists in sysfs
stat -t /sys/bus/cxl/devices/decoder0.0/$region

// Delete the region, and name
echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region

After creating a region, it will show up in sysfs

/sys/bus/cxl/devices/
├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
├── decoder1.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/decoder1.0
├── decoder2.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2/decoder2.0
├── mem0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem0
├── pmem0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem0/pmem0
├── port1 -> ../../../devices/platform/ACPI0017:00/root0/port1
├── port2 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2
└── root0 -> ../../../devices/platform/ACPI0017:00/root0

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl       |  23 +++
 .../driver-api/cxl/memory-devices.rst         |  11 ++
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/bus.c                        |  84 +++++++++++
 drivers/cxl/core/region.c                     | 139 ++++++++++++++++++
 drivers/cxl/cxl.h                             |   9 ++
 drivers/cxl/region.h                          |  37 +++++
 tools/testing/cxl/Kbuild                      |   1 +
 8 files changed, 305 insertions(+)
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/region.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0b6a2e6e8fbb..5c48d2ed108f 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -127,3 +127,26 @@ Description:
 		memory (type-3). The 'target_type' attribute indicates the
 		current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/create_region
+Date:		June, 2021
+KernelVersion:	v5.16
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Creates a new CXL region. Writing a value of the form
+		"regionX.Y:Z" will create a new uninitialized region that will
+		be mapped by the CXL decoderX.Y. Reading from this node will
+		return a newly allocated region name. In order to create a
+		region (writing) you must use a value returned from reading the
+		node. Regions must be subsequently configured and bound to a
+		region driver before they can be used.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
+Date:		June, 2021
+KernelVersion:	v5.16
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Deletes the named region. A region must be unbound from the
+		region driver before being deleted. The attributes expects a
+		region in the form "regionX.Y:Z". The region's name, allocated
+		by reading create_region, will also be released.
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index d04d07ae7118..0ed00906acdd 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -65,6 +65,17 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/mbox.c
    :doc: cxl mbox
 
+CXL Regions
+-----------
+.. kernel-doc:: drivers/cxl/region.h
+   :identifiers:
+
+.. kernel-doc:: drivers/cxl/core/region.c
+   :doc: cxl core region
+
+.. kernel-doc:: drivers/cxl/core/region.c
+   :identifiers:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9d33d2d5bf09..6a3b3ecd7a25 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CXL_BUS) += cxl_core.o
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(srctree)/drivers/cxl
 cxl_core-y := bus.o
 cxl_core-y += pmem.o
+cxl_core-y += region.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 4b4e6033b774..7a51a290ed25 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -157,6 +157,74 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
+static ssize_t create_region_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int rc;
+
+	if (dev_WARN_ONCE(dev, !is_root_decoder(dev),
+			  "Invalid decoder selected for region.")) {
+		return -ENODEV;
+	}
+
+	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
+	if (rc < 0) {
+		dev_err(&cxld->dev, "Couldn't get a new id\n");
+		return rc;
+	}
+
+	return sysfs_emit(buf, "region%d.%d:%d\n", port->id, cxld->id, rc);
+}
+
+static ssize_t create_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int decoder, port, region_id;
+	struct cxl_region *region;
+	ssize_t rc;
+
+	if (sscanf(buf, "region%d.%d:%d", &decoder, &port, &region_id) != 3)
+		return -EINVAL;
+
+	if (decoder != cxld->id)
+		return -EINVAL;
+
+	if (cxld->id != port)
+		return -EINVAL;
+
+	region = cxl_alloc_region(cxld, region_id);
+	if (IS_ERR(region))
+		return PTR_ERR(region);
+
+	rc = cxl_add_region(cxld, region);
+	if (rc) {
+		kfree(region);
+		return rc;
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RW(create_region);
+
+static ssize_t delete_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int rc;
+
+	rc = cxl_delete_region(cxld, buf);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(delete_region);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
@@ -170,6 +238,8 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 };
 
 static struct attribute *cxl_decoder_root_attrs[] = {
+	&dev_attr_create_region.attr,
+	&dev_attr_delete_region.attr,
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
@@ -210,11 +280,23 @@ static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
 	NULL,
 };
 
+static int delete_region(struct device *dev, void *arg)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+
+	return cxl_delete_region(cxld, dev_name(dev));
+}
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 
+	device_for_each_child(&cxld->dev, cxld, delete_region);
+
+	dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
+		      "Lost track of a region");
+
 	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
 }
@@ -750,6 +832,8 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	else
 		dev->type = &cxl_decoder_root_type;
 
+	ida_init(&cxld->region_ida);
+
 	return cxld;
 err:
 	kfree(cxld);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
new file mode 100644
index 000000000000..588f0ca65bb2
--- /dev/null
+++ b/drivers/cxl/core/region.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <region.h>
+#include <cxl.h>
+
+/**
+ * DOC: cxl core region
+ *
+ * Regions are managed through the Linux device model. Each region instance is a
+ * unique struct device. CXL core provides functionality to create, destroy, and
+ * configure regions. This is all implemented here. Binding a region
+ * (programming the hardware) is handled by a separate region driver.
+ */
+
+static void cxl_region_release(struct device *dev);
+
+static const struct device_type cxl_region_type = {
+	.name = "cxl_region",
+	.release = cxl_region_release,
+};
+
+struct cxl_region *to_cxl_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
+			  "not a cxl_region device\n"))
+		return NULL;
+
+	return container_of(dev, struct cxl_region, dev);
+}
+EXPORT_SYMBOL_GPL(to_cxl_region);
+
+static void cxl_region_release(struct device *dev)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *region = to_cxl_region(dev);
+
+	ida_free(&cxld->region_ida, region->id);
+	kfree(region);
+}
+
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
+{
+	struct cxl_region *region;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return ERR_PTR(-ENOMEM);
+
+	region->id = id;
+
+	return region;
+}
+
+/**
+ * cxl_add_region - Adds a region to a decoder
+ * @cxld: Parent decoder.
+ * @region: Region to be added to the decoder.
+ *
+ * This is the second step of region initialization. Regions exist within an
+ * address space which is mapped by a @cxld. That @cxld must be a root decoder,
+ * and it enforces constraints upon the region as it is configured.
+ *
+ * Return: 0 if the region was added to the @cxld, else returns negative error
+ * code. The region will be named "regionX.Y.Z" where X is the port, Y is the
+ * decoder id, and Z is the region number.
+ */
+int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct device *dev = &region->dev;
+	int rc;
+
+	device_initialize(dev);
+	dev->parent = &cxld->dev;
+	device_set_pm_not_required(dev);
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_region_type;
+	rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id,
+			  region->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(dev, "Added %s to %s\n", dev_name(dev), dev_name(&cxld->dev));
+
+	return 0;
+
+err:
+	put_device(dev);
+	return rc;
+}
+
+static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,
+						  const char *name)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child_by_name(&cxld->dev, name);
+	if (!region_dev)
+		return ERR_PTR(-ENOENT);
+
+	return to_cxl_region(region_dev);
+}
+
+/**
+ * cxl_delete_region - Deletes a region
+ * @cxld: Parent decoder
+ * @region_name: Named region, ie. regionX.Y:Z
+ */
+int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
+{
+	struct cxl_region *region;
+
+	device_lock(&cxld->dev);
+
+	region = cxl_find_region_by_name(cxld, region_name);
+	if (IS_ERR(region)) {
+		device_unlock(&cxld->dev);
+		return PTR_ERR(region);
+	}
+
+	dev_dbg(&cxld->dev, "Requested removal of %s from %s\n",
+		dev_name(&region->dev), dev_name(&cxld->dev));
+
+	device_unregister(&region->dev);
+	device_unlock(&cxld->dev);
+
+	put_device(&region->dev);
+
+	return 0;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5823c267a4de..bcef2cb4e55b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,6 +220,7 @@ enum cxl_decoder_type {
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
+ * @region_ida: allocator for region ids.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -231,6 +232,7 @@ struct cxl_decoder {
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
+	struct ida region_ida;
 	const int nr_targets;
 	struct cxl_dport *target[];
 };
@@ -305,6 +307,13 @@ struct cxl_dport {
 	struct list_head root_port_link;
 };
 
+bool is_cxl_region(struct device *dev);
+struct cxl_region *to_cxl_region(struct device *dev);
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
+				    int interleave_ways);
+int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region);
+int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
+
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
new file mode 100644
index 000000000000..d032df438832
--- /dev/null
+++ b/drivers/cxl/region.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2021 Intel Corporation. */
+#ifndef __CXL_REGION_H__
+#define __CXL_REGION_H__
+
+#include <linux/uuid.h>
+
+#include "cxl.h"
+
+/**
+ * struct cxl_region - CXL region
+ * @dev: This region's device.
+ * @id: This regions id. Id is globally unique across all regions.
+ * @list: Node in decoder's region list.
+ * @res: Address space consumed by this region.
+ * @size: Size of the region determined from LSA or userspace.
+ * @uuid: The UUID for this region.
+ * @eniw: Number of interleave ways this region is configured for.
+ * @ig: Interleave granularity of region
+ * @targets: The memory devices comprising the region.
+ */
+struct cxl_region {
+	struct device dev;
+	int id;
+	struct list_head list;
+
+	struct {
+		struct resource *res;
+		u64 size;
+		uuid_t uuid;
+		int eniw;
+		int ig;
+		struct cxl_memdev *targets[CXL_DECODER_MAX_INTERLEAVE];
+	};
+};
+
+#endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 46db4dd345a0..3e5a1c4dce14 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -32,6 +32,7 @@ cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
+cxl_core-y += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
 
 cxl_core-y += mock_pmem.o
-- 
2.33.1

