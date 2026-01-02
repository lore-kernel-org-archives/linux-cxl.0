Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D34C8CE
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366982; cv=none; b=Zvm6bEBH+duHX11T/unWnaSBb4sSyFCLj4pKWELdVNCXc8IcgZeP0WC7MBvcjakXAUFJ6HBFkNoXuDQAQnpiRFfbT+aTa8oAV9kocJBndCOQyCQuwrrwXr1KuWcmd+pcR0hBrD6NJPGjZM56RMJV7IvMLcftFFiNcs3f0jGP1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366982; c=relaxed/simple;
	bh=lCu1yHGiSQ8hL1ttxpZ5THtc+O/y7s+XKmUr4ANo5ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acTZ6WJuoxy9/+qOHbeo6AI9W9zSM+CnhyX3r8yFvdyXtL8H7C1i689hh9I2YDOxPAyHuD6VUIMzU9buKmF4BpfREE+aUPibd+5OuusITutKzZqLJPRKeF4bwP1VyOEDJSXuzQXDzmv0wgu4T/SxcfRhnaws+pJaMsdpxkByIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djS1Q4cPMzJ467Z;
	Fri,  2 Jan 2026 23:15:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 40EE240565;
	Fri,  2 Jan 2026 23:16:18 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:16:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu v2 2/5] hw/cxl/events: Update for rev3.2 common event record format
Date: Fri, 2 Jan 2026 15:15:09 +0000
Message-ID: <20260102151512.460766-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
format has updated with optional Maintenance Operation Subclass,
LD ID and ID of the device head information.

Add updates for the above optional parameters in the related
CXL events reporting and in the QMP commands to inject CXL events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json               | 20 ++++++++---
 include/hw/cxl/cxl_device.h |  7 +++-
 include/hw/cxl/cxl_events.h | 15 ++++++--
 hw/cxl/cxl-events.c         |  3 +-
 hw/cxl/cxl-mailbox-utils.c  |  3 +-
 hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
 hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
 7 files changed, 121 insertions(+), 21 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index d5b86159f1..b3c2ac9575 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -33,20 +33,32 @@
 ##
 # @CXLCommonEventBase:
 #
-# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
-# Table 8-42 Common Event Record Format).
+# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
+# Table 8-55 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
 # @log: event log to add the event to
 #
-# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
+# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @maint-op-class: Maintenance operation class the device requests to
+#     initiate.
+#
+# @maint-op-subclass: Maintenance operation subclass the device
+#     requests to initiate.
+#
+# @ld-id: LD ID of LD from where the event originated.
+#
+# @head-id: ID of the device head from where the event originated.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLCommonEventBase',
-  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
+            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
+            '*ld-id':'uint16', '*head-id':'uint8' } }
 
 ##
 # @CXLGeneralMediaEvent:
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 165355baf9..e461a824b6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -723,7 +723,12 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp);
+                             uint8_t length, uint64_t timestamp,
+                             bool has_maint_op_class, uint8_t maint_op_class,
+                             bool has_maint_op_subclass,
+                             uint8_t maint_op_subclass,
+                             bool has_ld_id, uint16_t ld_id,
+                             bool has_head_id, uint8_t head_id);
 void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
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
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 7583dd9162..5356dfb5b3 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -271,7 +271,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(event_rec),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0, 0, 0, 0, 0);
     event_rec.type = type;
     event_rec.validity_flags = 1;
     event_rec.host_id = 0;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6cfdd98168..e9528da70c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3458,7 +3458,8 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
                             &dynamic_capacity_uuid,
                             (1 << CXL_EVENT_TYPE_INFO),
                             sizeof(dcEvent),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            0, 0, 0, 0, 0, 0, 0, 0);
     dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
     dcEvent.validity_flags = 1;
     dcEvent.host_id = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6eb20137a0..371bd4dc6a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1592,12 +1592,39 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
-                             uint8_t length, uint64_t timestamp)
+                             uint8_t length, uint64_t timestamp,
+                             bool has_maint_op_class, uint8_t maint_op_class,
+                             bool has_maint_op_subclass,
+                             uint8_t maint_op_subclass,
+                             bool has_ld_id, uint16_t ld_id,
+                             bool has_head_id, uint8_t head_id)
 {
-    st24_le_p(&hdr->flags, flags);
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
     stq_le_p(&hdr->timestamp, timestamp);
+
+    if (has_maint_op_class) {
+        hdr->maint_op_class = maint_op_class;
+    } else {
+        hdr->maint_op_class = 0;
+    }
+
+    if (has_maint_op_subclass) {
+        flags |= CXL_EVENT_REC_FLAGS_MAINT_OP_SUBCLASS_VALID;
+        hdr->maint_op_subclass = maint_op_subclass;
+    }
+
+    if (has_ld_id) {
+        flags |= CXL_EVENT_REC_FLAGS_LD_ID_VALID;
+        stw_le_p(&hdr->ld_id, ld_id);
+    }
+
+    if (has_head_id) {
+        flags |= CXL_EVENT_REC_FLAGS_HEAD_ID_VALID;
+        hdr->head_id = head_id;
+    }
+
+    st24_le_p(&hdr->flags, flags);
 }
 
 static const QemuUUID gen_media_uuid = {
@@ -1637,7 +1664,13 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 }
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -1675,7 +1708,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 
     memset(&gem, 0, sizeof(gem));
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
 
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
@@ -1719,7 +1755,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
+                               uint32_t flags,
+                               bool has_maint_op_class, uint8_t maint_op_class,
+                               bool has_maint_op_subclass,
+                               uint8_t maint_op_subclass,
+                               bool has_ld_id, uint16_t ld_id,
+                               bool has_head_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -1762,7 +1804,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 
     memset(&dram, 0, sizeof(dram));
     cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
     dram.descriptor = descriptor;
     dram.type = type;
@@ -1822,7 +1867,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
@@ -1861,7 +1912,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
 
     memset(&module, 0, sizeof(module));
     cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            has_maint_op_class, maint_op_class,
+                            has_maint_op_subclass, maint_op_subclass,
+                            has_ld_id, ld_id, has_head_id, head_id);
 
     module.type = type;
     module.health_status = health_status;
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..91b1478114 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -14,7 +14,13 @@
 #include "qapi/qapi-commands-cxl.h"
 
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -23,7 +29,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp) {}
 
-void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
+                               uint32_t flags,
+                               bool has_maint_op_class, uint8_t maint_op_class,
+                               bool has_maint_op_subclass,
+                               uint8_t maint_op_subclass,
+                               bool has_ld_id, uint16_t ld_id,
+                               bool has_head_id, uint8_t head_id,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -38,7 +50,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint8_t type,
+                                        uint32_t flags, bool has_maint_op_class,
+                                        uint8_t maint_op_class,
+                                        bool has_maint_op_subclass,
+                                        uint8_t maint_op_subclass,
+                                        bool has_ld_id, uint16_t ld_id,
+                                        bool has_head_id, uint8_t head_id,
+                                        uint8_t type,
                                         uint8_t health_status,
                                         uint8_t media_status,
                                         uint8_t additional_status,
-- 
2.48.1

