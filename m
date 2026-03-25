Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465A2BDC32
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464324; cv=none; b=Ov1f776j/seWviAUdLKzB8OEZZDraWP1XqOyuUEQpmUr4S4fbNrxYpPm8Y2fRRuyJPMlX8Q0y4sKA8yxUtZ552/hClsZ8chYvrk8ZJetmzskvKyP6oNn5zxvLatgTZkRcNrNsIcX0Qzbf2DFwo/I894ZUdI9RSiFaNyYxYUBpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464324; c=relaxed/simple;
	bh=6ZK6iWrzoDctVt3ifBsmTCwkNNZsccS7MvcEh+ra33Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIJERhNzvXbWPokfQwMCal4ohuGGqhRJ4z+lXSC0GiZkIQZqT33WtSJuyacpynBHRniZx4kAm33kVokkvlrFbS7WIiinqL1zdiO3LeBEcJmbSQ/HvjadqSmB8eFsujuQK9neIntKOyB8wuazk0p7RqMnAV9ekDVG/xRExTJlpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwn86D3YzHnGdQ;
	Thu, 26 Mar 2026 02:44:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id ADC8A40587;
	Thu, 26 Mar 2026 02:45:20 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:45:19 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 4/9] hw/cxl: Carry backend metadata in DC extent records
Date: Wed, 25 Mar 2026 18:42:52 +0000
Message-ID: <20260325184259.366-5-alireza.sanaee@huawei.com>
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

The lazy dc-regions-total-size flow needs more than DPA and length for each
pending or committed extent. Later stages need to remember which backend
was selected for the extent, which fixed window owns the mapping, and which
region/offset the request came from.

Extend CXLDCExtent and the helper APIs so add, copy, and release paths can
carry that metadata alongside the range information.  This is preparatory
plumbing for the patches that map accepted extents into the fixed window
and tear them down on release.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 45 ++++++++++++++++++++++++++-----------
 hw/mem/cxl_type3.c          | 23 ++++++++++++++-----
 include/hw/cxl/cxl_device.h | 21 +++++++++++++----
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c83b5f90d4..c5427adb3a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3525,20 +3525,26 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
 }
 
 void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                             HostMemoryBackend *hm,
+                                             struct CXLFixedWindow *fw,
                                              uint64_t dpa,
                                              uint64_t len,
                                              uint8_t *tag,
-                                             uint16_t shared_seq)
+                                             uint16_t shared_seq,
+                                             int rid)
 {
     CXLDCExtent *extent;
 
     extent = g_new0(CXLDCExtent, 1);
+    extent->hm = hm;
+    extent->fw = fw;
     extent->start_dpa = dpa;
     extent->len = len;
     if (tag) {
         memcpy(extent->tag, tag, 0x10);
     }
     extent->shared_seq = shared_seq;
+    extent->rid = rid;
 
     QTAILQ_INSERT_TAIL(list, extent, node);
 }
@@ -3556,17 +3562,21 @@ void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
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
+    cxl_insert_extent_to_extent_list(&group->list,
+                                     host_mem, fw, dpa, len,
+                                     tag, shared_seq, rid);
     return group;
 }
 
@@ -3747,7 +3757,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
-        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+        cxl_insert_extent_to_extent_list(extent_list,
+                                         NULL, NULL, dpa, len,
+                                         NULL, 0, 0);
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
@@ -3774,8 +3786,11 @@ static uint32_t copy_extent_list(CXLDCExtentList *dst,
     }
 
     QTAILQ_FOREACH(ent, src, node) {
-        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
-                                         ent->tag, ent->shared_seq);
+        cxl_insert_extent_to_extent_list(dst,
+                                         ent->hm, ent->fw,
+                                         ent->start_dpa, ent->len,
+                                         ent->tag, ent->shared_seq,
+                                         ent->rid);
         cnt++;
     }
     return cnt;
@@ -3830,14 +3845,16 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
 
                     if (len1) {
                         cxl_insert_extent_to_extent_list(updated_list,
-                                                         ent_start_dpa,
-                                                         len1, NULL, 0);
+                                                         NULL, NULL,
+                                                         ent_start_dpa, len1,
+                                                         NULL, 0, ent->rid);
                         cnt_delta++;
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(updated_list,
-                                                         dpa + len,
-                                                         len2, NULL, 0);
+                                                         NULL, NULL,
+                                                         dpa + len, len2,
+                                                         NULL, 0, ent->rid);
                         cnt_delta++;
                     }
 
@@ -4310,9 +4327,11 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
             for (i = 0; i < in->ext_count; i++) {
                 CXLDCExtentRaw *ext = &in->extents[i];
 
-                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
+                group = cxl_insert_extent_to_extent_group(group,
+                                                          NULL, NULL,
+                                                          ext->start_dpa,
                                                           ext->len, ext->tag,
-                                                          ext->shared_seq);
+                                                          ext->shared_seq, 0);
             }
 
             cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 569184975f..bd32532c7a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2457,11 +2457,24 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
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
index 630cf44e0e..a84b8ab358 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -10,6 +10,7 @@
 #ifndef CXL_DEVICE_H
 #define CXL_DEVICE_H
 
+#include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/register.h"
@@ -643,11 +644,14 @@ typedef struct CXLDCExtentRaw {
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
@@ -780,6 +784,7 @@ struct CXLType3Dev {
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
+        struct CXLFixedWindow *fw;
         /*
          * total_capacity is equivalent to the dynamic capability
          * memory region size.
@@ -854,18 +859,26 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
 void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
                                         CXLDCExtent *extent);
-void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
-                                      uint64_t len, uint8_t *tag,
-                                      uint16_t shared_seq);
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                      HostMemoryBackend *hm,
+                                      struct CXLFixedWindow *fw,
+                                      uint64_t dpa,
+                                      uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq,
+                                      int rid);
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
2.50.1 (Apple Git-155)

