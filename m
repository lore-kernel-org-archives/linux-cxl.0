Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC39C433DB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CB364ED7
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBBBAx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:00:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:21901 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBAx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:00:53 -0500
IronPort-SDR: LFEvGWLxlog9Xyg5SqsqXLwWeWpmWvMhFxR2BKqtVkiqdWCebEkdXP5whJvcCL4RvVnjP2Fhry
 pHAZ6X2JtT5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294600"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:57 -0800
IronPort-SDR: iBBfz+pcKucWJNRI1+lm3P5UU2TShZ24qGllhR0/lM7uXjMxiIaP1PnK+THCDwwviclJYzRzPO
 bSdYohOK03bQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764060"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 04/31] hw/cxl/device: Implement the CAP array (8.2.8.1-2)
Date:   Mon,  1 Feb 2021 16:59:21 -0800
Message-Id: <20210202005948.241655-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This implements all device MMIO up to the first capability. That
includes the CXL Device Capabilities Array Register, as well as all of
the CXL Device Capability Header Registers. The latter are filled in as
they are implemented in the following patches.

Endianness and alignment are managed by softmmu memory core.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-device-utils.c   | 105 ++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build          |   1 +
 include/hw/cxl/cxl_device.h |  27 +++++++++-
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 hw/cxl/cxl-device-utils.c

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
new file mode 100644
index 0000000000..bb15ad9a0f
--- /dev/null
+++ b/hw/cxl/cxl-device-utils.c
@@ -0,0 +1,105 @@
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
+ *   • A 32 bit register shall   be accessed as a 1 Byte, 2 Bytes or 4 Bytes
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
+    return cxl_dstate->caps_reg_state32[offset / 4];
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
+        .max_access_size = 4,
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
+                          "cap-array", CXL_DEVICE_REGISTERS_OFFSET - 0);
+    memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
+                          "device-status", CXL_DEVICE_REGISTERS_LENGTH);
+
+    memory_region_add_subregion(&cxl_dstate->device_registers, 0,
+                                &cxl_dstate->caps);
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_DEVICE_REGISTERS_OFFSET,
+                                &cxl_dstate->device);
+}
+
+static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
+
+void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint32_t *cap_hdrs = cxl_dstate->caps_reg_state32;
+    const int cap_count = 1;
+
+    /* CXL Device Capabilities Array Register */
+    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
+    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
+    ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY2, CAP_COUNT, cap_count);
+
+    cxl_device_cap_init(cxl_dstate, DEVICE, 1);
+    device_reg_init_common(cxl_dstate);
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 00c3876a0f..47154d6850 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -1,3 +1,4 @@
 softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
   'cxl-component-utils.c',
+  'cxl-device-utils.c',
 ))
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a85f250503..f3bcf19410 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -58,6 +58,8 @@
 #define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
 #define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
 #define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
+#define CXL_CAPS_SIZE \
+    (CXL_DEVICE_CAP_REG_SIZE * CXL_DEVICE_CAPS_MAX + 1) /* +1 for header */
 
 #define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
 #define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
@@ -70,11 +72,18 @@
 #define CXL_MAILBOX_REGISTERS_LENGTH \
     (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
 
+#define CXL_MMIO_SIZE                                       \
+    CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH + \
+        CXL_MAILBOX_REGISTERS_LENGTH
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
-    MemoryRegion caps;
+    struct {
+        MemoryRegion caps;
+        uint32_t caps_reg_state32[CXL_CAPS_SIZE / 4];
+    };
 
     /* mmio for the device status registers 8.2.8.3 */
     MemoryRegion device;
@@ -126,6 +135,22 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
                                                CXL_DEVICE_CAP_REG_SIZE)
 
+#define cxl_device_cap_init(dstate, reg, cap_id)                                   \
+    do {                                                                           \
+        uint32_t *cap_hdrs = dstate->caps_reg_state32;                             \
+        int which = R_CXL_DEV_##reg##_CAP_HDR0;                                    \
+        cap_hdrs[which] =                                                          \
+            FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_ID, cap_id); \
+        cap_hdrs[which] = FIELD_DP32(                                              \
+            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);            \
+        cap_hdrs[which + 1] =                                                      \
+            FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,              \
+                       CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);                  \
+        cap_hdrs[which + 2] =                                                      \
+            FIELD_DP32(cap_hdrs[which + 2], CXL_DEV_##reg##_CAP_HDR2,              \
+                       CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);                  \
+    } while (0)
+
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
     FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
-- 
2.30.0

