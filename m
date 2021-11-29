Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0643C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhK2WAC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:00:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:47142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232437AbhK2V6C (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:58:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968507"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968507"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596102"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 7/9] cxl/acpi: Map component registers for Root Ports
Date:   Mon, 29 Nov 2021 13:47:19 -0800
Message-Id: <20211129214721.1668325-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This implements the TODO in cxl_acpi for mapping component registers.
cxl_acpi becomes the second consumer of CXL register block enumeration
(cxl_pci being the first). Moving the functionality to cxl_core allows
both of these drivers to use the functionality. Equally importantly it
allows cxl_core to use the functionality in the future.

CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
distinction being they're a part of the CXL 2.0 host bridge. While
mapping their component registers is not immediately useful for the CXL
drivers, the movement of register block enumeration into core is a vital
step towards HDM decoder programming.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
- Add comment on why component register enumeration for root ports is
  optional (Jonathan)
- Fix kdoc for cxl_find_regblock (Jonathan)
- Convert cxl_reg_block macro to static inline (Dan)
- Rename cxl_reg_block cxl_reg_block to cxl_regmap_to_base (Dan)
- Make cxl_regmap_to_base return CXL_RESOURCE_NONE on failure (Dan)
---
 drivers/cxl/acpi.c      | 13 ++++++++--
 drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  4 +++
 drivers/cxl/pci.c       | 52 ---------------------------------------
 drivers/cxl/pci.h       |  9 +++++++
 5 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3163167ecc3a..c656a49a11a9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
+#include "pci.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
@@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 {
+	resource_size_t creg = CXL_RESOURCE_NONE;
 	struct cxl_walk_context *ctx = data;
 	struct pci_bus *root_bus = ctx->root;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
 	struct device *dev = ctx->dev;
+	struct cxl_register_map map;
 	u32 lnkcap, port_num;
 	int rc;
 
@@ -152,9 +155,15 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 				  &lnkcap) != PCIBIOS_SUCCESSFUL)
 		return 0;
 
-	/* TODO walk DVSEC to find component register base */
+	/* The driver doesn't rely on component registers for Root Ports yet. */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (!rc)
+		dev_info(&pdev->dev, "No component register block found\n");
+
+	creg = cxl_regmap_to_base(pdev, &map);
+
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
 	if (rc) {
 		ctx->error = rc;
 		return rc;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e37e23bf4355..7a1c4290f0a3 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include <pci.h>
 
 /**
  * DOC: cxl registers
@@ -247,3 +248,56 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
+
+static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
+				struct cxl_register_map *map)
+{
+	map->block_offset = ((u64)reg_hi << 32) |
+			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+}
+
+/**
+ * cxl_find_regblock() - Locate register blocks by type
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ * @map: Enumeration output, clobbered on error
+ *
+ * Return: 0 if register block enumerated, negative error code otherwise
+ *
+ * A CXL DVSEC may point to one or more register blocks, search for them
+ * by @type.
+ */
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map)
+{
+	u32 regloc_size, regblocks;
+	int regloc, i;
+
+	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					   CXL_DVSEC_REG_LOCATOR);
+	if (!regloc)
+		return -ENXIO;
+
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+
+		pci_read_config_dword(pdev, regloc, &reg_lo);
+		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+
+		cxl_decode_regblock(reg_lo, reg_hi, map);
+
+		if (map->reg_type == type)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ab4596f0b751..7150a9694f66 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -145,6 +145,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 
+enum cxl_regloc_type;
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ada0d67c8194..6aa3dd4b29a1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -416,58 +416,6 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
 	return 0;
 }
 
-static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
-				struct cxl_register_map *map)
-{
-	map->block_offset = ((u64)reg_hi << 32) |
-			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
-	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
-	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
-}
-
-/**
- * cxl_find_regblock() - Locate register blocks by type
- * @pdev: The CXL PCI device to enumerate.
- * @type: Register Block Indicator id
- * @map: Enumeration output, clobbered on error
- *
- * Return: 0 if register block enumerated, negative error code otherwise
- *
- * A CXL DVSEC may point to one or more register blocks, search for them
- * by @type.
- */
-static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-			     struct cxl_register_map *map)
-{
-	u32 regloc_size, regblocks;
-	int regloc, i;
-
-	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					   CXL_DVSEC_REG_LOCATOR);
-	if (!regloc)
-		return -ENXIO;
-
-	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
-	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
-
-	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
-	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
-
-	for (i = 0; i < regblocks; i++, regloc += 8) {
-		u32 reg_lo, reg_hi;
-
-		pci_read_config_dword(pdev, regloc, &reg_lo);
-		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
-
-		cxl_decode_regblock(reg_lo, reg_hi, map);
-
-		if (map->reg_type == type)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
 static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			  struct cxl_register_map *map)
 {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8ae2b4adc59d..f418272dbe38 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -47,4 +47,13 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
+static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
+						 struct cxl_register_map *map)
+{
+	if (!map)
+		return CXL_RESOURCE_NONE;
+
+	return pci_resource_start(pdev, map->barno) + map->block_offset;
+}
+
 #endif /* __CXL_PCI_H__ */
-- 
2.34.1

