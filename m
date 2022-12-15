Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EAC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiLOSIN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLOSIM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 13:08:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D1442D3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671127690; x=1702663690;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YQN4K3xdMVpdT8Z6M8GCSMrrrqAp/GavmHTY93P3Mro=;
  b=ewLgqBFRvCmvDLiJQCHrpK97zbitjaNglN2MHqP/KT38Yg4VcFkV+SVH
   3HGqe3y00m4JOtbnWVDQ6vQNVhZEwOMX1sDEG79glCRkJdcPdBC1VmtG9
   lgZ1tpWomaIh2Hc+G57BaHWDb/mbyBxNvMWL/32Ee7SveG/YUzcQBUV5O
   nK6lOkhG82W9xljNU89yAae8CaIOfGZXMzTu5DxtgcGt3+1EoUL5mfd91
   ymJEKzN/nNtp65AO00cBtZVCVbArOq4y2b91rPyP3C1BmSNspmiwI/Wzv
   XbL9Q/zENLYI5pHzaS6HAR4CdW1hTi2/Zm5nx8mjLgvkUrFb/NtbqkK7r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="405019037"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="405019037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:08:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="712993206"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="712993206"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:08:03 -0800
Subject: [PATCH v4] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 15 Dec 2022 11:08:03 -0700
Message-ID: <167112768345.3343090.11728168471813709343.stgit@djiang5-desk3.ch.intel.com>
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

v4:
- Fix masking of RAS register. (Jonathan)

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
index 33083a522fd1..64272db6a3fd 100644
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
+	val &= ~mask;
+	writel(val, addr);
+	dev_dbg(&pdev->dev, "Unmasked Uncorrectable RAS Errors Mask: %#x\n", val);
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+	val = readl(addr);
+	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x\n", val);
+	val &= ~CXL_RAS_CORRECTABLE_MASK_MASK;
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


