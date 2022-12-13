Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE2C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Dec 2022 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiLMVgc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 16:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLMVgb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 16:36:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1AE24BD2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670967389; x=1702503389;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kMeyk25HOABWRNs0zCMWR3Wh+ySnYVuPzb3RM95k9FU=;
  b=QXCsA0y8CGKT6OgiSkRFlgp2IF0IASXyP7l4nXYNJin3ffez8l7gENbW
   XhxYLiWlxEjkKAIOX6AjtnHn36HbVVxttsUgwzWx5zXnHCYUXOKaoknIG
   IOEMb91ApgYpxaYu+X71u39S790SxrQ4ijBFdqoNvba81zp9zn45FOKpo
   IU7baW16qCnRFdat4bisvNYeyre5hUJt/cP2XGQnSKdvVF59uRvYUHQmA
   qJrJ3MPWYARuH3rWooq5O8rF53KFmv+AEYSJd/jYeDb1TXtZQb8YJzrfQ
   tG4SwfBv/tqHQxcIbV1U0rhCf/2vJAIFL6A4Wo414zcyR8UpghT//b2PZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="315880778"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="315880778"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 13:36:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="755621122"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="755621122"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 13:36:29 -0800
Subject: [PATCH v2] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 13 Dec 2022 14:36:28 -0700
Message-ID: <167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

By default the CXL RAS mask registers bits are defaulted to 1's and
suppress all error reporting. If the kernel has negotiated ownership
of error handling for CXL then unmask the mask registers by writing 0s.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

Based on patch posted by Ira [1] to export CXL native error reporting control.

[1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/

v2:
- Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
- Return error for cxl_pci_ras_unmask(). (Dan)
- Add dev_dbg() for register bits to be cleared. (Dan)
- Check Flex Port DVSEC status. (Dan)
---
 drivers/cxl/cxl.h             |    1 +
 drivers/cxl/cxlpci.h          |    4 +++
 drivers/cxl/pci.c             |   61 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |    1 +
 4 files changed, 67 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..31e795c6d537 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
 #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
 #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
 #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 920909791bb9..d138d9cd8e33 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -45,6 +45,10 @@
 
 /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
 #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+#define    CXL_DVSEC_PORT_STATUS_OFFSET			0xE
+#define      CXL_DVSEC_PORT_STATUS_CACHE_ENABLED	BIT(0)
+#define      CXL_DVSEC_PORT_STATUS_IO_ENABLED		BIT(1)
+#define      CXL_DVSEC_PORT_STATUS_MEM_ENABLED		BIT(2)
 
 /* CXL 2.0 8.1.9: Register Locator DVSEC */
 #define CXL_DVSEC_REG_LOCATOR					8
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..03691570649d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -419,6 +419,66 @@ static void disable_aer(void *pdev)
 	pci_disable_pcie_error_reporting(pdev);
 }
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u32 lnksta2;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
+static int cxl_pci_ras_unmask(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	void __iomem *addr;
+	int dvsec, rc;
+	u16 port_sta;
+	u32 val;
+
+	if (!cxlds->regs.ras)
+		return -ENODEV;
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return -EOPNOTSUPP;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_FLEXBUS_PORT);
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_PORT_STATUS_OFFSET,
+				  &port_sta);
+	if (rc)
+		return rc;
+
+	if (!(port_sta & (CXL_DVSEC_PORT_STATUS_CACHE_ENABLED |
+			  CXL_DVSEC_PORT_STATUS_IO_ENABLED |
+			  CXL_DVSEC_PORT_STATUS_MEM_ENABLED)))
+		return -EOPNOTSUPP;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+	dev_dbg(&pdev->dev, "Unmasking Uncorrectable RAS errors: %#x\n",
+		readl(addr));
+	val = 0;
+	if (!cxl_pci_flit_256(pdev))
+		val |= CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+	writel(val, addr);
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+	dev_dbg(&pdev->dev, "Unmasking Correctable RAS errors: %#x\n",
+		readl(addr));
+	val = 0;
+	writel(val, addr);
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -498,6 +558,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	if (cxlds->regs.ras) {
 		pci_enable_pcie_error_reporting(pdev);
+		cxl_pci_ras_unmask(pdev);
 		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
 		if (rc)
 			return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 82a03ea954af..576ee2ec973f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -693,6 +693,7 @@
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
+#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */


