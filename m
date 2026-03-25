Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90E2EB859
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464357; cv=none; b=iclPkRSKYHV+9g75naGZr05zM1A9bm2MhxeApfBVK7f1W4wXLcF/nvU4rfVadvYgNxkPB+8m8DpgYF7X8CKiP+YJT5hLdoTvmObkMBlEpL5MMTXei0s690Bt0y7Kwd31f6OHodzEE/9NIp3vh3utPtlqZKyaFVtxL3Fuf9LFKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464357; c=relaxed/simple;
	bh=v271Hn3Lnrj5e0Pesa891R0dbaBNcgdZoJG9sB0w0UE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiJbXYN2CskzKyXLL7unO7q8hbE3fsJ5vHBhwtdNPMl8zP6J4QbuSXUWM5+tVknmJMEbYmU/J8L+S2dr7av8qXpl0WVmJKvKmwi3uoHjb4dz8v0TQ0+Os0ikrPfOjRKahSoHeBJaJguC3xdYqj2qJEB2y3EB5Or9Hj1U1/RIQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwnn6sp4zHnGjr;
	Thu, 26 Mar 2026 02:45:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C5BF540584;
	Thu, 26 Mar 2026 02:45:53 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:45:52 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Date: Wed, 25 Mar 2026 18:42:53 +0000
Message-ID: <20260325184259.366-6-alireza.sanaee@huawei.com>
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

In the dc-regions-total-size flow, a requested extent is not backed when it
is queued. It becomes usable only after the host accepts it with Add
Dynamic Capacity Response.

Use that response path to look up the first pending group's metadata for
each accepted extent, enable the selected host backend, and move the
backend and fixed-window references onto the committed extent list. The
accepted range is then marked backed just like the non-lazy path.

This wires host acceptance to the lazy backend lifecycle and leaves the
fixed-window direct aliasing to the following patch.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c5427adb3a..cc7be6e68c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3668,6 +3668,28 @@ static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
     return CXL_MBOX_SUCCESS;
 }
 
+/* Find extent details (backend, window, tag, rid) in the first pending group */
+static bool cxl_extent_find_extent_detail(CXLDCExtentGroupList *list,
+                                          uint64_t start_dpa, uint64_t len,
+                                          uint8_t *tag, HostMemoryBackend **hmb,
+                                          struct CXLFixedWindow **fw, int *rid)
+{
+    CXLDCExtent *ent;
+    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+
+    QTAILQ_FOREACH(ent, &group->list, node) {
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
@@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
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
@@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     for (i = 0; i < in->num_entries_updated; i++) {
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
+        if (ct3d->dc.total_capacity_cmd) {
+            bool found;
+            MemoryRegion *mr;
+
+            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
+                                                  dpa, len, tag,
+                                                  &hmb_dc, &fw, &rid);
+
+            /*
+             * Host accepted an extent where device lacks details including
+             * wrong DPA or wrong length.
+             */
+            if (!found) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Could not find the extent detail for DPA 0x%"
+                              PRIx64 " LEN 0x%" PRIx64 "\n", dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            /* The host memory backend should not be already mapped */
+            if (host_memory_backend_is_mapped(hmb_dc)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "The host memory backend for DPA 0x%" PRIx64
+                              " LEN 0x%" PRIx64 " is already mapped\n",
+                              dpa, len);
+                return CXL_MBOX_INVALID_PA;
+            }
 
-        cxl_insert_extent_to_extent_list(extent_list,
-                                         NULL, NULL, dpa, len,
-                                         NULL, 0, 0);
+            mr = host_memory_backend_get_memory(hmb_dc);
+            if (!mr) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Could not get memory region from "
+                              "host memory backend\n");
+                return CXL_MBOX_INVALID_PA;
+            }
+
+            memory_region_set_nonvolatile(mr, false);
+            memory_region_set_enabled(mr, true);
+            host_memory_backend_set_mapped(hmb_dc, true);
+
+            cxl_insert_extent_to_extent_list(extent_list,
+                                             hmb_dc, fw, dpa, len,
+                                             NULL, 0, rid);
+        } else {
+            cxl_insert_extent_to_extent_list(extent_list,
+                                             NULL, NULL, dpa, len,
+                                             NULL, 0, -1);
+        }
         ct3d->dc.total_extent_count += 1;
         ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
-- 
2.50.1 (Apple Git-155)

