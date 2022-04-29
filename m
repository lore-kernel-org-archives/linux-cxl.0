Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA7EC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 15:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377508AbiD2PGk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358332AbiD2PGj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 11:06:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB089CD67E
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 08:03:20 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqbJV4Xsqz67xMg;
        Fri, 29 Apr 2022 23:00:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:03:18 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:03:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v10 43/45] pci-bridge/cxl_upstream: Add a CXL switch upstream port
Date:   Fri, 29 Apr 2022 15:41:08 +0100
Message-ID: <20220429144110.25167-44-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

An initial simple upstream port emulation to allow the creation
of CXL switches. The Device ID has been allocated for this use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_upstream.c | 216 +++++++++++++++++++++++++++++++++++
 hw/pci-bridge/meson.build    |   2 +-
 include/hw/cxl/cxl.h         |   4 +
 3 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
new file mode 100644
index 0000000000..6d98f9537a
--- /dev/null
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -0,0 +1,216 @@
+/*
+ * Emulated CXL Switch Upstream Port
+ *
+ * Copyright (c) 2022 Huawei Technologies.
+ *
+ * Based on xio31130_upstream.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+
+#define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 1
+
+#define CXL_UPSTREAM_PORT_MSI_OFFSET 0x70
+#define CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET 0x90
+#define CXL_UPSTREAM_PORT_AER_OFFSET 0x100
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+
+typedef struct CXLUpstreamPort {
+    /*< private >*/
+    PCIEPort parent_obj;
+
+    /*< public >*/
+    CXLComponentState cxl_cstate;
+} CXLUpstreamPort;
+
+CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
+{
+    return &usp->cxl_cstate;
+}
+
+static void cxl_usp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
+                                       uint32_t val, int len)
+{
+    CXLUpstreamPort *usp = CXL_USP(dev);
+
+    if (range_contains(&usp->cxl_cstate.dvsecs[EXTENSIONS_PORT_DVSEC], addr)) {
+        uint8_t *reg = &dev->config[addr];
+        addr -= usp->cxl_cstate.dvsecs[EXTENSIONS_PORT_DVSEC].lob;
+        if (addr == PORT_CONTROL_OFFSET) {
+            if (pci_get_word(reg) & PORT_CONTROL_UNMASK_SBR) {
+                /* unmask SBR */
+                qemu_log_mask(LOG_UNIMP, "SBR mask control is not supported\n");
+            }
+            if (pci_get_word(reg) & PORT_CONTROL_ALT_MEMID_EN) {
+                /* Alt Memory & ID Space Enable */
+                qemu_log_mask(LOG_UNIMP,
+                              "Alt Memory & ID space is not supported\n");
+            }
+        }
+    }
+}
+
+static void cxl_usp_write_config(PCIDevice *d, uint32_t address,
+                                 uint32_t val, int len)
+{
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+
+    cxl_usp_dvsec_write_config(d, address, val, len);
+}
+
+static void latch_registers(CXLUpstreamPort *usp)
+{
+    uint32_t *reg_state = usp->cxl_cstate.crb.cache_mem_registers;
+    uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk,
+                                       CXL2_UPSTREAM_PORT);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
+}
+
+static void cxl_usp_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+    CXLUpstreamPort *usp = CXL_USP(qdev);
+
+    pci_bridge_reset(qdev);
+    pcie_cap_deverr_reset(d);
+    latch_registers(usp);
+}
+
+static void build_dvsecs(CXLComponentState *cxl)
+{
+    uint8_t *dvsec;
+
+    dvsec = (uint8_t *)&(CXLDVSECPortExtensions){
+        .status = 0x1, /* Port Power Management Init Complete */
+    };
+    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+                               EXTENSIONS_PORT_DVSEC_LENGTH,
+                               EXTENSIONS_PORT_DVSEC,
+                               EXTENSIONS_PORT_DVSEC_REVID, dvsec);
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
+        .ctrl                    = 0x27, /* Cache, IO, Mem */
+        .status                  = 0x26, /* same */
+        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
+    };
+    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg0_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, dvsec);
+}
+
+static void cxl_usp_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+    CXLUpstreamPort *usp = CXL_USP(d);
+    CXLComponentState *cxl_cstate = &usp->cxl_cstate;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    MemoryRegion *component_bar = &cregs->component_registers;
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = msi_init(d, CXL_UPSTREAM_PORT_MSI_OFFSET,
+                  CXL_UPSTREAM_PORT_MSI_NR_VECTOR, true, true, errp);
+    if (rc) {
+        assert(rc == -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc = pcie_cap_init(d, CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET,
+                       PCI_EXP_TYPE_UPSTREAM, p->port, errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+    rc = pcie_aer_init(d, PCI_ERR_VER, CXL_UPSTREAM_PORT_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc) {
+        goto err_cap;
+    }
+
+    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
+    cxl_cstate->pdev = d;
+    build_dvsecs(cxl_cstate);
+    cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
+    pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     component_bar);
+
+    return;
+
+err_cap:
+    pcie_cap_exit(d);
+err_msi:
+    msi_uninit(d);
+err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void cxl_usp_exitfn(PCIDevice *d)
+{
+    pcie_aer_exit(d);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static void cxl_upstream_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
+
+    k->is_bridge = true;
+    k->config_write = cxl_usp_write_config;
+    k->realize = cxl_usp_realize;
+    k->exit = cxl_usp_exitfn;
+    k->vendor_id = 0x19e5; /* Huawei */
+    k->device_id = 0xa128; /* Emulated CXL Switch Upstream Port */
+    k->revision = 0;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "CXL Switch Upstream Port";
+    dc->reset = cxl_usp_reset;
+}
+
+static const TypeInfo cxl_usp_info = {
+    .name = TYPE_CXL_USP,
+    .parent = TYPE_PCIE_PORT,
+    .instance_size = sizeof(CXLUpstreamPort),
+    .class_init = cxl_upstream_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CXL_DEVICE },
+        { }
+    },
+};
+
+static void cxl_usp_register_type(void)
+{
+    type_register_static(&cxl_usp_info);
+}
+
+type_init(cxl_usp_register_type);
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index b6d26a03d5..4a8c26b5a1 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -5,7 +5,7 @@ pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
-pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c'))
+pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c'))
 
 # NewWorld PowerMac
 pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 21d28ca110..ff7b296b9f 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -57,5 +57,9 @@ void cxl_fixed_memory_window_config(MachineState *ms,
 void cxl_fixed_memory_window_link_targets(Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
+#define TYPE_CXL_USP "cxl-upstream"
 
+typedef struct CXLUpstreamPort CXLUpstreamPort;
+DECLARE_INSTANCE_CHECKER(CXLUpstreamPort, CXL_USP, TYPE_CXL_USP)
+CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
 #endif
-- 
2.32.0

