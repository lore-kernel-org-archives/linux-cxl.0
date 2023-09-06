Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B58DEE14C3
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjIFXtR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbjIFXtQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:16 -0400
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C61BD0
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:49:05 -0700 (PDT)
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-58d9ba95c78so4136417b3.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044085; x=1694648885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3TXSZttiLwQUf7LpcHreKd5DddM8bjWjzB8x7ZghXc=;
        b=rsnXhoFgfKFT4oy+PCJPwXYsDXOLvAz6rx6mm1QIuPrR1P6ZSdqU0z2YRFj7tw6ZPe
         Zgt/ZC7rm1ZnuTXSWPgqGZTyu9gqSsNAkakAIrRubv1dc4Zh1SYA+C8aYsJIddgfGfAf
         tnSPAu1InOhJAmyhb/eTLSSB7A4Kh6GergOYASfqhP0yA2tFrle/v1pFkXRUjipCkTyi
         ZsFvvI6vfGVlTytgEeg5eJo+Rnx7VOvMcj38I/tkQYUnVihcRNB2BMO2bseZbesnzhds
         Ben9GMgjYuCGKXlNPDJ+rBjPgKoVDW8EBLYbqJQ8ElxNwAc8dCDE9wGxKijcnHk9PYWH
         /TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044085; x=1694648885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3TXSZttiLwQUf7LpcHreKd5DddM8bjWjzB8x7ZghXc=;
        b=Mrv8VrQVptQHprQxDvSkg9sZGaDQ7eYNUtdPosXhb34qR7jeKX15ksXCUGsm6He6FV
         KrrymCVcjy+5iKmmL6Ll/KK+ufXVO0y8c1Kd9MCILwdP27NEqBRulM7doupZR+isefK4
         42bdl3YHe59OEvaH0N/W/E5DqA3QYhIO6JZNjqblwubM/3/kVrExu0AyJl5ruBtgYP7a
         du1yFUGOGwP7B6rnHV4HSovjiW/M8EWtU7lqfGOJ1j4a8Hrn3f+gv/5VqbJfwo9AUjOH
         sDIJJ02lMJIwQqXcD3O8pSUz8/XqeB+pNZzOJhstZ2YJJbgfCi3FynzheY1o5AMmEdRs
         XPPQ==
X-Gm-Message-State: AOJu0YwXwiMpLMMbyWWm77Tx25tTKn/aqIu7h3bCdx6BS/lE/tmWJojr
        xFb4gpFkkL29C7kV8HHlhA==
X-Google-Smtp-Source: AGHT+IFkOIfbSKj11YwpbzpzJ6Eum4HrDx9FlBBhPK+AeC3/cGJ9KHg82RM0QZl1Sr5foj/nyMhJqw==
X-Received: by 2002:a05:690c:290b:b0:598:7885:7b7e with SMTP id eg11-20020a05690c290b00b0059878857b7emr14387412ywb.18.1694044084880;
        Wed, 06 Sep 2023 16:48:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:48:04 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 5/6] cxl/mailbox,type3: Implement MHD get info command callback
Date:   Tue,  5 Sep 2023 20:15:16 -0400
Message-Id: <20230906001517.324380-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For multi-headed type 3 devices, this command reports logical device
mappings for each head.  Implement a callback which can be
initialized by MHD devices to field these commands.

Reports "unsupported" if the command is called but the callback is
not implemented.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b64bbdf45d..3177a59de3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -91,6 +91,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    MHD = 0x55,
+        #define GET_MHD_INFO 0x0
 };
 
 /* CCI Message Format CXL r3.0 Figure 7-19 */
@@ -184,6 +186,23 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
     return CXL_MBOX_INVALID_INPUT;
 }
 
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    if (cvc->mhd_get_info) {
+        return cvc->mhd_get_info(cmd, payload_in, len_in, payload_out,
+                                 len_out, cci);
+    }
+    return CXL_MBOX_UNSUPPORTED;
+}
+
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
                                          uint8_t *payload_out, size_t *len_out,
@@ -1598,6 +1617,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1fb3ffeca8..307d7c1fd8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2120,6 +2120,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
     cvc->set_cacheline = set_cacheline;
+    cvc->mhd_get_info = NULL;
     cvc->mhd_access_valid = NULL;
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 37893f8626..4a5d4bd98b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -508,6 +508,12 @@ struct CXLType3Class {
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 
     /* Multi-headed Device */
+    CXLRetCode (*mhd_get_info)(const struct cxl_cmd *cmd,
+                               uint8_t *payload_in,
+                               size_t len_in,
+                               uint8_t *payload_out,
+                               size_t *len_out,
+                               CXLCCI *cci);
     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
-- 
2.39.1

