Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEEC4708D
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D231F613EC
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhE1AvF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 May 2021 20:51:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:19710 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhE1AvE (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 May 2021 20:51:04 -0400
IronPort-SDR: nlrQPJlOi38rfbDxQtisj+bw4G+q3JmP2vzOa7C8PM01l8YVhd8wPbduGbWBAGDpgkhInCqVMa
 9iUuRnmYoOHg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="266753505"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="266753505"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:28 -0700
IronPort-SDR: OlbgG+jLLMoYRoxtbvhE5rDTnK5TmgXY0J4Cp0DB2AVID5E/Xa0BjJD2UJ25bLbRtFQW7NkY3V
 Gd1K4QIkw4MA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443791897"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:28 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] cxl/pci: Add HDM decoder capabilities
Date:   Thu, 27 May 2021 17:49:22 -0700
Message-Id: <20210528004922.3980613-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210528004922.3980613-1-ira.weiny@intel.com>
References: <20210528004922.3980613-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

An HDM decoder is defined in the CXL 2.0 specification as a mechanism
that allow devices and upstream ports to claim memory address ranges and
participate in interleave sets. HDM decoder registers are within the
component register block defined in CXL 2.0 8.2.3 CXL 2.0 Component
Registers as part of the CXL.cache and CXL.mem subregion.

The Component Register Block is found via the Register Locator DVSEC
in a similar fashion to how the CXL Device Register Block is found. The
primary difference is the capability id size of the Component Register
Block is a single DWORD instead of 4 DWORDS.

It's now possible to configure a CXL type 3 device's HDM decoder. Such
programming is expected for CXL devices with persistent memory, and hot
plugged CXL devices that participate in CXL.mem with volatile memory.

Add probe and mapping functions for the component register blocks.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes for V3:
	Johnathan
		Remove CXL_REGLOC_RBI_MAX
	Add kernel doc comment for cxl_probe_component_regs()
	Update to devm_cxl_iomap_block() call.
---
 drivers/cxl/core.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h  | 65 +++++++++++++++++++++++++++++---
 drivers/cxl/pci.c  | 15 ++++++++
 3 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 2b5aac6f76f2..f41a38e87606 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -13,6 +13,78 @@
  * point for cross-device interleave coordination through cxl ports.
  */
 
+/**
+ * cxl_probe_component_regs() - Detect CXL Component register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping containing the HDM Decoder Capability Header
+ * @map: Map object describing the register block information found
+ *
+ * See CXL 2.0 8.2.4 Component Register Layout and Definition
+ * See CXL 2.0 8.2.5.5 CXL Device Register Interface
+ *
+ * Probe for component register information and return it in map object.
+ */
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*map = (struct cxl_component_reg_map) { 0 };
+
+	/*
+	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
+	 * CXL 2.0 8.2.4 Table 141.
+	 */
+	base += CXL_CM_OFFSET;
+
+	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
+		dev_err(dev,
+			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
+		return;
+	}
+
+	/* It's assumed that future versions will be backward compatible */
+	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 hdr;
+		int decoder_cnt;
+		u16 cap_id, offset;
+		u32 length;
+
+		hdr = readl(base + cap * 0x4);
+
+		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
+		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
+		register_block = base + offset;
+
+		switch (cap_id) {
+		case CXL_CM_CAP_CAP_ID_HDM:
+			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
+				offset);
+
+			hdr = readl(register_block);
+
+			decoder_cnt = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr);
+			length = 0x20 * decoder_cnt + 0x10;
+
+			map->hdm_decoder.valid = true;
+			map->hdm_decoder.offset = offset;
+			map->hdm_decoder.size = length;
+			break;
+		default:
+			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
+				offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
+
 /**
  * cxl_probe_device_regs() - Detect CXL Device register blocks
  * @dev: Host device of the @base mapping
@@ -105,6 +177,26 @@ static void __iomem *devm_cxl_iomap_block(struct pci_dev *pdev,
 	return ret_val;
 }
 
+int cxl_map_component_regs(struct pci_dev *pdev,
+			   struct cxl_component_regs *regs,
+			   struct cxl_register_map *map)
+{
+	resource_size_t phys_addr;
+	resource_size_t length;
+
+	phys_addr = pci_resource_start(pdev, map->barno);
+	phys_addr += map->block_offset;
+
+	phys_addr += map->component_map.hdm_decoder.offset;
+	length = map->component_map.hdm_decoder.size;
+	regs->hdm_decoder = devm_cxl_iomap_block(pdev, phys_addr, length);
+	if (!regs->hdm_decoder)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_component_regs);
+
 int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ae4b4c96c6b5..2c47e9cffd44 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,31 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
+/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
+
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
+/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
+#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -34,18 +59,30 @@
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/*
- * CXL_DEVICE_REGS - Common set of CXL Device register block base pointers
- * @status: CXL 2.0 8.2.8.3 Device Status Registers
- * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
- * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
- */
+#define CXL_COMPONENT_REGS() \
+	void __iomem *hdm_decoder
+
 #define CXL_DEVICE_REGS() \
 	void __iomem *status; \
 	void __iomem *mbox; \
 	void __iomem *memdev
 
 /* See note for 'struct cxl_regs' for the rationale of this organization */
+/*
+ * CXL_COMPONENT_REGS - Common set of CXL Component register block base pointers
+ * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+ */
+struct cxl_component_regs {
+	CXL_COMPONENT_REGS();
+};
+
+/* See note for 'struct cxl_regs' for the rationale of this organization */
+/*
+ * CXL_DEVICE_REGS - Common set of CXL Device register block base pointers
+ * @status: CXL 2.0 8.2.8.3 Device Status Registers
+ * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+ * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+ */
 struct cxl_device_regs {
 	CXL_DEVICE_REGS();
 };
@@ -56,6 +93,12 @@ struct cxl_device_regs {
  * agnostic code to include the prefix.
  */
 struct cxl_regs {
+	union {
+		struct {
+			CXL_COMPONENT_REGS();
+		};
+		struct cxl_component_regs component;
+	};
 	union {
 		struct {
 			CXL_DEVICE_REGS();
@@ -70,6 +113,10 @@ struct cxl_reg_map {
 	unsigned long size;
 };
 
+struct cxl_component_reg_map {
+	struct cxl_reg_map hdm_decoder;
+};
+
 struct cxl_device_reg_map {
 	struct cxl_reg_map status;
 	struct cxl_reg_map mbox;
@@ -82,12 +129,18 @@ struct cxl_register_map {
 	u8 reg_type;
 	u8 barno;
 	union {
+		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
 	};
 };
 
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+int cxl_map_component_regs(struct pci_dev *pdev,
+			   struct cxl_component_regs *regs,
+			   struct cxl_register_map *map);
 int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e1a2dbc2886b..5a1705b52278 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -982,9 +982,20 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
+	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 
 	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_COMPONENT:
+		comp_map = &map->component_map;
+		cxl_probe_component_regs(dev, base, comp_map);
+		if (!comp_map->hdm_decoder.valid) {
+			dev_err(dev, "HDM decoder registers not found\n");
+			return -ENXIO;
+		}
+
+		dev_dbg(dev, "Set up component registers\n");
+		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(dev, base, dev_map);
@@ -1012,6 +1023,10 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 	struct device *dev = &pdev->dev;
 
 	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_COMPONENT:
+		cxl_map_component_regs(pdev, &cxlm->regs.component, map);
+		dev_dbg(dev, "Mapping component registers...\n");
+		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
 		dev_dbg(dev, "Probing device registers...\n");
-- 
2.28.0.rc0.12.gb6a658bd00c9

