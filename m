Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C373C43217
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKVUe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKVUd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:20:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2398558CB
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o22so8964367qkl.8
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLt8Ha8SRNDCr78HCvP6MyBvZdCHkmHdkfxlYMSesP4=;
        b=QJHcL19tRcMTItrnje33Kg+UOabwQRfpUhgDgSu9BIf1LRMk3QhzCcQdHVtrFcbgS4
         Rc12CARydhAGqGjc8t/HcDX+1MVXIujYURAxYWYuHktg8+TkUD096z+XHlTpv9Uthu9z
         D9iOpO6P00qbI20v/QCt/rb6Qd7pzcNXjN9VF/PlK+Ucw+aIRpRNn1VZ69WcfDO8k/YI
         kiNp30mvQgKrZXILnuyPPczERm4fX9Br9AAg0j91iAXIe7uBl0MsIFGPbAlFlLDygQ9h
         16nptakKWKiQDf3Za0m2U22nLKs3JJN7jKO+lOnk+e24V+Q7WK4fAiKnXgLP//1dFVTp
         Hcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLt8Ha8SRNDCr78HCvP6MyBvZdCHkmHdkfxlYMSesP4=;
        b=YZXs7H4p7DSxz/sVbHJzXM+monTs9V+NBy+PtwHVnIWwAOIJ3xA9BDB9BHfDKBbbrf
         7VmhEXdQBOIxivf/TbsF6OGlpzDbBhOmmsAD9DFUWkxprBWnevO4z46UXhJtozenn2OT
         tTJ2DkcghG1hkwl4eGcq9j/jloM4rdT0m1MzncRSww1YZfIKnLIn9xHGNPMNwD8ZBm7K
         PHnrtwkXPA40jyxW/VjfDtS6/FPlPhbbOkn2Ocq9ZHKsp77afQTsBMobpX+AzqCB4v5Z
         drUAYQY6RJ6XIHzhfLcGiOHRa5w+QhoygxcCGXphhtMouinGUP3UR9uJyNDBHIDr2FFS
         G8Zw==
X-Gm-Message-State: ACrzQf1NoY7AeVCGquHuF0VNdq9+Mu6R6H2PAuQQlV+5a0y0fFuIxq7M
        aQRxIYfKOICwTjProqMFow==
X-Google-Smtp-Source: AMsMyM7p+vzWevLZOg9St6xTSc/0Bd8qtN9jd8pNav9dhFGL82jmi5CNgnb4UY4CaEgdGL9CVEiwpg==
X-Received: by 2002:a05:620a:318b:b0:6ce:d5d3:f914 with SMTP id bi11-20020a05620a318b00b006ced5d3f914mr17760582qkb.248.1665523230872;
        Tue, 11 Oct 2022 14:20:30 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:20:30 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 4/5] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
Date:   Tue, 11 Oct 2022 17:19:15 -0400
Message-Id: <20221011211916.117552-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This commit enables each CXL Type-3 device to contain one volatile
memory region and one persistent region.

Two new properties have been added to cxl-type3 device initialization:
    [volatile-memdev] and [persistent-memdev]

The existing [memdev] property has been deprecated and will default the
memory region to a persistent memory region (although a user may assign
the region to a ram or file backed region). It cannot be used in
combination with the new [persistent-memdev] property.

Partitioning volatile memory from persistent memory is not yet supported.

Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  21 ++--
 hw/mem/cxl_type3.c          | 197 ++++++++++++++++++++++++++----------
 include/hw/cxl/cxl_device.h |  11 +-
 3 files changed, 162 insertions(+), 67 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 776c8cbadc..88d33e9a37 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -142,7 +142,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
+    if (cxl_dstate->mem_size < CXL_CAPACITY_MULTIPLIER) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -285,20 +285,20 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
 
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
-    uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
     id = (void *)cmd->payload;
     memset(id, 0, sizeof(*id));
 
-    /* PMEM only */
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
-    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
+    id->total_capacity = cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER;
+    id->persistent_capacity = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
+    id->volatile_capacity = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
     id->lsa_size = cvc->get_lsa_size(ct3d);
     id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
 
@@ -317,16 +317,15 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)cmd->payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
-    uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    /* PMEM only */
-    part_info->active_vmem = 0;
+    part_info->active_vmem = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
     part_info->next_vmem = 0;
-    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
+    part_info->active_pmem = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
     part_info->next_pmem = 0;
 
     *len = sizeof(*part_info);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index dda78704c2..c371cd06e1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -131,11 +131,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     uint64_t dpa_base = 0;
     MemoryRegion *mr;
 
-    if (!ct3d->hostmem | !host_memory_backend_get_memory(ct3d->hostmem)) {
+    if ((!ct3d->hostvmem && !ct3d->hostpmem) ||
+        (ct3d->hostvmem && !host_memory_backend_get_memory(ct3d->hostvmem)) ||
+        (ct3d->hostpmem && !host_memory_backend_get_memory(ct3d->hostpmem))) {
         return -EINVAL;
     }
 
-    dsmas_num = 1;
+    dsmas_num = (ct3d->hostvmem ? 1 : 0) + (ct3d->hostpmem ? 1 : 0);
     dslbis_num = 4 * dsmas_num;
     dsemts_num = dsmas_num;
 
@@ -147,16 +149,30 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         return -ENOMEM;
     }
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    cdat_len += ct3_build_dsmas(&dsmas[dsmad_handle],
-                                &dslbis[4 * dsmad_handle],
-                                &dsemts[dsmad_handle],
-                                mr,
-                                dsmad_handle,
-                                false,
-                                dpa_base);
-    dpa_base += mr->size;
-    dsmad_handle++;
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        cdat_len += ct3_build_dsmas(&dsmas[dsmad_handle],
+                        &dslbis[4 * dsmad_handle],
+                        &dsemts[dsmad_handle],
+                        mr,
+                        dsmad_handle,
+                        false,
+                        dpa_base);
+        dpa_base += mr->size;
+        dsmad_handle++;
+    }
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        cdat_len += ct3_build_dsmas(&dsmas[dsmad_handle],
+                        &dslbis[4 * dsmad_handle],
+                        &dsemts[dsmad_handle],
+                        mr,
+                        dsmad_handle,
+                        false,
+                        dpa_base);
+        dpa_base += mr->size;
+        dsmad_handle++;
+    }
 
     /* Allocate and fill in the CDAT table */
     *cdat_table = g_malloc0(cdat_len * sizeof(*cdat_table));
@@ -185,7 +201,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
 {
-    int dsmas_num = 1;
+    CXLType3Dev *ct3d = priv;
+    int dsmas_num = (ct3d->hostvmem ? 1 : 0) + (ct3d->hostpmem ? 1 : 0);
     int dslbis_idx = dsmas_num;
     int dsemts_idx = dsmas_num + (dsmas_num * 4);
 
@@ -386,16 +403,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
+    uint32_t range1_size_hi = 0, range1_size_lo = 0,
+             range1_base_hi = 0, range1_base_lo = 0,
+             range2_size_hi = 0, range2_size_lo = 0,
+             range2_base_hi = 0, range2_base_lo = 0;
+
+    /*
+     * Volatile memory is mapped as (0x0)
+     * Persistent memory is mapped at (volatile->size)
+     */
+    if (ct3d->hostvmem && ct3d->hostpmem) {
+        range1_size_hi = ct3d->hostvmem->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (ct3d->hostvmem->size & 0xF0000000);
+        range1_base_hi = 0;
+        range1_base_lo = 0;
+        range2_size_hi = ct3d->hostpmem->size >> 32;
+        range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (ct3d->hostpmem->size & 0xF0000000);
+        range2_base_hi = ct3d->hostvmem->size >> 32;
+        range2_base_lo = ct3d->hostvmem->size & 0xF0000000;
+    } else {
+        HostMemoryBackend* hmbe = ct3d->hostvmem ?
+                                  ct3d->hostvmem : ct3d->hostpmem;
+        range1_size_hi = hmbe->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                         (hmbe->size & 0xF0000000);
+        range1_base_hi = 0;
+        range1_base_lo = 0;
+    }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
         .cap = 0x1e,
         .ctrl = 0x2,
         .status2 = 0x2,
-        .range1_size_hi = ct3d->hostmem->size >> 32,
-        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
-        (ct3d->hostmem->size & 0xF0000000),
-        .range1_base_hi = 0,
-        .range1_base_lo = 0,
+        .range1_size_hi = range1_size_hi,
+        .range1_size_lo = range1_size_lo,
+        .range1_base_hi = range1_base_hi,
+        .range1_base_lo = range1_base_lo,
+        .range2_size_hi = range2_size_hi,
+        .range2_size_lo = range2_size_lo,
+        .range2_base_hi = range2_base_hi,
+        .range2_base_lo = range2_base_lo
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                PCIE_CXL_DEVICE_DVSEC_LENGTH,
@@ -483,35 +532,57 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
     MemoryRegion *mr;
     char *name;
 
-    if (!ct3d->hostmem) {
-        error_setg(errp, "memdev property must be set");
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+        error_setg(errp, "at least one memdev property must be set");
+        return false;
+    } else if (ct3d->hostmem && ct3d->hostpmem) {
+        error_setg(errp, "[memdev] cannot be used with new "
+                         "[persistent-memdev] property");
         return false;
+    } else if (ct3d->hostmem) {
+        /* Use of hostmem property implies pmem */
+        ct3d->hostpmem = ct3d->hostmem;
+        ct3d->hostmem = NULL;
     }
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
-        error_setg(errp, "memdev property must be set");
+    if (ct3d->hostpmem && !ct3d->lsa) {
+        error_setg(errp, "lsa property must be set for persistent devices");
         return false;
     }
-    memory_region_set_nonvolatile(mr, true);
-    memory_region_set_enabled(mr, true);
-    host_memory_backend_set_mapped(ct3d->hostmem, true);
 
-    if (ds->id) {
-        name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
-    } else {
-        name = g_strdup("cxl-type3-dpa-space");
+    if (ct3d->hostvmem)
+    {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        memory_region_set_nonvolatile(mr, false);
+        memory_region_set_enabled(mr, true);
+        host_memory_backend_set_mapped(ct3d->hostvmem, true);
+        if (ds->id) {
+            name = g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->id);
+        } else {
+            name = g_strdup("cxl-type3-dpa-vmem-space");
+        }
+        address_space_init(&ct3d->hostvmem_as, mr, name);
+        ct3d->cxl_dstate.vmem_size = mr->size;
+        ct3d->cxl_dstate.mem_size += mr->size;
+        g_free(name);
     }
-    address_space_init(&ct3d->hostmem_as, mr, name);
-    g_free(name);
 
-    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
-
-    if (!ct3d->lsa) {
-        error_setg(errp, "lsa property must be set");
-        return false;
+    if (ct3d->hostpmem)
+    {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        memory_region_set_nonvolatile(mr, true);
+        memory_region_set_enabled(mr, true);
+        host_memory_backend_set_mapped(ct3d->hostpmem, true);
+        if (ds->id) {
+            name = g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->id);
+        } else {
+            name = g_strdup("cxl-type3-dpa-pmem-space");
+        }
+        address_space_init(&ct3d->hostpmem_as, mr, name);
+        ct3d->cxl_dstate.pmem_size = mr->size;
+        ct3d->cxl_dstate.mem_size += mr->size;
+        g_free(name);
     }
-
     return true;
 }
 
@@ -627,7 +698,10 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
-    address_space_destroy(&ct3d->hostmem_as);
+    if (ct3d->hostvmem)
+        address_space_destroy(&ct3d->hostvmem_as);
+    if (ct3d->hostpmem)
+        address_space_destroy(&ct3d->hostpmem_as);
 }
 
 /* TODO: Support multiple HDM decoders and DPA skip */
@@ -667,11 +741,15 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset;
-    MemoryRegion *mr;
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace* as;
 
-    /* TODO support volatile region */
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    if (ct3d->hostvmem)
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    if (ct3d->hostpmem)
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+
+    if (!vmr && !pmr) {
         return MEMTX_ERROR;
     }
 
@@ -679,11 +757,13 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
         return MEMTX_ERROR;
     }
 
-    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
+    as = (vmr && (dpa_offset <= int128_get64(vmr->size))) ?
+        &ct3d->hostvmem_as : &ct3d->hostpmem_as;
+    return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
@@ -691,10 +771,15 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset;
-    MemoryRegion *mr;
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace* as;
+
+    if (ct3d->hostvmem)
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    if (ct3d->hostpmem)
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    if (!vmr && !pmr) {
         return MEMTX_OK;
     }
 
@@ -702,11 +787,13 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_OK;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
         return MEMTX_OK;
     }
-    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
-                               &data, size);
+
+    as = (vmr && (dpa_offset <= int128_get64(vmr->size))) ?
+        &ct3d->hostvmem_as : &ct3d->hostpmem_as;
+    return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
 static void ct3d_reset(DeviceState *dev)
@@ -721,7 +808,11 @@ static void ct3d_reset(DeviceState *dev)
 
 static Property ct3_props[] = {
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
-                     HostMemoryBackend *),
+                     HostMemoryBackend *), /* for backward compatibility */
+    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
@@ -804,7 +895,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     pc->config_read = ct3d_config_read;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->desc = "CXL PMEM Device (Type 3)";
+    dc->desc = "CXL Memory Device (Type 3)";
     dc->reset = ct3d_reset;
     device_class_set_props(dc, ct3_props);
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0f4e29345f..458853b373 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -141,8 +141,10 @@ typedef struct cxl_device_state {
         uint64_t host_set;
     } timestamp;
 
-    /* memory region for persistent memory, HDM */
+    /* memory region size, HDM */
+    uint64_t mem_size;
     uint64_t pmem_size;
+    uint64_t vmem_size;
 
     /* Move me later */
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
@@ -270,12 +272,15 @@ struct CXLType3Dev {
     PCIDevice parent_obj;
 
     /* Properties */
-    HostMemoryBackend *hostmem;
+    HostMemoryBackend *hostmem; /* deprecated */
+    HostMemoryBackend *hostvmem;
+    HostMemoryBackend *hostpmem;
     HostMemoryBackend *lsa;
     uint64_t sn;
 
     /* State */
-    AddressSpace hostmem_as;
+    AddressSpace hostvmem_as;
+    AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
 
-- 
2.37.3

