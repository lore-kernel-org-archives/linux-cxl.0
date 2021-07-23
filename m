Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D19C41537
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA6460F42
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhGWU0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671211"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436162"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 15/23] cxl/region: Introduce a cxl_region driver
Date:   Fri, 23 Jul 2021 14:06:15 -0700
Message-Id: <20210723210623.114073-16-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_region driver is responsible for managing the HDM decoder
programming in the CXL topology. Once a region is created it must be
configured and bound to the driver in order to activate it.

The following is a sample of how such controls might work:

echo 1 > /sys/bus/cxl/devices/decoder0.0/create_region
echo $((256<<20)) > /sys/bus/cxl/devices/decoder0.0/region0.0:0/size
echo mem0 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target0
echo region0.0:0 > /sys/bus/cxl/drivers/cxl_region/bind

In order to handle the eventual rise in failure modes of binding a
region, a new trace event is created to help track these failures for
debug and reconfiguration paths in userspace.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   6 ++
 drivers/cxl/Makefile                          |   3 +-
 drivers/cxl/core/bus.c                        |  15 ++-
 drivers/cxl/core/region.c                     |  24 +++--
 drivers/cxl/cxl.h                             |   1 +
 drivers/cxl/mem.h                             |   1 +
 drivers/cxl/region.c                          | 100 ++++++++++++++++++
 drivers/cxl/region.h                          |   4 +
 drivers/cxl/trace.h                           |  33 ++++++
 9 files changed, 178 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/trace.h

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 96a1f8be7940..9e19f90ce7a1 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -47,6 +47,9 @@ CXL Core
 
 CXL Regions
 -----------
+.. kernel-doc:: drivers/cxl/region.c
+   :doc: cxl region
+
 .. kernel-doc:: drivers/cxl/region.h
    :identifiers:
 
@@ -56,6 +59,9 @@ CXL Regions
 .. kernel-doc:: drivers/cxl/core/region.c
    :identifiers:
 
+.. kernel-doc:: drivers/cxl/region.c
+   :identifiers:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d19d22a19966..5b8ada0b7c3b 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
@@ -8,3 +8,4 @@ cxl_acpi-y := acpi.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_region-y := region.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 3b2bcc091523..b3f2d19ab01f 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -722,6 +722,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (is_cxl_region(dev))
+		return CXL_DEVICE_REGION;
 	return 0;
 }
 
@@ -738,7 +740,18 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 
 static int cxl_bus_probe(struct device *dev)
 {
-	return to_cxl_drv(dev->driver)->probe(dev);
+	int id = cxl_device_id(dev);
+
+	if (id == CXL_DEVICE_REGION) {
+		struct cxl_region *region = to_cxl_region(dev);
+
+		if (is_cxl_region_configured(region))
+			return to_cxl_drv(dev->driver)->probe(dev);
+	} else {
+		return to_cxl_drv(dev->driver)->probe(dev);
+	}
+
+	return -ENODEV;
 }
 
 static int cxl_bus_remove(struct device *dev)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8ed513951730..6d5a52091ae2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -18,13 +18,23 @@
  * (programming the hardware) is handled by a separate region driver.
  */
 
-struct cxl_region *to_cxl_region(struct device *dev);
-
-static bool is_region_active(struct cxl_region *region)
+/*
+ * Most sanity checking is left up to region binding. This does the most basic
+ * check to determine whether or not the core should try probing the driver.
+ */
+bool is_cxl_region_configured(struct cxl_region *region)
 {
-	/* TODO: Regions can't be activated yet. */
-	return false;
+	/* zero sized regions aren't a thing. */
+	if (region->requested_size <= 0)
+		return false;
+
+	/* all regions have at least 1 target */
+	if (!region->targets[0])
+		return false;
+
+	return true;
 }
+EXPORT_SYMBOL_GPL(is_cxl_region_configured);
 
 static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -63,7 +73,7 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 		return rc;
 
 	device_lock(&region->dev);
-	if (is_region_active(region))
+	if (region->active)
 		rc = -EBUSY;
 	else
 		region->requested_size = val;
@@ -91,7 +101,7 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	device_lock(&region->dev);
-	if (is_region_active(region))
+	if (region->active)
 		rc = -EBUSY;
 	else
 		rc = uuid_parse(buf, &region->uuid);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ecfa5ae082fa..c516182eb7bc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -318,6 +318,7 @@ extern struct bus_type cxl_bus_type;
 enum cxl_driver_id {
 	CXL_DEVICE_NVDIMM_BRIDGE,
 	CXL_DEVICE_NVDIMM,
+	CXL_DEVICE_REGION,
 };
 
 struct cxl_driver {
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 7765f59c890d..4f3ac1ccee0a 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -92,4 +92,5 @@ struct cxl_mem {
 	struct range pmem_range;
 	struct range ram_range;
 };
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
new file mode 100644
index 000000000000..71efe7f29a35
--- /dev/null
+++ b/drivers/cxl/region.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include "region.h"
+#include "mem.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+/**
+ * DOC: cxl region
+ *
+ * This module implements a region driver that is capable of programming CXL
+ * hardware to setup regions.
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
+static int bind_region(struct cxl_region *region)
+{
+	int i;
+
+	if (dev_WARN_ONCE(&region->dev, !is_cxl_region_configured(region),
+			  "unconfigured regions can't be probed (race?)\n")) {
+		return -ENXIO;
+	}
+
+	if (region->requested_size % (SZ_256M * region->eniw)) {
+		trace_cxl_region_bind(region, "Invalid size. Must be multiple of NIW");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < region->eniw; i++)
+		if (!region->targets[i]) {
+			trace_cxl_region_bind(region, "Missing memory device target");
+			return -ENXIO;
+		}
+
+	/* TODO: Allocate from decoder's address space */
+
+	/* TODO: program HDM decoders */
+
+	if (uuid_is_null(&region->uuid))
+		uuid_gen(&region->uuid);
+
+	trace_cxl_region_bind(region, "Region binding succeeded.");
+	return 0;
+}
+
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	int ret;
+
+	device_lock_assert(&region->dev);
+
+	if (region->active)
+		return -EBUSY;
+
+	ret = bind_region(region);
+	if (!ret)
+		region->active = true;
+
+	return ret;
+}
+
+static void cxl_region_remove(struct device *dev)
+{
+	/* Remove region from the decoder's address space */
+}
+
+static struct cxl_driver cxl_region_driver = {
+	.name = "cxl_region",
+	.probe = cxl_region_probe,
+	.remove = cxl_region_remove,
+	.id = CXL_DEVICE_REGION,
+};
+
+static __init int cxl_region_init(void)
+{
+	return cxl_driver_register(&cxl_region_driver);
+}
+
+static __exit void cxl_region_exit(void)
+{
+	cxl_driver_unregister(&cxl_region_driver);
+}
+
+MODULE_LICENSE("GPL v2");
+module_init(cxl_region_init);
+module_exit(cxl_region_exit);
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_REGION);
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index c8ed3a8bd1e0..0ee1da323231 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -14,6 +14,7 @@
  * @uuid: The UUID for this region.
  * @list: Node in decoders region list.
  * @eniw: Number of interleave ways this region is configured for.
+ * @active: If the region has been activated.
  * @targets: The memory devices comprising the region.
  */
 struct cxl_region {
@@ -24,7 +25,10 @@ struct cxl_region {
 	uuid_t uuid;
 	struct list_head list;
 	int eniw;
+	bool active;
 	struct cxl_memdev *targets[];
 };
 
+bool is_cxl_region_configured(struct cxl_region *region);
+
 #endif
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
new file mode 100644
index 000000000000..d1a2942c3b82
--- /dev/null
+++ b/drivers/cxl/trace.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __CXL_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(cxl_region_bind,
+	TP_PROTO(struct cxl_region *region, char *status),
+	TP_ARGS(region, status),
+	TP_STRUCT__entry(
+		__field(struct cxl_region *, region)
+		__string(status, status)
+	),
+
+	TP_fast_assign(
+		__entry->region = region;
+		__assign_str(status, status);
+	),
+
+	TP_printk("%s failed to bind (%s)", dev_name(&__entry->region->dev), __get_str(status))
+);
+
+#endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/cxl
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.32.0

