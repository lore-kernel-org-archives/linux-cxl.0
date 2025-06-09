Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB743A1B6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486883; cv=none; b=RdKVREhTqH8V45YMm0X8k8lM8C3rCn25Yhibu8zuOxskT/RDR1ZHNZrB04lEyt1VpXDHxuZI/dqsnlgppazVRqjN8JWbP89QNMRX5HQixD4dUEORXymBJUKLMdnF//BiCGlt56nFu6guH7mraUajCqAp/EyRR6PMxdDOnHbAQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486883; c=relaxed/simple;
	bh=cXjeh+jNyxteyH06KEfk3raY9CpXdvQLk0hYMsiDyy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2d4VjPno3Pw8GFjyZYdCrFKeGBmCfdE4sjXhuxKv01/jOWusB0TQSdYDb6IHXUm5qnlWNelkwB6bWqkbjizsNB6oivMjMTfs3Y3x8fZ31hoO/d735Vs8KPV38gYnwhZZfhLI+f9vLJ7I1QRGN84PcxsZgusspr4ubgrw6PB+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGHTY58rfz6L5QM;
	Tue, 10 Jun 2025 00:30:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 30D7514020C;
	Tue, 10 Jun 2025 00:34:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Jun 2025 18:34:37 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Klaus Jensen <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [RFC PATCH qemu 2/5] hw/i2c: add mctp core
Date: Mon, 9 Jun 2025 17:33:30 +0100
Message-ID: <20250609163334.922346-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Klaus Jensen <k.jensen@samsung.com>

Add an abstract MCTP over I2C endpoint model. This implements MCTP
control message handling as well as handling the actual I2C transport
(packetization).

Devices are intended to derive from this and implement the class
methods.

Parts of this implementation is inspired by code[1] previously posted by
Jonathan Cameron.

Squashed a fix[2] from Matt Johnston.

  [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
  [2]: https://lore.kernel.org/qemu-devel/20221121080445.GA29062@codeconstruct.com.au/

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Link: https://lore.kernel.org/r/20230914-nmi-i2c-v6-2-11bbb4f74d18@samsung.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS           |   7 +
 include/hw/i2c/mctp.h | 125 ++++++++++++
 include/net/mctp.h    |  35 ++++
 hw/i2c/mctp.c         | 431 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig        |   1 +
 hw/i2c/Kconfig        |   4 +
 hw/i2c/meson.build    |   1 +
 hw/i2c/trace-events   |  14 ++
 8 files changed, 618 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6763077e..4ad35a1aa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3782,6 +3782,13 @@ F: include/hw/fsi/*
 F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
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
index 0000000000..10c3fb9048
--- /dev/null
+++ b/include/hw/i2c/mctp.h
@@ -0,0 +1,125 @@
+#ifndef QEMU_I2C_MCTP_H
+#define QEMU_I2C_MCTP_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
+OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_ENDPOINT)
+
+struct MCTPI2CEndpointClass {
+    I2CSlaveClass parent_class;
+
+    /**
+     * put_buf() - receive incoming message fragment
+     *
+     * Return 0 for success or negative for error.
+     */
+    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
+
+    /**
+     * get_buf() - provide pointer to message fragment
+     *
+     * Called by the mctp subsystem to request a pointer to the next message
+     * fragment. Subsequent calls MUST return next fragment (if any).
+     *
+     * Must return the number of bytes in message fragment.
+     */
+    size_t (*get_buf)(MCTPI2CEndpoint *mctp, const uint8_t **buf,
+                      size_t maxlen, uint8_t *mctp_flags);
+
+    /**
+     * handle() - handle an MCTP message
+     *
+     * Called by the mctp subsystem when a full message has been delivered and
+     * may be parsed and processed.
+     */
+    void (*handle)(MCTPI2CEndpoint *mctp);
+
+    /**
+     * reset() - reset internal state
+     *
+     * Called by the mctp subsystem in the event of some transport error.
+     * Implementation must reset its internal state and drop any fragments
+     * previously receieved.
+     */
+    void (*reset)(MCTPI2CEndpoint *mctp);
+
+    /**
+     * get_types() - provide supported mctp message types
+     *
+     * Must provide a buffer with a full MCTP supported message types payload
+     * (i.e. `0x0(SUCCESS),0x1(COUNT),0x4(NMI)`).
+     *
+     * Returns the size of the response.
+     */
+    size_t (*get_types)(MCTPI2CEndpoint *mctp, const uint8_t **data);
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
+ * Header and the 1 byte MCTP/I2C piggy-backed source address).
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
+    uint8_t buffer[I2C_MCTP_MAX_LENGTH];
+    uint64_t pos;
+    size_t len;
+
+    struct {
+        MCTPTxState state;
+        bool is_control;
+
+        uint8_t eid;
+        uint8_t addr;
+        uint8_t pktseq;
+        uint8_t tag;
+
+        QEMUBH *bh;
+    } tx;
+} MCTPI2CEndpoint;
+
+void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp);
+
+#endif /* QEMU_I2C_MCTP_H */
diff --git a/include/net/mctp.h b/include/net/mctp.h
new file mode 100644
index 0000000000..5d26d855db
--- /dev/null
+++ b/include/net/mctp.h
@@ -0,0 +1,35 @@
+#ifndef QEMU_MCTP_H
+#define QEMU_MCTP_H
+
+#include "hw/registerfields.h"
+
+/* DSP0236 1.3.0, Section 8.3.1 */
+#define MCTP_BASELINE_MTU 64
+
+/* DSP0236 1.3.0, Table 1, Message body */
+FIELD(MCTP_MESSAGE_H, TYPE, 0, 7)
+FIELD(MCTP_MESSAGE_H, IC,   7, 1)
+
+/* DSP0236 1.3.0, Table 1, MCTP transport header */
+FIELD(MCTP_H_FLAGS, TAG,    0, 3);
+FIELD(MCTP_H_FLAGS, TO,     3, 1);
+FIELD(MCTP_H_FLAGS, PKTSEQ, 4, 2);
+FIELD(MCTP_H_FLAGS, EOM,    6, 1);
+FIELD(MCTP_H_FLAGS, SOM,    7, 1);
+
+/* DSP0236 1.3.0, Figure 4 */
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
+#endif /* QEMU_MCTP_H */
diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
new file mode 100644
index 0000000000..cf45a46706
--- /dev/null
+++ b/hw/i2c/mctp.c
@@ -0,0 +1,431 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPDX-FileCopyrightText: Copyright (c) 2023 Samsung Electronics Co., Ltd.
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
+#include "net/mctp.h"
+
+#include "trace.h"
+
+/* DSP0237 1.2.0, Figure 1 */
+typedef struct MCTPI2CPacketHeader {
+    uint8_t dest;
+#define MCTP_I2C_COMMAND_CODE 0xf
+    uint8_t command_code;
+    uint8_t byte_count;
+    uint8_t source;
+} MCTPI2CPacketHeader;
+
+typedef struct MCTPI2CPacket {
+    MCTPI2CPacketHeader i2c;
+    MCTPPacket          mctp;
+} MCTPI2CPacket;
+
+#define i2c_mctp_payload_offset offsetof(MCTPI2CPacket, mctp.payload)
+#define i2c_mctp_payload(buf) (buf + i2c_mctp_payload_offset)
+
+/* DSP0236 1.3.0, Figure 20 */
+typedef struct MCTPControlMessage {
+#define MCTP_MESSAGE_TYPE_CONTROL 0x0
+    uint8_t type;
+#define MCTP_CONTROL_FLAGS_RQ               (1 << 7)
+#define MCTP_CONTROL_FLAGS_D                (1 << 6)
+    uint8_t flags;
+    uint8_t command_code;
+    uint8_t data[];
+} MCTPControlMessage;
+
+enum MCTPControlCommandCodes {
+    MCTP_CONTROL_SET_EID                    = 0x01,
+    MCTP_CONTROL_GET_EID                    = 0x02,
+    MCTP_CONTROL_GET_VERSION                = 0x04,
+    MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT   = 0x05,
+};
+
+#define MCTP_CONTROL_ERROR_UNSUPPORTED_CMD 0x5
+
+#define i2c_mctp_control_data_offset \
+    (i2c_mctp_payload_offset + offsetof(MCTPControlMessage, data))
+#define i2c_mctp_control_data(buf) (buf + i2c_mctp_control_data_offset)
+
+/**
+ * The byte count field in the SMBUS Block Write containers the number of bytes
+ * *following* the field itself.
+ *
+ * This is at least 5.
+ *
+ * 1 byte for the MCTP/I2C piggy-backed I2C source address in addition to the
+ * size of the MCTP transport/packet header.
+ */
+#define MCTP_I2C_BYTE_COUNT_OFFSET (sizeof(MCTPPacketHeader) + 1)
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
+            /* packet payload is already in buffer; max 1 packet */
+            flags = FIELD_DP8(flags, MCTP_H_FLAGS, SOM, 1);
+            flags = FIELD_DP8(flags, MCTP_H_FLAGS, EOM, 1);
+        } else {
+            const uint8_t *payload;
+
+            /* get message bytes from derived device */
+            mctp->len = mc->get_buf(mctp, &payload, I2C_MCTP_MAXMTU, &flags);
+            assert(mctp->len <= I2C_MCTP_MAXMTU);
+
+            memcpy(pkt->mctp.payload, payload, mctp->len);
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
+            .dest = mctp->tx.addr << 1,
+            .command_code = MCTP_I2C_COMMAND_CODE,
+            .byte_count = MCTP_I2C_BYTE_COUNT_OFFSET + mctp->len,
+
+            /* DSP0237 1.2.0, Figure 1 */
+            .source = slave->address << 1 | 0x1,
+        };
+
+        pkt->mctp.hdr = (MCTPPacketHeader) {
+            .version = 0x1,
+            .eid.dest = mctp->tx.eid,
+            .eid.source = mctp->my_eid,
+            .flags = flags,
+        };
+
+        pkt->mctp.hdr.flags = FIELD_DP8(pkt->mctp.hdr.flags, MCTP_H_FLAGS,
+                                        PKTSEQ, mctp->tx.pktseq++);
+        pkt->mctp.hdr.flags = FIELD_DP8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, TAG,
+                                        mctp->tx.tag);
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
+static void i2c_mctp_set_control_data(MCTPI2CEndpoint *mctp, const void * buf,
+                                      size_t len)
+{
+    assert(i2c_mctp_control_data_offset < I2C_MCTP_MAX_LENGTH - len);
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, len);
+
+    assert(mctp->len < I2C_MCTP_MAX_LENGTH - len);
+    mctp->len += len;
+}
+
+static void i2c_mctp_handle_control_set_eid(MCTPI2CEndpoint *mctp, uint8_t eid)
+{
+    mctp->my_eid = eid;
+
+    uint8_t buf[] = {
+        0x0, 0x0, eid, 0x0,
+    };
+
+    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
+}
+
+static void i2c_mctp_handle_control_get_eid(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, mctp->my_eid, 0x0, 0x0,
+    };
+
+    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
+}
+
+static void i2c_mctp_handle_control_get_version(MCTPI2CEndpoint *mctp)
+{
+    uint8_t buf[] = {
+        0x0, 0x1, 0x0, 0x1, 0x3, 0x1,
+    };
+
+    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
+}
+
+static void i2c_mctp_handle_get_message_type_support(MCTPI2CEndpoint *mctp)
+{
+    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
+    const uint8_t *types;
+    size_t len;
+
+    len = mc->get_types(mctp, &types);
+    assert(mctp->len <= MCTP_BASELINE_MTU - len);
+
+    i2c_mctp_set_control_data(mctp, types, len);
+}
+
+static void i2c_mctp_handle_control(MCTPI2CEndpoint *mctp)
+{
+    MCTPControlMessage *msg = (MCTPControlMessage *)i2c_mctp_payload(mctp->buffer);
+
+    /* clear Rq/D */
+    msg->flags &= ~(MCTP_CONTROL_FLAGS_RQ | MCTP_CONTROL_FLAGS_D);
+
+    mctp->len = sizeof(MCTPControlMessage);
+
+    trace_i2c_mctp_handle_control(msg->command_code);
+
+    switch (msg->command_code) {
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
+        i2c_mctp_handle_get_message_type_support(mctp);
+        break;
+
+    default:
+        trace_i2c_mctp_unhandled_control(msg->command_code);
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
+    uint8_t pec, pktseq, msgtype;
+    int ret;
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
+            trace_i2c_mctp_drop_short_packet(mctp->len);
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
+        if (!(pkt->mctp.hdr.eid.dest == mctp->my_eid ||
+              pkt->mctp.hdr.eid.dest == 0)) {
+            trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
+                                            mctp->my_eid);
+            goto drop;
+        }
+
+        pktseq = FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, PKTSEQ);
+
+        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, SOM)) {
+            mctp->tx.is_control = false;
+
+            if (mctp->state == I2C_MCTP_STATE_RX) {
+                mc->reset(mctp);
+            }
+
+            mctp->state = I2C_MCTP_STATE_RX;
+
+            mctp->tx.addr = pkt->i2c.source >> 1;
+            mctp->tx.eid = pkt->mctp.hdr.eid.source;
+            mctp->tx.tag = FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, TAG);
+            mctp->tx.pktseq = pktseq;
+
+            msgtype = FIELD_EX8(pkt->mctp.payload[0], MCTP_MESSAGE_H, TYPE);
+
+            if (msgtype == MCTP_MESSAGE_TYPE_CONTROL) {
+                mctp->tx.is_control = true;
+
+                i2c_mctp_handle_control(mctp);
+
+                return 0;
+            }
+        } else if (mctp->state == I2C_MCTP_STATE_RX_STARTED) {
+            trace_i2c_mctp_drop_expected_som();
+            goto drop;
+        } else if (pktseq != (++mctp->tx.pktseq & 0x3)) {
+            trace_i2c_mctp_drop_invalid_pktseq(pktseq, mctp->tx.pktseq & 0x3);
+            goto drop;
+        }
+
+        ret = mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
+        if (ret < 0) {
+            goto drop;
+        }
+
+        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, EOM)) {
+            mc->handle(mctp);
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
+    mc->reset(mctp);
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
+static const Property mctp_i2c_props[] = {
+    DEFINE_PROP_UINT8("eid", MCTPI2CEndpoint, my_eid, 0x9),
+};
+
+static void i2c_mctp_class_init(ObjectClass *oc, const void *data)
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..d12f575c8d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -530,6 +530,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select I2C_MCTP
     select DPS310
     select PCA9552
     select SERIAL_MM
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 596a7a3165..794cccc053 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -6,6 +6,10 @@ config I2C_DEVICES
     # to any board's i2c bus
     bool
 
+config I2C_MCTP
+    bool
+    select I2C
+
 config SMBUS
     bool
     select I2C
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..a86457e610 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -1,5 +1,6 @@
 i2c_ss = ss.source_set()
 i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
+i2c_ss.add(when: 'CONFIG_I2C_MCTP', if_true: files('mctp.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 1ad0e95c0e..da78fa327f 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -61,3 +61,17 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
 
 imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
 imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
+
+# mctp.c
+
+i2c_mctp_tx_start_send(size_t len) "len %zu"
+i2c_mctp_tx_send_byte(size_t pos, uint8_t byte) "pos %zu byte 0x%"PRIx8""
+i2c_mctp_tx_done(void) "packet sent"
+i2c_mctp_handle_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_unhandled_control(uint8_t command) "command 0x%"PRIx8""
+i2c_mctp_drop_invalid_length(unsigned byte_count, size_t expected) "byte_count %u expected %zu"
+i2c_mctp_drop_invalid_pec(uint8_t pec, uint8_t expected) "pec 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_eid(uint8_t eid, uint8_t expected) "eid 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_invalid_pktseq(uint8_t pktseq, uint8_t expected) "pktseq 0x%"PRIx8" expected 0x%"PRIx8""
+i2c_mctp_drop_short_packet(size_t len) "len %zu"
+i2c_mctp_drop_expected_som(void) ""
-- 
2.48.1

