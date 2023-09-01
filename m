Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26372CA0FE5
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 01:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjIAB32 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbjIAB32 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Aug 2023 21:29:28 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525DE76
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:25 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-58e6c05f529so15429487b3.3
        for <linux-cxl@vger.kernel.org>; Thu, 31 Aug 2023 18:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693531765; x=1694136565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK7n0aiJMN0SWoP8B2n02PHYDXpt98FoPoro/RkTgS8=;
        b=GslpNyMb9v/FQmuLq8uO5I0TqlycAe0UyRh0Wzct6wA947HMsBhykPXwEflZi5N/gm
         w7CTJyeb6rJAnCrzeUVcthuiVmA/9In6S49nbrnZzBo/rc0/wUsAP1p3Eh159eg51Em1
         oJtxIU9A6GmJ/BHlIi0r2lYhjIfJahGqN7y6jQRkluvc6mMHpgsdjMwo0IUGiwEauEQc
         8yKtnwviEGNIrXN4Jxbvaz/ee9Bz80yuqliC23a4x8W9mTagCyl5ZIk9iPcrOZYaV+c4
         +PdMmHwZA9xHHZrxyu53THGzv8jRHKgPXZAl4qrJRjdp92YK0QnkAaZX2mYiq7MGxjGr
         YTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693531765; x=1694136565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK7n0aiJMN0SWoP8B2n02PHYDXpt98FoPoro/RkTgS8=;
        b=XNhPwzrPfYYxvdG35IHOWlbPE2sc5mo3MAw5Fvz1bVS7r2oFx6+LXxW2RuTidHjAAu
         SPtmW8MshPAwGv+aZluqLd3giGKSs9A3Cav4IGnRCsEWU7sIdJ8SRtBbKF972+Ak73BO
         uO3cLAo71pHyZRWGpgPvGDsM73F4IM9KfDntggAB+Pgcnmf4EdRw8/O6btPbFefoeBni
         6Zzj83Wpd245oW7N4fMSICz6CwfgChim16fI3n3DlkIBubHSq1sx5VPM0mwv1oRvvkCy
         F11KjT7sZ3u0X24cubfJnrbxmpP5B+le4/TFHT9E3gufvCA6v9JIEj/KnQnBXrcHQY72
         NZhg==
X-Gm-Message-State: AOJu0Yzh4rgtSnZO5bK1LWqZDDdM+B3PXzHwYVcpSyT8R0if0JKvspnD
        Mf5VTlA+XSGBZ5mJBO8pkuuqgdH07Wwm
X-Google-Smtp-Source: AGHT+IHopUFq0B9kgHdCiPSfXi9p4iJvI2XcsVjcI25l4AGICoAvGmt9VwQA2GIRpLzeMRkcsz5gYA==
X-Received: by 2002:a0d:e5c2:0:b0:595:b30:1dd8 with SMTP id o185-20020a0de5c2000000b005950b301dd8mr1394663ywe.18.1693531764903;
        Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 3/5] cxl/type3: Expose ct3 functions so that inheriters can call them
Date:   Thu, 31 Aug 2023 21:29:12 -0400
Message-Id: <20230901012914.226527-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For devices built on top of ct3, we need the init, realize, and
exit functions exposed to correctly start up and tear down.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 80d596ee10..a8d4a12f3e 100644
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
@@ -2081,7 +2081,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path,
                                      errp);
 }
 
-static void ct3_class_init(ObjectClass *oc, void *data)
+void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e824c5ade8..4ad38b689c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -524,6 +524,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+void ct3_realize(PCIDevice *pci_dev, Error **errp);
+void ct3_exit(PCIDevice *pci_dev);
+void ct3d_reset(DeviceState *d);
+void ct3_class_init(ObjectClass *oc, void *data);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
-- 
2.39.1

