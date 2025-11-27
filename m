Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB9296BBC
	for <linux-cxl@vger.kernel.org>; Thu, 27 Nov 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284266; cv=none; b=kCLny2FWnPT02DuEX+7QJdATL55C+e4IyTMhjnafy66uGUardzBXi86MBnZ5c7AcrLunquYRK+P8HlXIqfKaEhHxrywZUYnNojmnk6NDD9nqjdvFCK3n0UDnbCWUQwRgWoOwCW5zViL753LKFyrfp5UcBqkTSuzsvI8DwbGUT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284266; c=relaxed/simple;
	bh=IWxli8upXtMECh+dIbA7+0K1mjXa0XPUPvet423jHjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM/DD15YfeW0wAFPWy72cLAVPt5c/t4htjuWLvKa6axJeQENQaOR56oP5NNOJ+c8/6vYC26D2VhY6SadFV7fa7KjtrNxA9k1ee49sJ2n8sVdl9DPGbkkxzVfFgmS3h1nJuNcC0N+Psxgl1rk1Z6t2JlYUVL2CfE1FSOMwgzXIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWyY2RGbzHnGcc;
	Fri, 28 Nov 2025 06:56:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A852F1402F1;
	Fri, 28 Nov 2025 06:57:42 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:57:41 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: [RFC PATCH 4/7] hw/cxl: Map lazy memory backend after host acceptance
Date: Thu, 27 Nov 2025 22:55:22 +0000
Message-ID: <20251127225526.700-5-alireza.sanaee@huawei.com>
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

Map relevant memory backend when host accepted an extent.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 74 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ae723c03ec..b785553225 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2979,6 +2979,30 @@ static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
     return CXL_MBOX_SUCCESS;
 }
 
+static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
+                                          uint64_t start_dpa,
+                                          uint64_t len,
+                                          uint8_t *tag,
+                                          HostMemoryBackend **hmb,
+                                          struct CXLFixedWindow **fw,
+                                          int *rid)
+{
+    CXLDCExtent *ent, *ent_next;
+    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+
+    QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
+        if (ent->start_dpa == start_dpa && ent->len == len) {
+            *fw = ent->fw;
+            *hmb = ent->hm;
+            memcpy(tag, ent->tag, 0x10);
+            *rid = ent->rid;
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
         const CXLUpdateDCExtentListInPl *in)
 {
@@ -3029,8 +3053,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    struct CXLFixedWindow *fw;
+    HostMemoryBackend *hmb_dc;
+    uint8_t tag[0x10];
     uint32_t i, num;
     uint64_t dpa, len;
+    int rid;
     CXLRetCode ret;
 
     if (len_in < sizeof(*in)) {
@@ -3065,12 +3093,52 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     }
 
     for (i = 0; i < in->num_entries_updated; i++) {
+        bool found;
+        MemoryRegion *mr;
+
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
-        cxl_insert_extent_to_extent_list(extent_list, NULL,
-                                         NULL, dpa, len,
-                                         NULL, 0, 0);
+        if (ct3d->dc.total_capacity_cmd) {
+            found = cxl_extent_find_extent_detail(
+                &ct3d->dc.extents_pending, dpa, len, tag, &hmb_dc, &fw, &rid);
+
+            /*
+             * This only occurs when host accepts an extent where device does
+             * not know anything about it.
+             */
+            if (!found) {
+                qemu_log("Could not find the extent detail for DPA 0x%" PRIx64
+                         " LEN 0x%" PRIx64 "\n",
+                         dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            /* The host memory backend should not be already mapped */
+            if (host_memory_backend_is_mapped(hmb_dc)) {
+                qemu_log("The host memory backend for DPA 0x%" PRIx64
+                         " LEN 0x%" PRIx64 " is already mapped\n",
+                         dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            mr = host_memory_backend_get_memory(hmb_dc);
+            if (!mr) {
+                qemu_log("Could not get memory region from host memory "
+                         "backend\n");
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            memory_region_set_nonvolatile(mr, false);
+            memory_region_set_enabled(mr, true);
+            host_memory_backend_set_mapped(hmb_dc, true);
+            cxl_insert_extent_to_extent_list(extent_list, hmb_dc, fw, dpa, len,
+                                             NULL, 0, rid);
+        } else {
+            cxl_insert_extent_to_extent_list(extent_list, NULL, NULL, dpa, len,
+                                             NULL, 0, -1);
+        }
+
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
-- 
2.43.0

