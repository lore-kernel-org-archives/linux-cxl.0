Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D46C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 30 May 2022 14:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbiE3OWW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 May 2022 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbiE3ORr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 May 2022 10:17:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D614544C4
        for <linux-cxl@vger.kernel.org>; Mon, 30 May 2022 06:47:46 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LBc7H55jzz6GD5M;
        Mon, 30 May 2022 21:43:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 15:47:43 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 14:47:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH 5/8] pci/pci_expander_bridge: For CXL HB delay the HB register memory region setup.
Date:   Mon, 30 May 2022 14:45:11 +0100
Message-ID: <20220530134514.31664-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220530134514.31664-1-Jonathan.Cameron@huawei.com>
References: <20220530134514.31664-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As the CXLState will no long be accessible via MachineState
at time of PXB_CXL realization, come back later from the machine specific
code to fill in the missing memory region setup. Only at this stage
is it possible to check if cxl=on, so that check is moved to this
later point.

Note that for multiple host bridges, the allocation order of the
register spaces is changed. This will be reflected in ACPI CEDT.

Stubs are added to handle case of CONFIG_PXB=n for machines that
call these functions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/pc.c                                | 17 +++++++++++
 hw/pci-bridge/meson.build                   |  5 +++-
 hw/pci-bridge/pci_expander_bridge.c         | 32 +++++++++++++--------
 hw/pci-bridge/pci_expander_bridge_stubs.c   | 14 +++++++++
 include/hw/pci-bridge/pci_expander_bridge.h | 12 ++++++++
 5 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6cecd74d58..88b5454aaf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -37,6 +37,7 @@
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/firmware/smbios.h"
@@ -733,7 +734,23 @@ void pc_machine_done(Notifier *notifier, void *data)
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
     MachineState *ms = MACHINE(pcms);
+    PCIBus *bus = pcms->bus;
 
+    /* Walk the pci busses looking for pxb busses to hook up */
+    if (bus) {
+        QLIST_FOREACH(bus, &bus->child, sibling) {
+            if (!pci_bus_is_root(bus)) {
+                continue;
+            }
+            if (pci_bus_is_cxl(bus)) {
+                if (!ms->cxl_devices_state->is_enabled) {
+                    error_report("CXL host bridges present, but cxl=off");
+                    exit(EXIT_FAILURE);
+                }
+                pxb_cxl_hook_up_registers(ms->cxl_devices_state, bus, &error_fatal);
+            }
+        }
+    }
     if (ms->cxl_devices_state) {
         cxl_fmws_link_targets(ms->cxl_devices_state, &error_fatal);
     }
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index b6d26a03d5..fdbe2e07c5 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -3,7 +3,8 @@ pci_ss.add(files('pci_bridge_dev.c'))
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
-pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
+                               if_false: files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c'))
 
@@ -13,3 +14,5 @@ pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
 pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
 
 softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('pci_expander_bridge_stubs.c'))
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 02032360f5..c9e817aa58 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -17,6 +17,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/cxl/cxl.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
@@ -186,25 +187,38 @@ static const TypeInfo pxb_host_info = {
 
 static void pxb_cxl_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     CXLHost *cxl = PXB_CXL_HOST(dev);
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
     struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-    hwaddr offset;
 
     cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
                                       TYPE_PXB_CXL_HOST);
     sysbus_init_mmio(sbd, mr);
+}
+
+/*
+ * Host bridge realization has no means of knowning state associated
+ * with a particular machine. As such, it is nececssary to delay
+ * final setup of the host bridge register space until later in the
+ * machine bring up.
+ */
+void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
+{
+    PXBDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
+    CXLHost *cxl = pxb->cxl.cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    hwaddr offset;
 
-    offset = memory_region_size(mr) * ms->cxl_devices_state->next_mr_idx;
-    if (offset > memory_region_size(&ms->cxl_devices_state->host_mr)) {
+    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
+    if (offset > memory_region_size(&cxl_state->host_mr)) {
         error_setg(errp, "Insufficient space for pxb cxl host register space");
         return;
     }
 
-    memory_region_add_subregion(&ms->cxl_devices_state->host_mr, offset, mr);
-    ms->cxl_devices_state->next_mr_idx++;
+    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
+    cxl_state->next_mr_idx++;
 }
 
 static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
@@ -461,17 +475,11 @@ static const TypeInfo pxb_pcie_dev_info = {
 
 static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-
     /* A CXL PXB's parent bus is still PCIe */
     if (!pci_bus_is_express(pci_get_bus(dev))) {
         error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
         return;
     }
-    if (!ms->cxl_devices_state || !ms->cxl_devices_state->is_enabled) {
-        error_setg(errp, "Machine does not have cxl=on");
-        return;
-    }
 
     pxb_dev_realize_common(dev, CXL, errp);
     pxb_dev_reset(DEVICE(dev));
diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
new file mode 100644
index 0000000000..b35180311f
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_stubs.c
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Stubs for calls made from machines to handle the case where CONFIG_PXB
+ * is not enabled.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/cxl/cxl.h"
+
+void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
new file mode 100644
index 0000000000..0b3856d615
--- /dev/null
+++ b/include/hw/pci-bridge/pci_expander_bridge.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PCI_EXPANDER_BRIDGE_H
+#define PCI_EXPANDER_BRIDGE_H
+
+#include "hw/cxl/cxl.h"
+
+void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp);
+
+#endif /* PCI_EXPANDER_BRIDGE_H */
-- 
2.32.0

