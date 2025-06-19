Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8D3085A8
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346208; cv=none; b=DAY0mjigI9SdT95xLywY1wUE4HkYEt44hLniZeisvf1CgOdRvvGVYTrd4ugpBt8/z6oN6CBlQQkF45uvToeLFUIspZcqdagkg6PjIeek30KEV9UlxkGRfmR8a2RFKctm+E2A6JldLIYKL/LS4SBM0PlLmrCsQ0vwa+2CKkoHuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346208; c=relaxed/simple;
	bh=rIfoElqKIoAVr9AjrFrYzjjrbHNwb/Cd//c8hLs7rwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTftLLHs8j6TbFynn7+oSIFtet9hf3PmhiDe5kR6SwIHjuLt9zBQyK/1BLq4RNYr2+fDgL+38Q1KhYCoVruOq0UM+EtHnoNGYbv/KNPVzqniLGKk35QoTv2pe9WvO0ENUxi4W7BZrfV6jVSlUJd8qa0aiLwUFcredoTijLSX9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPKH6PQgz6L5sL;
	Thu, 19 Jun 2025 23:14:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id EE8161400D9;
	Thu, 19 Jun 2025 23:16:43 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:43 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 4/7] hw/cxl/events: Updates for rev3.2 memory module event record
Date: Thu, 19 Jun 2025 16:16:16 +0100
Message-ID: <20250619151619.1695-5-shiju.jose@huawei.com>
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

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 16 ++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  2 ++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 10 +++++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b99a100fe0..81774bf4b9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2054,6 +2054,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
     }
 }
 
+#define CXL_MMER_VALID_COMPONENT                        BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
+
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t flags, uint8_t class,
                                         uint8_t subclass, uint16_t ld_id,
@@ -2066,11 +2069,14 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
     CXLEventMemoryModule module;
     CXLEventRecordHdr *hdr = &module.hdr;
+    uint16_t valid_flags = 0;
     CXLDeviceState *cxlds;
     CXLType3Dev *ct3d;
     uint8_t enc_log;
@@ -2111,6 +2117,16 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     stl_le_p(&module.corrected_persistent_error_count,
              corrected_persist_error_count);
 
+    if (component_id) {
+        strncpy((char *)module.component_id, component_id,
+                sizeof(module.component_id) - 1);
+        valid_flags |= CXL_MMER_VALID_COMPONENT;
+        valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
+    }
+    module.sub_type = sub_type;
+
+    stw_le_p(&module.validity_flags, valid_flags);
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 26161c086a..04c36ed262 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -61,6 +61,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a3c5f2ec20..4a7836ad72 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,7 +166,7 @@ typedef struct CXLEventDram {
 
 /*
  * Memory Module Event Record
- * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
+ * CXL r3.2 Section 8.2.10.2.1.3: Table 8-59
  * All fields little endian.
  */
 typedef struct CXLEventMemoryModule {
@@ -180,7 +180,10 @@ typedef struct CXLEventMemoryModule {
     uint32_t dirty_shutdown_count;
     uint32_t corrected_volatile_error_count;
     uint32_t corrected_persistent_error_count;
-    uint8_t reserved[0x3d];
+    uint16_t validity_flags;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_type;
+    uint8_t reserved[0x2a];
 } QEMU_PACKED CXLEventMemoryModule;
 
 /*
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 0ba3a8e0f3..0a40596a30 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -253,6 +253,13 @@
 # @corrected-persistent-error-count: Total number of correctable
 #     errors in persistent memory
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#     See CXL r3.2 Table 8-59 Memory Module Event Record.
+#
+# @sub-type: Device event sub-type.
+#     See CXL r3.2 Table 8-59 Memory Module Event Record.
+#
 # Since: 8.1
 ##
 { 'command': 'cxl-inject-memory-module-event',
@@ -264,7 +271,8 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', 'sub-type':'uint8'
             }}
 
 ##
-- 
2.43.0

