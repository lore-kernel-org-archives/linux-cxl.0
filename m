Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010EEC18E5B
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D219860E8C
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhJVSjh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:5584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhJVSjf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528957"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854674"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:17 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 16/28] cxl: Introduce cxl_mem driver
Date:   Fri, 22 Oct 2021 11:36:57 -0700
Message-Id: <20211022183709.1199701-17-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a driver that is capable of determining whether a device is in a
CXL.mem routed part of the topology.

This driver allows a higher level driver - such as one controlling CXL
regions, which is itself a set of CXL devices - to easily determine if
the CXL devices are CXL.mem capable by checking if the driver has bound.
CXL memory device services may also be provided by this driver though
none are needed as of yet. cxl_mem also plays the part of registering
itself as an endpoint port, which is a required step to enumerate the
device's HDM decoder resources.

As part of this patch, find_dport_by_dev() is promoted to the cxl_core's
set of APIs for use by the new driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   3 +
 drivers/cxl/Kconfig                           |  15 ++
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |  17 +-
 drivers/cxl/core/bus.c                        |  19 +++
 drivers/cxl/core/core.h                       |   1 +
 drivers/cxl/core/memdev.c                     |   2 +-
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/cxlmem.h                          |   2 +
 drivers/cxl/mem.c                             | 158 ++++++++++++++++++
 10 files changed, 205 insertions(+), 17 deletions(-)
 create mode 100644 drivers/cxl/mem.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 547336c95593..d04d07ae7118 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
 CXL Port
 --------
 .. kernel-doc:: drivers/cxl/port.c
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 23773d0ac896..bce98bdaf12c 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -28,6 +28,21 @@ config CXL_PCI
 
 	  If unsure say 'm'.
 
+config CXL_MEM
+	tristate "CXL.mem: Memory Devices"
+	default CXL_BUS
+        help
+          The CXL.mem protocol allows a device to act as a provider of
+	  "System RAM" and/or "Persistent Memory" that is fully coherent
+	  as if the memory was attached to the typical CPU memory controller.
+	  This is known as HDM "Host-managed Device Memory".
+
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
+	  specification for a detailed description of HDM.
+
+	  If unsure say 'm'.
+
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
 	depends on CXL_PCI
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 40b386aaedf7..77499a6b40f2 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -2,9 +2,11 @@
 obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_MEM) += cxl_port.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f6b78736c933..23afb3b8f5cc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -243,21 +243,6 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
-{
-	struct cxl_dport *dport;
-
-	device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list)
-		if (dport->dport == dev) {
-			device_unlock(&port->dev);
-			return dport;
-		}
-
-	device_unlock(&port->dev);
-	return NULL;
-}
-
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {
@@ -292,7 +277,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	dport = find_dport_by_dev(root_port, match);
+	dport = cxl_find_dport_by_dev(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return -ENODEV;
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index f10e7d5b22a4..4b4e6033b774 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -673,6 +673,23 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_GPL(cxl_add_dport);
 
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == dev) {
+			device_unlock(&port->dev);
+			return dport;
+		}
+
+	device_unlock(&port->dev);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(cxl_find_dport_by_dev);
+
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
@@ -859,6 +876,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (dev->type == &cxl_port_type)
 		return CXL_DEVICE_PORT;
+	if (dev->type == &cxl_memdev_type)
+		return CXL_DEVICE_MEMORY_EXPANDER;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e0c9aacc4e9c..dea246cb7c58 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_memdev_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 15762c16d83f..4a7a6e48cba2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
-static const struct device_type cxl_memdev_type = {
+const struct device_type cxl_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
 	.devnode = cxl_memdev_devnode,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 03b414462416..5823c267a4de 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,6 +315,8 @@ void cxl_scan_ports(struct cxl_dport *root_port);
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys, bool root_port);
 struct cxl_dport *cxl_get_root_dport(struct device *dev);
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
@@ -350,6 +352,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
+#define CXL_DEVICE_MEMORY_EXPANDER	4
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 62fe8e2c59e4..cc5844150ce0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -36,6 +36,7 @@
  * @cxlm: pointer to the parent device driver data
  * @id: id number of this memdev instance.
  * @creg_base: register base of component registers
+ * @root_port: Hostbridge's root port connected to this endpoint
  */
 struct cxl_memdev {
 	struct device dev;
@@ -43,6 +44,7 @@ struct cxl_memdev {
 	struct cxl_mem *cxlm;
 	int id;
 	resource_size_t creg_base;
+	struct cxl_dport *root_port;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..97092b9b748d
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "cxlmem.h"
+#include "pci.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * CXL memory endpoint devices and switches are CXL capable devices that are
+ * participating in CXL.mem protocol. Their functionality builds on top of the
+ * CXL.io protocol that allows enumerating and configuring components via
+ * standard PCI mechanisms.
+ *
+ * The cxl_mem driver implements enumeration and control over these CXL
+ * components.
+ */
+
+struct walk_ctx {
+	struct cxl_dport *root_port;
+	bool has_switch;
+};
+
+/**
+ * walk_to_root_port() - Walk up to root port
+ * @dev: Device to walk up from
+ * @ctx: Information to populate while walking
+ *
+ * A platform specific driver such as cxl_acpi is responsible for scanning CXL
+ * topologies in a top-down fashion. If the CXL memory device is directly
+ * connected to the top level hostbridge, nothing else needs to be done. If
+ * however there are CXL components (ie. a CXL switch) in between an endpoint
+ * and a hostbridge the platform specific driver must be notified after all the
+ * components are enumerated.
+ */
+static void walk_to_root_port(struct device *dev, struct walk_ctx *ctx)
+{
+	struct cxl_dport *root_port;
+
+	if (!dev->parent)
+		return;
+
+	root_port = cxl_get_root_dport(dev);
+	if (root_port)
+		ctx->root_port = root_port;
+
+	if (is_cxl_switch_usp(dev))
+		ctx->has_switch = true;
+
+	walk_to_root_port(dev->parent, ctx);
+}
+
+static void remove_endpoint(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct cxl_port *endpoint;
+
+	if (cxlmd->root_port)
+		sysfs_remove_link(&cxlmd->dev.kobj, "root_port");
+
+	endpoint = dev_get_drvdata(&cxlmd->dev);
+
+	devm_cxl_remove_port(endpoint);
+}
+
+static int create_endpoint(struct device *dev, struct cxl_port *parent,
+			   struct cxl_dport *dport)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_port *endpoint;
+	int rc;
+
+	endpoint = devm_cxl_add_port(dev, cxlmd->creg_base, parent);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = sysfs_create_link(&cxlmd->dev.kobj, &dport->dport->kobj,
+			       "root_port");
+	if (rc) {
+		device_del(&endpoint->dev);
+		return rc;
+	}
+	dev_set_drvdata(dev, endpoint);
+	dev_dbg(dev, "add: %s\n", dev_name(&endpoint->dev));
+
+	return devm_add_action_or_reset(dev, remove_endpoint, cxlmd);
+}
+
+static int cxl_mem_probe(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_port *hostbridge, *parent_port;
+	struct walk_ctx ctx = { NULL, false };
+	int rc;
+
+	walk_to_root_port(dev, &ctx);
+
+	/*
+	 * Couldn't find a CXL capable root port. This may happen if cxl_acpi
+	 * hasn't completed in which case cxl_acpi will rescan the bus.
+	 */
+	if (!ctx.root_port)
+		return -ENODEV;
+
+	/* FIXME: This lock is racy, and does it even need to be here? */
+	hostbridge = ctx.root_port->port;
+	device_lock(&hostbridge->dev);
+
+	/* hostbridge has no port driver, the topology isn't enabled yet */
+	if (!hostbridge->dev.driver) {
+		device_unlock(&hostbridge->dev);
+		return -ENODEV;
+	}
+
+	/* No switch + found root port means we're done */
+	if (!ctx.has_switch) {
+		parent_port = to_cxl_port(&hostbridge->dev);
+		goto out;
+	}
+
+	/* Walk down from the root port and add all switches */
+	cxl_scan_ports(ctx.root_port);
+
+	/* If parent is a dport the endpoint is good to go. */
+	parent_port = to_cxl_port(dev->parent->parent);
+	if (!cxl_find_dport_by_dev(parent_port, dev->parent)) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+out:
+
+	rc = create_endpoint(dev, parent_port, ctx.root_port);
+	if (rc)
+		goto err_out;
+
+	cxlmd->root_port = ctx.root_port;
+
+err_out:
+	device_unlock(&hostbridge->dev);
+	return rc;
+}
+
+static struct cxl_driver cxl_mem_driver = {
+	.name = "cxl_mem",
+	.probe = cxl_mem_probe,
+	.id = CXL_DEVICE_MEMORY_EXPANDER,
+};
+
+module_cxl_driver(cxl_mem_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
+MODULE_SOFTDEP("pre: cxl_port");
-- 
2.33.1

