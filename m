Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDDCC77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 13:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjE3Nij (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Nii (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 09:38:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA11A1
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 06:38:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVthr1BMBz6DB8S;
        Tue, 30 May 2023 21:36:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 14:38:34 +0100
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
Subject: [PATCH v9 5/7] hw/cxl/events: Add injection of General Media Events
Date:   Tue, 30 May 2023 14:36:01 +0100
Message-ID: <20230530133603.16934-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

To facilitate testing provide a QMP command to inject a general media
event.  The event can be added to the log specified.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v9: Double space after . for consistency.
---
 qapi/cxl.json               |  74 ++++++++++++++++++++++++
 include/hw/cxl/cxl_events.h |  20 +++++++
 hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  10 ++++
 4 files changed, 215 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index ed1c7eea3a..d509430844 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -5,6 +5,80 @@
 # = CXL devices
 ##
 
+##
+# @CxlEventLog:
+#
+# CXL has a number of separate event logs for different types of
+# events.  Each such event log is handled and signaled independently.
+#
+# @informational: Information Event Log
+#
+# @warning: Warning Event Log
+#
+# @failure: Failure Event Log
+#
+# @fatal: Fatal Event Log
+#
+# Since: 8.1
+##
+{ 'enum': 'CxlEventLog',
+  'data': ['informational',
+           'warning',
+           'failure',
+           'fatal']
+ }
+
+##
+# @cxl-inject-general-media-event:
+#
+# Inject an event record for a General Media Event (CXL r3.0
+# 8.2.9.2.1.1).  This event type is reported via one of the event logs
+# specified via the log parameter.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: event log to add the event to
+#
+# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
+#     Record Format, Event Record Flags for subfield definitions.
+#
+# @dpa: Device Physical Address (relative to @path device).  Note
+#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
+#     Media Event Record, Physical Address.
+#
+# @descriptor: Memory Event Descriptor with additional memory event
+#     information.  See CXL r3.0 Table 8-43 General Media Event
+#     Record, Memory Event Descriptor for bit definitions.
+#
+# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
+#     General Media Event Record, Memory Event Type for possible
+#     values.
+#
+# @transaction-type: Type of first transaction that caused the event
+#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
+#     Transaction Type for possible values.
+#
+# @channel: The channel of the memory event location.  A channel is an
+#     interface that can be independently accessed for a transaction.
+#
+# @rank: The rank of the memory event location.  A rank is a set of
+#     memory devices on a channel that together execute a transaction.
+#
+# @device: Bitmask that represents all devices in the rank associated
+#     with the memory event location.
+#
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'dpa': 'uint64', 'descriptor': 'uint8',
+            'type': 'uint8', 'transaction-type': 'uint8',
+            '*channel': 'uint8', '*rank': 'uint8',
+            '*device': 'uint32', '*component-id': 'str' } }
+
 ##
 # @cxl-inject-poison:
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4bf8b7aa08..b189193f4c 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -103,4 +103,24 @@ typedef struct CXLEventInterruptPolicy {
 /* DCD is optional but other fields are not */
 #define CXL_EVENT_INT_SETTING_MIN_LEN 4
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+typedef struct CXLEventGenMedia {
+    CXLEventRecordHdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint16_t validity_flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t device[3];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
+} QEMU_PACKED CXLEventGenMedia;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c9e347f42b..b1618779d2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1181,6 +1181,117 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
+static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                                    const QemuUUID *uuid, uint32_t flags,
+                                    uint8_t length, uint64_t timestamp)
+{
+    st24_le_p(&hdr->flags, flags);
+    hdr->length = length;
+    memcpy(&hdr->id, uuid, sizeof(hdr->id));
+    stq_le_p(&hdr->timestamp, timestamp);
+}
+
+static const QemuUUID gen_media_uuid = {
+    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
+                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+};
+
+#define CXL_GMER_VALID_CHANNEL                          BIT(0)
+#define CXL_GMER_VALID_RANK                             BIT(1)
+#define CXL_GMER_VALID_DEVICE                           BIT(2)
+#define CXL_GMER_VALID_COMPONENT                        BIT(3)
+
+static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
+{
+    switch (log) {
+    case CXL_EVENT_LOG_INFORMATIONAL:
+        return CXL_EVENT_TYPE_INFO;
+    case CXL_EVENT_LOG_WARNING:
+        return CXL_EVENT_TYPE_WARN;
+    case CXL_EVENT_LOG_FAILURE:
+        return CXL_EVENT_TYPE_FAIL;
+    case CXL_EVENT_LOG_FATAL:
+        return CXL_EVENT_TYPE_FATAL;
+/* DCD not yet supported */
+    default:
+        return -EINVAL;
+    }
+}
+/* Component ID is device specific.  Define this as a string. */
+void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t descriptor, uint8_t type,
+                                        uint8_t transaction_type,
+                                        bool has_channel, uint8_t channel,
+                                        bool has_rank, uint8_t rank,
+                                        bool has_device, uint32_t device,
+                                        const char *component_id,
+                                        Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventGenMedia gem;
+    CXLEventRecordHdr *hdr = &gem.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
+    uint16_t valid_flags = 0;
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
+    memset(&gem, 0, sizeof(gem));
+    cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+
+    stq_le_p(&gem.phys_addr, dpa);
+    gem.descriptor = descriptor;
+    gem.type = type;
+    gem.transaction_type = transaction_type;
+
+    if (has_channel) {
+        gem.channel = channel;
+        valid_flags |= CXL_GMER_VALID_CHANNEL;
+    }
+
+    if (has_rank) {
+        gem.rank = rank;
+        valid_flags |= CXL_GMER_VALID_RANK;
+    }
+
+    if (has_device) {
+        st24_le_p(gem.device, device);
+        valid_flags |= CXL_GMER_VALID_DEVICE;
+    }
+
+    if (component_id) {
+        strncpy((char *)gem.component_id, component_id,
+                sizeof(gem.component_id) - 1);
+        valid_flags |= CXL_GMER_VALID_COMPONENT;
+    }
+
+    stw_le_p(&gem.validity_flags, valid_flags);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index fd1166a610..4dfbdf9268 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -3,6 +3,16 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-cxl.h"
 
+void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t descriptor, uint8_t type,
+                                        uint8_t transaction_type,
+                                        bool has_channel, uint8_t channel,
+                                        bool has_rank, uint8_t rank,
+                                        bool has_device, uint32_t device,
+                                        const char *component_id,
+                                        Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
2.39.2

