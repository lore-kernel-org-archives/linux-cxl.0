Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28374C19F30
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E34960F26
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhGWU0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:34290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671218"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671218"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436183"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 20/23] cxl/memdev: Determine CXL.mem capability
Date:   Fri, 23 Jul 2021 14:06:20 -0700
Message-Id: <20210723210623.114073-21-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If the "upstream" port of the endpoint is an enumerated downstream CXL
port the memdev driver can bind. This is useful for region
configuration/creation because it provides a way for the region code to
determine if the memdev is actually CXL capable.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c        | 23 +++++++----------------
 drivers/cxl/core/bus.c    | 23 +++++++++++++++++++++++
 drivers/cxl/core/memdev.c |  6 ++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/mem.c         | 27 ++++++++++++++++++++++++++-
 drivers/cxl/mem.h         |  6 +-----
 6 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fd1ae2495ab0..c8486ff273b6 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
+#include "mem.h"
 
 static struct acpi_table_header *acpi_cedt;
 
@@ -223,21 +224,6 @@ static int match_add_root_ports(struct pci_dev *pdev, void *data)
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
 static struct acpi_device *to_cxl_host_bridge(struct device *dev)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
@@ -403,9 +389,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
-	if (IS_ENABLED(CONFIG_CXL_PMEM))
+	if (IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
+		if (rc)
+			goto out;
+	}
+
+	rc = bus_rescan_devices(&cxl_bus_type);
 
 out:
 	acpi_put_table(acpi_cedt);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index ecaa0bcb7fe4..c8c51718f3c7 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -329,6 +329,12 @@ static const struct device_type cxl_port_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+bool is_cxl_port(struct device *dev)
+{
+	return dev->type == &cxl_port_type;
+}
+EXPORT_SYMBOL_GPL(is_cxl_port);
+
 struct cxl_port *to_cxl_port(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
@@ -336,6 +342,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
 }
+EXPORT_SYMBOL_GPL(to_cxl_port);
 
 static void unregister_port(void *_port)
 {
@@ -494,6 +501,22 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 	return dup ? -EEXIST : 0;
 }
 
+struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev)
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
+EXPORT_SYMBOL_GPL(find_dport_by_dev);
+
 /**
  * cxl_add_dport - append downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 45894164560b..2596c3da64a0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -222,3 +222,9 @@ bool is_cxl_memdev(struct device *dev)
 {
 	return dev->type == &cxl_memdev_type;
 }
+
+bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
+{
+	return !!cxlmd->dev.driver;
+}
+EXPORT_SYMBOL_GPL(is_cxl_mem_capable);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 640006ba457f..8020af021494 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -284,8 +284,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 
+bool is_cxl_port(struct device *dev);
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys);
+struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2997a03abcb6..ae2024de7912 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include "mem.h"
 
 /**
@@ -13,9 +14,33 @@
  * mechanisms.
  */
 
+static int port_match(struct device *dev, const void *data)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	if (find_dport_by_dev(port, data))
+		return 1;
+
+	return 0;
+}
+
 static int cxl_memdev_probe(struct device *dev)
 {
-	return -EOPNOTSUPP;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct device *pdev_parent = cxlm->pdev->dev.parent;
+	struct device *port_dev;
+
+	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
+	if (!port_dev)
+		return -ENODEV;
+
+	return 0;
 }
 
 static void cxl_memdev_remove(struct device *dev)
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index d5c0cd541277..7da1bb48d409 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -93,11 +93,7 @@ struct cxl_mem {
 	struct range ram_range;
 };
 
-static inline bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
-{
-	return false;
-}
-
+bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
 bool is_cxl_memdev(struct device *dev);
 
 #endif /* __CXL_MEM_H__ */
-- 
2.32.0

