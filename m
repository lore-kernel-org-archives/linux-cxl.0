Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92329E0E6
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821440; cv=none; b=ZKLLkVyFvPS7LzBKmEaM3HqO5UvxLuFG1/sRnIn1KIjHVuD3SZoOoKB0WKj9zqbWHyGju//o2LiG/mb5lR9VNtwxqufenQYGolCeBKsan14PnYRZQjy+9arDNQz+U+AH3sKwhbYJwHyfodghtn1OBEprKSYd3tJQ0CfyLmOfMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821440; c=relaxed/simple;
	bh=FtSARSCuG6w3rRjkFhBSQkap5OY7vq8Ko8wSM4YtbDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcfC13ojI6LRltex1XnOcEysqcVUWeOAk7CJvPzgxFneWuTtXIWJcO3BFzGSZj2CasGFTs7gePDT6nWHe7ygXhUXHoBm786x3K/5uaun8oxxU+gKUyAWVp0dwz+Jcde0XxwKWGVRzhB9Y0VZ3oYfo7hvIa7AqVkCQ//UoJXC48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvnwG71bNzHnHKv;
	Mon, 19 Jan 2026 19:16:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E40040584;
	Mon, 19 Jan 2026 19:17:16 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 11:17:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu v4 3/5] hw/cxl/events: Updates for rev3.2 general media event record
Date: Mon, 19 Jan 2026 11:15:40 +0000
Message-ID: <20260119111542.788389-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
table has updated with following new fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type
4. Support for component ID in the PLDM format.

Add updates for the above spec changes in the CXL general media event
reporting and QMP command to inject general media event.

In order to have one consistent source of references, update all to
references for this command to CXL r3.2.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: Update the spec reference in the related command to 3.2 as well.
(Markus)
v3: Update all references to 3.2 for consistency.
---
 qapi/cxl.json               | 29 +++++++++++++++++++++--------
 include/hw/cxl/cxl_events.h |  7 +++++--
 hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  6 ++++++
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 82001c0591d8..4ff66fc6c16c 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -64,22 +64,22 @@
 ##
 # @CXLGeneralMediaEvent:
 #
-# Event record for a General Media Event (CXL r3.0 8.2.9.2.1.1).
+# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-43 General
+#     lower bits include some flags.  See CXL r3.2 Table 8-57 General
 #     Media Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-43 General Media Event
+#     information.  See CXL r3.2 Table 8-57 General Media Event
 #     Record, Memory Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-57
 #     General Media Event Record, Memory Event Type for possible
 #     values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
+#     to occur.  See CXL r3-2 Table 8-57 General Media Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -94,6 +94,16 @@
 # @component-id: Device specific component identifier for the event.
 #     May describe a field replaceable sub-component of the device.
 #
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cme-count: Corrected memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLGeneralMediaEvent',
@@ -101,13 +111,16 @@
   'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
-            '*device': 'uint32', '*component-id': 'str' } }
+            '*device': 'uint32', '*component-id': 'str',
+            '*is-comp-id-pldm':'bool',
+            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
+            'sub-type':'uint8' } }
 
 ##
 # @cxl-inject-general-media-event:
 #
-# Inject an event record for a General Media Event (CXL r3.0
-# 8.2.9.2.1.1).  This event type is reported via one of the event
+# Inject an event record for a General Media Event (CXL r3.2
+# 8.2.10.2.1.1).  This event type is reported via one of the event
 # logs specified via the log parameter.
 #
 # Since: 8.1
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4d9cfdb621ea..352f9891bd36 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
 
 /*
  * General Media Event Record
- * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
+ * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
-#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
 typedef struct CXLEventGenMedia {
     CXLEventRecordHdr hdr;
     uint64_t phys_addr;
@@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
     uint8_t rank;
     uint8_t device[3];
     uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t cme_ev_flags;
+    uint8_t cme_count[3];
+    uint8_t sub_type;
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 371bd4dc6ab2..d03a9f0edc29 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1646,6 +1646,11 @@ static const QemuUUID memory_module_uuid = {
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
 #define CXL_GMER_VALID_COMPONENT                        BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
+
+#define CXL_GMER_EV_DESC_UCE                            BIT(0)
+#define CXL_GMER_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_GMER_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 {
@@ -1677,6 +1682,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1737,10 +1748,28 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         strncpy((char *)gem.component_id, component_id,
                 sizeof(gem.component_id) - 1);
         valid_flags |= CXL_GMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
+        }
     }
 
     stw_le_p(&gem.validity_flags, valid_flags);
 
+    if (has_cme_ev_flags) {
+        gem.cme_ev_flags = cme_ev_flags;
+    } else {
+        gem.cme_ev_flags = 0;
+    }
+
+    if (has_cme_count) {
+        descriptor |= CXL_GMER_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(gem.cme_count, cme_count);
+    } else {
+        st24_le_p(gem.cme_count, 0);
+    }
+
+    gem.sub_type = sub_type;
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 91b1478114d9..2047e9784694 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -27,6 +27,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
-- 
2.48.1

