Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C653C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJJWa0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJWaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E115A810
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441022; x=1696977022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WINfsvFZv1InPNmycrqd9oyzCqeJWXmlB+gr9uGiA0k=;
  b=GrvpY9n8X9jN8qv+orbO+XjNlDlDP9nQ5s/3Lod0jiXatjVUn72zI8g6
   sEerV6k65kE9NhziHQt1rJJkoOYobe+zLODjfY7er1VD+9eV1SN40HPOz
   kZkTBXoh501X2y7ex74GAsTcT12TrNxmyEv8zWyTXD4SEynx9iKknh1I+
   Xwv8NGxMbJGj/2NEfqGUMIxmm3X3AKOywcKjhy83df1lQff6rFJk+2RHH
   7986x4mQ+R8CCDVHiflcwknKH8p05t0/zwRjSoG+o6CIZ9KX84y2XSaiH
   3BkyzFtc0Fy/eY4K39nXrEfOElSAy9gtuVxgM+PF5MKLO9vWmXEqz6I3g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661245"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628456989"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628456989"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:20 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 3/6] hw/cxl/cxl-events: Add CXL mock events
Date:   Mon, 10 Oct 2022 15:29:41 -0700
Message-Id: <20221010222944.3923556-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

To facilitate testing of guest software add mock events and code to
support iterating through the event logs.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build          |   1 +
 include/hw/cxl/cxl_device.h |  19 +++
 include/hw/cxl/cxl_events.h | 173 +++++++++++++++++++++++++
 4 files changed, 441 insertions(+)
 create mode 100644 hw/cxl/cxl-events.c
 create mode 100644 include/hw/cxl/cxl_events.h

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
new file mode 100644
index 000000000000..c275280bcb64
--- /dev/null
+++ b/hw/cxl/cxl-events.c
@@ -0,0 +1,248 @@
+/*
+ * CXL Event processing
+ *
+ * Copyright(C) 2022 Intel Corporation.
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
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_events.h"
+
+struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type)
+{
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return NULL;
+    }
+    return &cxlds->event_logs[log_type];
+}
+
+struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log)
+{
+    return log->events[log->cur_event];
+}
+
+uint16_t get_cur_event_handle(struct cxl_event_log *log)
+{
+    return cpu_to_le16(log->cur_event);
+}
+
+bool log_empty(struct cxl_event_log *log)
+{
+    return log->cur_event == log->nr_events;
+}
+
+int log_rec_left(struct cxl_event_log *log)
+{
+    return log->nr_events - log->cur_event;
+}
+
+static void event_store_add_event(CXLDeviceState *cxlds,
+                                  enum cxl_event_log_type log_type,
+                                  struct cxl_event_record_raw *event)
+{
+    struct cxl_event_log *log;
+
+    assert(log_type < CXL_EVENT_TYPE_MAX);
+
+    log = &cxlds->event_logs[log_type];
+    assert(log->nr_events < CXL_TEST_EVENT_CNT_MAX);
+
+    log->events[log->nr_events] = event;
+    log->nr_events++;
+}
+
+uint16_t log_overflow(struct cxl_event_log *log)
+{
+    int cnt = log_rec_left(log) - 5;
+
+    if (cnt < 0) {
+        return 0;
+    }
+    return cnt;
+}
+
+#define CXL_EVENT_RECORD_FLAG_PERMANENT         BIT(2)
+#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED      BIT(3)
+#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED     BIT(4)
+#define CXL_EVENT_RECORD_FLAG_HW_REPLACE        BIT(5)
+
+struct cxl_event_record_raw maint_needed = {
+    .hdr = {
+        .id.data = UUID(0xDEADBEEF, 0xCAFE, 0xBABE,
+                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+        .length = sizeof(struct cxl_event_record_raw),
+        .flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
+        /* .handle = Set dynamically */
+        .related_handle = const_le16(0xa5b6),
+    },
+    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+struct cxl_event_record_raw hardware_replace = {
+    .hdr = {
+        .id.data = UUID(0xBABECAFE, 0xBEEF, 0xDEAD,
+                        0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
+        .length = sizeof(struct cxl_event_record_raw),
+        .flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
+        /* .handle = Set dynamically */
+        .related_handle = const_le16(0xb6a5),
+    },
+    .data = { 0xDE, 0xAD, 0xBE, 0xEF },
+};
+
+#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT            BIT(0)
+#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT               BIT(1)
+#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW          BIT(2)
+
+#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR                 0x00
+#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR                  0x01
+#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR           0x02
+
+#define CXL_GMER_TRANS_UNKNOWN                          0x00
+#define CXL_GMER_TRANS_HOST_READ                        0x01
+#define CXL_GMER_TRANS_HOST_WRITE                       0x02
+#define CXL_GMER_TRANS_HOST_SCAN_MEDIA                  0x03
+#define CXL_GMER_TRANS_HOST_INJECT_POISON               0x04
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB             0x05
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT        0x06
+
+#define CXL_GMER_VALID_CHANNEL                          BIT(0)
+#define CXL_GMER_VALID_RANK                             BIT(1)
+#define CXL_GMER_VALID_DEVICE                           BIT(2)
+#define CXL_GMER_VALID_COMPONENT                        BIT(3)
+
+struct cxl_event_gen_media gen_media = {
+    .hdr = {
+        .id.data = UUID(0xfbcd0a77, 0xc260, 0x417f,
+                        0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+        .length = sizeof(struct cxl_event_gen_media),
+        .flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+        /* .handle = Set dynamically */
+        .related_handle = const_le16(0),
+    },
+    .phys_addr = const_le64(0x2000),
+    .descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+    .type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+    .transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+    .validity_flags = { CXL_GMER_VALID_CHANNEL |
+                        CXL_GMER_VALID_RANK, 0 },
+    .channel = 1,
+    .rank = 30
+};
+
+#define CXL_DER_VALID_CHANNEL                           BIT(0)
+#define CXL_DER_VALID_RANK                              BIT(1)
+#define CXL_DER_VALID_NIBBLE                            BIT(2)
+#define CXL_DER_VALID_BANK_GROUP                        BIT(3)
+#define CXL_DER_VALID_BANK                              BIT(4)
+#define CXL_DER_VALID_ROW                               BIT(5)
+#define CXL_DER_VALID_COLUMN                            BIT(6)
+#define CXL_DER_VALID_CORRECTION_MASK                   BIT(7)
+
+struct cxl_event_dram dram = {
+    .hdr = {
+        .id.data = UUID(0x601dcbb3, 0x9c06, 0x4eab,
+                        0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+        .length = sizeof(struct cxl_event_dram),
+        .flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+        /* .handle = Set dynamically */
+        .related_handle = const_le16(0),
+    },
+    .phys_addr = const_le64(0x8000),
+    .descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+    .type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+    .transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+    .validity_flags = { CXL_DER_VALID_CHANNEL |
+                        CXL_DER_VALID_BANK_GROUP |
+                        CXL_DER_VALID_BANK |
+                        CXL_DER_VALID_COLUMN, 0 },
+    .channel = 1,
+    .bank_group = 5,
+    .bank = 2,
+    .column = { 0xDE, 0xAD},
+};
+
+#define CXL_MMER_HEALTH_STATUS_CHANGE           0x00
+#define CXL_MMER_MEDIA_STATUS_CHANGE            0x01
+#define CXL_MMER_LIFE_USED_CHANGE               0x02
+#define CXL_MMER_TEMP_CHANGE                    0x03
+#define CXL_MMER_DATA_PATH_ERROR                0x04
+#define CXL_MMER_LAS_ERROR                      0x05
+
+#define CXL_DHI_HS_MAINTENANCE_NEEDED           BIT(0)
+#define CXL_DHI_HS_PERFORMANCE_DEGRADED         BIT(1)
+#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED        BIT(2)
+
+#define CXL_DHI_MS_NORMAL                                    0x00
+#define CXL_DHI_MS_NOT_READY                                 0x01
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST                    0x02
+#define CXL_DHI_MS_ALL_DATA_LOST                             0x03
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS   0x04
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN     0x05
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT           0x06
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS      0x07
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN        0x08
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT              0x09
+
+#define CXL_DHI_AS_NORMAL               0x0
+#define CXL_DHI_AS_WARNING              0x1
+#define CXL_DHI_AS_CRITICAL             0x2
+
+#define CXL_DHI_AS_LIFE_USED(as)        (as & 0x3)
+#define CXL_DHI_AS_DEV_TEMP(as)         ((as & 0xC) >> 2)
+#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)  ((as & 0x10) >> 4)
+#define CXL_DHI_AS_COR_PER_ERR_CNT(as)  ((as & 0x20) >> 5)
+
+struct cxl_event_mem_module mem_module = {
+    .hdr = {
+        .id.data = UUID(0xfe927475, 0xdd59, 0x4339,
+                        0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+        .length = sizeof(struct cxl_event_mem_module),
+        /* .handle = Set dynamically */
+        .related_handle = const_le16(0),
+    },
+    .event_type = CXL_MMER_TEMP_CHANGE,
+    .info = {
+        .health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+        .media_status = CXL_DHI_MS_ALL_DATA_LOST,
+        .add_status = (CXL_DHI_AS_CRITICAL << 2) |
+                       (CXL_DHI_AS_WARNING << 4) |
+                       (CXL_DHI_AS_WARNING << 5),
+        .device_temp = { 0xDE, 0xAD},
+        .dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
+        .cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+        .cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+    }
+};
+
+void cxl_mock_add_event_logs(CXLDeviceState *cxlds)
+{
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO, &maint_needed);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
+                          (struct cxl_event_record_raw *)&gen_media);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_INFO,
+                          (struct cxl_event_record_raw *)&mem_module);
+
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &maint_needed);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
+                          (struct cxl_event_record_raw *)&dram);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
+                          (struct cxl_event_record_raw *)&gen_media);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
+                          (struct cxl_event_record_raw *)&mem_module);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FAIL,
+                          (struct cxl_event_record_raw *)&dram);
+
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+    event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL,
+                          (struct cxl_event_record_raw *)&dram);
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index cfa95ffd40b7..71059972d435 100644
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
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7b4cff569347..46c50c1c13a6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -11,6 +11,7 @@
 #define CXL_DEVICE_H
 
 #include "hw/register.h"
+#include "hw/cxl/cxl_events.h"
 
 /*
  * The following is how a CXL device's Memory Device registers are laid out.
@@ -80,6 +81,14 @@
     (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
      CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
 
+#define CXL_TEST_EVENT_CNT_MAX 15
+
+struct cxl_event_log {
+    int cur_event;
+    int nr_events;
+    struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
+};
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
@@ -119,6 +128,8 @@ typedef struct cxl_device_state {
 
     /* memory region for persistent memory, HDM */
     uint64_t pmem_size;
+
+    struct cxl_event_log event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
@@ -272,4 +283,12 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+void cxl_mock_add_event_logs(CXLDeviceState *cxlds);
+struct cxl_event_log *find_event_log(CXLDeviceState *cxlds, int log_type);
+struct cxl_event_record_raw *get_cur_event(struct cxl_event_log *log);
+uint16_t get_cur_event_handle(struct cxl_event_log *log);
+bool log_empty(struct cxl_event_log *log);
+int log_rec_left(struct cxl_event_log *log);
+uint16_t log_overflow(struct cxl_event_log *log);
+
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
new file mode 100644
index 000000000000..255111f3dcfb
--- /dev/null
+++ b/include/hw/cxl/cxl_events.h
@@ -0,0 +1,173 @@
+/*
+ * QEMU CXL Events
+ *
+ * Copyright (c) 2022 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_EVENTS_H
+#define CXL_EVENTS_H
+
+#include "qemu/uuid.h"
+#include "hw/cxl/cxl.h"
+
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+struct cxl_event_record_hdr {
+    QemuUUID id;
+    uint8_t length;
+    uint8_t flags[3];
+    uint16_t handle;
+    uint16_t related_handle;
+    uint64_t timestamp;
+    uint8_t maint_op_class;
+    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
+} QEMU_PACKED;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+struct cxl_event_record_raw {
+    struct cxl_event_record_hdr hdr;
+    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
+} QEMU_PACKED;
+
+/*
+ * Get Event Records output payload
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
+ *
+ * Space given for 1 record
+ */
+#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
+#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
+struct cxl_get_event_payload {
+    uint8_t flags;
+    uint8_t reserved1;
+    uint16_t overflow_err_count;
+    uint64_t first_overflow_timestamp;
+    uint64_t last_overflow_timestamp;
+    uint16_t record_count;
+    uint8_t reserved2[0xa];
+    struct cxl_event_record_raw record;
+} QEMU_PACKED;
+
+/*
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ */
+enum cxl_event_log_type {
+    CXL_EVENT_TYPE_INFO = 0x00,
+    CXL_EVENT_TYPE_WARN,
+    CXL_EVENT_TYPE_FAIL,
+    CXL_EVENT_TYPE_FATAL,
+    CXL_EVENT_TYPE_DYNAMIC_CAP,
+    CXL_EVENT_TYPE_MAX
+};
+
+static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
+{
+    switch (type) {
+    case CXL_EVENT_TYPE_INFO:
+        return "Informational";
+    case CXL_EVENT_TYPE_WARN:
+        return "Warning";
+    case CXL_EVENT_TYPE_FAIL:
+        return "Failure";
+    case CXL_EVENT_TYPE_FATAL:
+        return "Fatal";
+    case CXL_EVENT_TYPE_DYNAMIC_CAP:
+        return "Dynamic Capacity";
+    default:
+        break;
+    }
+    return "<unknown>";
+}
+
+/*
+ * Clear Event Records input payload
+ * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ *
+ * Space given for 1 record
+ */
+struct cxl_mbox_clear_event_payload {
+    uint8_t event_log;      /* enum cxl_event_log_type */
+    uint8_t clear_flags;
+    uint8_t nr_recs;        /* 1 for this struct */
+    uint8_t reserved[3];
+    uint16_t handle;
+};
+
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+struct cxl_event_gen_media {
+    struct cxl_event_record_hdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint8_t validity_flags[2];
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t device[3];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
+} QEMU_PACKED;
+
+/*
+ * DRAM Event Record - DER
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE   0x20
+#define CXL_EVENT_DER_RES_SIZE               0x17
+struct cxl_event_dram {
+    struct cxl_event_record_hdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint8_t validity_flags[2];
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint8_t column[2];
+    uint8_t correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+    uint8_t reserved[CXL_EVENT_DER_RES_SIZE];
+} QEMU_PACKED;
+
+/*
+ * Get Health Info Record
+ * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+    uint8_t health_status;
+    uint8_t media_status;
+    uint8_t add_status;
+    uint8_t life_used;
+    uint8_t device_temp[2];
+    uint8_t dirty_shutdown_cnt[4];
+    uint8_t cor_vol_err_cnt[4];
+    uint8_t cor_per_err_cnt[4];
+} QEMU_PACKED;
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CXL_EVENT_MEM_MOD_RES_SIZE  0x3d
+struct cxl_event_mem_module {
+    struct cxl_event_record_hdr hdr;
+    uint8_t event_type;
+    struct cxl_get_health_info info;
+    uint8_t reserved[CXL_EVENT_MEM_MOD_RES_SIZE];
+} QEMU_PACKED;
+
+#endif /* CXL_EVENTS_H */
-- 
2.37.2

