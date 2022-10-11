Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96C4C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKVU0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKVUZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:20:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24274D16D
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m6so4263175qkm.4
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ozVAThgn2oeccWPcE+jwIIHUv3uIclTtkDlamqTwwk=;
        b=k4fm6dEkcYzgX5Q7VPbkNgie4EmRxxWgLPHRI3Nax8PSmgCd7AbMlPrjI3hyajdpsD
         OLh9ezcYAu/z46FVdEr3qpsCfGnR5uASxk3kWBknjPlz9ChU1BKL/3GBfH7a/S2T5HUE
         ZT3CVG+ctHA27V3xOsWC2jtopjCdiW7VKk3vlGh1/ZdZxnBWfkySpHYKndA0anhZDaLr
         TzgelghthKQk2+vTvYjHcRKCcMUyHO91rMycqIlPojbBNyxdyBSVQYMHkNSeBi9a99He
         m9xREuRmkubmc/iijzY2yvkOBPDGnEYfvQ73y4tWCpjyK9hnd9PbUTApFV22FYFfXzvZ
         Hzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ozVAThgn2oeccWPcE+jwIIHUv3uIclTtkDlamqTwwk=;
        b=hACbNe7EC93i+zYCUjYnBYpVB8gesFMwbd8gipypu2W7vumzhTYr69I/drYBNs4H+H
         DEdZUssUNSNipn2S3uZ77dt20g8vTn6DmaJ44XpxJgO7/I+V5hNSjQfGvVLakuTfLcfl
         PltobdMz7qK7UD1FBJODFuEWV5cR0oV0XuhzCQO9m813JwFyAQ+v6G2t7xL5xe+thSSY
         eJrxIy463dqs+d9G5saPuaMQhtoILBsK9b24GgUbIdlgCRspPnECcFvl3QATvW5eZk0X
         eYx+0vWrsc74yYKwph8dthXDBeCGC7Y5tJSzvPdkcCFqFlfpKEXAku/3XZ0ajcK7tups
         l5oA==
X-Gm-Message-State: ACrzQf32YMak3zozHcn6OXFRiT+Rp50P/VPX9fknrH9VY2pclhzlkqqP
        g9FgCFU+XqSwX8W9s6aaHA==
X-Google-Smtp-Source: AMsMyM7kFZvP7defG2iJkjuNTo0HSF3VoSHFoaf7ehStKnxdYQZUqMA9fVaJJS+cPNwjYDO4WLwAiw==
X-Received: by 2002:a05:620a:22c3:b0:6ec:53bb:d296 with SMTP id o3-20020a05620a22c300b006ec53bbd296mr10773609qki.158.1665523223758;
        Tue, 11 Oct 2022 14:20:23 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:20:23 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
Date:   Tue, 11 Oct 2022 17:19:12 -0400
Message-Id: <20221011211916.117552-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Current code sets to STORAGE_EXPRESS and then overrides it.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e7ca7a455..282f274266 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -535,7 +535,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     pci_config_set_prog_interface(pci_conf, 0x10);
-    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     if (ct3d->sn != UI64_NULL) {
@@ -763,7 +762,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     pc->config_read = ct3d_config_read;
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
-    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
+    pc->class_id = PCI_CLASS_MEMORY_CXL;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0xd93; /* LVF for now */
     pc->revision = 1;
-- 
2.37.3

