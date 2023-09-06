Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5BEE14C3
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbjIFXtK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjIFXtJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:09 -0400
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994F010F7
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:49:03 -0700 (PDT)
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-5920efd91c7so4332287b3.2
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044083; x=1694648883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2cy+GLqlTQ8dVdKP4BOlp5an3Yg4Ivxw3bTV+3I6Rc=;
        b=gy9eLHhco4JNtH3LDG7CcF/Uham06hISWCDBl6G4SwdALc+h0KuVeGYY6yDlOSl832
         z95WlwgcRAlH46EpM7XYeRfUffRUKQY9tL10eAkgz9Mlkkxa/KUs9WegLhYfEcnqwD7E
         nfals1wEHgqMRuj8ltVoNQQo7HkwwtRQEn9dJnAMjjSSwUJvnVXth/h/J5ps7vqXh8aK
         jCwp2fIM0aCl1YJ7rrWhPSIDar/izJgAzteKU4KsWebZ7s5VcAXIWAiImY7fwo54dAq5
         tqkoz4z7bdgsNX/Y4YRs0D1RypBV37eIo2jsDeGoWISah+Ph/JzFfpPoigAXaPcSpKS6
         k4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044083; x=1694648883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2cy+GLqlTQ8dVdKP4BOlp5an3Yg4Ivxw3bTV+3I6Rc=;
        b=BLata5y2KOJ4EFUNgxf8dmyb/PWDdjF1o1+AVKsou54PeYv1IW8J17MmZB3rs6M46d
         F1UP8gwueXV1aQ9blsImAC79HwwNLvoyXJzz8YL6yS4iKMbJ+WIC55v9+m6ToTtnZjlc
         ErltL2CGcrG9Q/VcPmpshJd+KJwkeaYur0ru4rol4DPr8KxirrH77jiLwj+jkt11WQJp
         9hLv3zQj5kuuPoFk86Wqhn14I/KDHqMV2aD3Fy0S2gw2/+8LWjaDQM49buKPnuZ/TaG3
         UzoWkZsBIlyNRz5IvWXAIj1VmRNe4jwxjwvawHOMZgKytZQIwKx3vHhe70dBxtMk03PG
         +pfw==
X-Gm-Message-State: AOJu0Yx/DG1sTrKdR8BZv9sQ8iTwKZeJrHP/xDhyx1khHhDIjqP6Xyae
        JmnUB/TVrocissYL4xPQLKxNaVs7Blgr
X-Google-Smtp-Source: AGHT+IESDAYo5PwejGWmAa/zJuBVeaLBycSjoUBB5CtYMOrj5c0JbFybviSnNXYCgPHTFNu2LuPikg==
X-Received: by 2002:a81:48ce:0:b0:58c:5299:8033 with SMTP id v197-20020a8148ce000000b0058c52998033mr17140659ywa.17.1694044082780;
        Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 3/6] cxl/type3: Expose ct3 functions so that inheriters can call them
Date:   Tue,  5 Sep 2023 20:15:14 -0400
Message-Id: <20230906001517.324380-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For devices built on top of ct3, we need the init, realize, and
exit functions exposed to correctly start up and tear down.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 6 +++---
 include/hw/cxl/cxl_device.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 80d596ee10..6e3309dc11 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -950,7 +950,7 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
-static void ct3_realize(PCIDevice *pci_dev, Error **errp)
+void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -1054,7 +1054,7 @@ err_address_space_free:
     return;
 }
 
-static void ct3_exit(PCIDevice *pci_dev)
+void ct3_exit(PCIDevice *pci_dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -1285,7 +1285,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-static void ct3d_reset(DeviceState *dev)
+void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e824c5ade8..9c37a54699 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -524,6 +524,10 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+void ct3_realize(PCIDevice *pci_dev, Error **errp);
+void ct3_exit(PCIDevice *pci_dev);
+void ct3d_reset(DeviceState *d);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
-- 
2.39.1

