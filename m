Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633752D3ED1
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118566; cv=none; b=Ygx2k2To2xN6voADXsuErF5ZqTYkc4w/59rsuwAa1KESy6kIQhKAYMmFugJ7zlG235IU0Y7X7qMir8yScZ857GZYUP+MZWHshArQP8VBWNGLV2By5in3bHYhfu3NfB4RGBTAA8p57OL5XgyZsmtuoWAmpoReG6pDvI39QkxnQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118566; c=relaxed/simple;
	bh=FlQNXm99NxtTfIjxVR7VH8Rbchi/y0DuHLaBIwWJJig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E42x6KJK82ZdoJ2sYfrvp04zUg4FdAbOkShhSwilzVrTsTpk1r4YWvEvO0LjXqkNYX650wmNCDSuxxmwZQdh9b4o2Qux7SZXItesMCAve5sGGhqfAo+DG3Anrv2rkxDQmC+Z+4FplvYaTkspdPHxrknGdEwVQCXyRv09K6nbW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bm6Z54CS2z6L5Hc;
	Tue, 22 Jul 2025 01:18:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 71840140277;
	Tue, 22 Jul 2025 01:22:41 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.155.20) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Jul 2025 19:22:40 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <fan.ni@samsung.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH qemu v4 3/7] hw/cxl/events: Updates for rev3.2 DRAM event record
Date: Mon, 21 Jul 2025 18:22:24 +0100
Message-ID: <20250721172228.2118-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250721172228.2118-1-shiju.jose@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500007.china.huawei.com (7.182.85.172)

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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  7 +++++++
 include/hw/cxl/cxl_events.h |  9 ++++++--
 qapi/cxl.json               | 26 ++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a10e6bf518..afe5ceb1c9 100644
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
+                               bool has_comp_id_pldm, uint8_t is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1888,6 +1901,35 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
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
+
+    dram.sub_type = sub_type;
+
     stw_le_p(&dram.validity_flags, valid_flags);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 28eb880b30..c3cd97b5b7 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm,
+                               uint8_t is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 352f9891bd..a3c5f2ec20 100644
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
diff --git a/qapi/cxl.json b/qapi/cxl.json
index e8060d16f7..f84088c0b9 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -171,6 +171,26 @@
 # @correction-mask: Bits within each nibble.  Used in order of bits
 #     set in the nibble-mask.  Up to 4 nibbles may be covered.
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
+#
+# @is-comp-id-pldm: Flag represents device specific component identifier
+#     format is PLDM or not.
+#
+# @sub-channel: The sub-channel of the memory event location.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
+#
+# @cvme-count: Corrected volatile memory error count at event.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
+#
+# @sub-type: Memory event sub-type.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
+#
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-dram-event',
@@ -181,7 +201,11 @@
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
-            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
+            '*component-id': 'str', '*is-comp-id-pldm':'uint8',
+            '*sub-channel':'uint8',
+            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
+            'sub-type':'uint8'
            }}
 
 ##
-- 
2.43.0

