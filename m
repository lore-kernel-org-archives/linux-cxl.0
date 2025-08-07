Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26A13B5AE
	for <linux-cxl@vger.kernel.org>; Thu,  7 Aug 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565071; cv=none; b=KPFeYSz4TtGyD0fU7c+ad3iOZrnZGOo/U+lrr9+Mu0pf2uMELiSOhz64/cCZf2CrsaUa5/Ner8qENKW0zbe+1TXGIIGBRMw0Av9D/HRtGAPwsZ3aYHtlZNGhOCCbEhFfHK0UceeED3hEOi5J4aKYYS0d1JxzTVUlvNQU42hGz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565071; c=relaxed/simple;
	bh=W34e7cE2YmnV1zvqdRCX6Ya19lQzDBX7AoBd5jPdsro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ieon2ZB424qUZwNZ+AQcSR/VyABqGl/giz7o5qg1n0lHdP0wyYHlh2eFGt9CDXSeyACeDYhbsEUNUy272x+7cHthNtG5pGb7zePD/XwXDI/wXAJpOMgRUOWpkQbIsziRh2VKgmqq3PjAgQgE6Wt4JILKlSLfoFd++RrOM9huEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHcy_FiZRoLDeBBA--.36853S2;
	Thu, 07 Aug 2025 19:11:01 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwBH0gm_iZRoF_8KAA--.16082S3;
	Thu, 07 Aug 2025 19:10:55 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@huawei.com,
	rad@semihalf.com,
	peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC QEMU PATCH v7] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
Date: Thu,  7 Aug 2025 19:10:37 +0800
Message-Id: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBH0gm_iZRoF_8KAA--.16082S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWiTrgAFjgAGsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ury7Wr48Zw45trykGw13CFg_yoW8JF4fCo
	WxtFs5uF48Kr4SqF1jkFZrJrW7WFZ8KFn3JF45CF4Yka1jyw4DJa4fKws7JwsxJr4rtF13
	XFW7tr98G34DAFykn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This creates a specific CXL host bridge (0001:00) with four cxl
root ports on sbsa-ref. And the memory layout provides separate
space windows for the cxl host bridge in the sbsa-ref memmap:

- 64K  CXL Host Bridge Component Registers (CHBCR)
- 64K  CXL_PIO
- 128M CXL_MMIO
- 256M CXL_ECAM
- 4G   CXL_MMIO_HIGH

To provide CFMWs on sbsa-ref, this extends 1TB space from the
hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:

- 1T   CXL_FIXED_WINDOW

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---

v6 -> v7:
- Remove redundancy local variables (Jonathan)
- Remove redundant comments (Jonathan)
- Based on TYPE_CXL_FMW, directly assign the attributes of CFMW in create_cxl_fixed_window()

v5 -> v6:
- Change the CXL root ports to 4

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's patches[2].
SBSA-REF can be more like a real machine, thus my initial purpose is to support the
simplest CXL VH topology on sbsa-ref to verify the basic CXL function usage,
therefore, some real machine could refer the CXL running result on sbsa-ref.  

This series leverages Jonathan's patches to design [SBSA_CXL_CHBCR] and
[SBSA_CXL_FIXED_WINDOW] spaces for sbsa-ref layout. 

Regard to the burden of edk2 firmware, I try to build a static CEDT table and add
acpi0016, acpi0017 and other CXL relevant contents into acpi tables[3][4]. Hence it
doesn't need to communicate CXL contents via DT to edk2. 

The New CXL HOST
================
This patch will use the new CXL host bridge to establish the CXL topology[5].

CXL FIXED WINDOW design
=======================
0xA0000000000 is chosen as the base address of this space because of 3 reasons:
1) It is more suitable to choose a static address instead of that
implementation in virt, since a dynamic address space layout of
sbsa-ref is not appropriate for its original purpose as a reference
platform.

2) The Hotplug Memory address range should in the range of maximum
addressable range of sbsa-ref platform(0x10000000000-0x80ffffffffff).
It is satisfied the requirements of memory hotplug in linux kernel.

3) The start pfn of CFMW should exceed the reserved_pfn_range for
onlined numa node.

Usage of CXL on sbsa-ref
========================
With the 'create_cxl()' and 'create_cxl_fixed_window()', users don't need to input
'-device pxb-cxl' , '-device cxl-rp' and '-M cxl-fmw' parameters.

Thus, to run sbsa-ref with a CXL device could use:
qemu-system-aarch64 \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \

Incompatibility problem
=======================
Although the new CXL host bridge has been separated from the original pcie host, the
incompatibility problem of "-device qemu-xhci" is not resolved. Because the new device
to plug by qemu command would be enumerated at the largest domain(0001), for example,
if we add "-device qemu-xhci" to boot sbsa-ref with CXL, the lspci would show:

    root@ubuntu-jammy-arm64:~# lspci
     0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
     0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
     0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
     0001:00:00.0 PCI bridge: Intel Corporation Device 7075
     0001:00:01.0 PCI bridge: Intel Corporation Device 7075
     0001:00:02.0 PCI bridge: Intel Corporation Device 7075
     0001:00:03.0 PCI bridge: Intel Corporation Device 7075
     0001:00:04.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
     0001:01:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01)
     0001:02:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01)
     0001:03:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01)
     0001:04:00.0 Memory controller [0502]: Intel Corporation Device 0d93 (rev 01)

Hence we should add "bus=pcie.0" when we want to plug some devices on the original
pcie bus, for example:
-device qemu-xhci,bus=pcie.0 \
or
-device nvme,serial=deadbeef,bus=pcie.0,drive=hdd \
-drive file=../disk/hdd.qcow2,format=qcow2,id=hdd,if=none \

Dynamic CXL topology problem
============================
Actually the ideal expectation is sbsa-ref could also have a dynamic CXL topology by user
parameters. According to my knowledge, it should pass a dtb to firmware to match the required
address space. I'm currently trying to solve this problem. I am looking for suggestions on if
there are better ways to do it.

This series patches are here to hopefully some comments to guide me!

Link:
[1]: https://lists.nongnu.org/archive/html/qemu-arm/2024-12/msg00350.html
[2]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[3]: https://edk2.groups.io/g/devel/message/120851
[4]: https://edk2.groups.io/g/devel/topic/rfc_patch_edk2_platforms_v4/110023229
[5]: https://lore.kernel.org/linux-cxl/20250807105910.240070-1-wangyuquan1236@phytium.com.cn/T/#t

 docs/system/arm/sbsa.rst |   4 ++
 hw/arm/Kconfig           |   1 +
 hw/arm/sbsa-ref.c        | 114 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index 2bf3fc8d59..21b88e88e7 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -28,6 +28,7 @@ The ``sbsa-ref`` board supports:
   - E1000E ethernet card on PCIe bus
   - Bochs display adapter on PCIe bus
   - A generic SBSA watchdog device
+  - CXL host bridge and CXL fixed memory window
 
 
 Board to firmware interface
@@ -92,3 +93,6 @@ Platform version changes:
 
 0.4
   CPU topology information is present in devicetree.
+
+0.5
+  CXL host bridge and CXL fixed memory window are supported.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2aa4b5d778..8aa457aeb6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -200,6 +200,7 @@ config SBSA_REF
     select GPIO_KEY
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select CXL_HOST_BRIDGE
     select PFLASH_CFI01
     select PL011 # UART
     select PL031 # RTC
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 15c1ff4b14..e6bbc0f934 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -37,11 +37,15 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/loader.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/pci-host/cxl_host_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
@@ -94,6 +98,13 @@ enum {
     SBSA_SECURE_MEM,
     SBSA_AHCI,
     SBSA_XHCI,
+    SBSA_CXL,
+    SBSA_CXL_CHBCR,
+    SBSA_CXL_MMIO,
+    SBSA_CXL_MMIO_HIGH,
+    SBSA_CXL_PIO,
+    SBSA_CXL_ECAM,
+    SBSA_CXL_FIXED_WINDOW,
 };
 
 struct SBSAMachineState {
@@ -105,6 +116,7 @@ struct SBSAMachineState {
     int psci_conduit;
     DeviceState *gic;
     PFlashCFI01 *flash[2];
+    CXLState cxl_devices_state;
 };
 
 #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
@@ -132,6 +144,14 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
+    /* 64K CXL Host Bridge Registers space */
+    [SBSA_CXL_CHBCR] =          { 0x60200000, 0x00010000 },
+    /* 64K CXL PIO space */
+    [SBSA_CXL_PIO] =            { 0x60300000, 0x00010000 },
+    /* 128M CXL 32-bit MMIO space */
+    [SBSA_CXL_MMIO] =           { 0x60400000, 0x08000000 },
+    /* 256M CXL ECAM space */
+    [SBSA_CXL_ECAM] =           { 0x68500000, 0x10000000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -141,6 +161,10 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
     [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
     [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+    /* 4G CXL 64-bit MMIO space */
+    [SBSA_CXL_MMIO_HIGH] =      { 0x90000000000ULL, 0x100000000ULL },
+    /* 1TB CXL FIXED WINDOW space */
+    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
 };
 
 static const int sbsa_ref_irqmap[] = {
@@ -154,6 +178,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
+    [SBSA_CXL] = 17, /* ... to 20 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -216,7 +241,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 5);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -631,6 +656,91 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
+static void create_cxl_fixed_window(SBSAMachineState *sms,
+                                    MemoryRegion *mem, CXLHostBridge *host)
+{
+    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
+    CXLFixedWindow *fw = CXL_FMW(dev);
+
+    fw->num_targets = 1;
+    fw->enc_int_ways = 0;
+    fw->enc_int_gran = 0;
+    fw->size = sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].size;
+    fw->base = sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].base;
+    fw->target_hbs[0] = OBJECT(host);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    memory_region_init_io(&fw->mr, OBJECT(sms), &cfmws_ops, fw,
+                          "cxl-fixed-memory-region", fw->size);
+
+    memory_region_add_subregion(mem, fw->base, &fw->mr);
+}
+
+static void create_cxl(SBSAMachineState *sms)
+{
+    MemoryRegion *ecam_alias, *mmio_alias, *mmio_alias_high;
+    DeviceState *dev;
+    PCIDevice *cxlrp;
+    int irq = sbsa_ref_irqmap[SBSA_CXL];
+    int i;
+
+    dev = qdev_new(TYPE_CXL_HOST);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sms->cxl_devices_state.is_enabled = true;
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
+                             sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1),
+                             0, sbsa_ref_memmap[SBSA_CXL_ECAM].size);
+    memory_region_add_subregion(get_system_memory(),
+                                sbsa_ref_memmap[SBSA_CXL_ECAM].base,
+                                ecam_alias);
+
+    mmio_alias = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
+                             sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2),
+                             sbsa_ref_memmap[SBSA_CXL_MMIO].base,
+                             sbsa_ref_memmap[SBSA_CXL_MMIO].size);
+    memory_region_add_subregion(get_system_memory(),
+                                sbsa_ref_memmap[SBSA_CXL_MMIO].base, mmio_alias);
+
+    mmio_alias_high = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
+                             sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2),
+                             sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base,
+                             sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size);
+    memory_region_add_subregion(get_system_memory(),
+                                sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base,
+                                mmio_alias_high);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3,
+                    sbsa_ref_memmap[SBSA_CXL_PIO].base);
+
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic, irq + i));
+        cxl_host_set_irq_num(CXL_HOST(dev), i, irq + i);
+    }
+
+    memory_region_init(&sms->cxl_devices_state.host_mr, OBJECT(sms),
+                       "cxl_host_reg", sbsa_ref_memmap[SBSA_CXL_CHBCR].size);
+    memory_region_add_subregion(get_system_memory(),
+                                sbsa_ref_memmap[SBSA_CXL_CHBCR].base,
+                                &sms->cxl_devices_state.host_mr);
+
+    for (i = 0; i < 4; i++) {
+        cxlrp = pci_new(-1, "cxl-rp");
+        PCIE_PORT(cxlrp)->port = i;
+        PCIE_SLOT(cxlrp)->slot = i;
+        pci_realize_and_unref(cxlrp, PCI_HOST_BRIDGE(dev)->bus, &error_fatal);
+    }
+
+    cxl_host_hook_up_registers(&sms->cxl_devices_state, CXL_HOST(dev));
+
+    create_cxl_fixed_window(sms, get_system_memory(), CXL_HOST(dev));
+}
+
 static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
@@ -825,6 +935,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_cxl(sms);
+
     create_secure_ec(secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
-- 
2.34.1

