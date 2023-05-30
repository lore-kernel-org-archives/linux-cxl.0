Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCA7C77B73
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjE3NiI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3NiH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 09:38:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA77C5
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 06:38:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVtd15JSKz6J70C;
        Tue, 30 May 2023 21:33:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 14:38:04 +0100
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
Subject: [PATCH v9 4/7] hw/cxl/events: Add event interrupt support
Date:   Tue, 30 May 2023 14:36:00 +0100
Message-ID: <20230530133603.16934-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
commands.  Enable those commands to control interrupts for each of the
event log types.

Skip the standard input mailbox length on the Set command due to DCD
being optional.  Perform the checks separately.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |   6 +-
 include/hw/cxl/cxl_events.h |  23 ++++++++
 hw/cxl/cxl-events.c         |  33 ++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 106 +++++++++++++++++++++++++++++-------
 hw/mem/cxl_type3.c          |   4 +-
 5 files changed, 147 insertions(+), 25 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d3aec1bc0e..1978730fba 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -121,6 +121,8 @@ typedef struct CXLEventLog {
     uint16_t overflow_err_count;
     uint64_t first_overflow_timestamp;
     uint64_t last_overflow_timestamp;
+    bool irq_enabled;
+    int irq_vec;
     QemuMutex lock;
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
@@ -369,7 +371,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
-void cxl_event_init(CXLDeviceState *cxlds);
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
 bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
                       CXLEventRecordRaw *event);
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
@@ -378,6 +380,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
 
+void cxl_event_irq_assert(CXLType3Dev *ct3d);
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index d4aaa894f1..4bf8b7aa08 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -80,4 +80,27 @@ typedef struct CXLClearEventPayload {
     uint16_t handle[];
 } CXLClearEventPayload;
 
+/**
+ * Event Interrupt Policy
+ *
+ * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ */
+typedef enum CXLEventIntMode {
+    CXL_INT_NONE     = 0x00,
+    CXL_INT_MSI_MSIX = 0x01,
+    CXL_INT_FW       = 0x02,
+    CXL_INT_RES      = 0x03,
+} CXLEventIntMode;
+#define CXL_EVENT_INT_MODE_MASK 0x3
+#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
+typedef struct CXLEventInterruptPolicy {
+    uint8_t info_settings;
+    uint8_t warn_settings;
+    uint8_t failure_settings;
+    uint8_t fatal_settings;
+    uint8_t dyn_cap_settings;
+} QEMU_PACKED CXLEventInterruptPolicy;
+/* DCD is optional but other fields are not */
+#define CXL_EVENT_INT_SETTING_MIN_LEN 4
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 5da1b76b97..d161d57456 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -13,6 +13,8 @@
 #include "qemu/bswap.h"
 #include "qemu/typedefs.h"
 #include "qemu/error-report.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
@@ -26,7 +28,7 @@ static void reset_overflow(CXLEventLog *log)
     log->last_overflow_timestamp = 0;
 }
 
-void cxl_event_init(CXLDeviceState *cxlds)
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num)
 {
     CXLEventLog *log;
     int i;
@@ -37,9 +39,16 @@ void cxl_event_init(CXLDeviceState *cxlds)
         log->overflow_err_count = 0;
         log->first_overflow_timestamp = 0;
         log->last_overflow_timestamp = 0;
+        log->irq_enabled = false;
+        log->irq_vec = start_msg_num++;
         qemu_mutex_init(&log->lock);
         QSIMPLEQ_INIT(&log->events);
     }
+
+    /* Override -- Dynamic Capacity uses the same vector as info */
+    cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP].irq_vec =
+                      cxlds->event_logs[CXL_EVENT_TYPE_INFO].irq_vec;
+
 }
 
 static CXLEvent *cxl_event_get_head(CXLEventLog *log)
@@ -215,3 +224,25 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
 
     return CXL_MBOX_SUCCESS;
 }
+
+void cxl_event_irq_assert(CXLType3Dev *ct3d)
+{
+    CXLDeviceState *cxlds = &ct3d->cxl_dstate;
+    PCIDevice *pdev = &ct3d->parent_obj;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        CXLEventLog *log = &cxlds->event_logs[i];
+
+        if (!log->irq_enabled || cxl_event_empty(log)) {
+            continue;
+        }
+
+        /*  Notifies interrupt, legacy IRQ is not supported */
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, log->irq_vec);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, log->irq_vec);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3f46538048..02f9b5a870 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -80,25 +80,6 @@ struct cxl_cmd {
     uint8_t *payload;
 };
 
-#define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
-    uint16_t __zero##name = size;                                         \
-    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
-                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        *len = __zero##name;                                              \
-        memset(cmd->payload, 0, *len);                                    \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-#define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
-    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
-                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-
-DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
-DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
-
 static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
                                          CXLDeviceState *cxlds,
                                          uint16_t *len)
@@ -136,6 +117,88 @@ static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
     return cxl_event_clear_records(cxlds, pl);
 }
 
+static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+                                                  CXLDeviceState *cxlds,
+                                                  uint16_t *len)
+{
+    CXLEventInterruptPolicy *policy;
+    CXLEventLog *log;
+
+    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    memset(policy, 0, sizeof(*policy));
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    if (log->irq_enabled) {
+        policy->info_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    if (log->irq_enabled) {
+        policy->warn_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    if (log->irq_enabled) {
+        policy->failure_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    if (log->irq_enabled) {
+        policy->fatal_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
+    if (log->irq_enabled) {
+        /* Dynamic Capacity borrows the same vector as info */
+        policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
+    }
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
+                                                  CXLDeviceState *cxlds,
+                                                  uint16_t *len)
+{
+    CXLEventInterruptPolicy *policy;
+    CXLEventLog *log;
+
+    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    policy = (CXLEventInterruptPolicy *)cmd->payload;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    log->irq_enabled = (policy->warn_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    log->irq_enabled = (policy->failure_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    log->irq_enabled = (policy->fatal_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    /* DCD is optional */
+    if (*len < sizeof(*policy)) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
+    log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                                CXLDeviceState *cxl_dstate,
@@ -611,9 +674,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
         cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
-        cmd_events_get_interrupt_policy, 0, 0 },
+                                      cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
-        cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+                                      cmd_events_set_interrupt_policy,
+                                      ~0, IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ec5a384885..c9e347f42b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -659,7 +659,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 1;
+    unsigned short msix_num = 6;
     int i, rc;
 
     QTAILQ_INIT(&ct3d->error_list);
@@ -723,8 +723,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
+    cxl_event_init(&ct3d->cxl_dstate, 2);
 
-    cxl_event_init(&ct3d->cxl_dstate);
     return;
 
 err_release_cdat:
-- 
2.39.2

