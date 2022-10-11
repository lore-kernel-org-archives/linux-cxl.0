Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54146C43217
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJKVU3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKVU2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:20:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D324D26E
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z18so9793590qvn.6
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk6+oDslH4pTPbHcXpDk0IpR14fq+cZd9zEm6po2Q3M=;
        b=URTPnec8rUQ2Pm6MSDK4VRTy9jqNMUprXSPDGota9/3oLYIssbz4Pj1bR14A85IIg8
         GNKCDGBnP0G2UKdEMJ1EbvddJFMQS3OYheXyyMu2h4vMedJJ8h1vtftIuVcj8iCm+cGy
         fjI2ZioQ9I1IombD+cb60hsc1gxmfKglf/897r22WH0KV4JQSUHnnc5RO395EpZBxsPo
         MB0Xkl4dd0oRcUFoKs0CsOqq0RmTR8+ZjcWX2FICpIjoJnEt/Wm1MkAS4WkqsNe9Ii0H
         bHT7cVyE0rTC742Jde+ZCfrpOoEcC0hqZeKpNbyZm/nzK8dpv3pHKAkHxaojQ8x69GQy
         IKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk6+oDslH4pTPbHcXpDk0IpR14fq+cZd9zEm6po2Q3M=;
        b=bBMgmA8k2FD3a5GgfZZeGL9xfIfvxVEpgws9cvfCrVW0GQBZY3exjVHIaNMppo4llo
         DLXX6HIT8VZniSfMrQr8gQ6cDIXXi38w1kEG+p5JBS5rKVYJ3LfgnyL1FONMKJnMMhfL
         yFu+pM50jtfXSy04bjtVK5sDDHgT4M4eGrN0fp8LaALBNPpybSuAc64Y1h9e2kYEntxe
         5cVxRaRQt+FkIuNYo7h/B2iqcEV4y50llLnU3En61xmJMkPCvjYA4x6bGddtBZJeucfO
         OYvxWV1+wqTLw568SnG9JGUOCP3K6ldhWKFyi2rKTQkyvCWrXwaL/AXnW4CVWe1D+XgV
         Z5eA==
X-Gm-Message-State: ACrzQf3gjyUtVQDiRuUjfVb/IBXk17sqPkNHHF26np6el8bxFXemkNi9
        W7Ufs/ApK5riOipZA8/6/A==
X-Google-Smtp-Source: AMsMyM7NpmrToXN1ecncH/qlivf1f9hvWXGrXotwBzOGtP6e2p4xkY5CJElPoUzkp2tJXJY934n/ow==
X-Received: by 2002:a0c:9c4d:0:b0:4b1:c126:b1e8 with SMTP id w13-20020a0c9c4d000000b004b1c126b1e8mr20543436qve.21.1665523226605;
        Tue, 11 Oct 2022 14:20:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:20:26 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 2/5] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Date:   Tue, 11 Oct 2022 17:19:13 -0400
Message-Id: <20221011211916.117552-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Remove usage of magic numbers when accessing capacity fields and replace
with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c7e1a88b44..776c8cbadc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -14,6 +14,8 @@
 #include "qemu/log.h"
 #include "qemu/uuid.h"
 
+#define CXL_CAPACITY_MULTIPLIER   0x10000000 /* SZ_256M */
+
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
  *  1. Add the command set and cmd to the enum.
@@ -140,7 +142,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < (256 << 20)) {
+    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -285,7 +287,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -295,8 +297,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     /* PMEM only */
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    id->total_capacity = size / (256 << 20);
-    id->persistent_capacity = size / (256 << 20);
+    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
+    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
     id->lsa_size = cvc->get_lsa_size(ct3d);
     id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
 
@@ -317,14 +319,14 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
     uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
     /* PMEM only */
     part_info->active_vmem = 0;
     part_info->next_vmem = 0;
-    part_info->active_pmem = size / (256 << 20);
+    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
     part_info->next_pmem = 0;
 
     *len = sizeof(*part_info);
-- 
2.37.3

