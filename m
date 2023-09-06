Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABACEE14AA
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjIFXtM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjIFXtM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:12 -0400
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00D1BCB
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:49:04 -0700 (PDT)
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-5922380064bso4365887b3.2
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044084; x=1694648884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uQCHpegy+Oy5ZTt5LqLlsA06JmldqXw1wStxlifsWA=;
        b=rVdB3cADt1iIrQpyFcd2de7XBe5BaN6wCg344qkF13pqDSfHhYW39U4igPCysifb8N
         oiYiJmNfqEQQuSBTVjKs6MHH3FcaWguBJan6FAtgoKMtYwnYgEqGOkclcJgsrk1umQW7
         gUc8yNa9cslB9Ugc27B6+T/OsRxSu/Wctv0gwMGSYSJkokyolZJ+vSiRNf7D5+PiXTC7
         81C8hrOVlYvivdQW14bAXgv7Y6V3iP2JFirPASHsVJyoyfWr67YS7t7lRp5mmnKFUjIO
         75f3RMlZ7V8vUIFvrTYmgxYuWVlH1prmSiCA+VuYyW1RTUZo8+O5zM+fy7fBck5Zlh+X
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044084; x=1694648884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uQCHpegy+Oy5ZTt5LqLlsA06JmldqXw1wStxlifsWA=;
        b=BrHvLAwFM/HuEJRZo6TNWcIxC4hQaqZIvfEMYslLevGLqRbdT0Eidt2GJnRUF6aJp5
         CJXvdwgb4J9gUzLmx4iL3QMLzBvK2tRTX5IQaazf2IoAZqsZdHJRPCSaFmgSCfoN+/sh
         eW2XR7ErWOSqGjNyS3XXKFM65/rFWF+NgIr2r+b0N0BPF83FZgzZ/eCilGeXF14WBpQe
         dqr7PJywZixX8EoGbW8jPjYe3BWp0766jmTJGl/2oka/gNn5vQufIT8NNqbF4kmci1jL
         YTC2mtFaygs+GSh5yFDT2XLfJIGZ71R9H37BHTr4wd4kDCndG9qheK8bbegorzsCmq39
         jOdw==
X-Gm-Message-State: AOJu0YwCpv0mlYmgGuH4X9S9m/3UpckLrYLutP1xnGfW4RwdfT35Z87K
        TzD9Qdki7M9pqTx8Dq9Lmg==
X-Google-Smtp-Source: AGHT+IFMy7ES3j3wkZBhB84OxrmgRJ49qRnJ/3RREn/RM8HAdptZWVyJVzSNKZvrqdGYNDc9F4CBHg==
X-Received: by 2002:a0d:d3c1:0:b0:577:25dc:c1fc with SMTP id v184-20020a0dd3c1000000b0057725dcc1fcmr16551998ywd.0.1694044083835;
        Wed, 06 Sep 2023 16:48:03 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:48:03 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 4/6] cxl/type3: add an optional mhd validation function for memory accesses
Date:   Tue,  5 Sep 2023 20:15:15 -0400
Message-Id: <20230906001517.324380-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When memory accesses are made, some MHSLD's would validate the address
is within the scope of allocated sections.  To do this, the base device
must call an optional function set by inherited devices.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 15 +++++++++++++++
 include/hw/cxl/cxl_device.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6e3309dc11..1fb3ffeca8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1034,6 +1034,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
             goto err_release_cdat;
         }
     }
+
     return;
 
 err_release_cdat:
@@ -1249,6 +1250,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1259,6 +1261,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (cvc->mhd_access_valid &&
+        !cvc->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
@@ -1270,6 +1277,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1279,6 +1287,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+
+    if (cvc->mhd_access_valid &&
+        !cvc->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
@@ -2106,6 +2120,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
     cvc->set_cacheline = set_cacheline;
+    cvc->mhd_access_valid = NULL;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9c37a54699..37893f8626 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -506,6 +506,9 @@ struct CXLType3Class {
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
+
+    /* Multi-headed Device */
+    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
 struct CSWMBCCIDev {
-- 
2.39.1

