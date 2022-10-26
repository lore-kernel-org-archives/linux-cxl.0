Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B979C38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 00:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJZAtf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJZAte (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 20:49:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589A2663
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:49:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a24so8891392qto.10
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eCdkblp9N10CpvwBlCvOOWSX9hk0WPXXWNuoMHXung=;
        b=W+dtK43wYZKfPY1up96M7gKPiJYFd8iwcrFUuMybsCXNlHKyg/SUGOUZlXi5vB7JyI
         pXAWEvjiHlHIC4t8JxXZdncwYoHheg0ZIj0UOMpkHEAWrPAY+GXMwGTsfuH7gScKmDvH
         o0o+hzrtUTp3zm9VP+o1Pzqs94ljVpZSmb8Q2cKWBiB50nOpVID6Vs0/DbwJMOaUb6HT
         kDgn1VRH/b1foa7SG9dSmRjpiUNzTzHVSLVyYUVb6oFo/WaSRIcBYIfViPr9LsHZ1Tur
         RnyFA9wNVwBDAUZA6sNPyiFHMUGK2vx7dA6yvlg1uiYEiQ5ve/XI9L3BflXTxapr4bRV
         lmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eCdkblp9N10CpvwBlCvOOWSX9hk0WPXXWNuoMHXung=;
        b=PkOTMrtwzl+iE4bTBM2n0OdI4v22a/K2nsWrza7dedNXgJcBzgFScdQc/zMn1gIHEa
         6m3hqjtNGVtZXMjK01o1+bWHWbBBCPsq/g2kSSfc0rI2++tXJYrWaB6vXTBYenIogpQY
         gC/ZjuBcq9JHgrHxB1D9Su999ViDzrHe/yu500co5BUp0L6N1hCZTZDGEAS+hx/qiFsm
         eS3NvnnDOJBOA8x6vA/U41jcLdekfJTZOBldm+BuehH4qX5nmA/EwOzIKChNT9efgaKt
         Akm5517zqMWmx2M1UKuS07tf6CFTDWTVyHZZrtBDezgXR/e2GKqan1MZxYtAkMxFl9qt
         /d2Q==
X-Gm-Message-State: ACrzQf0+8737AMDb1oX8Qyw4z2AMIzP3XPKlKtYeCHRJ5d/G8dWkpLre
        pFUM6AkRqaE3z07BhiC5qg==
X-Google-Smtp-Source: AMsMyM4KdvUGjoK1qeOBgzRxPNIzo2UXmA4fZ6uat3Ig2AevStpprICpMTj37vtwKCuwZNDk5PT3Qw==
X-Received: by 2002:ac8:7f54:0:b0:39c:bb57:a1aa with SMTP id g20-20020ac87f54000000b0039cbb57a1aamr34896534qtk.382.1666745366008;
        Tue, 25 Oct 2022 17:49:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id j15-20020ac8550f000000b0039a610a04b1sm2408651qtq.37.2022.10.25.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:49:19 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        ani@anisinha.ca, alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [PATCH 3/4] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
Date:   Tue, 25 Oct 2022 20:47:36 -0400
Message-Id: <20221026004737.3646-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026004737.3646-1-gregory.price@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
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
 docs/system/devices/cxl.rst |  53 +++++--
 hw/cxl/cxl-mailbox-utils.c  |  21 ++-
 hw/mem/cxl_type3.c          | 274 +++++++++++++++++++++++++++---------
 include/hw/cxl/cxl_device.h |  11 +-
 tests/qtest/cxl-test.c      | 111 +++++++++++----
 5 files changed, 348 insertions(+), 122 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index f25783a4ec..9e165064c8 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -300,15 +300,36 @@ Example topology involving a switch::
 
 Example command lines
 ---------------------
-A very simple setup with just one directly attached CXL Type 3 device::
+A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
 
   qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
   ...
-  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
-  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -object memory-backend-file,pmem=true,id=pmem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
+  -object memory-backend-file,pmem=true,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=pmem0,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+The same volatile setup may optionally include an LSA region::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
@@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
-  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
+  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
   -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
-  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
+  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
   -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
-  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
+  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
 
 An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
@@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
+  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
+  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
+  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
+  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Deprecations
+------------
+
+The Type 3 device [memdev] attribute has been deprecated in favor
+of the [persistent-memdev] and [volatile-memdev] attributes. [memdev]
+will default to a persistent memory device for backward compatibility
+and is incapable of being used in combination with [persistent-memdev].
+
 Kernel Configuration Options
 ----------------------------
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d7543fd5b4..c1183614b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -269,7 +269,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
+    if (cxl_dstate->mem_size < CXL_CAPACITY_MULTIPLIER) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -412,20 +412,20 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
 
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
 
@@ -444,16 +444,15 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
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
index 0317bd96a6..21e866dcaf 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -32,7 +32,8 @@ enum {
 };
 
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr)
+                                         int dsmad_handle, MemoryRegion *mr,
+                                         bool is_pmem, uint64_t dpa_base)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -51,8 +52,8 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = CDAT_DSMAS_FLAG_NV,
-        .DPA_base = 0,
+        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .DPA_base = dpa_base,
         .DPA_length = int128_get64(mr->size),
     };
 
@@ -151,33 +152,67 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 {
     g_autofree CDATSubHeader **table = NULL;
-    MemoryRegion *nonvolatile_mr;
     CXLType3Dev *ct3d = priv;
+    MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
     int dsmad_handle = 0;
+    int cur_ent = 0;
+    int len = 0;
     int rc;
 
-    if (!ct3d->hostmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem) {
         return 0;
     }
 
-    nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!nonvolatile_mr) {
-        return -EINVAL;
+    if (ct3d->hostvmem) {
+        volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!volatile_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES;
+    }
+
+    if (ct3d->hostpmem) {
+        nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!nonvolatile_mr) {
+            return -EINVAL;
+        }
+        len += CT3_CDAT_NUM_ENTRIES;
     }
 
-    table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
+    table = g_malloc0(len * sizeof(*table));
     if (!table) {
         return -ENOMEM;
     }
 
-    rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, nonvolatile_mr);
-    if (rc < 0) {
-        return rc;
+    /* Now fill them in */
+    if (volatile_mr) {
+        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
+                true, 0);
+        if (rc < 0) {
+            return rc;
+        }
+        cur_ent = CT3_CDAT_NUM_ENTRIES;
+    }
+
+    if (nonvolatile_mr) {
+        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
+                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size : 0));
+        if (rc < 0) {
+            goto error_cleanup;
+        }
+        cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+    assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
 
-    return CT3_CDAT_NUM_ENTRIES;
+    return len;
+error_cleanup:
+    int i;
+    for (i = 0; i < cur_ent; i++) {
+        g_free(*cdat_table[i]);
+    }
+    return rc;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
@@ -378,16 +413,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
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
+        HostMemoryBackend *hmbe = ct3d->hostvmem ?
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
@@ -475,33 +542,62 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
     MemoryRegion *mr;
     char *name;
 
-    if (!ct3d->hostmem) {
-        error_setg(errp, "memdev property must be set");
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+        error_setg(errp, "at least one memdev property must be set");
         return false;
+    } else if (ct3d->hostmem && ct3d->hostpmem) {
+        error_setg(errp, "[memdev] cannot be used with new "
+                         "[persistent-memdev] property");
+        return false;
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
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!mr) {
+            error_setg(errp, "volatile memdev must have backing device");
+            return false;
+        }
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
-
-    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
 
-    if (!ct3d->lsa) {
-        error_setg(errp, "lsa property must be set");
-        return false;
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!mr) {
+            error_setg(errp, "persistent memdev must have backing device");
+            return false;
+        }
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
 
     return true;
@@ -609,7 +705,12 @@ err_free_spdm_socket:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
-    address_space_destroy(&ct3d->hostmem_as);
+    if (ct3d->hostvmem) {
+        address_space_destroy(&ct3d->hostvmem_as);
+    }
+    if (ct3d->hostpmem) {
+        address_space_destroy(&ct3d->hostpmem_as);
+    }
     return;
 }
 
@@ -623,7 +724,12 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
-    address_space_destroy(&ct3d->hostmem_as);
+    if (ct3d->hostvmem) {
+        address_space_destroy(&ct3d->hostvmem_as);
+    }
+    if (ct3d->hostpmem) {
+        address_space_destroy(&ct3d->hostpmem_as);
+    }
 }
 
 /* TODO: Support multiple HDM decoders and DPA skip */
@@ -663,11 +769,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset;
-    MemoryRegion *mr;
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace *as;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
 
-    /* TODO support volatile region */
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    if (!vmr && !pmr) {
         return MEMTX_ERROR;
     }
 
@@ -675,11 +787,13 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
         return MEMTX_ERROR;
     }
 
-    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
+    as = (vmr && (dpa_offset <= int128_get64(vmr->size))) ?
+         &ct3d->hostvmem_as : &ct3d->hostpmem_as;
+    return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
@@ -687,10 +801,17 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset;
-    MemoryRegion *mr;
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace *as;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
 
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    if (!vmr && !pmr) {
         return MEMTX_OK;
     }
 
@@ -698,11 +819,13 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
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
+         &ct3d->hostvmem_as : &ct3d->hostpmem_as;
+    return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
 static void ct3d_reset(DeviceState *dev)
@@ -717,7 +840,11 @@ static void ct3d_reset(DeviceState *dev)
 
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
@@ -728,10 +855,12 @@ static Property ct3_props[] = {
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
 {
-    MemoryRegion *mr;
-
-    mr = host_memory_backend_get_memory(ct3d->lsa);
-    return memory_region_size(mr);
+    MemoryRegion *mr = NULL;
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        return memory_region_size(mr);
+    }
+    return 0;
 }
 
 static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
@@ -744,30 +873,35 @@ static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
 static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
                     uint64_t offset)
 {
-    MemoryRegion *mr;
+    MemoryRegion *mr = NULL;
     void *lsa;
 
-    mr = host_memory_backend_get_memory(ct3d->lsa);
-    validate_lsa_access(mr, size, offset);
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        validate_lsa_access(mr, size, offset);
 
-    lsa = memory_region_get_ram_ptr(mr) + offset;
-    memcpy(buf, lsa, size);
+        lsa = memory_region_get_ram_ptr(mr) + offset;
+        memcpy(buf, lsa, size);
+        return size;
+    }
 
-    return size;
+    return 0;
 }
 
 static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset)
 {
-    MemoryRegion *mr;
-    void *lsa;
+    MemoryRegion *mr = NULL;
+    void *lsa = NULL;
 
-    mr = host_memory_backend_get_memory(ct3d->lsa);
-    validate_lsa_access(mr, size, offset);
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        validate_lsa_access(mr, size, offset);
 
-    lsa = memory_region_get_ram_ptr(mr) + offset;
-    memcpy(lsa, buf, size);
-    memory_region_set_dirty(mr, offset, size);
+        lsa = memory_region_get_ram_ptr(mr) + offset;
+        memcpy(lsa, buf, size);
+        memory_region_set_dirty(mr, offset, size);
+    }
 
     /*
      * Just like the PMEM, if the guest is not allowed to exit gracefully, label
@@ -978,7 +1112,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     pc->config_read = ct3d_config_read;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->desc = "CXL PMEM Device (Type 3)";
+    dc->desc = "CXL Memory Device (Type 3)";
     dc->reset = ct3d_reset;
     device_class_set_props(dc, ct3_props);
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1cd71afcb6..1b366b739c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -180,8 +180,10 @@ typedef struct cxl_device_state {
         uint64_t host_set;
     } timestamp;
 
-    /* memory region for persistent memory, HDM */
+    /* memory region size, HDM */
+    uint64_t mem_size;
     uint64_t pmem_size;
+    uint64_t vmem_size;
 
     struct cxl_cmd (*cxl_cmd_set)[256];
     /* Move me later */
@@ -311,12 +313,15 @@ struct CXLType3Dev {
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
 
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 6baed747fa..a05ddc0c7b 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -34,29 +34,46 @@
                  "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
                  "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
 
-#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
-
-#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
-
-#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
-                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
-                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+#define QEMU_T3D_DEPRECATED \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+
+#define QEMU_T3D_PMEM \
+  "-object memory-backend-file,id=m0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-m0,lsa=lsa0,id=pmem0 "
+
+#define QEMU_T3D_VMEM \
+  "-object memory-backend-ram,id=mem0,size=256M " \
+  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=mem0 "
+
+#define QEMU_T3D_VMEM_LSA \
+  "-object memory-backend-ram,id=mem0,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,lsa=lsa0,id=mem0 "
+
+#define QEMU_2T3D \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
+  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 "
+
+#define QEMU_4T3D \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
+  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 " \
+  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
+  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp2,persistent-memdev=cxl-mem2,lsa=lsa2,id=pmem2 " \
+  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
+  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
 static void cxl_basic_hb(void)
 {
@@ -95,14 +112,53 @@ static void cxl_2root_port(void)
 }
 
 #ifdef CONFIG_POSIX
-static void cxl_t3d(void)
+static void cxl_t3d_deprecated(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
     g_autofree const char *tmpfs = NULL;
 
     tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
 
-    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs, tmpfs);
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_DEPRECATED,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_persistent(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_PMEM,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile_lsa(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM_LSA,
+                    tmpfs);
 
     qtest_start(cmdline->str);
     qtest_end();
@@ -167,7 +223,10 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/rp", cxl_root_port);
         qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
 #ifdef CONFIG_POSIX
-        qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
+        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
+        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
+        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
         qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
         qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
                        cxl_2pxb_4rp_4t3d);
-- 
2.37.3

