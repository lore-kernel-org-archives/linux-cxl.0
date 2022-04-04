Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581C1C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359409AbiDDPTJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378487AbiDDPTH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:19:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BD28E34
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:17:10 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDqM33Cqz67J5F;
        Mon,  4 Apr 2022 23:15:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:17:08 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:17:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 05/45] hw/cxl/device: Implement the CAP array (8.2.8.1-2)
Date:   Mon, 4 Apr 2022 16:14:05 +0100
Message-ID: <20220404151445.10955-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

This implements all device MMIO up to the first capability. That
includes the CXL Device Capabilities Array Register, as well as all of
the CXL Device Capability Header Registers. The latter are filled in as
they are implemented in the following patches.

Endianness and alignment are managed by softmmu memory core.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/cxl/cxl-device-utils.c   | 109 ++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build          |   1 +
 include/hw/cxl/cxl_device.h |  31 +++++++++-
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
new file mode 100644
index 0000000000..241f9f82e3
--- /dev/null
+++ b/hw/cxl/cxl-device-utils.c
@@ -0,0 +1,109 @@
+/*
+ * CXL Utility library for devices
+ *
+ * Copyright(C) 2020 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/cxl/cxl.h"
+
+/*
+ * Device registers have no restrictions per the spec, and so fall back to the
+ * default memory mapped register rules in 8.2:
+ *   Software shall use CXL.io Memory Read and Write to access memory mapped
+ *   register defined in this section. Unless otherwise specified, software
+ *   shall restrict the accesses width based on the following:
+ *   • A 32 bit register shall be accessed as a 1 Byte, 2 Bytes or 4 Bytes
+ *     quantity.
+ *   • A 64 bit register shall be accessed as a 1 Byte, 2 Bytes, 4 Bytes or 8
+ *     Bytes
+ *   • The address shall be a multiple of the access width, e.g. when
+ *     accessing a register as a 4 Byte quantity, the address shall be
+ *     multiple of 4.
+ *   • The accesses shall map to contiguous bytes.If these rules are not
+ *     followed, the behavior is undefined
+ */
+
+static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CXLDeviceState *cxl_dstate = opaque;
+
+    if (size == 4) {
+        return cxl_dstate->caps_reg_state32[offset / sizeof(*cxl_dstate->caps_reg_state32)];
+    } else {
+        return cxl_dstate->caps_reg_state64[offset / sizeof(*cxl_dstate->caps_reg_state64)];
+    }
+}
+
+static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps dev_ops = {
+    .read = dev_reg_read,
+    .write = NULL, /* status register is read only */
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
+static const MemoryRegionOps caps_ops = {
+    .read = caps_reg_read,
+    .write = NULL, /* caps registers are read only */
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
+{
+    /* This will be a BAR, so needs to be rounded up to pow2 for PCI spec */
+    memory_region_init(&cxl_dstate->device_registers, obj, "device-registers",
+                       pow2ceil(CXL_MMIO_SIZE));
+
+    memory_region_init_io(&cxl_dstate->caps, obj, &caps_ops, cxl_dstate,
+                          "cap-array", CXL_CAPS_SIZE);
+    memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
+                          "device-status", CXL_DEVICE_STATUS_REGISTERS_LENGTH);
+
+    memory_region_add_subregion(&cxl_dstate->device_registers, 0,
+                                &cxl_dstate->caps);
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_DEVICE_STATUS_REGISTERS_OFFSET,
+                                &cxl_dstate->device);
+}
+
+static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
+
+void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
+    const int cap_count = 1;
+
+    /* CXL Device Capabilities Array Register */
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
+    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
+
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1);
+    device_reg_init_common(cxl_dstate);
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 3231b5de1e..dd7c6f8e5a 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -1,4 +1,5 @@
 softmmu_ss.add(when: 'CONFIG_CXL',
                if_true: files(
                    'cxl-component-utils.c',
+                   'cxl-device-utils.c',
                ))
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9513aaac77..599c887616 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -58,6 +58,8 @@
 #define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
 #define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
 #define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
+#define CXL_CAPS_SIZE \
+    (CXL_DEVICE_CAP_REG_SIZE * (CXL_DEVICE_CAPS_MAX + 1)) /* +1 for header */
 
 #define CXL_DEVICE_STATUS_REGISTERS_OFFSET 0x80 /* Read comment above */
 #define CXL_DEVICE_STATUS_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
@@ -70,12 +72,22 @@
 #define CXL_MAILBOX_REGISTERS_LENGTH \
     (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
 
+#define CXL_MMIO_SIZE                                           \
+    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH + \
+     CXL_MAILBOX_REGISTERS_LENGTH)
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
     MemoryRegion device;
-    MemoryRegion caps;
+    struct {
+        MemoryRegion caps;
+        union {
+            uint32_t caps_reg_state32[CXL_CAPS_SIZE / 4];
+            uint64_t caps_reg_state64[CXL_CAPS_SIZE / 8];
+        };
+    };
 
     /* mmio for the mailbox registers 8.2.8.4 */
     MemoryRegion mailbox;
@@ -128,6 +140,23 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE_STATUS, CXL_DEVICE_CAP_HDR1_OFFSET)
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
                                                CXL_DEVICE_CAP_REG_SIZE)
 
+#define cxl_device_cap_init(dstate, reg, cap_id)                           \
+    do {                                                                   \
+        uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
+        int which = R_CXL_DEV_##reg##_CAP_HDR0;                            \
+        cap_hdrs[which] =                                                  \
+            FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0,          \
+                       CAP_ID, cap_id);                                    \
+        cap_hdrs[which] = FIELD_DP32(                                      \
+            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);    \
+        cap_hdrs[which + 1] =                                              \
+            FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,      \
+                       CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);          \
+        cap_hdrs[which + 2] =                                              \
+            FIELD_DP32(cap_hdrs[which + 2], CXL_DEV_##reg##_CAP_HDR2,      \
+                       CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);          \
+    } while (0)
+
 /* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
-- 
2.32.0

