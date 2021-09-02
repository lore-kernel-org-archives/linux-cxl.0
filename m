Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C8C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E5F61041
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347371AbhIBTvb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:41971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347396AbhIBTv3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778203"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451626"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:25 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 06/13] cxl/mem: Introduce cxl_mem driver
Date:   Thu,  2 Sep 2021 12:50:10 -0700
Message-Id: <20210902195017.2516472-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL endpoints that participate in the CXL.mem protocol require extra
control to ensure architectural constraints are met for device
management. The most straight-forward way to achieve control of these
endpoints is with a new driver that can bind to such devices. This
driver will also be responsible for enumerating the switches that
connect the endpoint to the hostbridge.

cxl_core already understands the concept of a memdev, but the core [by
design] does not comprehend all the topological constraints.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |  3 ++
 drivers/cxl/Makefile                          |  3 +-
 drivers/cxl/core/bus.c                        |  2 +
 drivers/cxl/core/core.h                       |  1 +
 drivers/cxl/core/memdev.c                     |  2 +-
 drivers/cxl/cxl.h                             |  1 +
 drivers/cxl/mem.c                             | 49 +++++++++++++++++++
 7 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/mem.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index a18175bae7a6..00d141071570 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
 CXL Core
 --------
 .. kernel-doc:: drivers/cxl/cxl.h
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d1aaabc940f3..d912ac4e3f0c 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 6202ce5a5ac2..256e55dc2a3b 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -641,6 +641,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (dev->type == &cxl_memdev_type)
+		return CXL_DEVICE_ENDPOINT;
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
index ee61202c7aab..c9dd054bd813 100644
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
index 708bfe92b596..b48bdbefd949 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,6 +315,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_ENDPOINT		3
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..978a54b0a51a
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include "cxlmem.h"
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
+static int cxl_mem_probe(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static void cxl_mem_remove(struct device *dev)
+{
+}
+
+static struct cxl_driver cxl_mem_driver = {
+	.name = "cxl_mem",
+	.probe = cxl_mem_probe,
+	.remove = cxl_mem_remove,
+	.id = CXL_DEVICE_ENDPOINT,
+};
+
+static __init int cxl_mem_init(void)
+{
+	return cxl_driver_register(&cxl_mem_driver);
+}
+
+static __exit void cxl_mem_exit(void)
+{
+	cxl_driver_unregister(&cxl_mem_driver);
+}
+
+MODULE_LICENSE("GPL v2");
+module_init(cxl_mem_init);
+module_exit(cxl_mem_exit);
+MODULE_IMPORT_NS(CXL);
-- 
2.33.0

