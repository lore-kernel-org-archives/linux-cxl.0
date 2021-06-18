Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560A8C49EA2
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1661209
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhFRAyP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:2051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhFRAyP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
IronPort-SDR: hCTmPtc6Ih4VIYfkllhzy7ElbBrPn8ulOPrM8b0nKatjPy9W61TFX6vzywvYAMnGyIxdsSRuJw
 yEjmP/lr94Gw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105417"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105417"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
IronPort-SDR: vvN94hcTO1i5SuIkW6idg0P6e6EnVcmyIErqlpSALjqRPKKN7gjXoAMx2x/R7cE5NA2MNc74rk
 16RVaPA7ACaA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223117"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 2/5] cxl/mem: Introduce CXL mem driver
Date:   Thu, 17 Jun 2021 17:51:57 -0700
Message-Id: <20210618005200.997804-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
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
 drivers/cxl/Makefile |  3 ++-
 drivers/cxl/core.c   |  2 ++
 drivers/cxl/cxl.h    |  1 +
 drivers/cxl/mem.c    | 45 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.h    |  1 +
 drivers/cxl/pci.c    |  5 +++++
 6 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/mem.c

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index f35077c073b8..1fc2836d4f12 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o
+obj-$(CONFIG_CXL_MEM) += cxl_pci.o cxl_region.o mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
@@ -10,3 +10,4 @@ cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
 cxl_region-y := region.o
+cxl_mem-y := mem.o
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 5d81fba787e9..16a671722d4e 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -1098,6 +1098,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (is_cxl_region(dev))
 		return CXL_DEVICE_REGION;
+	if (is_cxl_memdev(dev))
+		return CXL_DEVICE_ENDPOINT;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b5b728155d86..ce4b241c5dda 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -328,6 +328,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_REGION		3
+#define CXL_DEVICE_ENDPOINT		4
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
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
index 3d51bf6c090f..2c20c1ccd6b8 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -88,5 +88,6 @@ static inline bool is_cxl_capable(struct cxl_memdev *cxlmd)
 {
 	return false;
 }
+bool is_cxl_memdev(struct device *dev);
 
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 379a106ada94..f9c0eaf3ff4e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1276,6 +1276,11 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+bool is_cxl_memdev(struct device *dev)
+{
+	return dev->type == &cxl_memdev_type;
+}
+
 static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
 {
 	down_write(&cxl_memdev_rwsem);
-- 
2.32.0

