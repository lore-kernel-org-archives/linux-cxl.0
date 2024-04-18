Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AA2AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483018; cv=none; b=nMXf119NjjyujmvaJzuEOpour+n1vjfSWpUmBPWyAHkI197kR99eBowpwvd7JzBmX6PjAXd6phjXZTXKRYL5j9AL9FWixdjt+w3YvNpzUPNucp83BXrFUybSVhOQ35ElVFGxbpl7UoaNtkVX+w4ckTzajbT/w33dOgBiT/LXogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483018; c=relaxed/simple;
	bh=pecmI63i8V+au0MCTYswh/QpGHcQy7+n+QqR0RNRWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMAlgMa6ktuUnZSmE8aSiEilidOP0lxzAWBfkopZP2lg9AzjCxeDPf9qBFSfSuJoxdisEJaqKc1hrvGxENrx/EqMkbtsW3JXGSTJ0Abjrqkro45pWKykr8iYG+9Vbs36o34/rw2+Sacx6Hy6mXuwvFXkxI88yNhbjMgqcQos624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dArkGlOr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dArkGlOr"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so1084110a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483016; x=1714087816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxule/gMtEI1MvLKkWxzoQAnJuD3vvD9B73sdceJ75M=;
        b=dArkGlOrcqlP8278zI0QebgKTiem5n+Fv3LERPbXhRRpwWXzbrf2/z5vdQloBu1U9+
         DsClie3Dr4GqnvVFyLb7McK1zkm7V9h3q/5bhlinWZbJGcfjE8AlokVtDym14za6KBy0
         X2UFlUM0fC/RqYf27vUGVvDQeHX363X8mlbuvh6rQrhzJwBWhvyeYExng117pen6XaPC
         LHpBlvIzWJIWnQtevAIdRIGBslq6TbZhMZqsgyZ1jDFSERyR4K/Cd/azXnC2IUy/vzPB
         oHc1yav3faj1Z5As219RdABGcccoS7KgX+s32/jF6YXAEWJZid64I1+MT2Me6Bxub9kE
         noRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483016; x=1714087816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxule/gMtEI1MvLKkWxzoQAnJuD3vvD9B73sdceJ75M=;
        b=tGBlRI8M8WFMyOi1jeUYKQyF38rMHf1vzjsK6SpZVkSNKDXDLYl1xyZDIX33WsiXFj
         Yd80fINe5PNgHVg1ModpxQmK88nV/g+t5MUslh8nNpwX0g9DtJSZ/CspkNHA/ZHKtai/
         Uvn4SKd9ylvcNdSOuuNhSz5yNZ4YBoGd7K1s982T5c2zdev0i2t5PRytMchk05OZsJlA
         zXKviXVONHRy46Z+HA4sQNw+G/4EmnRvfI212kugSQfm08TfgkMjXqO7i0glk9cwBYIw
         CjwPbZTaEYrQhUW6i217Rp54ATywmYJBIFD10u3cGGhxZWc+fR4pbMITw+fzFa4azuZ/
         auHA==
X-Forwarded-Encrypted: i=1; AJvYcCUjExes0fbUAtCDSkhBbNknrD8dOrsm4YisJoxgBZWIPJd0c9hkL9abySwDR3iDDu0fWJuNhNIOh+FpW1DG0rf9HOzpgmcWQaym
X-Gm-Message-State: AOJu0YwjjKgkCCbdXwcdWIj1a0mw6pi0ZYS7ApGwY7TlOsnD7JG+SmSL
	CvVHTuQA6EAfJ7Zim7YAfpaHySIYrmRLVFcPKCw3GnWG5lP7Hm/V
X-Google-Smtp-Source: AGHT+IF7E3nwkc/Hek34L4khNmjp08wBGYvYa33glyGNnfXexfP/auxHVMBZVWbeo67G8IElhdxNvg==
X-Received: by 2002:a05:6a20:3951:b0:1aa:a473:3ee0 with SMTP id r17-20020a056a20395100b001aaa4733ee0mr889618pzg.6.1713483015264;
        Thu, 18 Apr 2024 16:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:14 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
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
Subject: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address space handling for DC regions
Date: Thu, 18 Apr 2024 16:10:57 -0700
Message-ID: <20240418232902.583744-7-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
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

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  16 ++--
 hw/mem/cxl_type3.c          | 172 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   8 ++
 3 files changed, 160 insertions(+), 36 deletions(-)

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
index a1fe268560..ac87398089 100644
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
+         * TODO: we assume the dynamic capacity to be volatile for now.
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
@@ -301,10 +337,16 @@ static void build_dvsecs(CXLType3Dev *ct3d)
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
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -579,11 +621,27 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
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
+        error_setg(errp, "host backend size must be multiples of region len");
+        return false;
+    }
+    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region size is unaligned to %lx",
+                   CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
+    decode_len = region_len;
 
     if (ct3d->hostvmem) {
         mr = host_memory_backend_get_memory(ct3d->hostvmem);
@@ -606,6 +664,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
         };
+        ct3d->dc.total_capacity += region->len;
     }
 
     return true;
@@ -615,7 +674,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+        && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -679,7 +739,37 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
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
+         * TODO: set dc as volatile for now, non-volatile support can be added
+         * in the future if needed.
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
             error_setg(errp, "setup DC regions failed");
             return false;
@@ -776,6 +866,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -794,6 +887,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -872,16 +968,23 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
 
@@ -889,19 +992,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
@@ -983,6 +1085,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1049,33 +1153,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
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

