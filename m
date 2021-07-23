Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B030C19F34
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1760EBC
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhGWU0L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:34290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhGWU0J (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671219"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671219"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436187"
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
Subject: [PATCH 21/23] cxl/mem: Check that the device is CXL.mem capable
Date:   Fri, 23 Jul 2021 14:06:21 -0700
Message-Id: <20210723210623.114073-22-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL.mem capability is required to participate in an interleave set.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c  | 24 ++++++++++++++++++++++++
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/mem.c       | 18 ++++++++++++++++++
 drivers/cxl/pci.c       | 23 -----------------------
 drivers/cxl/pci.h       |  7 ++++++-
 5 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index c8c51718f3c7..75f49fbb8c00 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -716,6 +716,30 @@ struct cxl_decoder *devm_cxl_add_endpoint_decoder(struct device *host,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_endpoint_decoder);
 
+int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 vendor, id;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_mem_dvsec);
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index eb1a17103e5d..eab6e6461549 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl.h>
 #include <mem.h>
+#include <pci.h>
 #include <region.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ae2024de7912..40281dcc0f3e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "mem.h"
+#include "pci.h"
 
 /**
  * DOC: cxl mem
@@ -33,13 +34,30 @@ static int cxl_memdev_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct pci_dev *pdev = cxlm->pdev;
 	struct device *pdev_parent = cxlm->pdev->dev.parent;
 	struct device *port_dev;
+	int pcie_dvsec;
+	u16 dvsec_ctrl;
 
 	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
 	if (!port_dev)
 		return -ENODEV;
 
+	pcie_dvsec = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
+	if (!pcie_dvsec) {
+		dev_err(dev, "Unable to determine CXL protocol support");
+		return -ENODEV;
+	}
+
+	pci_read_config_word(pdev,
+			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
+			     &dvsec_ctrl);
+	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
+		dev_err(dev, "CXL.cache protocol not supported on device");
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f924a8c5a831..96837412914d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -971,29 +971,6 @@ static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
 	pci_iounmap(cxlm->pdev, base);
 }
 
-static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
-{
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
-	if (!pos)
-		return 0;
-
-	while (pos) {
-		u16 vendor, id;
-
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
-		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos,
-						   PCI_EXT_CAP_ID_DVSEC);
-	}
-
-	return 0;
-}
-
 static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 			  struct cxl_register_map *map)
 {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8c1a58813816..c5a4d51b7561 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -11,7 +11,10 @@
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
-#define PCI_DVSEC_ID_CXL		0x0
+
+#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0
+#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
+#define   CXL_PCIE_MEM_ENABLE			BIT(2)
 
 #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
 #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
@@ -29,4 +32,6 @@
 
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
+int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec);
+
 #endif /* __CXL_PCI_H__ */
-- 
2.32.0

