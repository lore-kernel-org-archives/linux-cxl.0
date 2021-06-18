Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B25C48BE5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E256120A
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhFRAyP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:2051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhFRAyP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
IronPort-SDR: /59NfB72BQEYnPx/Ul4ZCQBo5DKOu8Xeaj+z/jzKYS62avvRwgcTwjHknz8b/RI9IuiHYxjAxm
 znt4+yTxEdSA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105418"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105418"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
IronPort-SDR: S7uElc/qAdDZzU8Cx8m5U8y3yGxxTpAO0XIpFdtWGEY4SGt66EMEvsrunagjstVVFYNVXErFcv
 NVRbPtr/zGrw==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223121"
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
Subject: [RFC PATCH 3/5] cxl/memdev: Determine CXL.mem capability
Date:   Thu, 17 Jun 2021 17:51:58 -0700
Message-Id: <20210618005200.997804-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
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
 drivers/cxl/acpi.c |  9 ++++++++-
 drivers/cxl/core.c |  5 +++++
 drivers/cxl/cxl.h  |  1 +
 drivers/cxl/mem.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/mem.h  |  5 +----
 5 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cf7c26fb2578..6192739fcf43 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
+#include "mem.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
@@ -398,9 +399,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
+
 out:
 	acpi_put_table(cedt_table);
 	return rc;
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 16a671722d4e..0a54c6eb84eb 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -303,6 +303,11 @@ static const struct device_type cxl_port_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+bool is_cxl_port(struct device *dev)
+{
+	return dev->type == &cxl_port_type;
+}
+
 struct cxl_port *to_cxl_port(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ce4b241c5dda..1a3800616f4a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -285,6 +285,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+bool is_cxl_port(struct device *dev);
 struct cxl_decoder *
 devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 		     resource_size_t base, resource_size_t len,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2997a03abcb6..cbf18df24109 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include "mem.h"
 
 /**
@@ -13,9 +14,42 @@
  * mechanisms.
  */
 
+static int port_match(struct device *dev, const void *data)
+{
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int ret = 0;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == data) {
+			ret = 1;
+			break;
+		}
+
+	device_unlock(&port->dev);
+
+	return ret;
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
+	port_dev =
+		bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
+	if (!port_dev)
+		return -ENODEV;
+
+	return 0;
 }
 
 static void cxl_memdev_remove(struct device *dev)
@@ -29,6 +63,11 @@ static struct cxl_driver cxl_memdev_driver = {
 	.id = CXL_DEVICE_ENDPOINT,
 };
 
+bool is_cxl_capable(struct cxl_memdev *cxlmd)
+{
+	return cxlmd->dev.driver == &cxl_memdev_driver.drv;
+}
+
 static __init int cxl_memdev_init(void)
 {
 	return cxl_driver_register(&cxl_memdev_driver);
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 2c20c1ccd6b8..e9333c2ea745 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -84,10 +84,7 @@ struct cxl_mem {
 	struct range ram_range;
 };
 
-static inline bool is_cxl_capable(struct cxl_memdev *cxlmd)
-{
-	return false;
-}
+bool is_cxl_capable(struct cxl_memdev *cxlmd);
 bool is_cxl_memdev(struct device *dev);
 
 #endif /* __CXL_MEM_H__ */
-- 
2.32.0

