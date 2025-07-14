Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E22F22
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515423; cv=none; b=Y3xsVPap71d6EyElnN46hKZkrZ+I4JoQcNDJKWGYLBTZMh90bEhHqs2iW15keqA4ZIAJ4O64RuXbDSOTbgptZDzkY5wC9npeowWYL8tkYuev9+Q1c1j8Hhn44u4xH4opguyGezaz8bttvLPrDEhJRta40k+J0wbT82NlbHtYEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515423; c=relaxed/simple;
	bh=BszKXCwxsbzpD45dOy+NJKlalpcGq/uf7taxZhJOgx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEl5GcKyLFTuwlKbGaiNmduW+K19yqzdoh4gy0ThSQaNGhb+3lNY/BMGjpFsIBzVPA60bxhUoZD4BQ7z6QmRgQS6DaW/fCme1x0iLeOvtXFPZrYlgZJr7KyIbrMe8i5EjvL+dR8VpASBxcybQ9fgj7JkAZFeO2c052WzVmunxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqZC1plTz6M56Y;
	Tue, 15 Jul 2025 01:49:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EDA82140142;
	Tue, 15 Jul 2025 01:50:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:50:19 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 10/11] hw/cxl: mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Mon, 14 Jul 2025 18:45:06 +0100
Message-ID: <20250714174509.1984430-11-Jonathan.Cameron@huawei.com>
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |   4 ++
 hw/cxl/cxl-mailbox-utils.c  | 109 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +--
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 71a5834c3d..89411c8093 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -728,4 +728,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
                                              uint32_t ext_count);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b6f30e8689..5d08525529 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3543,6 +3544,107 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() function which accepts
+ * CXLUpdateDCExtentListInPl as a parameter.
+ */
+static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
+                                CXLUpdateDCExtentListInPl *extent_list,
+                                int count)
+{
+    int i;
+
+    extent_list->num_entries_updated = count;
+
+    for (i = 0; i < count; i++) {
+        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
+        extent_list->updated_entries[i].len = raw_extents[i].len;
+    }
+}
+
+/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */
+static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t selection_policy;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int i, rc;
+
+    switch (in->selection_policy) {
+        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
+            /* Adding extents exceeds device's extent tracking ability. */
+            if (in->ext_count + ct3d->dc.total_extent_count >
+                CXL_NUM_EXTENTS_SUPPORTED) {
+                return CXL_MBOX_RESOURCES_EXHAUSTED;
+            }
+
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw *ext = &in->extents[i];
+
+                /* Check requested extents do not overlap with pending ones. */
+                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                         ext->start_dpa,
+                                                         ext->len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+                /* Check requested extents do not overlap with existing ones. */
+                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                                   ext->start_dpa,
+                                                   ext->len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+            }
+
+            if (rc) {
+                return rc;
+            }
+
+            CXLDCExtentGroup *group = NULL;
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw *ext = &in->extents[i];
+
+                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
+                                                          ext->len, ext->tag,
+                                                          ext->shared_seq);
+            }
+
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+            ct3d->dc.total_extent_count += in->ext_count;
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_ADD_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                          "CXL extent selection policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3670,6 +3772,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0 },
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4e975b1a42..be609ff9d0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
  * the list.
  * Return value: return true if has overlaps; otherwise, return false
  */
-static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
-                                           uint64_t dpa, uint64_t len)
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
     Range range1, range2;
@@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
-- 
2.48.1

