Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9DC38A02
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 00:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJZAtS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJZAtR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 20:49:17 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6EDFB52
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:49:17 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id i12so10251987qvs.2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u9Srr6RXjECMW/z6fGCEplaACCtFUVAvHpD6VsFGYI=;
        b=lb2uPwdsVV8+Qr+6+gRs0GsA/2YzAY3YGpgCAt07Nih5ihzeki8P8UUaaBA6BrAHgB
         roB4jvw+wtgqFnpXt3hOdgnZePM+QxjVDjSPavlhDDHdvFQAeHMKOELFRI2RKdOBAw3K
         bF6sJEv31boKoe66WJpxmYhCE59Z6dE9Y7HxK+NGDqxpKCd2pzylEYJ2UF6456wUNUdj
         haYjnui/Kbv/N4m7ALzWSVCEnbLMET/M3a0GkJbp/P6YE2Tgcf9kEXPBQ+365T9a0CfK
         1AbcQfoyNWwR7O+ltUkROuB2g3kDTIUwuYzV+rFqkSW+8ef5L3kks98s+uanuyB4VivB
         M47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u9Srr6RXjECMW/z6fGCEplaACCtFUVAvHpD6VsFGYI=;
        b=3HsbjOqChax40nq2xSPjBoTCMC1Vp0fN0LtsMPwVEu59D4yN8pdDMZDrW5wJ7+3fd2
         9RRF9hjZZCL+ouQUlAP5nZxQ0EqpuIxPGhQ46OXudGxWRPuyWoCM9GnaPYq2/le5CG8q
         JsU2WYRZfIPH7XxKKFcDA7y/We4hAWKwAbpl2KBY5mho+yqgMT4Zaap9eDk+gRjWF5XV
         92366jo1rR1PLmXNWlUzMCkzto5Ay/1AokdE3PwVco40Oj+ipX+gLpSMePUfjtbYjTBz
         Ig7FObp9qMmtAoVH6GNkzdwcq0dzkAyBWEIazBFwN15SVGGrCAA9pdIsx8UkRA1Nji5S
         I4lA==
X-Gm-Message-State: ACrzQf2lsfO2IMWxeY5Gd6x69BeZeizDWdvdX9NllJYCF6C74R9xQA8r
        mo84HaeyJ2XDtW//P8/sTQ==
X-Google-Smtp-Source: AMsMyM7kWNgW/Qc08xbI2ipjZ7uhFkt3FM7NaxfvqlUw8LQ6GxNqwnQ5fjbsSSstj5XOfsinCWFTng==
X-Received: by 2002:ad4:5de8:0:b0:4b1:85db:3509 with SMTP id jn8-20020ad45de8000000b004b185db3509mr34393355qvb.121.1666745356253;
        Tue, 25 Oct 2022 17:49:16 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id j15-20020ac8550f000000b0039a610a04b1sm2408651qtq.37.2022.10.25.17.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:49:11 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        ani@anisinha.ca, alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [PATCH 2/4] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Date:   Tue, 25 Oct 2022 20:47:35 -0400
Message-Id: <20221026004737.3646-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026004737.3646-1-gregory.price@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
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
index 3e23d29e2d..d7543fd5b4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -15,6 +15,8 @@
 #include "qemu/log.h"
 #include "qemu/uuid.h"
 
+#define CXL_CAPACITY_MULTIPLIER   0x10000000 /* SZ_256M */
+
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
  *  1. Add the command set and cmd to the enum.
@@ -267,7 +269,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < (256 << 20)) {
+    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -412,7 +414,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -422,8 +424,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     /* PMEM only */
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    id->total_capacity = size / (256 << 20);
-    id->persistent_capacity = size / (256 << 20);
+    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
+    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
     id->lsa_size = cvc->get_lsa_size(ct3d);
     id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
 
@@ -444,14 +446,14 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
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

