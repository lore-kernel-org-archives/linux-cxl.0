Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC79295524
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539370; cv=none; b=g+BuMBJHN6ToV6Uf3JbVg0pQ9G2sDZ/5nh0SXdzfSEYcXJqx058HRjMlvWhQn8y+JZ0LGjEwl10dLBKVoregr4rBKFooAh/IRBu1Y7wepKB36spkS1sVnH4JGa5Xba1ZYQ3B7+UzzoBqazJ/M5Q9m0nezxyHFYjCyNg31Dn7XII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539370; c=relaxed/simple;
	bh=z7MYYmWWqiljW5nAJFtpdTnrEKdZy9040x4Hmn6NiA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1+RVgQUwl6y/hMteWM3oByr2cpSLa5BuMm5ngBEHg6upMoQFi2fTAbb3rYp5LoxzARHMwnZ97OFvC48JqNKqVqgMpN8198rc8WpE3oEZAmpDulINadRKcASH6txouI+Oyi3cxzw91/S3uE9ESZTYN254DfIgRUGlZKmroZrtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXtcm3Q5Qz6DKlm;
	Thu,  3 Jul 2025 18:42:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 430B91402F5;
	Thu,  3 Jul 2025 18:42:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 12:42:44 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>,
	<mst@redhat.com>, Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH qemu v17 3/5] hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances pxb-cxl
Date: Thu, 3 Jul 2025 11:41:08 +0100
Message-ID: <20250703104110.992379-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
References: <20250703104110.992379-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

Code based on i386/pc enablement.
The memory layout places space for 16 host bridge register regions after
the GIC_REDIST2 in the extended memmap. This is a hole in the current
map so adding them here has no impact on placement of other memory regions
(tested with enough CPUs for GIC_REDIST2 to be in use.)
The high memory map is GiB aligned so the hole is there whatever the
size of memory or device_memory below this point.

The CFMWs are placed above the extended memmap. Note the existing
variable highest_gpa is the highest GPA that has been allocated at
a particular point in setting up the memory map. Whilst this caused
some confusion in review there are existing comments explaining this
so nothing is added.

The cxl_devices_state.host_mr provides a small space in which to place
the individual host bridge register regions for whatever host bridges are
allocated via -device pxb-cxl on the command line. The existing dynamic
sysbus infrastructure is not reused because pxb-cxl is a PCI device not
a sysbus one but these registers are directly in the main memory map,
not the PCI address space.

Only create the CEDT table if cxl=on set for the machine. Default to off.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v17: Updated patch description to cover some feedback from Eric.
     Added a comment in the high memory map where the CXL
     Fixed Memory Windows will be placed. Given the size can only
     be established at runtime, explicit entries don't work. This
     is similar to device_memory.

Perhaps unresolved feedback.  Peter raised a concern about the direct
initialization of vms->cxl_devices_state.host_mr. I've added more
commentary about that to the patch description. Whilst it seems
unnecessary I could wrap the relevant 3 lines of code up in a utility
function rather than open coding them here and in i386/pc.
---
 docs/system/arm/virt.rst |  9 +++++++++
 include/hw/arm/virt.h    |  4 ++++
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 hw/arm/virt.c            | 30 ++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 6a719b9586..10cbffc8a7 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -31,6 +31,7 @@ Supported devices
 The virt board supports:
 
 - PCI/PCIe devices
+- CXL Fixed memory windows, root bridges and devices.
 - Flash memory
 - Either one or two PL011 UARTs for the NonSecure World
 - An RTC
@@ -189,6 +190,14 @@ ras
 acpi
   Set ``on``/``off``/``auto`` to enable/disable ACPI.
 
+cxl
+  Set  ``on``/``off`` to enable/disable CXL. More details in
+  :doc:`../devices/cxl`. The default is off.
+
+cxl-fmw
+  Array of CXL fixed memory windows describing fixed address routing to
+  target CXL host bridges. See :doc:`../devices/cxl`.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..4375819ea0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,6 +36,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
+#include "hw/cxl/cxl.h"
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
@@ -85,6 +86,7 @@ enum {
 /* indices of IO regions located after the RAM */
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
+    VIRT_CXL_HOST,
     VIRT_HIGH_PCIE_ECAM,
     VIRT_HIGH_PCIE_MMIO,
 };
@@ -140,6 +142,7 @@ struct VirtMachineState {
     bool secure;
     bool highmem;
     bool highmem_compact;
+    bool highmem_cxl;
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
@@ -174,6 +177,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    CXLState cxl_devices_state;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cd90c47976..c3b9b3f6ea 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -39,10 +39,12 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/cxl.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -119,10 +121,29 @@ static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
     aml_append(scope, dev);
 }
 
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev, *scope, *method;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x0B)));
+    aml_append(dev, method);
+    build_cxl_dsm_method(dev);
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
@@ -136,6 +157,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
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
@@ -1027,6 +1056,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
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
index 3bcdf92e2f..394e8b5301 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -57,6 +57,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/platform-bus.h"
@@ -86,6 +87,8 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat[] = {
@@ -220,9 +223,11 @@ static const MemMapEntry base_memmap[] = {
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
+    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
+    /* Any CXL Fixed memory windows come here */
 };
 
 static const int a15irqmap[] = {
@@ -1623,6 +1628,17 @@ static void create_pcie(VirtMachineState *vms)
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
+    vms->highmem_cxl = true;
+}
+
 static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
@@ -1739,6 +1755,12 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
+                              &error_fatal);
+
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&error_fatal);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1785,6 +1807,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
 {
     bool *enabled_array[] = {
         &vms->highmem_redists,
+        &vms->highmem_cxl,
         &vms->highmem_ecam,
         &vms->highmem_mmio,
     };
@@ -1892,6 +1915,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     if (device_memory_size > 0) {
         machine_memory_devices_init(ms, device_memory_base, device_memory_size);
     }
+    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
+                                                    256 * MiB),
+                                           BIT_ULL(pa_bits)) - 1;
 }
 
 static VirtGICType finalize_gic_version_do(const char *accel_name,
@@ -2343,6 +2369,8 @@ static void machvirt_init(MachineState *machine)
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
 
+    cxl_fmws_update_mmio();
+
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, sysmem);
@@ -2398,6 +2426,7 @@ static void machvirt_init(MachineState *machine)
     create_rtc(vms);
 
     create_pcie(vms);
+    create_cxl_host_reg_region(vms);
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
@@ -3364,6 +3393,7 @@ static void virt_instance_init(Object *obj)
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.48.1

