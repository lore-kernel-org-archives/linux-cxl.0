Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED4318BA6
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464291; cv=none; b=aTIWe99gxw9eRgMM4zXkXDefbs/nSl40m0zM8xkevawSWC/itjAANre3+nzUQ1zBnKCAcSeN0do3N/fFFnZDx4OI0TJQvlA6kcpWqaTCxGL01mZ5qeriMz8i7LPEWkMAKQynl3FJsUz5cHHN0RprYKOJgIUFgEqv0ySCzEeH+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464291; c=relaxed/simple;
	bh=qBA/X+nldghfrRNr0Run9BdyHV58kWzmRCqgYsxkMTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PApL2OWK4zGi39q/T9Zd9/A/BQxmXiaN8BsCa3wyK8S/NIOYxGtBc2YEy8298Oa3a73lGd0qIiqbeX6sxW2X2psJ/sLJtRDZi8aApgpE+TKcNXQxQLqroTJNUQc4zsbwgwksL81hmYloBAs6ltFpUQyMJjhcTgVQFhyrQAcFZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwmW4qzZzHnGjr;
	Thu, 26 Mar 2026 02:44:11 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F6D74056B;
	Thu, 26 Mar 2026 02:44:47 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:44:46 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 3/9] hw/cxl: Hook up tagged host memory backends at runtime for DC extents
Date: Wed, 25 Mar 2026 18:42:51 +0000
Message-ID: <20260325184259.366-4-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260325184259.366-1-alireza.sanaee@huawei.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
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

When a type3 device is created with dc-regions-total-size instead of an
initial volatile-dc-memdev, prescriptive DC add requests need a way to name
the backend to attach to the accepted extent.

Teach the QMP and mailbox paths to carry that tag through the lazy
dynamic-capacity flow. In the add path, resolve the tag to a generic host
memory backend, reject reuse of an already-mapped backend, and verify that
the backend size matches the requested extent.

Store the selected backend metadata on the pending extent so a later patch
can bind the accepted extent to the chosen backend when the host
acknowledges the request.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c |  8 ----
 hw/mem/cxl_type3.c         | 77 ++++++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e6e136cf44..c83b5f90d4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4270,10 +4270,6 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     int i, rc;
 
-    if (ct3d->dc.total_capacity_cmd) {
-        return CXL_MBOX_UNSUPPORTED;
-    }
-
     switch (in->selection_policy) {
         case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
             /* Adding extents exceeds device's extent tracking ability. */
@@ -4361,10 +4357,6 @@ static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     int i, rc;
 
-    if (ct3d->dc.total_capacity_cmd) {
-        return CXL_MBOX_UNSUPPORTED;
-    }
-
     switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
         case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
             CXLDCExtentList updated_list;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 45fb6c55bc..569184975f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "qemu/uuid.h"
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -2289,13 +2290,42 @@ bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
     return false;
 }
 
+static bool cxl_device_lazy_dynamic_capacity_init(CXLType3Dev *ct3d,
+                                                  const char *tag,
+                                                  Error **errp)
+{
+    MemoryRegion *dc_mr;
+
+    ct3d->dc.host_dc = host_memory_backend_find_by_tag(tag);
+    if (!ct3d->dc.host_dc) {
+        error_setg(errp, "dynamic capacity must have a backing device");
+        return false;
+    }
+
+    dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+    if (!dc_mr) {
+        error_setg(errp, "dynamic capacity must have a backing device");
+        return false;
+    }
+
+    if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+        error_setg(errp,
+                   "memory backend %s is already mapped and cannot be reused",
+                   object_get_canonical_path_component(
+                       OBJECT(ct3d->dc.host_dc)));
+        return false;
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
         uint16_t hid, CXLDCEventType type, uint8_t rid,
-        CxlDynamicCapacityExtentList *records, Error **errp)
+        const char *tag, CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
     CXLType3Dev *dcd;
@@ -2303,7 +2333,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint64_t dpa, offset, len, block_size;
+    uint64_t dpa, offset, block_size;
+    uint64_t len = 0;
     g_autofree unsigned long *blk_bitmap = NULL;
     int i;
 
@@ -2319,13 +2350,6 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         return;
     }
 
-    if (dcd->dc.total_capacity_cmd) {
-        error_setg(errp,
-                   "dc-regions-total-size is set: extent add/release via QMP "
-                   "not yet supported without a backing device at init");
-        return;
-    }
-
     if (rid >= dcd->dc.num_regions) {
         error_setg(errp, "region id is too large");
         return;
@@ -2334,6 +2358,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
 
     /* Sanity check and count the extents */
+    QemuUUID uuid;
+    qemu_uuid_parse(tag, &uuid);
     list = records;
     while (list) {
         offset = list->value->offset;
@@ -2392,6 +2418,31 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
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
@@ -2403,7 +2454,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
 
         extents[i].start_dpa = dpa;
         extents[i].len = len;
-        memset(extents[i].tag, 0, 0x10);
+        memcpy(extents[i].tag, &uuid.data, 0x10);
         extents[i].shared_seq = 0;
         if (type == DC_EVENT_ADD_CAPACITY) {
             group = cxl_insert_extent_to_extent_group(group,
@@ -2434,7 +2485,8 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
     case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
                                                       DC_EVENT_ADD_CAPACITY,
-                                                      region, extents, errp);
+                                                      region, tag,
+                                                      extents, errp);
         return;
     default:
         error_setg(errp, "Selection policy not supported");
@@ -2465,7 +2517,8 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     switch (removal_policy) {
     case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
-                                                      region, extents, errp);
+                                                      region, tag,
+                                                      extents, errp);
         return;
     default:
         error_setg(errp, "Removal policy not supported");
-- 
2.50.1 (Apple Git-155)

