Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5961ACEC2
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883120; cv=none; b=YjaXwJkXKF97M0btunLJO4llOM1NZwpzCb2CGAai7xUKFtJNhKte+/OiYCH4XZZfEKpSB0CbH5Qg2p7Jvpp6ETpJGebcZFRL49j6epldhdRbtJidtt49ZgTbQH13G3p78PBcT/9Q4sUp8vBNsGJWsk+f4jlfD/dL6cTdsFhfh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883120; c=relaxed/simple;
	bh=tHtgqMJyVy7Hm+KLgBgruXIK8Nk2qjYixMijnqE7DUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qx4vKG1wiEb6wtI/IVdRF5nXXVwxVeoukiJbz2edcDMvxaFxcEbGAAXTerBiVtOOTZq/gLp5lIQMTNmqXWMAeHXOVtLgNuZrAyFiHXphhltAzoh4I6mcdD4CNFjR5E3yxcVfFobm0mE8Ifwd0U6Vzmi9W2dpeUKEhAghXwi3nxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHJ_Hj9FhnrLJoCA--.16087S2;
	Wed, 11 Dec 2024 10:11:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwBnv3vO9FhnOi5nAA--.4806S4;
	Wed, 11 Dec 2024 10:11:41 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com,
	peter.maydell@linaro.org,
	quic_llindhol@quicinc.com,
	marcin.juszkiewicz@linaro.org
Cc: Jonathan.Cameron@Huawei.com,
	chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v4 1/1] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
Date: Wed, 11 Dec 2024 10:11:17 +0800
Message-Id: <20241211021117.120630-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211021117.120630-1-wangyuquan1236@phytium.com.cn>
References: <20241211021117.120630-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnv3vO9FhnOi5nAA--.4806S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWdYm48BlwAAst
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw4fuF13Gr4rJrW5KrW8tFb_yoW3tw1rpF
	43C393Cr48KFs8Arna93WDWF15u34vyFWUC347CF93Cr17Kw1jvFWkKa1UKa45JrWkJa45
	u3WDXFyFvw1UZw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This creates a specific cxl host bridge (0001:00) with two cxl
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
 docs/system/arm/sbsa.rst |   4 ++
 hw/arm/sbsa-ref.c        | 135 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

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
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..40aaaef617 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,11 +36,14 @@
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
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
@@ -94,6 +97,13 @@ enum {
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
@@ -105,6 +115,7 @@ struct SBSAMachineState {
     int psci_conduit;
     DeviceState *gic;
     PFlashCFI01 *flash[2];
+    CXLState cxl_devices_state;
 };
 
 #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
@@ -132,6 +143,14 @@ static const MemMapEntry sbsa_ref_memmap[] = {
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
@@ -141,6 +160,10 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
     [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
     [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+    /* 4G CXL 64-bit MMIO space */
+    [SBSA_CXL_MMIO_HIGH] =      { 0x90000000000ULL, 0x100000000ULL },
+    /* 1TB CXL FIXED WINDOW space */
+    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
 };
 
 static const int sbsa_ref_irqmap[] = {
@@ -154,6 +177,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
+    [SBSA_CXL] = 17, /* ... to 20 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -216,7 +240,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 5);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -629,6 +653,113 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
+static void create_cxl_fixed_window(SBSAMachineState *sms,
+                               MemoryRegion *mem, CXLHostBridge *host)
+{
+    PCIBus *cxlbus = PCI_HOST_BRIDGE(host)->bus;
+    char *cxl_host = object_get_canonical_path(OBJECT(cxlbus));
+    hwaddr base = sbsa_ref_memmap[SBSA_CXL_FIXED_WINDOW].base;
+    GList *it;
+    strList host_target = { NULL, cxl_host };
+    CXLFixedMemoryWindowOptions sbsa_ref_cfmwoptions = {
+        .size = 1 * TiB,
+        .has_interleave_granularity = false,
+        .targets = &host_target,
+    };
+    CXLFixedWindow *fw;
+
+    cxl_fixed_memory_window_config(&sms->cxl_devices_state,
+                               &sbsa_ref_cfmwoptions, &error_fatal);
+
+    it = sms->cxl_devices_state.fixed_windows;
+    fw = it->data;
+    fw->base = base;
+    fw->target_chb[0] = host;
+
+    memory_region_init_io(&fw->mr, OBJECT(sms), &cfmws_ops, fw,
+                            "cxl-fixed-memory-region", fw->size);
+
+    memory_region_add_subregion(mem, fw->base, &fw->mr);
+}
+
+static void create_cxl(SBSAMachineState *sms)
+{
+    hwaddr base_pio = sbsa_ref_memmap[SBSA_CXL_PIO].base;
+    int irq = sbsa_ref_irqmap[SBSA_CXL];
+    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *chbcr = &sms->cxl_devices_state.host_mr;
+    DeviceState *dev;
+    CXLHostBridge *host;
+    PCIHostState *cxl;
+    PCIDevice *cxlrp;
+    PCIEPort *p;
+    PCIESlot *s;
+    int i;
+
+    dev = qdev_new(TYPE_CXL_HOST);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sms->cxl_devices_state.is_enabled = true;
+
+    /* Map CXL ECAM space */
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
+                             ecam_reg, 0, sbsa_ref_memmap[SBSA_CXL_ECAM].size);
+    memory_region_add_subregion(get_system_memory(),
+                              sbsa_ref_memmap[SBSA_CXL_ECAM].base, ecam_alias);
+
+    /* Map CXL MMIO space */
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
+                             mmio_reg, sbsa_ref_memmap[SBSA_CXL_MMIO].base,
+                                       sbsa_ref_memmap[SBSA_CXL_MMIO].size);
+    memory_region_add_subregion(get_system_memory(),
+                           sbsa_ref_memmap[SBSA_CXL_MMIO].base, mmio_alias);
+
+    /* Map CXL MMIO_HIGH space */
+    mmio_alias_high = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
+                           mmio_reg, sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base,
+                                     sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size);
+    memory_region_add_subregion(get_system_memory(),
+                    sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base, mmio_alias_high);
+
+    /* Map CXL IO port space */
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, base_pio);
+
+    for (i = 0; i < CXL_HOST_NUM_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic, irq + i));
+        cxl_host_set_irq_num(CXL_HOST(dev), i, irq + i);
+    }
+
+    /* Map CXL CHBCR space */
+    memory_region_init(chbcr, OBJECT(sms), "cxl_host_reg",
+                       sbsa_ref_memmap[SBSA_CXL_CHBCR].size);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_CHBCR].base,
+                                chbcr);
+
+    cxl = PCI_HOST_BRIDGE(dev);
+
+    /* Connect two cxl root ports */
+    for (i = 0; i < 2; i++) {
+        cxlrp = pci_new(-1, "cxl-rp");
+        p = PCIE_PORT(cxlrp);
+        s = PCIE_SLOT(cxlrp);
+        p->port = i;
+        s->slot = i;
+        pci_realize_and_unref(cxlrp, cxl->bus, &error_fatal);
+    }
+
+    host = CXL_HOST(dev);
+    cxl_host_hook_up_registers(&sms->cxl_devices_state, host, &error_fatal);
+
+    create_cxl_fixed_window(sms, sysmem, host);
+}
+
 static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
@@ -821,6 +952,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_cxl(sms);
+
     create_secure_ec(secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
-- 
2.34.1

