Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656CC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJLSWb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJLSWL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:22:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA1FFFAB
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:40 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z30so11001534qkz.13
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwYRwJUmb/ECwSOs8mOpcTqevLQDineADYqXRuc0klU=;
        b=RhNDsoH0/3AmCc0nN1MsZMs353OL2dxTcLWgkajs7Y+F7ND0WwDkXgvxCw+xb1/IdW
         PnDiO0tOBro8/VDNoNOeqoCCkqCSLaG7oxPIPpZVVt/WBy2GMRLfjnF7B9bzb2PPzLxs
         UD/uxS8FLD4ECzzgo62yrTHv4EozkWZznhzrrTy3R2CbDHiaAAnX3jywcWesXyPv8+kl
         969x1PtgWeqKdczaEDZI8PoeHZbc/K48SPtX4kM2OQVF7f32gM3BAPNZVOustZU3CPvq
         VqRTap6Fe5HWAm/91HvpgqNdTZn43uG2uHuokztxfFwkeAUt6FK1Rp4z3LyjvFr7qdLy
         NOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwYRwJUmb/ECwSOs8mOpcTqevLQDineADYqXRuc0klU=;
        b=EjenVCnKn/dYYZSQYFYOmGYH7MMyh0hSkd73/ey+MYxcUw8lTBDDuJptG9MD5sQ1PL
         uDCxhtSh3/Z3mr20tijemBMVNCePvEgY6gYvGCMljeJXn1hzjivRrje461HZq6u5M8g3
         mw+QjuoYIJ0u8kj0Vh1rwbk4q+7KlU5NHL9WdJXAfqA9YYVTqTpWnMVdmZbXtIaR6i3l
         Kz5ywfOEN++uVnIhi1szCeoGbPtbH+VNyqmbzakKzQQLMdOFVpNNKh5jPMKOqiVK9sM7
         zACS1rcAV4y+Wli+FATCes4UKVSQcP65IghasVz3xE3acrBOWIiqpAqtpVFC3fQc/tJQ
         Q4Tw==
X-Gm-Message-State: ACrzQf0mPZ3UV8eI745HN9HWMVvXWn12eRGXzapIHbDfwzcMIzxotKW3
        LaJfdu1+D9aUBs55NXhjJg==
X-Google-Smtp-Source: AMsMyM7lYSTJ9D9LN2djFtz0k3yhYzKbW6MSVPKNTKwxtp9ZebLEkF8G6/Oo1vmWDAvi6mkdvKyzKw==
X-Received: by 2002:a05:620a:4081:b0:6ee:80ab:25b6 with SMTP id f1-20020a05620a408100b006ee80ab25b6mr6675429qko.517.1665598899339;
        Wed, 12 Oct 2022 11:21:39 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:39 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 5/5] hw/mem/cxl_type3: Refactor CDAT sub-table entry initialization into a function
Date:   Wed, 12 Oct 2022 14:21:20 -0400
Message-Id: <20221012182120.174142-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CDAT can contain multiple entries for multiple memory regions, this
will allow us to re-use the initialization code when volatile memory
region support is added.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 137 ++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 65 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 220b9f09a9..3c5485abd0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -19,117 +19,93 @@
 #define DWORD_BYTE 4
 #define CT3_CDAT_SUBTABLE_SIZE 6
 
-static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
-                                void *priv)
+static int ct3_build_cdat_subtable(CDATSubHeader **cdat_table,
+        MemoryRegion *mr, int dsmad_handle)
 {
-    g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile1 = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile2 = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile3 = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile4 = NULL;
-    g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
-    CXLType3Dev *ct3d = priv;
-    int next_dsmad_handle = 0;
-    int nonvolatile_dsmad = -1;
-    MemoryRegion *mr;
-
-    if (!ct3d->hostmem) {
-        return 0;
-    }
-
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
-        return -EINVAL;
-    }
-
-    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));
-    if (!*cdat_table) {
-        return -ENOMEM;
-    }
-
-    /* Non volatile aspects */
-    dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
-    dslbis_nonvolatile1 = g_malloc(sizeof(*dslbis_nonvolatile1));
-    dslbis_nonvolatile2 = g_malloc(sizeof(*dslbis_nonvolatile2));
-    dslbis_nonvolatile3 = g_malloc(sizeof(*dslbis_nonvolatile3));
-    dslbis_nonvolatile4 = g_malloc(sizeof(*dslbis_nonvolatile4));
-    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
-
-    if (!dsmas_nonvolatile || !dsemts_nonvolatile ||
-        !dslbis_nonvolatile1 || !dslbis_nonvolatile2 ||
-        !dslbis_nonvolatile3 || !dslbis_nonvolatile4) {
-        g_free(*cdat_table);
-        *cdat_table = NULL;
+    g_autofree CDATDsmas *dsmas = NULL;
+    g_autofree CDATDslbis *dslbis1 = NULL;
+    g_autofree CDATDslbis *dslbis2 = NULL;
+    g_autofree CDATDslbis *dslbis3 = NULL;
+    g_autofree CDATDslbis *dslbis4 = NULL;
+    g_autofree CDATDsemts *dsemts = NULL;
+
+    dsmas = g_malloc(sizeof(*dsmas));
+    dslbis1 = g_malloc(sizeof(*dslbis1));
+    dslbis2 = g_malloc(sizeof(*dslbis2));
+    dslbis3 = g_malloc(sizeof(*dslbis3));
+    dslbis4 = g_malloc(sizeof(*dslbis4));
+    dsemts = g_malloc(sizeof(*dsemts));
+
+    if (!dsmas || !dslbis1 || !dslbis2 || !dslbis3 || !dslbis4 || !dsemts) {
         return -ENOMEM;
     }
 
-    nonvolatile_dsmad = next_dsmad_handle++;
-    *dsmas_nonvolatile = (CDATDsmas) {
+    *dsmas = (CDATDsmas) {
         .header = {
             .type = CDAT_TYPE_DSMAS,
-            .length = sizeof(*dsmas_nonvolatile),
+            .length = sizeof(*dsmas),
         },
-        .DSMADhandle = nonvolatile_dsmad,
+        .DSMADhandle = dsmad_handle,
         .flags = CDAT_DSMAS_FLAG_NV,
         .DPA_base = 0,
         .DPA_length = int128_get64(mr->size),
     };
 
     /* For now, no memory side cache, plausiblish numbers */
-    *dslbis_nonvolatile1 = (CDATDslbis) {
+    *dslbis1 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile1),
+            .length = sizeof(*dslbis1),
         },
-        .handle = nonvolatile_dsmad,
+        .handle = dsmad_handle,
         .flags = HMAT_LB_MEM_MEMORY,
         .data_type = HMAT_LB_DATA_READ_LATENCY,
         .entry_base_unit = 10000, /* 10ns base */
         .entry[0] = 15, /* 150ns */
     };
 
-    *dslbis_nonvolatile2 = (CDATDslbis) {
+    *dslbis2 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile2),
+            .length = sizeof(*dslbis2),
         },
-        .handle = nonvolatile_dsmad,
+        .handle = dsmad_handle,
         .flags = HMAT_LB_MEM_MEMORY,
         .data_type = HMAT_LB_DATA_WRITE_LATENCY,
         .entry_base_unit = 10000,
         .entry[0] = 25, /* 250ns */
     };
 
-    *dslbis_nonvolatile3 = (CDATDslbis) {
+    *dslbis3 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile3),
+            .length = sizeof(*dslbis3),
         },
-        .handle = nonvolatile_dsmad,
+        .handle = dsmad_handle,
         .flags = HMAT_LB_MEM_MEMORY,
         .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
         .entry_base_unit = 1000, /* GB/s */
         .entry[0] = 16,
     };
 
-    *dslbis_nonvolatile4 = (CDATDslbis) {
+    *dslbis4 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile4),
+            .length = sizeof(*dslbis4),
         },
-        .handle = nonvolatile_dsmad,
+        .handle = dsmad_handle,
         .flags = HMAT_LB_MEM_MEMORY,
         .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
         .entry_base_unit = 1000, /* GB/s */
         .entry[0] = 16,
     };
 
-    *dsemts_nonvolatile = (CDATDsemts) {
+    *dsemts = (CDATDsemts) {
         .header = {
             .type = CDAT_TYPE_DSEMTS,
-            .length = sizeof(*dsemts_nonvolatile),
+            .length = sizeof(*dsemts),
         },
-        .DSMAS_handle = nonvolatile_dsmad,
+        .DSMAS_handle = dsmad_handle,
         /* Reserved - the non volatile from DSMAS matters */
         .EFI_memory_type_attr = 2,
         .DPA_offset = 0,
@@ -137,16 +113,47 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     };
 
     /* Header always at start of structure */
-    (*cdat_table)[0] = g_steal_pointer(&dsmas_nonvolatile);
-    (*cdat_table)[1] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile1);
-    (*cdat_table)[2] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile2);
-    (*cdat_table)[3] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile3);
-    (*cdat_table)[4] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile4);
-    (*cdat_table)[5] = g_steal_pointer(&dsemts_nonvolatile);
+    cdat_table[0] = g_steal_pointer(&dsmas);
+    cdat_table[1] = (CDATSubHeader *)g_steal_pointer(&dslbis1);
+    cdat_table[2] = (CDATSubHeader *)g_steal_pointer(&dslbis2);
+    cdat_table[3] = (CDATSubHeader *)g_steal_pointer(&dslbis3);
+    cdat_table[4] = (CDATSubHeader *)g_steal_pointer(&dslbis4);
+    cdat_table[5] = g_steal_pointer(&dsemts);
 
     return CT3_CDAT_SUBTABLE_SIZE;
 }
 
+static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
+                                void *priv)
+{
+    CXLType3Dev *ct3d = priv;
+    MemoryRegion *mr;
+    int ret = 0;
+
+    if (!ct3d->hostmem) {
+        return 0;
+    }
+
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    if (!mr) {
+        return -EINVAL;
+    }
+
+    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));
+    if (!*cdat_table) {
+        return -ENOMEM;
+    }
+
+    /* Non volatile aspects */
+    ret = ct3_build_cdat_subtable(*cdat_table, mr, 0);
+    if (ret < 0) {
+        g_free(*cdat_table);
+        *cdat_table = NULL;
+    }
+
+    return ret;
+}
+
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
 {
     int i;
-- 
2.37.3

