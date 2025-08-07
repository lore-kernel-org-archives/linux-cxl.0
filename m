Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE722A1CF
	for <linux-cxl@vger.kernel.org>; Thu,  7 Aug 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564405; cv=none; b=Y95TcN+TMZuISONI8lGik6Ee6hiVBPSDHpO1gIZWBqKV+eWXrw2eZtZQxbLz/yiDvI0Vwuuppa73kCYjhKFevEkYa2srGMRSFivlAmChsfHh5BK3eQDU6vdhRZdwiTDEcyps01L+F+555pDgMflOowIhA+2dfHuuVMCWn3CnDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564405; c=relaxed/simple;
	bh=lAQcLwWQOhWyNIfvwgVWW+WzIwge/7TkOHpy/imd1HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRRP6CNSTnnuWJ/Z72xUQMZ0WEiuW/6A99JLeIezaMPHCzKxpL30gWDB62GvJF2EU6nvkg23781ozbs0R//Q959bas21XG0Ut0DqUdbdXukBpOMVpCubrtT5oQzo+gg1Vvhoh8bdxm+9+Sg0i/aUDbEPuzwC66KQ5hQwaL/wLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3jWEkh5Ro10CABA--.30459S2;
	Thu, 07 Aug 2025 18:59:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDHTwcSh5RoT_kKAA--.12934S5;
	Thu, 07 Aug 2025 18:59:46 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	rad@semihalf.com,
	peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com,
	graf@amazon.com,
	claudio.fontana@huawei.com,
	philmd@linaro.org,
	richard.henderson@linaro.org
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC QEMU PATCH v4 2/2] pci-host/cxl: Support creation of a new CXL Host Bridge
Date: Thu,  7 Aug 2025 18:59:10 +0800
Message-Id: <20250807105910.240070-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHTwcSh5RoT_kKAA--.12934S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWiTrgAFigAAsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3tFWUAF4UKF43Xr13Gw4UJwb_yoWkCw13pF
	909r13Gr48GFW7ZrZ7ta9rGF1xWa1kGFW5C397uwn2yF1xK34qqr4vkay2vFyUCFWUAry5
	WFW0qFykGa1UJr7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR).

The root bus path of CXL_HOST is "0001:00", that would not affect the
original PCIe host topology on some platforms. In the previous, the
pxb-cxl-host with any CXL root ports and CXL endpoint devices would
share the resources (like BDF, MMIO space) of the original pcie
domain, but it would cause some platforms like sbsa-ref are unable to
support the original number of PCIe devices. The new type provides a
solution to resolve the problem.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/cxl/cxl-host.c                     |  56 +++++++---
 hw/pci-host/Kconfig                   |   4 +
 hw/pci-host/cxl.c                     | 146 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/pci-host/cxl_host_bridge.h |  24 +++++
 6 files changed, 225 insertions(+), 13 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 5c2ce25a19..cedc11459d 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -16,11 +16,13 @@
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
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
@@ -84,14 +86,16 @@ static int cxl_fmws_link(Object *obj, void *opaque)
         Object *o;
         bool ambig;
 
-        o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
+        o = object_resolve_path_type(fw->targets[i], TYPE_DEVICE,
                                      &ambig);
-        if (!o) {
+        if (object_dynamic_cast(o, TYPE_PXB_CXL_DEV) ||
+            object_dynamic_cast(o, TYPE_CXL_HOST)) {
+            fw->target_hbs[i] = o;
+        } else {
             error_setg(&error_fatal, "Could not resolve CXLFM target %s",
                        fw->targets[i]);
             return 1;
         }
-        fw->target_hbs[i] = PXB_CXL_DEV(o);
     }
     return 0;
 }
@@ -159,6 +163,7 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 {
     CXLComponentState *hb_cstate, *usp_cstate;
+    CXLHostBridge *cxlhost;
     PCIHostState *hb;
     CXLUpstreamPort *usp;
     int rb_index;
@@ -166,23 +171,50 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
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
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9824fa188d..33ab945d38 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -75,6 +75,10 @@ config PCI_POWERNV
     select MSI_NONBROKEN
     select PCIE_PORT
 
+config CXL_HOST_BRIDGE
+    bool
+    select PCI_EXPRESS
+
 config REMOTE_PCIHOST
     bool
 
diff --git a/hw/pci-host/cxl.c b/hw/pci-host/cxl.c
new file mode 100644
index 0000000000..cffe392fbf
--- /dev/null
+++ b/hw/pci-host/cxl.c
@@ -0,0 +1,146 @@
+/*
+ * QEMU CXL Host Bridge Emulation
+ *
+ * Copyright (C) 2025, Phytium Technology Co, Ltd. All rights reserved.
+ *
+ * Based on gpex.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
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
+    if (index >= PCI_NUM_PINS) {
+        return -EINVAL;
+    }
+
+    host->irq_num[index] = gsi;
+    return 0;
+}
+
+static PCIINTxRoute cxl_host_route_intx_pin_to_irq(void *opaque, int pin)
+{
+    CXLHostBridge *host = opaque;
+    int gsi = host->irq_num[pin];
+    PCIINTxRoute route = {
+       .irq = gsi,
+       .mode = gsi < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED,
+    };
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
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+    int i;
+
+    cxl_host_reset(host);
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate, TYPE_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+    sysbus_init_mmio(sbd, &pex->mmio);
+
+    memory_region_init(&host->mmio, OBJECT(host), "cxl_host_mmio",
+                       UINT64_MAX);
+
+    memory_region_init_io(&host->mmio_window, OBJECT(host),
+                          &unassigned_io_ops, OBJECT(host),
+                          "cxl_host_mmio_window", UINT64_MAX);
+
+    memory_region_add_subregion(&host->mmio_window, 0, &host->mmio);
+    sysbus_init_mmio(sbd, &host->mmio_window);
+
+    /* ioport window init, 64K is the legacy size in x86 */
+    memory_region_init(&host->ioport, OBJECT(host), "cxl_host_ioport",
+                       64 * 1024);
+
+    memory_region_init_io(&host->ioport_window, OBJECT(host),
+                          &unassigned_io_ops, OBJECT(host),
+                          "cxl_host_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&host->ioport_window, 0, &host->ioport);
+    sysbus_init_mmio(sbd, &host->ioport_window);
+
+    /* PCIe host bridge use 4 legacy IRQ lines */
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_init_irq(sbd, &host->irq[i]);
+        host->irq_num[i] = -1;
+    }
+
+    pci->bus = pci_register_root_bus(dev, "cxlhost.0", cxl_host_set_irq,
+                                     pci_swizzle_map_irq_fn, host, &host->mmio,
+                                     &host->ioport, 0, 4, TYPE_CXL_BUS);
+    pci->bus->flags |= PCI_BUS_CXL;
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
index 937a0f72ac..030672373d 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -4,6 +4,7 @@ pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
 pci_ss.add(when: 'CONFIG_GT64120', if_true: files('gt64120.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_CXL_HOST_BRIDGE', if_true: files('cxl.c'))
 pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'], if_true: files('gpex-acpi.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
 pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a98..eaf4b6cc8a 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,12 +27,14 @@
 
 typedef struct PXBCXLDev PXBCXLDev;
 
+typedef struct CXLHostBridge CXLHostBridge;
+
 typedef struct CXLFixedWindow {
     SysBusDevice parent_obj;
     int index;
     uint64_t size;
     char **targets;
-    PXBCXLDev *target_hbs[16];
+    Object *target_hbs[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
@@ -60,6 +62,9 @@ struct CXLHost {
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
+#define TYPE_CXL_HOST "cxl-host"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLHostBridge, CXL_HOST)
+
 #define TYPE_CXL_USP "cxl-upstream"
 
 typedef struct CXLUpstreamPort CXLUpstreamPort;
diff --git a/include/hw/pci-host/cxl_host_bridge.h b/include/hw/pci-host/cxl_host_bridge.h
new file mode 100644
index 0000000000..db0e4b5390
--- /dev/null
+++ b/include/hw/pci-host/cxl_host_bridge.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/cxl/cxl.h"
+#include "hw/irq.h"
+#include "hw/pci/pcie_host.h"
+#include "system/memory.h"
+
+typedef struct CXLHostBridge {
+    PCIExpressHost parent_obj;
+
+    CXLComponentState cxl_cstate;
+
+    MemoryRegion ioport;
+    MemoryRegion mmio;
+    MemoryRegion ioport_window;
+    MemoryRegion mmio_window;
+    qemu_irq irq[PCI_NUM_PINS];
+    int irq_num[PCI_NUM_PINS];
+} CXLHostBridge;
+
+int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
+void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host);
-- 
2.34.1

