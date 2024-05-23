Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C1763F2
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486533; cv=none; b=Rsri1JDPFplftEbcTfIFXHnScxll3tGWO8vZF0ZEtjqtdfBRqmlitkSzBTVxfhfNnT4Muq6mCTfR8cxa5M+Shl3HnIBh0pboF5oR748ylIta/nUt/5vB+LfxWlGKPgCud9anupou9qE7pZqEqbh0M4cJ8GUKEVoWJ2LbmiHJcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486533; c=relaxed/simple;
	bh=q4bK1pRiMTI6djeBfQjIBOOjNwcGou5H/2AXuSYAsL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwGf8tx4I32PHcy9p/5qMG6UOKyKGhkowWGHetl9tEE6aE+2tsB+yp5ID2NYzqU+KLNy3+YhgzT2d7rIzDJOXRCylitgbN37/5ety3c7hATDYA3b/Djtfq+G4oF+3TDC7Wcx9ub83dNawlEfvi2lKpNJiDETFu9dfFb7j4MisNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwTKVYyU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwTKVYyU"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee12baa01cso22323265ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486531; x=1717091331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvFPMLoK01mkfdgG+TlQSzE5mXYNDErR/nxyp18SFeo=;
        b=ZwTKVYyUyWNmJuRFZ6Chw03iJboAtBuWFBhmU8k2zZqiRVfOVPI6TXmbVm/kDqZlIi
         Mat01Wp7lW8NmdsxmWpT8PaaIudJCjQwEehu+4T5LUY3TFG/C9v3VXq08AnSsG+K3krj
         frZJpb6mWjvjfy66DlaUBjcLyhPX/ELe07uUJl3o+Q15fOkq8Zn1UCe+DEOh+JdXfHpX
         6C++tqD4fsdjfB7bcC1+OHvEEgEBdao6z1hA9UBVQQuvebcgeYnnHPr/GbpOHobJVxS1
         MQn1ZSf6TIUCE7stXEy/sYf1uhpy/2fyvZMmNllaNo1C6DhRrXB1wuIn7Hek/caWtzAt
         y95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486531; x=1717091331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvFPMLoK01mkfdgG+TlQSzE5mXYNDErR/nxyp18SFeo=;
        b=Jk7coS96rBkbLJ2nWufUVy+EdlNJa/w/k5uU+JjJWk5fGqu1X+su0dXLaEDg0oSdvu
         ahIkjRXkVk4a9fpDIS6tRNYJCDS1PUwfGnvX3MLvtP3alICxCDQ8dEELAugfSvPiZqg5
         fkt85NEjWSX+nC2XgLX4Sq9YrO49TLOomFcGVL715ESQ2gQnigQINA0qrhoiOoHirhFA
         u0bgvvTC9gX4QxBp8TqU8DAK047H1xBYsOWwHVoMoWB0SPfhtG32aA4ikVGA6HswiJuz
         dqjHfEE0WjrASDcTTk64zzUkGBEFQd+Zk2kRt3WI8tJL91/pw9+5kknvyoPS81r/+W5r
         TPMA==
X-Forwarded-Encrypted: i=1; AJvYcCWymEX0o3FUyCYD4THrFuk96+n8bS61aoKbyfvyjwF63It7oNeU7dLIqIVbyNTbRKr+5sy8JjuPUzo5GJQuuG5kxlOEua+Z8578
X-Gm-Message-State: AOJu0YxGNKI71gQmJZfqZBs2wkSITguzknjRsQ/CcneZrMkik0sS2Qrn
	Y9c+6R4KKzfSpPsaTdz1twv3mkL/SD2LzfcE/7MV7OB3EYSf4YCw
X-Google-Smtp-Source: AGHT+IETzR8iasTTrODYffeR9p7FNeBvLAHH8lDyUFNCg4oA5Eiw8g9lIEKSh/CZIl1ocl9yLuGuhw==
X-Received: by 2002:a17:902:d48c:b0:1e4:b1a2:b40c with SMTP id d9443c01a7336-1f4494f2e86mr464425ad.42.1716486530621;
        Thu, 23 May 2024 10:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:50 -0700 (PDT)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 08/14] hw/mem/cxl_type3: Add host backend and address space handling for DC regions
Date: Thu, 23 May 2024 10:44:48 -0700
Message-ID: <20240523174651.1089554-9-nifan.cxl@gmail.com>
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

Add (file/memory backed) host backend for DCD. All the dynamic capacity
regions will share a single, large enough host backend. Set up address
space for DC regions to support read/write operations to dynamic capacity
for DCD.

With the change, the following support is added:
1. Add a new property to type3 device "volatile-dc-memdev" to point to host
   memory backend for dynamic capacity. Currently, all DC regions share one
   host backend;
2. Add namespace for dynamic capacity for read/write support;
3. Create cdat entries for each dynamic capacity region.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++--
 hw/mem/cxl_type3.c          | 174 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   8 ++
 3 files changed, 162 insertions(+), 36 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0f2ad58a14..831cef0567 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -622,7 +622,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t *len_out,
                                                CXLCCI *cci)
 {
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -636,7 +637,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -793,7 +795,8 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -835,9 +838,11 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -1179,7 +1184,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size +
+        ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 51be50ce87..f645a3f2e9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -45,7 +45,8 @@ enum {
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
                                           int dsmad_handle, uint64_t size,
-                                          bool is_pmem, uint64_t dpa_base)
+                                          bool is_pmem, bool is_dynamic,
+                                          uint64_t dpa_base)
 {
     CDATDsmas *dsmas;
     CDATDslbis *dslbis0;
@@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
+                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
         .DPA_base = dpa_base,
         .DPA_length = size,
     };
@@ -149,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    MemoryRegion *dc_mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
 
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
 
@@ -176,21 +179,54 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         pmr_size = memory_region_size(nonvolatile_mr);
     }
 
+    if (ct3d->dc.num_regions) {
+        if (!ct3d->dc.host_dc) {
+            return -EINVAL;
+        }
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+    }
+
     table = g_malloc0(len * sizeof(*table));
 
     /* Now fill them in */
     if (volatile_mr) {
         ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
-                                      false, 0);
+                                      false, false, 0);
         cur_ent = CT3_CDAT_NUM_ENTRIES;
     }
 
     if (nonvolatile_mr) {
         uint64_t base = vmr_size;
         ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                      pmr_size, true, base);
+                                      pmr_size, true, false, base);
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        int i;
+        uint64_t region_base = vmr_size + pmr_size;
+
+        /*
+         * We assume the dynamic capacity to be volatile for now.
+         * Non-volatile dynamic capacity will be added if needed in the
+         * future.
+         */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
+                                          dsmad_handle++,
+                                          ct3d->dc.regions[i].len,
+                                          false, true, region_base);
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -301,10 +337,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi = ct3d->hostpmem->size >> 32;
         range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+    } else {
+        /*
+         * For DCD with no static memory, set memory active, memory class bits.
+         * No range is set.
+         */
+        range1_size_hi = 0;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -579,11 +622,28 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 {
     int i;
     uint64_t region_base = 0;
-    uint64_t region_len =  2 * GiB;
-    uint64_t decode_len = 2 * GiB;
+    uint64_t region_len;
+    uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
     CXLDCRegion *region;
     MemoryRegion *mr;
+    uint64_t dc_size;
+
+    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+    dc_size = memory_region_size(mr);
+    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
+
+    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
+        error_setg(errp, "backend size is not multiple of region len: 0x%lx",
+                   region_len);
+        return false;
+    }
+    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region size is unaligned to 0x%lx",
+                   CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
+    decode_len = region_len;
 
     if (ct3d->hostvmem) {
         mr = host_memory_backend_get_memory(ct3d->hostvmem);
@@ -610,6 +670,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
         };
+        ct3d->dc.total_capacity += region->len;
     }
 
     return true;
@@ -619,7 +680,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+        && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -683,7 +745,37 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    ct3d->dc.total_capacity = 0;
     if (ct3d->dc.num_regions > 0) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+
+        if (!ct3d->dc.host_dc) {
+            error_setg(errp, "dynamic capacity must have a backing device");
+            return false;
+        }
+
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have a backing device");
+            return false;
+        }
+
+        /*
+         * Set DC regions as volatile for now, non-volatile support can
+         * be added in the future if needed.
+         */
+        memory_region_set_nonvolatile(dc_mr, false);
+        memory_region_set_enabled(dc_mr, true);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+        if (ds->id) {
+            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+        } else {
+            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+        }
+        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+        g_free(dc_name);
+
         if (!cxl_create_dc_regions(ct3d, errp)) {
             error_append_hint(errp, "setup DC regions failed");
             return false;
@@ -779,6 +871,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -797,6 +892,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -875,16 +973,23 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(dc_mr);
     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
 
@@ -892,19 +997,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
+    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-    if (vmr) {
-        if (*dpa_offset < memory_region_size(vmr)) {
-            *as = &ct3d->hostvmem_as;
-        } else {
-            *as = &ct3d->hostpmem_as;
-            *dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (*dpa_offset < vmr_size) {
+        *as = &ct3d->hostvmem_as;
+    } else if (*dpa_offset < vmr_size + pmr_size) {
         *as = &ct3d->hostpmem_as;
+        *dpa_offset -= vmr_size;
+    } else {
+        *as = &ct3d->dc.host_dc_as;
+        *dpa_offset -= (vmr_size + pmr_size);
     }
 
     return 0;
@@ -986,6 +1090,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1052,33 +1158,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
     AddressSpace *as;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
     }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(dc_mr);
+     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
         return false;
     }
 
-    if (vmr) {
-        if (dpa_offset < memory_region_size(vmr)) {
-            as = &ct3d->hostvmem_as;
-        } else {
-            as = &ct3d->hostpmem_as;
-            dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (dpa_offset < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_offset < vmr_size + pmr_size) {
         as = &ct3d->hostpmem_as;
+        dpa_offset -= vmr_size;
+    } else {
+        as = &ct3d->dc.host_dc_as;
+        dpa_offset -= (vmr_size + pmr_size);
     }
 
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index f7f56b44e3..c2c3df0d2a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -467,6 +467,14 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
 
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        /*
+         * total_capacity is equivalent to the dynamic capability
+         * memory region size.
+         */
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
-- 
2.43.0

