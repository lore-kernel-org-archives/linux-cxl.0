Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B7C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Oct 2022 23:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiJFXh6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Oct 2022 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiJFXhr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Oct 2022 19:37:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831214299F
        for <linux-cxl@vger.kernel.org>; Thu,  6 Oct 2022 16:37:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y20so1968022qtv.5
        for <linux-cxl@vger.kernel.org>; Thu, 06 Oct 2022 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXnrCCrFrEHRTzjU4zPgMKQljTe3AEJH6ThNJaFK9+Q=;
        b=gdLG/8hwiQYAhivNCwdR/gGa3loMyrfQjaEvDSDjtjgQT0eMkMCtlv3JNy2ib5770H
         qFqQtwd3efSl8Xr/IO66240r/OyMvVUKWXyP/fgSOHyUZNG3B8oWS5DvjnngZv0HU7Gk
         NB2bNPu6MqjvMEb5GbYFK4fQoFA2MFvGt4SLvJRX5XS7Apoy6EAM58LBdUxe34cohbVV
         +sGa1n4TotjWb05XxDPV+3SJsydQ0As2xdgQBhyvZOnAj/Q6jYMBNpDTaJVxvCLUax6b
         uJ2SMS2JGTjVqKL+PqSyifYIGi9OESUYwu3LMYHGi+9W86lLIsbhTFZs5EXCLGn+1PPR
         VtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXnrCCrFrEHRTzjU4zPgMKQljTe3AEJH6ThNJaFK9+Q=;
        b=PUfiZjkoMr3AJPeQNZ61vibVJFjYWTWcKeWedG5Vpg7gR+7VfEvKIDQh5bhq/+HizS
         eQOCdaxIX5/LhLp+CHHotLA4cCJbMgtZpq5Mql5bsWnod5/9RNJpqedAs1LDeSXl9dn5
         EXTtA/v/v3QppH4LG6ojMJ+zyx+HFzWNECaZCiP6b0LCFaVULctS9P7qoMDQoPXDhuK7
         SVq9bPYWDKGqWiHOCty5CvTsZEB9aUvafyRPIO9RumL0glwZcXF6drkbwGJFyp45H9by
         c3I5ofNL97x8Ngrmiy5tPnvmnDEYBPGPxS6dRh84P6f0X0DGyMl2J6YBBPMSc4loy0xO
         EeAQ==
X-Gm-Message-State: ACrzQf3XRL/AYjiCQiW8ukSaSl5dU+oo2yPd8dnA/km//jJOZcj3lal/
        ldVLVLM2s3ob9jvoIGwpWPzr4dHFSQ==
X-Google-Smtp-Source: AMsMyM47ayvjPLxl4MVI8DahP9BUKGU2hKr9rMCxuYdKTO0z2kAC/g3fWUf0v9SONi6H6NAE/TlvKw==
X-Received: by 2002:ac8:5d88:0:b0:393:a9e3:ac82 with SMTP id d8-20020ac85d88000000b00393a9e3ac82mr2336207qtx.632.1665099460705;
        Thu, 06 Oct 2022 16:37:40 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm528032qkp.19.2022.10.06.16.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:37:40 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/2] hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
Date:   Thu,  6 Oct 2022 19:37:01 -0400
Message-Id: <20221006233702.18532-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Current code sets to STORAGE_EXPRESS and then overrides it.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ada2108fac..1837c1c83a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -146,7 +146,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     pci_config_set_prog_interface(pci_conf, 0x10);
-    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     cxl_cstate->dvsec_offset = 0x100;
@@ -335,7 +334,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
-    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
+    pc->class_id = PCI_CLASS_MEMORY_CXL;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0xd93; /* LVF for now */
     pc->revision = 1;
-- 
2.37.3

