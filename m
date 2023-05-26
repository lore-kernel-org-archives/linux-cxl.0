Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB0BC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjEZROl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZROk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:14:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF0194
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:14:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWhh1N6nz67GDT;
        Sat, 27 May 2023 01:13:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:14:36 +0100
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
Subject: [PATCH v8 3/7] hw/cxl/events: Wire up get/clear event mailbox commands
Date:   Fri, 26 May 2023 18:13:00 +0100
Message-ID: <20230526171304.1613-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
References: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL testing is benefited from an artificial event log injection
mechanism.

Add an event log infrastructure to insert, get, and clear events from
the various logs available on a device.

Replace the stubbed out CXL Get/Clear Event mailbox commands with
commands that operate on the new infrastructure.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  25 +++++
 include/hw/cxl/cxl_events.h |  55 +++++++++
 hw/cxl/cxl-events.c         | 217 ++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  40 ++++++-
 hw/mem/cxl_type3.c          |   1 +
 hw/cxl/meson.build          |   1 +
 6 files changed, 337 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9f8ee85f8a..d3aec1bc0e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -111,6 +111,20 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+typedef struct CXLEvent {
+    CXLEventRecordRaw data;
+    QSIMPLEQ_ENTRY(CXLEvent) node;
+} CXLEvent;
+
+typedef struct CXLEventLog {
+    uint16_t next_handle;
+    uint16_t overflow_err_count;
+    uint64_t first_overflow_timestamp;
+    uint64_t last_overflow_timestamp;
+    QemuMutex lock;
+    QSIMPLEQ_HEAD(, CXLEvent) events;
+} CXLEventLog;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
@@ -161,6 +175,8 @@ typedef struct cxl_device_state {
     uint64_t mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
+
+    CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
@@ -353,6 +369,15 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
+void cxl_event_init(CXLDeviceState *cxlds);
+bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
+                      CXLEventRecordRaw *event);
+CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
+                                 uint8_t log_type, int max_recs,
+                                 uint16_t *len);
+CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
+                                   CXLClearEventPayload *pl);
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index aeb3b0590e..d4aaa894f1 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -10,6 +10,8 @@
 #ifndef CXL_EVENTS_H
 #define CXL_EVENTS_H
 
+#include "qemu/uuid.h"
+
 /*
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
  *
@@ -25,4 +27,57 @@ typedef enum CXLEventLogType {
     CXL_EVENT_TYPE_MAX
 } CXLEventLogType;
 
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+typedef struct CXLEventRecordHdr {
+    QemuUUID id;
+    uint8_t length;
+    uint8_t flags[3];
+    uint16_t handle;
+    uint16_t related_handle;
+    uint64_t timestamp;
+    uint8_t maint_op_class;
+    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
+} QEMU_PACKED CXLEventRecordHdr;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+typedef struct CXLEventRecordRaw {
+    CXLEventRecordHdr hdr;
+    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
+} QEMU_PACKED CXLEventRecordRaw;
+#define CXL_EVENT_RECORD_SIZE (sizeof(CXLEventRecordRaw))
+
+/*
+ * Get Event Records output payload
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
+ */
+#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
+#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
+typedef struct CXLGetEventPayload {
+    uint8_t flags;
+    uint8_t reserved1;
+    uint16_t overflow_err_count;
+    uint64_t first_overflow_timestamp;
+    uint64_t last_overflow_timestamp;
+    uint16_t record_count;
+    uint8_t reserved2[0xa];
+    CXLEventRecordRaw records[];
+} QEMU_PACKED CXLGetEventPayload;
+#define CXL_EVENT_PAYLOAD_HDR_SIZE (sizeof(CXLGetEventPayload))
+
+/*
+ * Clear Event Records input payload
+ * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ */
+typedef struct CXLClearEventPayload {
+    uint8_t event_log;      /* CXLEventLogType */
+    uint8_t clear_flags;
+    uint8_t nr_recs;
+    uint8_t reserved[3];
+    uint16_t handle[];
+} CXLClearEventPayload;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
new file mode 100644
index 0000000000..5da1b76b97
--- /dev/null
+++ b/hw/cxl/cxl-events.c
@@ -0,0 +1,217 @@
+/*
+ * CXL Event processing
+ *
+ * Copyright(C) 2023 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/typedefs.h"
+#include "qemu/error-report.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_events.h"
+
+/* Artificial limit on the number of events a log can hold */
+#define CXL_TEST_EVENT_OVERFLOW 8
+
+static void reset_overflow(CXLEventLog *log)
+{
+    log->overflow_err_count = 0;
+    log->first_overflow_timestamp = 0;
+    log->last_overflow_timestamp = 0;
+}
+
+void cxl_event_init(CXLDeviceState *cxlds)
+{
+    CXLEventLog *log;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        log = &cxlds->event_logs[i];
+        log->next_handle = 1;
+        log->overflow_err_count = 0;
+        log->first_overflow_timestamp = 0;
+        log->last_overflow_timestamp = 0;
+        qemu_mutex_init(&log->lock);
+        QSIMPLEQ_INIT(&log->events);
+    }
+}
+
+static CXLEvent *cxl_event_get_head(CXLEventLog *log)
+{
+    return QSIMPLEQ_FIRST(&log->events);
+}
+
+static CXLEvent *cxl_event_get_next(CXLEvent *entry)
+{
+    return QSIMPLEQ_NEXT(entry, node);
+}
+
+static int cxl_event_count(CXLEventLog *log)
+{
+    CXLEvent *event;
+    int rc = 0;
+
+    QSIMPLEQ_FOREACH(event, &log->events, node) {
+        rc++;
+    }
+
+    return rc;
+}
+
+static bool cxl_event_empty(CXLEventLog *log)
+{
+    return QSIMPLEQ_EMPTY(&log->events);
+}
+
+static void cxl_event_delete_head(CXLDeviceState *cxlds,
+                                  CXLEventLogType log_type,
+                                  CXLEventLog *log)
+{
+    CXLEvent *entry = cxl_event_get_head(log);
+
+    reset_overflow(log);
+    QSIMPLEQ_REMOVE_HEAD(&log->events, node);
+    if (cxl_event_empty(log)) {
+        cxl_event_set_status(cxlds, log_type, false);
+    }
+    g_free(entry);
+}
+
+/*
+ * return true if an interrupt should be generated as a result
+ * of inserting this event.
+ */
+bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
+                      CXLEventRecordRaw *event)
+{
+    uint64_t time;
+    CXLEventLog *log;
+    CXLEvent *entry;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return false;
+    }
+
+    time = cxl_device_get_timestamp(cxlds);
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+
+    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
+        if (log->overflow_err_count == 0) {
+            log->first_overflow_timestamp = time;
+        }
+        log->overflow_err_count++;
+        log->last_overflow_timestamp = time;
+        return false;
+    }
+
+    entry = g_new0(CXLEvent, 1);
+
+    memcpy(&entry->data, event, sizeof(*event));
+
+    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
+    log->next_handle++;
+    /* 0 handle is never valid */
+    if (log->next_handle == 0) {
+        log->next_handle++;
+    }
+    entry->data.hdr.timestamp = cpu_to_le64(time);
+
+    QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
+    cxl_event_set_status(cxlds, log_type, true);
+
+    /* Count went from 0 to 1 */
+    return cxl_event_count(log) == 1;
+}
+
+CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
+                                 uint8_t log_type, int max_recs,
+                                 uint16_t *len)
+{
+    CXLEventLog *log;
+    CXLEvent *entry;
+    uint16_t nr;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < max_recs; nr++) {
+        memcpy(&pl->records[nr], &entry->data, CXL_EVENT_RECORD_SIZE);
+        entry = cxl_event_get_next(entry);
+    }
+
+    if (!cxl_event_empty(log)) {
+        pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+    }
+
+    if (log->overflow_err_count) {
+        pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
+        pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
+        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
+        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
+    }
+
+    pl->record_count = cpu_to_le16(nr);
+    *len = CXL_EVENT_PAYLOAD_HDR_SIZE + (CXL_EVENT_RECORD_SIZE * nr);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
+{
+    CXLEventLog *log;
+    uint8_t log_type;
+    CXLEvent *entry;
+    int nr;
+
+    log_type = pl->event_log;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+    /*
+     * Must itterate the queue twice.
+     * "The device shall verify the event record handles specified in the input
+     * payload are in temporal order. If the device detects an older event
+     * record that will not be cleared when Clear Event Records is executed,
+     * the device shall return the Invalid Handle return code and shall not
+     * clear any of the specified event records."
+     *   -- CXL 3.0 8.2.9.2.3
+     */
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
+        uint16_t handle = pl->handle[nr];
+
+        /* NOTE: Both handles are little endian. */
+        if (handle == 0 || entry->data.hdr.handle != handle) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        entry = cxl_event_get_next(entry);
+    }
+
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
+        cxl_event_delete_head(cxlds, log_type, log);
+        entry = cxl_event_get_head(log);
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d7e114aaae..3f46538048 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
@@ -95,11 +96,46 @@ struct cxl_cmd {
         return CXL_MBOX_SUCCESS;                                          \
     }
 
-DEFINE_MAILBOX_HANDLER_ZEROED(events_get_records, 0x20);
-DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
 DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
+static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxlds,
+                                         uint16_t *len)
+{
+    CXLGetEventPayload *pl;
+    uint8_t log_type;
+    int max_recs;
+
+    if (cmd->in < sizeof(log_type)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log_type = *((uint8_t *)cmd->payload);
+
+    pl = (CXLGetEventPayload *)cmd->payload;
+    memset(pl, 0, sizeof(*pl));
+
+    max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
+                CXL_EVENT_RECORD_SIZE;
+    if (max_recs > 0xFFFF) {
+        max_recs = 0xFFFF;
+    }
+
+    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
+}
+
+static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
+                                           CXLDeviceState *cxlds,
+                                           uint16_t *len)
+{
+    CXLClearEventPayload *pl;
+
+    pl = (CXLClearEventPayload *)cmd->payload;
+    *len = 0;
+    return cxl_event_clear_records(cxlds, pl);
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                                CXLDeviceState *cxl_dstate,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d751803188..ec5a384885 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -724,6 +724,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_release_cdat;
     }
 
+    cxl_event_init(&ct3d->cxl_dstate);
     return;
 
 err_release_cdat:
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index cfa95ffd40..71059972d4 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -5,6 +5,7 @@ softmmu_ss.add(when: 'CONFIG_CXL',
                    'cxl-mailbox-utils.c',
                    'cxl-host.c',
                    'cxl-cdat.c',
+                   'cxl-events.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
-- 
2.39.2

