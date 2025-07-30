Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B62957AD
	for <linux-cxl@vger.kernel.org>; Wed, 30 Jul 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889127; cv=none; b=oiAFz+d5lGyeq+YcJSm9e8tBD3DX4ToktJ5rqYf1zhAVLdiLruRz0QP1RqzAAcjJSDQj6NyjiijckvpEXrLgdq+Iiq7P1/0zYZful433VjdC2nqJFgcm1eVLJAHbiVQd7eg9gvjaa1wvKgIt2MIWBa4iUhVoFxczWU4U1Esij6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889127; c=relaxed/simple;
	bh=btQNP1t6GDmERGU0UpfTH3+aD4512EdUSfnbz7u+apo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOGPnVhzEcX3hryg84TvlSia7ps+aUBssaVJYIc6WTdyt0RMLj4PED/wEzIUYD7ojavMJcdvfvN5BSlnK+Bxp6Egfcnk5t/k+Bc2DXXda/a70Qjh8c+bsAUSoIRE4WnXvAxZcNtKgC6JAJ31IMi/9CsUiqxeQFN7yDZnbxiarcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C21C4CEE3;
	Wed, 30 Jul 2025 15:25:25 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
Date: Wed, 30 Jul 2025 08:25:19 -0700
Message-ID: <20250730152519.125601-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
the config. The config will depend on CPER or PCIE AER to build.
Move the related RAS code from core/pci.c to core/ras.c.

Cc: Robert Richter <rrichter@amd.com>
Cc: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Make cxl_handle_rdport_errors() static. (Dan)
---
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/core/Makefile |   2 +-
 drivers/cxl/core/pci.c    | 319 --------------------------------------
 drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   8 -
 drivers/cxl/cxlpci.h      |  16 ++
 tools/testing/cxl/Kbuild  |   1 +
 7 files changed, 334 insertions(+), 328 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..b36bb0cabe58 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,8 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_RAS
+	def_bool y
+	depends on ACPI_APEI_GHES || PCIEAER_CXL
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..1c652e575aaa 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,10 +14,10 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
-cxl_core-y += ras.o
 cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
+cxl_core-$(CONFIG_CXL_RAS) += ras.o
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b50551601c2e..a3aef78f903a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,7 +6,6 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
-#include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -664,324 +663,6 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
-				 void __iomem *ras_base)
-{
-	void __iomem *addr;
-	u32 status;
-
-	if (!ras_base)
-		return;
-
-	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
-	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
-	}
-}
-
-static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
-}
-
-/* CXL spec rev3.0 8.2.4.16.1 */
-static void header_log_copy(void __iomem *ras_base, u32 *log)
-{
-	void __iomem *addr;
-	u32 *log_addr;
-	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
-
-	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
-	log_addr = log;
-
-	for (i = 0; i < log_u32_size; i++) {
-		*log_addr = readl(addr);
-		log_addr++;
-		addr += sizeof(u32);
-	}
-}
-
-/*
- * Log the state of the RAS status registers and prepare them to log the
- * next error status. Return 1 if reset needed.
- */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
-{
-	u32 hl[CXL_HEADERLOG_SIZE_U32];
-	void __iomem *addr;
-	u32 status;
-	u32 fe;
-
-	if (!ras_base)
-		return false;
-
-	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
-	status = readl(addr);
-	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
-
-	/* If multiple errors, log header points to first error from ctrl reg */
-	if (hweight32(status) > 1) {
-		void __iomem *rcc_addr =
-			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
-
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   readl(rcc_addr)));
-	} else {
-		fe = status;
-	}
-
-	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
-	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
-
-	return true;
-}
-
-static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
-{
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
-}
-
-#ifdef CONFIG_PCIEAER_CXL
-
-static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
-{
-	resource_size_t aer_phys;
-	struct device *host;
-	u16 aer_cap;
-
-	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
-	if (aer_cap) {
-		host = dport->reg_map.host;
-		aer_phys = aer_cap + dport->rcrb.base;
-		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
-						sizeof(struct aer_capability_regs));
-	}
-}
-
-static void cxl_dport_map_ras(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-}
-
-static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
-{
-	void __iomem *aer_base = dport->regs.dport_aer;
-	u32 aer_cmd_mask, aer_cmd;
-
-	if (!aer_base)
-		return;
-
-	/*
-	 * Disable RCH root port command interrupts.
-	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
-	 *
-	 * This sequence may not be necessary. CXL spec states disabling
-	 * the root cmd register's interrupts is required. But, PCI spec
-	 * shows these are disabled by default on reset.
-	 */
-	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
-			PCI_ERR_ROOT_CMD_NONFATAL_EN |
-			PCI_ERR_ROOT_CMD_FATAL_EN);
-	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
-	aer_cmd &= ~aer_cmd_mask;
-	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
-}
-
-/**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
- * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
- */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
-{
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
-
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
-
-		if (!host_bridge->native_aer)
-			return;
-
-		cxl_dport_map_rch_aer(dport);
-		cxl_disable_rch_root_ints(dport);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
-
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
-/*
- * Copy the AER capability registers using 32 bit read accesses.
- * This is necessary because RCRB AER capability is MMIO mapped. Clear the
- * status after copying.
- *
- * @aer_base: base address of AER capability block in RCRB
- * @aer_regs: destination for copying AER capability
- */
-static bool cxl_rch_get_aer_info(void __iomem *aer_base,
-				 struct aer_capability_regs *aer_regs)
-{
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
-
-	if (!aer_base)
-		return false;
-
-	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
-
-	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
-	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
-
-	return true;
-}
-
-/* Get AER severity. Return false if there is no error. */
-static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
-				     int *severity)
-{
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
-		return true;
-	}
-
-	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
-		*severity = AER_CORRECTABLE;
-		return true;
-	}
-
-	return false;
-}
-
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct aer_capability_regs aer_regs;
-	struct cxl_dport *dport;
-	int severity;
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return;
-
-	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
-		return;
-
-	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
-		return;
-
-	pci_print_aer(pdev, severity, &aer_regs);
-
-	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
-	else
-		cxl_handle_rdport_ras(cxlds, dport);
-}
-
-#else
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
-#endif
-
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_endpoint_cor_ras(cxlds);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_endpoint_ras(cxlds);
-	}
-
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
-
 static int cxl_flit_size(struct pci_dev *pdev)
 {
 	if (cxl_pci_flit_256(pdev))
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..2e203a07786d 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -4,7 +4,9 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <cxl/event.h>
+#include <cxlpci.h>
 #include <cxlmem.h>
+#include <cxl.h>
 #include "trace.h"
 
 static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
@@ -117,3 +119,313 @@ void cxl_ras_exit(void)
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
 	cancel_work_sync(&cxl_cper_prot_err_work);
 }
+
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	resource_size_t aer_phys;
+	struct device *host;
+	u16 aer_cap;
+
+	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
+	if (aer_cap) {
+		host = dport->reg_map.host;
+		aer_phys = aer_cap + dport->rcrb.base;
+		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
+						sizeof(struct aer_capability_regs));
+	}
+}
+
+static void cxl_dport_map_ras(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+}
+
+static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
+{
+	void __iomem *aer_base = dport->regs.dport_aer;
+	u32 aer_cmd_mask, aer_cmd;
+
+	if (!aer_base)
+		return;
+
+	/*
+	 * Disable RCH root port command interrupts.
+	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
+	 *
+	 * This sequence may not be necessary. CXL spec states disabling
+	 * the root cmd register's interrupts is required. But, PCI spec
+	 * shows these are disabled by default on reset.
+	 */
+	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
+			PCI_ERR_ROOT_CMD_NONFATAL_EN |
+			PCI_ERR_ROOT_CMD_FATAL_EN);
+	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
+	aer_cmd &= ~aer_cmd_mask;
+	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
+}
+
+/**
+ * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * @dport: the cxl_dport that needs to be initialized
+ * @host: host device for devm operations
+ */
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+{
+	dport->reg_map.host = host;
+	cxl_dport_map_ras(dport);
+
+	if (dport->rch) {
+		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
+
+		if (!host_bridge->native_aer)
+			return;
+
+		cxl_dport_map_rch_aer(dport);
+		cxl_disable_rch_root_ints(dport);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+
+static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+{
+	void __iomem *addr;
+	u32 status;
+
+	if (!ras_base)
+		return;
+
+	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	}
+}
+
+/* CXL spec rev3.0 8.2.4.16.1 */
+static void header_log_copy(void __iomem *ras_base, u32 *log)
+{
+	void __iomem *addr;
+	u32 *log_addr;
+	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
+
+	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
+	log_addr = log;
+
+	for (i = 0; i < log_u32_size; i++) {
+		*log_addr = readl(addr);
+		log_addr++;
+		addr += sizeof(u32);
+	}
+}
+
+static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
+					  struct cxl_dport *dport)
+{
+	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+}
+
+/*
+ * Log the state of the RAS status registers and prepare them to log the
+ * next error status. Return 1 if reset needed.
+ */
+static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+{
+	u32 hl[CXL_HEADERLOG_SIZE_U32];
+	void __iomem *addr;
+	u32 status;
+	u32 fe;
+
+	if (!ras_base)
+		return false;
+
+	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
+		return false;
+
+	/* If multiple errors, log header points to first error from ctrl reg */
+	if (hweight32(status) > 1) {
+		void __iomem *rcc_addr =
+			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
+
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
+				   readl(rcc_addr)));
+	} else {
+		fe = status;
+	}
+
+	header_log_copy(ras_base, hl);
+	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+
+	return true;
+}
+
+static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
+				       struct cxl_dport *dport)
+{
+	return __cxl_handle_ras(cxlds, dport->regs.ras);
+}
+
+/*
+ * Copy the AER capability registers using 32 bit read accesses.
+ * This is necessary because RCRB AER capability is MMIO mapped. Clear the
+ * status after copying.
+ *
+ * @aer_base: base address of AER capability block in RCRB
+ * @aer_regs: destination for copying AER capability
+ */
+static bool cxl_rch_get_aer_info(void __iomem *aer_base,
+				 struct aer_capability_regs *aer_regs)
+{
+	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	u32 *aer_regs_buf = (u32 *)aer_regs;
+	int n;
+
+	if (!aer_base)
+		return false;
+
+	/* Use readl() to guarantee 32-bit accesses */
+	for (n = 0; n < read_cnt; n++)
+		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+
+	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
+	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
+
+	return true;
+}
+
+/* Get AER severity. Return false if there is no error. */
+static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
+				     int *severity)
+{
+	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
+		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+			*severity = AER_FATAL;
+		else
+			*severity = AER_NONFATAL;
+		return true;
+	}
+
+	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
+		*severity = AER_CORRECTABLE;
+		return true;
+	}
+
+	return false;
+}
+
+static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct aer_capability_regs aer_regs;
+	struct cxl_dport *dport;
+	int severity;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return;
+
+	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
+		return;
+
+	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs);
+
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_rdport_cor_ras(cxlds, dport);
+	else
+		cxl_handle_rdport_ras(cxlds, dport);
+}
+
+static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+}
+
+static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
+{
+	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+}
+
+void cxl_cor_error_detected(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct device *dev = &cxlds->cxlmd->dev;
+
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		cxl_handle_endpoint_cor_ras(cxlds);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	bool ue;
+
+	scoped_guard(device, dev) {
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+		/*
+		 * A frozen channel indicates an impending reset which is fatal to
+		 * CXL.mem operation, and will likely crash the system. On the off
+		 * chance the situation is recoverable dump the status of the RAS
+		 * capability registers and bounce the active state of the memdev.
+		 */
+		ue = cxl_handle_endpoint_ras(cxlds);
+	}
+
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
+EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f68a9414da26..ddf0ee46b116 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -760,14 +760,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
 
-#ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
-#else
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
-#endif
-
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..3959fa7e2ead 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -132,7 +132,23 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
+
+#ifdef CONFIG_CXL_RAS
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+#else
+static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
+
+static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+						  pci_channel_state_t state)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						struct device *host) { }
+#endif
+
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 31a2d73c963f..4cc8099bbcd2 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
+cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o

base-commit: 6e130ce1dfd47a1ef953d0be127934760aecb769
-- 
2.50.1

