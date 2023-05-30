Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF0FC77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 13:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjE3NjK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjE3NjJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 09:39:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CE2C5
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 06:39:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVtjQ4pYvz6DB8N;
        Tue, 30 May 2023 21:36:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 14:39:05 +0100
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
Subject: [PATCH v9 6/7] hw/cxl/events: Add injection of DRAM events
Date:   Tue, 30 May 2023 14:36:02 +0100
Message-ID: <20230530133603.16934-7-Jonathan.Cameron@huawei.com>
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

Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
provides information related to DRAM devices.

Example injection command in QMP:

{ "execute": "cxl-inject-dram-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "rank": 17,
        "nibble-mask": 37421234,
        "bank-group": 7,
        "bank": 11,
        "row": 2,
        "column": 77,
        "correction-mask": [33, 44, 55,66]
    }}

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json               |  61 +++++++++++++++++++
 include/hw/cxl/cxl_events.h |  23 +++++++
 hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  13 ++++
 4 files changed, 213 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index d509430844..2ad310387c 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -79,6 +79,67 @@
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
+##
+# @cxl-inject-dram-event:
+#
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# This event type is reported via one of the event logs specified via
+# the log parameter.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: Event log to add the event to
+#
+# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
+#     Record Format, Event Record Flags for subfield definitions.
+#
+# @dpa: Device Physical Address (relative to @path device).  Note
+#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
+#     Event Record, Physical Address.
+#
+# @descriptor: Memory Event Descriptor with additional memory event
+#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
+#     Event Descriptor for bit definitions.
+#
+# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
+#     DRAM Event Record, Memory Event Type for possible values.
+#
+# @transaction-type: Type of first transaction that caused the event
+#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
+#     Transaction Type for possible values.
+#
+# @channel: The channel of the memory event location.  A channel is an
+#     interface that can be independently accessed for a transaction.
+#
+# @rank: The rank of the memory event location.  A rank is a set of
+#     memory devices on a channel that together execute a transaction.
+#
+# @nibble-mask: Identifies one or more nibbles that the error affects
+#
+# @bank-group: Bank group of the memory event location, incorporating
+#     a number of Banks.
+#
+# @bank: Bank of the memory event location.  A single bank is accessed
+#     per read or write of the memory.
+#
+# @row: Row address within the DRAM.
+#
+# @column: Column address within the DRAM.
+#
+# @correction-mask: Bits within each nibble.  Used in order of bits
+#     set in the nibble-mask.  Up to 4 nibbles may be covered.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'dpa': 'uint64', 'descriptor': 'uint8',
+            'type': 'uint8', 'transaction-type': 'uint8',
+            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
+            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+           }}
+
 ##
 # @cxl-inject-poison:
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index b189193f4c..a39e30d973 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -123,4 +123,27 @@ typedef struct CXLEventGenMedia {
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
+/*
+ * DRAM Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
+ * All fields little endian.
+ */
+typedef struct CXLEventDram {
+    CXLEventRecordHdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint16_t validity_flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint64_t correction_mask[4];
+    uint8_t reserved[0x17];
+} QEMU_PACKED CXLEventDram;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b1618779d2..3c07b1b7a3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1196,6 +1196,11 @@ static const QemuUUID gen_media_uuid = {
                  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
 };
 
+static const QemuUUID dram_uuid = {
+    .data = UUID(0x601dcbb3, 0x9c06, 0x4eab, 0xb8, 0xaf,
+                 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+};
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1292,6 +1297,117 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_DRAM_VALID_CHANNEL                          BIT(0)
+#define CXL_DRAM_VALID_RANK                             BIT(1)
+#define CXL_DRAM_VALID_NIBBLE_MASK                      BIT(2)
+#define CXL_DRAM_VALID_BANK_GROUP                       BIT(3)
+#define CXL_DRAM_VALID_BANK                             BIT(4)
+#define CXL_DRAM_VALID_ROW                              BIT(5)
+#define CXL_DRAM_VALID_COLUMN                           BIT(6)
+#define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint64_t dpa, uint8_t descriptor,
+                               uint8_t type, uint8_t transaction_type,
+                               bool has_channel, uint8_t channel,
+                               bool has_rank, uint8_t rank,
+                               bool has_nibble_mask, uint32_t nibble_mask,
+                               bool has_bank_group, uint8_t bank_group,
+                               bool has_bank, uint8_t bank,
+                               bool has_row, uint32_t row,
+                               bool has_column, uint16_t column,
+                               bool has_correction_mask, uint64List *correction_mask,
+                               Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventDram dram;
+    CXLEventRecordHdr *hdr = &dram.hdr;
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
+    memset(&dram, 0, sizeof(dram));
+    cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    stq_le_p(&dram.phys_addr, dpa);
+    dram.descriptor = descriptor;
+    dram.type = type;
+    dram.transaction_type = transaction_type;
+
+    if (has_channel) {
+        dram.channel = channel;
+        valid_flags |= CXL_DRAM_VALID_CHANNEL;
+    }
+
+    if (has_rank) {
+        dram.rank = rank;
+        valid_flags |= CXL_DRAM_VALID_RANK;
+    }
+
+    if (has_nibble_mask) {
+        st24_le_p(dram.nibble_mask, nibble_mask);
+        valid_flags |= CXL_DRAM_VALID_NIBBLE_MASK;
+    }
+
+    if (has_bank_group) {
+        dram.bank_group = bank_group;
+        valid_flags |= CXL_DRAM_VALID_BANK_GROUP;
+    }
+
+    if (has_bank) {
+        dram.bank = bank;
+        valid_flags |= CXL_DRAM_VALID_BANK;
+    }
+
+    if (has_row) {
+        st24_le_p(dram.row, row);
+        valid_flags |= CXL_DRAM_VALID_ROW;
+    }
+
+    if (has_column) {
+        stw_le_p(&dram.column, column);
+        valid_flags |= CXL_DRAM_VALID_COLUMN;
+    }
+
+    if (has_correction_mask) {
+        int count = 0;
+        while (correction_mask && count < 4) {
+            stq_le_p(&dram.correction_mask[count],
+                     correction_mask->value);
+            count++;
+            correction_mask = correction_mask->next;
+        }
+        valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
+    }
+
+    stw_le_p(&dram.validity_flags, valid_flags);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return;
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 4dfbdf9268..e904c5d089 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -13,6 +13,19 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp) {}
 
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint64_t dpa, uint8_t descriptor,
+                               uint8_t type, uint8_t transaction_type,
+                               bool has_channel, uint8_t channel,
+                               bool has_rank, uint8_t rank,
+                               bool has_nibble_mask, uint32_t nibble_mask,
+                               bool has_bank_group, uint8_t bank_group,
+                               bool has_bank, uint8_t bank,
+                               bool has_row, uint32_t row,
+                               bool has_column, uint16_t column,
+                               bool has_correction_mask, uint64List *correction_mask,
+                               Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
2.39.2

