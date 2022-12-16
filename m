Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27BC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 16:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiLPQL3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLPQKb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 11:10:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3602709
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671207003; x=1702743003;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l7d8kpJeWdxEshv0AOuxKq4L5TmaPdyRvyXFpeCs69w=;
  b=mi33htAxfVsJULPjQo0SUXpKpF5UAhXbYtAsxw6U3Qr2ZvJtSdis1C0n
   /ltdOAwvZTwnbZ+UgM2bquVQNkBPOf1g0MivwEeaFC19STnRnkjWFRXOE
   5JAuipRs1x/ywDIhqQIAB36y5CRSOOFD3fQLfuucXrbzPqBs4kCKx+w2Y
   S8hkwbo56gH5YiIBMcLkR83TsPsWS/b1oj/ySikV4YqatdQ3j2xjfKRbs
   dnWDO+A3CSbEjIOe52ze9zMvwh9vb3QWZyEUzQwmjDThRNBN/ax3cvHGO
   d0ASp4O8+IuFyzIuW6hwBOjq5jzCxqQiP1gQ3aksr94JNl8tme+uTMDBP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="381218444"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381218444"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:10:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="774204523"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="774204523"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:10:01 -0800
Subject: [PATCH v5] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Dec 2022 09:10:02 -0700
Message-ID: <167120700197.3444116.12992018879314163331.stgit@djiang5-desk3.ch.intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

Based on patch posted by Ira [1] to export CXL native error reporting control.

[1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/

v5:
- Add single debug out to show mask changing. (Dan)

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
 drivers/cxl/pci.c             |   49 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |    1 +
 3 files changed, 51 insertions(+)

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
index 33083a522fd1..1e5fc69bcc4d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -419,6 +419,54 @@ static void disable_aer(void *pdev)
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
+	u32 orig_val, val, mask;
+
+	if (!cxlds->regs.ras)
+		return -ENODEV;
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return -EOPNOTSUPP;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+	orig_val = readl(addr);
+
+	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
+	if (!cxl_pci_flit_256(pdev))
+		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+	val = orig_val & ~mask;
+	writel(val, addr);
+	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n",
+		orig_val, val);
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+	orig_val = readl(addr);
+	val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
+	writel(val, addr);
+	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
+		orig_val, val);
+
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -498,6 +546,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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


