Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA81EF09B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478648; cv=none; b=sXfVrz6gMbwpvEBk64HKevPenmHb9fYKuJowxfCJVQAyHL++uA28BG0trjFO0SWVgD2+3O/UggUfKpbfBmO5nGjSrztK69tqtajgA3S29a+gcYEbF/fDXzU/v7JcwkTqEh0+MwPhb5nXrjLy7SX4GmTkVAWpV5GrqFemlMeXauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478648; c=relaxed/simple;
	bh=SPo2nDR/jvotzb40n+oaWNnLocGCLa9EMSpLvEcTAgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfFhqgC8JFniKQPb5eOuUw6hIuIIP/Gmxj9l9TTy9N69H45FGoJKdsklanpOLVqy28vafeCnIeOsgWgIk3ozwDhX5TV0tihn2JSl/agcNyUz6WKVvTP7c7EMjiBX+zPWW59ZSzod6NeL7LBAfKh7aEQKxP45JS+TCCIHhrsXw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3vt7eyFJnx3SGBw--.8160S2;
	Fri, 06 Dec 2024 17:50:22 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHWHTUyFJnPuhjAA--.7499S4;
	Fri, 06 Dec 2024 17:50:20 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] cxl/cxl-host: Support creation of a new CXL Host Bridge
Date: Fri,  6 Dec 2024 17:49:39 +0800
Message-Id: <20241206094939.921781-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206094939.921781-1-wangyuquan1236@phytium.com.cn>
References: <20241206094939.921781-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHWHTUyFJnPuhjAA--.7499S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQALAWdSBAwGLwAAsf
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3KFyDCF1DKrykCFyxWry5XFb_yoW8Gw1xto
	W3Xa45Xr48JF1fCFyvkwnayr9rGrWUKF4rXF4FkFWqk3W7CwsxX348tan3Ca9xKF1ftFZ8
	WrWfA343GFZ7AF18n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and pxb-cxl
features(CHBCR) at meanwhile.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Also the CXLFixedWindow struct adds a new member 'target_chb' to
record the target list of CXLHostBridge. And necessary is to adjust
the logic of 'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to
allow different types of cxl host bridge.

Move 'cxl_get_hb_cstate' & 'cxl_get_hb_passthrough' from pxb code
into cxl-host code.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/cxl/cxl-host-stubs.c             |   2 +
 hw/cxl/cxl-host.c                   | 220 ++++++++++++++++++++++++++--
 hw/pci-bridge/pci_expander_bridge.c |  20 +--
 include/hw/cxl/cxl.h                |  23 +++
 include/hw/cxl/cxl_component.h      |   4 +-
 include/hw/cxl/cxl_host.h           |   6 +
 6 files changed, 242 insertions(+), 33 deletions(-)

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
index e9f2543c43..81a5948874 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -16,15 +16,37 @@
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
-                                           CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb, int type)
+{
+    if (type == 0) {
+        CXLHost *pxbhost = PXB_CXL_HOST(hb);
+        return &pxbhost->cxl_cstate;
+    } else {
+        CXLHostBridge *cxlhost = CXL_HOST(hb);
+        return &cxlhost->cxl_cstate;
+    }
+}
+
+bool cxl_get_hb_passthrough(PCIHostState *hb, int type)
+{
+    if (type == 0) {
+        CXLHost *pxbhost = PXB_CXL_HOST(hb);
+        return pxbhost->passthrough;
+    } else {
+        return false;
+    }
+}
+
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                    CXLFixedMemoryWindowOptions *object,
+                                    Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
@@ -81,18 +103,24 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
             int i;
 
             for (i = 0; i < fw->num_targets; i++) {
-                Object *o;
+                Object *pxb_cxl, *cxl_host;
                 bool ambig;
 
-                o = object_resolve_path_type(fw->targets[i],
+                pxb_cxl = object_resolve_path_type(fw->targets[i],
                                              TYPE_PXB_CXL_DEV,
                                              &ambig);
-                if (!o) {
-                    error_setg(errp, "Could not resolve CXLFM target %s",
-                               fw->targets[i]);
+                if (!pxb_cxl) {
+                    cxl_host = object_resolve_path_type(fw->targets[i],
+                                             TYPE_CXL_HOST,
+                                             &ambig);
+                    if (!cxl_host) {
+                        error_setg(errp, "Could not resolve CXLFM target %s",
+                                   fw->targets[i]);
                     return;
+                    }
+                    fw->target_chb[i] = CXL_HOST(cxl_host);
                 }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
+                fw->target_hbs[i] = PXB_CXL_DEV(pxb_cxl);
             }
         }
     }
@@ -162,23 +190,36 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     uint8_t target;
     bool target_found;
     PCIDevice *rp, *d;
+    int type;
 
     /* Address is relative to memory region. Convert to HPA */
     addr += fw->base;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
-    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
-    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
-        return NULL;
+    if (fw->target_chb[rb_index]) {
+        type = CXL_HOST_BRIDGE_TYPE;
+        hb = PCI_HOST_BRIDGE(fw->target_chb[rb_index]);
+        CXLHostBridge *host = fw->target_chb[rb_index];
+
+        hb_cstate = &host->cxl_cstate;
+        cache_mem = hb_cstate->crb.cache_mem_registers;
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        rp = pcie_find_port_by_pn(hb->bus, target);
+    } else {
+        type = PXB_CXL_HOST_TYPE;
+        hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
+        if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
+            return NULL;
+        }
     }
 
-    if (cxl_get_hb_passthrough(hb)) {
+    if (cxl_get_hb_passthrough(hb, type)) {
         rp = pcie_find_port_first(hb->bus);
         if (!rp) {
             return NULL;
         }
     } else {
-        hb_cstate = cxl_get_hb_cstate(hb);
+        hb_cstate = cxl_get_hb_cstate(hb, type);
         if (!hb_cstate) {
             return NULL;
         }
@@ -372,3 +413,154 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
         }
     }
 }
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
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host,
+                                Error **errp)
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
+static void cxl_host_class_init(ObjectClass *class, void *data)
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
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 07d411cff5..2f1b26256b 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -56,20 +56,6 @@ static GList *pxb_dev_list;
 
 #define TYPE_PXB_HOST "pxb-host"
 
-CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return &host->cxl_cstate;
-}
-
-bool cxl_get_hb_passthrough(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return host->passthrough;
-}
-
 static int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
@@ -240,7 +226,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
  * This is a device to handle the MMIO for a CXL host bridge. It does nothing
  * else.
  */
-static const TypeInfo cxl_host_info = {
+static const TypeInfo pxb_cxl_host_info = {
     .name          = TYPE_PXB_CXL_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(CXLHost),
@@ -524,7 +510,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
      * vendor, device, class, etc. ids are intentionally left out.
      */
 
-    dc->desc = "CXL Host Bridge";
+    dc->desc = "PXB CXL Host Bridge";
     device_class_set_props(dc, pxb_cxl_dev_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
@@ -551,7 +537,7 @@ static void pxb_register_types(void)
     type_register_static(&pxb_pcie_bus_info);
     type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
     type_register_static(&pxb_cxl_dev_info);
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..548a1bd28c 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -17,6 +17,7 @@
 #include "cxl_pci.h"
 #include "cxl_component.h"
 #include "cxl_device.h"
+#include "hw/pci/pcie_host.h"
 
 #define CXL_CACHE_LINE_SIZE 64
 #define CXL_COMPONENT_REG_BAR_IDX 0
@@ -24,12 +25,34 @@
 
 #define CXL_WINDOW_MAX 10
 
+#define PXB_CXL_HOST_TYPE 0
+#define CXL_HOST_BRIDGE_TYPE 1
+
+#define TYPE_CXL_HOST "cxl-host"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLHostBridge, CXL_HOST)
+
+#define CXL_HOST_NUM_IRQS 4
+
 typedef struct PXBCXLDev PXBCXLDev;
 
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
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
     PXBCXLDev *target_hbs[16];
+    CXLHostBridge *target_chb[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 945ee6ffd0..953521d601 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -270,8 +270,8 @@ uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
 hwaddr cxl_decode_ig(int ig);
 
-CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
-bool cxl_get_hb_passthrough(PCIHostState *hb);
+CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb, int type);
+bool cxl_get_hb_passthrough(PCIHostState *hb, int type);
 
 bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
 void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..d6d915141a 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,12 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                        CXLFixedMemoryWindowOptions *object, Error **errp);
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host,
+                                Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
-- 
2.34.1

