Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A979C433F5
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 18:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiCFSFY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCFSFY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 13:05:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD451E51
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 10:04:31 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTwG2vjHz67h3l;
        Mon,  7 Mar 2022 02:03:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 19:04:29 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:04:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 45/46] pci-bridge/cxl_downstream: Add a CXL switch downstream port
Date:   Sun, 6 Mar 2022 17:41:36 +0000
Message-ID: <20220306174137.5707-46-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Emulation of a simple CXL Switch downstream port.
The Device ID has been allocated for this use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_downstream.c | 229 +++++++++++++++++++++++++++++++++
 hw/pci-bridge/meson.build      |   2 +-
 2 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
new file mode 100644
index 0000000000..8e66f632a5
--- /dev/null
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -0,0 +1,229 @@
+/*
+ * Emulated CXL Switch Downstream Port
+ *
+ * Copyright (c) 2022 Huawei Technologies.
+ *
+ * Based on xio31130_downstream.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "qapi/error.h"
+
+typedef struct CXLDownStreamPort {
+    /*< private >*/
+    PCIESlot parent_obj;
+
+    /*< public >*/
+    CXLComponentState cxl_cstate;
+} CXLDownstreamPort;
+
+#define TYPE_CXL_DSP "cxl-downstream"
+DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
+
+#define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
+#define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 1
+#define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
+#define CXL_DOWNSTREAM_PORT_AER_OFFSET 0x100
+#define CXL_DOWNSTREAM_PORT_DVSEC_OFFSET        \
+    (CXL_DOWNSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+
+static void latch_registers(CXLDownstreamPort *dsp)
+{
+    uint32_t *reg_state = dsp->cxl_cstate.crb.cache_mem_registers;
+
+    cxl_component_register_init_common(reg_state, CXL2_DOWNSTREAM_PORT);
+}
+
+/* TODO: Look at sharing this code acorss all CXL port types */
+static void cxl_dsp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
+                                      uint32_t val, int len)
+{
+    CXLDownstreamPort *dsp = CXL_DSP(dev);
+    CXLComponentState *cxl_cstate = &dsp->cxl_cstate;
+
+    if (range_contains(&cxl_cstate->dvsecs[EXTENSIONS_PORT_DVSEC], addr)) {
+        uint8_t *reg = &dev->config[addr];
+        addr -= cxl_cstate->dvsecs[EXTENSIONS_PORT_DVSEC].lob;
+        if (addr == PORT_CONTROL_OFFSET) {
+            if (pci_get_word(reg) & PORT_CONTROL_UNMASK_SBR) {
+                /* unmask SBR */
+            }
+            if (pci_get_word(reg) & PORT_CONTROL_ALT_MEMID_EN) {
+                /* Alt Memory & ID Space Enable */
+            }
+        }
+    }
+}
+
+static void cxl_dsp_config_write(PCIDevice *d, uint32_t address,
+                                 uint32_t val, int len)
+{
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
+    pci_bridge_write_config(d, address, val, len);
+    pcie_cap_flr_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
+    pcie_aer_write_config(d, address, val, len);
+
+    cxl_dsp_dvsec_write_config(d, address, val, len);
+}
+
+static void cxl_dsp_reset(DeviceState *qdev)
+{
+    PCIDevice *d = PCI_DEVICE(qdev);
+    CXLDownstreamPort *dsp = CXL_DSP(qdev);
+
+    pcie_cap_deverr_reset(d);
+    pcie_cap_slot_reset(d);
+    pcie_cap_arifwd_reset(d);
+    pci_bridge_reset(qdev);
+
+    latch_registers(dsp);
+}
+
+static void build_dvsecs(CXLComponentState *cxl)
+{
+    uint8_t *dvsec;
+
+    dvsec = (uint8_t *)&(struct cxl_dvsec_port_extensions){ 0 };
+    cxl_component_create_dvsec(cxl, EXTENSIONS_PORT_DVSEC_LENGTH,
+                               EXTENSIONS_PORT_DVSEC,
+                               EXTENSIONS_PORT_DVSEC_REVID, dvsec);
+    dvsec = (uint8_t *)&(struct cxl_dvsec_port_flexbus){
+        .cap                     = 0x26, /* IO, Mem, non-MLD */
+        .ctrl                    = 0,
+        .status                  = 0x26, /* same */
+        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
+    };
+    cxl_component_create_dvsec(cxl, PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+
+    dvsec = (uint8_t *)&(struct cxl_dvsec_register_locator){
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg0_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, dvsec);
+}
+
+static void cxl_dsp_realize(PCIDevice *d, Error **errp)
+{
+    PCIEPort *p = PCIE_PORT(d);
+    PCIESlot *s = PCIE_SLOT(d);
+    CXLDownstreamPort *dsp = CXL_DSP(d);
+    CXLComponentState *cxl_cstate = &dsp->cxl_cstate;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    MemoryRegion *component_bar = &cregs->component_registers;
+    int rc;
+
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);
+    pcie_port_init_reg(d);
+
+    rc = msi_init(d, CXL_DOWNSTREAM_PORT_MSI_OFFSET,
+                  CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR,
+                  true, true, errp);
+    if (rc) {
+        assert(rc == -ENOTSUP);
+        goto err_bridge;
+    }
+
+    rc = pcie_cap_init(d, CXL_DOWNSTREAM_PORT_EXP_OFFSET,
+                       PCI_EXP_TYPE_DOWNSTREAM, p->port,
+                       errp);
+    if (rc < 0) {
+        goto err_msi;
+    }
+
+    pcie_cap_flr_init(d);
+    pcie_cap_deverr_init(d);
+    pcie_cap_slot_init(d, s);
+    pcie_cap_arifwd_init(d);
+
+    pcie_chassis_create(s->chassis);
+    rc = pcie_chassis_add_slot(s);
+    if (rc < 0) {
+        error_setg(errp, "Can't add chassis slot, error %d", rc);
+        goto err_pcie_cap;
+    }
+
+    rc = pcie_aer_init(d, PCI_ERR_VER, CXL_DOWNSTREAM_PORT_AER_OFFSET,
+                       PCI_ERR_SIZEOF, errp);
+    if (rc < 0) {
+        goto err_chassis;
+    }
+
+    cxl_cstate->dvsec_offset = CXL_DOWNSTREAM_PORT_DVSEC_OFFSET;
+    cxl_cstate->pdev = d;
+    build_dvsecs(cxl_cstate);
+    cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_DSP);
+    pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     component_bar);
+
+    return;
+
+ err_chassis:
+    pcie_chassis_del_slot(s);
+ err_pcie_cap:
+    pcie_cap_exit(d);
+ err_msi:
+    msi_uninit(d);
+ err_bridge:
+    pci_bridge_exitfn(d);
+}
+
+static void cxl_dsp_exitfn(PCIDevice *d)
+{
+    PCIESlot *s = PCIE_SLOT(d);
+
+    pcie_aer_exit(d);
+    pcie_chassis_del_slot(s);
+    pcie_cap_exit(d);
+    msi_uninit(d);
+    pci_bridge_exitfn(d);
+}
+
+static void cxl_dsp_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
+
+    k->is_bridge = true;
+    k->config_write = cxl_dsp_config_write;
+    k->realize = cxl_dsp_realize;
+    k->exit = cxl_dsp_exitfn;
+    k->vendor_id = 0x19e5; /* Huawei */
+    k->device_id = 0xa129; /* Emulated CXL Switch Downstream Port */
+    k->revision = 0;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->desc = "CXL Switch Downstream Port";
+    dc->reset = cxl_dsp_reset;
+}
+
+static const TypeInfo cxl_dsp_info = {
+    .name = TYPE_CXL_DSP,
+    .instance_size = sizeof(CXLDownstreamPort),
+    .parent = TYPE_PCIE_SLOT,
+    .class_init = cxl_dsp_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CXL_DEVICE },
+        { }
+    },
+};
+
+static void cxl_dsp_register_type(void)
+{
+    type_register_static(&cxl_dsp_info);
+}
+
+type_init(cxl_dsp_register_type);
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 4a8c26b5a1..53cc53314a 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -5,7 +5,7 @@ pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
-pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c'))
+pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
 # NewWorld PowerMac
 pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
-- 
2.32.0

