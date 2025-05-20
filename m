Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031261E50B
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771078; cv=none; b=CIUPFR6qRWRNQyLy1gvOj8dA1nHWyIqq3ctqo7PnAP6s/6O5/0l4/vltpr8rB6fyFEa06Wd7EdUvbxZwD/4kOLIS/N7jbYKBJlUjYDqrdVVxRwM7NiKOpg8SPNQzAGM2I9+vis+bx/y2gtrs7/MnZqjaGPHJaiInv6nlKRYmsJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771078; c=relaxed/simple;
	bh=AqRnYMvF9e4rTmv4Ui8XFwHm2VKrj/6w3rmbxZbOwmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPbOmgZTehI2b5eZuDNQKXlDIOERhrG/NHzk+zR+SbT7YE5JL9hUVSaUxjSQYdxLHEh+3g78WMZoZ2jHMFYpXr1uFbfkuCmfN4k7Q7o2ZTllysYyt1fbGZpSYzdPRSu6q1Nc7s4io+6hScJTH5qO/mmZWTtiBi6lCIWNs0bdRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXsOyT4x; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXsOyT4x"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742af848148so3307508b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747771076; x=1748375876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxu7EAKjxOL/jRlNPWnc2FmXYmyv4DcFiIfRobuMjWM=;
        b=bXsOyT4xwSnd1hHtqe+yAZxBK2P9UcDifRNI3H1fy7HdifO5wgreaJyUHmZhrMU+/7
         zVUqGvYVh+f4n2/RfsIX/xmD6gsh4qLtbJz2YKNA37Flt3lMhzKVjENoj8Cu6GHE9hk2
         5hBiqjtD+0Qoy1eN9BdomeX8lnfKIfx4yG/cOHSCb4OhxbInVMmfGW4cvHr+tCeF9uCx
         0VGPz7U42DLKkM19ufkfdhlDYyruRzD/tSjnJmiqzCXldrXOXLgu1oGy7hBtanmv80kx
         2ODa7A/VpcWqsuWjikMnqtu+3ESTUbmmA8E9vptBpNO/eXok1LOK4gF4lwS/iLDTU525
         uXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747771076; x=1748375876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxu7EAKjxOL/jRlNPWnc2FmXYmyv4DcFiIfRobuMjWM=;
        b=Cr5FF4kHYrqBkT2+IeLfvN0+f+8ACnBS1LWqmitufEfbvcqFATJsrWAvRtoxD7l+dA
         2L+a6SPaUotplzdux7MsZK7c8llfJ9HPgtJqeTShG5OYFKc2lNS6MbzhI4/D0hO0djf0
         fvHCdqFiuNZSAK8omOpaMrgWPsAzokdDrOgiUEhNGvMt/8v9hietfOQXRahiEf7Tb5/+
         1pmS8z1T6gzm7GHxNYiZDRel4zTBO8KMUDI4zR+U8Ok2NCJ6NsZGa1beShWzCC7tvKy2
         Bkba2miWXLFr3LsgjW4ZHeZ5vNTfgKU29Cuhmyd5sif3l2YhdBuVfukBIaD0YM+JfvPH
         xPCA==
X-Gm-Message-State: AOJu0YzmComLr139bbUKjDkOd6pGE3DxYQOMOFdQ/lIs1jyMiNMcw+3c
	8ejbSP9Ye7pn3PXK5XiM1ilS73tyzqYfqRwSjZwU1qP1SqbKcv/BDxFW
X-Gm-Gg: ASbGncuzw4gsGQQD390YQ+WY0a3iF20ah5GU7e5hWJwCW1HsZXT0vWUGtWq3nky8387
	b7otcoW2q4Y4WXG0SZ4o28o3SRSEPeDuDkj3zsXYx32fZmEGwK4wtTMtiiXwzyYaMRcxYcpB55J
	ZRpgfSUA0XFbR5LST+4YzXMkmdkw+a2T5RnRR1V65QcAOww5c9WsvPoeahjEcOahumcDIuVNCnn
	2MbEWAR0UltnSTo5vhYZnErHcmCWXLEqUk0MMmgMiQd3pCx4njJ3sgaQXDJZh6XSqDodulT0mrk
	fbM8t0s8+Cw+5CYwi25M5lYA7oRwCsLCRbfRjc2aizvGEf2hYV0V8CmdvfYMZbEgwsM5
X-Google-Smtp-Source: AGHT+IHVgoS/GUrv4eXd7c/tYQixcYyqNwUlmHsqZpaOzi2Jukxs0vecZkBbaB+DbCsJDFN5uiXTyw==
X-Received: by 2002:a05:6a21:9183:b0:1fe:5e67:21af with SMTP id adf61e73a8af0-216219d18e0mr29653558637.30.1747771076060;
        Tue, 20 May 2025 12:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8458531a12.49.2025.05.20.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:57:55 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	anisa.su887@gmail.com,
	gourry@gourry.net,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] hw/cxl: fix DC extent capacity tracking
Date: Tue, 20 May 2025 12:56:43 -0700
Message-ID: <20250520195741.789841-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  3 ++-
 3 files changed, 21 insertions(+), 9 deletions(-)

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
-- 
2.47.2

