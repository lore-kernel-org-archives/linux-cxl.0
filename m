Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DB9C43381
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B83764EDB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBBBAz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:00:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:21903 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBAz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:00:55 -0500
IronPort-SDR: bIudXEqm14GdVWgOIX5n9QG48mbtYXhDwnOroC9T42BEmlQ2jETGSdOfbAADbrfvNI3IjwH+6s
 iyaRhMnQXV7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294603"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294603"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:59 -0800
IronPort-SDR: 3VGnYAkJjEEgAa8923cebRlxcrHpnkefdI0AJFfWy06eMgzm70BfHLl4fdOfwVcLelQ0ycQN79
 vJGY13dSm2JA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764071"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:58 -0800
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
Subject: [RFC PATCH v3 06/31] hw/cxl/device: Add memory device utilities
Date:   Mon,  1 Feb 2021 16:59:23 -0800
Message-Id: <20210202005948.241655-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Memory devices implement extra capabilities on top of CXL devices. This
adds support for that.

A large part of memory devices is the mailbox/command interface. All of
the mailbox handling is done in the mailbox-utils library. Longer term,
new CXL devices that are being emulated may want to handle commands
differently, and therefore would need a mechanism to opt in/out of the
specific generic handlers. As such, this is considered sufficient for
now, but may need more depth in the future.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-device-utils.c   | 38 ++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h | 18 +++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 6602606f3d..639ace523d 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -130,6 +130,31 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
         cxl_process_mailbox(cxl_dstate);
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
@@ -187,6 +212,9 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                           "device-status", CXL_DEVICE_REGISTERS_LENGTH);
     memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_dstate,
                           "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
+    memory_region_init_io(&cxl_dstate->memory_device, obj, &mdev_ops,
+                          cxl_dstate, "memory device caps",
+                          CXL_MEMORY_DEVICE_REGISTERS_LENGTH);
 
     memory_region_add_subregion(&cxl_dstate->device_registers, 0,
                                 &cxl_dstate->caps);
@@ -196,6 +224,9 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
     memory_region_add_subregion(&cxl_dstate->device_registers,
                                 CXL_MAILBOX_REGISTERS_OFFSET,
                                 &cxl_dstate->mailbox);
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_MEMORY_DEVICE_REGISTERS_OFFSET,
+                                &cxl_dstate->memory_device);
 }
 
 static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
@@ -208,10 +239,12 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
 }
 
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+
 void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 {
     uint32_t *cap_hdrs = cxl_dstate->caps_reg_state32;
-    const int cap_count = 2;
+    const int cap_count = 3;
 
     /* CXL Device Capabilities Array Register */
     ARRAY_FIELD_DP32(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
@@ -224,5 +257,8 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
     mailbox_reg_init_common(cxl_dstate);
 
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
+    memdev_reg_init_common(cxl_dstate);
+
     assert(cxl_initialize_mailbox(cxl_dstate) == 0);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index af91bec10c..0cc5354ba4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -72,15 +72,20 @@
 #define CXL_MAILBOX_REGISTERS_LENGTH \
     (CXL_MAILBOX_REGISTERS_SIZE + CXL_MAILBOX_MAX_PAYLOAD_SIZE)
 
+#define CXL_MEMORY_DEVICE_REGISTERS_OFFSET \
+    (CXL_MAILBOX_REGISTERS_OFFSET + CXL_MAILBOX_REGISTERS_LENGTH)
+#define CXL_MEMORY_DEVICE_REGISTERS_LENGTH 0x8
+
 #define CXL_MMIO_SIZE                                       \
     CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_REGISTERS_LENGTH + \
-        CXL_MAILBOX_REGISTERS_LENGTH
+        CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH
 
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
     MemoryRegion device;
+    MemoryRegion memory_device;
     struct {
         MemoryRegion caps;
         uint32_t caps_reg_state32[CXL_CAPS_SIZE / 4];
@@ -145,6 +150,9 @@ REG32(CXL_DEV_CAP_ARRAY2, 4) /* We're going to pretend it's 64b */
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(DEVICE, CXL_DEVICE_CAP_HDR1_OFFSET)
 CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MAILBOX, CXL_DEVICE_CAP_HDR1_OFFSET + \
                                                CXL_DEVICE_CAP_REG_SIZE)
+CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
+                                      CXL_DEVICE_CAP_HDR1_OFFSET +
+                                          CXL_DEVICE_CAP_REG_SIZE * 2)
 
 int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
@@ -197,4 +205,12 @@ REG32(CXL_DEV_BG_CMD_STS, 0x18)
 
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
+/* XXX: actually a 64b registers */
+REG32(CXL_MEM_DEV_STS, 0)
+    FIELD(CXL_MEM_DEV_STS, FATAL, 0, 1)
+    FIELD(CXL_MEM_DEV_STS, FW_HALT, 1, 1)
+    FIELD(CXL_MEM_DEV_STS, MEDIA_STATUS, 2, 2)
+    FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
+    FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
+
 #endif
-- 
2.30.0

