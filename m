Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78383C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKVUc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKVUb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:20:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA94F3AB
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o22so8964320qkl.8
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEsY8vod6zC9rVPrYYS0T9zyb/vlYbm5XlYZdRBYkDo=;
        b=h0iddW6AEYNxaJP5LAfQrgN08/tnQWYtABmOjtfpnF/jimzdVYK/kKQl4M8HsGt7U8
         TOLw164ivuxr7ComAtxciN9B6+om1pJ+ZghvxngYfgDPcQlyhyBALc7GwNKeYZgSAIOM
         7ZFN5QuJSDB3XTAebZC5NMZXrWhf5qF6qUcng+MylSEet8/Q7eLv5SxVIg8FWmv55DV8
         UDr0zo0wK5jPeWpMyDLqS5Bv5n0rv40VFW+nw7Ga5uaybog8nSWVcVYzDDvgERzw+WLJ
         OF6SqNdkBWuxjjej8Pe0HSXEcM2d+Y9Uuk0WBid8+UHlgrOascuf2uaCXuc/au7mRBEt
         NE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEsY8vod6zC9rVPrYYS0T9zyb/vlYbm5XlYZdRBYkDo=;
        b=gdzYHHW5uDmggi+iDKV6dFjlxHwEqPXSTqA4eaCfNrdDT24rXmSIrpzLL9yRAVM/RR
         DXWwULzxgf9EoGcqdJ+J0TyU98+249Ki7ZSWXrg/f444hvuksGLYonwluONfN9eyjvA4
         CYkv5s7mx3pkAaPf6vhnHiq9hs5pxe5iFKElg8uTOeE8MGP8ZEPKdx2XAumFNqFLmy1m
         ffTxXzOIzK3bJMFWEd85/spsWi1cjHcEJDOAY1zn/W6fj0FqTpTMW2EFpcYbzWD97OZT
         OPLHfVmMl5KGokledLz8kR8R9LNgdwPmCsPde+Vz7j6UCM80aw/gIToW0TSVIybzAezT
         dn4g==
X-Gm-Message-State: ACrzQf1eGWA6Ujqhv2bB0xoNLvaXFsEyPuu2MSK1x/1XD8A0+EcJlWI2
        g14LAAPiBTutbGIIQsZrRQ==
X-Google-Smtp-Source: AMsMyM4GJTv0qKRb4+WrRd4T4Ry+IBGN2HKAGGqClGeeFPX1ffh50YZBkJC7ACLFRb3/qQUABmtFkw==
X-Received: by 2002:a05:620a:e:b0:6ee:86e5:66f8 with SMTP id j14-20020a05620a000e00b006ee86e566f8mr2895888qki.163.1665523229084;
        Tue, 11 Oct 2022 14:20:29 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:20:28 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 3/5] hw/mem/cxl_type: Generalize CDATDsmas initialization for Memory Regions
Date:   Tue, 11 Oct 2022 17:19:14 -0400
Message-Id: <20221011211916.117552-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This is a preparatory commit for enabling multiple memory regions within
a single CXL Type-3 device.  We will need to initialize multiple CDAT
DSMAS regions (and subsequent DSLBIS, and DSEMTS entries), so generalize
the intialization into a function.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 275 +++++++++++++++++++++++++--------------------
 1 file changed, 154 insertions(+), 121 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 282f274266..dda78704c2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -24,145 +24,178 @@
 #define UI64_NULL ~(0ULL)
 #define DWORD_BYTE 4
 
+static int ct3_build_dsmas(CDATDsmas *dsmas,
+                           CDATDslbis *dslbis,
+                           CDATDsemts *dsemts,
+                           MemoryRegion *mr,
+                           int dsmad_handle,
+                           bool is_pmem,
+                           uint64_t dpa_base)
+{
+    int len = 0;
+    /* ttl_len should be incremented for every entry */
+
+    /* Device Scoped Memory Affinity Structure */
+    *dsmas = (CDATDsmas) {
+        .header = {
+            .type = CDAT_TYPE_DSMAS,
+            .length = sizeof(*dsmas),
+        },
+        .DSMADhandle = dsmad_handle,
+        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0),
+        .DPA_base = dpa_base,
+        .DPA_length = int128_get64(mr->size),
+    };
+    len++;
+
+    /* For now, no memory side cache, plausiblish numbers */
+    dslbis[0] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis),
+        },
+        .handle = dsmad_handle,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_READ_LATENCY,
+        .entry_base_unit = 10000, /* 10ns base */
+        .entry[0] = 15, /* 150ns */
+    };
+    len++;
+
+    dslbis[1] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis),
+        },
+        .handle = dsmad_handle,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_WRITE_LATENCY,
+        .entry_base_unit = 10000,
+        .entry[0] = 25, /* 250ns */
+    };
+    len++;
+
+    dslbis[2] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis),
+            },
+        .handle = dsmad_handle,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
+        .entry_base_unit = 1000, /* GB/s */
+        .entry[0] = 16,
+    };
+    len++;
+
+    dslbis[3] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis),
+        },
+        .handle = dsmad_handle,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
+        .entry_base_unit = 1000, /* GB/s */
+        .entry[0] = 16,
+    };
+    len++;
+
+    *dsemts = (CDATDsemts) {
+        .header = {
+            .type = CDAT_TYPE_DSEMTS,
+            .length = sizeof(*dsemts),
+        },
+        .DSMAS_handle = dsmad_handle,
+        /* EFI_MEMORY_NV implies EfiReservedMemoryType */
+        .EFI_memory_type_attr = is_pmem ? 2 : 0,
+        /* Reserved - the non volatile from DSMAS matters */
+        .DPA_offset = 0,
+        .DPA_length = int128_get64(mr->size),
+    };
+    len++;
+    return len;
+}
+
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
                                 void *priv)
 {
-    g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
-    g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
+    g_autofree CDATDsmas *dsmas = NULL;
+    g_autofree CDATDslbis *dslbis = NULL;
+    g_autofree CDATDsemts *dsemts = NULL;
     CXLType3Dev *ct3d = priv;
-    int len = 0;
-    int i = 0;
-    int next_dsmad_handle = 0;
-    int nonvolatile_dsmad = -1;
-    int dslbis_nonvolatile_num = 4;
+    int cdat_len = 0;
+    int cdat_idx = 0, sub_idx = 0;
+    int dsmas_num, dslbis_num, dsemts_num;
+    int dsmad_handle = 0;
+    uint64_t dpa_base = 0;
     MemoryRegion *mr;
 
-    /* Non volatile aspects */
-    if (ct3d->hostmem) {
-        dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
-        if (!dsmas_nonvolatile) {
-            return -ENOMEM;
-        }
-        nonvolatile_dsmad = next_dsmad_handle++;
-        mr = host_memory_backend_get_memory(ct3d->hostmem);
-        if (!mr) {
-            return -EINVAL;
-        }
-        *dsmas_nonvolatile = (CDATDsmas) {
-            .header = {
-                .type = CDAT_TYPE_DSMAS,
-                .length = sizeof(*dsmas_nonvolatile),
-            },
-            .DSMADhandle = nonvolatile_dsmad,
-            .flags = CDAT_DSMAS_FLAG_NV,
-            .DPA_base = 0,
-            .DPA_length = int128_get64(mr->size),
-        };
-        len++;
-
-        /* For now, no memory side cache, plausiblish numbers */
-        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
-        if (!dslbis_nonvolatile)
-            return -ENOMEM;
-
-        dslbis_nonvolatile[0] = (CDATDslbis) {
-            .header = {
-                .type = CDAT_TYPE_DSLBIS,
-                .length = sizeof(*dslbis_nonvolatile),
-            },
-            .handle = nonvolatile_dsmad,
-            .flags = HMAT_LB_MEM_MEMORY,
-            .data_type = HMAT_LB_DATA_READ_LATENCY,
-            .entry_base_unit = 10000, /* 10ns base */
-            .entry[0] = 15, /* 150ns */
-        };
-        len++;
-
-        dslbis_nonvolatile[1] = (CDATDslbis) {
-            .header = {
-                .type = CDAT_TYPE_DSLBIS,
-                .length = sizeof(*dslbis_nonvolatile),
-            },
-            .handle = nonvolatile_dsmad,
-            .flags = HMAT_LB_MEM_MEMORY,
-            .data_type = HMAT_LB_DATA_WRITE_LATENCY,
-            .entry_base_unit = 10000,
-            .entry[0] = 25, /* 250ns */
-        };
-        len++;
-       
-        dslbis_nonvolatile[2] = (CDATDslbis) {
-            .header = {
-                .type = CDAT_TYPE_DSLBIS,
-                .length = sizeof(*dslbis_nonvolatile),
-            },
-            .handle = nonvolatile_dsmad,
-            .flags = HMAT_LB_MEM_MEMORY,
-            .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
-            .entry_base_unit = 1000, /* GB/s */
-            .entry[0] = 16,
-        };
-        len++;
-
-        dslbis_nonvolatile[3] = (CDATDslbis) {
-            .header = {
-                .type = CDAT_TYPE_DSLBIS,
-                .length = sizeof(*dslbis_nonvolatile),
-            },
-            .handle = nonvolatile_dsmad,
-            .flags = HMAT_LB_MEM_MEMORY,
-            .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
-            .entry_base_unit = 1000, /* GB/s */
-            .entry[0] = 16,
-        };
-        len++;
-
-        mr = host_memory_backend_get_memory(ct3d->hostmem);
-        if (!mr) {
-            return -EINVAL;
-        }
-        dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
-        *dsemts_nonvolatile = (CDATDsemts) {
-            .header = {
-                .type = CDAT_TYPE_DSEMTS,
-                .length = sizeof(*dsemts_nonvolatile),
-            },
-            .DSMAS_handle = nonvolatile_dsmad,
-            .EFI_memory_type_attr = 2, /* Reserved - the non volatile from DSMAS matters */
-            .DPA_offset = 0,
-            .DPA_length = int128_get64(mr->size),
-        };
-        len++;
+    if (!ct3d->hostmem | !host_memory_backend_get_memory(ct3d->hostmem)) {
+        return -EINVAL;
+    }
+
+    dsmas_num = 1;
+    dslbis_num = 4 * dsmas_num;
+    dsemts_num = dsmas_num;
+
+    dsmas = g_malloc(sizeof(*dsmas) * dsmas_num);
+    dslbis = g_malloc(sizeof(*dslbis) * dslbis_num);
+    dsemts = g_malloc(sizeof(*dsemts) * dsemts_num);
+
+    if (!dsmas || !dslbis || !dsemts) {
+        return -ENOMEM;
+    }
+
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    cdat_len += ct3_build_dsmas(&dsmas[dsmad_handle],
+                                &dslbis[4 * dsmad_handle],
+                                &dsemts[dsmad_handle],
+                                mr,
+                                dsmad_handle,
+                                false,
+                                dpa_base);
+    dpa_base += mr->size;
+    dsmad_handle++;
+
+    /* Allocate and fill in the CDAT table */
+    *cdat_table = g_malloc0(cdat_len * sizeof(*cdat_table));
+    if (!*cdat_table) {
+        return -ENOMEM;
     }
 
-    *cdat_table = g_malloc0(len * sizeof(*cdat_table));
     /* Header always at start of structure */
-    if (dsmas_nonvolatile) {
-        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
+    CDATDsmas *dsmas_ent = g_steal_pointer(&dsmas);
+    for (sub_idx = 0; sub_idx < dsmas_num; sub_idx++) {
+        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dsmas_ent[sub_idx];
     }
-    if (dslbis_nonvolatile) {
-        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);        
-        int j;
 
-        for (j = 0; j < dslbis_nonvolatile_num; j++) {
-            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
-        }
+    CDATDslbis *dslbis_ent = g_steal_pointer(&dslbis);
+    for (sub_idx = 0; sub_idx < dslbis_num; sub_idx++) {
+        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dslbis_ent[sub_idx];
     }
-    if (dsemts_nonvolatile) {
-        (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
+
+    CDATDsemts *dsemts_ent = g_steal_pointer(&dsemts);
+    for (sub_idx = 0; sub_idx < dsemts_num; sub_idx++) {
+        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dsemts_ent[sub_idx];
     }
-    
-    return len;
+
+    return cdat_len;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
 {
-    int i;
+    int dsmas_num = 1;
+    int dslbis_idx = dsmas_num;
+    int dsemts_idx = dsmas_num + (dsmas_num * 4);
+
+    /* There are only 3 sub-tables to free: dsmas, dslbis, dsemts */
+    assert(num == (dsmas_num + (dsmas_num * 4) + (dsmas_num)));
+
+    g_free(cdat_table[0]);
+    g_free(cdat_table[dslbis_idx]);
+    g_free(cdat_table[dsemts_idx]);
 
-    for (i = 0; i < num; i++) {
-        g_free(cdat_table[i]);
-    }
     g_free(cdat_table);
 }
 
-- 
2.37.3

