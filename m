Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55ACC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355501AbhLBEnu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:61244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355526AbhLBEnc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438379"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438379"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717443"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 07/14] cxl: Cache and pass DVSEC ranges
Date:   Wed,  1 Dec 2021 20:37:43 -0800
Message-Id: <20211202043750.3501494-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 1.1 specification provided a mechanism for mapping an address space
of a CXL device. That functionality is known as a "range" and can be
programmed through PCIe DVSEC. In addition to this, the specification
defines an active bit which a device will expose through the same DVSEC
to notify system software that memory is initialized and ready.

While CXL 2.0 introduces a more powerful mechanism called HDM decoders
that are controlled by MMIO behind a PCIe BAR, the spec does allow the
1.1 style mapping to still be present. In such a case, when the CXL
driver takes over, if it were to enable HDM decoding and there was an
actively used range, things would likely blow up, in particular if it
wasn't an identical mapping.

This patch caches the relevant information which the cxl_mem driver will
need to make the proper decision and passes it along.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v1:
- Fix unused size (LKP)
- Use struct range
- Get rid of macros for pci config reads (Jonathan)
---
 drivers/cxl/cxlmem.h |  15 ++++++
 drivers/cxl/pci.c    | 121 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.h    |  13 +++++
 3 files changed, 149 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ef3c652599e..8d0a14c53518 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -89,6 +89,18 @@ struct cxl_mbox_cmd {
  */
 #define CXL_CAPACITY_MULTIPLIER SZ_256M
 
+/**
+ * struct cxl_endpoint_dvsec_info - Cached DVSEC info
+ * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
+ * @ranges: Number of active HDM ranges this device uses.
+ * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
+ */
+struct cxl_endpoint_dvsec_info {
+	bool mem_enabled;
+	int ranges;
+	struct range dvsec_range[2];
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -117,6 +129,7 @@ struct cxl_mbox_cmd {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @info: Cached DVSEC information about the device.
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -147,6 +160,8 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	struct cxl_endpoint_dvsec_info *info;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 09ff82b4ea06..4e00abde5dbb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -435,8 +435,121 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static int wait_for_valid(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	const unsigned long timeout = jiffies + HZ;
+	int d = cxlds->device_dvsec;
+	bool valid;
+
+	do {
+		u32 temp;
+		int rc;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_LOW_OFFSET(0),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+
+		/*
+		 * Memory_Info_Valid: When set, indicates that the CXL Range 1
+		 * Size high and Size Low registers are valid. Must be set
+		 * within 1 second of deassertion of reset to CXL device.
+		 */
+		valid = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID, temp);
+		if (valid)
+			break;
+		cpu_relax();
+	} while (!time_after(jiffies, timeout));
+
+	return valid ? 0 : -ETIMEDOUT;
+}
+
+static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_endpoint_dvsec_info *info;
+	int d = cxlds->device_dvsec;
+	int hdm_count, rc, i;
+	u16 cap, ctrl;
+
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_PCIE_DEVICE_CAP_OFFSET, &cap);
+	if (rc)
+		return ERR_PTR(-ENXIO);
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_PCIE_DEVICE_CTRL_OFFSET, &ctrl);
+	if (rc)
+		return ERR_PTR(-ENXIO);
+
+	if (!(cap & CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE))
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * It is not allowed by spec for MEM.capable to be set and have 0 HDM
+	 * decoders. As this driver is for a spec defined class code which must
+	 * be CXL.mem capable, there is no point in continuing.
+	 */
+	hdm_count = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK, cap);
+	if (!hdm_count || hdm_count > 2)
+		return ERR_PTR(-EINVAL);
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return ERR_PTR(rc);
+
+	info = devm_kzalloc(cxlds->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->mem_enabled = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ENABLE, ctrl);
+
+	for (i = 0; i < hdm_count; i++) {
+		u64 base, size;
+		u32 temp;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_HIGH_OFFSET(i),
+					   &temp);
+		if (rc)
+			continue;
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_LOW_OFFSET(i),
+					   &temp);
+		if (rc)
+			continue;
+		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_HIGH_OFFSET(i),
+					   &temp);
+		if (rc)
+			continue;
+		base = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_LOW_OFFSET(i),
+					   &temp);
+		if (rc)
+			continue;
+		base |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_BASE_LOW_MASK;
+
+		info->dvsec_range[i] = (struct range) {
+			.start = base,
+			.end = base + size - 1
+		};
+
+		if (size)
+			info->ranges++;
+	}
+
+	return info;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_endpoint_dvsec_info *info;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
@@ -490,6 +603,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	info = dvsec_ranges(cxlds);
+	if (IS_ERR(info))
+		dev_err(&pdev->dev,
+			"Failed to get DVSEC range information (%ld)\n",
+			PTR_ERR(info));
+	else
+		cxlds->info = info;
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index f418272dbe38..7eb38030e376 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -15,6 +15,19 @@
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_PCIE_DEVICE_CAP_OFFSET			0xA
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE			BIT(2)
+#define     CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK		GENMASK(5, 4)
+#define   CXL_DVSEC_PCIE_DEVICE_CTRL_OFFSET			0xC
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_ENABLE			BIT(2)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_HIGH_OFFSET(i)	(0x18 + (i * 0x10))
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_LOW_OFFSET(i)	(0x1C + (i * 0x10))
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_INFO_VALID		BIT(0)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_ACTIVE			BIT(1)
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK		GENMASK(31, 28)
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_HIGH_OFFSET(i)	(0x20 + (i * 0x10))
+#define   CXL_DVSEC_PCIE_DEVICE_RANGE_BASE_LOW_OFFSET(i)	(0x24 + (i * 0x10))
+#define     CXL_DVSEC_PCIE_DEVICE_MEM_BASE_LOW_MASK		GENMASK(31, 28)
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
-- 
2.34.1

