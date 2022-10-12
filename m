Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68688C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJLSWZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJLSWG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:22:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9602102504
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id jr1so2696703qtb.0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/OIjGnZ8Z2MlKUjHTeqka/I/IZvDfiB0NY+oyfcc4s=;
        b=jKIGYrw9yB2dtHKLpXQrIULA63v2EbPdg4/UeDYYJM4iD3Gveqcqjp23FRmJWV2kqg
         t2GCMtaj8F6cbrdKMyYV7Ppszlob1SJw0HPbZ5IzfaGW0KnV5teIc5lH8BsrXNrRlEwq
         qAaJAvULCZAdI0alRR08sii1LGbUv6z6yEHbgiGQPhJ3XjTSNjC021EJW/AKbR1Q0kTh
         tH1c/OiDND6rGM8cqwEq7uyIX/vZZygIGFDLLcjwZS9mNFrvw17Zt36kUxvb55sz+rHK
         rGqOwZt5zbCVdjlvao3LpCQZ6NNO1n3ECYK1x7fWzoEOpqiiE0K2vVqEq+DdbDioO4g5
         fxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/OIjGnZ8Z2MlKUjHTeqka/I/IZvDfiB0NY+oyfcc4s=;
        b=fpjnqIHPTP0JvJf9OfR4y3RI2prdDbpaMmBswZI3Umcfs4/qDf0sCpdMpvRaB0wIiH
         0x9zkPEta+guYbggYUsbluAAkEP9SzvuN28vtpABj5bgoZyOt1GwFepDTn73lvoEIPhz
         /4lfYQpzC6CzA3ah4Znc0FDSfR15I2wNfMgCW9hlg3FCdwgdOOJL2ZOWjOr4S+xL+d4T
         lmvlKc3dDrnvFU54QNWnSQ7huXtCIOZVqoGVZNT7PHcVYvx5Lg/4FPswnydgHJlm8zp3
         d+jo/6Xr2KqVRsEVethjaT4b1hwCgSGSoAygZ9kVyDQx7bbt9brWjESLXv7mw8i9iWJl
         Feag==
X-Gm-Message-State: ACrzQf2YySZSM3PnFAOvD9rEYJkrp171hfoEvcLrPEk26dpSh7itlKu1
        ++VE7FRCppVxovBr0rHU+w==
X-Google-Smtp-Source: AMsMyM70tX7LUk3Ti1w2k4JsuhkpWUrgqefoViSwtPtKQUHP1tZJA7Us4c8XwVj7uBL0qfIauHtgEg==
X-Received: by 2002:a05:622a:1754:b0:39c:c5ab:9bdf with SMTP id l20-20020a05622a175400b0039cc5ab9bdfmr2549651qtk.618.1665598896712;
        Wed, 12 Oct 2022 11:21:36 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:36 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 3/5] hw/mem/cxl_type3: CDAT pre-allocate and check resources prior to work
Date:   Wed, 12 Oct 2022 14:21:18 -0400
Message-Id: <20221012182120.174142-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Makes the size of the allocated cdat table static (6 entries),
flattens the code, and reduces the number of exit conditions

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 52 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 43b2b9e041..0e0ea70387 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,6 +17,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CT3_CDAT_SUBTABLE_SIZE 6
 
 static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
                                 void *priv)
@@ -25,7 +26,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
     g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
     CXLType3Dev *ct3d = priv;
-    int len = 0;
     int i = 0;
     int next_dsmad_handle = 0;
     int nonvolatile_dsmad = -1;
@@ -33,7 +33,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     MemoryRegion *mr;
 
     if (!ct3d->hostmem) {
-        return len;
+        return 0;
     }
 
     mr = host_memory_backend_get_memory(ct3d->hostmem);
@@ -41,11 +41,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         return -EINVAL;
     }
 
+    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));
+    if (!*cdat_table) {
+        return -ENOMEM;
+    }
+
     /* Non volatile aspects */
     dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
-    if (!dsmas_nonvolatile) {
+    dslbis_nonvolatile =
+        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
+    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
+    if (!dsmas_nonvolatile || !dslbis_nonvolatile || !dsemts_nonvolatile) {
+        g_free(*cdat_table);
+        *cdat_table = NULL;
         return -ENOMEM;
     }
+
     nonvolatile_dsmad = next_dsmad_handle++;
     *dsmas_nonvolatile = (CDATDsmas) {
         .header = {
@@ -57,15 +68,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .DPA_base = 0,
         .DPA_length = int128_get64(mr->size),
     };
-    len++;
 
     /* For now, no memory side cache, plausiblish numbers */
-    dslbis_nonvolatile =
-        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
-    if (!dslbis_nonvolatile) {
-        return -ENOMEM;
-    }
-
     dslbis_nonvolatile[0] = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
@@ -77,7 +81,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry_base_unit = 10000, /* 10ns base */
         .entry[0] = 15, /* 150ns */
     };
-    len++;
 
     dslbis_nonvolatile[1] = (CDATDslbis) {
         .header = {
@@ -90,7 +93,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry_base_unit = 10000,
         .entry[0] = 25, /* 250ns */
     };
-    len++;
 
     dslbis_nonvolatile[2] = (CDATDslbis) {
         .header = {
@@ -103,7 +105,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry_base_unit = 1000, /* GB/s */
         .entry[0] = 16,
     };
-    len++;
 
     dslbis_nonvolatile[3] = (CDATDslbis) {
         .header = {
@@ -116,9 +117,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry_base_unit = 1000, /* GB/s */
         .entry[0] = 16,
     };
-    len++;
 
-    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
     *dsemts_nonvolatile = (CDATDsemts) {
         .header = {
             .type = CDAT_TYPE_DSEMTS,
@@ -130,26 +129,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .DPA_offset = 0,
         .DPA_length = int128_get64(mr->size),
     };
-    len++;
 
-    *cdat_table = g_malloc0(len * sizeof(*cdat_table));
     /* Header always at start of structure */
-    if (dsmas_nonvolatile) {
-        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
-    }
-    if (dslbis_nonvolatile) {
-        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
-        int j;
+    (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
 
-        for (j = 0; j < dslbis_nonvolatile_num; j++) {
-            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
-        }
-    }
-    if (dsemts_nonvolatile) {
-        (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
+    CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
+    int j;
+    for (j = 0; j < dslbis_nonvolatile_num; j++) {
+        (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
     }
 
-    return len;
+    (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
+
+    return CT3_CDAT_SUBTABLE_SIZE;
 }
 
 static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
-- 
2.37.3

