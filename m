Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338DC43219
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLSW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJLSWH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:22:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C9102DC4
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a5so5981735qkl.6
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IktacSVymJ4XPCZWnpI70Qh+XpMKAyrOqOuaVfZ+z7M=;
        b=HUtZZy4YLvJmCpi4B9LSnmhnuAcZIx3YxOg8+glBpEoRFKMbdTEAzLPoADuTODqkxs
         d8MHJq7yZnOnh89QqA8rKcYYlhbm8HgFIXAPPQ8b5AYGPjBpY6tlrumHM1WuTq5KDitv
         nGV0oFEt3aH4Dn2Pg3rXZLHn2VdvuewYalojXdAq3e5ZOL0s2F1y6w/2rWNY77Shpb69
         c+yOXfSAGFrlYegQ0Jek5Ru1X62FY65RPlY8qoJ2tkd+W5DZbRZiyjnUp3ehQhJbCtNf
         etpHuSmY1UkhhdBvP2N6oUJV4n5xMCf4r3VidBGvDTZvHWO7iBEzVc3fxqE60CU24jFG
         KDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IktacSVymJ4XPCZWnpI70Qh+XpMKAyrOqOuaVfZ+z7M=;
        b=hg08+/y1JkTWSSaTSF7H5pO46m+kmy3ixayVcJIe6maly14AqXMOm4Eyvx3eXgXLGJ
         ickPIyZRQoLQvUlXl96GyzbZx9EmC726s15hnZ67OLjLmz6KviRqV+2+bwXFCqWFm210
         Zuz903j3DKOAOHFQjc+IFoEWzzqV1sRQyB1JPrTyE8QG7R/3j6MX5NJyMe41Fvgwm43n
         Dj4GcIuebmAPTW05j1rUFTrN+jRzpFNht6cRQIvZwyB+kxH4ENB82nI1DvT/bHn7z5ka
         uczm7xg8Y144QtZVqj7wP5hRBb4DKVi91gI0yYBOfiXAbLrCHj6s1D0NAtvaTbuydgz8
         1HuA==
X-Gm-Message-State: ACrzQf0/u5owHepp+XJcLkwu8hpkgQ/vMxNzJLtGIELVrBbCy08f9OUF
        ZqCPj+oQ78hnV/h/6/aQaQ==
X-Google-Smtp-Source: AMsMyM7A4eoyN5KwTtSExyVRSKfjjEUI0Mvu7mnNU+2q9jNGEXRo6WDFrbnysRtbs7Al87blAXeluQ==
X-Received: by 2002:a05:620a:4694:b0:6ee:b286:281a with SMTP id bq20-20020a05620a469400b006eeb286281amr311258qkb.455.1665598895491;
        Wed, 12 Oct 2022 11:21:35 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:35 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 2/5] hw/mem/cxl_type3: Pull validation checks ahead of functional code
Date:   Wed, 12 Oct 2022 14:21:17 -0400
Message-Id: <20221012182120.174142-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For style - pulling these validations ahead flattens the code.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 193 ++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 97 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 94bc439d89..43b2b9e041 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -32,107 +32,106 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     int dslbis_nonvolatile_num = 4;
     MemoryRegion *mr;
 
+    if (!ct3d->hostmem) {
+        return len;
+    }
+
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    if (!mr) {
+        return -EINVAL;
+    }
+
     /* Non volatile aspects */
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
-        dslbis_nonvolatile =
-            g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
-        if (!dslbis_nonvolatile) {
-            return -ENOMEM;
-        }
+    dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
+    if (!dsmas_nonvolatile) {
+        return -ENOMEM;
+    }
+    nonvolatile_dsmad = next_dsmad_handle++;
+    *dsmas_nonvolatile = (CDATDsmas) {
+        .header = {
+            .type = CDAT_TYPE_DSMAS,
+            .length = sizeof(*dsmas_nonvolatile),
+        },
+        .DSMADhandle = nonvolatile_dsmad,
+        .flags = CDAT_DSMAS_FLAG_NV,
+        .DPA_base = 0,
+        .DPA_length = int128_get64(mr->size),
+    };
+    len++;
 
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
-            /* Reserved - the non volatile from DSMAS matters */
-            .EFI_memory_type_attr = 2,
-            .DPA_offset = 0,
-            .DPA_length = int128_get64(mr->size),
-        };
-        len++;
+    /* For now, no memory side cache, plausiblish numbers */
+    dslbis_nonvolatile =
+        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
+    if (!dslbis_nonvolatile) {
+        return -ENOMEM;
     }
 
+    dslbis_nonvolatile[0] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis_nonvolatile),
+        },
+        .handle = nonvolatile_dsmad,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_READ_LATENCY,
+        .entry_base_unit = 10000, /* 10ns base */
+        .entry[0] = 15, /* 150ns */
+    };
+    len++;
+
+    dslbis_nonvolatile[1] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis_nonvolatile),
+        },
+        .handle = nonvolatile_dsmad,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_WRITE_LATENCY,
+        .entry_base_unit = 10000,
+        .entry[0] = 25, /* 250ns */
+    };
+    len++;
+
+    dslbis_nonvolatile[2] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis_nonvolatile),
+        },
+        .handle = nonvolatile_dsmad,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
+        .entry_base_unit = 1000, /* GB/s */
+        .entry[0] = 16,
+    };
+    len++;
+
+    dslbis_nonvolatile[3] = (CDATDslbis) {
+        .header = {
+            .type = CDAT_TYPE_DSLBIS,
+            .length = sizeof(*dslbis_nonvolatile),
+        },
+        .handle = nonvolatile_dsmad,
+        .flags = HMAT_LB_MEM_MEMORY,
+        .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
+        .entry_base_unit = 1000, /* GB/s */
+        .entry[0] = 16,
+    };
+    len++;
+
+    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
+    *dsemts_nonvolatile = (CDATDsemts) {
+        .header = {
+            .type = CDAT_TYPE_DSEMTS,
+            .length = sizeof(*dsemts_nonvolatile),
+        },
+        .DSMAS_handle = nonvolatile_dsmad,
+        /* Reserved - the non volatile from DSMAS matters */
+        .EFI_memory_type_attr = 2,
+        .DPA_offset = 0,
+        .DPA_length = int128_get64(mr->size),
+    };
+    len++;
+
     *cdat_table = g_malloc0(len * sizeof(*cdat_table));
     /* Header always at start of structure */
     if (dsmas_nonvolatile) {
-- 
2.37.3

