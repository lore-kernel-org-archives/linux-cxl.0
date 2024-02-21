Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E484FC5
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539680; cv=none; b=f1WfkuYk8cLetrQQ7FPHxEK+ejgxqbgxuNsrx6EjFMVB3ZvIjKuu+XUm8YjQXmC5IVmM6Xqfwgr2i/2dDjEBgLxVlMlrx1N44M5vpt0idUwpUaauC+DPxbktDMFzi+p+QDYX/Z0d82LcUqHDfxIdPv20Vj9t1IOaBrBgtVCJYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539680; c=relaxed/simple;
	bh=wwTzhgPfGwW02M1ZAuyEF2oDyXuSfcQBR26acC5ZY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsgI+eKzF8KoCwUerhmvbdeO+gtMSbaLG4U+sWC2bjK9tKQyktt/By8ijC+W54wv7NuuCb0JDwgTWmKg1JvBOACEoDIY/qtbaUo3HrQGqJXjxTqSBbGloObXQYZARR+JNKwidh8ernH/s6Vdz3e124xS+O9A5gUgIbVfy45X31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hImn38RD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hImn38RD"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso686323a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539678; x=1709144478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByXkFoZstt7Taile7J7sAjWvfPjaE3AcMIHhZiOAS+I=;
        b=hImn38RDKtKAyU2LR0VvsKqPF0xw9l4cCP2za/9cZyTpIsdm9Uu3o5x3a7hFRBJ38S
         6MK/vh6E9NnEkD+48U+sgHHF3VFYPcAaIALUhP0tS/UVgeDTtfY4Evq2xcOJsS5gryvy
         rFTyF/9M4aEjjm4yTsup2W6wE0UlHB7vABe3gvutn7ztk7IhJVvt0WdMv+2f7KcTbDi5
         BM1FXi0vCSS1pAZk3m8id92K442+w/wjgUlC/ZKmcl7EwlAawrmpcChk7V5eDLgBHbqk
         WEyoqACew8Eq/UD4E3V02AY7sobP43+YykF6v/EnORlt4L+tWd4U4vtG3AG4WkHt4CjD
         BL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539678; x=1709144478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByXkFoZstt7Taile7J7sAjWvfPjaE3AcMIHhZiOAS+I=;
        b=qhMkv8Za0sxZ30mmIhOWKA3IaPrmc+9luwM4R88dJEqWO8DCGhfbaXRSsJLWDuhRsn
         U6EHk6G91JM7Bp5d5T8hHKroYLs+B9ALTkU+okVW5TfvR3hkHpyGsFqcHaGIKRAM9Un3
         zdv2NhyzFHQvnlVGD0tyK9goWuGAZff2FTYdYXYAOK8WQj6q3cj/DSgkoYfrxszDgD0c
         H6+SOtxknwjLrz2eDjFcZzYmUuxYGYyW40x3eG0jf5FwtRG5o/+7R8D3QwcRD+nX+o+F
         IJmlCwVqsUQJ6lJWA9zH7O2oASiFHOFtP7R4n7hze/JFk359ETqQTrKHxz7/iCj3fS22
         CyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfHQN7QbpS3FP3R4gtk4j9m3rrVT7ShaFgaASOPboVsW1eabtSybpdMH/3T81pclPMOWG5Gq4HcDvvRSlgnOsCrcwkC3EGZFc6
X-Gm-Message-State: AOJu0YxoTpJ1e6QvY6vqEHuBbCYZjrppL/UDpbdUu9wtGrZG/U27RVbr
	NlH6nowsd9+NIhIV15nmnNgUUqRcXQ8gvWoHYbl0j5KXfoJkIzW5
X-Google-Smtp-Source: AGHT+IEDrY9CBvXUVAZCTG6XPyMxCbOD4bhgwDQW7wmUAU1B3xHNd5EHMNgjtfioPjh2SMGZMZxwqw==
X-Received: by 2002:a17:90a:b014:b0:299:6e88:7b6a with SMTP id x20-20020a17090ab01400b002996e887b6amr10884499pjq.36.1708539678029;
        Wed, 21 Feb 2024 10:21:18 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:17 -0800 (PST)
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
Subject: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address space handling for DC regions
Date: Wed, 21 Feb 2024 10:15:59 -0800
Message-ID: <20240221182020.1086096-7-nifan.cxl@gmail.com>
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

Add (file/memory backed) host backend, all the dynamic capacity regions
will share a single, large enough host backend. Set up address space for
DC regions to support read/write operations to dynamic capacity for DCD.

With the change, following supports are added:
1. Add a new property to type3 device "volatile-dc-memdev" to point to host
   memory backend for dynamic capacity. Currently, all dc regions share one
   one host backend.
2. Add namespace for dynamic capacity for read/write support;
3. Create cdat entries for each dynamic capacity region;
4. Fix dvsec range registers to include DC regions.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++-
 hw/mem/cxl_type3.c          | 188 ++++++++++++++++++++++++++++--------
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 165 insertions(+), 43 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7d2b74c9c5..f95e417683 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -621,7 +621,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t *len_out,
                                                CXLCCI *cci)
 {
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -635,7 +636,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -792,7 +794,8 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -834,9 +837,11 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
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
 
@@ -1178,7 +1183,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size +
+            ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6e5f908fb1..b966fa4f10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -44,7 +45,8 @@ enum {
 
 static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
                                           int dsmad_handle, uint64_t size,
-                                          bool is_pmem, uint64_t dpa_base)
+                                          bool is_pmem, bool is_dynamic,
+                                          uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -60,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
+                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
         .DPA_base = dpa_base,
         .DPA_length = size,
     };
@@ -148,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
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
 
@@ -175,21 +179,51 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
         pmr_size = memory_region_size(nonvolatile_mr);
     }
 
+    if (ct3d->dc.num_regions) {
+        if (ct3d->dc.host_dc) {
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
+            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+        } else {
+            return -EINVAL;
+        }
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
+        /* FIXME: Currently we assume the dynamic capacity to be volatile. */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
+                    dsmad_handle++,
+                    ct3d->dc.regions[i].len,
+                    false, true, region_base);
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -299,11 +333,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_hi = ct3d->hostpmem->size >> 32;
             range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
+        } else if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi = ct3d->hostpmem->size >> 32;
         range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+        if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi = ct3d->dc.host_dc->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+            (ct3d->dc.host_dc->size & 0xF0000000);
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -570,19 +617,32 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
-/*
- * TODO: dc region configuration will be updated once host backend and address
- * space support is added for DCD.
- */
 static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
 {
     int i;
+    MemoryRegion *dc_mr;
+    uint64_t dc_size = 0;
     uint64_t region_base = 0;
-    uint64_t region_len =  2 * GiB;
-    uint64_t decode_len = 2 * GiB;
+    uint64_t region_len;
+    uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
     CXLDCDRegion *region;
 
+    dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+    dc_size = memory_region_size(dc_mr);
+    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
+
+    if (region_len * ct3d->dc.num_regions > dc_size) {
+        error_setg(errp, "host backend size must be multiples of region len");
+        return false;
+    }
+    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region size is unaligned to %lx",
+                CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
+    decode_len = region_len;
+
     if (ct3d->hostvmem) {
         region_base += ct3d->hostvmem->size;
     }
@@ -599,6 +659,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         region->flags = 0;
 
         region_base += region->len;
+        ct3d->dc.total_capacity += region->len;
     }
 
     return true;
@@ -608,7 +669,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+            && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -672,9 +734,38 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
-    if (!cxl_create_dc_regions(ct3d, errp)) {
-        error_setg(errp, "setup DC regions failed");
-        return false;
+    ct3d->dc.total_capacity = 0;
+    if (ct3d->dc.num_regions) {
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
+        /* FIXME: set dc as volatile for now */
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
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_setg(errp, "setup DC regions failed");
+            return false;
+        }
     }
 
     return true;
@@ -766,6 +857,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -784,6 +878,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -862,16 +959,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
+        /* Do we want dc_size to be dc_mr->size or not?? */
+        dc_size = ct3d->dc.total_capacity;
     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
 
@@ -879,19 +984,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
@@ -973,6 +1077,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1039,33 +1145,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
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
+        dc_size = ct3d->dc.total_capacity;
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
index 80188db670..2f244da9a1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -467,6 +467,10 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
 
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
     } dc;
-- 
2.43.0

