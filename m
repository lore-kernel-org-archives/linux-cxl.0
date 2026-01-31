Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739521D6BB
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817777; cv=none; b=diGtcECoCAj0KpJMxbG371AKWBlMFfpHBq5j3Wnf+wyoFQMj5s3G2jDCz7IBlQLlocF776phBkLm37lBgQV21qiGQwS31olIK/cTNPWm42sUZmVUzuRiRSSztiClXklOoKMZrJMcdSumOLIJAM4XdFNCxxp/Pm/HVpDbR2bjtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817777; c=relaxed/simple;
	bh=a2GDeL6PN+XleVAYPkxX8Tl6Sg/PWxQL5NJ+2724/8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdOnvzLJZJaB6UV5EqTYiTHfnQmXpvPcVbfaima1NOVFg9f0ihUQuY3BnciAhGN7WchdPhL48ol3aolUC2OWAG4xmrog6HRfT+Q5EkULlstYEfWb69jRKbHFeOtGox8yvH72wDY+fRL7TtxH9oFvQcCY5dAwdQuohxM++SW0nVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAfz3Avg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAfz3Avg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817775; x=1801353775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a2GDeL6PN+XleVAYPkxX8Tl6Sg/PWxQL5NJ+2724/8U=;
  b=XAfz3AvgpfL4zuuX5e4Wf1vFPFyut2QvOcKF2DhyXtgaH8lbLvJ7eC1x
   y6ASgcbFZo+ih44V+sjuVIpe1K58htTfuSfw0fbNN5lb3z5HhEkmHzYLc
   LY+qJNLVfIlKSdosZBlD2+PEcYeD0xdT3GccMpqj29HbVWvr+t1/nt0Pi
   rFSoXshY4hEDlhqJoWMTadWqfUFWQu/G5lY3EEwOs9Rqr0A1LWrMLVEoH
   dRfv7kvJiHKjuHC3kxvJ1CGRj6ATGklJBnT9zd5An1mJ6aFze+Ewf2DXS
   46kyW5ZlYEQYnQq0njReWWe8sEFwbMFy237dw0RevynxzaVO4Pggz+w+Q
   A==;
X-CSE-ConnectionGUID: yrK+b4kXQe2fPCI1WDgrRw==
X-CSE-MsgGUID: VLb8P+DiREml42CLpIHzvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156923"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: FFYob//URfiCw/8Zo5+qVg==
X-CSE-MsgGUID: TSrVTo8cQUyPINxHmepDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093732"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 8/9] cxl/port: Move endpoint component register management to cxl_port
Date: Fri, 30 Jan 2026 16:04:02 -0800
Message-ID: <20260131000403.2135324-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for generic protocol error handling across CXL endpoints,
whether they be memory expander class devices or accelerators, drop the
endpoint component management from cxl_dev_state.

Organize all CXL port component management through the common cxl_port
driver.

Note that the end game is that drivers/cxl/core/ras.c loses all
dependencies on a 'struct cxl_dev_state' parameter and operates only on
port resources. The removal of component register mapping from cxl_pci is
an incremental step towards that.

Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h   |  4 +--
 drivers/cxl/core/ras.c |  6 ++--
 drivers/cxl/pci.c      | 63 +-----------------------------------------
 drivers/cxl/port.c     | 54 ++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 67 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..ab7201ef3ea6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -415,7 +415,7 @@ struct cxl_dpa_partition {
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @reg_map: component and ras register mapping parameters
- * @regs: Parsed register blocks
+ * @regs: Class device "Device" registers
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @media_ready: Indicate whether the device media is usable
@@ -431,7 +431,7 @@ struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_register_map reg_map;
-	struct cxl_regs regs;
+	struct cxl_device_regs regs;
 	int cxl_dvsec;
 	bool rcd;
 	bool media_ready;
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b4be9c5715a6..f6a8f4a355f1 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -255,6 +255,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &cxlds->cxlmd->dev;
 
 	scoped_guard(device, dev) {
@@ -268,7 +269,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -297,10 +298,9 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
 	}
 
-
 	switch (state) {
 	case pci_channel_io_normal:
 		if (ue) {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b7f694bda913..acb0eb2a13c3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -535,52 +535,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return cxl_setup_regs(map);
 }
 
-static int cxl_pci_ras_unmask(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	void __iomem *addr;
-	u32 orig_val, val, mask;
-	u16 cap;
-	int rc;
-
-	if (!cxlds->regs.ras) {
-		dev_dbg(&pdev->dev, "No RAS registers.\n");
-		return 0;
-	}
-
-	/* BIOS has PCIe AER error control */
-	if (!pcie_aer_is_native(pdev))
-		return 0;
-
-	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
-	if (rc)
-		return rc;
-
-	if (cap & PCI_EXP_DEVCTL_URRE) {
-		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
-		orig_val = readl(addr);
-
-		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
-		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
-		val = orig_val & ~mask;
-		writel(val, addr);
-		dev_dbg(&pdev->dev,
-			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
-			orig_val, val);
-	}
-
-	if (cap & PCI_EXP_DEVCTL_CERE) {
-		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
-		orig_val = readl(addr);
-		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
-		writel(val, addr);
-		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
-			orig_val, val);
-	}
-
-	return 0;
-}
-
 static void free_event_buf(void *buf)
 {
 	kvfree(buf);
@@ -912,13 +866,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	unsigned int i;
 	bool irq_avail;
 
-	/*
-	 * Double check the anonymous union trickery in struct cxl_regs
-	 * FIXME switch to struct_group()
-	 */
-	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
-		     offsetof(struct cxl_regs, device_regs.memdev));
-
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -942,7 +889,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+	rc = cxl_map_device_regs(&map, &cxlds->regs);
 	if (rc)
 		return rc;
 
@@ -957,11 +904,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->reg_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
-				    BIT(CXL_CM_CAP_CAP_ID_RAS));
-	if (rc)
-		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -1052,9 +994,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	if (cxl_pci_ras_unmask(pdev))
-		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
-
 	pci_save_state(pdev);
 
 	return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 6ebd665fb347..0ae78469207a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/aer.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -68,6 +69,55 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static int cxl_ras_unmask(struct cxl_port *port)
+{
+	struct pci_dev *pdev;
+	void __iomem *addr;
+	u32 orig_val, val, mask;
+	u16 cap;
+	int rc;
+
+	if (!dev_is_pci(port->uport_dev))
+		return 0;
+	pdev = to_pci_dev(port->uport_dev);
+
+	if (!port->regs.ras) {
+		pci_dbg(pdev, "No RAS registers.\n");
+		return 0;
+	}
+
+	/* BIOS has PCIe AER error control */
+	if (!pcie_aer_is_native(pdev))
+		return 0;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
+	if (rc)
+		return rc;
+
+	if (cap & PCI_EXP_DEVCTL_URRE) {
+		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+
+		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
+		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+		val = orig_val & ~mask;
+		writel(val, addr);
+		pci_dbg(pdev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	if (cap & PCI_EXP_DEVCTL_CERE) {
+		addr = port->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+		orig_val = readl(addr);
+		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
+		writel(val, addr);
+		pci_dbg(pdev, "Correctable RAS Errors Mask: %#x -> %#x\n",
+			orig_val, val);
+	}
+
+	return 0;
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
@@ -98,6 +148,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (dport->rch)
 		devm_cxl_dport_rch_ras_setup(dport);
 
+	devm_cxl_port_ras_setup(port);
+	if (cxl_ras_unmask(port))
+		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
-- 
2.52.0

