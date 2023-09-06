Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06454EE14C3
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIFXtG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIFXtF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:05 -0400
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98210F9
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:49:02 -0700 (PDT)
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-59231a1ca9eso4457927b3.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044081; x=1694648881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
        b=oHKlFJv0RJ+6xM4/J2941T6+zBll47EaOC6mxw+dhVT0rdbm/5Dl9iLxoJBIUtfHYE
         uJucGU09kMH4R1JWgtp/MtHizejGWBNM0haH3TnMJj4/0c7RLEej56b44pbxE4hjDwLn
         t5BdhQiNLiwbAVxsJQieix72ug58WVL1662Tw6WftqALSI0FvzsnP800hKTZUYpGMZFV
         EAhKD3dB+gMy120XKVOEetavI/gqIVkh6hVergqtOSnRnV/Jyt1I7GuT0fzdvEf+38UP
         PGr0eF4OmZrUnN4I+HLvve+Q54j32m/DTLXGvhhwbb7DHxGlXAxsF1Gb9z0ZnC/U1Xoe
         6DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044081; x=1694648881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pq4K1DRMCsdduEbuGuJ200122U1I+V8+TOdtq9hf9Q=;
        b=hS4weyaGJWc3XnSmpxg+pdB3neurAvd//T/WEpAt6roj/Zxq+m5ynR4BfYoUe10kMS
         rXz6SblWiZK9caB8+Y4ZmlflJSozWPBZiMZ+RGub/BSN1glt5SdkNmJfdCqOs0HwbYCy
         GohkWPXq1dfUGGr8I9YgjZ5ELyucESiTCfQpXu63XLfx+TcGypjlQaVbq99tb/j4THog
         sQiWQ5Z5iQ4P0OMqDkjPm0SAv44KaGuNxToaSrNfbtlFdD71sIQCzb5nmq3vdwXGu/fb
         uZJbVwW4zU7b4B8qg6xf21IUaLYacpOiU43LeSKif8mcbt4l9WaZUIGEeGjp8XlaDOA7
         ePeg==
X-Gm-Message-State: AOJu0YxLkIV5Q75F7q6JiorBc+IaN46e2KWRaDep7mg2qOltFIIDBOi4
        41jpOGZsSle/hoHl9CyykHjnr7RLRECf
X-Google-Smtp-Source: AGHT+IH/ubpKztgn1qDvJM/VkrWOg2yBzVO3CflsLQdbMmkZBe+KAhcEoIrZzMeoczKFrs8vbymL6Q==
X-Received: by 2002:a0d:d685:0:b0:589:db22:bfd6 with SMTP id y127-20020a0dd685000000b00589db22bfd6mr19575436ywd.40.1694044081583;
        Wed, 06 Sep 2023 16:48:01 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:48:01 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 2/6] cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
Date:   Tue,  5 Sep 2023 20:15:13 -0400
Message-Id: <20230906001517.324380-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
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

