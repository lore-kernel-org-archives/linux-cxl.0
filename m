Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD79266EE7
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515146; cv=none; b=SvyzZeipqx801ENDhrs7r+dTXf0DaCCOAC+X29QXOedEfLEbLYCx37UZ+kv5ZUsUcEJp1Tko9N0Y62Go3Jl9q206JZz9S63w7qE+n/P3SF3m5N3up7AInCGSTdy5vst35flWbi6mLrP/cuJUCDejHLUAXMMp6saHXtmSDWiDilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515146; c=relaxed/simple;
	bh=Imf5zDdwAIlbXHxdT814dHNv2m7DjiWNmRkzUwtG2s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXbOI+SPy3T2HnVvVDi38mBJ0G/nfylGFGtAtLhX5hOlhrHkTyCndCiVVs6ojIvFcafFg8AfcB78yDQvUwqqjbyK4RT0IjTeco1nJy+3vjFnI+ImBfto2APf/JFqiDKUH5EFkqLBV0JZWRLstUgPx/T9iV6lVX1kc564RR3iFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqSr3mR8z6M4K7;
	Tue, 15 Jul 2025 01:44:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4606C14033F;
	Tue, 15 Jul 2025 01:45:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:45:40 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 01/11] hw/cxl: fix DC extent capacity tracking
Date: Mon, 14 Jul 2025 18:44:57 +0100
Message-ID: <20250714174509.1984430-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Fan Ni <fan.ni@samsung.com>

Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
extents in different states including added, pending, etc.

Before the change, for the in-device extent number tracking purpose, we only
have "total_extent_count" defined, which only tracks the number of
extents accepted. However, we need to track number of extents in other
states also, for now it is extents pending-to-add.

To fix that, we introduce a new counter for dynamic capacity
"nr_extents_accepted" which explicitly tracks number of the extents
accepted by the hosts, and fix "total_extent_count" to include
both accepted and pending extents counting.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  3 ++-
 hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  1 +
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ed6cd50c67..a151e19da8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ struct CXLType3Dev {
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
+        uint32_t nr_extents_accepted;
         uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
@@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint16_t shared_seq);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
 void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                  uint64_t len);
 void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 299f232f26..0b615ea37a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     uint16_t out_pl_len, size;
     CXLDCExtent *ent;
 
-    if (start_extent_id > ct3d->dc.total_extent_count) {
+    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
 
     stl_le_p(&out->count, record_count);
-    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
     stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
 
     if (record_count > 0) {
@@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
     QTAILQ_INSERT_TAIL(list, group, node);
 }
 
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+    uint32_t extents_deleted = 0;
 
     QTAILQ_REMOVE(list, group, node);
     QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
         cxl_remove_extent_from_extent_list(&group->list, ent);
+        extents_deleted++;
     }
     g_free(group);
+
+    return extents_deleted;
 }
 
 /*
@@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
-    uint32_t i;
+    uint32_t i, num;
     uint64_t dpa, len;
     CXLRetCode ret;
 
@@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     }
 
     if (in->num_entries_updated == 0) {
-        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        ct3d->dc.total_extent_count -= num;
         return CXL_MBOX_SUCCESS;
     }
 
@@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
-    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    ct3d->dc.total_extent_count -= num;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -3160,7 +3167,7 @@ free_and_exit:
         }
         *updated_list_size = 0;
     } else {
-        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
+        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
     }
 
     return ret;
@@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
-    ct3d->dc.total_extent_count = updated_list_size;
+    ct3d->dc.total_extent_count += (updated_list_size -
+                                    ct3d->dc.nr_extents_accepted);
+
+    ct3d->dc.nr_extents_accepted = updated_list_size;
 
     return CXL_MBOX_SUCCESS;
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 94e7274912..f283178d88 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
     if (group) {
         cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
+        dcd->dc.total_extent_count += num_extents;
     }
 
     /*
-- 
2.48.1

