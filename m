Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBA79955
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581470; cv=none; b=Ouqdjcb3pi8fHcANAtWoYPKQdVLe2SBfVFZMvp0xSpnpNR6Va3f4VVczQIL/3RJe5Kgpvip0AsodJzZNKrO+FsF8HXYzi1EO47h2j8U8gF0tlv2sjcOaFKi1KjkemjC8IWt+DSEdnHGNuIUVIJYLdOL8cQwxpfn3P6LFO8rraDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581470; c=relaxed/simple;
	bh=mVm0UNgh3ZwpCrXeqT/IHKRH5OFdo9MzIgXnwdgWnak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjXuVc9WKnorrmwsnnBgN9f3rGNM/hs1rpV3sgr6sO9f0OUF0hJmaRe5qoBIKWHBphXRkORKGq78BFUCxRKZrgRIRv/ptwldHpnatnGiCErqQqTx/g1SebgsPwFdR+UQ/RPmy0BJhZvOgs1tYDh9xlGE8US0zSOtz/gLBw2iGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJL7pwBS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJL7pwBS"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4372636276.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581468; x=1710186268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJmbpLHmX91RSD+FS2bbI4ESdtGu0icFFQqbt0j7En8=;
        b=MJL7pwBSiubmwVnt+Zwshf/PX1EQN0SyMe6BzVesHffztvVIBxaR6gqWgR3KiQ9IQw
         1gGgMw5riBalzYuQKKv7/3hXIL175yn2e/0X/4udhJ9pUGO4NJC3mf4L5JF5u1cxI13S
         8ktdriTk10Q53pBsI7b+vA8uSdVdfRipmc/JYeB3xlfRnKfAYZuLeAIOFHgTT0fVYkce
         a0i7AIUXxjb+ffqmLIUy0UnQvELp3rK++GWBmWqAClf43DLoR+mKlOR41gtXjY6hI2OW
         Gp5EzXNM54FFU8cLdWZaHNKcBFKqojijTfYorX7Dkxv1LMyGzs9Dt1ISpnTBXIPX9Sua
         TxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581468; x=1710186268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJmbpLHmX91RSD+FS2bbI4ESdtGu0icFFQqbt0j7En8=;
        b=AFoHH0GLWIRw5Ncr/nzw7GibTS1oq93bbjIQ0oYfcnv93BicWoJm6uVVp7pNzr9T7B
         z+RSJBSP30b1ptScD+ykrTVNA61dJqKvrQO+W2ptCbutKL2oKzteRH2w+eWtRAVqIQ6+
         FQIhJelB0B14S3iHveuMczbYl5+ivUacXc8WFdajZckkxKi/5K1fnhcjoZEj1XA6PKEj
         ZTm282uXvdS7fbT07ZIcWfTTr7q1XN8oWzZsDgVTGFms4NcXTOEIf/kREhRxInK9DLg7
         QGdOccfVLfuiPuWaFpuhFWuk5KTCympyrK+PBmo5QAyp1moh9Iib96XF330DZCO8lRtm
         LjxA==
X-Forwarded-Encrypted: i=1; AJvYcCWuogJky1uSwFOPBuzLiLkx3JwdZcWD6CTuBXKPUJMTUUyTM2MBLKGXcoYVv1ByhSjomMjbyFtb1Rnf6f1n+Ef8Pb9xC0DRXVGy
X-Gm-Message-State: AOJu0Yxyd5juDajPZg+7nTZCJMNCzibN4T1VcBEnz5QCV2LryZqtT8GZ
	UcGY+3Y0DeSvUg905kHErhPvXPVTOJgMY3dXm8icX8N3cNmLm/JZ
X-Google-Smtp-Source: AGHT+IFgVk4gFsTBw619+d2h77tRgbIEeyXBAg4E1CIdEk27elXaNIecJfX30qCONXyB3gh3/cBbGg==
X-Received: by 2002:a5b:644:0:b0:dc2:41de:b744 with SMTP id o4-20020a5b0644000000b00dc241deb744mr7144765ybq.32.1709581468003;
        Mon, 04 Mar 2024 11:44:28 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:27 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 10/13] hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
Date: Mon,  4 Mar 2024 11:34:05 -0800
Message-ID: <20240304194331.1586191-11-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
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
 hw/cxl/cxl-mailbox-utils.c  |  4 ++
 hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  7 ++++
 3 files changed, 87 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 53ebc526ae..b538297bb5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1606,6 +1606,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
 
     /*
@@ -1681,17 +1682,20 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                     found = true;
                     cxl_remove_extent_from_extent_list(extent_list, ent);
                     ct3d->dc.total_extent_count -= 1;
+                    ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
 
                     if (len1) {
                         cxl_insert_extent_to_extent_list(extent_list,
                                                          ent_start_dpa, len1,
                                                          NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
                     }
                     if (len2) {
                         cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                          len2, NULL, 0);
                         ct3d->dc.total_extent_count += 1;
+                        ct3_set_region_block_backed(ct3d, dpa + len, len2);
                     }
                     break;
                 } else {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e9c8994cdb..c164cf4580 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
@@ -682,6 +683,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent;
+    int i;
+    CXLDCRegion *region;
 
     while (!QTAILQ_EMPTY(&ct3d->dc.extents)) {
         ent = QTAILQ_FIRST(&ct3d->dc.extents);
@@ -693,6 +696,11 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
                                            ent);
     }
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -924,6 +932,70 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
 
+/*
+ * Mark the DPA range [dpa, dap + len) to be backed and accessible. This
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
+ * Check whether the DPA range [dpa, dpa + len) is backed with DC extents.
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
+ * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
+ * happens when a dc extent is released by the host.
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
index b524c5e699..b213149de2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -450,6 +450,7 @@ typedef struct CXLDCRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCRegion;
 
 struct CXLType3Dev {
@@ -557,4 +558,10 @@ void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
                                       uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                        unsigned long size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                 uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.43.0

