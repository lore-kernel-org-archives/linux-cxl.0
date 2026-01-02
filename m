Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D03C8CE
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367075; cv=none; b=usm2spLevdpt3kLnRC239MXbO2NK15bdA01aAMuLBxFSjhvDRPuQnLNxDPakHJKhn5XO+IFyamnjxnlFwryuRfTCdCMKL3M+22RZYLGEITH0o2INh8JN5LA0iFMS0J62x/h1eVJRrALVBErle3wGSTZYrRGbeWaGLkoptd9cI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367075; c=relaxed/simple;
	bh=p5BaLbrtOGF7vUpZybuxuDXuctI/OxR7WCr8OAlfCZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouXnNbMCtFkhiIlisrqL1PqbswjK8qspz2cWet7R5alQSSc5wZvvxhKXk5isk5lWIbIJeUaaUGlJbkZQfCHOntJLl9AnXQytPTDpldegWYCpQECCEvtb1b4JB95d8ayVJfHWsQzlJuSVttu+7Vt+tQQidB7zqwyesT6J7ILafsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djS3C55DDzJ46BG;
	Fri,  2 Jan 2026 23:16:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 56A9740569;
	Fri,  2 Jan 2026 23:17:51 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:17:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory module event record
Date: Fri, 2 Jan 2026 15:15:12 +0000
Message-ID: <20260102151512.460766-6-Jonathan.Cameron@huawei.com>
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

CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
event record has updated with following new fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL memory module
event reporting and QMP command to inject memory module event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json               | 12 +++++++++++-
 include/hw/cxl/cxl_events.h |  7 +++++--
 hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  4 ++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 3e4bad4ad0..752d46cda2 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -242,6 +242,14 @@
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
@@ -251,7 +259,9 @@
             'life-used': 'uint8', 'temperature' : 'int16',
             'dirty-shutdown-count': 'uint32',
             'corrected-volatile-error-count': 'uint32',
-            'corrected-persistent-error-count': 'uint32'
+            'corrected-persistent-error-count': 'uint32',
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            'sub-type':'uint8'
             }}
 
 ##
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
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3da538bafb..4dc9b223f4 100644
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
index 231dda263f..98292a931c 100644
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
2.48.1

