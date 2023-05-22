Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B0C77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 15:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEVPNp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjEVPNb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 11:13:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F16DCD
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 08:13:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ1773tXhz6J71T;
        Mon, 22 May 2023 23:08:51 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:13:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module Events
Date:   Mon, 22 May 2023 16:09:47 +0100
Message-ID: <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These events include a copy of the device health information at the
time of the event. Actually using the emulated device health would
require a lot of controls to manipulate that state.  Given the aim
of this injection code is to just test the flows when events occur,
inject the contents of the device health state as well.

Future work may add more sophisticate device health emulation
including direct generation of these records when events occur
(such as a temperature threshold being crossed).  That does not
reduce the usefulness of this more basic generation of the events.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7: Expanded docs for qapi and added a lot of cross references to
    the CXL revision 3.0 specification.
---
 qapi/cxl.json               | 54 ++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_events.h | 19 ++++++++++++
 hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    | 12 +++++++
 4 files changed, 147 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index ce9adcbc55..05c560cfe5 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -147,6 +147,60 @@
             '*column': 'uint16', '*correction-mask': [ 'uint64' ]
            }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a Memory Module Event (CXL r3.0
+# 8.2.9.2.1.3). # This event includes a copy of the Device Health
+# info at the time of the event.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: Event Log to add the event to
+#
+# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
+#         Record Format, Event Record Flags for subfield definitions.
+#
+# @type: Device Event Type. See CXL r3.0 Table 8-45 Memory Module
+#        Event Record for bit definitions for bit definiions.
+#
+# @health-status: Overall health summary bitmap. See CXL r3.0 Table
+#                 8-100 Get Health Info Output Payload, Health Status
+#                 for bit definitions.
+#
+# @media-status: Overall media health summary. See CXL r3.0 Table
+#                8-100 Get Health Info Output Payload, Media Status
+#                for bit definitions.
+#
+# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+#                     Payload, Additional Status for subfield
+#                     definitions.
+#
+# @life-used: Percentage (0-100) of factory expected life span.
+#
+# @temperature: Device temperature in degrees Celsius.
+#
+# @dirty-shutdown-count: Number of time the device has been unable to
+#                        determine whether data loss may have occurred.
+#
+# @corrected-volatile-error-count: Total number of correctable errors in
+#                                  volatile memory.
+#
+# @corrected-persistent-error-count: Total number correctable errors in
+#                                    persistent memory
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
+            'type': 'uint8', 'health-status': 'uint8',
+            'media-status': 'uint8', 'additional-status': 'uint8',
+            'life-used': 'uint8', 'temperature' : 'int16',
+            'dirty-shutdown-count': 'uint32',
+            'corrected-volatile-error-count': 'uint32',
+            'corrected-persistent-error-count': 'uint32'
+            }}
+
 ##
 # @cxl-inject-poison:
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a39e30d973..089ba2091f 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -146,4 +146,23 @@ typedef struct CXLEventDram {
     uint8_t reserved[0x17];
 } QEMU_PACKED CXLEventDram;
 
+/*
+ * Memory Module Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
+ * All fields little endian.
+ */
+typedef struct CXLEventMemoryModule {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t health_status;
+    uint8_t media_status;
+    uint8_t additional_status;
+    uint8_t life_used;
+    int16_t temperature;
+    uint32_t dirty_shutdown_count;
+    uint32_t corrected_volatile_error_count;
+    uint32_t corrected_persistent_error_count;
+    uint8_t reserved[0x3d];
+} QEMU_PACKED CXLEventMemoryModule;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3c07b1b7a3..4e314748d3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1201,6 +1201,11 @@ static const QemuUUID dram_uuid = {
                  0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
 };
 
+static const QemuUUID memory_module_uuid = {
+    .data = UUID(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86,
+                 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+};
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1408,6 +1413,63 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     return;
 }
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventMemoryModule module;
+    CXLEventRecordHdr *hdr = &module.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
+    uint8_t enc_log;
+    int rc;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+        return;
+    }
+    ct3d = CXL_TYPE3(obj);
+    cxlds = &ct3d->cxl_dstate;
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    memset(&module, 0, sizeof(module));
+    cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+
+    module.type = type;
+    module.health_status = health_status;
+    module.media_status = media_status;
+    module.additional_status = additional_status;
+    module.life_used = life_used;
+    stw_le_p(&module.temperature, temperature);
+    stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
+    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
+    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index e904c5d089..f3e4a9fa72 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -26,6 +26,18 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                bool has_correction_mask, uint64List *correction_mask,
                                Error **errp) {}
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
2.39.2

