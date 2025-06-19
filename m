Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FED21B199
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346208; cv=none; b=Y0PEmKGcl3lhqCtUHz3p+nHUVd5/flCI+cfDJw983BiVpH7paJ1SRtnzgVpvBt3LonTO9eZPh2YajO1MWj00NBiWaFMpefjBHUzpeXkSj9VDNCDbkM/mV7E93nK8o3FZux4VxnPbmGRgfX8t9nkpW00WqydsbrDYKbnNX5xoQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346208; c=relaxed/simple;
	bh=4y3E5f8waoQtg8MprmSvi5pthpclu+UfIaChNsUnjjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1UCyGfK6K/6TRACFJog2Da+tlBs927Ium0vGsTapOmbCTwTkYyemKMigAswJ3ZfpgfMPksVpJI17BLjFJ1w2lsppKCcAbl6xU6XukGzFRwayV5TPl7B8HdeztMYaWXyzrIV2sH/CzMmNAsaPidzwkYzUIs4W0B/6XBgfpEwcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPKH1Xttz6L5sP;
	Thu, 19 Jun 2025 23:14:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4462F1400D9;
	Thu, 19 Jun 2025 23:16:43 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:42 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 3/7] hw/cxl/events: Updates for rev3.2 DRAM event record
Date: Thu, 19 Jun 2025 16:16:15 +0100
Message-ID: <20250619151619.1695-4-shiju.jose@huawei.com>
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

CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
has updated with following new fields.
1. Component Identifier
2. Sub-channel of the memory event location
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Volatile Memory Error Count at Event
5. Memory Event Sub-Type

Add updates for the above spec changes in the CXL DRAM event
reporting and QMP command to inject DRAM event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 24 ++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  5 +++++
 include/hw/cxl/cxl_events.h |  9 +++++++--
 qapi/cxl.json               | 22 +++++++++++++++++++++-
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 410ff445d0..b99a100fe0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1924,6 +1924,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_ROW                              BIT(5)
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
+#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
+#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags,
                                uint8_t class, uint8_t subclass,
@@ -1939,6 +1942,11 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               uint8_t cme_ev_flags,
+                               uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -2023,6 +2031,22 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
         valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
     }
 
+    if (component_id) {
+        strncpy((char *)dram.component_id, component_id,
+                sizeof(dram.component_id) - 1);
+        valid_flags |= CXL_DRAM_VALID_COMPONENT;
+        valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
+    }
+
+    if (has_sub_channel) {
+        dram.sub_channel = sub_channel;
+        valid_flags |= CXL_DRAM_VALID_SUB_CHANNEL;
+    }
+
+    dram.cme_ev_flags = cme_ev_flags;
+    st24_le_p(dram.cvme_count, cvme_count);
+    dram.sub_type = sub_type;
+
     stw_le_p(&dram.validity_flags, valid_flags);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index b2a11bded8..26161c086a 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -42,6 +42,11 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               uint8_t cme_ev_flags,
+                               uint32_t cvme_count,
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
index dd01d50c25..0ba3a8e0f3 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -167,6 +167,23 @@
 # @correction-mask: Bits within each nibble.  Used in order of bits
 #     set in the nibble-mask.  Up to 4 nibbles may be covered.
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#     See CXL r3.2 Table 8-58 DRAM Event Record.
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
@@ -177,7 +194,10 @@
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
-            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
+            '*component-id': 'str', '*sub-channel':'uint8',
+            'cme-ev-flags':'uint8', 'cvme-count':'uint32',
+            'sub-type':'uint8'
            }}
 
 ##
-- 
2.43.0

