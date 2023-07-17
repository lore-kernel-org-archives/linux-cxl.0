Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE1EEB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQRUy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGQRUx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:20:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB3D8
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:20:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TKn6nPGz67T1b;
        Tue, 18 Jul 2023 01:17:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:20:48 +0100
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
Subject: [RFC PATCH 08/17] hw/i2c: add mctp core
Date:   Mon, 17 Jul 2023 18:16:37 +0100
Message-ID: <20230717171646.8972-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

Add an abstract MCTP over I2C endpoint model. This implements MCTP
control message handling as well as handling the actual I2C transport
(packetization).

Devices are intended to derive from this and implement the class
methods.

Parts of this implementation is inspired by code[1] previously posted by
Jonathan Cameron.

  [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS                   |   7 +
 include/hw/i2c/mctp.h         | 114 +++++++++++
 include/hw/i2c/smbus_master.h |   3 +
 include/net/mctp.h            |  43 +++++
 hw/i2c/mctp.c                 | 352 ++++++++++++++++++++++++++++++++++
 hw/i2c/smbus_master.c         |  28 +++
 hw/arm/Kconfig                |   1 +
 hw/i2c/Kconfig                |   4 +
 hw/i2c/meson.build            |   1 +
 hw/i2c/trace-events           |  12 ++
 10 files changed, 565 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12e59b6b27..02a5bce814 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3386,6 +3386,13 @@ F: tests/qtest/adm1272-test.c
 F: tests/qtest/max34451-test.c
 F: tests/qtest/isl_pmbus_vr-test.c
 
+MCTP I2C Transport
+M: Klaus Jensen <k.jensen@samsung.com>
+S: Maintained
+F: hw/i2c/mctp.c
+F: include/hw/i2c/mctp.h
+F: include/net/mctp.h
+
 Firmware schema specifications
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
new file mode 100644
index 0000000000..c53ee6a3b6
--- /dev/null
+++ b/include/hw/i2c/mctp.h
@@ -0,0 +1,114 @@
+#ifndef QEMU_I2C_MCTP_H
+#define QEMU_I2C_MCTP_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+#include "net/mctp.h"
+
+typedef struct MCTPI2CPacketHeader {
+    uint8_t dest;
+    uint8_t prot;
+    uint8_t byte_count;
+    uint8_t source;
+} MCTPI2CPacketHeader;
+
+typedef struct MCTPI2CPacket {
+    MCTPI2CPacketHeader i2c;
+    MCTPPacket          mctp;
+} MCTPI2CPacket;
+
+#define i2c_mctp_payload(buf) (buf + offsetof(MCTPI2CPacket, mctp.payload))
+
+#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
+OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_ENDPOINT)
+
+struct MCTPI2CEndpointClass {
+    I2CSlaveClass parent_class;
+
+    int (*put_message_bytes)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
+    size_t (*get_message_bytes)(MCTPI2CEndpoint *mctp, uint8_t *buf,
+                                size_t maxlen, uint8_t *mctp_flags);
+
+    void (*handle_message)(MCTPI2CEndpoint *mctp);
+    void (*reset_message)(MCTPI2CEndpoint *mctp);
+
+    size_t (*get_message_types)(MCTPI2CEndpoint *mctp, uint8_t *data,
+                                size_t maxlen);
+};
+
+/*
+ * Maximum value of the SMBus Block Write "Byte Count" field (8 bits).
+ *
+ * This is the count of bytes that follow the Byte Count field and up to, but
+ * not including, the PEC byte.
+ */
+#define I2C_MCTP_MAXBLOCK 255
+
+/*
+ * Maximum Transmission Unit under I2C.
+ *
+ * This is for the MCTP Packet Payload (255, subtracting the 4 byte MCTP Packet
+ * Header or the 1 byte MCTP/I2C piggy-backed source address).
+ */
+#define I2C_MCTP_MAXMTU (I2C_MCTP_MAXBLOCK - (sizeof(MCTPPacketHeader) + 1))
+
+/*
+ * Maximum length of an MCTP/I2C packet.
+ *
+ * This is the sum of the three I2C header bytes (Destination target address,
+ * Command Code and Byte Count), the maximum number of bytes in a message (255)
+ * and the 1 byte Packet Error Code.
+ */
+#define I2C_MCTP_MAX_LENGTH (3 + I2C_MCTP_MAXBLOCK + 1)
+
+/*
+ * Maximum length of an MCTP/I2C Control Message.
+ *
+ * This is the 64 byte MCTP Baseline Maximum Transmission Unit, adding the
+ * combined MCTP/I2C headers and the trailing 1 byte PEC.
+ */
+#define I2C_MCTP_CONTROL_MAX_LENGTH \
+    (sizeof(MCTPI2CPacket) + MCTP_BASELINE_MTU + 1)
+
+typedef enum {
+    I2C_MCTP_STATE_IDLE,
+    I2C_MCTP_STATE_RX_STARTED,
+    I2C_MCTP_STATE_RX,
+    I2C_MCTP_STATE_WAIT_TX,
+    I2C_MCTP_STATE_TX,
+} MCTPState;
+
+typedef enum {
+    I2C_MCTP_STATE_TX_START_SEND,
+    I2C_MCTP_STATE_TX_SEND_BYTE,
+} MCTPTxState;
+
+typedef struct MCTPI2CEndpoint {
+    I2CSlave parent_obj;
+    I2CBus *i2c;
+
+    MCTPState state;
+
+    /* mctp endpoint identifier */
+    uint8_t my_eid;
+
+    uint8_t  buffer[I2C_MCTP_MAX_LENGTH];
+    uint64_t pos;
+    size_t   len;
+
+    struct {
+        MCTPTxState state;
+        bool is_control;
+
+        uint8_t eid;
+        uint8_t addr;
+        uint8_t pktseq;
+        uint8_t flags;
+
+        QEMUBH *bh;
+    } tx;
+} MCTPI2CEndpoint;
+
+void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp);
+
+#endif /* QEMU_I2C_MCTP_H */
diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
index bb13bc423c..ea5eff3a2c 100644
--- a/include/hw/i2c/smbus_master.h
+++ b/include/hw/i2c/smbus_master.h
@@ -27,6 +27,9 @@
 
 #include "hw/i2c/i2c.h"
 
+/* SMBus PEC */
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
 int smbus_receive_byte(I2CBus *bus, uint8_t addr);
diff --git a/include/net/mctp.h b/include/net/mctp.h
new file mode 100644
index 0000000000..c936224ecf
--- /dev/null
+++ b/include/net/mctp.h
@@ -0,0 +1,43 @@
+#ifndef QEMU_MCTP_H
+#define QEMU_MCTP_H
+
+#define MCTP_BASELINE_MTU 64
+
+enum {
+    MCTP_H_FLAGS_EOM = 1 << 6,
+    MCTP_H_FLAGS_SOM = 1 << 7,
+};
+
+enum {
+    MCTP_MESSAGE_TYPE_CONTROL   = 0x0,
+    MCTP_MESSAGE_TYPE_NMI       = 0x4,
+
+    MCTP_MESSAGE_IC             = 1 << 7,
+};
+
+typedef struct MCTPPacketHeader {
+    uint8_t version;
+    struct {
+        uint8_t dest;
+        uint8_t source;
+    } eid;
+    uint8_t flags;
+} MCTPPacketHeader;
+
+typedef struct MCTPPacket {
+    MCTPPacketHeader hdr;
+    uint8_t          payload[];
+} MCTPPacket;
+
+typedef struct MCTPControlMessage {
+    uint8_t type;
+    uint8_t flags;
+    uint8_t command;
+    uint8_t data[];
+} MCTPControlMessage;
+
+enum {
+    MCTP_CONTROL_ERROR_UNSUPPORTED_CMD = 0x5,
+};
+
+#endif /* QEMU_MCTP_H */
diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
new file mode 100644
index 0000000000..0f4045d0d6
--- /dev/null
+++ b/hw/i2c/mctp.c
@@ -0,0 +1,352 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPDX-FileCopyrightText: Copyright (c) 2022 Samsung Electronics Co., Ltd.
+ * SPDX-FileContributor: Klaus Jensen <k.jensen@samsung.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/smbus_master.h"
+#include "hw/i2c/mctp.h"
+
+#include "trace.h"
+
+void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp)
+{
+    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(DEVICE(mctp)));
+
+    mctp->tx.state = I2C_MCTP_STATE_TX_START_SEND;
+
+    i2c_bus_master(i2c, mctp->tx.bh);
+}
+
+static void i2c_mctp_tx(void *opaque)
+{
+    DeviceState *dev = DEVICE(opaque);
+    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(dev));
+    I2CSlave *slave = I2C_SLAVE(dev);
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(dev);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
+    uint8_t flags = 0;
+
+    switch (mctp->tx.state) {
+    case I2C_MCTP_STATE_TX_SEND_BYTE:
+        if (mctp->pos < mctp->len) {
+            uint8_t byte = mctp->buffer[mctp->pos];
+
+            trace_i2c_mctp_tx_send_byte(mctp->pos, byte);
+
+            /* send next byte */
+            i2c_send_async(i2c, byte);
+
+            mctp->pos++;
+
+            break;
+        }
+
+        /* packet sent */
+        i2c_end_transfer(i2c);
+
+        /* end of any control data */
+        mctp->len = 0;
+
+        /* fall through */
+
+    case I2C_MCTP_STATE_TX_START_SEND:
+        if (mctp->tx.is_control) {
+            /* packet payload is already in buffer */
+            flags |= MCTP_H_FLAGS_SOM | MCTP_H_FLAGS_EOM;
+        } else {
+            /* get message bytes from derived device */
+            mctp->len = mc->get_message_bytes(mctp, pkt->mctp.payload,
+                                              I2C_MCTP_MAXMTU, &flags);
+        }
+
+        if (!mctp->len) {
+            trace_i2c_mctp_tx_done();
+
+            /* no more packets needed; release the bus */
+            i2c_bus_release(i2c);
+
+            mctp->state = I2C_MCTP_STATE_IDLE;
+            mctp->tx.is_control = false;
+
+            break;
+        }
+
+        mctp->state = I2C_MCTP_STATE_TX;
+
+        pkt->i2c = (MCTPI2CPacketHeader) {
+            .dest = mctp->tx.addr & ~0x1,
+            .prot = 0xf,
+            .byte_count = 5 + mctp->len,
+            .source = slave->address << 1 | 0x1,
+        };
+
+        pkt->mctp.hdr = (MCTPPacketHeader) {
+            .version = 0x1,
+            .eid.dest = mctp->tx.eid,
+            .eid.source = mctp->my_eid,
+            .flags = flags | (mctp->tx.pktseq++ & 0x3) << 4 | mctp->tx.flags,
+        };
+
+        mctp->len += sizeof(MCTPI2CPacket);
+        assert(mctp->len < I2C_MCTP_MAX_LENGTH);
+
+        mctp->buffer[mctp->len] = i2c_smbus_pec(0, mctp->buffer, mctp->len);
+        mctp->len++;
+
+        trace_i2c_mctp_tx_start_send(mctp->len);
+
+        i2c_start_send_async(i2c, pkt->i2c.dest >> 1);
+
+        /* already "sent" the destination slave address */
+        mctp->pos = 1;
+
+        mctp->tx.state = I2C_MCTP_STATE_TX_SEND_BYTE;
+
+        break;
+    }
+}
+
+#define i2c_mctp_control_data(buf) \
+    (i2c_mctp_payload(buf) + offsetof(MCTPControlMessage, data))
+
+static void i2c_mctp_handle_control_set_eid(MCTPI2CEndpoint *mctp, uint8_t eid)
+{
+    mctp->my_eid = eid;
+
+    uint8_t buf[] = {
+        0x0, 0x0, eid, 0x0,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+static void i2c_mctp_handle_control_get_eid(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, mctp->my_eid, 0x0, 0x0,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+static void i2c_mctp_handle_control_get_version(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, 0x1, 0x0, 0x1, 0x3, 0x1,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}
+
+enum {
+    MCTP_CONTROL_SET_EID                    = 0x01,
+    MCTP_CONTROL_GET_EID                    = 0x02,
+    MCTP_CONTROL_GET_VERSION                = 0x04,
+    MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT   = 0x05,
+};
+
+static void i2c_mctp_handle_control(MCTPI2CEndpoint *mctp)
+{
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    MCTPControlMessage *msg = (MCTPControlMessage *)i2c_mctp_payload(mctp->buffer);
+
+    /* clear Rq/D */
+    msg->flags &= 0x1f;
+
+    mctp->len = sizeof(MCTPControlMessage);
+
+    trace_i2c_mctp_handle_control(msg->command);
+
+    switch (msg->command) {
+    case MCTP_CONTROL_SET_EID:
+        i2c_mctp_handle_control_set_eid(mctp, msg->data[1]);
+        break;
+
+    case MCTP_CONTROL_GET_EID:
+        i2c_mctp_handle_control_get_eid(mctp);
+        break;
+
+    case MCTP_CONTROL_GET_VERSION:
+        i2c_mctp_handle_control_get_version(mctp);
+        break;
+
+    case MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT:
+        mctp->len += mc->get_message_types(mctp, i2c_mctp_control_data(mctp->buffer),
+                                           MCTP_BASELINE_MTU - mctp->len);
+        break;
+
+    default:
+        trace_i2c_mctp_unhandled_control(msg->command);
+
+        msg->data[0] = MCTP_CONTROL_ERROR_UNSUPPORTED_CMD;
+        mctp->len++;
+
+        break;
+    }
+
+    assert(mctp->len <= MCTP_BASELINE_MTU);
+
+    i2c_mctp_schedule_send(mctp);
+}
+
+static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
+    size_t payload_len;
+    uint8_t pec;
+
+    switch (event) {
+    case I2C_START_SEND:
+        if (mctp->state == I2C_MCTP_STATE_IDLE) {
+            mctp->state = I2C_MCTP_STATE_RX_STARTED;
+        } else if (mctp->state != I2C_MCTP_STATE_RX) {
+            return -1;
+        }
+
+        /* the i2c core eats the slave address, so put it back in */
+        pkt->i2c.dest = i2c->address << 1;
+        mctp->len = 1;
+
+        return 0;
+
+    case I2C_FINISH:
+        if (mctp->len < sizeof(MCTPI2CPacket) + 1) {
+            trace_i2c_mctp_drop("short packet");
+            goto drop;
+        }
+
+        payload_len = mctp->len - (1 + offsetof(MCTPI2CPacket, mctp.payload));
+
+        if (pkt->i2c.byte_count + 3 != mctp->len - 1) {
+            trace_i2c_mctp_drop_invalid_length(pkt->i2c.byte_count + 3,
+                                               mctp->len - 1);
+            goto drop;
+        }
+
+        pec = i2c_smbus_pec(0, mctp->buffer, mctp->len - 1);
+        if (mctp->buffer[mctp->len - 1] != pec) {
+            trace_i2c_mctp_drop_invalid_pec(mctp->buffer[mctp->len - 1], pec);
+            goto drop;
+        }
+
+        if (pkt->mctp.hdr.eid.dest != mctp->my_eid) {
+            trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
+                                            mctp->my_eid);
+            goto drop;
+        }
+
+        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_SOM) {
+            mctp->tx.is_control = false;
+
+            if (mctp->state == I2C_MCTP_STATE_RX) {
+                mc->reset_message(mctp);
+            }
+
+            mctp->state = I2C_MCTP_STATE_RX;
+
+            mctp->tx.addr = pkt->i2c.source;
+            mctp->tx.eid = pkt->mctp.hdr.eid.source;
+            mctp->tx.flags = pkt->mctp.hdr.flags & 0x7;
+            mctp->tx.pktseq = (pkt->mctp.hdr.flags >> 4) & 0x3;
+
+            if ((pkt->mctp.payload[0] & 0x7f) == MCTP_MESSAGE_TYPE_CONTROL) {
+                mctp->tx.is_control = true;
+
+                i2c_mctp_handle_control(mctp);
+
+                return 0;
+            }
+        } else if (mctp->state == I2C_MCTP_STATE_RX_STARTED) {
+            trace_i2c_mctp_drop("expected SOM");
+            goto drop;
+        } else if (((pkt->mctp.hdr.flags >> 4) & 0x3) != (++mctp->tx.pktseq & 0x3)) {
+            trace_i2c_mctp_drop_invalid_pktseq((pkt->mctp.hdr.flags >> 4) & 0x3,
+                                               mctp->tx.pktseq & 0x3);
+            goto drop;
+        }
+
+        mc->put_message_bytes(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
+
+        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_EOM) {
+            mc->handle_message(mctp);
+            mctp->state = I2C_MCTP_STATE_WAIT_TX;
+        }
+
+        return 0;
+
+    default:
+        return -1;
+    }
+
+drop:
+    mc->reset_message(mctp);
+
+    mctp->state = I2C_MCTP_STATE_IDLE;
+
+    return 0;
+}
+
+static int i2c_mctp_send_cb(I2CSlave *i2c, uint8_t data)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
+
+    if (mctp->len < I2C_MCTP_MAX_LENGTH) {
+        mctp->buffer[mctp->len++] = data;
+        return 0;
+    }
+
+    return -1;
+}
+
+static void i2c_mctp_instance_init(Object *obj)
+{
+    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(obj);
+
+    mctp->tx.bh = qemu_bh_new(i2c_mctp_tx, mctp);
+}
+
+static Property mctp_i2c_props[] = {
+    DEFINE_PROP_UINT8("eid", MCTPI2CEndpoint, my_eid, 0x9),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void i2c_mctp_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(oc);
+
+    k->event = i2c_mctp_event_cb;
+    k->send = i2c_mctp_send_cb;
+
+    device_class_set_props(dc, mctp_i2c_props);
+}
+
+static const TypeInfo i2c_mctp_info = {
+    .name = TYPE_MCTP_I2C_ENDPOINT,
+    .parent = TYPE_I2C_SLAVE,
+    .abstract = true,
+    .instance_init = i2c_mctp_instance_init,
+    .instance_size = sizeof(MCTPI2CEndpoint),
+    .class_init = i2c_mctp_class_init,
+    .class_size = sizeof(MCTPI2CEndpointClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&i2c_mctp_info);
+}
+
+type_init(register_types)
diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
index 6a53c34e70..47f9eb24e0 100644
--- a/hw/i2c/smbus_master.c
+++ b/hw/i2c/smbus_master.c
@@ -15,6 +15,34 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_master.h"
 
+static uint8_t crc8(uint16_t data)
+{
+#define POLY (0x1070U << 3)
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        if (data & 0x8000) {
+            data = data ^ POLY;
+        }
+
+        data = data << 1;
+    }
+
+    return (uint8_t)(data >> 8);
+#undef POLY
+}
+
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
+{
+    int i;
+
+    for (i = 0; i < len; i++) {
+        crc = crc8((crc ^ buf[i]) << 8);
+    }
+
+    return crc;
+}
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 {
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e68348440..3308d9e0bd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -541,6 +541,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select MCTP_I2C
     select DPS310
     select PCA9552
     select SERIAL
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 14886b35da..3415e8421a 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -45,3 +45,7 @@ config PCA954X
 config PMBUS
     bool
     select SMBUS
+
+config MCTP_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index b58bc167db..d707ec58f7 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -1,5 +1,6 @@
 i2c_ss = ss.source_set()
 i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
+i2c_ss.add(when: 'CONFIG_MCTP_I2C', if_true: files('mctp.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 8e88aa24c1..2e3065a998 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -45,3 +45,15 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# mctp.c
+i2c_mctp_tx_start_send(size_t len) "len %zu"
+i2c_mctp_tx_send_byte(size_t pos, uint8_t byte) "pos %zu byte 0x%"PRIx8""
+i2c_mctp_tx_done(void) "packet sent"
+i2c_mctp_handle_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_unhandled_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_drop(const char *reason) "%s"
+i2c_mctp_drop_invalid_length(unsigned byte_count, size_t expected) "byte_count %u expected %zu"
+i2c_mctp_drop_invalid_pec(uint8_t pec, uint8_t expected) "pec 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_eid(uint8_t eid, uint8_t expected) "eid 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_pktseq(uint8_t pktseq, uint8_t expected) "pktseq 0x%"PRIx8" expected 0x%"PRIx8""
-- 
2.39.2

