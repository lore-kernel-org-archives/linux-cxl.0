Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B93C43217
	for <linux-cxl@archiver.kernel.org>; Mon, 28 Nov 2022 15:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiK1PCQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiK1PCP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Nov 2022 10:02:15 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011911FD
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:15 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id o12so1917654pjo.4
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq3NRy72X3AFgsMApkdPvqc33L5sCjSJV7Eox6k+7XI=;
        b=M0SpkFsK0rWgiTfLWrl2MlQpUs5qqZtXuJL4yW6ErK8B59Qql93jQwnrSuH2PHluj7
         gISkW3242hrnVrHa/B4MhOBiN5Q/Z27xjvyJ2zF/cLj/BTWATi+T4nxma4IIe5KxuOkA
         7cAVficGxiM/HUGTC3OLt5+PTjNf2QaFImTkJpWG17U/4UdjkbhrhAE+VQctQwHz1IFo
         4j9qTt0/3/tpyS767fzCuAQ2sUEBNF2WoTWKnzrV4owGA7fP1p+OL5yFBNz9D8JMn/9n
         QZxe5hbdiymY7ZYk3VhwKWiYlkmF6mNNVvKWBzF5jsiaCsj0I/AIq9XSOIMZudWqzRso
         xKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq3NRy72X3AFgsMApkdPvqc33L5sCjSJV7Eox6k+7XI=;
        b=q/H/rm7z8dd6dMxRdX+bsGNRrz1Ie8KMTPdFWTEEZG+ev6PPZGdJb3+SixUH9lsYAe
         MJX4t8Jw9Q2FTq3qfsqiBBXcEkFTDIYMarhNnggwL30+yzeK3liG28lW23eL9LXOcPYa
         GWVZn/lVpwMOFwzjFEo6ujsTg1RScqaPeLHNcJzCLjtz48r3VCOAZ/qBLf/MlfuhOIm4
         mMxv8XlYJzTH4lg+3BEVw5OfZBXZrArW2uYFJ8zFvGeqmSa3mi8Sd/51xZHwI+RXqF8M
         /gZhJjM8cG3fTnkWtvYhjBbezMbzzDDxvYTfhIb07IJxr66vqy3R/O1Zu/VXdMSOlt+t
         Aacg==
X-Gm-Message-State: ANoB5pmuGl1cIvB/SsYJYyTjMWSu/g1SRNN77LZOWWXWV4ax/3KC4Ukh
        /mjqNUhLsSk2L3chYMiZdQ==
X-Google-Smtp-Source: AA0mqf5Asg0rv13Ipcqg9rT+Nug0on7Ts8fbocO1TgaO81M/DAPYKe31YKDNw3zpbZKo1raYCLWGCQ==
X-Received: by 2002:a17:902:f10c:b0:187:2721:68e1 with SMTP id e12-20020a170902f10c00b00187272168e1mr32523501plb.21.1669647734378;
        Mon, 28 Nov 2022 07:02:14 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm8997928plh.127.2022.11.28.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:02:13 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        Gregory Price <gourry.memverge@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC v4 1/3] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Date:   Mon, 28 Nov 2022 10:01:55 -0500
Message-Id: <20221128150157.97724-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221128150157.97724-1-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Gregory Price <gourry.memverge@gmail.com>

Remove usage of magic numbers when accessing capacity fields and replace
with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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

