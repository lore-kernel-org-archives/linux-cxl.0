Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D1C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJLSW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJLSWH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:22:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD743136A
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m6so5910926qkm.4
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNKsnJI2O2Dvzfe8afK4oFdeHHBtIjx3W5QyApq77ec=;
        b=dFpKglfKpZgSGu7YqXw/Ag0jwAUHtRW93owL6zO7NjuoojiXdvfmN+7+YWQSnul9zq
         VtMYjXjyRfKJPMiY3TywWuzR13g8Zt88PtWMN19b7fsEEfY1d+oh6IDPqJJrKmC/F858
         3Uib2CFKQRpACJEaXYj1Cmz008jFHxc5nWWg9frcFbSR0ymIneKR1VfuyDKCNwITu2Br
         VK6ahx3TM/PvuJ7+ToNIE6qWEj2BvyEgUn49eEQXuHykKaQRwcdcVUK2YdfBuF4+eCGE
         R7M14gdAjWAMFHSpftqqRZRVtOBMRQ7lLBJq03fQkNuZbRFRkKAOOTv7JsLaX3TNsOIl
         Lk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNKsnJI2O2Dvzfe8afK4oFdeHHBtIjx3W5QyApq77ec=;
        b=pxB6D7quzDikA0j29DNn5arC7tpMCEZxHjUefY8drFTvvtxVURZXFSXrTahTeG+GGG
         17htv/DjKEpU2IP/TTP6sofcKLjj41ZBW/N7yxBXghKiRQhEwovO5viRIB2rFe+FpSyQ
         Ocs5wRYaJsysVBGWwoAO3S8vWVDPu0XzhOjt8qZoK31yCrqIFP64WpIf8JTk0T7Trotg
         51UlN3B9mbRrJi9izsO5rFWR7YCnJOYlIN3X0I0AEasDzNbuy9fa2qAz0kYUBxWBhx7W
         OXljI07tX3/sGcxsEoV0i8vATNi/6KxlpqZmtOZSUguM5md5kDV23Sc8A5rwYG2jJfZB
         G14A==
X-Gm-Message-State: ACrzQf3WDKAN1d94dAuT8fAnPOs0ugI35m2YDQMgzAJf+3Tfyt0xmQM0
        sSzafZPMU2hgEkPnW6hzaw==
X-Google-Smtp-Source: AMsMyM7+lhEQBxC97aEvdrQqrRerFiBAjiYwBTHqxEF4uz6F3dwF2OA0MtzQne8RDkUnC1TVG9SOsA==
X-Received: by 2002:a05:620a:1e5:b0:6ed:1061:5c6b with SMTP id x5-20020a05620a01e500b006ed10615c6bmr11550573qkn.34.1665598897918;
        Wed, 12 Oct 2022 11:21:37 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:37 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 4/5] hw/mem/cxl_type3: Change the CDAT allocation/free strategy
Date:   Wed, 12 Oct 2022 14:21:19 -0400
Message-Id: <20221012182120.174142-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The existing code allocates a subtable for SLBIS entries, uses a
local variable to avoid a g_autofree footgun, and the cleanup code
causes heap corruption.

Rather than allocate a table, explicitly allocate each individual entry
and make the sub-table size static.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 49 ++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0e0ea70387..220b9f09a9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -23,13 +23,14 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
                                 void *priv)
 {
     g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
-    g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
+    g_autofree CDATDslbis *dslbis_nonvolatile1 = NULL;
+    g_autofree CDATDslbis *dslbis_nonvolatile2 = NULL;
+    g_autofree CDATDslbis *dslbis_nonvolatile3 = NULL;
+    g_autofree CDATDslbis *dslbis_nonvolatile4 = NULL;
     g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
     CXLType3Dev *ct3d = priv;
-    int i = 0;
     int next_dsmad_handle = 0;
     int nonvolatile_dsmad = -1;
-    int dslbis_nonvolatile_num = 4;
     MemoryRegion *mr;
 
     if (!ct3d->hostmem) {
@@ -48,10 +49,15 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
 
     /* Non volatile aspects */
     dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
-    dslbis_nonvolatile =
-        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
+    dslbis_nonvolatile1 = g_malloc(sizeof(*dslbis_nonvolatile1));
+    dslbis_nonvolatile2 = g_malloc(sizeof(*dslbis_nonvolatile2));
+    dslbis_nonvolatile3 = g_malloc(sizeof(*dslbis_nonvolatile3));
+    dslbis_nonvolatile4 = g_malloc(sizeof(*dslbis_nonvolatile4));
     dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
-    if (!dsmas_nonvolatile || !dslbis_nonvolatile || !dsemts_nonvolatile) {
+
+    if (!dsmas_nonvolatile || !dsemts_nonvolatile ||
+        !dslbis_nonvolatile1 || !dslbis_nonvolatile2 ||
+        !dslbis_nonvolatile3 || !dslbis_nonvolatile4) {
         g_free(*cdat_table);
         *cdat_table = NULL;
         return -ENOMEM;
@@ -70,10 +76,10 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
-    dslbis_nonvolatile[0] = (CDATDslbis) {
+    *dslbis_nonvolatile1 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile),
+            .length = sizeof(*dslbis_nonvolatile1),
         },
         .handle = nonvolatile_dsmad,
         .flags = HMAT_LB_MEM_MEMORY,
@@ -82,10 +88,10 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry[0] = 15, /* 150ns */
     };
 
-    dslbis_nonvolatile[1] = (CDATDslbis) {
+    *dslbis_nonvolatile2 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile),
+            .length = sizeof(*dslbis_nonvolatile2),
         },
         .handle = nonvolatile_dsmad,
         .flags = HMAT_LB_MEM_MEMORY,
@@ -94,10 +100,10 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry[0] = 25, /* 250ns */
     };
 
-    dslbis_nonvolatile[2] = (CDATDslbis) {
+    *dslbis_nonvolatile3 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile),
+            .length = sizeof(*dslbis_nonvolatile3),
         },
         .handle = nonvolatile_dsmad,
         .flags = HMAT_LB_MEM_MEMORY,
@@ -106,10 +112,10 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         .entry[0] = 16,
     };
 
-    dslbis_nonvolatile[3] = (CDATDslbis) {
+    *dslbis_nonvolatile4 = (CDATDslbis) {
         .header = {
             .type = CDAT_TYPE_DSLBIS,
-            .length = sizeof(*dslbis_nonvolatile),
+            .length = sizeof(*dslbis_nonvolatile4),
         },
         .handle = nonvolatile_dsmad,
         .flags = HMAT_LB_MEM_MEMORY,
@@ -131,15 +137,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     };
 
     /* Header always at start of structure */
-    (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
-
-    CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
-    int j;
-    for (j = 0; j < dslbis_nonvolatile_num; j++) {
-        (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
-    }
-
-    (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
+    (*cdat_table)[0] = g_steal_pointer(&dsmas_nonvolatile);
+    (*cdat_table)[1] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile1);
+    (*cdat_table)[2] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile2);
+    (*cdat_table)[3] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile3);
+    (*cdat_table)[4] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile4);
+    (*cdat_table)[5] = g_steal_pointer(&dsemts_nonvolatile);
 
     return CT3_CDAT_SUBTABLE_SIZE;
 }
-- 
2.37.3

