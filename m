Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9FAEB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGQRVz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQRVy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:21:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF134132
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:21:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TLz2Hgyz67nfn;
        Tue, 18 Jul 2023 01:18:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:21:50 +0100
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
Subject: [RFC PATCH 10/17] misc/i2c_mctp_cxl: Initial device emulation
Date:   Mon, 17 Jul 2023 18:16:39 +0100
Message-ID: <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
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

The CCI and Fabric Manager APIs are used to configure CXL switches and
devices. DMTF has defined an MCTP binding specification to carry
these messages. The end goal of this work is to hook this
up to emulated CXL switches and devices to  allow control of the
configuration.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h               |   9 +-
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 hw/cxl/cxl-mailbox-utils.c                |  73 +++++++
 hw/cxl/i2c_mctp_cxl.c                     | 237 ++++++++++++++++++++++
 hw/arm/Kconfig                            |   2 +
 hw/cxl/Kconfig                            |   3 +
 hw/cxl/meson.build                        |   1 +
 hw/i386/Kconfig                           |   2 +
 8 files changed, 326 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 962b2bee7c..c49ff7e9b3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -297,6 +297,10 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
                             bool *bg_started);
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+    size_t payload_max);
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+    size_t payload_max);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -397,8 +401,9 @@ struct CXLType3Dev {
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
-    CXLCCI cci;
-    
+    CXLCCI cci; /* Primary PCI mailbox CCI */
+    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
+
     /* DOE */
     DOECap doe_cdat;
     DOECap doe_comp;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index b02aa8f659..15db8c8582 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -11,6 +11,7 @@ typedef struct CXLUpstreamPort {
 
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLCCI mctpcci;
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2db1258946..2d3d19dce8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -45,6 +45,8 @@
  */
 
 enum {
+    INFOSTAT    = 0x00,
+        #define IS_IDENTIFY   0x1
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -203,6 +205,52 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
+/* CXL r3 8.2.9.1.1 */
+static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    PCIDeviceClass *class = PCI_DEVICE_GET_CLASS(cci->d);
+    struct {
+        uint16_t pcie_vid;
+        uint16_t pcie_did;
+        uint16_t pcie_subsys_vid;
+        uint16_t pcie_subsys_id;
+        uint64_t sn;
+    uint8_t max_message_size;
+        uint8_t component_type;
+    } QEMU_PACKED *is_identify;
+    QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
+
+    is_identify = (void *)payload_out;
+    memset(is_identify, 0, sizeof(*is_identify));
+    /*
+     * Messy question - which IDs?  Those of the CCI Function, or those of
+     * the USP?
+     */
+    is_identify->pcie_vid = class->vendor_id;
+    is_identify->pcie_did = class->device_id;
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
+        is_identify->sn = CXL_USP(cci->d)->sn;
+        /* Subsystem info not defined for a USP */
+        is_identify->pcie_subsys_vid = 0;
+        is_identify->pcie_subsys_id = 0;
+        is_identify->component_type = 0x0; /* Switch */
+    } else if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        is_identify->sn = CXL_TYPE3(cci->d)->sn;
+        is_identify->pcie_subsys_vid = class->subsystem_vendor_id;
+        is_identify->pcie_subsys_id = class->subsystem_id;
+        is_identify->component_type = 0x3; /* Type 3 */
+    }
+
+    /* FIXME: This depends on interface */
+    is_identify->max_message_size = CXL_MAILBOX_PAYLOAD_SHIFT;
+    *len_out = sizeof(*is_identify);
+    return CXL_MBOX_SUCCESS;
+}
 
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
@@ -797,3 +845,28 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cci->intf = d;
     cxl_init_cci(cci, payload_max);
 }
+
+static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+};
+
+void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
+static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
+};
+
+void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_usp_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
new file mode 100644
index 0000000000..58c3042aab
--- /dev/null
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -0,0 +1,237 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Emulation of a CXL Switch Fabric Management interface over MCTP over I2C.
+ *
+ * Copyright (c) 2023 Huawei Technologies.
+ *
+ * Reference list:
+ * From www.dmtf.org
+ * DSP0236 Management Component Transport Protocol (MCTP) Base Specification 1.3.0
+ * DPS0234 CXL Fabric Manager API over MCTP Binding Specification 1.0.0
+ * DSP0281 CXL Type 3 Deivce Component Command Interface over MCTP Binding
+ *    Specification (note some commands apply to switches as well)
+ * From www.computeexpresslink.org
+ * Compute Express Link (CXL) Specification revision 3.0 Version 1.0
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/mctp.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+
+#define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
+
+#define MCTP_CXL_MAX_MSG_LEN 1088 /* CXL FMAPI binding spec */
+
+typedef struct CXLMCTPMessage {
+    /*
+     * DSP0236 (MCTP Base) Integrity Check + Message Type
+     * DSP0234/DSP0281 (CXL bindings) state no Integrity Check
+     * so just the message type.
+     */
+    uint8_t message_type;
+    /* Remaing fields from CXL r3.0 Table 7-14 CCI Message Format */
+    uint8_t category;
+    uint8_t tag;
+    uint8_t rsvd;
+    /*
+     * CXL r3.0 - Table 8-36 Generic Component Command Opcodes:
+     * Command opcode is split into two sub fields
+     */
+    uint8_t command;
+    uint8_t command_set;
+    uint8_t pl_length[3];
+    uint16_t vendor_status;
+    uint16_t rc;
+    uint8_t payload[];
+} QEMU_PACKED CXLMCTPMessage;
+
+enum cxl_dev_type {
+    cxl_type3,
+    cxl_switch,
+};
+
+struct I2C_MCTP_CXL_State {
+    MCTPI2CEndpoint mctp;
+    PCIDevice *target;
+    CXLCCI *cci;
+    enum cxl_dev_type type;
+    size_t len;
+    int64_t pos;
+    uint8_t buffer[MCTP_CXL_MAX_MSG_LEN];
+    uint8_t scratch[MCTP_CXL_MAX_MSG_LEN];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I2C_MCTP_CXL_State, I2C_MCTP_CXL)
+
+static Property i2c_mctp_cxl_props[] = {
+    DEFINE_PROP_LINK("target", I2C_MCTP_CXL_State,
+                     target, TYPE_PCI_DEVICE, PCIDevice *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static size_t i2c_mctp_cxl_get_message_bytes(MCTPI2CEndpoint *mctp,
+                                             uint8_t *buf,
+                                             size_t maxlen,
+                                             uint8_t *mctp_flags)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+    size_t len;
+
+    len = MIN(maxlen, s->len - s->pos);
+
+    if (len == 0) {
+        return 0;
+    }
+
+    if (s->pos == 0) {
+        *mctp_flags |= MCTP_H_FLAGS_SOM;
+    }
+
+    memcpy(buf, s->scratch + s->pos, len);
+    s->pos += len;
+
+    if (s->pos == s->len) {
+        *mctp_flags |= MCTP_H_FLAGS_EOM;
+
+        s->pos = s->len = 0;
+    }
+
+    return len;
+}
+
+static int i2c_mctp_cxl_put_message_bytes(MCTPI2CEndpoint *mctp,
+                                          uint8_t *buf, size_t len)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+
+    if (s->len + len > MCTP_CXL_MAX_MSG_LEN) {
+        return -1;
+    }
+
+    memcpy(s->buffer + s->len, buf, len);
+    s->len += len;
+
+    return 0;
+}
+
+static size_t i2c_mctp_cxl_get_message_types(MCTPI2CEndpoint *mctp,
+                                             uint8_t *data,
+                                             size_t maxlen)
+{
+    uint8_t buf[] = {
+        0x0, 0x7, 0x8, /* Control, CXL FM-API and CXL CCI */
+    };
+
+    memcpy(data, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
+static void i2c_mctp_cxl_reset_message(MCTPI2CEndpoint *mctp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+
+    s->len = 0;
+}
+
+static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(mctp);
+    CXLMCTPMessage *msg = (CXLMCTPMessage *)s->buffer;
+    CXLMCTPMessage *buf = (CXLMCTPMessage *)s->scratch;
+
+    *buf = (CXLMCTPMessage) {
+        .message_type = msg->message_type,
+        .category = 1,
+        .tag = msg->tag,
+    };
+    s->pos = sizeof(buf);
+
+    /* To fix, msg->message_type currently ignored */
+    if (s->cci) {
+        bool bg_started;
+        int rc;
+        size_t len_out;
+        size_t len_in = msg->pl_length[2] << 16 | msg->pl_length[1] << 8 |
+            msg->pl_length[0]; //hack
+        
+        rc = cxl_process_cci_message(s->cci, msg->command_set, msg->command,
+                                     len_in, msg->payload,
+                                     &len_out, s->scratch + sizeof(CXLMCTPMessage),
+                                     &bg_started);
+        buf->command = msg->command;
+        buf->command_set = msg->command_set;
+        buf->rc = rc;
+        s->len += len_out;
+        st24_le_p(buf->pl_length, len_out);
+        s->pos = 0;
+        i2c_mctp_schedule_send(mctp);
+    }
+}   
+
+static void i2c_mctp_cxl_realize(DeviceState *d, Error **errp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(d);
+
+    /* Check this is a type we support */
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(s->target);
+        
+        s->type = cxl_switch;
+        s->cci = &usp->mctpcci;
+        /* Figure out right size */
+        cxl_initialize_usp_mctpcci(s->cci, DEVICE(s->target), d, 512);
+
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(s->target);
+
+        s->type = cxl_type3;
+        s->cci = &ct3d->oob_mctp_cci;
+
+        cxl_initialize_t3_mctpcci(s->cci, DEVICE(s->target), d, 512);
+        return;
+    }
+
+    error_setg(errp, "Unhandled target type for CXL MCTP EP");
+}
+
+static void i2c_mctp_cxl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_CLASS(klass);
+
+    dc->realize = i2c_mctp_cxl_realize;
+    mc->get_message_types = i2c_mctp_cxl_get_message_types;
+    mc->get_message_bytes = i2c_mctp_cxl_get_message_bytes;
+    mc->put_message_bytes = i2c_mctp_cxl_put_message_bytes;
+
+    mc->handle_message = i2c_mctp_cxl_handle_message;
+    mc->reset_message = i2c_mctp_cxl_reset_message;
+    device_class_set_props(dc, i2c_mctp_cxl_props);
+}
+
+static const TypeInfo i2c_mctp_cxl_info = {
+    .name = TYPE_I2C_MCTP_CXL,
+    .parent = TYPE_MCTP_I2C_ENDPOINT,
+    .instance_size = sizeof(I2C_MCTP_CXL_State),
+    .class_init = i2c_mctp_cxl_class_init,
+};
+
+static void i2c_mctp_cxl_register_types(void)
+{
+    type_register_static(&i2c_mctp_cxl_info);
+}
+
+type_init(i2c_mctp_cxl_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3308d9e0bd..f2415e0d44 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -32,6 +32,8 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select MCTP_I2C
+    select I2C_MCTP_CXL
 
 config CHEETAH
     bool
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index 8e67519b16..c9b2e46bac 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,6 @@
 config CXL
     bool
     default y if PCI_EXPRESS
+
+config I2C_MCTP_CXL
+    bool
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 9024e9a9a6..7a885e7b84 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -11,5 +11,6 @@ system_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
+system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9051083c1e..9644e81254 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -45,6 +45,8 @@ config PC
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
+    select MCTP_I2C
+    select I2C_MCTP_CXL
 
 config PC_PCI
     bool
-- 
2.39.2

