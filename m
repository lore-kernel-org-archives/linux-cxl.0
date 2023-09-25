Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A4CE7A9B
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIYQQi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjIYQQh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:16:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51781CE
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:16:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvScM0hSDz6DBCn;
        Tue, 26 Sep 2023 00:14:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:16:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 10/19] hw/cxl: Add a switch mailbox CCI function
Date:   Mon, 25 Sep 2023 17:11:15 +0100
Message-ID: <20230925161124.18940-11-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL switch CCIs were added in CXL r3.0. They are a PCI function,
identified by class code that provides a CXL mailbox (identical
to that previously defined for CXL type 3 memory devices) over which
various FM-API commands may be used. Whilst the intent of this
feature is enable switch control from a BMC attached to a switch
upstream port, it is also useful to allow emulation of this feature
on the upstream port connected to a host using the CXL devices as
this greatly simplifies testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
- Use assigned Huawei VID and Device ID pair for this emulated device.
---
 include/hw/cxl/cxl_component.h            |   3 +-
 include/hw/cxl/cxl_device.h               |  15 +++
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-device-utils.c                 |  27 ++++++
 hw/cxl/cxl-mailbox-utils.c                |  21 ++++
 hw/cxl/switch-mailbox-cci.c               | 111 ++++++++++++++++++++++
 hw/cxl/meson.build                        |   1 +
 7 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index e52dd8d2b9..5227a8e833 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -26,7 +26,8 @@ enum reg_type {
     CXL2_LOGICAL_DEVICE,
     CXL2_ROOT_PORT,
     CXL2_UPSTREAM_PORT,
-    CXL2_DOWNSTREAM_PORT
+    CXL2_DOWNSTREAM_PORT,
+    CXL3_SWITCH_MAILBOX_CCI,
 };
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba74908da5..a99a7e6274 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -221,8 +221,10 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
                                     CXLCCI *cci);
 
 typedef struct CXLType3Dev CXLType3Dev;
+typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
 void cxl_device_register_init_t3(CXLType3Dev *ct3d);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
 
 /*
  * CXL 2.0 - 8.2.8.1 including errata F4
@@ -269,6 +271,8 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
+                                  DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
@@ -412,6 +416,17 @@ struct CXLType3Class {
                           uint8_t *data);
 };
 
+struct CSWMBCCIDev {
+    PCIDevice parent_obj;
+    PCIDevice *target;
+    CXLComponentState cxl_cstate;
+    CXLDeviceState cxl_dstate;
+    CXLCCI *cci;
+};
+
+#define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
+OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
+
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs);
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index 15db8c8582..7275102cfa 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -12,6 +12,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI mctpcci;
+    CXLCCI swcci;
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index f3a6e17154..3dd45fb262 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -67,6 +67,9 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf),
+                                   TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return 0;
     }
@@ -154,6 +157,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf),
+                                   TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return;
     }
@@ -372,6 +378,27 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+{
+    CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
+    uint64_t *cap_h = cxl_dstate->caps_reg_state64;
+    const int cap_count = 3;
+
+    /* CXL Device Capabilities Array Register */
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
+    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
+
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
+    device_reg_init_common(cxl_dstate);
+
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
+    mailbox_reg_init_common(cxl_dstate);
+
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
+    memdev_reg_init_common(cxl_dstate);
+}
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
 {
     uint64_t time, delta;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e319cfccf7..9d5b5dadbd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -863,6 +863,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
+                         IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0x49 },
+};
+
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in, size_t *len_out,
                             uint8_t *pl_out, bool *bg_started)
@@ -904,6 +916,15 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     }
 }
 
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
+                                  DeviceState *d, size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
     cci->cxl_cmd_set = cxl_cmd_set;
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
new file mode 100644
index 0000000000..ba399c6240
--- /dev/null
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -0,0 +1,111 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Emulation of a CXL Switch Mailbox CCI PCIe function.
+ *
+ * Copyright (c) 2023 Huawei Technologies.
+ *
+ * From www.computeexpresslink.org
+ * Compute Express Link (CXL) Specification revision 3.0 Version 1.0
+ */
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/qdev-properties.h"
+#include "hw/cxl/cxl.h"
+
+static void cswmbcci_reset(DeviceState *dev)
+{
+    CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(dev);
+    cxl_device_register_init_swcci(cswmb);
+}
+
+static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CSWMBCCIDev *cswmb = CXL_SWITCH_MAILBOX_CCI(pci_dev);
+    CXLComponentState *cxl_cstate = &cswmb->cxl_cstate;
+    CXLDeviceState *cxl_dstate = &cswmb->cxl_dstate;
+    CXLDVSECRegisterLocator *regloc_dvsec;
+    CXLUpstreamPort *usp;
+
+    if (!cswmb->target) {
+        error_setg(errp, "Target not set");
+        return;
+    }
+    usp = CXL_USP(cswmb->target);
+
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+    cxl_cstate->dvsec_offset = 0x100;
+    cxl_cstate->pdev = pci_dev;
+    cswmb->cci = &usp->swcci;
+    cxl_device_register_block_init(OBJECT(pci_dev), cxl_dstate, cswmb->cci);
+    pci_register_bar(pci_dev, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &cxl_dstate->device_registers);
+    regloc_dvsec = &(CXLDVSECRegisterLocator) {
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_CXL_DEVICE_REG | 0,
+        .reg0_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
+
+    cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev),
+                                 DEVICE(cswmb->target),
+                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+}
+
+static void cswmbcci_exit(PCIDevice *pci_dev)
+{
+    /* Nothing to do here yet */
+}
+
+static Property cxl_switch_cci_props[] = {
+    DEFINE_PROP_LINK("target", CSWMBCCIDev,
+                     target, TYPE_CXL_USP, PCIDevice *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cswmbcci_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = cswbcci_realize;
+    pc->exit = cswmbcci_exit;
+    /* Serial bus, CXL Switch CCI */
+    pc->class_id = 0x0c0b;
+    /*
+     * Huawei Technologies
+     * CXL Switch Mailbox CCI - DID assigned for emulation only.
+     * No real hardware will ever use this ID.
+     */
+    pc->vendor_id = 0x19e5;
+    pc->device_id = 0xa123;
+    pc->revision = 0;
+    dc->desc = "CXL Switch Mailbox CCI";
+    dc->reset = cswmbcci_reset;
+    device_class_set_props(dc, cxl_switch_cci_props);
+}
+
+static const TypeInfo cswmbcci_info = {
+    .name = TYPE_CXL_SWITCH_MAILBOX_CCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = cswmbcci_class_init,
+    .instance_size = sizeof(CSWMBCCIDev),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void cxl_switch_mailbox_cci_register(void)
+{
+    type_register_static(&cswmbcci_info);
+}
+type_init(cxl_switch_mailbox_cci_register);
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 0152a2b190..7c96e73320 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -6,6 +6,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-host.c',
                    'cxl-cdat.c',
                    'cxl-events.c',
+                   'switch-mailbox-cci.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
-- 
2.39.2

