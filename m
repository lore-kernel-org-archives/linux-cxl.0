Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198117C77
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486539; cv=none; b=ITf2lqC1RVcc+gf+9BPU+JWY0/+WrvuzDysYOlVr1s7+EzppC8DV6vDdNafci3AMz9BwoNGyvMfyAYxuSEiwgj7D1ECduHhi3OtEhHXtmNA2vQPSlUviALdRziSYE9CFiIZhSb7gyvyn3aclsCNZ8SG4AVSUTj5aLqQYZjVWitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486539; c=relaxed/simple;
	bh=88iK6XRBmPran6ZbRdZG6soJ6vpEuN+RKnwS7UvAH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYocvMXXSp1o9ICMW95G3zVBbCVxiXqNoHn60KCfawJBLw0Jts+g54hi+prlowyovaCyFjy10SNBgRUSuSXbQGaYzm1UyFGHjRVoTGqVg9tPVOYxUfr16Ywfe+KeF0/Qu3zU7p/WdXWbcvEFY36jf1Eb/bFSrzMrsQO2L/+m040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8VIwxU3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8VIwxU3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f332528c1aso13479755ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486537; x=1717091337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdMPl+cqllxYu/DQv6hq5NibyaBbgGeK2RHmqU1o/rQ=;
        b=F8VIwxU3y18/6b7OiXKKLVU0EnN6RlITJr7KBF4ddr3/JHLSDwzJQwCtNPvXAGw6CX
         KewVlhzM9mNj4nBKFfNh1P8cEdosueo9kDP0RDy9Ib0tFEk5ujwWWj8iSKeyvifmKUso
         WmnJsxWMjCLhwmbCBeLW1CgIKG83pwEB7XFzjsPKuplTis5tSzHMAIP1J3PSyL3TXga1
         4oJZ4BCTbzkGmY9P6bOTPzwHW4lhhXfLJNGSWKtG9WyoJ4n3lxkvBio5kbUXfUZXZUNL
         kqwyJZBv5egSv/EOChJV2TN+NkSHaZBl61M3wU+8d2sMTZnq7QpCKb08o2MArSi0b/ss
         WFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486537; x=1717091337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdMPl+cqllxYu/DQv6hq5NibyaBbgGeK2RHmqU1o/rQ=;
        b=wYrxcP9GDPeBUsd7slSqwEnO1hTbKCsijMo/RHciOr4I7AibIElHiAoAVahjIvXVu/
         VN6jAtncs8JJOv6Mdu4wPhH0zkQlGygw+y9JN03X3WD83oRKZHAe+vjFFhjUlpoVcqtO
         kMClZs2F8oE+CCKEKHKd/59MEtYzLNkQD0tdlWeasnmqBnsZcbRYyS4xMf06gZcpjfP/
         3b2boEubR0fkILqsddkyYD/GcCf7ENGpP1AtYf/yWEyzfTL1PLUEFYxcTP1cgf9xoqxy
         /8KDGvRhl4KrrQF2LvmnaV2mj2Vt5f8RM6w4ADzkkt0AaV2aFL0xtdbOOiSxJSgfsS+0
         QWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXD4phAq4DwvfWdWqvIvB9BjcBO407rfm3rMUd+JYP3mN49SayGm1Xs8ckv1hgDWfhcO9NtEKG5n66IxbVE8ga6IzdRYAW8RJM
X-Gm-Message-State: AOJu0YytWfgVPXmnZ6Uu4jWjtH6+DNnRAaPJ0s8xHOr59fO4spi6d+O9
	YG8J2OLcQ1wvLPOU5z9y8+CnxMhZNpFK2beTy2Ne3fjgoAtailJv
X-Google-Smtp-Source: AGHT+IHehiabqYnVUJQxYIy6yhBc7pdUHHNaYYN4bddYFtnk788KTzylMWc10q/piC8M/olLxZvAhQ==
X-Received: by 2002:a17:903:2347:b0:1f2:f9de:c9e8 with SMTP id d9443c01a7336-1f4486fd296mr777535ad.2.1716486537115;
        Thu, 23 May 2024 10:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:56 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Svetly Todorov <svetly.todorov@memverge.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 12/14] hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
Date: Thu, 23 May 2024 10:44:52 -0700
Message-ID: <20240523174651.1089554-13-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

All DPA ranges in the DC regions are invalid to access until an extent
covering the range has been successfully accepted by the host. A bitmap
is added to each region to record whether a DC block in the region has
been backed by a DC extent. Each bit in the bitmap represents a DC block.
When a DC extent is accepted, all the bits representing the blocks in the
extent are set, which will be cleared when the extent is released.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 86 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ab71492697..045bce8f74 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1655,6 +1655,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
     cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
@@ -1813,10 +1814,12 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
      * list and update the extent count;
      */
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
+        ct3_clear_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
     copy_extent_list(&ct3d->dc.extents, &updated_list);
     QTAILQ_FOREACH_SAFE(ent, &updated_list, node, ent_next) {
+        ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
     ct3d->dc.total_extent_count = updated_list_size;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2161766b14..60cbaa9bb6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -671,6 +671,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .flags = 0,
         };
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -682,6 +683,8 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
+    int i;
+    CXLDCRegion *region;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
@@ -694,6 +697,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         }
         g_free(group);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -925,6 +933,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCRegion *region;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
+               len / region->block_size);
+}
+
+/*
+ * Check whether the DPA range [dpa, dpa + len - 1] is backed with DC extents.
+ * Used when validating read/write to dc regions
+ */
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len)
+{
+    CXLDCRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return false;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = DIV_ROUND_UP(len, region->block_size);
+    /*
+     * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
+     * backed with DC extents, return true; else return false.
+     */
+    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
+}
+
+/*
+ * Mark the DPA range [dpa, dap + len - 1] to be unbacked and inaccessible.
+ * This happens when a dc extent is released by the host.
+ */
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len)
+{
+    CXLDCRegion *region;
+    uint64_t nbits;
+    long nr;
+
+    region = cxl_find_dc_region(ct3d, dpa, len);
+    if (!region) {
+        return;
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
@@ -1029,6 +1101,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         *as = &ct3d->hostpmem_as;
         *dpa_offset -= vmr_size;
     } else {
+        if (!ct3_test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as = &ct3d->dc.host_dc_as;
         *dpa_offset -= (vmr_size + pmr_size);
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c69ff6b5de..0a4fcb2800 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -456,6 +456,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -577,4 +578,10 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
 void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0

