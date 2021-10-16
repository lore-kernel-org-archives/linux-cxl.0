Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CA8C433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E306124F
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbhJPFRw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:1743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243695AbhJPFRv (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489614"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489614"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743303"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 18/27] cxl/region: Introduce a cxl_region driver
Date:   Fri, 15 Oct 2021 22:15:22 -0700
Message-Id: <20211016051531.622613-19-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_region driver is responsible for managing the HDM decoder
programming in the CXL topology. Once a region is created it must be
configured and bound to the driver in order to activate it.

The following is a sample of how such controls might work:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
echo 2 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/interleave
echo $((256<<20)) > /sys/bus/cxl/devices/decoder0.0/region0.0:0/size
echo mem0 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target0
echo region0.0:0 > /sys/bus/cxl/drivers/cxl_region/bind

In order to handle the eventual rise in failure modes of binding a
region, a new trace event is created to help track these failures for
debug and reconfiguration paths in userspace.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format                                 |   1 +
 .../driver-api/cxl/memory-devices.rst         |   3 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/core/bus.c                        |  19 +-
 drivers/cxl/core/core.h                       |   1 +
 drivers/cxl/core/region.c                     |  25 +-
 drivers/cxl/cxl.h                             |   5 +
 drivers/cxl/region.c                          | 321 ++++++++++++++++++
 drivers/cxl/region.h                          |   4 +
 drivers/cxl/trace.h                           |  45 +++
 10 files changed, 422 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/trace.h

diff --git a/.clang-format b/.clang-format
index 15d4eaabc6b5..cb7c46371465 100644
--- a/.clang-format
+++ b/.clang-format
@@ -169,6 +169,7 @@ ForEachMacros:
   - 'for_each_cpu_and'
   - 'for_each_cpu_not'
   - 'for_each_cpu_wrap'
+  - 'for_each_cxl_endpoint'
   - 'for_each_dapm_widgets'
   - 'for_each_dev_addr'
   - 'for_each_dev_scope'
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 0ed00906acdd..fb5ed0c914b6 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -67,6 +67,9 @@ CXL Core
 
 CXL Regions
 -----------
+.. kernel-doc:: drivers/cxl/region.c
+   :doc: cxl region
+
 .. kernel-doc:: drivers/cxl/region.h
    :identifiers:
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 77499a6b40f2..9936568711cd 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
+obj-$(CONFIG_CXL_MEM) += cxl_region.o
 
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
 cxl_port-y := port.o
+cxl_region-y := region.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index e22e40e9545f..edde7df70fdf 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <cxlmem.h>
+#include <region.h>
 #include <cxl.h>
 #include <pci.h>
 #include "core.h"
@@ -29,6 +30,8 @@ static DEFINE_IDA(cxl_port_ida);
 static LIST_HEAD(cxl_root_ports);
 static DECLARE_RWSEM(root_port_sem);
 
+struct cxl_region *to_cxl_region(struct device *dev);
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -905,6 +908,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_PORT;
 	if (dev->type == &cxl_memdev_type)
 		return CXL_DEVICE_MEMORY_EXPANDER;
+	if (dev->type == &cxl_region_type)
+		return CXL_DEVICE_REGION;
 	return 0;
 }
 
@@ -921,7 +926,19 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
 
 static int cxl_bus_probe(struct device *dev)
 {
-	return to_cxl_drv(dev->driver)->probe(dev);
+	int id = cxl_device_id(dev);
+
+	if (id == CXL_DEVICE_REGION) {
+		/* Regions cannot bind until parameters are set */
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
 
 static void cxl_bus_remove(struct device *dev)
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index dea246cb7c58..5bff806a8742 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,7 @@
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_memdev_type;
+extern const struct device_type cxl_region_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3b0d74d4dd6c..f227d339f092 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -11,6 +11,8 @@
 #include <cxlmem.h>
 #include <cxl.h>
 
+#include "core.h"
+
 /**
  * DOC: cxl core region
  *
@@ -25,10 +27,27 @@ static const struct attribute_group region_interleave_group;
 
 static bool is_region_active(struct cxl_region *region)
 {
-	/* TODO: Regions can't be activated yet. */
-	return false;
+	return region->active;
 }
 
+/*
+ * Most sanity checking is left up to region binding. This does the most basic
+ * check to determine whether or not the core should try probing the driver.
+ */
+bool is_cxl_region_configured(const struct cxl_region *region)
+{
+	/* zero sized regions aren't a thing. */
+	if (region->size <= 0)
+		return false;
+
+	/* all regions have at least 1 target */
+	if (!region->targets[0])
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(is_cxl_region_configured);
+
 static void remove_target(struct cxl_region *region, int target)
 {
 	struct cxl_memdev *cxlmd;
@@ -310,7 +329,7 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev);
 
-static const struct device_type cxl_region_type = {
+const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
 	.groups = region_groups
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 903d1ce19b1b..34063c2440c9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -197,6 +197,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 #define CXL_DECODER_F_EN    BIT(5)
 #define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
+#define cxl_is_pmem_t3(flags)                                                  \
+	(((flags) & (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM)) ==             \
+	 (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM))
+
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
        CXL_DECODER_EXPANDER = 3,
@@ -357,6 +361,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
 #define CXL_DEVICE_MEMORY_EXPANDER	4
+#define CXL_DEVICE_REGION		5
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
new file mode 100644
index 000000000000..610c32107860
--- /dev/null
+++ b/drivers/cxl/region.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "cxlmem.h"
+#include "region.h"
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
+#define for_each_cxl_endpoint(ep, region, idx)                                 \
+	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
+	     idx++, ep = (region)->targets[idx])
+
+#define region_ways(region) ((region)->eniw)
+#define region_ig(region) (ilog2((region)->ig))
+
+#define cxld_from_region(r) to_cxl_decoder(region->dev.parent)
+
+struct cfmws_context {
+	const struct cxl_region *region;
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int count;
+};
+
+static struct cxl_port *get_hostbridge(const struct cxl_memdev *endpoint)
+{
+	return endpoint->root_port->port;
+}
+
+static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
+{
+	struct cxl_port *hostbridge = get_hostbridge(endpoint);
+
+	if (hostbridge)
+		return to_cxl_port(hostbridge->dev.parent);
+
+	return NULL;
+}
+
+/**
+ * sanitize_region() - Check is region is reasonably configured
+ * @region: The region to check
+ *
+ * Determination as to whether or not a region can possibly be configured is
+ * described in CXL Memory Device SW Guide. In order to implement the algorithms
+ * described there, certain more basic configuration parameters must first need
+ * to be validated. That is accomplished by this function.
+ *
+ * Returns 0 if the region is reasonably configured, else returns a negative
+ * error code.
+ */
+static int sanitize_region(const struct cxl_region *region)
+{
+	int i;
+
+	if (region->active)
+		return -EBUSY;
+
+	if (dev_WARN_ONCE(&region->dev, !is_cxl_region_configured(region),
+			  "unconfigured regions can't be probed (race?)\n")) {
+		return -ENXIO;
+	}
+
+	if (region->size % (SZ_256M * region_ways(region))) {
+		trace_sanitize_failed(region, "Invalid size. Must be multiple of NIW");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < region_ways(region); i++) {
+		if (!region->targets[i]) {
+			trace_sanitize_failed(region, "Missing memory device target");
+			return -ENXIO;
+		}
+		if (!region->targets[i]->dev.driver) {
+			trace_sanitize_failed(region, "Target isn't CXL.mem capable");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * allocate_address_space() - Gets address space for the region.
+ * @region: The region that will consume the address space
+ */
+static int allocate_address_space(struct cxl_region *region)
+{
+	/* TODO */
+	return 0;
+}
+
+/**
+ * find_cdat_dsmas() - Find a valid DSMAS for the region
+ * @region: The region
+ */
+static bool find_cdat_dsmas(const struct cxl_region *region)
+{
+	return true;
+}
+
+/**
+ * qtg_match() - Does this CFMWS have desirable QTG for the endpoint
+ * @cfmws: The CFMWS for the region
+ * @endpoint: Endpoint whose QTG is being compared
+ *
+ * Prior to calling this function, the caller should verify that all endpoints
+ * in the region have the same QTG ID.
+ *
+ * Returns true if the QTG ID of the CFMWS matches the endpoint
+ */
+static bool qtg_match(const struct cxl_decoder *cfmws,
+		      const struct cxl_memdev *endpoint)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * region_xhb_config_valid() - determine cross host bridge validity
+ * @cfmws: The CFMWS to check against
+ * @region: The region being programmed
+ *
+ * The algorithm is outlined in 2.13.14 "Verify XHB configuration sequence" of
+ * the CXL Memory Device SW Guide (Rev1p0).
+ *
+ * Returns true if the configuration is valid.
+ */
+static bool region_xhb_config_valid(const struct cxl_region *region,
+				    const struct cxl_decoder *cfmws)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * region_hb_rp_config_valid() - determine root port ordering is correct
+ * @cfmws: CFMWS decoder for this @region
+ * @region: Region to validate
+ *
+ * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
+ * sequence" of the CXL Memory Device SW Guide (Rev1p0).
+ *
+ * Returns true if the configuration is valid.
+ */
+static bool region_hb_rp_config_valid(const struct cxl_region *region,
+				      const struct cxl_decoder *cfmws)
+{
+	/* TODO: */
+	return true;
+}
+
+/**
+ * cfmws_contains() - determine if this region can exist in the cfmws
+ * @cfmws: CFMWS that potentially decodes to this region
+ * @region: region to be routed by the @cfmws
+ */
+static bool cfmws_contains(const struct cxl_region *region,
+			   const struct cxl_decoder *cfmws)
+{
+	/* TODO: */
+	return true;
+}
+
+static bool cfmws_valid(const struct cxl_region *region,
+			const struct cxl_decoder *cfmws)
+{
+	const struct cxl_memdev *endpoint = region->targets[0];
+
+	if (!qtg_match(cfmws, endpoint))
+		return false;
+
+	if (!cxl_is_pmem_t3(cfmws->flags))
+		return false;
+
+	if (!region_xhb_config_valid(region, cfmws))
+		return false;
+
+	if (!region_hb_rp_config_valid(region, cfmws))
+		return false;
+
+	if (!cfmws_contains(region, cfmws))
+		return false;
+
+	return true;
+}
+
+static int cfmws_match(struct device *dev, void *data)
+{
+	struct cfmws_context *ctx = (struct cfmws_context *)data;
+	const struct cxl_region *region = ctx->region;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	return !!cfmws_valid(region, to_cxl_decoder(dev));
+}
+
+/*
+ * This is a roughly equivalent implementation to "Figure 45 - High-level
+ * sequence: Finding CFMWS for region" from the CXL Memory Device SW Guide
+ * Rev1p0.
+ */
+static struct cxl_decoder *find_cfmws(const struct cxl_region *region,
+				      const struct cxl_port *root)
+{
+	struct cfmws_context ctx;
+	struct device *ret;
+
+	ctx.region = region;
+
+	ret = device_find_child((struct device *)&root->dev, &ctx, cfmws_match);
+	if (ret)
+		return to_cxl_decoder(ret);
+
+	return NULL;
+}
+
+/**
+ * gather_hdm_decoders() - Amass all HDM decoders in the hierarchy
+ * @region: The region to be programmed
+ *
+ * Programming the hardware such that the correct set of devices receive the
+ * correct memory traffic requires all connected components in the hierarchy to
+ * have HDM decoders programmed.
+ *
+ * Returns 0 if an HDM decoder was obtained for each component, else returns a
+ * negative error code.
+ */
+static int gather_hdm_decoders(const struct cxl_region *region)
+{
+	/* TODO: */
+	return 0;
+}
+
+static int bind_region(const struct cxl_region *region)
+{
+	/* TODO: */
+	return 0;
+}
+
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	struct cxl_port *root_decoder;
+	struct cxl_decoder *cfmws, *ours;
+	int ret;
+
+	device_lock_assert(&region->dev);
+
+	if (uuid_is_null(&region->uuid))
+		uuid_gen(&region->uuid);
+
+	/* TODO: What about LSA generated regions? */
+
+	ret = sanitize_region(region);
+	if (ret)
+		return ret;
+
+	ret = allocate_address_space(region);
+	if (ret)
+		return ret;
+
+	if (!find_cdat_dsmas(region))
+		return -ENXIO;
+
+	cfmws = cxld_from_region(region);
+	if (!cfmws_valid(region, cfmws)) {
+		dev_err(dev, "Picked invalid cfmws\n");
+		return -ENXIO;
+	}
+
+	root_decoder = get_root_decoder(region->targets[0]);
+	ours = find_cfmws(region, root_decoder);
+	if (ours != cfmws)
+		dev_warn(dev, "Picked different cfmws %s %s\n",
+			 dev_name(&cfmws->dev), dev_name(&ours->dev));
+	if (ours)
+		put_device(&ours->dev);
+
+	ret = gather_hdm_decoders(region);
+	if (ret)
+		return ret;
+
+	ret = bind_region(region);
+	if (!ret) {
+		region->active = true;
+		trace_region_activated(region, "");
+	}
+
+	return ret;
+}
+
+static struct cxl_driver cxl_region_driver = {
+	.name = "cxl_region",
+	.probe = cxl_region_probe,
+	.id = CXL_DEVICE_REGION,
+};
+module_cxl_driver(cxl_region_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index d032df438832..5df417324cab 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -12,6 +12,7 @@
  * @dev: This region's device.
  * @id: This regions id. Id is globally unique across all regions.
  * @list: Node in decoder's region list.
+ * @active: If the region has been activated.
  * @res: Address space consumed by this region.
  * @size: Size of the region determined from LSA or userspace.
  * @uuid: The UUID for this region.
@@ -23,6 +24,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct list_head list;
+	bool active;
 
 	struct {
 		struct resource *res;
@@ -34,4 +36,6 @@ struct cxl_region {
 	};
 };
 
+bool is_cxl_region_configured(const struct cxl_region *region);
+
 #endif
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
new file mode 100644
index 000000000000..8f7f471e15b8
--- /dev/null
+++ b/drivers/cxl/trace.h
@@ -0,0 +1,45 @@
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
+DECLARE_EVENT_CLASS(cxl_region_template,
+
+	TP_PROTO(const struct cxl_region *region, char *status),
+
+	TP_ARGS(region, status),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(&region->dev))
+		__field(const struct cxl_region *, region)
+		__string(status, status)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(&region->dev));
+		__entry->region = (const struct cxl_region *)region;
+		__assign_str(status, status);
+	),
+
+	TP_printk("%s: (%s)\n", __get_str(dev_name), __get_str(status))
+);
+
+DEFINE_EVENT(cxl_region_template, region_activated,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, sanitize_failed,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
+
+#endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/cxl
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.33.1

