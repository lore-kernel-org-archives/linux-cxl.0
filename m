Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE27CA0FE1
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 01:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjIAB3a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbjIAB33 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 21:29:29 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23360E70
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:27 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5925e580f12so15732977b3.3
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693531766; x=1694136566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGyDOe9YH+wHWF5Vb+pQ1xAEsSvo14grLJWUVd5BMeE=;
        b=TEnB/lqACjWS8ouZegVUjfEqRuzeZhwayx9qV3+6y+i2Y4N1pY36KAGkhA8JpLtP9p
         YnrlAIg0Q3/OfoyjBpt9p8v+reYAKmqXAZ6uECGg2/RBhalzhrVHSWUbdIk98Bcj8RDj
         VTQT7WG77m4R0pDaQY/w8rt5f2fxrxQPsHfgdrrOWSO+nDAOK7/lB6jDYpiK28CXMOor
         MmuEf7F/nwQ3bKyl3QKk65w7wEQ/vemYQBHvYxPHS8tcKPSZfRH0edCa1JpGtHztCUlE
         zFDeJfYyyh0KYeGhPZpSAOlpY6BKpEXRG1L3fluZG1+QEdJ/ql4sjTXlYPF3duB1mzYm
         tjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693531766; x=1694136566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGyDOe9YH+wHWF5Vb+pQ1xAEsSvo14grLJWUVd5BMeE=;
        b=QKF2Zj/lXTZqMeLro0LHQmpR0xln5361//o8atd1q4Dsdb70RYcs2XHFZrI5UcFULf
         2WXBeyXOpwvN5sZhYrblYQ2BzVaoCIJEmESK1FuvLLMu0T2mmVJ3K7/w2GF5tEJrRAAh
         ItnuYjr6nAmj4ZjhqaqMIqHBlrK3QamuhRon/g6bBsS3TjgjOlc2AkkUa56vZ9DZG2xa
         OGy6hOiHDx2SccONnWTfvYYcB2fEWjNgGCaoRWSxcjerHoS5Ql9ZZSiZkdo1kZqNklJA
         d8mdgxv+TgC9klNFL39W+QRL6rLMX5cu6pg3nu/PAOk+HYxNFqvauAr/UQf6O4kZhaRO
         RzNg==
X-Gm-Message-State: AOJu0YwAvXEPqeHqT2KgcOT7abQFzMGM+z2HYxdR9glMcHi0lbwcjSBy
        9Us8CU/mUxVZB0hkkPDTfizP/ErwhEMX
X-Google-Smtp-Source: AGHT+IGo027K8zC4uZckAITLYpghGqKZwYmeHjA3c7jEoHtENn765YTn1e3HAVQXEB0XQRm9OWKS3Q==
X-Received: by 2002:a81:72c3:0:b0:595:9770:6910 with SMTP id n186-20020a8172c3000000b0059597706910mr965799ywc.52.1693531766304;
        Thu, 31 Aug 2023 18:29:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 18:29:26 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 4/5] cxl/type3: add an optional mhd validation function for memory accesses
Date:   Thu, 31 Aug 2023 21:29:13 -0400
Message-Id: <20230901012914.226527-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
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
index a8d4a12f3e..8e1565f2fc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1034,6 +1034,10 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
             goto err_release_cdat;
         }
     }
+
+    /* Devices which inherit ct3d should initialize these after ct3_realize */
+    ct3d->mhd_access_valid = NULL;
+
     return;
 
 err_release_cdat:
@@ -1259,6 +1263,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (ct3d->mhd_access_valid &&
+        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
@@ -1279,6 +1288,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+
+    if (ct3d->mhd_access_valid &&
+        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 4ad38b689c..b1b39a9aa0 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -489,6 +489,9 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
     } dc;
+
+    /* Multi-headed Device */
+    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.39.1

