Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE9C433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA71064EDB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBBBAv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:00:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:21898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBAv (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:00:51 -0500
IronPort-SDR: 7gzBtgulqlRWUpcfmCZPuZ5pSABmNczoCmkhXFcyI/SAx+4pCU7cRLKFm2F34zwe45brQgY98h
 TX8nzPgx72zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294598"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294598"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:56 -0800
IronPort-SDR: eprYjPG4hF3fBy0jm6V08RghzcD8Ab0d9RBbbTjE9spCO/4Na4rflnb/CvosCM+qwA4Tubs6Ag
 sy4AIGh0FHDw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764052"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:55 -0800
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
Subject: [RFC PATCH v3 03/31] hw/cxl/device: Introduce a CXL device (8.2.8)
Date:   Mon,  1 Feb 2021 16:59:20 -0800
Message-Id: <20210202005948.241655-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A CXL device is a type of CXL component. Conceptually, a CXL device
would be a leaf node in a CXL topology. From an emulation perspective,
CXL devices are the most complex and so the actual implementation is
reserved for discrete commits.

This new device type is specifically catered towards the eventual
implementation of a Type3 CXL.mem device, 8.2.8.5 in the CXL 2.0
specification.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_device.h | 155 ++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 include/hw/cxl/cxl_device.h

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 55f6cc30a5..23f52c4cf9 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -12,6 +12,7 @@
 
 #include "cxl_pci.h"
 #include "cxl_component.h"
+#include "cxl_device.h"
 
 #endif
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
new file mode 100644
index 0000000000..a85f250503
--- /dev/null
+++ b/include/hw/cxl/cxl_device.h
@@ -0,0 +1,155 @@
+/*
+ * QEMU CXL Devices
+ *
+ * Copyright (c) 2020 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_DEVICE_H
+#define CXL_DEVICE_H
+
+#include "hw/register.h"
+
+/*
+ * The following is how a CXL device's MMIO space is laid out. The only
+ * requirement from the spec is that the capabilities array and the capability
+ * headers start at offset 0 and are contiguously packed. The headers themselves
+ * provide offsets to the register fields. For this emulation, registers will
+ * start at offset 0x80 (m == 0x80). No secondary mailbox is implemented which
+ * means that n = m + sizeof(mailbox registers) + sizeof(device registers).
+ *
+ * This is roughly described in 8.2.8 Figure 138 of the CXL 2.0 spec.
+ *
+ * n + PAYLOAD_SIZE_MAX  +---------------------------------+
+ *                       |                                 |
+ *                  ^    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |         Command Payload         |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  n    +---------------------------------+
+ *                  ^    |                                 |
+ *                  |    |    Device Capability Registers  |
+ *                  |    |    x, mailbox, y                |
+ *                  |    |                                 |
+ *                  m    +---------------------------------+
+ *                  ^    |     Device Capability Header y  |
+ *                  |    +---------------------------------+
+ *                  |    | Device Capability Header Mailbox|
+ *                  |    +------------- --------------------
+ *                  |    |     Device Capability Header x  |
+ *                  |    +---------------------------------+
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |      Device Cap Array[0..n]     |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  |    |                                 |
+ *                  0    +---------------------------------+
+ */
+
+#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
+#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
+#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
+
+#define CXL_DEVICE_REGISTERS_OFFSET 0x80 /* Read comment above */
+#define CXL_DEVICE_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
+
+#define CXL_MAILBOX_REGISTERS_OFFSET \
+    (CXL_DEVICE_REGISTERS_OFFSET + CXL_DEVICE_REGISTERS_LENGTH)
+#define CXL_MAILBOX_REGISTERS_SIZE 0x20
+#define CXL_MAILBOX_PAYLOAD_SHIFT 11
+#define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
+#define CXL_MAILBOX_REGISTERS_LENGTH \
+    (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
+
+typedef struct cxl_device_state {
+    MemoryRegion device_registers;
+
+    /* mmio for device capabilities array - 8.2.8.2 */
+    MemoryRegion caps;
+
+    /* mmio for the device status registers 8.2.8.3 */
+    MemoryRegion device;
+
+    /* mmio for the mailbox registers 8.2.8.4 */
+    MemoryRegion mailbox;
+
+    /* memory region for persistent memory, HDM */
+    MemoryRegion *pmem;
+
+    /* memory region for volatile  memory, HDM */
+    MemoryRegion *vmem;
+} CXLDeviceState;
+
+/* Initialize the register block for a device */
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
+
+/* Set up default values for the register block */
+void cxl_device_register_init_common(CXLDeviceState *dev);
+
+/* CXL 2.0 - 8.2.8.1 */
+REG32(CXL_DEV_CAP_ARRAY, 0) /* 48b!?!?! */
+    FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
+    FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
+REG32(CXL_DEV_CAP_ARRAY2, 4) /* We're going to pretend it's 64b */
+    FIELD(CXL_DEV_CAP_ARRAY2, CAP_COUNT, 0, 16)
+
+/*
+ * Helper macro to initialize capability headers for CXL devices.
+ *
+ * In the 8.2.8.2, this is listed as a 128b register, but in 8.2.8, it says:
+ * > No registers defined in Section 8.2.8 are larger than 64-bits wide so that
+ * > is the maximum access size allowed for these registers. If this rule is not
+ * > followed, the behavior is undefined
+ *
+ * Here we've chosen to make it 4 dwords. The spec allows any pow2 multiple
+ * access to be used for a register (2 qwords, 8 words, 128 bytes).
+ */
+#define CXL_DEVICE_CAPABILITY_HEADER_REGISTER(n, offset)                            \
+    REG32(CXL_DEV_##n##_CAP_HDR0, offset)                 \
+        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_ID, 0, 16)      \
+        FIELD(CXL_DEV_##n##_CAP_HDR0, CAP_VERSION, 16, 8) \
+    REG32(CXL_DEV_##n##_CAP_HDR1, offset + 4)             \
+        FIELD(CXL_DEV_##n##_CAP_HDR1, CAP_OFFSET, 0, 32)  \
+    REG32(CXL_DEV_##n##_CAP_HDR2, offset + 8)             \
+        FIELD(CXL_DEV_##n##_CAP_HDR2, CAP_LENGTH, 0, 32)
+
+CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
+CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
+                                               CXL_DEVICE_CAP_REG_SIZE)
+
+REG32(CXL_DEV_MAILBOX_CAP, 0)
+    FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
+    FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
+    FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
+    FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
+
+REG32(CXL_DEV_MAILBOX_CTRL, 4)
+    FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
+    FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
+    FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
+
+/* XXX: actually a 64b register */
+REG32(CXL_DEV_MAILBOX_STS, 0x10)
+    FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
+    FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
+    FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
+
+/* XXX: actually a 64b register */
+REG32(CXL_DEV_BG_CMD_STS, 0x18)
+    FIELD(CXL_DEV_BG_CMD_STS, BG, 0, 16)
+    FIELD(CXL_DEV_BG_CMD_STS, DONE, 16, 7)
+    FIELD(CXL_DEV_BG_CMD_STS, ERRNO, 32, 16)
+    FIELD(CXL_DEV_BG_CMD_STS, VENDOR_ERRNO, 48, 16)
+
+REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
+
+#endif
-- 
2.30.0

