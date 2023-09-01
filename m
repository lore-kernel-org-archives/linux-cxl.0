Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7ECCA0FE4
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 01:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbjIAB32 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbjIAB31 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 21:29:27 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41DE6E
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-58caaedb20bso16634467b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693531763; x=1694136563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
        b=BtXkkzMJFiMyCZ+bLLkcEI1kJW/jxpo2CO8IBvDaFqqxhtH9z5HayrL51ZWQ1Qmbgx
         XO/ISg+tAto58YaqjM+mixh/TBo5v1xtpGWoUDPLJBMPt2dQO63edzFmm24rcas9AYac
         fCCkjyXNowo7Eu48wfBSbX6B08bBK3ZrG6VsGLhjX3Sqa9FjHzhNVjflwQohE/CY0h+2
         FNHs543jOtf9lNqdYkfdXKB/YNfRo55dyweGCPYoHAcDAYPSmkVw8TtAbYahKCVboLis
         F98q20pdoe+znhyLqt0ZTqm66KwQstdMqtG+0XW7VaEjqV8WWw0lNJlyBadwByJvboCH
         4Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693531763; x=1694136563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
        b=ix04KHU2IHPsn9zZ9kWrRB7QtLUEYY70eeP/I9ofu6+QqeCy3h1xHKSBUgZzlWWIdg
         Ne926oBNRxjHyX9Hl/8WWJsTGFaMZIdkFipsrK67Gm7oqwvlQWxyhnVV6Ne3RDQkUzvo
         VwR0ntF6RL682D9hZZZ+cQWSE/BJito/Iww7eyS5somk3o+TyLlePMwOfK4/0EYlGzvO
         Ig0UHZHcUwBwidXyYuD0f3YfUWU69YeJ26JSbXZl1pyvmHJk4zJwHeeC1+0snyh9qDwK
         /NzYlHJaz6PedKbML1LNroIawEycIejUk9qN1/zoWK9T5i/c/HY5QhDdmb27G+ao4URs
         4Wxw==
X-Gm-Message-State: AOJu0Yx0PWFRs0NIeHf8wzCx+z+LzVzNcu1eAZ4AysJ8ocdPDMk59J18
        Cbo0D/5VEWJdMAgK6RQp/A==
X-Google-Smtp-Source: AGHT+IEJPgTPHVRYS7i4yrvWXex07bwZ3MY3D94Tlo3IEKDVY/laIV/4Ngd3nqRkijMM4+JN86bGYg==
X-Received: by 2002:a81:9141:0:b0:586:6a71:b018 with SMTP id i62-20020a819141000000b005866a71b018mr1181617ywg.20.1693531763637;
        Thu, 31 Aug 2023 18:29:23 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 18:29:23 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/5] cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
Date:   Thu, 31 Aug 2023 21:29:11 -0400
Message-Id: <20230901012914.226527-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Call CXL_TYPE3 once at top of function to avoid multiple invocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index fd9d134d46..80d596ee10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1248,17 +1248,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1268,16 +1269,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
     return address_space_write(as, dpa_offset, attrs, &data, size);
-- 
2.39.1

