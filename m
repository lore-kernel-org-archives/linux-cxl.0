Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3B3589E
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdF2LZMn"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3F8F
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3216b2a1so48538845ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380621; x=1699985421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fidJGI9tSfEUK7LuKCCNr/HhdNthEOLs0OgUT171rXg=;
        b=bdF2LZMn9Fg1/iM2fRX631ezfjeklzum66uQl8cvJE+X419IKlQCTjllt0nLn0XLMN
         ykbp6aYiBR9p8NOXFJeoXGI20KjYpGOViMUjScToipMgabNM8t+1Hwd4CgSu0S3YHmot
         14UH0DNUhJFtJRPz1le9l4oa66fyZ57lYOfuQbM/2u/xAG1FikJtx4cQC+XzD1X7sup6
         9hVZ8G0S+10G+2O7By495zt4HuJGWUBmQ2pPo2asr+0y0Ff29m8gD6b+Bols9JnHDFuB
         gY9XA3PYP5JxwT71OYuxaMG0zTXOeXgVaWaNG3OlWfXAJDgV98UKZjvS4HQ4VWi9Xlea
         kOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380621; x=1699985421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fidJGI9tSfEUK7LuKCCNr/HhdNthEOLs0OgUT171rXg=;
        b=uKdJFTiqlxAMoN04l67DWJ47KrilptW6A0oj96SNu7BFP1IGemwOZTIyT6AxIjpQDW
         P9uLlFrbIjF4Ijrjzsc6qn0XeWgZAoK/Q3IzCxolTkXuj0YL25JFw7vtrFFQUl1WKNM9
         K/GirfPb55nR4thff0zDI6FKNqgJ7ZrY52WRCkbq8iVxmQYc6LfIiIa8eyjo8zQevj0U
         AQIYynECZ9ze2KUPAGN8+OBmMxkp/jQPpNlbjXRqrcBSj2C2QljdwQuSTO9W7q7g20hD
         mwpdQi9RTqzURz9AKgVHeA9YzUV6j6JrvV+b7GTJb7yJAOuy4+6v0wTobE7/PGP2Otee
         E5jA==
X-Gm-Message-State: AOJu0YxKeUgdUwiycSna9eOCjLEePrP2Au4MvklM+VpeeKRphJwtRZu5
	9hPjeCpKdo99tQasweGeD6Q=
X-Google-Smtp-Source: AGHT+IH2sOSQhzqP6upCTCtWBH3TOQDDXqGUL3eGXNC+4Wz3oTZeRcj6fBK6yv5oVwcRAzQmxyDd9g==
X-Received: by 2002:a17:903:11c3:b0:1cc:5549:aabd with SMTP id q3-20020a17090311c300b001cc5549aabdmr27205343plh.8.1699380621077;
        Tue, 07 Nov 2023 10:10:21 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:20 -0800 (PST)
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
Subject: [PATCH v3 5/9] hw/mem/cxl_type3: Add host backend and address space handling for DC regions
Date: Tue,  7 Nov 2023 10:07:09 -0800
Message-ID: <20231107180907.553451-6-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
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
1. Add a new property to type3 device "nonvolatile-dc-memdev" to point to host
   memory backend for dynamic capacity. Currently, all dc regions share one
   one host backend.
2. Add namespace for dynamic capacity for read/write support;
3. Create cdat entries for each dynamic capacity region;
4. Fix dvsec range registers to include DC regions.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++-
 hw/mem/cxl_type3.c          | 198 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 179 insertions(+), 39 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 707fd9fe7f..1f512b3e6b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -596,7 +596,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t *len_out,
                                                CXLCCI *cci)
 {
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -610,7 +611,8 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -764,7 +766,8 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -805,9 +808,11 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
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
 
@@ -1149,7 +1154,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size +
+            ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2d67d2015c..152a51306d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -31,6 +31,7 @@
 #include "hw/pci/spdm.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -44,8 +45,9 @@ enum {
 };
 
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr,
-                                         bool is_pmem, uint64_t dpa_base)
+                                         int dsmad_handle, uint64_t size,
+                                         bool is_pmem, bool is_dynamic,
+                                         uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -64,9 +66,10 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
+            (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -150,7 +153,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          */
         .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -169,21 +172,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    MemoryRegion *dc_mr = NULL;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
     int rc, i;
+    uint64_t vmr_size = 0, pmr_size = 0;
 
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
 
+    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
+        warn_report("The device has static ram and pmem and dynamic capacity");
+    }
+
     if (ct3d->hostvmem) {
         volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
         if (!volatile_mr) {
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = memory_region_size(volatile_mr);
     }
 
     if (ct3d->hostpmem) {
@@ -192,6 +202,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = memory_region_size(nonvolatile_mr);
+    }
+
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
     }
 
     table = g_malloc0(len * sizeof(*table));
@@ -201,8 +224,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     /* Now fill them in */
     if (volatile_mr) {
-        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           false, 0);
+        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vmr_size,
+                                           false, false, 0);
         if (rc < 0) {
             return rc;
         }
@@ -210,14 +233,38 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     if (nonvolatile_mr) {
-        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
         rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true, base);
+                                           pmr_size, true, false, vmr_size);
         if (rc < 0) {
             goto error_cleanup;
         }
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        uint64_t region_base = vmr_size + pmr_size;
+
+        /*
+         * Currently we create cdat entries for each region, should we only
+         * create dsmas table instead??
+         * We assume all dc regions are non-volatile for now.
+         *
+         */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
+                                               dsmad_handle++,
+                                               ct3d->dc.regions[i].len,
+                                               true, true, region_base);
+            if (rc < 0) {
+                goto error_cleanup;
+            }
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -445,11 +492,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
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
@@ -721,6 +781,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+/*
+ * TODO: region parameters are hard coded, may need to change in the future.
+ */
 static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 {
     int i;
@@ -736,6 +799,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     if (ct3d->hostpmem) {
         region_base += ct3d->hostpmem->size;
     }
+
     for (i = 0; i < ct3d->dc.num_regions; i++) {
         region = &ct3d->dc.regions[i];
         region->base = region_base;
@@ -755,7 +819,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+            && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -823,6 +888,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return false;
     }
 
+    ct3d->dc.total_capacity = 0;
+    if (ct3d->dc.host_dc) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+        uint64_t total_region_size = 0;
+        int i;
+
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have backing device");
+            return false;
+        }
+        /* FIXME: set dc as nonvolatile for now */
+        memory_region_set_nonvolatile(dc_mr, true);
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
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            total_region_size += ct3d->dc.regions[i].len;
+        }
+        /* Make sure the host backend is large enough to cover all dc range */
+        if (total_region_size > memory_region_size(dc_mr)) {
+            error_setg(errp,
+                "too small host backend size, increase to %lu MiB or more",
+                total_region_size / MiB);
+            return false;
+        }
+
+        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
+            error_setg(errp, "DC region size is unaligned to %lx",
+                    CXL_CAPACITY_MULTIPLIER);
+            return false;
+        }
+
+        ct3d->dc.total_capacity = total_region_size;
+    }
+
     return true;
 }
 
@@ -933,6 +1042,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -952,6 +1064,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -1025,16 +1140,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
 
@@ -1042,19 +1165,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
@@ -1143,6 +1265,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1209,33 +1333,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
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
index de6469eef7..3dc6928bc5 100644
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
2.42.0

