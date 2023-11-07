Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0253589D
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXsXahkQ"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A06C6
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b9a456798eso3557424a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380625; x=1699985425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3VD1vraDKH7t/1eP7lxzrPhMiE3bMoC5UEpP6LTwk8=;
        b=MXsXahkQVMb9d7VYopERZ1NdAmGj+MgDiJHkDAXPkmjsx0gy1TTO/wF5b/vYUwZq7D
         IcBkVPzBFNKiw3qkaoIG5zxKJRmis6YIyqUbl+/Za+gbVE6K+xbT0CNG7z5trjjoC11t
         kQwDqPqp5c5ZuuaMPWTzWE40YuZYYyVfdUTa861s8lSD4YW3LVbNv6rVEd0YyOmDg0x7
         IHkUJ0g/Bf6NpW4evCg2RxXhJZvSim2atnKr/+3o7Z0eDAXzVBFJiclMXhoEERaGCRcr
         0Cmtvot5kaSjycsAr7u5PlQOyD3aG4WJ3u1dPJxLirgm8/v1ti5TBqSeO4tXvLoTL1Qm
         ZibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380625; x=1699985425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3VD1vraDKH7t/1eP7lxzrPhMiE3bMoC5UEpP6LTwk8=;
        b=iihwK3AKr2DmHEPbd+cRaUoQdOsm7cycO8/vku8LudrGuHXMqBjfzKzTljixOPWSyk
         fL78lmiJF0aZYejHYY2uxIJbVeGkw+PYv8pHv0QRNzVsiJdVYKYCGtUZX1YgHiaopZ5o
         frljfGvUjUfJhSP+XlYSEnGpwrWbVQVj4gXzTSzRIqgaygXuY2TFkmp/IAzLGLuaZk04
         A04dwrbsuZvne6CkWMwWsaUrBbDad5s+kkgHN95y0y/8+MHUs2y/HuRFZJBNSct8KDpi
         BgPm37TpVs6XfWL3I2+S285X7M9pmk3ZRHyiMvvViu0tqe4Z8kEHfd+js95HAftFvd1i
         /nNw==
X-Gm-Message-State: AOJu0YwAANQijTahHMFh4Khc1kIwysMwgWti1H3wWgL8TDHvIUZGl8wQ
	RSzZ9xyrJkm4xpmRotdwz8M=
X-Google-Smtp-Source: AGHT+IEGtULtzP3zUAeEcHZAMhAMLm8y71Y+vs76AD4I/K8Ta3QaxjqhuJ8KDNsahiaEcfKxi25Q/A==
X-Received: by 2002:a17:90a:6f84:b0:280:9074:eb3d with SMTP id e4-20020a17090a6f8400b002809074eb3dmr17621113pjk.22.1699380624853;
        Tue, 07 Nov 2023 10:10:24 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:24 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
Date: Tue,  7 Nov 2023 10:07:13 -0800
Message-ID: <20231107180907.553451-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Not all dpa range in the dc regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a dc block in the region has been backed by dc extent.
For the bitmap, a bit in the bitmap represents a dc block. When a dc
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>

--
JC changes:
- Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
- Drop unnecessary handling of failed bitmap allocations. In common with
  most QEMU allocations they fail hard anyway.
- Use previously factored out cxl_find_region() helper
- Minor editorial stuff in comments such as spec version references
  according to the standard form I'm trying to push through the code.
Picked up Jørgen's fix:
https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com/T/#u
---
 hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
 hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 15 +++++--
 3 files changed, 109 insertions(+), 15 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8e6a98753a..6be92fb5ba 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
 }
 
 void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
-                                             uint64_t dpa,
-                                             uint64_t len,
-                                             uint8_t *tag,
-                                             uint16_t shared_seq)
+                                      uint64_t dpa, uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq)
 {
     CXLDCDExtent *extent;
 
@@ -1421,6 +1420,13 @@ void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
     QTAILQ_INSERT_TAIL(list, extent, node);
 }
 
+static void cxl_remove_extent_to_extent_list(CXLDCDExtentList *list,
+                                             CXLDCDExtent *ent)
+{
+    QTAILQ_REMOVE(list, ent, node);
+    g_free(ent);
+}
+
 /*
  * CXL r3.0 Table 8-129: Add Dynamic Capacity Response Input Payload
  * CXL r3.0 Table 8-131: Release Dynamic Capacity Input Payload
@@ -1545,14 +1551,15 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             }
         }
         if (ent) {
-            QTAILQ_REMOVE(&ct3d->dc.extents_pending_to_add, ent, node);
-            g_free(ent);
+            cxl_remove_extent_to_extent_list(&ct3d->dc.extents_pending_to_add,
+                                             ent);
         } else {
             return CXL_MBOX_INVALID_PA;
         }
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3_set_region_block_backed(ct3d, dpa, len);
     }
 
     /*
@@ -1601,16 +1608,22 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
                 uint64_t len1 = dpa - ent->start_dpa;
                 uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
 
+                cxl_remove_extent_to_extent_list(extent_list, ent);
+                ct3d->dc.total_extent_count -= 1;
+                ct3_clear_region_block_backed(ct3d, dpa, len);
+
                 if (len1) {
                     cxl_insert_extent_to_extent_list(extent_list,
                                                      ent->start_dpa, len1,
                                                      NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa, len);
                 }
                 if (len2) {
                     cxl_insert_extent_to_extent_list(extent_list, dpa + len,
                                                      len2, NULL, 0);
                     ct3d->dc.total_extent_count += 1;
+                    ct3_set_region_block_backed(ct3d, dpa, len);
                 }
                 break;
                 /*Currently we reject the attempt to remove a superset*/
@@ -1621,11 +1634,7 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
             }
         }
 
-        if (ent) {
-            QTAILQ_REMOVE(extent_list, ent, node);
-            g_free(ent);
-            ct3d->dc.total_extent_count -= 1;
-        } else {
+        if (!ent) {
             /* Try to remove a non-existing extent */
             return CXL_MBOX_INVALID_PA;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 43cea3d818..4ec65a751a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -810,6 +810,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
         /* dsmad_handle is set when creating cdat table entries */
         region->flags = 0;
 
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
         region_base += region->len;
     }
     QTAILQ_INIT(&ct3d->dc.extents);
@@ -818,6 +819,17 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     return 0;
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
@@ -1046,6 +1058,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1068,6 +1081,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1078,6 +1092,66 @@ static void ct3_exit(PCIDevice *pci_dev)
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
+ * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
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
+    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
+}
+
+/*
+ * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
+ * happens when a dc extent is return by the host.
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
@@ -1178,6 +1252,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
index ca4f824b11..b71b09700a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -447,6 +447,7 @@ typedef struct CXLDCDRegion {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCDRegion;
 
 struct CXLType3Dev {
@@ -552,9 +553,15 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
-                                             uint64_t dpa,
-                                             uint64_t len,
-                                             uint8_t *tag,
-                                             uint16_t shared_seq);
+                                      uint64_t dpa,
+                                      uint64_t len,
+                                      uint8_t *tag,
+                                      uint16_t shared_seq);
 bool test_any_bits_set(const unsigned long *addr, int nr, int size);
+void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
+void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                   uint64_t len);
+bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+                                  uint64_t len);
 #endif
-- 
2.42.0

