Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5460296BBC
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284298; cv=none; b=IWB0NxjA9esteEESuO4ySKYl+KVuugP+4bdIkAd3oF02eXWdh1tfmGn5u8P8xCb5yjSBI5mM3F/SzYUa/Od27CklJA8DQwS9V364m+43pdY/s7z7Et7YxufFUm4otz94TO2AXk3P77HLy9iwV0wfPtmkq4WjQ4fuz8J/2xFWFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284298; c=relaxed/simple;
	bh=b9IEqV3bXkwSSGSU8iWmV7fQfxJFJPoPKQs3+YS7/II=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Axhvs5v1/O78YaG9DYL2MEZzdVd/1TSccrINpiOvUTBauC9mSxJ+bN+IkUEGWhD+XyvYX5A7pxYshrmSS8o6g/Jd/bqALkQOW5XFSbHr8UBgHUYheS8wdUfH8uUc6+XDLfQl9yw28ckurxNiVTRirzIHXwQMoS0XePBerK1e5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWz94vzKzHnGcc;
	Fri, 28 Nov 2025 06:57:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0814F1400D4;
	Fri, 28 Nov 2025 06:58:15 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:58:14 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 5/7] hw/cxl: Add performant direct mapping for extents
Date: Thu, 27 Nov 2025 22:55:23 +0000
Message-ID: <20251127225526.700-6-alireza.sanaee@huawei.com>
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

Add alias direct mapping into the fixed memory window.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c           |  4 ++
 hw/cxl/cxl-mailbox-utils.c  | 73 +++++++++++++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  6 ++-
 include/hw/cxl/cxl_device.h | 25 +++++++++++--
 4 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7c8fde4646..3b327be68c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -362,10 +362,14 @@ static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
     fw = CXL_FMW(obj);
 
     if (!cfmws_is_not_interleaved(fw, state->decoder_base)) {
+        ct3d->direct_mr_enabled = false;
         return 0;
     }
+    ct3d->direct_mr_enabled = true;
 
     ct3d->dc.fw = fw;
+    ct3d->dc.dc_decoder_window.base = state->decoder_base;
+    ct3d->dc.dc_decoder_window.size = state->decoder_size;
 
     if (state->commit) {
         MemoryRegion *mr = NULL;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b785553225..15114a5314 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2846,13 +2846,19 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint64_t len,
                                              uint8_t *tag,
                                              uint16_t shared_seq,
-                                             int rid)
+                                             int rid,
+                                             uint64_t offset)
 {
     CXLDCExtent *extent;
 
     extent = g_new0(CXLDCExtent, 1);
     extent->start_dpa = dpa;
     extent->len = len;
+    extent->offset = offset;
+    extent->shared_seq = shared_seq;
+    extent->hm = host_mem;
+    extent->fw = fw;
+    extent->rid = rid;
     if (tag) {
         memcpy(extent->tag, tag, 0x10);
     }
@@ -2880,14 +2886,15 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint64_t len,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
-                                                    int rid)
+                                                    int rid,
+                                                    uint64_t offset)
 {
     if (!group) {
         group = g_new0(CXLDCExtentGroup, 1);
         QTAILQ_INIT(&group->list);
     }
     cxl_insert_extent_to_extent_list(&group->list, host_mem, fw, dpa, len,
-                                     tag, shared_seq, rid);
+                                     tag, shared_seq, rid, offset);
     return group;
 }
 
@@ -2985,7 +2992,8 @@ static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
                                           uint8_t *tag,
                                           HostMemoryBackend **hmb,
                                           struct CXLFixedWindow **fw,
-                                          int *rid)
+                                          int *rid,
+                                          uint64_t *offset)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
@@ -2996,6 +3004,7 @@ static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
             *hmb = ent->hm;
             memcpy(tag, ent->tag, 0x10);
             *rid = ent->rid;
+            *offset = ent->offset;
             return true;
         }
     }
@@ -3057,7 +3066,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     HostMemoryBackend *hmb_dc;
     uint8_t tag[0x10];
     uint32_t i, num;
-    uint64_t dpa, len;
+    uint64_t dpa, len, offset;
     int rid;
     CXLRetCode ret;
 
@@ -3100,16 +3109,25 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         len = in->updated_entries[i].len;
 
         if (ct3d->dc.total_capacity_cmd) {
+            int mr_idx = ct3d->dc.cur_direct_region_idx;
             found = cxl_extent_find_extent_detail(
-                &ct3d->dc.extents_pending, dpa, len, tag, &hmb_dc, &fw, &rid);
+                &ct3d->dc.extents_pending, dpa, len, tag, &hmb_dc, &fw, &rid,
+                &offset);
 
             /*
              * This only occurs when host accepts an extent where device does
              * not know anything about it.
              */
             if (!found) {
-                qemu_log("Could not find the extent detail for DPA 0x%" PRIx64
-                         " LEN 0x%" PRIx64 "\n",
+                qemu_log("could not find the extent detail for dpa 0x%" PRIx64
+                         " len 0x%" PRIx64 "\n",
+                         dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            if (!hmb_dc) {
+                qemu_log("Mapping host memory backend for dpa 0x%" PRIx64
+                         " len 0x%" PRIx64 "\n",
                          dpa, len);
                 return CXL_MBOX_INVALID_PA;
             }
@@ -3123,6 +3141,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             }
 
             mr = host_memory_backend_get_memory(hmb_dc);
+
             if (!mr) {
                 qemu_log("Could not get memory region from host memory "
                          "backend\n");
@@ -3132,11 +3151,32 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             memory_region_set_nonvolatile(mr, false);
             memory_region_set_enabled(mr, true);
             host_memory_backend_set_mapped(hmb_dc, true);
+
+            if (ct3d->direct_mr_enabled) {
+                g_autofree char *direct_mapping_name =
+                    g_strdup_printf("cxl-direct-mapping-%d", mr_idx);
+                int region_offset = dpa - ct3d->dc.regions[rid].base;
+                MemoryRegion *dr_dc_mr = &ct3d->dc.dc_direct_mr[mr_idx];
+                memory_region_init_alias(dr_dc_mr, OBJECT(ct3d),
+                                         direct_mapping_name, mr, region_offset,
+                                         ct3d->dc.dc_decoder_window.size);
+                memory_region_add_subregion(&fw->mr,
+                                            ct3d->dc.dc_decoder_window.base -
+                                                fw->base + offset,
+                                            dr_dc_mr);
+                /*
+                 * for now assuming 4 extents and 4 direct mapping memory
+                 * regions.
+                 */
+                ct3d->dc.cur_direct_region_idx =
+                    (ct3d->dc.cur_direct_region_idx + 1) % 4;
+            }
+
             cxl_insert_extent_to_extent_list(extent_list, hmb_dc, fw, dpa, len,
-                                             NULL, 0, rid);
+                                             tag, 0, rid, offset);
         } else {
             cxl_insert_extent_to_extent_list(extent_list, NULL, NULL, dpa, len,
-                                             NULL, 0, -1);
+                                             NULL, 0, -1, -1);
         }
 
         ct3d->dc.total_extent_count += 1;
@@ -3167,7 +3207,7 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
     QTAILQ_FOREACH(ent, src, node) {
         cxl_insert_extent_to_extent_list(dst, ent->hm, ent->fw, ent->start_dpa,
                                          ent->len, ent->tag, ent->shared_seq,
-                                         ent->rid);
+                                         ent->rid, ent->offset);
         cnt++;
     }
     return cnt;
@@ -3223,15 +3263,15 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (len1) {
                         cxl_insert_extent_to_extent_list(updated_list, NULL,
                                                          NULL, ent_start_dpa,
-                                                         len1, NULL, 0,
-                                                         ent->rid);
+                                                         len1, ent->tag, 0,
+                                                         ent->rid, ent->offset);
                         cnt_delta++;
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(updated_list, NULL,
                                                          NULL, dpa + len,
-                                                         len2, NULL, 0,
-                                                         ent->rid);
+                                                         len2, ent->tag, 0,
+                                                         ent->rid, ent->offset);
                         cnt_delta++;
                     }
 
@@ -3706,7 +3746,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                 group = cxl_insert_extent_to_extent_group(group, NULL, NULL,
                                                           ext->start_dpa,
                                                           ext->len, ext->tag,
-                                                          ext->shared_seq, 0);
+                                                          ext->shared_seq, 0,
+                                                          -1);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ef1c1cbaef..e3093f63a3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2139,7 +2139,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].len,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
-                                                          rid);
+                                                          rid,
+                                                          offset);
             } else {
                 group = cxl_insert_extent_to_extent_group(group,
                                                           dcd->dc.host_dc,
@@ -2148,7 +2149,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].len,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
-                                                          rid);
+                                                          rid,
+                                                          offset);
             }
         }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fe0c44e8d7..1a521df881 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -524,6 +524,7 @@ typedef struct CXLDCExtent {
     uint16_t shared_seq;
     uint8_t rsvd[0x6];
     int rid;
+    uint64_t offset;
 
     QTAILQ_ENTRY(CXLDCExtent) node;
 } CXLDCExtent;
@@ -589,6 +590,7 @@ struct CXLType3Dev {
 
     /* State */
     MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
+    bool direct_mr_enabled;
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
@@ -633,6 +635,14 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         struct CXLFixedWindow *fw;
+        int cur_direct_region_idx;
+        /*
+         * dc_decoder_window represents the CXL Decoder Window
+         */
+        struct decoder_window {
+            hwaddr base;
+            hwaddr size;
+        } dc_decoder_window;
         /*
          * total_capacity is equivalent to the dynamic capability
          * memory region size.
@@ -647,6 +657,11 @@ struct CXLType3Dev {
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
+        /*
+         * Assume 4 now but many possible, each region is one alias an extent
+         * to allow performance translation in KVM.
+         */
+        MemoryRegion dc_direct_mr[4];
     } dc;
 
     struct CXLSanitizeInfo *media_op_sanitize;
@@ -720,8 +735,11 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       HostMemoryBackend *hm,
                                       struct CXLFixedWindow *fw,
                                       uint64_t dpa,
-                                      uint64_t len, uint8_t *tag,
-                                      uint16_t shared_seq, int rid);
+                                      uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq,
+                                      int rid,
+                                      uint64_t offset);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
@@ -733,7 +751,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint64_t len,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
-                                                    int rid);
+                                                    int rid,
+                                                    uint64_t offset);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
-- 
2.43.0

