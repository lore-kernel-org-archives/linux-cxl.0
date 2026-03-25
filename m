Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9D313E29
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464422; cv=none; b=XvOa4fNYztcOr507i+WAQh2m/Td9v24Nqn8iQw0+b6COr9ssYYPc6uTkIGUikUz9OAdfQLQKaIYmSDGPl0OQ8mFQOqtMm+Iu3YNotcBgU6DCsFE5/B/oWXUKgDU+/SCayO1+KRbZBtyuOwkGkjnIFTx4ILRTAw82M1JY3xhCKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464422; c=relaxed/simple;
	bh=KR2Amgh2vKu3QZEyHXZ3+CKMQyo89iDhLbyUCPphgqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9ylcgRGvkeGuYrH8XrwVg0278CvhDyl5iB+9CUYha4svYi8R6thfSl79vZE0xAE3DAd43dcpFgqro6Qghi0pKY5cLlmIY2eNDxtEsZ6B8AaThXtk2iHp+GTnq5qGTw+cY8JFJgzWw8NcnXzyPutuWiOAENzVK22GSBLcyy+YTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwq31L7bzHnGdQ;
	Thu, 26 Mar 2026 02:46:23 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id F3DB240587;
	Thu, 26 Mar 2026 02:46:58 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:46:57 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 7/9] hw/cxl: Add release-time teardown for direct-mapped extents
Date: Wed, 25 Mar 2026 18:42:55 +0000
Message-ID: <20260325184259.366-8-alireza.sanaee@huawei.com>
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

Consolidate teardown into the release path so all cleanup flows through a
single place.

When an extent is removed, tear down any direct alias tied to it and unmap
a lazy-mode tagged backend before dropping the extent record. Partial
release of backend-backed extents is rejected, since those backends are
tracked one-per-extent and cannot be split.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 103 +++++++++++++++++++++++++++++-------
 hw/mem/cxl_type3.c          |  37 ++++++++++++-
 include/hw/cxl/cxl_device.h |   9 +++-
 3 files changed, 126 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4684c33ba1..9853740994 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3532,7 +3532,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint8_t *tag,
                                              uint16_t shared_seq,
                                              int rid,
-                                             uint64_t offset)
+                                             uint64_t offset,
+                                             int direct_window_idx)
 {
     CXLDCExtent *extent;
 
@@ -3547,6 +3548,7 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
     }
     extent->shared_seq = shared_seq;
     extent->rid = rid;
+    extent->direct_window_idx = direct_window_idx;
 
     QTAILQ_INSERT_TAIL(list, extent, node);
 }
@@ -3571,7 +3573,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
                                                     int rid,
-                                                    uint64_t offset)
+                                                    uint64_t offset,
+                                                    int direct_window_idx)
 {
     if (!group) {
         group = g_new0(CXLDCExtentGroup, 1);
@@ -3579,7 +3582,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
     }
     cxl_insert_extent_to_extent_list(&group->list,
                                      host_mem, fw, dpa, len,
-                                     tag, shared_seq, rid, offset);
+                                     tag, shared_seq, rid, offset,
+                                     direct_window_idx);
     return group;
 }
 
@@ -3695,6 +3699,25 @@ static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
     return false;
 }
 
+static void cxl_unmap_extent_backend(CXLDCExtent *ent)
+{
+    MemoryRegion *mr;
+
+    if (!ent->hm) {
+        return;
+    }
+
+    mr = host_memory_backend_get_memory(ent->hm);
+    if (!mr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Could not get memory region from host memory backend\n");
+        return;
+    }
+
+    memory_region_set_enabled(mr, false);
+    host_memory_backend_set_mapped(ent->hm, false);
+}
+
 static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
         const CXLUpdateDCExtentListInPl *in)
 {
@@ -3856,11 +3879,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
             cxl_insert_extent_to_extent_list(extent_list,
                                              hmb_dc, fw, dpa, len,
-                                             tag, 0, rid, offset);
+                                             tag, 0, rid, offset, mr_idx);
         } else {
             cxl_insert_extent_to_extent_list(extent_list,
                                              NULL, NULL, dpa, len,
-                                             NULL, 0, -1, (uint64_t)-1);
+                                             NULL, 0, -1,
+                                             (uint64_t)-1, -1);
         }
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
@@ -3892,7 +3916,8 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
                                          ent->hm, ent->fw,
                                          ent->start_dpa, ent->len,
                                          ent->tag, ent->shared_seq,
-                                         ent->rid, ent->offset);
+                                         ent->rid, ent->offset,
+                                         ent->direct_window_idx);
         cnt++;
     }
     return cnt;
@@ -3900,6 +3925,7 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
 
 static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         const CXLUpdateDCExtentListInPl *in, CXLDCExtentList *updated_list,
+        CXLDCExtentList *updated_removed_list,
         uint32_t *updated_list_size)
 {
     CXLDCExtent *ent, *ent_next;
@@ -3909,6 +3935,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
     CXLRetCode ret = CXL_MBOX_SUCCESS;
 
     QTAILQ_INIT(updated_list);
+    if (updated_removed_list) {
+        QTAILQ_INIT(updated_removed_list);
+    }
     copy_extent_list(updated_list, &ct3d->dc.extents);
 
     for (i = 0; i < in->num_entries_updated; i++) {
@@ -3942,25 +3971,44 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
                     len_done = ent_len - len1 - len2;
 
+                    /*
+                     * Tagged backends are mapped one-backend-per-extent.
+                     * Partial release would leave a backend-backed extent
+                     * behind without a clean backend lifecycle.
+                     */
+                    if (ent->hm && (len1 || len2)) {
+                        ret = CXL_MBOX_INVALID_INPUT;
+                        goto free_and_exit;
+                    }
+
+                    /* Cannot split extents with direct window mapping */
+                    if (ent->direct_window_idx >= 0 && (len1 || len2)) {
+                        ret = CXL_MBOX_INVALID_INPUT;
+                        goto free_and_exit;
+                    }
+
+                    if (updated_removed_list) {
+                        cxl_insert_extent_to_extent_list(
+                            updated_removed_list, ent->hm, ent->fw,
+                            ent->start_dpa, ent->len, ent->tag, ent->shared_seq,
+                            ent->rid, ent->offset, ent->direct_window_idx);
+                    }
+
                     cxl_remove_extent_from_extent_list(updated_list, ent);
                     cnt_delta--;
 
                     if (len1) {
-                        cxl_insert_extent_to_extent_list(updated_list,
-                                                         NULL, NULL,
-                                                         ent_start_dpa, len1,
-                                                         ent->tag, 0,
-                                                         ent->rid,
-                                                         ent->offset);
+                        cxl_insert_extent_to_extent_list(
+                            updated_list, NULL, NULL,
+                            ent_start_dpa, len1, ent->tag, 0,
+                            ent->rid, ent->offset, ent->direct_window_idx);
                         cnt_delta++;
                     }
                     if (len2) {
-                        cxl_insert_extent_to_extent_list(updated_list,
-                                                         NULL, NULL,
-                                                         dpa + len, len2,
-                                                         ent->tag, 0,
-                                                         ent->rid,
-                                                         ent->offset);
+                        cxl_insert_extent_to_extent_list(
+                            updated_list, NULL, NULL,
+                            dpa + len, len2, ent->tag, 0,
+                            ent->rid, ent->offset, ent->direct_window_idx);
                         cnt_delta++;
                     }
 
@@ -4002,6 +4050,7 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList updated_list;
+    CXLDCExtentList updated_removed_list;
     CXLDCExtent *ent, *ent_next;
     uint32_t updated_list_size;
     CXLRetCode ret;
@@ -4025,11 +4074,26 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     }
 
     ret = cxl_dc_extent_release_dry_run(ct3d, in, &updated_list,
+                                        &updated_removed_list,
                                         &updated_list_size);
     if (ret != CXL_MBOX_SUCCESS) {
         return ret;
     }
 
+    if (ct3d->direct_mr_enabled) {
+        /* Remove memory alias for the removed extents */
+        QTAILQ_FOREACH_SAFE(ent, &updated_removed_list, node, ent_next) {
+            cxl_remove_memory_alias(ct3d, ent->fw, ent->direct_window_idx);
+            cxl_unmap_extent_backend(ent);
+            cxl_remove_extent_from_extent_list(&updated_removed_list, ent);
+        }
+    } else {
+        QTAILQ_FOREACH_SAFE(ent, &updated_removed_list, node, ent_next) {
+            cxl_unmap_extent_backend(ent);
+            cxl_remove_extent_from_extent_list(&updated_removed_list, ent);
+        }
+    }
+
     /*
      * If the dry run release passes, the returned updated_list will
      * be the updated extent list and we just need to clear the extents
@@ -4438,7 +4502,7 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                                                           ext->start_dpa,
                                                           ext->len, ext->tag,
                                                           ext->shared_seq, 0,
-                                                          (uint64_t)-1);
+                                                          (uint64_t)-1, -1);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
@@ -4520,6 +4584,7 @@ static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
             rc = cxl_dc_extent_release_dry_run(ct3d,
                                                list,
                                                &updated_list,
+                                               NULL,
                                                &updated_list_size);
             if (rc) {
                 return rc;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e13826eb0b..6b73d58358 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2465,7 +2465,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
                                                           rid,
-                                                          offset);
+                                                          offset,
+                                                          0);
             } else {
                 group = cxl_insert_extent_to_extent_group(group,
                                                           dcd->dc.host_dc,
@@ -2475,7 +2476,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
                                                           rid,
-                                                          offset);
+                                                          offset,
+                                                          0);
             }
         }
 
@@ -2541,6 +2543,37 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 }
 
+void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
+                             int hdm_id)
+{
+    MemoryRegion *mr;
+
+    if (hdm_id < 0 || hdm_id >= CXL_DC_MAX_DIRECT_MR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid direct window index %d\n", hdm_id);
+        return;
+    }
+
+    if (dcd->dc.total_capacity_cmd > 0) {
+        mr = &dcd->dc.dc_direct_mr[hdm_id];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "No dynamic capacity command support, "
+                      "cannot remove memory region alias\n");
+        return;
+    }
+
+    if (!fw) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Cannot remove memory region alias "
+                      "without a valid fixed window\n");
+        return;
+    }
+
+    memory_region_del_subregion(&fw->mr, mr);
+    dcd->dc.direct_mr_bitmap &= ~(1u << hdm_id);
+}
+
 static void ct3_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1e904d7b48..42db9c7ce4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -654,6 +654,7 @@ typedef struct CXLDCExtent {
     uint8_t rsvd[0x6];
     int rid;
     uint64_t offset;
+    int direct_window_idx;
 
     QTAILQ_ENTRY(CXLDCExtent) node;
 } CXLDCExtent;
@@ -879,7 +880,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       uint8_t *tag,
                                       uint16_t shared_seq,
                                       int rid,
-                                      uint64_t offset);
+                                      uint64_t offset,
+                                      int direct_window_idx);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
@@ -892,7 +894,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
                                                     int rid,
-                                                    uint64_t offset);
+                                                    uint64_t offset,
+                                                    int direct_window_idx);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
@@ -900,6 +903,8 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                  uint64_t len);
 void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
+void cxl_remove_memory_alias(CXLType3Dev *dcd, struct CXLFixedWindow *fw,
+                             int hdm_id);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
-- 
2.50.1 (Apple Git-155)

