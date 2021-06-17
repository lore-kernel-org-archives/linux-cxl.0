Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D2DC48BE5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DC0613E1
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFQRjO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:39:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:2464 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhFQRjN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:13 -0400
IronPort-SDR: 4areGsWj6i6rFAdIq+orv9YYZELyeKPIyB3jviUdq1Zy9n8gxszMD2LulsgGoZhdy7pvv3DP/r
 A2152NWnZ4aQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732195"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732195"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:04 -0700
IronPort-SDR: GKk56XcAPdDXh/IzlblzhopilTqkNtkpr3Bef6LKXUrClRdont2YS8yOAHITsf685+pyQhstyh
 KjOaWiFgGiFg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944112"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/6] cxl/region: Introduce a cxl_region driver
Date:   Thu, 17 Jun 2021 10:36:53 -0700
Message-Id: <20210617173655.430424-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617173655.430424-1-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
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
 drivers/cxl/Makefile |  2 +-
 drivers/cxl/core.c   | 15 ++++++-
 drivers/cxl/cxl.h    |  1 +
 drivers/cxl/mem.h    |  1 +
 drivers/cxl/region.c | 99 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/region.h |  2 +
 drivers/cxl/trace.h  | 33 +++++++++++++++
 7 files changed, 149 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cxl/trace.h

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index c3151198c041..f35077c073b8 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(src)
 cxl_core-y := core.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index d8d7ca85e110..44f982f4f247 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -1086,6 +1086,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == &cxl_region_type)
+		return CXL_DEVICE_REGION;
 	return 0;
 }
 
@@ -1102,7 +1104,18 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 
 static int cxl_bus_probe(struct device *dev)
 {
-	return to_cxl_drv(dev->driver)->probe(dev);
+	int id = cxl_device_id(dev);
+
+	if (id == CXL_DEVICE_REGION) {
+		struct cxl_region *region = to_cxl_region(dev);
+
+		if (cxl_is_region_configured(region))
+			return to_cxl_drv(dev->driver)->probe(dev);
+	} else {
+		return to_cxl_drv(dev->driver)->probe(dev);
+	}
+
+	return -ENODEV;
 }
 
 static int cxl_bus_remove(struct device *dev)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8b27a07d7d0f..90107b21125b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -325,6 +325,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_REGION		3
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index fe12ef3c3dde..ff1f9c57e089 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -83,4 +83,5 @@ struct cxl_mem {
 	struct range pmem_range;
 	struct range ram_range;
 };
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index cf7fd3027419..616b47903d69 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -11,6 +11,9 @@
 #include "cxl.h"
 #include "mem.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 /**
  * DOC: cxl region
  *
@@ -27,8 +30,24 @@ static struct cxl_region *to_cxl_region(struct device *dev);
 
 static bool is_region_active(struct cxl_region *region)
 {
-	/* TODO: Regions can't be activated yet. */
-	return false;
+	return region->active;
+}
+
+/*
+ * Most sanity checking is left up to region binding. This does the most basic
+ * check to determine whether or not the core should try probing the driver.
+ */
+bool cxl_is_region_configured(struct cxl_region *region)
+{
+	/* zero sized regions aren't a thing. */
+	if (region->requested_size <= 0)
+		return false;
+
+	/* all regions have at least 1 target */
+	if (region->targets[0])
+		return false;
+
+	return true;
 }
 
 static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
@@ -368,3 +387,79 @@ int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
 
 	return 0;
 }
+
+static int bind_region(struct cxl_region *region)
+{
+	int i;
+
+	if (dev_WARN_ONCE(&region->dev, !cxl_is_region_configured(region),
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
+	if (region->active)
+		return -EBUSY;
+
+	device_lock(&region->dev);
+	ret = bind_region(region);
+	if (!ret)
+		region->active = true;
+	device_unlock(&region->dev);
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
index 7a87d229e38a..926dec98709b 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -16,6 +16,7 @@ extern const struct device_type cxl_region_type;
  * @uuid: The UUID for this region.
  * @list: Node in decoders region list.
  * @eniw: Number of interleave ways this region is configured for.
+ * @active: If the region has been activated.
  * @targets: The memory devices comprising the region.
  */
 struct cxl_region {
@@ -26,6 +27,7 @@ struct cxl_region {
 	uuid_t uuid;
 	struct list_head list;
 	int eniw;
+	bool active;
 	struct cxl_memdev *targets[];
 };
 
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
new file mode 100644
index 000000000000..fe9576ec2cde
--- /dev/null
+++ b/drivers/cxl/trace.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
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
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.32.0

