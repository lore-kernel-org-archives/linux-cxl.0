Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55422DA06
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536823; cv=none; b=tW1dp9c/lP2Dd9nz1SlJde5HcKV49MnvLeRSKn0PcY1Z6oIiivq2oY1UY5nO/iv2sj0HL/9OMRosmigezJ6idLUnox6jUHvjMFLvAYWxxj1qITVgITMcB8FmowkXU7m9goM11AHA9WIgpzLVbn7s2nlb9nPISKRvvqpzgaonZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536823; c=relaxed/simple;
	bh=YFOb5U6HQLlb2DJYtg2+V+A+VpZNZcetIAvy1xZGZnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c60z2ncxuiRtd98V3oFG/oo+GadBk+AZtnTIJnwVczSDzxKOs45FvSSpsoKodwiSECh/cmubHQGKFAqr5m+sJYk58xNvbv7yUchbrXSO/OytbHbCytEBHySDNdEdYMluRkJT6w/X2LW1H5Zo4hkXCPjdKf7cdHvh2c1c/Jc9gV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXv0LFOV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXv0LFOV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23228b9d684so13101595ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536820; x=1749141620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYNbXaI7S/Aqt1+tr2L7iGWdwvMVK43iCdmEWh/uNF4=;
        b=PXv0LFOVJ5wCIicVXSywdDiFJqzios0nHBNgWib5FhBMrlGNeCMDzg/spwmDJUYYYm
         2ESi6HMfpLNsIUSe6+rsSwXS6LqmQfolhJP7hJtzSVeuOiwm11+Oj+ABnklaOsC4W3rt
         XqUbjliGPq/IPII8ulrojTuvn/r5DHekxdjopPk7y06AgFlcaRFt/vpDa+l2cmb2pfPb
         MpEnM2DrJMWo8x4Y4h1xejXPelmFXUqAYre+nDYAAyUn52bi5sEkTfwa40vZnmLi8Uoz
         DEI6QWGq0xqbbjNh98374hVOMxY5IwwtiuVjMXmi3kfhL4k5MD3k1/aoSv1m+lZenRK9
         Zd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536820; x=1749141620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYNbXaI7S/Aqt1+tr2L7iGWdwvMVK43iCdmEWh/uNF4=;
        b=JieTxe3uJGqUNN1rUAltBWFRge9hRG9TMfnlYPi8yebBRaV04qDSqXxSIi3ccGw+nR
         JsmS3oczv99rgI6Gkvb+7RziExm/Xs6yDXVOe/VI/wmfGGE+rP3svb/JGIGVjIsfCfrK
         IOs/rhbeTetdu3ryv0lOSGPP0TV+qeFBzZhz1f9NO9k+pA2qhHZWAAF0F85VwASiRoxX
         1KmiFN8fIX8cDjG5yUoRQ0sXJ+9ZCD8VCYL/vO6KMVQRdNWUNcsobQAw7Cx2MF+ckwU9
         H0gINKq5OuqyXFoOLmaXl461QBi06mHXr39pSs0eEZFHfck54m6X2+IBV5BY4Za+/TKa
         pj5g==
X-Gm-Message-State: AOJu0YzRZR8N6GKRrM9xUf4A8HMbWjW34o+Pmiwi52Djseb2/W6+CpMa
	q+BmtIT7qZ6mpTP9jN8DTHevmOL8qoD/VBidwg+6hbA3h/xlxk5mAIlw
X-Gm-Gg: ASbGncv5itejuwqtZRfX/Dn9P9hunfhN0gysnq4ztsw6iN+7WvSE1K3iM7PfAaup+pw
	n9aOPUh+IwPaE3yk5K0AQ2BXk/v3+It4jgK+kboc6QBXdU2b54ZGvnIA96oqLVYD1eyxVj3hkcn
	+AsABzNnxAylav9vm+a6uPsRF7JRbfZnDlZ2lMZ2yYKt4LNGcbbs2sujWTZAn6EuCJsahWTmk66
	QJQH6KVr6I/CG9IcD6Msq3KEJRB7O4oCip+jIRdh9OJbpsN/WGGghQWequffYwSyyKL04pdWAUq
	keUVdkgkolxWvxe6x9cXbkNsXN79QFHpERSEffybXzrvyLiGgHsW3pVJE1i69eso6YFC5Q==
X-Google-Smtp-Source: AGHT+IGlRn6ufcaM9FLeterqYY+YfCTHaKiwbaVFWaTmmZV5ZtrbGUuJEWojZSwMmIH6vMs0Ijz1LA==
X-Received: by 2002:a17:903:2f85:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-23529201121mr3217425ad.20.1748536819577;
        Thu, 29 May 2025 09:40:19 -0700 (PDT)
Received: from smc-140338-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8cfbsm14361615ad.118.2025.05.29.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:40:19 -0700 (PDT)
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
	fan.ni@samsung.com,
	mst@redhat.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [Qemu PATCH v2] hw/cxl: fix DC extent capacity tracking
Date: Thu, 29 May 2025 16:34:25 +0000
Message-ID: <20250529163925.2916725-1-nifan.cxl@gmail.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
1) No functional changes;
2) Rebased the code to ToT of master branch;
3) Picked up tag;

v1:
https://lore.kernel.org/linux-cxl/20250520195741.789841-1-nifan.cxl@gmail.com/
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

