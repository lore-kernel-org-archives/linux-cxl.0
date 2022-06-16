Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0A4C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Jun 2022 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbiFPOUQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377153AbiFPOUP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Jun 2022 10:20:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD3FF8
        for <linux-cxl@vger.kernel.org>; Thu, 16 Jun 2022 07:20:14 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LP43c4ws4z67xN7;
        Thu, 16 Jun 2022 22:16:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 16 Jun 2022 16:20:12 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:20:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <qemu-arm@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v11 1/2] hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances pxb-cxl
Date:   Thu, 16 Jun 2022 15:19:49 +0100
Message-ID: <20220616141950.23374-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Code based on i386/pc enablement.
The memory layout places space for 16 host bridge register regions after
the GIC_REDIST2 in the extended memmap.
The CFMWs are placed above the extended memmap.

Only create the CEDT table if cxl=on set for the machine.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
 hw/arm/virt-acpi-build.c | 34 +++++++++++++++++++++++++++++++
 hw/arm/virt.c            | 44 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h    |  3 +++
 3 files changed, 81 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 449fab0080..d47efcb297 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -39,9 +39,11 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/cxl.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
+#include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -157,10 +159,29 @@ static void acpi_dsdt_add_virtio(Aml *scope,
     }
 }
 
+/* Uses local definition of AcpiBuildState so can't easily be common code */
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev, *scope, *method;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x01)));
+    aml_append(dev, method);
+
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
+    bool cxl_present = false;
+    PCIBus *bus = vms->bus;
     struct GPEXConfig cfg = {
         .mmio32 = memmap[VIRT_PCIE_MMIO],
         .pio    = memmap[VIRT_PCIE_PIO],
@@ -174,6 +195,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     }
 
     acpi_dsdt_add_gpex(scope, &cfg);
+    QLIST_FOREACH(bus, &vms->bus->child, sibling) {
+        if (pci_bus_is_cxl(bus)) {
+            cxl_present = true;
+        }
+    }
+    if (cxl_present) {
+        build_acpi0017(scope);
+    }
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
@@ -992,6 +1021,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         }
     }
 
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
+                       vms->oem_id, vms->oem_table_id, &vms->cxl_devices_state);
+    }
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
                           ms->nvdimms_state, ms->ram_slots, vms->oem_id,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 097238faa7..a8a2d79f19 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -55,6 +55,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/platform-bus.h"
@@ -78,6 +79,8 @@
 #include "hw/virtio/virtio-mem-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
@@ -178,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
+    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
@@ -1525,6 +1529,16 @@ static void create_pcie(VirtMachineState *vms)
     }
 }
 
+static void create_cxl_host_reg_region(VirtMachineState *vms)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;
+
+    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
+                       vms->memmap[VIRT_CXL_HOST].size);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
+}
+
 static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
@@ -1638,6 +1652,12 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
+                              &error_fatal);
+
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&vms->cxl_devices_state, &error_fatal);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1779,6 +1799,20 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
         memory_region_init(&ms->device_memory->mr, OBJECT(vms),
                            "device-memory", device_memory_size);
     }
+
+    if (vms->cxl_devices_state.fixed_windows) {
+        GList *it;
+
+        base = ROUND_UP(base, 256 * MiB);
+        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+
+            fw->base = base;
+            memory_region_init_io(&fw->mr, OBJECT(vms), &cfmws_ops, fw,
+                                  "cxl-fixed-memory-region", fw->size);
+            base += fw->size;
+        }
+    }
 }
 
 /*
@@ -2215,6 +2249,14 @@ static void machvirt_init(MachineState *machine)
         memory_region_add_subregion(sysmem, machine->device_memory->base,
                                     &machine->device_memory->mr);
     }
+    if (vms->cxl_devices_state.fixed_windows) {
+        GList *it;
+        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+
+            memory_region_add_subregion(sysmem, fw->base, &fw->mr);
+        }
+    }
 
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
@@ -2241,6 +2283,7 @@ static void machvirt_init(MachineState *machine)
     create_rtc(vms);
 
     create_pcie(vms);
+    create_cxl_host_reg_region(vms);
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
@@ -3070,6 +3113,7 @@ static void virt_instance_init(Object *obj)
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 15feabac63..403c9107e5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
+#include "hw/cxl/cxl.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
@@ -92,6 +93,7 @@ enum {
 /* indices of IO regions located after the RAM */
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
+    VIRT_CXL_HOST,
     VIRT_HIGH_PCIE_ECAM,
     VIRT_HIGH_PCIE_MMIO,
 };
@@ -176,6 +178,7 @@ struct VirtMachineState {
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
+    CXLState cxl_devices_state;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.32.0

