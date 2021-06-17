Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F35C49361
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727AB613E9
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhFQRjN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:39:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:2462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232619AbhFQRjN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:13 -0400
IronPort-SDR: CB6G1lfYFheR4ny3rFjAyZrMRsNk3JPz9eyO/QcdbcWh1g0x37hiHPUkk1MeuT3x5hxxiJKEJj
 wuup7j+D3wKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732188"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
IronPort-SDR: Ihz/6cg7kC+L+olepSwJbgxB6ZcOWqe9eRzs54LWzagY/oTpBp/XFyo+unUMzn/R//WMwp5qsq
 4OmOjTAomXmg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944101"
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
Subject: [PATCH 1/6] cxl/region: Add region creation ABI
Date:   Thu, 17 Jun 2021 10:36:50 -0700
Message-Id: <20210617173655.430424-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617173655.430424-1-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Regions are created as a child of the decoder that encompasses an
address space with constraints. Regions only exist for persistent
capacities.

When regions are created, the number of desired interleave ways must be
known. To enable this, the sysfs attribute will take the desired ways as
input. This interface intentionally allows creation of
impossible-to-enable regions based on interleave constraints in the
topology. The reasoning is to create new regions through the kernel
interfaces which may become possible on reboot under a variety of
circumstances.

As an example, creating a x1 region with:
echo 1 > /sys/bus/cxl/devices/decoder1.0/create_region

Will yield /sys/bus/cxl/devices/decoder1.0/region1.0:0

That region may then be deleted with:
echo region1.0:0 > /sys/bus/cxl/devices/decoder1.0/delete_region

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl       |  21 +++
 .../driver-api/cxl/memory-devices.rst         |  11 ++
 drivers/cxl/Makefile                          |   3 +-
 drivers/cxl/core.c                            |  71 +++++++++
 drivers/cxl/cxl.h                             |  11 ++
 drivers/cxl/region.c                          | 147 ++++++++++++++++++
 drivers/cxl/region.h                          |  43 +++++
 7 files changed, 306 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0b6a2e6e8fbb..115a25d2899d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -127,3 +127,24 @@ Description:
 		memory (type-3). The 'target_type' attribute indicates the
 		current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/create_region
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Creates a new CXL region of N interleaved ways. Writing a value
+		of '2' will create a new uninitialized region with 2x interleave
+		that will be mapped by the CXL decoderX.Y. Reading from this
+		node will return the last created region. Regions must be
+		subsequently configured and bound to a region driver before they
+		can be used.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Deletes the named region. A region must be unbound from the
+		region driver before being deleted. The attributes expects a
+		region in the form "regionX.Y:Z".
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 487ce4f41d77..c7f59a8c94db 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -39,6 +39,17 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core.c
    :doc: cxl core
 
+CXL Regions
+-----------
+.. kernel-doc:: drivers/cxl/region.c
+   :doc: cxl region
+
+.. kernel-doc:: drivers/cxl/region.h
+   :identifiers:
+
+.. kernel-doc:: drivers/cxl/region.c
+   :identifiers:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 32954059b37b..c3151198c041 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
@@ -9,3 +9,4 @@ cxl_core-y := core.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_region-y := region.o
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index a2e4d54fc7bc..d8d7ca85e110 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include "region.h"
 #include "cxl.h"
 #include "mem.h"
 
@@ -120,7 +121,68 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
+static ssize_t create_region_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	int rc;
+
+	device_lock(dev);
+	rc = sprintf(buf, "%s\n",
+		     cxld->youngest ? dev_name(&cxld->youngest->dev) : "");
+	device_unlock(dev);
+
+	return rc;
+}
+
+static ssize_t create_region_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_region *region;
+	ssize_t rc;
+	int val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+	if (val < 0 || val > 16)
+		return -EINVAL;
+
+	region = cxl_alloc_region(cxld, val);
+	if (IS_ERR(region))
+		return PTR_ERR(region);
+
+	rc = cxl_add_region(cxld, region);
+	if (rc) {
+		cxl_free_region(cxld, region);
+		return rc;
+	}
+
+	cxld->youngest = region;
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
+	&dev_attr_create_region.attr,
+	&dev_attr_delete_region.attr,
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
@@ -171,7 +233,13 @@ static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_region *region;
 
+	list_for_each_entry(region, &cxld->regions, list)
+		cxl_delete_region(cxld, dev_name(&region->dev));
+
+	dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
+		      "Lost track of a region");
 	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
 }
@@ -483,8 +551,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 		.interleave_ways = interleave_ways,
 		.interleave_granularity = interleave_granularity,
 		.target_type = type,
+		.regions = LIST_HEAD_INIT(cxld->regions),
 	};
 
+	ida_init(&cxld->region_ida);
+
 	/* handle implied target_list */
 	if (interleave_ways == 1)
 		cxld->target[0] =
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6bda39a59e3..8b27a07d7d0f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -190,6 +190,9 @@ enum cxl_decoder_type {
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
+ * @region_ida: allocator for region ids.
+ * @regions: List of regions mapped (may be disabled) by this decoder.
+ * @youngest: Last region created for this decoder.
  * @target: active ordered target list in current decoder configuration
  */
 struct cxl_decoder {
@@ -200,6 +203,9 @@ struct cxl_decoder {
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
+	struct ida region_ida;
+	struct list_head regions;
+	struct cxl_region *youngest;
 	struct cxl_dport *target[];
 };
 
@@ -262,6 +268,11 @@ struct cxl_dport {
 	struct list_head list;
 };
 
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
+				    int interleave_ways);
+void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region);
+int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *region);
+int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
new file mode 100644
index 000000000000..391467e864a2
--- /dev/null
+++ b/drivers/cxl/region.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include "region.h"
+#include "cxl.h"
+#include "mem.h"
+
+/**
+ * DOC: cxl region
+ *
+ * A CXL region encompasses a chunk of host physical address space that may be
+ * consumed by a single device (x1 interleave aka linear) or across multiple
+ * devices (xN interleaved). A region is a child device of a &struct
+ * cxl_decoder. There may be multiple active regions under a single &struct
+ * cxl_decoder. The common case for multiple regions would be several linear,
+ * contiguous regions under a single decoder. Generally, there will be a 1:1
+ * relationship between decoder and region when the region is interleaved.
+ */
+
+static void cxl_region_release(struct device *dev);
+
+const struct device_type cxl_region_type = {
+	.name = "cxl_region",
+	.release = cxl_region_release,
+};
+
+void cxl_free_region(struct cxl_decoder *cxld, struct cxl_region *region)
+{
+	ida_free(&cxld->region_ida, region->id);
+	kfree(region);
+}
+
+static void cxl_region_release(struct device *dev)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
+	struct cxl_region *region = to_cxl_region(dev);
+
+	cxl_free_region(cxld, region);
+}
+
+struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
+				    int interleave_ways)
+{
+	struct cxl_region *region;
+	int rc;
+
+	region = kzalloc(struct_size(region, targets, interleave_ways),
+			 GFP_KERNEL);
+	if (!region)
+		return ERR_PTR(-ENOMEM);
+
+	region->eniw = interleave_ways;
+
+	rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);
+	if (rc < 0) {
+		dev_err(&cxld->dev, "Couldn't get a new id\n");
+		kfree(region);
+		return ERR_PTR(rc);
+	}
+	region->id = rc;
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
+ * address space which is mapped by a @cxld, and that @cxld enforces constraints
+ * upon the region as it is configured. Regions may be added to a @cxld but not
+ * activated and therefore it is possible to have more regions in a @cxld than
+ * there are interleave ways in the @cxld. Regions exist only for persistent
+ * capacities.
+ *
+ * Return: zero if the region was added to the @cxld, else returns negative
+ * error code.
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
+	rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, region->id);
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
+static struct cxl_region *
+cxl_find_region_by_name(struct cxl_decoder *cxld, const char *name)
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
+	cmpxchg(&cxld->youngest, region, NULL);
+
+	device_unregister(&region->dev);
+	device_unlock(&cxld->dev);
+
+	put_device(&region->dev);
+
+	return 0;
+}
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
new file mode 100644
index 000000000000..7a87d229e38a
--- /dev/null
+++ b/drivers/cxl/region.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2021 Intel Corporation. */
+#ifndef __CXL_REGION_H__
+#define __CXL_REGION_H__
+
+#include <linux/uuid.h>
+
+extern const struct device_type cxl_region_type;
+
+/**
+ * struct cxl_region - CXL region
+ * @dev: This region's device.
+ * @id: This regions id. Id is globally unique across all regions.
+ * @res: Address space consumed by this region.
+ * @requested_size: Size of the region determined from LSA or userspace.
+ * @uuid: The UUID for this region.
+ * @list: Node in decoders region list.
+ * @eniw: Number of interleave ways this region is configured for.
+ * @targets: The memory devices comprising the region.
+ */
+struct cxl_region {
+	struct device dev;
+	int id;
+	struct resource *res;
+	u64 requested_size;
+	uuid_t uuid;
+	struct list_head list;
+	int eniw;
+	struct cxl_memdev *targets[];
+};
+
+static inline struct cxl_region *to_cxl_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
+			  "not a cxl_region device\n"))
+		return NULL;
+
+	return container_of(dev, struct cxl_region, dev);
+}
+
+bool cxl_is_region_configured(struct cxl_region *region);
+
+#endif
-- 
2.32.0

