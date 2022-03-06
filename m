Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A9C433F5
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiCFRp4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiCFRp4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 12:45:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E407F25E8F
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 09:45:03 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTTq0KVhz67NvB;
        Mon,  7 Mar 2022 01:43:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:45:01 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:45:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 07/46] hw/cxl/device: Add memory device utilities
Date:   Sun, 6 Mar 2022 17:40:58 +0000
Message-ID: <20220306174137.5707-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Memory devices implement extra capabilities on top of CXL devices. This
adds support for that.

A large part of memory devices is the mailbox/command interface. All of
the mailbox handling is done in the mailbox-utils library. Longer term,
new CXL devices that are being emulated may want to handle commands
differently, and therefore would need a mechanism to opt in/out of the
specific generic handlers. As such, this is considered sufficient for
now, but may need more depth in the future.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/cxl/cxl-device-utils.c   | 38 ++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h | 22 ++++++++++++++++++---
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 4b995beba7..1f5587ffcd 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -131,6 +131,31 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t retval = 0;
+
+    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+
+    return retval;
+}
+
+static const MemoryRegionOps mdev_ops = {
+    .read = mdev_reg_read,
+    .write = NULL, /* memory device register is read only */
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 8,
+        .max_access_size = 8,
+    },
+};
+
 static const MemoryRegionOps mailbox_ops = {
     .read = mailbox_reg_read,
     .write = mailbox_reg_write,
@@ -188,6 +213,9 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                           "device-status", CXL_DEVICE_REGISTERS_LENGTH);
     memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_dstate,
                           "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
+    memory_region_init_io(&cxl_dstate->memory_device, obj, &mdev_ops,
+                          cxl_dstate, "memory device caps",
+                          CXL_MEMORY_DEVICE_REGISTERS_LENGTH);
 
     memory_region_add_subregion(&cxl_dstate->device_registers, 0,
                                 &cxl_dstate->caps);
@@ -197,6 +225,9 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
     memory_region_add_subregion(&cxl_dstate->device_registers,
                                 CXL_MAILBOX_REGISTERS_OFFSET,
                                 &cxl_dstate->mailbox);
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_MEMORY_DEVICE_REGISTERS_OFFSET,
+                                &cxl_dstate->memory_device);
 }
 
 static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
@@ -209,10 +240,12 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
 }
 
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+
 void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 {
     uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
-    const int cap_count = 2;
+    const int cap_count = 3;
 
     /* CXL Device Capabilities Array Register */
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
@@ -225,5 +258,8 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
     mailbox_reg_init_common(cxl_dstate);
 
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
+    memdev_reg_init_common(cxl_dstate);
+
     assert(cxl_initialize_mailbox(cxl_dstate) == 0);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 49dcca7e44..7fd8d0f616 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -77,15 +77,21 @@
 #define CXL_MAILBOX_REGISTERS_LENGTH \
     (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
 
-#define CXL_MMIO_SIZE                                           \
-    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH +    \
-     CXL_MAILBOX_REGISTERS_LENGTH)
+
+#define CXL_MEMORY_DEVICE_REGISTERS_OFFSET \
+    (CXL_MAILBOX_REGISTERS_OFFSET + CXL_MAILBOX_REGISTERS_LENGTH)
+#define CXL_MEMORY_DEVICE_REGISTERS_LENGTH 0x8
+
+#define CXL_MMIO_SIZE                                                   \
+    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH +            \
+     CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
 
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
     MemoryRegion device;
+    MemoryRegion memory_device;
     struct {
         MemoryRegion caps;
         union {
@@ -158,6 +164,9 @@ REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte access
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
                                                CXL_DEVICE_CAP_REG_SIZE)
+CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
+                                      CXL_DEVICE_CAP_HDR1_OFFSET +
+                                          CXL_DEVICE_CAP_REG_SIZE * 2)
 
 int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
@@ -208,4 +217,11 @@ REG64(CXL_DEV_BG_CMD_STS, 0x18)
 
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
+REG64(CXL_MEM_DEV_STS, 0)
+    FIELD(CXL_MEM_DEV_STS, FATAL, 0, 1)
+    FIELD(CXL_MEM_DEV_STS, FW_HALT, 1, 1)
+    FIELD(CXL_MEM_DEV_STS, MEDIA_STATUS, 2, 2)
+    FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
+    FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
+
 #endif
-- 
2.32.0

