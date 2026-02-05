Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3512BFC85
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290789; cv=none; b=K0zDzrBK8Uc23hknU6d/XO1gdrVJDbXPAZVNVQDLLLAXkwAxOv4RH720rK+ICx1BSKRMozh8BV3GFR11gfWnL4TRFjJ4eiZpkGgrSjA31r23KM9nHH37jqmQibAbHNeGRDpcHgNPgnvSYFUjCYm5XXmx78eDIJLHOVG0OnNfDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290789; c=relaxed/simple;
	bh=BzAm02Lylqy6O/uXf1TyVCxCqRB0JsXUbGxRbs1XfIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixgaC8xBFomFRnhvOTvZbush31xb9fYvk9RyDa0iuMBt5a1MuswF6ILkrQxQCX9Gg2DNTL8UKyyfeK8gaWLp4PTg2/eNUt8lIt3kY2cTGqemDlzAwzkUVBtlN25bfoIguRguMlJyo2gA4dmbchsWfinSnMWQDVatAIKZkk7x5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6FKX3HNDzHnGhl;
	Thu,  5 Feb 2026 19:26:24 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C5E5140569;
	Thu,  5 Feb 2026 19:26:26 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Feb 2026 11:26:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, Ravi Shankar <venkataravis@micron.com>,
	<armbru@redhat.com>, Ravi Jonnalagadda <ravis.opensrc@gmail.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH qemu v5 5/5] hw/cxl/events: Updates for rev3.2 memory module event record
Date: Thu, 5 Feb 2026 11:23:50 +0000
Message-ID: <20260205112350.60681-6-Jonathan.Cameron@huawei.com>
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

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-59, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Updated all references for this command to the CXL r3.2
specification.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Fix table reference in commit message. 8-50 is completely
    unrelated to this change, should be 8-59 (Ravi)
---
 qapi/cxl.json               | 30 ++++++++++++++++++++----------
 include/hw/cxl/cxl_events.h |  7 +++++--
 hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  4 ++++
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 1dc8b08ca301..81d6198ba030 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -214,20 +214,20 @@
 ##
 # @CXLMemModuleEvent:
 #
-# Event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3).
+# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
-# @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
+# @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
 #
-# @health-status: Overall health summary bitmap.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Health Status for bit
+# @health-status: Overall health summary bitmap.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Health Status for bit
 #     definitions.
 #
-# @media-status: Overall media health summary.  See CXL r3.0 Table
-#     8-100 Get Health Info Output Payload, Media Status for bit
+# @media-status: Overall media health summary.  See CXL r3.2 Table
+#     8-148 Get Health Info Output Payload, Media Status for bit
 #     definitions.
 #
-# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
+# @additional-status: See CXL r3.2 Table 8-148 Get Health Info Output
 #     Payload, Additional Status for subfield definitions.
 #
 # @life-used: Percentage (0-100) of factory expected life span.
@@ -243,6 +243,14 @@
 # @corrected-persistent-error-count: Total number of correctable
 #     errors in persistent memory
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-type: Device event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLMemModuleEvent',
@@ -252,14 +260,16 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            'sub-type':'uint8'
             }}
 
 ##
 # @cxl-inject-memory-module-event:
 #
-# Inject an event record for a Memory Module Event (CXL r3.0
-# 8.2.9.2.1.3).  This event includes a copy of the Device Health info
+# Inject an event record for a Memory Module Event (CXL r3.2
+# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
 # at the time of the event.
 #
 # Since: 8.1
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a3c5f2ec20e6..4a7836ad7227 100644
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
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index be99d20fafb4..acb75f8f01e3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1937,6 +1937,9 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_MMER_VALID_COMPONENT                        BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT              BIT(1)
+
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
                                         uint8_t maint_op_class,
@@ -1953,11 +1956,16 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
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
@@ -2000,6 +2008,18 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     stl_le_p(&module.corrected_persistent_error_count,
              corrected_persist_error_count);
 
+    if (component_id) {
+        strncpy((char *)module.component_id, component_id,
+                sizeof(module.component_id) - 1);
+        valid_flags |= CXL_MMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+    module.sub_type = sub_type;
+
+    stw_le_p(&module.validity_flags, valid_flags);
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 231dda263fa4..98292a931c16 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -78,6 +78,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
                                         uint32_t corrected_persist_error_count,
+                                        const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
-- 
2.51.0

