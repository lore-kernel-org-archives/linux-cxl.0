Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43B324B0F
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284200; cv=none; b=Pe/O5LgJ0nFHpxLmCVLUq3qBXWJZ90PZ5u95S+mnQlmMhJtlZVC8PaDMN6JUaA7n5yhjJy3i+cPai8ZbspJNeEZ2dBeB+7DzY0SMMWE8pNu58rRpyqBM5jUSvGpQO56UXN3iHvjLvRjtAzotUCqo0O1fQnvQDSdjfMXwYivdw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284200; c=relaxed/simple;
	bh=X4u6T1lQYlBc0Pwvf6ILv50teyBjcmHZGGBdGATVfU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du2EEX7ZjTiZ1wDjKuF9JXdTog8M8LONSzSlGgav63gK+NbI0RhhfuNARWf2iN0yQfzijm+FdiVr3znVOmkRMXwJs3zSp9CnPUOLm+HEf1ycsYkKbqUTJyhLBnwXfn9EdnPUeIPohnvSxGeHsgO1C4Iadu672FFQYFtiHqU5zcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWxG5ZhrzHnGch;
	Fri, 28 Nov 2025 06:55:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 208491402E9;
	Fri, 28 Nov 2025 06:56:36 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:56:35 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 2/7] hw/cxl: Allow initializing type3 device with no backing device
Date: Thu, 27 Nov 2025 22:55:20 +0000
Message-ID: <20251127225526.700-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20251127225526.700-1-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Allow creating a type3 device without any backing device for DC. In
Dynamic Capacity scenarios, memory can show up asynchronously and it can
be coming from difference resources, RAM, PMEM, FILE BACKED. For these
cases, only one parameter will be needed to know total size of DC which
is exposed by dc-total-regions-size.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/mem/cxl_type3.c          | 157 ++++++++++++++++++++++++++----------
 include/hw/cxl/cxl_device.h |   1 +
 2 files changed, 115 insertions(+), 43 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 8cdb3bff7e..690b3ab658 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "hw/mem/tagged_mem.h"
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -190,12 +191,15 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     if (ct3d->dc.num_regions) {
-        if (!ct3d->dc.host_dc) {
-            return -EINVAL;
-        }
-        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-        if (!dc_mr) {
-            return -EINVAL;
+        /* Only check if DC is static */
+        if (ct3d->dc.total_capacity_cmd == 0) {
+            if (!ct3d->dc.host_dc) {
+                return -EINVAL;
+            }
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
         }
         len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
     }
@@ -216,7 +220,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
 
-    if (dc_mr) {
+    if (dc_mr || ct3d->dc.total_capacity_cmd) {
         int i;
         uint64_t region_base = vmr_size + pmr_size;
 
@@ -651,8 +655,13 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     MemoryRegion *mr;
     uint64_t dc_size;
 
-    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-    dc_size = memory_region_size(mr);
+    if (ct3d->dc.total_capacity_cmd != 0) {
+        dc_size = ct3d->dc.total_capacity_cmd;
+    } else {
+        mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(mr);
+    }
+
     region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
 
     if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
@@ -810,39 +819,43 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 
     ct3d->dc.total_capacity = 0;
     if (ct3d->dc.num_regions > 0) {
-        MemoryRegion *dc_mr;
-        char *dc_name;
+        if (ct3d->dc.total_capacity_cmd == 0) {
+            MemoryRegion *dc_mr;
+            char *dc_name;
 
-        if (!ct3d->dc.host_dc) {
-            error_setg(errp, "dynamic capacity must have a backing device");
-            return false;
-        }
+            if (!ct3d->dc.host_dc) {
+                error_setg(errp, "dynamic capacity must have a backing device");
+                return false;
+            }
 
-        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
-        if (!dc_mr) {
-            error_setg(errp, "dynamic capacity must have a backing device");
-            return false;
-        }
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                error_setg(errp, "dynamic capacity must have a backing device");
+                return false;
+            }
 
-        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
-            error_setg(errp, "memory backend %s can't be used multiple times.",
-               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
-            return false;
-        }
-        /*
-         * Set DC regions as volatile for now, non-volatile support can
-         * be added in the future if needed.
-         */
-        memory_region_set_nonvolatile(dc_mr, false);
-        memory_region_set_enabled(dc_mr, true);
-        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
-        if (ds->id) {
-            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
-        } else {
-            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+            if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+                error_setg(errp,
+                           "memory backend %s can't be used multiple times.",
+                           object_get_canonical_path_component(
+                               OBJECT(ct3d->dc.host_dc)));
+                return false;
+            }
+            /*
+             * Set DC regions as volatile for now, non-volatile support can
+             * be added in the future if needed.
+             */
+            memory_region_set_nonvolatile(dc_mr, false);
+            memory_region_set_enabled(dc_mr, true);
+            host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+            if (ds->id) {
+                dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+            } else {
+                dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+            }
+            address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+            g_free(dc_name);
         }
-        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
-        g_free(dc_name);
 
         if (!cxl_create_dc_regions(ct3d, errp)) {
             error_append_hint(errp, "setup DC regions failed");
@@ -1284,6 +1297,8 @@ static const Property ct3_props[] = {
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_SIZE("dc-regions-total-size", CXLType3Dev,
+                     dc.total_capacity_cmd, 0),
     DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLType3Dev,
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
@@ -1952,12 +1967,38 @@ bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
     return false;
 }
 
+static bool cxl_device_lazy_dynamic_capacity_init(CXLType3Dev *ct3d,
+                                                  const char *tag, Error **errp)
+{
+    MemoryRegion *dc_mr;
+
+    ct3d->dc.host_dc = memory_backend_tagged_find_by_tag(tag, errp);
+    if (!ct3d->dc.host_dc) {
+        error_setg(errp, "dynamic capacity must have a backing device");
+        return false;
+    }
+
+    dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+    if (!dc_mr) {
+        error_setg(errp, "test dynamic capacity must have a backing device");
+        return false;
+    }
+
+    if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+        qemu_log("Warning: memory backend %s is already mapped. Reusing it.\n",
+               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
+        return true;
+    }
+
+    return true;
+}
+
 /*
  * The main function to process dynamic capacity event with extent list.
  * Currently DC extents add/release requests are processed.
  */
 static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
-        uint16_t hid, CXLDCEventType type, uint8_t rid,
+        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
         CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
@@ -1966,8 +2007,10 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint64_t dpa, offset, len, block_size;
+    uint64_t dpa, offset, block_size;
+    uint64_t len = 0;
     g_autofree unsigned long *blk_bitmap = NULL;
+    QemuUUID uuid;
     int i;
 
     obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
@@ -1996,6 +2039,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         offset = list->value->offset;
         len = list->value->len;
         dpa = offset + dcd->dc.regions[rid].base;
+        qemu_uuid_parse(tag, &uuid);
 
         if (len == 0) {
             error_setg(errp, "extent with 0 length is not allowed");
@@ -2049,6 +2093,31 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         num_extents++;
     }
 
+    if (type == DC_EVENT_ADD_CAPACITY && dcd->dc.total_capacity_cmd) {
+        MemoryRegion *host_dc_mr;
+        uint64_t size;
+
+        if (num_extents > 1) {
+            error_setg(errp, "Only single extent add is supported currently");
+            return;
+        }
+
+        if (!cxl_device_lazy_dynamic_capacity_init(dcd, tag, errp)) {
+            return;
+        }
+
+        host_dc_mr = host_memory_backend_get_memory(dcd->dc.host_dc);
+        size = memory_region_size(host_dc_mr);
+
+        if (size != len) {
+            error_setg(errp,
+                       "Host memory backend size 0x%" PRIx64
+                       " does not match extent length 0x%" PRIx64,
+                       size, len);
+            return;
+        }
+    }
+
     /* Create extent list for event being passed to host */
     i = 0;
     list = records;
@@ -2060,7 +2129,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
 
         extents[i].start_dpa = dpa;
         extents[i].len = len;
-        memset(extents[i].tag, 0, 0x10);
+        memcpy(extents[i].tag, &uuid.data, 0x10);
         extents[i].shared_seq = 0;
         if (type == DC_EVENT_ADD_CAPACITY) {
             group = cxl_insert_extent_to_extent_group(group,
@@ -2091,7 +2160,8 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
     case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
                                                       DC_EVENT_ADD_CAPACITY,
-                                                      region, extents, errp);
+                                                      region, tag, extents,
+                                                      errp);
         return;
     default:
         error_setg(errp, "Selection policy not supported");
@@ -2122,7 +2192,8 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     switch (removal_policy) {
     case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
-                                                      region, extents, errp);
+                                                      region, tag, extents,
+                                                      errp);
         return;
     default:
         error_setg(errp, "Removal policy not supported");
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1d199d035e..bfd1a97e03 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -633,6 +633,7 @@ struct CXLType3Dev {
          * memory region size.
          */
         uint64_t total_capacity; /* 256M aligned */
+        uint64_t total_capacity_cmd; /* 256M aligned */
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
-- 
2.43.0

