Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F44C83
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393499; cv=none; b=t0OHj7i4RKR7CY8TibHt4am/GDa+SHKZssrIzDa7x+8l+UE6s9YqMngfVxZIo99A6r4PqULVbS7STtSN1r73VMiKsBivg3+QalZXq0KD3Pb+RlPhEK1Tjt24dZK231OCCR5/dFBaUOnXWCTODgjYZ2uebkOgqstjcZsW4xUW7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393499; c=relaxed/simple;
	bh=+SYHBmlTlkSltya5tL8aSHbriUoG0N83e336Fnr8qME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0+p7/KYYBb+1v72KGPlR31LUnEvG5nVtQ1j9l9x5XxI2XXcBuE96jFRyrD3CBvWkPcJEBWMRDoy1J9DysJB3x9igmn1c/qCBAacBQl6dwb00MSH0VAj4LgmHZ+08lCEkpoyZ8VAxs7wfR3qC/0ffGnH4PY6Lir5ft+u25ccEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enn+CrYl; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enn+CrYl"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36897ed32f9so2750205ab.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393497; x=1711998297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hl+9iwdY1IzIu9iDPkfmumLwvkEBhE4sR7cuyu/dHg=;
        b=Enn+CrYlRHYxLHkk61EevpjtAeDiWOEyLAvfdKSkvNn+gn9YlPjv83qCm53p1hC2Oq
         Sio6Ia4mINzckgbsBE3j2ldHbf2h77H5R9Lirk4YTIO8zuD4RodUzFg9GMvbaJVNF7rX
         w4rL4LkGIwiX1HXUtRlurte79vGZGW6KKWHgudMQc3y2l5kRo6b5kO+YRj2Cve5H4FEg
         SA6E0aE5lt/NgGD0KhFXM/5Dzbw9rrMWct1rEmYGMyOASOemZJ8/ldIv97j0Y3vZqQ5z
         six/vQEP6shKZG2kzYfKmMQdH5bQ/xmjakIbs1y0AScz5eQYdeJqaCTXNUds+gflzx0d
         l9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393497; x=1711998297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hl+9iwdY1IzIu9iDPkfmumLwvkEBhE4sR7cuyu/dHg=;
        b=R2IuhT5XHgNM6YCKLv3NoMBid2zu8XYAcn7GO1z+EqemnDskohkvRSt/Lih1XYnViP
         lAbVzcP7QQ5hTgQi8i+mZA8GMOp3JG+ExxxrjqMuXuX4GjbxKlCLwETSPIEnRog9oo7t
         MpGPWnUMFMXTTYrjsJRGPm9tVpwkoyWhsgloLqgiD3WOGp+XG/Z0XFAVLOrp2WMY77SS
         MOOzSzF+T1LkVW8IDIMspjpT3CicQIgdlAQdTtLqGhzfdvNhcHMsMTYTVn93mYXjL1Ru
         WIHttYzlhimJl8UiPUTKIDqX54R5Egys+j0EPpeLiFZYQGwE8G7rT401RBpZozh0bJrC
         ak1A==
X-Forwarded-Encrypted: i=1; AJvYcCXoKvSbqdNWSAb/raTbNHPNdJjmsWHZzWq1w+ZdY72hgHN1k0WwGe0IhF2ba0JqiHvGBS3ww7JzA2M7Mhk0NwP5YUYO7byCYnPo
X-Gm-Message-State: AOJu0YzJlZl/cUgm/kfSXD9DWGsc2b6TGlfG2Lpo7/bKtqHc0nAl1moK
	9+Wifu/V4ABrXaGm7KEbfjghNEES8sWQFioULL2VMqogPN3r5p2w
X-Google-Smtp-Source: AGHT+IGc9FRWx0eL65nIDDAzsuPuf8IL9et/6B2jfyccxqQmw9OSUztCOPmfFxh3U4MmMzExS+vMCQ==
X-Received: by 2002:a05:6e02:805:b0:366:89f6:82f8 with SMTP id u5-20020a056e02080500b0036689f682f8mr8256468ilm.1.1711393496642;
        Mon, 25 Mar 2024 12:04:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:55 -0700 (PDT)
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
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
Date: Mon, 25 Mar 2024 12:02:28 -0700
Message-ID: <20240325190339.696686-11-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

All dpa ranges in the DC regions are invalid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a DC block in the region has been backed by DC extent.
For the bitmap, a bit in the bitmap represents a DC block. When a DC
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  6 +++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 89 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7094e007b9..a0d2239176 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
 
         ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
@@ -1798,18 +1799,23 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 
                     cxl_remove_extent_from_extent_list(extent_list, ent);
                     ct3d->dc.total_extent_count -= 1;
+                    ct3_clear_region_block_backed(ct3d, ent_start_dpa,
+                                                  ent_len);
 
                     if (len1) {
                         cxl_insert_extent_to_extent_list(extent_list,
                                                          ent_start_dpa,
                                                          len1, NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, ent_start_dpa,
+                                                    len1);
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(extent_list,
                                                          dpa + len,
                                                          len2, NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, dpa + len, len2);
                     }
 
                     len -= len_done;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 74cb64e843..2628a6f50f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .flags = 0,
         };
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -682,6 +683,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
+    int i;
+    CXLDCRegion *region;
 
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
@@ -690,6 +693,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending,
                                            ent);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -921,6 +929,70 @@ static void ct3_exit(PCIDevice *pci_dev)
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
+ * Mark the DPA range [dpa, dap + len -1] to be unbacked and inaccessible.
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
@@ -1025,6 +1097,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
index b84063d9f4..bc90da2ca2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -450,6 +450,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -563,4 +564,10 @@ bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
 bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
                                     uint64_t dpa, uint64_t len);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0

