Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3178EC001B2
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 23:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLNXwj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLNXwe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 18:52:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974D187
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671061952; x=1702597952;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A4vrPnwIiaOxoa4FNt6vs+Pp0bzKUUwtOV3BA1lX1xY=;
  b=ddcaFSH5sGcdeHSePqcG8KjKSN5BaFXToHoP69ojiixN7jwg1XWbc4Fm
   a/5foUwo0LVwWO0nC8pits4npgeKm6Kem+uV9v/lDrWoPm68Wp6DcElWv
   K19CwdSVWiJWWHyEbGhDZirBi04hCzBrfvz4XGWbUgRmZGmG3CyrPp/OC
   4kKxwfqIrTcN727wXymi3grodItLdR+28jwbEY3QRtP1bNh8rxsF7CBmX
   bTnAmuBD0xuPjAx2tfCQagPM68ONK1j0a08Oxj9CFDR8O4Hq9e4aMfZ0/
   bhLaA1slxkn3x6JJGLaDEtHFWAh8hnIuhwLNiYfz4JywqkY8e8Ll1qcoB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="382844591"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="382844591"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:52:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="651321799"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="651321799"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 15:52:31 -0800
Subject: [PATCH v3] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 14 Dec 2022 16:52:31 -0700
Message-ID: <167106195154.3243163.16808927634384563321.stgit@djiang5-desk3.ch.intel.com>
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

v3:
- Remove flex bus port status check. (Jonathan)
- Only unmask known mask bits. (Jonathan)

v2:
- Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
- Return error for cxl_pci_ras_unmask(). (Dan)
- Add dev_dbg() for register bits to be cleared. (Dan)
- Check Flex Port DVSEC status. (Dan)
---
 drivers/cxl/cxl.h             |    1 +
 drivers/cxl/pci.c             |   48 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |    1 +
 3 files changed, 50 insertions(+)

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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..9cbec159c57b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -419,6 +419,53 @@ static void disable_aer(void *pdev)
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
+	u32 val, mask;
+
+	if (!cxlds->regs.ras)
+		return -ENODEV;
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return -EOPNOTSUPP;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+	val = readl(addr);
+	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x\n", val);
+
+	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
+	if (!cxl_pci_flit_256(pdev))
+		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+	val ^= mask;
+	writel(val, addr);
+	dev_dbg(&pdev->dev, "Unmasked Uncorrectable RAS Errors Mask: %#x\n", val);
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+	val = readl(addr);
+	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x\n", val);
+	val ^= CXL_RAS_CORRECTABLE_MASK_MASK;
+	writel(val, addr);
+	dev_dbg(&pdev->dev, "Unmasked Correctable RAS Errors Mask: %#x\n", val);
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -498,6 +545,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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


