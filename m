Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494085642
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539685; cv=none; b=XaIHglOG3+jOcJrH962StQjI2SWCd0ae1GTcAUUmQdHPMOjUx/iTifybt+fQQoTRN1W3abj+WJ/Q5QR8mobbgTVYR1IDS75fQonl9POUuGFjZiER8rn9L5IP1QCa/bnni/GqXfmpxDN6MKYTQpa4GqadV4kuKNe885K+J1f1wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539685; c=relaxed/simple;
	bh=gi7SFXAZ79rmte8FoP+PDuMFiWsB3vEfmOINJ9CV4MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHAMt+6bV+E8Q0F6b7tZhhZzJFx4SYXc6K+RLFH9sggtp/MoD887+RBTYHv9d8bKAyP5/T9LDfpVXVtrKRJ7/f8SlVppJkMYrK9oHDFAorysQiIFNBmM92qo6mDasaBAzWsdYfjTCCanpFxKZb3ceovsR0gUwGbu/2TP6MsFlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvzkMzIu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvzkMzIu"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so4109171a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539683; x=1709144483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lopfkfP/Wd4iBuj5Kqs/1syP004OyEXA8CH53rf8oR0=;
        b=DvzkMzIuCguFveLPARcZCvxNir1AstzhndI62zOJk6CId9MCClbBBKQva0e+6dNDCc
         8P4w8kBtIFp2SLdJtEtmwHexyA/k3n49pIs9cFZXh6HXpNyXia/f/JdsrII2+jlAj7rL
         m4JiPZfKZ0T5Ge1mpCVG02YBbAyxv7q83SUnrX+6UCso9I+XqMkMFpVVtH/GgJaWT9RP
         8gpCtcSyhSNWx8vC4gJq1IjyrjifKC9Y3ZeKY8vHLEdTkCA1eEcsvVJc4OXSXVyMsyXj
         NYJy5Yy5o5+8DtWWXI7luZrS9IylEoQnuee0KDN3wxsdRvJ0dzxTgFOtnhAqfWOrdEZY
         NH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539683; x=1709144483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lopfkfP/Wd4iBuj5Kqs/1syP004OyEXA8CH53rf8oR0=;
        b=sLbBD6bdzqTBG+xE0wscf1ZmsBmhET9l/1fiuSiFTSgg3+IRU/ap+cxfcPwrQ1g/I4
         73YMEZkgRinRBbZlxVQTHiRwpmd76zoNmeVlLwdhTYRHMrF5elhilwhORhDZySCuSEml
         ksf2bL6mzTa14BB0JVy7zBtQ9/5WJ9RlFAJ8Y+P4gxO3U73gnUG6b3XJXaHuyOJ0dfGO
         hvc81HrFQaIKK7VibKbLxMfgTtaP+NR2p6WO7Vt+hh+pNOAFt4Igm4cDuXWN49sicqey
         +o6rGgyL43CX+hJ6l8Znyy6qksvGhTr9Egemo7dPV0K50gn/uD29jaOazBe1r2Qr9esS
         /HAA==
X-Forwarded-Encrypted: i=1; AJvYcCVzpPYVRbDHkUYhd+aotM9XXNuVdz4gIqFDr6LQQpTVoS4iX6t2Udw+Cw2x13gfrcxS3A5wsDG/Wz+HSGN3QvIm/8iJzCHdjO6E
X-Gm-Message-State: AOJu0YwnfPUPYZ9Bcb8COblxDuv4PWj/2coV8e8IHbQieMwUadVwjhN/
	c4k2U0O9Nv4dB3azITTl3V9Xai7WoB1lw+R4+x6ZGDBAJ3wbSt88
X-Google-Smtp-Source: AGHT+IGI8ZUHUmT+j5cQpkDxDF7pWt+w5yGxEq/geBFaBWFR/5DdTtSK+rbAurJexC4zeUi0z++sIQ==
X-Received: by 2002:a17:90a:f3cc:b0:29a:3bb5:7b91 with SMTP id ha12-20020a17090af3cc00b0029a3bb57b91mr601189pjb.2.1708539682849;
        Wed, 21 Feb 2024 10:21:22 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:22 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 10/10] hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
Date: Wed, 21 Feb 2024 10:16:03 -0800
Message-ID: <20240221182020.1086096-11-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Not all dpa range in the DC regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a DC block in the region has been backed by DC extent.
For the bitmap, a bit in the bitmap represents a DC block. When a DC
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  3 ++
 hw/mem/cxl_type3.c          | 82 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 92 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 34c4ebbd12..fd3be2f9cf 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1676,17 +1676,20 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                 found = true;
                 cxl_remove_extent_from_extent_list(extent_list, ent);
                 ct3d->dc.total_extent_count -= 1;
+                ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
 
                 if (len1) {
                     cxl_insert_extent_to_extent_list(extent_list,
                                                      ent_start_dpa, len1,
                                                      NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
                 }
                 if (len2) {
                     cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                      len2, NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa + len, len2);
                 }
                 break;
                 /*Currently we reject the attempt to remove a superset*/
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b8c4273e99..a56906db25 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -660,6 +660,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
@@ -667,6 +668,17 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     return true;
 }
 
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCDRegion *region;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -860,6 +872,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -881,6 +894,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -891,6 +905,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len) to be backed and accessible. This
+ * happens when a DC extent is added and accepted by the host.
+ */
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len)
+{
+    CXLDCDRegion *region;
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
+ * Check whether the DPA range [dpa, dpa + len) is backed with DC extents.
+ * Used when validating read/write to dc regions
+ */
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len)
+{
+    CXLDCDRegion *region;
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
+ * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
+ * happens when a dc extent is released by the host.
+ */
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len)
+{
+    CXLDCDRegion *region;
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
@@ -996,6 +1074,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
index 1d31164bd3..10f0389b50 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -450,6 +450,7 @@ typedef struct CXLDCDRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCDRegion;
 
 struct CXLType3Dev {
@@ -557,4 +558,10 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                       uint8_t *tag,
                                       uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, int nr, int size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0

