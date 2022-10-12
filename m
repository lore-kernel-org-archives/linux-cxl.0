Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29B0C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJLSWY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJLSWH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 14:22:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F9FF27F
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a5so5981699qkl.6
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1SK3FmyWNNpw6G4y43Kwb7gIJPzDAfBnVuIve7TjDc=;
        b=YCbfvvumKlZ3foogMftBxTqiz4dPxgz30svC9SU0NS8mga4dYKAfJTb+RuVmV7x9l5
         EMnzDTHQLU3is/d0Nh1I4e9twSKKTKtcOg2vEGCnVYivy4MMLN30QkDx4CaU6j2VeNv1
         jEm6Kc125d1gpgdBqpb3T7S9iJd38mjBJ5weV5G7WoE7Hixwv3wy9zyA0vdikrB+lfZQ
         aIon6dWDR21EPs7cEQsHFMQuL1YpE9wQEtBL2VQd9y+DMp74uQHg73coBv9Brbq1EFDZ
         VWQS/lw5h9EepMFt2A2oGLYZUfoCVhapE11JDbKC+IXUiv6TzXFk+o9FoDk6MYn05ZFI
         1yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1SK3FmyWNNpw6G4y43Kwb7gIJPzDAfBnVuIve7TjDc=;
        b=ijTpyfbCK/PV5D2uZ+6fq6OWvANlk4y+mygTRQe9rfzN03VRTnTbecoHg/xpD5B79E
         sAn61IIB5fQ5Iv/Rq8sLbsOCYQ5Rb2LURoOIDcjALTSY4PeNDstOAPH3wRi/9fXyt9wU
         /+AowdoNbmyOAXAtgLAZUrkuxMHCXhqx74kJWf76ik0zEUi09jA0lMmNOhf/SW2H+Dd5
         aSl1egx3BjPRjw4bFpEOnEozkjCWcVJcyv1dQ5ji4EKB0XOXSjcglK9FsVW6TZjynrLe
         yA/oLBhbas2NMou+r1rwBzL8Zm8UpQkq93pNpIHWwF2XoDarULYd9RjKuAqQuvLrx79o
         XCXg==
X-Gm-Message-State: ACrzQf3NgHG11GSrI0t3rW9pKjumOHQkpG2XFavXBj8yGUlcplxOi1gs
        ZW2+OLB7e3hbXL1F9jQT+g==
X-Google-Smtp-Source: AMsMyM4YgSMLUbbpvKx+iRy1VddHfrj7AbV9No4p/XrQY1dXhetAOW5p0z+bSKc/w0picxbfmeZkJg==
X-Received: by 2002:a05:620a:460c:b0:6ce:43e4:4e57 with SMTP id br12-20020a05620a460c00b006ce43e44e57mr21474633qkb.778.1665598894116;
        Wed, 12 Oct 2022 11:21:34 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006ee9d734479sm920228qkb.33.2022.10.12.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:21:33 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 1/5] hw/mem/cxl_type3: fix checkpatch errors
Date:   Wed, 12 Oct 2022 14:21:16 -0400
Message-Id: <20221012182120.174142-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This fixes checkpatch errors in the prior commit.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3fa5d70662..94bc439d89 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -56,9 +56,11 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         len++;
 
         /* For now, no memory side cache, plausiblish numbers */
-        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
-        if (!dslbis_nonvolatile)
+        dslbis_nonvolatile =
+            g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
+        if (!dslbis_nonvolatile) {
             return -ENOMEM;
+        }
 
         dslbis_nonvolatile[0] = (CDATDslbis) {
             .header = {
@@ -85,7 +87,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
             .entry[0] = 25, /* 250ns */
         };
         len++;
-       
+
         dslbis_nonvolatile[2] = (CDATDslbis) {
             .header = {
                 .type = CDAT_TYPE_DSLBIS,
@@ -123,7 +125,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
                 .length = sizeof(*dsemts_nonvolatile),
             },
             .DSMAS_handle = nonvolatile_dsmad,
-            .EFI_memory_type_attr = 2, /* Reserved - the non volatile from DSMAS matters */
+            /* Reserved - the non volatile from DSMAS matters */
+            .EFI_memory_type_attr = 2,
             .DPA_offset = 0,
             .DPA_length = int128_get64(mr->size),
         };
@@ -136,7 +139,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
         (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
     }
     if (dslbis_nonvolatile) {
-        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);        
+        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
         int j;
 
         for (j = 0; j < dslbis_nonvolatile_num; j++) {
@@ -146,7 +149,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
     if (dsemts_nonvolatile) {
         (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
     }
-    
+
     return len;
 }
 
-- 
2.37.3

