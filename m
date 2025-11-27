Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FD296BBC
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284235; cv=none; b=L3KDsspHSTapyUlUR+HVnX1CuK4ZxPDRoYwTpJtMmQ1mG7N6oaukXPl6KtMSV6HGnv26PZ0oMZ6JZ/cI9lJ7dayQ5Ibgg/21A94taE/URbZf2wYB62M1UGq92O/UElEm8WTjWcvC/KFGnYmFIhJzBYzAu/KM8EpPX/GRoRr9xZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284235; c=relaxed/simple;
	bh=XUI3ioTW+Bz2a6lIJPrnWmBdqG9cImOHN11zATucTCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOhEA2hlycUI+5FOrG7d4FZy6U304vQBdWxd6b1wvCp8Bv/Jee8NA/sSubbqbjlJqdOZEXptJLRNdGDBfe4lvxEU0hRGHz/XEOuLXWQvbKF++ZYhYh6xbL938G8yCPn+OEgkpTVOci5dxaF/YzFnQn8Z4PSe2le98k06I0wtkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWxv2Rm4zHnGcx;
	Fri, 28 Nov 2025 06:56:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A6B47140372;
	Fri, 28 Nov 2025 06:57:08 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:57:07 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 3/7] hw/cxl: Change Extent add/remove APIs for lazy memory backend.
Date: Thu, 27 Nov 2025 22:55:21 +0000
Message-ID: <20251127225526.700-4-alireza.sanaee@huawei.com>
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

Add extra information in each extent about fix memory window and
memory backend, because extent might be backed by different memory
backends, thus such information must be stored in the extent object.
Consequently, APIs should be changes to support extra members.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c           |  2 ++
 hw/cxl/cxl-mailbox-utils.c  | 42 ++++++++++++++++++++++++-------------
 hw/mem/cxl_type3.c          | 23 +++++++++++++++-----
 include/hw/cxl/cxl_device.h | 17 ++++++++++++---
 4 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 3a563af3bc..7c8fde4646 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -365,6 +365,8 @@ static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
         return 0;
     }
 
+    ct3d->dc.fw = fw;
+
     if (state->commit) {
         MemoryRegion *mr = NULL;
         uint64_t vmr_size = 0, pmr_size = 0;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 68c7cc9891..ae723c03ec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2840,10 +2840,13 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
 }
 
 void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                             HostMemoryBackend *host_mem,
+                                             struct CXLFixedWindow *fw,
                                              uint64_t dpa,
                                              uint64_t len,
                                              uint8_t *tag,
-                                             uint16_t shared_seq)
+                                             uint16_t shared_seq,
+                                             int rid)
 {
     CXLDCExtent *extent;
 
@@ -2871,17 +2874,20 @@ void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
  * Return value: the extent group where the extent is inserted.
  */
 CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
+                                                    HostMemoryBackend *host_mem,
+                                                    struct CXLFixedWindow *fw,
                                                     uint64_t dpa,
                                                     uint64_t len,
                                                     uint8_t *tag,
-                                                    uint16_t shared_seq)
+                                                    uint16_t shared_seq,
+                                                    int rid)
 {
     if (!group) {
         group = g_new0(CXLDCExtentGroup, 1);
         QTAILQ_INIT(&group->list);
     }
-    cxl_insert_extent_to_extent_list(&group->list, dpa, len,
-                                     tag, shared_seq);
+    cxl_insert_extent_to_extent_list(&group->list, host_mem, fw, dpa, len,
+                                     tag, shared_seq, rid);
     return group;
 }
 
@@ -3062,7 +3068,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
-        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+        cxl_insert_extent_to_extent_list(extent_list, NULL,
+                                         NULL, dpa, len,
+                                         NULL, 0, 0);
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
@@ -3089,8 +3097,9 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
     }
 
     QTAILQ_FOREACH(ent, src, node) {
-        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
-                                         ent->tag, ent->shared_seq);
+        cxl_insert_extent_to_extent_list(dst, ent->hm, ent->fw, ent->start_dpa,
+                                         ent->len, ent->tag, ent->shared_seq,
+                                         ent->rid);
         cnt++;
     }
     return cnt;
@@ -3144,15 +3153,17 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     cnt_delta--;
 
                     if (len1) {
-                        cxl_insert_extent_to_extent_list(updated_list,
-                                                         ent_start_dpa,
-                                                         len1, NULL, 0);
+                        cxl_insert_extent_to_extent_list(updated_list, NULL,
+                                                         NULL, ent_start_dpa,
+                                                         len1, NULL, 0,
+                                                         ent->rid);
                         cnt_delta++;
                     }
                     if (len2) {
-                        cxl_insert_extent_to_extent_list(updated_list,
-                                                         dpa + len,
-                                                         len2, NULL, 0);
+                        cxl_insert_extent_to_extent_list(updated_list, NULL,
+                                                         NULL, dpa + len,
+                                                         len2, NULL, 0,
+                                                         ent->rid);
                         cnt_delta++;
                     }
 
@@ -3624,9 +3635,10 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
             for (i = 0; i < in->ext_count; i++) {
                 CXLDCExtentRaw *ext = &in->extents[i];
 
-                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
+                group = cxl_insert_extent_to_extent_group(group, NULL, NULL,
+                                                          ext->start_dpa,
                                                           ext->len, ext->tag,
-                                                          ext->shared_seq);
+                                                          ext->shared_seq, 0);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 690b3ab658..ef1c1cbaef 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2132,11 +2132,24 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         memcpy(extents[i].tag, &uuid.data, 0x10);
         extents[i].shared_seq = 0;
         if (type == DC_EVENT_ADD_CAPACITY) {
-            group = cxl_insert_extent_to_extent_group(group,
-                                                      extents[i].start_dpa,
-                                                      extents[i].len,
-                                                      extents[i].tag,
-                                                      extents[i].shared_seq);
+            if (!dcd->dc.total_capacity_cmd) {
+                group = cxl_insert_extent_to_extent_group(group,
+                                                          NULL, NULL,
+                                                          extents[i].start_dpa,
+                                                          extents[i].len,
+                                                          extents[i].tag,
+                                                          extents[i].shared_seq,
+                                                          rid);
+            } else {
+                group = cxl_insert_extent_to_extent_group(group,
+                                                          dcd->dc.host_dc,
+                                                          dcd->dc.fw,
+                                                          extents[i].start_dpa,
+                                                          extents[i].len,
+                                                          extents[i].tag,
+                                                          extents[i].shared_seq,
+                                                          rid);
+            }
         }
 
         list = list->next;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index bfd1a97e03..fe0c44e8d7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -10,6 +10,7 @@
 #ifndef CXL_DEVICE_H
 #define CXL_DEVICE_H
 
+#include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
@@ -515,11 +516,14 @@ typedef struct CXLDCExtentRaw {
 } QEMU_PACKED CXLDCExtentRaw;
 
 typedef struct CXLDCExtent {
+    HostMemoryBackend *hm;
+    struct CXLFixedWindow *fw;
     uint64_t start_dpa;
     uint64_t len;
     uint8_t tag[0x10];
     uint16_t shared_seq;
     uint8_t rsvd[0x6];
+    int rid;
 
     QTAILQ_ENTRY(CXLDCExtent) node;
 } CXLDCExtent;
@@ -628,6 +632,7 @@ struct CXLType3Dev {
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
+        struct CXLFixedWindow *fw;
         /*
          * total_capacity is equivalent to the dynamic capability
          * memory region size.
@@ -711,18 +716,24 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
 void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
                                         CXLDCExtent *extent);
-void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                      HostMemoryBackend *hm,
+                                      struct CXLFixedWindow *fw,
+                                      uint64_t dpa,
                                       uint64_t len, uint8_t *tag,
-                                      uint16_t shared_seq);
+                                      uint16_t shared_seq, int rid);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
                                     uint64_t dpa, uint64_t len);
 CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
+                                                    HostMemoryBackend *host_mem,
+                                                    struct CXLFixedWindow *fw,
                                                     uint64_t dpa,
                                                     uint64_t len,
                                                     uint8_t *tag,
-                                                    uint16_t shared_seq);
+                                                    uint16_t shared_seq,
+                                                    int rid);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
-- 
2.43.0

