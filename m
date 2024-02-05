Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1559171C4
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142994; cv=none; b=dpPASlgnwPs5cgkGObJXqIBL1kdQXlOlCut6DV/jJ9vbdAeePd6pvKIv3vjvB2VT2amnUB0qfVbSZ/5uGgRoGf0yF6xFTcf9p6dFORkNlxqCW/S6B6WmmZqFmCbf6Bg23fP5fTN/KF/4t+Z+Fbp32Asy6uyDIP2bUg1ZjbooOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142994; c=relaxed/simple;
	bh=yhCB7A1lNC8aAUUwApgHkcQVyw4fdgfE787tcKDi0XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEGlf0+2Le0M59fKJ4o4s2qUoDqWGTmmHdvQTN7Y6U0pE9wloLRXHyWce3k5IDn9vvMhzp/ZN+4OKBbY4vPlo7bxGqgO6NVoTymbGTZjbkcpQ1TQOyJcKd9cFzS78M7bGGfyGfxlVbZW0K2SvrjwgFY87L63lNf63Wj1FSjNoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7mm2Fq4z6JB8F;
	Mon,  5 Feb 2024 22:19:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CA251404FC;
	Mon,  5 Feb 2024 22:23:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:23:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 07/11] pci/aer: Support firmware first error injection via GHESv2
Date: Mon, 5 Feb 2024 14:19:36 +0000
Message-ID: <20240205141940.31111-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

If the machine supports firmware first error injection
enable those flows.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/ghes.h |   3 +
 hw/acpi/ghes-stub.c    |   4 +
 hw/acpi/ghes.c         | 250 +++++++++++++++++++++++++++++++++++++++--
 hw/pci/pcie_aer.c      |  35 ++++--
 4 files changed, 271 insertions(+), 21 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 3210c19c14..437aeae7f6 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -76,6 +76,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
 int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
 
+typedef struct PCIDevice PCIDevice;
+bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify);
+
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 1ad7b9f776..bd208af4ec 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,6 +11,10 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
+bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify)
+{
+    return true;
+}
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     return -1;
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 9f99202e1f..d0103c0a6a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -26,6 +26,8 @@
 #include "qemu/error-report.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/nvram/fw_cfg.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
 #include "qemu/uuid.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
@@ -52,6 +54,7 @@
 
 /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
 #define ACPI_GHES_MEM_CPER_LENGTH           80
+#define ACPI_GHES_PCIE_CPER_LENGTH 208
 
 /* Masks for block_status flags */
 #define ACPI_GEBS_UNCORRECTABLE         1
@@ -184,6 +187,98 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
     build_append_int_noprefix(table, 0, 7);
 }
 
+static void build_append_aer_cper(PCIDevice *dev, GArray *table)
+{
+    PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(dev);
+    uint16_t pcie_cap_offset = pci_find_capability(dev, 0x10);
+    uint16_t sn_cap_offset = pcie_find_capability(dev, 0x3);
+    uint16_t aer_cap_offset = pcie_find_capability(dev, 0x1);
+    int i;
+
+    build_append_int_noprefix(table,
+                               /* Port Type */
+                              ((pcie_cap_offset ? 1UL : 0UL) << 0) |
+                               /* PCI Express Version */
+                              (1UL << 1) |
+                              /* Command Status */
+                              (1UL << 2) |
+                              /* Device ID valid */
+                              (1UL << 3) |
+                              /* Serial Number */
+                              ((sn_cap_offset ? 1UL : 0UL) << 4) |
+                              /* Whole PCIe Capability */
+                              ((pcie_cap_offset ? 1UL : 0UL) << 6) |
+                              /* AER capability */
+                              ((aer_cap_offset ? 1UL : 0UL) << 7),
+                              8);
+    if (pcie_cap_offset) {
+        uint16_t cap_reg = pci_get_word(dev->config + pcie_cap_offset
+                                        + PCI_EXP_FLAGS);
+        uint16_t port_type = (cap_reg & PCI_EXP_FLAGS_TYPE) >>
+            PCI_EXP_FLAGS_TYPE_SHIFT;
+
+        build_append_int_noprefix(table, port_type, 4);
+    }
+    build_append_int_noprefix(table, 1, 1); /* Version PCIE r6.1 */
+    build_append_int_noprefix(table, 6, 1);
+    build_append_int_noprefix(table, 0, 2); /* Reserved */
+
+    build_append_int_noprefix(table,
+                              pci_get_word(dev->config + PCI_COMMAND), 2);
+    build_append_int_noprefix(table, pci_get_word(dev->config + PCI_STATUS), 2);
+    build_append_int_noprefix(table, 0, 4); /* 20-23 reserved */
+
+    build_append_int_noprefix(table, pci_class->vendor_id, 2);
+    build_append_int_noprefix(table, pci_class->device_id, 2);
+    build_append_int_noprefix(table, pci_class->class_id, 3);
+    build_append_int_noprefix(table, PCI_FUNC(dev->devfn), 1);
+    build_append_int_noprefix(table, PCI_SLOT(dev->devfn), 1);
+    build_append_int_noprefix(table, 0, 2); /* Segment number */
+
+    /* RP/B primary bus number / device bus number */
+    build_append_int_noprefix(table, pci_dev_bus_num(dev), 1);
+    build_append_int_noprefix(table, 0, 1);
+    /*
+     * TODO: Figure out where to get the slot number from.
+     * The slot number capability is deprecated so it only really
+     * exists via the _DSM which is not easily available from here.
+     */
+    build_append_int_noprefix(table, 0, 2);
+    build_append_int_noprefix(table, 0, 1);  /* reserved */
+
+    /* Serial number */
+    if (sn_cap_offset) {
+        uint32_t dw = pci_get_long(dev->config + sn_cap_offset + 4);
+
+        build_append_int_noprefix(table, dw, 4);
+        dw = pci_get_long(dev->config + sn_cap_offset + 8);
+        build_append_int_noprefix(table, dw, 4);
+    } else {
+        build_append_int_noprefix(table, 0, 8);
+    }
+
+    /* Bridge control status */
+    build_append_int_noprefix(table, 0, 4);
+
+    if (pcie_cap_offset) {
+        uint32_t *pcie_cap = (uint32_t *)(dev->config + pcie_cap_offset);
+        for (i = 0; i < 60 / sizeof(uint32_t); i++) {
+            build_append_int_noprefix(table, pcie_cap[i], sizeof(uint32_t));
+        }
+    } else { /* Odd if we don't have one of these! */
+        build_append_int_noprefix(table, 0, 60);
+    }
+
+    if (aer_cap_offset) {
+        uint32_t *aer_cap = (uint32_t *)(dev->config + aer_cap_offset);
+        for (i = 0; i < 96 / sizeof(uint32_t); i++) {
+            build_append_int_noprefix(table, aer_cap[i], sizeof(uint32_t));
+        }
+    } else {
+        build_append_int_noprefix(table, 0, 96);
+    }
+}
+
 static int acpi_ghes_record_mem_error(uint64_t error_block_address,
                                       uint64_t error_physical_addr)
 {
@@ -231,6 +326,45 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
     return 0;
 }
 
+static int ghes_record_aer_error(PCIDevice *dev, uint64_t error_block_address)
+{
+    const uint8_t aer_section_id_le[] = {
+        0x54, 0xE9, 0x95, 0xD9, 0xC1, 0xBB, 0x0F,
+        0x43, 0xAD, 0x91, 0xB4, 0x4D, 0xCB, 0x3C,
+        0x6F, 0x35 };
+    QemuUUID fru_id = { 0 };
+    GArray *block = g_array_new(false, true, 1);
+    uint32_t data_length;
+
+    /* Read the current length in bytes of the generic error data */
+    cpu_physical_memory_read(error_block_address + 8, &data_length, 4);
+
+    /* Add a new generic error data entry*/
+    data_length += ACPI_GHES_DATA_LENGTH;
+    data_length += ACPI_GHES_PCIE_CPER_LENGTH;
+
+    /*
+     * Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return false;
+    }
+
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE, 0, 0,
+                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
+    acpi_ghes_generic_error_data(block, aer_section_id_le,
+                                 ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                 ACPI_GHES_PCIE_CPER_LENGTH, fru_id, 0);
+
+    build_append_aer_cper(dev, block);
+    cpu_physical_memory_write(error_block_address, block->data, block->len);
+    g_array_free(block, true);
+
+    return true;
+}
+
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -392,23 +526,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
+static uint64_t ghes_get_state_start_address(void)
+{
+    AcpiGedState *acpi_ged_state =
+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
+    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
+
+    return le64_to_cpu(ags->ghes_addr_le);
+}
+
 int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
-    uint64_t start_addr;
+    uint64_t start_addr = ghes_get_state_start_address();
     bool ret = -1;
-    AcpiGedState *acpi_ged_state;
-    AcpiGhesState *ags;
-
     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    g_assert(acpi_ged_state);
-    ags = &acpi_ged_state->ghes_state;
-
-    start_addr = le64_to_cpu(ags->ghes_addr_le);
-
     if (physical_address) {
 
         if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
@@ -448,6 +581,101 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     return ret;
 }
 
+/*
+ * Error register block data layout
+ *
+ * | +---------------------+ ges.ghes_addr_le
+ * | |error_block_address0 |
+ * | +---------------------+
+ * | |error_block_address1 |
+ * | +---------------------+ --+--
+ * | |    .............    | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |error_block_addressN |
+ * | +---------------------+
+ * | | read_ack_register0  |
+ * | +---------------------+ --+--
+ * | | read_ack_register1  | GHES_ADDRESS_SIZE
+ * | +---------------------+ --+--
+ * | |   .............     |
+ * | +---------------------+
+ * | | read_ack_registerN  |
+ * | +---------------------+ --+--
+ * | |      CPER           |   |
+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+ * | |      CPER           |   |
+ * | +---------------------+ --+--
+ * | |    ..........       |
+ * | +---------------------+
+ * | |      CPER           |
+ * | |      ....           |
+ * | |      CPER           |
+ * | +---------------------+
+ */
+
+/* Map from uint32_t notify to entry offset in GHES */
+static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
+                                                 0xff, 0xff, 0xff, 1, 0};
+
+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
+                          uint64_t *read_ack_register_addr)
+{
+    uint64_t base;
+
+    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
+        return false;
+    }
+
+    /* Find and check the source id for this new CPER */
+    if (error_source_to_index[notify] == 0xff) {
+        return false;
+    }
+
+    base = ghes_get_state_start_address();
+
+    *read_ack_register_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * sizeof(uint64_t);
+
+    /* Could also be read back from the error_block_address register */
+    *error_block_addr = base +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
+
+    return true;
+}
+
+bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify)
+{
+    int read_ack_register = 0;
+    uint64_t read_ack_register_addr = 0;
+    uint64_t error_block_addr = 0;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
+        return false;
+    }
+
+    cpu_physical_memory_read(read_ack_register_addr, &read_ack_register,
+                             sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("Last time OSPM does not acknowledge the error,"
+                     " record CPER failed this time, set the ack value to"
+                     " avoid blocking next time CPER record! exit");
+        read_ack_register = 1;
+        cpu_physical_memory_write(read_ack_register_addr, &read_ack_register,
+                                  sizeof(uint64_t));
+        return false;
+    }
+
+    read_ack_register = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_register_addr, &read_ack_register,
+                              sizeof(uint64_t));
+
+    return ghes_record_aer_error(dev, error_block_addr);
+}
+
 bool acpi_ghes_present(void)
 {
     AcpiGedState *acpi_ged_state;
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 2c85a78fcd..414a9564c2 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
@@ -27,6 +28,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
 #include "pci-internal.h"
+#include "hw/acpi/ghes.h"
 
 //#define DEBUG_PCIE
 #ifdef DEBUG_PCIE
@@ -638,6 +640,8 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject *inj, bool is_fatal)
  */
 int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     uint8_t *aer_cap = NULL;
     uint16_t devctl = 0;
     uint16_t devsta = 0;
@@ -701,16 +705,27 @@ int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
     }
 
     /* send up error message */
-    inj.msg.source_id = err->source_id;
-    pcie_aer_msg(dev, &inj.msg);
-
-    if (inj.log_overflow) {
-        PCIEAERErr header_log_overflow = {
-            .status = PCI_ERR_COR_HL_OVERFLOW,
-            .flags = PCIE_AER_ERR_IS_CORRECTABLE,
-        };
-        int ret = pcie_aer_inject_error(dev, &header_log_overflow);
-        assert(!ret);
+    if (!acpi_fw_first_pci()) {
+        inj.msg.source_id = err->source_id;
+        pcie_aer_msg(dev, &inj.msg);
+
+        if (inj.log_overflow) {
+            PCIEAERErr header_log_overflow = {
+                .status = PCI_ERR_COR_HL_OVERFLOW,
+                .flags = PCIE_AER_ERR_IS_CORRECTABLE,
+            };
+            int ret = pcie_aer_inject_error(dev, &header_log_overflow);
+            assert(!ret);
+        }
+    } else {
+        ghes_record_aer_errors(dev, ACPI_GHES_NOTIFY_GPIO);
+        if (mc->set_error) {
+            mc->set_error();
+        }
+        /* Simulation a firmware clearing status */
+        /* Bit hacky but we only injected one error so this should be fine */
+        pci_set_long(aer_cap + PCI_ERR_UNCOR_STATUS, 0);
+        pci_set_long(aer_cap + PCI_ERR_COR_STATUS, 0);
     }
     return 0;
 }
-- 
2.39.2

