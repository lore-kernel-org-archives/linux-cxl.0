Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C94594A
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346206; cv=none; b=Hzx1QuPvaevD6wO1btc8oqu9v/gsXP7Q1EJqH1c/aixkaGO7J0PTaYL8bYzBabwTETFa7Bz4RV+4aXhXc/ih5ftU2+aHiZPWmwtJqCOTnAy5ilPCaWibCP3MW2/0+bLGCJRs1I3TQFwPwzzAW0emnHFbvpWTRLGlqVtnOj99ZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346206; c=relaxed/simple;
	bh=hvi4ohNUILNg1cmf69i4fFNUNobAV1FLdzktkw27zBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUHpIfYMGzF/ae3gqJMkl1LhiHqo5pt2NWPXU+SrFZQ7ktQ80cWQmbUDy72aqQmaUxUiZmq+6Ik+TtZIXgPB3bp3e9QUFaqNqy6Oy+y2Ebtb967M4tI38EHfOwxvSDEYLJbev9cSE5f6+1FMGkujhaM5fWSZq+ebOM1+LsZMPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPM90Rrqz6M5hs;
	Thu, 19 Jun 2025 23:16:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id D25261404C4;
	Thu, 19 Jun 2025 23:16:41 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:41 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/7] hw/cxl/events: Update for rev3.2 common event record format
Date: Thu, 19 Jun 2025 16:16:13 +0100
Message-ID: <20250619151619.1695-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250619151619.1695-1-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
format has updated with Maintenance Operation Subclass, LD ID and
ID of the device head information.

Add updates for the above spec changes in the related CXL events
reporting and QMP command to inject CXL events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  6 +++--
 hw/mem/cxl_type3.c          | 32 ++++++++++++++++++-------
 hw/mem/cxl_type3_stubs.c    | 12 +++++++---
 include/hw/cxl/cxl_device.h |  4 +++-
 include/hw/cxl/cxl_events.h | 15 +++++++++---
 qapi/cxl.json               | 48 ++++++++++++++++++++++++++++++++++---
 6 files changed, 97 insertions(+), 20 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4c01b25110..4d0c0b3edc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3574,7 +3574,8 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(dcEvent),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0);
     dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
     dcEvent.validity_flags = 1;
     dcEvent.host_id = 0;
@@ -3692,7 +3693,8 @@ static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(event_rec),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0);
     event_rec.type = type;
     event_rec.validity_flags = 1;
     event_rec.host_id = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b5482f58a3..0787a9bfca 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1780,12 +1780,18 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp)
+                             uint8_t length, uint64_t timestamp,
+                             uint8_t maint_class, uint8_t maint_subclass,
+                             uint16_t ld_id, uint8_t head_id)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
     stq_le_p(&hdr->timestamp, timestamp);
+    hdr->maint_op_class = maint_class;
+    hdr->maint_op_subclass = maint_subclass;
+    hdr->ld_id = ld_id;
+    hdr->head_id = head_id;
 }
 
 static const QemuUUID gen_media_uuid = {
@@ -1825,7 +1831,9 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 }
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -1863,7 +1871,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 
     memset(&gem, 0, sizeof(gem));
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
 
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
@@ -1907,7 +1916,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
+                               uint8_t class, uint8_t subclass,
+                               uint16_t ld_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -1950,7 +1961,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 
     memset(&dram, 0, sizeof(dram));
     cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
     dram.descriptor = descriptor;
     dram.type = type;
@@ -2010,7 +2022,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
@@ -2049,7 +2063,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
 
     memset(&module, 0, sizeof(module));
     cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass, ld_id, head_id);
 
     module.type = type;
     module.health_status = health_status;
@@ -2284,7 +2299,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
      * Event Log.
      */
     cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+                            cxl_device_get_timestamp(&dcd->cxl_dstate),
+                            0, 0, 0, 0);
 
     dCap.type = type;
     /* FIXME: for now, validity flag is cleared */
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..263d8b4609 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -14,7 +14,9 @@
 #include "qapi/qapi-commands-cxl.h"
 
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -23,7 +25,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp) {}
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
+                               uint8_t class, uint8_t subclass,
+                               uint16_t ld_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -38,7 +42,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, uint8_t class,
+                                        uint8_t subclass, uint16_t ld_id,
+                                        uint8_t head_id, uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 831fdefbac..fc6ec82670 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -827,7 +827,9 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp);
+                             uint8_t length, uint64_t timestamp,
+                             uint8_t maint_class, uint8_t maint_subclass,
+                             uint16_t ld_id, uint8_t head_id);
 bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
                                     uint64_t dpa, uint64_t len);
 bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 758b075a64..4d9cfdb621 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -29,9 +29,15 @@ typedef enum CXLEventLogType {
 
 /*
  * Common Event Record Format
- * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
+ * CXL r3.2 section 8.2.10.2.1: Event Records; Table 8-55
  */
-#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+#define CXL_EVENT_REC_FLAGS_PERMANENT_COND BIT(2)
+#define CXL_EVENT_REC_FLAGS_MAINT_NEEDED   BIT(3)
+#define CXL_EVENT_REC_FLAGS_PERF_DEGRADED  BIT(4)
+#define CXL_EVENT_REC_FLAGS_HW_REPLACEMENT_NEEDED BIT(5)
+#define CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID BIT(6)
+#define CXL_EVENT_REC_FLAGS_LD_ID_VALID BIT(7)
+#define CXL_EVENT_REC_FLAGS_HEAD_ID_VALID BIT(8)
 typedef struct CXLEventRecordHdr {
     QemuUUID id;
     uint8_t length;
@@ -40,7 +46,10 @@ typedef struct CXLEventRecordHdr {
     uint16_t related_handle;
     uint64_t timestamp;
     uint8_t maint_op_class;
-    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
+    uint8_t maint_op_subclass;
+    uint16_t ld_id;
+    uint8_t head_id;
+    uint8_t reserved[0xb];
 } QEMU_PACKED CXLEventRecordHdr;
 
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8f2e9237b1..c38585d3c8 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -42,6 +42,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -73,7 +85,9 @@
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-general-media-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
@@ -93,6 +107,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
 #     Event Record, Physical Address.
@@ -132,7 +158,9 @@
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-dram-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
@@ -154,6 +182,18 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance operation class the device requests to initiate.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @subclass: Maintenance operation subclass the device requests to
+#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
+# @head-id: ID of the device head from where the event originated.
+#     See CXL r3.2 Table 8-55 Common Event Record Format.
+#
 # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
@@ -184,7 +224,9 @@
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-memory-module-event',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint32',
+	    'class':'uint8', 'subclass':'uint8',
+	    'ld-id':'uint16', 'head-id':'uint8',
             'type': 'uint8', 'health-status': 'uint8',
             'media-status': 'uint8', 'additional-status': 'uint8',
             'life-used': 'uint8', 'temperature' : 'int16',
-- 
2.43.0

