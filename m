Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C571F4C85
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601240; cv=none; b=tZfxUpR3tKziR5SOnSNPiH5hb4nBHPxcAxIoeurCaWKHbUjsIIXfY7CeWdV6DapHgZwmuJ9czGYBJSVkToerYwmDzCh9OvAvQhGvK5CVlZTm+uhV/A0Kw5wQ+KwvuFbf4/G+pL8XsPh98lKzn1nFsXEqnMazsBw4dTczfiXmPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601240; c=relaxed/simple;
	bh=vEdtaEH4tcEPZ135UZ52Xe/T+WuhkJvhmLL3rN56FEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pd1LOQy3hwKYKngq61rF/aMYAXRYRkxsWyZdvCd+bJxtLg+xGRfVQ0MAUda0PXzLuval6d41E1a7crojkKR7mP0V1/ePGbuy0ASjgx3ij1u5RCtvAazklj5/qCM1SX/AVPrqrWuVyqhd7AEaSaZ5pAigWeMoZquw6rGzfs2MQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHzRSHiTlorXjZAg--.22164S2;
	Fri, 30 May 2025 18:33:43 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwD3iyWAiTlo1VtFAA--.9604S5;
	Fri, 30 May 2025 18:33:42 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v2 2/2] pci-host/cxl: Support creation of a new CXL Host Bridge
Date: Fri, 30 May 2025 18:33:20 +0800
Message-Id: <20250530103320.534173-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
References: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwD3iyWAiTlo1VtFAA--.9604S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWg4uXAFnAAAsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3KFyDKFyfGw4DJF47Kr4kZwb_yoW8JF47to
	Waqa4UZr48Gr4fAFyvkwnak3y7CrWxKr4rXF4FkFWqk3W7Gw4DJw18Kws3Aay3GF1fJrn8
	WrWfCryak397Jr18n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and CHBCR
at meanwhile.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

CXLFixedWindow struct adds a new member 'target_chb' to record the
target list of CXLHostBridge and adjusts the logic of
'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to allow different
types of cxl host bridge.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/cxl/cxl-host-stubs.c               |   2 +
 hw/cxl/cxl-host.c                     |  66 +++++++++---
 hw/pci-host/cxl.c                     | 145 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/cxl/cxl_host.h             |   2 +
 include/hw/pci-host/cxl_host_bridge.h |  25 +++++
 7 files changed, 230 insertions(+), 18 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

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
index e010163174..183bc19a4b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -16,15 +16,17 @@
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/irq.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/pci-host/cxl_host_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
-                                           CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                    CXLFixedMemoryWindowOptions *object,
+                                    Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
@@ -83,14 +85,16 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
                 bool ambig;
 
                 o = object_resolve_path_type(fw->targets[i],
-                                             TYPE_PXB_CXL_DEV,
-                                             &ambig);
-                if (!o) {
+                    TYPE_DEVICE, &ambig);
+
+                if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV) ||
+                    object_dynamic_cast(o, TYPE_CXL_HOST)) {
+                    fw->target_hbs[i] = o;
+                } else {
                     error_setg(errp, "Could not resolve CXLFM target %s",
-                               fw->targets[i]);
+                        fw->targets[i]);
                     return;
                 }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
             }
         }
     }
@@ -153,6 +157,7 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
+    CXLHostBridge *cxlhost;
     PCIHostState *hb;
     CXLUpstreamPort *usp;
     int rb_index;
@@ -160,23 +165,50 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     uint8_t target;
     bool target_found;
     PCIDevice *rp, *d;
+    Object *o;
 
     /* Address is relative to memory region. Convert to HPA */
     addr += fw->base;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
-    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
-    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
-        return NULL;
-    }
-
-    if (cxl_get_hb_passthrough(hb)) {
-        rp = pcie_find_port_first(hb->bus);
-        if (!rp) {
+    o = fw->target_hbs[rb_index];
+    if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV)) {
+        hb = PCI_HOST_BRIDGE(PXB_CXL_DEV(o)->cxl_host_bridge);
+        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
             return NULL;
         }
+
+        if (cxl_get_hb_passthrough(hb)) {
+            rp = pcie_find_port_first(hb->bus);
+            if (!rp) {
+                return NULL;
+            }
+        } else {
+            hb_cstate = cxl_get_hb_cstate(hb);
+            if (!hb_cstate) {
+                return NULL;
+            }
+
+            cache_mem = hb_cstate->crb.cache_mem_registers;
+
+            target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+            if (!target_found) {
+                return NULL;
+            }
+
+            rp = pcie_find_port_by_pn(hb->bus, target);
+            if (!rp) {
+                return NULL;
+            }
+        }
     } else {
-        hb_cstate = cxl_get_hb_cstate(hb);
+        hb = PCI_HOST_BRIDGE(o);
+        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
+            return NULL;
+        }
+
+        cxlhost = CXL_HOST(hb);
+        hb_cstate = &cxlhost->cxl_cstate;
         if (!hb_cstate) {
             return NULL;
         }
diff --git a/hw/pci-host/cxl.c b/hw/pci-host/cxl.c
new file mode 100644
index 0000000000..8323456864
--- /dev/null
+++ b/hw/pci-host/cxl.c
@@ -0,0 +1,145 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci-host/cxl_host_bridge.h"
+
+static void cxl_host_set_irq(void *opaque, int irq_num, int level)
+{
+    CXLHostBridge *host = opaque;
+
+    qemu_set_irq(host->irq[irq_num], level);
+}
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi)
+{
+    if (index >= CXL_HOST_NUM_IRQS) {
+        return -EINVAL;
+    }
+
+    host->irq_num[index] = gsi;
+    return 0;
+}
+
+static PCIINTxRoute cxl_host_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    PCIINTxRoute route;
+    CXLHostBridge *host = opaque;
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
+static const char *cxl_host_root_bus_path(PCIHostState *host_bridge,
+                                          PCIBus *rootbus)
+{
+    return "0001:00";
+}
+
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+
+    memory_region_add_subregion(&cxl_state->host_mr, 0, mr);
+}
+
+static void cxl_host_reset(CXLHostBridge *host)
+{
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
+
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                     8);
+}
+
+static void cxl_host_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CXLHostBridge *host = CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &host->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    PCIBus *cxlbus;
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+    int i;
+
+    /* CHBCR MMIO init */
+    cxl_host_reset(host);
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate, TYPE_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+
+    /* MMFG window init */
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+    sysbus_init_mmio(sbd, &pex->mmio);
+
+    /* mmio window init */
+    memory_region_init(&host->io_mmio, OBJECT(host), "cxl_host_mmio",
+                        UINT64_MAX);
+
+    memory_region_init_io(&host->io_mmio_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_mmio_window", UINT64_MAX);
+
+    memory_region_add_subregion(&host->io_mmio_window, 0, &host->io_mmio);
+    sysbus_init_mmio(sbd, &host->io_mmio_window);
+
+    /* ioport window init, 64K is the legacy size in x86 */
+    memory_region_init(&host->io_ioport, OBJECT(host), "cxl_host_ioport",
+                        64 * 1024);
+
+    memory_region_init_io(&host->io_ioport_window, OBJECT(host),
+                              &unassigned_io_ops, OBJECT(host),
+                              "cxl_host_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&host->io_ioport_window, 0, &host->io_ioport);
+    sysbus_init_mmio(sbd, &host->io_ioport_window);
+
+    /* PCIe host bridge use 4 legacy IRQ lines */
+    for (i = 0; i < CXL_HOST_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &host->irq[i]);
+        host->irq_num[i] = -1;
+    }
+
+    pci->bus = pci_register_root_bus(dev, "cxlhost.0", cxl_host_set_irq,
+                                 pci_swizzle_map_irq_fn, host, &host->io_mmio,
+                                 &host->io_ioport, 0, 4, TYPE_CXL_BUS);
+    cxlbus = pci->bus;
+    cxlbus->flags |= PCI_BUS_CXL;
+
+    pci_bus_set_route_irq_fn(pci->bus, cxl_host_route_intx_pin_to_irq);
+}
+
+static void cxl_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = cxl_host_root_bus_path;
+    dc->realize = cxl_host_realize;
+    dc->desc = "CXL Host Bridge";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "cxl";
+}
+
+static const TypeInfo cxl_host_info = {
+    .name          = TYPE_CXL_HOST,
+    .parent        = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(CXLHostBridge),
+    .class_init    = cxl_host_class_init,
+};
+
+static void cxl_host_register(void)
+{
+    type_register_static(&cxl_host_info);
+}
+
+type_init(cxl_host_register)
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 937a0f72ac..a00995068b 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -4,6 +4,7 @@ pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
 pci_ss.add(when: 'CONFIG_GT64120', if_true: files('gt64120.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('cxl.c'))
 pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'], if_true: files('gpex-acpi.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..346a7b58ad 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -26,10 +26,12 @@
 
 typedef struct PXBCXLDev PXBCXLDev;
 
+typedef struct CXLHostBridge CXLHostBridge;
+
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
-    PXBCXLDev *target_hbs[16];
+    Object *target_hbs[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
@@ -56,6 +58,9 @@ struct CXLHost {
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
+#define TYPE_CXL_HOST "cxl-host"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLHostBridge, CXL_HOST)
+
 #define TYPE_CXL_USP "cxl-upstream"
 
 typedef struct CXLUpstreamPort CXLUpstreamPort;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..f3184733aa 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,8 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                        CXLFixedMemoryWindowOptions *object, Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/include/hw/pci-host/cxl_host_bridge.h b/include/hw/pci-host/cxl_host_bridge.h
new file mode 100644
index 0000000000..f6830dab83
--- /dev/null
+++ b/include/hw/pci-host/cxl_host_bridge.h
@@ -0,0 +1,25 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/cxl/cxl.h"
+#include "hw/irq.h"
+#include "hw/pci/pcie_host.h"
+
+#define CXL_HOST_NUM_IRQS 4
+
+typedef struct CXLHostBridge {
+    PCIExpressHost parent_obj;
+
+    CXLComponentState cxl_cstate;
+
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+    qemu_irq irq[CXL_HOST_NUM_IRQS];
+    int irq_num[CXL_HOST_NUM_IRQS];
+} CXLHostBridge;
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host);
-- 
2.34.1

