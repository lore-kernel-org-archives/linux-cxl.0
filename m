Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201CC04E69
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGQRY3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGQRY2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:24:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC2B5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:24:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TP76RNDz67nKD;
        Tue, 18 Jul 2023 01:20:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:24:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 15/17] hw/cxl: Add a switch mailbox CCI function.
Date:   Mon, 17 Jul 2023 18:16:44 +0100
Message-ID: <20230717171646.8972-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
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
 include/hw/cxl/cxl.h                      |   6 +
 include/hw/cxl/cxl_component.h            |   3 +-
 include/hw/cxl/cxl_device.h               |  15 +++
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-device-utils.c                 |  25 +++++
 hw/cxl/cxl-mailbox-utils.c                | 129 ++++++++++++++++++++++
 hw/cxl/switch-mailbox-cci.c               |  98 ++++++++++++++++
 hw/pci-bridge/cxl_downstream.c            |   5 +-
 hw/cxl/meson.build                        |   1 +
 9 files changed, 279 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index cd7567d6a8..69484f2553 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -63,4 +63,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 typedef struct CXLUpstreamPort CXLUpstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLUpstreamPort, CXL_USP, TYPE_CXL_USP)
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
+
+#define TYPE_CXL_DSP "cxl-downstream"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
+
 #endif
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index c355192b7c..52b6a2d67f 100644
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
index c49ff7e9b3..215383ba37 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -244,8 +244,10 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
                                     CXLCCI *cci);
 
 typedef struct CXLType3Dev CXLType3Dev;
+typedef struct CSWMBCCIDev CSWMBCCIDev;
 /* Set up default values for the register block */
 void cxl_device_register_init_t3(CXLType3Dev *ct3d);
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
 
 /*
  * CXL 2.0 - 8.2.8.1 including errata F4
@@ -292,6 +294,8 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
+                                  DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
@@ -437,6 +441,17 @@ struct CXLType3Class {
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
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
index 7dbc8b72d7..658321fa4a 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -64,6 +64,8 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return 0;
     }
@@ -148,6 +150,8 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
         cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_SWITCH_MAILBOX_CCI)) {
+        cxl_dstate = &CXL_SWITCH_MAILBOX_CCI(cci->intf)->cxl_dstate;
     } else {
         return;
     }
@@ -361,6 +365,27 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
                               CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
+void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
+{
+    CXLDeviceState *cxl_dstate = &sw->cxl_dstate;
+    uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
+    const int cap_count = 3;
+
+    /* CXL Device Capabilities Array Register */
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
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
index 2d3d19dce8..9c1020d9ab 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -47,6 +47,7 @@
 enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
+        #define BACKGROUND_OPERATION_STATUS    0x2
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -70,6 +71,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
 };
 
 
@@ -205,6 +208,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
+
 /* CXL r3 8.2.9.1.1 */
 static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
                                         uint8_t *payload_in,
@@ -252,6 +256,97 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
+                                  void *private)
+{
+    uint8_t *bm = private;
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+        uint8_t port = PCIE_PORT(d)->port;
+        bm[port / 8] |= 1 << (port % 8);
+    }
+}
+
+/* CXL r3 8.2.9.1.1 */
+static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    int num_phys_ports = pcie_count_ds_ports(bus);
+
+    struct cxl_fmapi_ident_switch_dev_resp_pl {
+        uint8_t ingress_port_id;
+        uint8_t rsvd;
+        uint8_t num_physical_ports;
+        uint8_t num_vcss;
+        uint8_t active_port_bitmask[0x20];
+        uint8_t active_vcs_bitmask[0x20];
+        uint16_t total_vppbs;
+        uint16_t bound_vppbs;
+        uint8_t num_hdm_decoders_per_usp;
+    } QEMU_PACKED *out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 0x49);
+
+    out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
+    *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
+        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+        .num_vcss = 1, /* Not yet support multiple VCS - potentialy tricky */
+        .active_vcs_bitmask[0] = 0x1,
+        .total_vppbs = num_phys_ports + 1,
+        .bound_vppbs = num_phys_ports + 1,
+        .num_hdm_decoders_per_usp = 4,
+    };
+
+    /* Depends on the CCI type */
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_PCIE_PORT)) {
+        out->ingress_port_id = PCIE_PORT(cci->intf)->port;
+    } else {
+        /* MCTP? */
+        out->ingress_port_id = 0;
+    }
+    
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
+                                  out->active_port_bitmask);
+    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
+
+    *len_out = sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.0 8.2.9.1.2 */
+static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint8_t status;
+        uint8_t rsvd;
+        uint16_t opcode;
+        uint16_t returncode;
+        uint16_t vendor_ext_status;
+    } QEMU_PACKED *bg_op_status;
+    QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
+
+    bg_op_status = (void *)payload_out;
+    memset(bg_op_status, 0, sizeof(*bg_op_status));
+    bg_op_status->status = cci->bg.complete_pct << 1;
+    if (cci->bg.runtime > 0) {
+        bg_op_status->status |= 1U << 0;
+    }
+    bg_op_status->opcode = cci->bg.opcode;
+    bg_op_status->returncode = cci->bg.ret_code;
+    *len_out = sizeof(*bg_op_status);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -796,6 +891,30 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
+        cmd_infostat_bg_op_sts, 0, 8 },
+    /*
+     * TODO get / set response message limit - requires all messages over
+     * 256 bytes to support chunking.
+     */
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0x49 },
+};
+
+/*
+ * While the command is executing in the background, the device should
+ * update the percentage complete in the Background Command Status Register
+ * at least once per second.
+ */
+
+#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
+
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in, size_t *len_out,
                             uint8_t *pl_out, bool *bg_started)
@@ -836,6 +955,14 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     }
 }
 
+void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
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
@@ -861,6 +988,8 @@ void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0x49 },
 };
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
new file mode 100644
index 0000000000..278d979d80
--- /dev/null
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -0,0 +1,98 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/qdev-properties.h"
+#include "hw/cxl/cxl.h"
+
+struct CSWMBCCIClass {
+    PCIDeviceClass parent_class;
+};
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
+        .reg_base[0].lo = RBI_CXL_DEVICE_REG | 0,
+        .reg_base[0].hi = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, CXL3_SWITCH_MAILBOX_CCI,
+                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
+
+    cxl_initialize_mailbox_swcci(cswmb->cci, DEVICE(pci_dev), DEVICE(cswmb->target),
+                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+}
+
+static void cswmbcci_exit(PCIDevice *pci_dev)
+{
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
+    pc->class_id = 0x0c0b; /* Serial bus, CXL Switch CCI */
+    pc->vendor_id = 0x19e5;
+    pc->device_id = 0xbeef; /* FIXME - assign a valid ID for this function */
+    pc->revision = 0;
+    dc->desc = "CXL Switch Mailbox CCI";
+    dc->reset = cswmbcci_reset;
+    device_class_set_props(dc, cxl_switch_cci_props);
+}
+
+static const TypeInfo cswmbcci_info = {
+    .name = TYPE_CXL_SWITCH_MAILBOX_CCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_size = sizeof(struct CSWMBCCIClass),
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
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 7eb1981be3..573c583be4 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,7 +13,9 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
 #include "qapi/error.h"
+#include "hw/cxl/cxl.h"
 
 typedef struct CXLDownstreamPort {
     /*< private >*/
@@ -23,9 +25,6 @@ typedef struct CXLDownstreamPort {
     CXLComponentState cxl_cstate;
 } CXLDownstreamPort;
 
-#define TYPE_CXL_DSP "cxl-downstream"
-DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
-
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 1
 #define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 7a885e7b84..1393821fc4 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -7,6 +7,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-cdat.c',
                    'cxl-events.c',
                    'cxl-cpmu.c',
+                   'switch-mailbox-cci.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
-- 
2.39.2

