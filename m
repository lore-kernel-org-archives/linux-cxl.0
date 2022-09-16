Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3634ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIPXLs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIPXLr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CDF7C32C
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369906; x=1694905906;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ueGRt4thWrbvzTif0qdSUiBRjX3AujplroxNnr6zkhA=;
  b=OJdbZ3jRZZBUTkxSDUzEeApQQSiy0Nlx5HR8gFq/aMatt2cMbvuVuvfc
   25368jhKYP2SHIDBUjhw1L37VsADD69pUr22gng3XOkBMjFcHM4XqFGry
   UW6I7OFGSChIj8qj4kY11VTq69MIYHA1iV/9+O0pUO4FVAZTDrZg274Eb
   n0O80B5IoxBOwbDZyewGDuqSDiThCgIKr3JP7KfglRnGXXapes84YKbCQ
   Ivm21J76eqP+xO9xBGda1Qo/Bj8v6PqyKhCjwvwl3nSwbWvUj2sH7GZlW
   iDq+Qt34Y6LkAH6U3l+dp6bXTAotESk3dlRftyV7dfbyOJYA/b9fOxIB0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278825776"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="278825776"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="793254566"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:45 -0700
Subject: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:45 -0700
Message-ID: <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Add nominal error handling that tears down CXL.mem in response to error
notifications that imply a device reset. Given some CXL.mem may be
operating as System RAM, there is a high likelihood that these error
events are fatal. However, if the system survives the notification the
expectation is that the driver behavior is equivalent to a hot-unplug
and re-plug of an endpoint.

Note that this does not change the mask values from the default. That
awaits CXL _OSC support to determine whether platform firmware is in
control of the mask registers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/memdev.c |    1 
 drivers/cxl/cxl.h         |    2 +
 drivers/cxl/cxlmem.h      |    2 +
 drivers/cxl/pci.c         |  160 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a7754..a74a93310d26 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -344,6 +344,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	 * needed as this is ordered with cdev_add() publishing the device.
 	 */
 	cxlmd->cxlds = cxlds;
+	cxlds->cxlmd = cxlmd;
 
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ce17ccd8b125..35434b110a3b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -132,7 +132,9 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 #define CXL_RAS_CORRECTABLE_MASK_OFFSET 0x10
 #define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
 #define CXL_RAS_CAP_CONTROL_OFFSET 0x14
+#define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
+#define CXL_RAX_HEADER_LOG_SIZE 512
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..b3117fd67f42 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -186,6 +186,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -218,6 +219,7 @@ struct cxl_endpoint_dvsec_info {
  */
 struct cxl_dev_state {
 	struct device *dev;
+	struct cxl_memdev *cxlmd;
 
 	struct cxl_regs regs;
 	int cxl_dvsec;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 357de704e42c..d51e34c4c87e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -399,6 +400,11 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static void disable_aer(void *pdev)
+{
+	pci_disable_pcie_error_reporting(pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -420,6 +426,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds = cxl_dev_state_create(&pdev->dev);
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
+	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
@@ -474,6 +481,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	if (cxlds->regs.ras) {
+		pci_enable_pcie_error_reporting(pdev);
+		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
+		if (rc)
+			return rc;
+	}
+	pci_save_state(pdev);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
@@ -487,10 +502,155 @@ static const struct pci_device_id cxl_mem_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
 
+/* CXL spec rev3.0 8.2.4.16.1 */
+#define DATA_HEADER_SIZE 16
+#define FLIT_SIZE (64 + 2)
+static int header_log_setup(struct cxl_dev_state *cxlds, u32 fe, u8 *log)
+{
+	void __iomem *addr;
+
+	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
+
+	if (fe & CXL_RAS_UC_CACHE_DATA_PARITY || fe & CXL_RAS_UC_CACHE_ADDR_PARITY ||
+	    fe & CXL_RAS_UC_CACHE_BE_PARITY || fe & CXL_RAS_UC_CACHE_DATA_ECC ||
+	    fe & CXL_RAS_UC_MEM_DATA_PARITY || fe & CXL_RAS_UC_MEM_ADDR_PARITY ||
+	    fe & CXL_RAS_UC_MEM_BE_PARITY || fe & CXL_RAS_UC_MEM_DATA_ECC) {
+		memcpy_fromio(log, addr, DATA_HEADER_SIZE);
+		return DATA_HEADER_SIZE;
+	}
+
+	if (fe & CXL_RAS_UC_RSVD_ENCODE) {
+		memcpy_fromio(log, addr, FLIT_SIZE);
+		return FLIT_SIZE;
+	}
+
+	if (fe & CXL_RAS_UC_RECV_OVERFLOW) {
+		*log = readb(addr);
+		return sizeof(u8);
+	}
+
+	return 0;
+}
+
+/*
+ * Log the state of the RAS status registers and prepare them to log the
+ * next error status. Return 1 if reset needed.
+ */
+static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	void __iomem *addr;
+	u32 status;
+	bool ue = false;
+
+	if (!cxlds->regs.ras)
+		return false;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = le32_to_cpu(readl(addr));
+	if (status & CXL_RAS_UNCORRECTABLE_STATUS_MASK) {
+		u8 hl[CXL_RAX_HEADER_LOG_SIZE];
+		u32 fe;
+		int size;
+
+		writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+		ue = true;
+
+		/* If multiple errors, log header points to first error from ctrl reg */
+		if (hweight32(status) > 1) {
+			addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+			fe = BIT(le32_to_cpu(readl(addr)) & CXL_RAS_CAP_CONTROL_FE_MASK);
+		} else {
+			fe = status;
+		}
+
+		size = header_log_setup(cxlds, fe, hl);
+		trace_cxl_ras_uc(dev_name(dev), status, fe, hl, size);
+	}
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = le32_to_cpu(readl(addr));
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+		trace_cxl_ras_ce(dev_name(dev), status);
+	}
+
+	return ue;
+}
+
+static pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	bool ue;
+
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	ue = cxl_report_and_clear(cxlds);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		if (ue) {
+			device_release_driver(dev);
+			return PCI_ERS_RESULT_NEED_RESET;
+		}
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		dev_warn(&pdev->dev,
+			 "%s: frozen state error detected, disable CXL.mem\n",
+			 dev_name(dev));
+		device_release_driver(dev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_warn(&pdev->dev,
+			 "failure state error detected, request disconnect\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	dev_info(&pdev->dev, "%s: restart CXL.mem after slot reset\n",
+		 dev_name(dev));
+	pci_restore_state(pdev);
+	if (device_attach(dev) <= 0)
+		return PCI_ERS_RESULT_DISCONNECT;
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void cxl_error_resume(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	dev_info(&pdev->dev, "%s: error resume %s\n", dev_name(dev),
+		 dev->driver ? "successful" : "failed");
+}
+
+static const struct pci_error_handlers cxl_error_handlers = {
+	.error_detected	= cxl_error_detected,
+	.slot_reset	= cxl_slot_reset,
+	.resume		= cxl_error_resume,
+};
+
 static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
+	.err_handler		= &cxl_error_handlers,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},


