Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A5C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjEYQMK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjEYQMH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 12:12:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769631A4
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 09:11:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRtKm67hYz67kvQ;
        Fri, 26 May 2023 00:09:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 17:11:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>
CC:     Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 5/6] misc/i2c_mctp_cxl: Initial device emulation
Date:   Thu, 25 May 2023 17:08:58 +0100
Message-ID: <20230525160859.32517-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525160859.32517-1-Jonathan.Cameron@huawei.com>
References: <20230525160859.32517-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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
 include/hw/cxl/cxl_fmapi.h | 102 ++++++++++
 hw/cxl/i2c_mctp_cxl.c      | 369 +++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig             |   3 +-
 hw/cxl/Kconfig             |   3 +
 hw/cxl/meson.build         |   1 +
 hw/i386/Kconfig            |   3 +-
 hw/misc/meson.build        |   1 +
 7 files changed, 480 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_fmapi.h b/include/hw/cxl/cxl_fmapi.h
new file mode 100644
index 0000000000..d5195a9fcc
--- /dev/null
+++ b/include/hw/cxl/cxl_fmapi.h
@@ -0,0 +1,102 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * CXL Fabric Manager API definitions
+ *
+ * Copyright (c) 2023 Huawei Technologies.
+ *
+ * Refs to: Compute Express Link (CXL) Specification revision 3.0 Version 1.0
+ * from www.computeexpresslink.org
+ *
+ * FM-API commands can be carried over various transports (MCTP, switch-CCI etc)
+ * so define the payloads in a common header.
+ */
+
+#ifndef CXL_FMAPI_H
+#define CXL_FMAPI_H
+
+#include "qemu/osdep.h"
+
+/*
+ * TODO: Confirm which commands sent via FM-API binding and which via Type 3 CCI
+ * binding.  For now I'm assuming only stuff in the FM-API table goes via
+ * FM-API.
+ */
+
+/*
+ * CXL r3.0 Table 8-36 Generic Component Command Opcodes
+ */
+
+/* CXL r3.0 8.2.9.1.1 Identify (Opcode 0001h) */
+#define CXL_CCI_CMD_SET_INFOSTAT 0x00
+#define   CXL_CCI_INFOSTAT_IDENTIFY 0x01
+
+struct cxl_cci_infostat_identify_resp_pl {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t subsystem_vendor_id;
+    uint16_t subsystem_id;
+    uint8_t serial_num[8];
+    uint8_t max_msg;
+    uint8_t component_type;
+};
+
+/*
+ * CXL r3.0 7.6.7 Fabric Management Application Programming Interface
+ */
+#define CXL_FMAPI_CMD_SET_PHYSICAL_SWITCH 0x51
+#define   CXL_FMAPI_PHYSICAL_SWITCH_IDENTIFY_SWITCH 0x00
+#define   CXL_FMAPI_GET_PHYSICAL_PORT_STATE 0x01
+
+/*
+ * CXL r3.0 7.6.7.1.1 Identify Switch Device (Opcode 5100h)
+ */
+struct cxl_fmapi_ident_switch_dev_resp_pl {
+    uint8_t ingres_port_id;
+    uint8_t rsv1;
+    uint8_t num_physical_ports;
+    uint8_t num_vcs;
+    uint8_t active_port_bitmask[32];
+    uint8_t active_vcs_bitmask[32];
+    uint16_t num_total_vppb;
+    uint16_t num_active_vppb;
+    uint8_t num_hdm_decoders;
+} QEMU_PACKED;
+
+/*
+ * CXL r3.0 7.6.7.1.2 Get Physical Port State (Opcode 5101h)
+ */
+
+/* CXL r3.0 Table 7-18 Get Physical Port State Request Payload */
+struct cxl_fmapi_get_phys_port_state_req_pl {
+    uint8_t num_ports; /* CHECK. may get too large for MCTP message size */
+    uint8_t ports[];
+} QEMU_PACKED;
+
+/* CXL r3.0 Table 7-20 Get Physical Port State Port Information Block Format */
+struct cxl_fmapi_port_state_info_block {
+    uint8_t port_id;
+    uint8_t config_state;
+    uint8_t connected_device_cxl_version;
+    uint8_t rsv1;
+    uint8_t connected_device_type;
+    uint8_t port_cxl_version_bitmask;
+    uint8_t max_link_width;
+    uint8_t negotiated_link_width;
+    uint8_t supported_link_speeds_vector;
+    uint8_t max_link_speed;
+    uint8_t current_link_speed;
+    uint8_t ltssm_state;
+    uint8_t first_lane_num;
+    uint16_t link_state;
+    uint8_t supported_ld_count;
+} QEMU_PACKED;
+
+/* CXL r3.0 Table 7-19 Get Physical Port State Response Payload */
+struct cxl_fmapi_get_phys_port_state_resp_pl {
+    uint8_t num_ports;
+    uint8_t rsv1[3];
+    struct cxl_fmapi_port_state_info_block ports[];
+} QEMU_PACKED;
+
+#endif /* CXL_FMAPI_H */
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
new file mode 100644
index 0000000000..8ce4c25eef
--- /dev/null
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -0,0 +1,369 @@
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
+#include "hw/cxl/cxl_fmapi.h"
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
+    uint16_t vendor_tatus;
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
+    enum cxl_dev_type type;
+    size_t len;
+    int64_t pos;
+    uint8_t buffer[MCTP_CXL_MAX_MSG_LEN];
+    uint8_t scratch[MCTP_CXL_MAX_MSG_LEN];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(I2C_MCTP_CXL_State, I2C_MCTP_CXL)
+
+static void cxl_cci_cmd_set_info_and_status_parse(I2C_MCTP_CXL_State *s,
+                                                  CXLMCTPMessage *msg)
+{
+    CXLMCTPMessage *out = (void *)s->scratch;
+    PCIDeviceClass *class = PCI_DEVICE_GET_CLASS(s->target);
+
+    switch (msg->command) {
+    case CXL_CCI_INFOSTAT_IDENTIFY:
+    {
+        struct cxl_cci_infostat_identify_resp_pl *pl =
+            (struct cxl_cci_infostat_identify_resp_pl *)&s->scratch[s->pos];
+
+        *pl = (struct cxl_cci_infostat_identify_resp_pl) {
+            .vendor_id = class->vendor_id,
+            .device_id = class->device_id,
+            .subsystem_vendor_id = class->subsystem_vendor_id,
+            .subsystem_id = class->subsystem_id,
+            /* TODO : Get serial number  - a bit fiddly */
+            .max_msg = 9, /* 512 - no need to chunk mctp for this */
+        };
+        switch (s->type) {
+        case cxl_type3:
+            pl->component_type = 0x3;
+            break;
+        case cxl_switch:
+            pl->component_type = 0x0;
+            break;
+        }
+
+        s->len += sizeof(*pl);
+        out->rc = CXL_MBOX_SUCCESS;
+        return;
+    }
+
+    default:
+        out->rc = CXL_MBOX_UNSUPPORTED;
+        return;
+    }
+}
+
+/* May make sense to push some of this to individual device emulation */
+static void cxl_fmapi_cmd_set_physical_switch_parse(I2C_MCTP_CXL_State *s,
+                                                    CXLMCTPMessage *msg)
+{
+    CXLMCTPMessage *out = (void *)s->scratch;
+
+    if (s->type != cxl_switch) {
+        /* TODO: Rename return codes as used for this as well as mailbox */
+        out->rc = CXL_MBOX_UNSUPPORTED;
+        return;
+    }
+
+    switch (msg->command) {
+    case CXL_FMAPI_PHYSICAL_SWITCH_IDENTIFY_SWITCH:
+    {
+        PCIEPort *usp = PCIE_PORT(s->target);
+        PCIBus *bus = &PCI_BRIDGE(s->target)->sec_bus;
+        struct cxl_fmapi_ident_switch_dev_resp_pl *pl =
+            (struct cxl_fmapi_ident_switch_dev_resp_pl *)&s->scratch[s->pos];
+        int num_phys_ports = pcie_count_ds_ports(bus);
+        int devfn;
+
+        *pl = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
+             /* TODO: Should be parameterized to support multiple instances */
+            .ingres_port_id = 0,
+            .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+            .num_vcs = 1, /* Not yet support multiple VCS - potentialy tricky */
+            .active_vcs_bitmask[0] = 0x1,
+            .num_total_vppb = num_phys_ports + 1,
+            .num_active_vppb = num_phys_ports + 1,
+            .num_hdm_decoders = 4,
+        };
+
+        /* Fill in the active ports bitmask with all USP and DSP port numbers */
+        for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+            PCIDevice *d = bus->devices[devfn];
+
+            if (!d || !pci_is_express(d) || !d->exp.exp_cap) {
+                continue;
+            }
+            if (object_dynamic_cast(OBJECT(d), TYPE_PCIE_PORT)) {
+                PCIEPort *port = PCIE_PORT(d);
+                uint8_t portnum = port->port;
+                pl->active_port_bitmask[portnum / 8] |= (1 << portnum % 8);
+            }
+        }
+        pl->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
+
+        s->len += sizeof(*pl);
+        out->rc = CXL_MBOX_SUCCESS;
+
+        return;
+    }
+
+    case CXL_FMAPI_GET_PHYSICAL_PORT_STATE:
+    {
+        size_t pl_size;
+        uint8_t num_ports = msg->payload[0];
+        int num_phys_ports = pcie_count_ds_ports(&PCI_BRIDGE(s->target)->sec_bus);
+        struct cxl_fmapi_get_phys_port_state_resp_pl *pl =
+            (struct cxl_fmapi_get_phys_port_state_resp_pl *)&s->scratch[s->pos];
+        int i;
+
+        /* TODO: Should match against particular ports requested... */
+        pl->num_ports = num_phys_ports;
+        for (i = 0; i < pl->num_ports; i++) {
+            struct cxl_fmapi_port_state_info_block *port;
+            port = &pl->ports[i];
+            port->port_id = i; /* TODO: Right port number */
+            if (port->port_id < 1) { /* 1 upstream ports */
+                port->config_state = 4;
+                port->connected_device_type = 0;
+            } else { /* remainder downstream ports */
+                port->config_state = 3;
+                port->connected_device_type = 4; /* TODO: Check. CXL type 3 */
+                port->supported_ld_count = 3;
+            }
+            port->connected_device_cxl_version = 2;
+            port->port_cxl_version_bitmask = 0x2;
+            port->max_link_width = 0x10; /* x16 */
+            port->negotiated_link_width = 0x10;
+            port->supported_link_speeds_vector = 0x1c; /* 8, 16, 32 GT/s */
+            port->max_link_speed = 5;
+            port->current_link_speed = 5; /* 32 */
+            port->ltssm_state = 0x7; /* L2 */
+            port->first_lane_num = 0;
+            port->link_state = 0;
+        }
+
+        pl_size = sizeof(pl) + sizeof(*pl->ports) * num_ports;
+
+        st24_le_p(out->pl_length, pl_size);
+        s->len += pl_size;
+        msg->rc = CXL_MBOX_SUCCESS;
+
+        return;
+    }
+
+    default:
+        msg->rc = CXL_MBOX_UNSUPPORTED;
+        return;
+    }
+}
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
+    CXLMCTPMessage buf = {
+        .message_type = msg->message_type,
+        .category = 1,
+        .tag = msg->tag,
+        .command = msg->command,
+        .command_set = msg->command_set,
+    };
+
+    memcpy(s->scratch, &buf, sizeof(buf));
+    s->pos = sizeof(buf);
+
+    switch (msg->message_type) {
+    case 0x7:
+        switch (msg->command_set)  {
+        case CXL_FMAPI_CMD_SET_PHYSICAL_SWITCH:
+            cxl_fmapi_cmd_set_physical_switch_parse(s, msg);
+            break;
+        }
+        break;
+    case 0x8:
+        switch (msg->command_set) {
+        case CXL_CCI_CMD_SET_INFOSTAT:
+            cxl_cci_cmd_set_info_and_status_parse(s, msg);
+            break;
+        }
+        break;
+    }
+    s->pos = 0;
+
+    i2c_mctp_schedule_send(mctp);
+}
+
+static void i2c_mctp_cxl_realize(DeviceState *d, Error **errp)
+{
+    I2C_MCTP_CXL_State *s = I2C_MCTP_CXL(d);
+
+    /* Check this is a type we support */
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_USP)) {
+        s->type = cxl_switch;
+        return;
+    }
+
+    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
+        s->type = cxl_type3;
+        return;
+    }
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
index 298134ce85..f0c6f91abe 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -32,7 +32,8 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
-    select I2C_MCTP_CXL_FMAPI
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
index 99ee564ce8..5fba90e5b5 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -12,5 +12,6 @@ softmmu_ss.add(when: 'CONFIG_CXL',
                if_false: files(
                    'cxl-host-stubs.c',
                ))
+softmmu_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 31e1958368..9644e81254 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -45,7 +45,8 @@ config PC
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
     select VIRTIO_MEM_SUPPORTED
-    select I2C_MCTP_CXL_FMAPI
+    select MCTP_I2C
+    select I2C_MCTP_CXL
 
 config PC_PCI
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44..ce5891716b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -128,6 +128,7 @@ softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
 
 softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
+
 softmmu_ss.add(when: 'CONFIG_I2C', if_true: files('i2c-echo.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
-- 
2.39.2

