Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2A3A7F4C
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290758; cv=none; b=lBXAmnEE/PmzJxjdDlekeVIgdHhneVtsJgSmk7sBsC/ogE/SxBvs4Eg48vBTRomVO6Nh69bJqJpBgex36sKF1QjJGJltj9XIWs6ZrpCYFpFCMYSLa/xvZCCcH62H3jfq5wNy68J6KMzA1YHTiDbttKaP8lOc4Ox3EaivWgtZ1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290758; c=relaxed/simple;
	bh=Iwjml6eRYSQmgJInHx+SzPBakV5PMLnI42um9NmDgnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOSe4M8E0semb1wUJIVpUtrh9vCB1CAtfUmBWhqXOwGatwDWfG7MzN6UqhyB5pHNqhf0T1RJeDvt5X9L5ffgKwH9HS5SfQQevmtBmwXGZs+IUxkvJvzvGoG1O2CdnIWzCHVBFbmAOX46Hk8FPl5Wq01wYuyC2qpO/cGJVwDXLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6FJx3s2LzHnGd2;
	Thu,  5 Feb 2026 19:25:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D8D6240569;
	Thu,  5 Feb 2026 19:25:55 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Feb 2026 11:25:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, Ravi Shankar <venkataravis@micron.com>,
	<armbru@redhat.com>, Ravi Jonnalagadda <ravis.opensrc@gmail.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH qemu v5 4/5] hw/cxl/events: Updates for rev3.2 DRAM event record
Date: Thu, 5 Feb 2026 11:23:49 +0000
Message-ID: <20260205112350.60681-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205112350.60681-1-Jonathan.Cameron@huawei.com>
References: <20260205112350.60681-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
has updated with following new fields.
1. Component Identifier
2. Sub-channel of the memory event location
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Volatile Memory Error Count at Event
5. Memory Event Sub-Type

Add updates for the above spec changes in the CXL DRAM event
reporting and QMP command to inject DRAM event.

In order to ensure consistency update all specification references
for this command to CXL r3.2.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: Move setting of gem.descriptor later to ensure update is correctly
    stored (Ravi)
---
 qapi/cxl.json               | 33 ++++++++++++++++++++++------
 include/hw/cxl/cxl_events.h |  9 ++++++--
 hw/mem/cxl_type3.c          | 44 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  7 ++++++
 4 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 4ff66fc6c16c..1dc8b08ca301 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -131,21 +131,21 @@
 ##
 # @CXLDRAMEvent:
 #
-# Event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
-#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
+#     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
 #     Event Record, Physical Address.
 #
 # @descriptor: Memory Event Descriptor with additional memory event
-#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
+#     information.  See CXL r3.2 Table 8-58 DRAM Event Record, Memory
 #     Event Descriptor for bit definitions.
 #
-# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
+# @type: Type of memory event that occurred.  See CXL r3.2 Table 8-58
 #     DRAM Event Record, Memory Event Type for possible values.
 #
 # @transaction-type: Type of first transaction that caused the event
-#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
+#     to occur.  See CXL r3.2 Table 8-58 DRAM Event Record,
 #     Transaction Type for possible values.
 #
 # @channel: The channel of the memory event location.  A channel is an
@@ -169,6 +169,21 @@
 # @correction-mask: Bits within each nibble.  Used in order of bits
 #     set in the nibble-mask.  Up to 4 nibbles may be covered.
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-channel: The sub-channel of the memory event location.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cvme-count: Corrected volatile memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLDRAMEvent',
@@ -177,13 +192,17 @@
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
-            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            '*sub-channel':'uint8',
+            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
+            'sub-type':'uint8'
            }}
 
 ##
 # @cxl-inject-dram-event:
 #
-# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 # This event type is reported via one of the event logs
 # specified via the log parameter.
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 352f9891bd36..a3c5f2ec20e6 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -138,7 +138,7 @@ typedef struct CXLEventGenMedia {
 
 /*
  * DRAM Event Record
- * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
+ * CXL r3.2 Section 8.2.10.2.1.2: Table 8-58
  * All fields little endian.
  */
 typedef struct CXLEventDram {
@@ -156,7 +156,12 @@ typedef struct CXLEventDram {
     uint8_t row[3];
     uint16_t column;
     uint64_t correction_mask[4];
-    uint8_t reserved[0x17];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    uint8_t cme_ev_flags;
+    uint8_t cvme_count[3];
+    uint8_t sub_type;
+    uint8_t reserved;
 } QEMU_PACKED CXLEventDram;
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 229be8870864..be99d20fafb4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1783,6 +1783,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_ROW                              BIT(5)
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
+#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
+#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
+
+#define CXL_DRAM_EV_DESC_UCE                            BIT(0)
+#define CXL_DRAM_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_DRAM_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                uint32_t flags,
@@ -1802,6 +1809,12 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm, bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1838,7 +1851,6 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                             has_maint_op_subclass, maint_op_subclass,
                             has_ld_id, ld_id, has_head_id, head_id);
     stq_le_p(&dram.phys_addr, dpa);
-    dram.descriptor = descriptor;
     dram.type = type;
     dram.transaction_type = transaction_type;
 
@@ -1888,6 +1900,36 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
         valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
     }
 
+    if (component_id) {
+        strncpy((char *)dram.component_id, component_id,
+                sizeof(dram.component_id) - 1);
+        valid_flags |= CXL_DRAM_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+
+    if (has_sub_channel) {
+        dram.sub_channel = sub_channel;
+        valid_flags |= CXL_DRAM_VALID_SUB_CHANNEL;
+    }
+
+    if (has_cme_ev_flags) {
+        dram.cme_ev_flags = cme_ev_flags;
+    } else {
+        dram.cme_ev_flags = 0;
+    }
+
+    if (has_cvme_count) {
+        descriptor |= CXL_DRAM_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(dram.cvme_count, cvme_count);
+    } else {
+        st24_le_p(dram.cvme_count, 0);
+    }
+    dram.descriptor = descriptor;
+
+    dram.sub_type = sub_type;
+
     stw_le_p(&dram.validity_flags, valid_flags);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 2047e9784694..231dda263fa4 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm,
+                               bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-- 
2.51.0

