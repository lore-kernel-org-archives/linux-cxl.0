Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC8C19F33
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F9660F26
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhGWU0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhGWU0I (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671216"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436180"
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
Subject: [PATCH 19/23] cxl/mem: Introduce CXL mem driver
Date:   Fri, 23 Jul 2021 14:06:19 -0700
Message-Id: <20210723210623.114073-20-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL endpoints that participate in the CXL.mem protocol require extra
control to ensure architectural constraints are met for device
management.

This driver will implement those controls.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Makefile      |  3 ++-
 drivers/cxl/core/bus.c    |  2 ++
 drivers/cxl/core/memdev.c |  5 +++++
 drivers/cxl/cxl.h         |  1 +
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.h         |  2 ++
 6 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/mem.c

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 5b8ada0b7c3b..e5e210369502 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o cxl_pci.o cxl_region.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
 cxl_acpi-y := acpi.o
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index baf4d4308ae5..ecaa0bcb7fe4 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -740,6 +740,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (is_cxl_region(dev))
 		return CXL_DEVICE_REGION;
+	if (is_cxl_memdev(dev))
+		return CXL_DEVICE_ENDPOINT;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index bdf811c02b4d..45894164560b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -217,3 +217,8 @@ devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_memdev);
+
+bool is_cxl_memdev(struct device *dev)
+{
+	return dev->type == &cxl_memdev_type;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9975b4ecf78b..640006ba457f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -321,6 +321,7 @@ enum cxl_driver_id {
 	CXL_DEVICE_NVDIMM_BRIDGE,
 	CXL_DEVICE_NVDIMM,
 	CXL_DEVICE_REGION,
+	CXL_DEVICE_ENDPOINT,
 };
 
 struct cxl_driver {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..2997a03abcb6
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include "mem.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * CXL memory endpoint devices are CXL capable devices that are participating in
+ * CXL.mem protocol. Their functionality builds on top of the CXL.io protocol
+ * that allows enumerating and configuring a CXL endpoint via standard PCI
+ * mechanisms.
+ */
+
+static int cxl_memdev_probe(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static void cxl_memdev_remove(struct device *dev)
+{
+}
+
+static struct cxl_driver cxl_memdev_driver = {
+	.name = "cxl_memdev",
+	.probe = cxl_memdev_probe,
+	.remove = cxl_memdev_remove,
+	.id = CXL_DEVICE_ENDPOINT,
+};
+
+static __init int cxl_memdev_init(void)
+{
+	return cxl_driver_register(&cxl_memdev_driver);
+}
+
+static __exit void cxl_memdev_exit(void)
+{
+	cxl_driver_unregister(&cxl_memdev_driver);
+}
+
+MODULE_LICENSE("GPL v2");
+module_init(cxl_memdev_init);
+module_exit(cxl_memdev_exit);
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 27e142cb0c55..d5c0cd541277 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -98,4 +98,6 @@ static inline bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
 	return false;
 }
 
+bool is_cxl_memdev(struct device *dev);
+
 #endif /* __CXL_MEM_H__ */
-- 
2.32.0

