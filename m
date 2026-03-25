Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993E318BA6
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464389; cv=none; b=Icc1VhdwrwoegkZrF4tmCfHl7DAa/6VRUyw0CV8M3sUKMY6kT4NAQ+Cvdk86DV11JHk5V4p53mY9BwdF3B1T/1yXLjVHtBstd+gLu1wiSnoOW1PET0MG1lb7/mgJl9v1ovxaYAuHafKpviS1erxrInW1Hxc0TMx42L7exzM4u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464389; c=relaxed/simple;
	bh=wmqKWX/7BXMob1Rh1XRHClz15HTruf+fG4jwwfgpfmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDQ0xdsKQTJRfLA73nP8C4ZfaXZr+6e5OrF/frCUzKIEyQfZDoehibCkq8tTQgQbm6Os67CD6wR2t4cDY2W2ODG0rJHv9mKkaFC4sy9LNgsNML9+nCgDq3iGy5iGKDqQPEtCUP8jAtqsamcfeKcOdtTJVulVZgKvtI4tjYwWT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwpQ3lhYzHnGdQ;
	Thu, 26 Mar 2026 02:45:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A88740584;
	Thu, 26 Mar 2026 02:46:26 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:46:25 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 6/9] hw/cxl: Create direct fixed-window aliases for accepted extents
Date: Wed, 25 Mar 2026 18:42:54 +0000
Message-ID: <20260325184259.366-7-alireza.sanaee@huawei.com>
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

For devices using dc-regions-total-size, the fallback read/write path still
routes through host_dc_as, but accepted extents are backed by individual
host memory backends rather than a single preconfigured address space.
Install aliases into the owning fixed window so accepted dynamic-capacity
memory is reachable through the normal CXL decoder path.

Record the non-interleaved decoder window discovered during HDM setup,
reserve per-device alias slots for lazy DC extents, and create an alias
from the accepted backend into that window when Add Dynamic Capacity
Response commits the extent.

This is scoped to the current non-interleaved direct-mapping model and uses
a small fixed pool of alias slots for now.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-host.c           |  6 ++++
 hw/cxl/cxl-mailbox-utils.c  | 61 +++++++++++++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  6 ++--
 include/hw/cxl/cxl_device.h | 18 +++++++++--
 4 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 079b27133b..4647754cc9 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -300,6 +300,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
             offset = state->dpa_base - vmr_size;
         }
     }
+
     if (!mr) {
         return;
     }
@@ -358,10 +359,15 @@ static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
 
     /* Verify not interleaved */
     if (!cxl_cfmws_find_device(fw, state->decoder_base, false)) {
+        state->ct3d->direct_mr_enabled = false;
         return 0;
     }
+    state->ct3d->direct_mr_enabled = true;
 
     cxl_fmws_direct_passthrough_setup(state, fw);
+    state->ct3d->dc.fw = fw;
+    state->ct3d->dc.dc_decoder_window.base = state->decoder_base;
+    state->ct3d->dc.dc_decoder_window.size = state->decoder_size;
 
     return 0;
 }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cc7be6e68c..4684c33ba1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3531,7 +3531,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint64_t len,
                                              uint8_t *tag,
                                              uint16_t shared_seq,
-                                             int rid)
+                                             int rid,
+                                             uint64_t offset)
 {
     CXLDCExtent *extent;
 
@@ -3540,6 +3541,7 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
     extent->fw = fw;
     extent->start_dpa = dpa;
     extent->len = len;
+    extent->offset = offset;
     if (tag) {
         memcpy(extent->tag, tag, 0x10);
     }
@@ -3568,7 +3570,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint64_t len,
                                                     uint8_t *tag,
                                                     uint16_t shared_seq,
-                                                    int rid)
+                                                    int rid,
+                                                    uint64_t offset)
 {
     if (!group) {
         group = g_new0(CXLDCExtentGroup, 1);
@@ -3576,7 +3579,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
     }
     cxl_insert_extent_to_extent_list(&group->list,
                                      host_mem, fw, dpa, len,
-                                     tag, shared_seq, rid);
+                                     tag, shared_seq, rid, offset);
     return group;
 }
 
@@ -3672,7 +3675,8 @@ static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
 static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
                                           uint64_t start_dpa, uint64_t len,
                                           uint8_t *tag, HostMemoryBackend **hmb,
-                                          struct CXLFixedWindow **fw, int *rid)
+                                          struct CXLFixedWindow **fw, int *rid,
+                                          uint64_t *offset)
 {
     CXLDCExtent *ent;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
@@ -3683,6 +3687,7 @@ static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
             *hmb = ent->hm;
             memcpy(tag, ent->tag, 0x10);
             *rid = ent->rid;
+            *offset = ent->offset;
             return true;
         }
     }
@@ -3744,7 +3749,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     HostMemoryBackend *hmb_dc;
     uint8_t tag[0x10];
     uint32_t i, num;
-    uint64_t dpa, len;
+    uint64_t dpa, len, offset;
     int rid;
     CXLRetCode ret;
 
@@ -3783,12 +3788,14 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
         if (ct3d->dc.total_capacity_cmd) {
+            int mr_idx = -1;
             bool found;
             MemoryRegion *mr;
 
             found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
                                                   dpa, len, tag,
-                                                  &hmb_dc, &fw, &rid);
+                                                  &hmb_dc, &fw, &rid,
+                                                  &offset);
 
             /*
              * Host accepted an extent where device lacks details including
@@ -3822,13 +3829,38 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             memory_region_set_enabled(mr, true);
             host_memory_backend_set_mapped(hmb_dc, true);
 
+            /* Optional direct alias mapping into fixed memory window */
+            if (ct3d->direct_mr_enabled) {
+                uint32_t full_mask = (1u << CXL_DC_MAX_DIRECT_MR) - 1;
+                if ((ct3d->dc.direct_mr_bitmap & full_mask) == full_mask) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Out of direct mapping slots\n");
+                    return CXL_MBOX_RESOURCES_EXHAUSTED;
+                }
+                mr_idx = ctz32(~ct3d->dc.direct_mr_bitmap);
+                g_autofree char *direct_mapping_name =
+                    g_strdup_printf("cxl-direct-mapping-%d", mr_idx);
+                hwaddr region_offset = dpa - ct3d->dc.regions[rid].base;
+                MemoryRegion *dr_dc_mr = &ct3d->dc.dc_direct_mr[mr_idx];
+
+                memory_region_init_alias(dr_dc_mr, OBJECT(ct3d),
+                                         direct_mapping_name, mr,
+                                         region_offset,
+                                         ct3d->dc.dc_decoder_window.size);
+                memory_region_add_subregion(&fw->mr,
+                    ct3d->dc.dc_decoder_window.base - fw->base + offset,
+                    dr_dc_mr);
+
+                ct3d->dc.direct_mr_bitmap |= (1u << mr_idx);
+            }
+
             cxl_insert_extent_to_extent_list(extent_list,
                                              hmb_dc, fw, dpa, len,
-                                             NULL, 0, rid);
+                                             tag, 0, rid, offset);
         } else {
             cxl_insert_extent_to_extent_list(extent_list,
                                              NULL, NULL, dpa, len,
-                                             NULL, 0, -1);
+                                             NULL, 0, -1, (uint64_t)-1);
         }
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
@@ -3860,7 +3892,7 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
                                          ent->hm, ent->fw,
                                          ent->start_dpa, ent->len,
                                          ent->tag, ent->shared_seq,
-                                         ent->rid);
+                                         ent->rid, ent->offset);
         cnt++;
     }
     return cnt;
@@ -3917,14 +3949,18 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                         cxl_insert_extent_to_extent_list(updated_list,
                                                          NULL, NULL,
                                                          ent_start_dpa, len1,
-                                                         NULL, 0, ent->rid);
+                                                         ent->tag, 0,
+                                                         ent->rid,
+                                                         ent->offset);
                         cnt_delta++;
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(updated_list,
                                                          NULL, NULL,
                                                          dpa + len, len2,
-                                                         NULL, 0, ent->rid);
+                                                         ent->tag, 0,
+                                                         ent->rid,
+                                                         ent->offset);
                         cnt_delta++;
                     }
 
@@ -4401,7 +4437,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                                                           NULL, NULL,
                                                           ext->start_dpa,
                                                           ext->len, ext->tag,
-                                                          ext->shared_seq, 0);
+                                                          ext->shared_seq, 0,
+                                                          (uint64_t)-1);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index bd32532c7a..e13826eb0b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2464,7 +2464,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].len,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
-                                                          rid);
+                                                          rid,
+                                                          offset);
             } else {
                 group = cxl_insert_extent_to_extent_group(group,
                                                           dcd->dc.host_dc,
@@ -2473,7 +2474,8 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                                                           extents[i].len,
                                                           extents[i].tag,
                                                           extents[i].shared_seq,
-                                                          rid);
+                                                          rid,
+                                                          offset);
             }
         }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a84b8ab358..1e904d7b48 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -634,6 +634,7 @@ typedef struct CXLMemSparingWriteAttrs {
 #define CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG    BIT(2)
 
 #define DCD_MAX_NUM_REGION 8
+#define CXL_DC_MAX_DIRECT_MR 4
 
 typedef struct CXLDCExtentRaw {
     uint64_t start_dpa;
@@ -652,6 +653,7 @@ typedef struct CXLDCExtent {
     uint16_t shared_seq;
     uint8_t rsvd[0x6];
     int rid;
+    uint64_t offset;
 
     QTAILQ_ENTRY(CXLDCExtent) node;
 } CXLDCExtent;
@@ -720,6 +722,7 @@ struct CXLType3Dev {
     /* State */
     MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
     CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
+    bool direct_mr_enabled;
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
@@ -785,6 +788,14 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         struct CXLFixedWindow *fw;
+        uint32_t direct_mr_bitmap;
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
@@ -799,6 +810,7 @@ struct CXLType3Dev {
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
+        MemoryRegion dc_direct_mr[CXL_DC_MAX_DIRECT_MR];
     } dc;
 
     struct CXLSanitizeInfo *media_op_sanitize;
@@ -866,7 +878,8 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       uint64_t len,
                                       uint8_t *tag,
                                       uint16_t shared_seq,
-                                      int rid);
+                                      int rid,
+                                      uint64_t offset);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
@@ -878,7 +891,8 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
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
2.50.1 (Apple Git-155)

