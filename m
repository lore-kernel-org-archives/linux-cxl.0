Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C3191F9E
	for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527472; cv=none; b=tPjvrBlJ2qt2TMMmaapciDN0cSFp0GoVlEa5zs0d10/I+NITVWRr/hKhRVC6ubYGTfucdCVRDhqbYi+mpHlD5qT17X0Q27Pu5nt+hxzPAmFM3lrXjh4qO72bhY3SF2x/ifIAePsYkHSsDSkKeCM8+fw1t7jBHQFZyCHwuD1FQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527472; c=relaxed/simple;
	bh=qiSqU3fbEX32WLLWpEiO9uJcri2Z4dCCY4Kx+I+LFO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUVepJhKGc/Ej/NDe/B0w7ozzfYp1T40c3L+HJfFFk+2J1XPd5Hm2ljedml9lEvX40n5guuzIjDuj03w6yhQrJspWVqSBxvN8RmTeJiyKgs2hacsqc0uiF3YzfBq/K1FVlDFvxZ2ODmD/ZZ1FV6QOfoWz0GjgcsIl+O7yYbE/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDXzqlhRURniEIiBw--.28974S2;
	Mon, 25 Nov 2024 17:37:37 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCH23dTRURnT9pZAA--.7191S4;
	Mon, 25 Nov 2024 17:37:33 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com,
	peter.maydell@linaro.org,
	quic_llindhol@quicinc.com,
	marcin.juszkiewicz@linaro.org,
	jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 1/1] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
Date: Mon, 25 Nov 2024 17:37:09 +0800
Message-Id: <20241125093709.57204-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125093709.57204-1-wangyuquan1236@phytium.com.cn>
References: <20241125093709.57204-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCH23dTRURnT9pZAA--.7191S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWdDg3QFhAAAsS
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfJr4rAF48Xw1kJr45Wry3Arb_yoW8AF4kKo
	WxXFZ5Zr48Gr4IyFy0kwsxtFW7XrWkKa13JFs0yF40ka1UAw4DXa4rKws3Aay3JF1rtas8
	XFW3Ary3WayDJF1kn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

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
 docs/system/arm/sbsa.rst  |   4 +
 hw/arm/sbsa-ref.c         | 139 ++++++++++++++++++++++++++++++-
 hw/cxl/cxl-host-stubs.c   |   2 +
 hw/cxl/cxl-host.c         | 169 +++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl.h      |  22 +++++
 include/hw/cxl/cxl_host.h |   5 ++
 6 files changed, 339 insertions(+), 2 deletions(-)

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
index e3195d5449..78aef823a6 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,12 +36,18 @@
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
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "hw/usb/xhci.h"
@@ -94,6 +100,13 @@ enum {
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
@@ -105,6 +118,7 @@ struct SBSAMachineState {
     int psci_conduit;
     DeviceState *gic;
     PFlashCFI01 *flash[2];
+    CXLState cxl_devices_state;
 };
 
 #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
@@ -132,6 +146,14 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
+    /* 64K CXL Host Bridge Registers space */
+    [SBSA_CXL_CHBCR] =          { 0x60120000, 0x00010000 },
+    /* 64K CXL PIO space */
+    [SBSA_CXL_PIO] =            { 0x60130000, 0x00010000 },
+    /* 128M CXL 32-bit MMIO space */
+    [SBSA_CXL_MMIO] =           { 0x60140000, 0x08000000 },
+    /* 256M CXL ECAM space */
+    [SBSA_CXL_ECAM] =           { 0x68140000, 0x10000000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -141,6 +163,10 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
     [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
     [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+    /* 4G CXL 64-bit MMIO space */
+    [SBSA_CXL_MMIO_HIGH] =      { 0x90000000000ULL, 0x100000000ULL },
+    /* 1TB CXL FIXED WINDOW space */
+    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
 };
 
 static const int sbsa_ref_irqmap[] = {
@@ -154,6 +180,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
+    [SBSA_CXL] = 17, /* ... to 20 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -216,7 +243,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 5);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -629,6 +656,114 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
+static void create_cxl_fixed_window(SBSAMachineState *sms,
+                               MemoryRegion *mem, SbsaCXLHost *host)
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
+    fw->sbsa_target = host;
+
+    memory_region_init_io(&fw->mr, OBJECT(sms), &cfmws_ops, fw,
+                            "cxl-fixed-memory-region", fw->size);
+
+    memory_region_add_subregion(mem, fw->base, &fw->mr);
+}
+
+static void create_cxl(SBSAMachineState *sms)
+{
+    hwaddr base_ecam = sbsa_ref_memmap[SBSA_CXL_ECAM].base;
+    hwaddr size_ecam = sbsa_ref_memmap[SBSA_CXL_ECAM].size;
+    hwaddr base_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].base;
+    hwaddr size_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].size;
+    hwaddr base_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base;
+    hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size;
+    hwaddr base_pio = sbsa_ref_memmap[SBSA_CXL_PIO].base;
+    int irq = sbsa_ref_irqmap[SBSA_CXL];
+    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *chbcr = &sms->cxl_devices_state.host_mr;
+    DeviceState *dev;
+    SbsaCXLHost *host;
+    PCIHostState *cxl;
+    PCIDevice *cxlrp;
+    PCIEPort *p;
+    PCIESlot *s;
+    int i;
+
+    dev = qdev_new(TYPE_SBSA_CXL_HOST);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sms->cxl_devices_state.is_enabled = true;
+
+    /* Map CXL ECAM space */
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "cxl-ecam",
+                             ecam_reg, 0, size_ecam);
+    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
+
+    /* Map CXL MMIO space */
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
+                             mmio_reg, base_mmio, size_mmio);
+    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
+
+    /* Map CXL MMIO_HIGH space */
+    mmio_alias_high = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
+                             mmio_reg, base_mmio_high, size_mmio_high);
+    memory_region_add_subregion(get_system_memory(), base_mmio_high,
+                                mmio_alias_high);
+
+    /* Map CXL IO port space */
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, base_pio);
+
+    for (i = 0; i < SBSA_CXL_NUM_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic, irq + i));
+        sbsa_cxl_set_irq_num(SBSA_CXL_HOST(dev), i, irq + i);
+    }
+
+    /* Map CXL CHBCR space */
+    memory_region_init(chbcr, OBJECT(sms), "cxl_host_reg",
+                       sbsa_ref_memmap[SBSA_CXL_CHBCR].size);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_CHBCR].base, chbcr);
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
+    host = SBSA_CXL_HOST(dev);
+    sbsa_cxl_hook_up_registers(&sms->cxl_devices_state, host, &error_fatal);
+
+    create_cxl_fixed_window(sms, sysmem, host);
+}
+
 static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
@@ -821,6 +956,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_cxl(sms);
+
     create_secure_ec(secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde..aea94933ba 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,5 +11,7 @@
 void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                        CXLFixedMemoryWindowOptions *object, Error **errp) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e9f2543c43..7e9d82819a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -16,13 +16,14 @@
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
                                            Error **errp)
 {
@@ -166,6 +167,17 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     /* Address is relative to memory region. Convert to HPA */
     addr += fw->base;
 
+    if (fw->sbsa_target) {
+        hb = PCI_HOST_BRIDGE(fw->sbsa_target);
+        SbsaCXLHost *host = fw->sbsa_target;
+
+        hb_cstate = &host->cxl_cstate;
+        cache_mem = hb_cstate->crb.cache_mem_registers;
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        rp = pcie_find_port_by_pn(hb->bus, target);
+        goto done;
+    }
+
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -196,6 +208,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
         }
     }
 
+done:
     d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
     if (!d) {
         return NULL;
@@ -372,3 +385,157 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
         }
     }
 }
+
+/****************************************************************************
+ * Sbsa CXL host
+ */
+
+static void sbsa_cxl_set_irq(void *opaque, int irq_num, int level)
+{
+    SbsaCXLHost *host = opaque;
+
+    qemu_set_irq(host->irq[irq_num], level);
+}
+
+int sbsa_cxl_set_irq_num(SbsaCXLHost *host, int index, int gsi)
+{
+    if (index >= SBSA_CXL_NUM_IRQS) {
+        return -EINVAL;
+    }
+
+    host->irq_num[index] = gsi;
+    return 0;
+}
+
+static PCIINTxRoute sbsa_cxl_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    PCIINTxRoute route;
+    SbsaCXLHost *host = opaque;
+    int gsi = host->irq_num[pin];
+
+    route.irq = gsi;
+    if (gsi < 0) {
+        route.mode = PCI_INTX_DISABLED;
+    } else {
+        route.mode = PCI_INTX_ENABLED;
+    }
+
+    return route;
+}
+
+static const char *sbsa_host_root_bus_path(PCIHostState *host_bridge,
+                                          PCIBus *rootbus)
+{
+    return "0001:00";
+}
+
+void sbsa_cxl_hook_up_registers(CXLState *cxl_state, SbsaCXLHost *host, Error **errp)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    hwaddr offset;
+
+    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
+    if (offset > memory_region_size(&cxl_state->host_mr)) {
+        error_setg(errp, "Insufficient space for sbsa cxl host register space");
+        return;
+    }
+
+    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
+    cxl_state->next_mr_idx++;
+}
+
+static void sbsa_cxl_host_reset(SbsaCXLHost *host)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                         8);
+}
+
+static void sbsa_cxl_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SbsaCXLHost *host = SBSA_CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    PCIBus *cxlbus;
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+    int i;
+
+    /* CHBCR MMIO init */
+    sbsa_cxl_host_reset(host);
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
+                                      TYPE_SBSA_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+
+    /* PCIe Host MMIO init */
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+    sysbus_init_mmio(sbd, &pex->mmio);
+
+    memory_region_init(&host->io_mmio, OBJECT(host), "cxl_host_mmio", UINT64_MAX);
+    memory_region_init(&host->io_ioport, OBJECT(host), "cxl_host_ioport", 64 * 1024);
+
+    memory_region_init_io(&host->io_mmio_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_mmio_window", UINT64_MAX);
+    memory_region_init_io(&host->io_ioport_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&host->io_mmio_window, 0, &host->io_mmio);
+    memory_region_add_subregion(&host->io_ioport_window, 0, &host->io_ioport);
+    sysbus_init_mmio(sbd, &host->io_mmio_window);
+    sysbus_init_mmio(sbd, &host->io_ioport_window);
+
+    sysbus_init_mmio(sbd, &host->io_mmio);
+    sysbus_init_mmio(sbd, &host->io_ioport);
+
+    for (i = 0; i < SBSA_CXL_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &host->irq[i]);
+        host->irq_num[i] = -1;
+    }
+
+    pci->bus = pci_register_root_bus(dev, "cxlhost.0", sbsa_cxl_set_irq,
+                                     pci_swizzle_map_irq_fn, host, &host->io_mmio,
+                                     &host->io_ioport, 0, 4, TYPE_CXL_BUS);
+    cxlbus = pci->bus;
+    cxlbus->flags |= PCI_BUS_CXL;
+
+    pci_bus_set_route_irq_fn(pci->bus, sbsa_cxl_route_intx_pin_to_irq);
+}
+
+static void sbsa_cxl_host_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = sbsa_host_root_bus_path;
+    dc->realize = sbsa_cxl_realize;
+    dc->desc = "Sbsa CXL Host Bridge";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "cxl";
+
+}
+
+/*
+ *  SBSA CXL HOST
+ */
+static const TypeInfo sbsa_cxl_host_info = {
+    .name          = TYPE_SBSA_CXL_HOST,
+    .parent        = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(SbsaCXLHost),
+    .class_init    = sbsa_cxl_host_class_init,
+};
+
+static void cxl_host_register(void)
+{
+    type_register_static(&sbsa_cxl_host_info);
+}
+
+type_init(cxl_host_register)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..5ae9957c69 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -17,6 +17,7 @@
 #include "cxl_pci.h"
 #include "cxl_component.h"
 #include "cxl_device.h"
+#include "hw/pci/pcie_host.h"
 
 #define CXL_CACHE_LINE_SIZE 64
 #define CXL_COMPONENT_REG_BAR_IDX 0
@@ -24,12 +25,33 @@
 
 #define CXL_WINDOW_MAX 10
 
+#define TYPE_SBSA_CXL_HOST "sbsa-cxl-host"
+OBJECT_DECLARE_SIMPLE_TYPE(SbsaCXLHost, SBSA_CXL_HOST)
+
+#define SBSA_CXL_NUM_IRQS 4
+
 typedef struct PXBCXLDev PXBCXLDev;
 
+struct SbsaCXLHost {
+    PCIExpressHost parent_obj;
+
+    CXLComponentState cxl_cstate;
+    bool passthrough;
+    int rp_count;
+
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+    qemu_irq irq[SBSA_CXL_NUM_IRQS];
+    int irq_num[SBSA_CXL_NUM_IRQS];
+};
+
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
     PXBCXLDev *target_hbs[16];
+    SbsaCXLHost *sbsa_target;
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..ae3ba436cc 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,11 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                        CXLFixedMemoryWindowOptions *object, Error **errp);
+
+int sbsa_cxl_set_irq_num(SbsaCXLHost *host, int index, int gsi);
+void sbsa_cxl_hook_up_registers(CXLState *cxl_state, SbsaCXLHost *host, Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
-- 
2.34.1

