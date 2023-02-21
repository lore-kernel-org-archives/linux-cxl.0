Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFBEC61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBUR4X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjBUR4S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 12:56:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139F2FCDF
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 09:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677002148; x=1708538148;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cr7mtXbGVwrma96N5VP7aE/o0EGKLPOfr88kUyPYJ5A=;
  b=VNR4CSMEI2dFjjsQpxDGEw59WnRA4VPlB2QwhPd1UC8MqV3H5S/vNTzh
   2TV5FEyOd3qVQzLJbdsF6+sTqQxZ1yKpDBJ5ajTkyhCWgzOmO6SnP/Ppd
   CUo/AJHFk917ZMdfFNDaBq4fmy0u7fzhnXgUOaLxlSUTO4Td7PwurD33C
   t5FfEPSq7gRlcxT2ghvZgj6wPCLIcV+PxzBb471CtF+ok+vM3A0FnHM6a
   B647J7CBSNH9Yc+95KpIWWqs4qnEGdB3PiGmD+ziUpkK4hcoHOZErc0Qp
   jHiEtpWD3fEsD7OpbfhYhNzScXzL0mEsOj9iRjMjrQUMu7MGFZY17kqgX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="312333172"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="312333172"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:55:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="673757969"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="673757969"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.184.163])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:55:38 -0800
Subject: [PATCH v9] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, bhelgaas@google.com, ira.weiny@intel.com,
        lukas@wunner.de
Date:   Tue, 21 Feb 2023 10:55:36 -0700
Message-ID: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

By default the CXL RAS mask registers bits are defaulted to 1's and
suppress all error reporting. If the kernel has negotiated ownership
of error handling for CXL then unmask the mask registers by writing 0s.

PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
errors bits are set before unmasking the respective errors.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
Patch based on top of:
https://lore.kernel.org/linux-cxl/167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local/T/#u

v9:
- Move dev_warn() to dev_dbg(). (Dan)
v8:
- Fix lnksta2 size. (Bjorn)
v7:
- Check PCI_EXP_DEVCTL to enable related RAS errors.
v6:
- Call cxl_pci_ras_unmask() based on return of pci_enable_pcie_error_reporting()
- Check PCI_EXP_DEVCTL for UE and CE bit before unmasking the respective error reporting.

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
 drivers/cxl/pci.c             |   65 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |    1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b3964149c77b..d640fe61b893 100644
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
index c87340095a8a..b6882c2b26d4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -637,6 +637,67 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u16 lnksta2;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
+static int cxl_pci_ras_unmask(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	void __iomem *addr;
+	u32 orig_val, val, mask;
+	u16 cap;
+	int rc;
+
+	if (!cxlds->regs.ras) {
+		dev_dbg(&pdev->dev, "No RAS registers.\n");
+		return 0;
+	}
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return -EOPNOTSUPP;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
+	if (rc)
+		return rc;
+
+	if (cap & PCI_EXP_DEVCTL_URRE) {
+		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+
+		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
+		if (!cxl_pci_flit_256(pdev))
+			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+		val = orig_val & ~mask;
+		writel(val, addr);
+		dev_dbg(&pdev->dev,
+			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	if (cap & PCI_EXP_DEVCTL_CERE) {
+		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
+		writel(val, addr);
+		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	return 0;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_pci_ras_unmask(pdev);
+	if (rc)
+		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
+
 	pci_save_state(pdev);
 
 	return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 85ab1278811e..dc2000e0fe3a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -693,6 +693,7 @@
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
 #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
+#define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
 #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
 #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */


