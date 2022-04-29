Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BFC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377085AbiD2Org (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358303AbiD2Orf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 10:47:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043907C17E
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 07:44:16 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqZtp410Hz67H19;
        Fri, 29 Apr 2022 22:41:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:44:14 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:44:13 +0100
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
Subject: [PATCH v10 06/45] hw/cxl/device: Implement basic mailbox (8.2.8.4)
Date:   Fri, 29 Apr 2022 15:40:31 +0100
Message-ID: <20220429144110.25167-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

This is the beginning of implementing mailbox support for CXL 2.0
devices. The implementation recognizes when the doorbell is rung,
handles the command/payload, clears the doorbell while returning error
codes and data.

Generally the mailbox mechanism is designed to permit communication
between the host OS and the firmware running on the device. For our
purposes, we emulate both the firmware, implemented primarily in
cxl-mailbox-utils.c, and the hardware.

No commands are implemented yet.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/cxl/cxl-device-utils.c   | 122 ++++++++++++++++++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 164 ++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build          |   1 +
 include/hw/cxl/cxl.h        |   3 +
 include/hw/cxl/cxl_device.h |  19 ++++-
 5 files changed, 307 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 241f9f82e3..f6c3e0f095 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -44,6 +44,108 @@ static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
     return 0;
 }
 
+static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CXLDeviceState *cxl_dstate = opaque;
+
+    switch (size) {
+    case 1:
+        return cxl_dstate->mbox_reg_state[offset];
+    case 2:
+        return cxl_dstate->mbox_reg_state16[offset / size];
+    case 4:
+        return cxl_dstate->mbox_reg_state32[offset / size];
+    case 8:
+        return cxl_dstate->mbox_reg_state64[offset / size];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void mailbox_mem_writel(uint32_t *reg_state, hwaddr offset,
+                               uint64_t value)
+{
+    switch (offset) {
+    case A_CXL_DEV_MAILBOX_CTRL:
+        /* fallthrough */
+    case A_CXL_DEV_MAILBOX_CAP:
+        /* RO register */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s Unexpected 32-bit access to 0x%" PRIx64 " (WI)\n",
+                      __func__, offset);
+        return;
+    }
+
+    reg_state[offset / sizeof(*reg_state)] = value;
+}
+
+static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
+                               uint64_t value)
+{
+    switch (offset) {
+    case A_CXL_DEV_MAILBOX_CMD:
+        break;
+    case A_CXL_DEV_BG_CMD_STS:
+        /* BG not supported */
+        /* fallthrough */
+    case A_CXL_DEV_MAILBOX_STS:
+        /* Read only register, will get updated by the state machine */
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s Unexpected 64-bit access to 0x%" PRIx64 " (WI)\n",
+                      __func__, offset);
+        return;
+    }
+
+
+    reg_state[offset / sizeof(*reg_state)] = value;
+}
+
+static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
+                              unsigned size)
+{
+    CXLDeviceState *cxl_dstate = opaque;
+
+    if (offset >= A_CXL_DEV_CMD_PAYLOAD) {
+        memcpy(cxl_dstate->mbox_reg_state + offset, &value, size);
+        return;
+    }
+
+    switch (size) {
+    case 4:
+        mailbox_mem_writel(cxl_dstate->mbox_reg_state32, offset, value);
+        break;
+    case 8:
+        mailbox_mem_writeq(cxl_dstate->mbox_reg_state64, offset, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
+                         DOORBELL)) {
+        cxl_process_mailbox(cxl_dstate);
+    }
+}
+
+static const MemoryRegionOps mailbox_ops = {
+    .read = mailbox_reg_read,
+    .write = mailbox_reg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
 static const MemoryRegionOps dev_ops = {
     .read = dev_reg_read,
     .write = NULL, /* status register is read only */
@@ -84,20 +186,33 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                           "cap-array", CXL_CAPS_SIZE);
     memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
                           "device-status", CXL_DEVICE_STATUS_REGISTERS_LENGTH);
+    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_dstate,
+                          "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
 
     memory_region_add_subregion(&cxl_dstate->device_registers, 0,
                                 &cxl_dstate->caps);
     memory_region_add_subregion(&cxl_dstate->device_registers,
                                 CXL_DEVICE_STATUS_REGISTERS_OFFSET,
                                 &cxl_dstate->device);
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_MAILBOX_REGISTERS_OFFSET,
+                                &cxl_dstate->mailbox);
 }
 
 static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
 
+static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    /* 2048 payload size, with no interrupt or background support */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
+    cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
+}
+
 void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 {
     uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
-    const int cap_count = 1;
+    const int cap_count = 2;
 
     /* CXL Device Capabilities Array Register */
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
@@ -106,4 +221,9 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 
     cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1);
     device_reg_init_common(cxl_dstate);
+
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
+    mailbox_reg_init_common(cxl_dstate);
+
+    assert(cxl_initialize_mailbox(cxl_dstate) == 0);
 }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
new file mode 100644
index 0000000000..2557f41f61
--- /dev/null
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -0,0 +1,164 @@
+/*
+ * CXL Utility library for mailbox interface
+ *
+ * Copyright(C) 2020 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cxl/cxl.h"
+#include "hw/pci/pci.h"
+#include "qemu/log.h"
+#include "qemu/uuid.h"
+
+/*
+ * How to add a new command, example. The command set FOO, with cmd BAR.
+ *  1. Add the command set and cmd to the enum.
+ *     FOO    = 0x7f,
+ *          #define BAR 0
+ *  2. Implement the handler
+ *    static ret_code cmd_foo_bar(struct cxl_cmd *cmd,
+ *                                  CXLDeviceState *cxl_dstate, uint16_t *len)
+ *  3. Add the command to the cxl_cmd_set[][]
+ *    [FOO][BAR] = { "FOO_BAR", cmd_foo_bar, x, y },
+ *  4. Implement your handler
+ *     define_mailbox_handler(FOO_BAR) { ... return CXL_MBOX_SUCCESS; }
+ *
+ *
+ *  Writing the handler:
+ *    The handler will provide the &struct cxl_cmd, the &CXLDeviceState, and the
+ *    in/out length of the payload. The handler is responsible for consuming the
+ *    payload from cmd->payload and operating upon it as necessary. It must then
+ *    fill the output data into cmd->payload (overwriting what was there),
+ *    setting the length, and returning a valid return code.
+ *
+ *  XXX: The handler need not worry about endianess. The payload is read out of
+ *  a register interface that already deals with it.
+ */
+
+/* 8.2.8.4.5.1 Command Return Codes */
+typedef enum {
+    CXL_MBOX_SUCCESS = 0x0,
+    CXL_MBOX_BG_STARTED = 0x1,
+    CXL_MBOX_INVALID_INPUT = 0x2,
+    CXL_MBOX_UNSUPPORTED = 0x3,
+    CXL_MBOX_INTERNAL_ERROR = 0x4,
+    CXL_MBOX_RETRY_REQUIRED = 0x5,
+    CXL_MBOX_BUSY = 0x6,
+    CXL_MBOX_MEDIA_DISABLED = 0x7,
+    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
+    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
+    CXL_MBOX_FW_AUTH_FAILED = 0xa,
+    CXL_MBOX_FW_INVALID_SLOT = 0xb,
+    CXL_MBOX_FW_ROLLEDBACK = 0xc,
+    CXL_MBOX_FW_REST_REQD = 0xd,
+    CXL_MBOX_INVALID_HANDLE = 0xe,
+    CXL_MBOX_INVALID_PA = 0xf,
+    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
+    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
+    CXL_MBOX_ABORTED = 0x12,
+    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
+    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
+    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
+    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
+    CXL_MBOX_MAX = 0x17
+} ret_code;
+
+struct cxl_cmd;
+typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate, uint16_t *len);
+struct cxl_cmd {
+    const char *name;
+    opcode_handler handler;
+    ssize_t in;
+    uint16_t effect; /* Reported in CEL */
+    uint8_t *payload;
+};
+
+#define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
+    uint16_t __zero##name = size;                                         \
+    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
+                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    {                                                                     \
+        *len = __zero##name;                                              \
+        memset(cmd->payload, 0, *len);                                    \
+        return CXL_MBOX_SUCCESS;                                          \
+    }
+#define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
+    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
+                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    {                                                                     \
+        return CXL_MBOX_SUCCESS;                                          \
+    }
+
+static QemuUUID cel_uuid;
+
+static struct cxl_cmd cxl_cmd_set[256][256] = {};
+
+void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
+{
+    uint16_t ret = CXL_MBOX_SUCCESS;
+    struct cxl_cmd *cxl_cmd;
+    uint64_t status_reg;
+    opcode_handler h;
+    uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
+
+    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
+    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
+    uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+    cxl_cmd = &cxl_cmd_set[set][cmd];
+    h = cxl_cmd->handler;
+    if (h) {
+        if (len == cxl_cmd->in) {
+            cxl_cmd->payload = cxl_dstate->mbox_reg_state +
+                A_CXL_DEV_CMD_PAYLOAD;
+            ret = (*h)(cxl_cmd, cxl_dstate, &len);
+            assert(len <= cxl_dstate->payload_size);
+        } else {
+            ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
+                      set << 8 | cmd);
+        ret = CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Set the return code */
+    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
+
+    /* Set the return length */
+    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
+    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
+    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len);
+
+    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
+    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+
+    /* Tell the host we're done */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
+                     DOORBELL, 0);
+}
+
+int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
+{
+    /* CXL 2.0: Table 169 Get Supported Logs Log Entry */
+    const char *cel_uuidstr = "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";
+
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmd_set[set][cmd].handler) {
+                struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+                struct cel_log *log =
+                    &cxl_dstate->cel_log[cxl_dstate->cel_size];
+
+                log->opcode = (set << 8) | cmd;
+                log->effect = c->effect;
+                cxl_dstate->cel_size++;
+            }
+        }
+    }
+
+    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index dd7c6f8e5a..e68eea2358 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -2,4 +2,5 @@ softmmu_ss.add(when: 'CONFIG_CXL',
                if_true: files(
                    'cxl-component-utils.c',
                    'cxl-device-utils.c',
+                   'cxl-mailbox-utils.c',
                ))
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b9d1ac3fad..554ad93b6b 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -14,4 +14,7 @@
 #include "cxl_component.h"
 #include "cxl_device.h"
 
+#define CXL_COMPONENT_REG_BAR_IDX 0
+#define CXL_DEVICE_REG_BAR_IDX 2
+
 #endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 599c887616..35489f635a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -90,7 +90,21 @@ typedef struct cxl_device_state {
     };
 
     /* mmio for the mailbox registers 8.2.8.4 */
-    MemoryRegion mailbox;
+    struct {
+        MemoryRegion mailbox;
+        uint16_t payload_size;
+        union {
+            uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
+            uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
+            uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
+            uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
+        };
+        struct cel_log {
+            uint16_t opcode;
+            uint16_t effect;
+        } cel_log[1 << 16];
+        size_t cel_size;
+    };
 
     /* memory region for persistent memory, HDM */
     uint64_t pmem_size;
@@ -140,6 +154,9 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE_STATUS, CXL_DEVICE_CAP_HDR1_OFFSET)
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
                                                CXL_DEVICE_CAP_REG_SIZE)
 
+int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
+void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
+
 #define cxl_device_cap_init(dstate, reg, cap_id)                           \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
-- 
2.32.0

