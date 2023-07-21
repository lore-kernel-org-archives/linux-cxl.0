Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF2EB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Jul 2023 16:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGUQjb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGUQjM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Jul 2023 12:39:12 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFC3AB2
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:33 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so2099160276.0
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689957442; x=1690562242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCxlxCkDucjgqyJyU3Oue/fnEXKDKF8PNCPD5OQGcak=;
        b=LE0skMiW+AIH9AdEitz+QvtO5F5y4hjqHyJvcZ7KFgRh5hyaU0jo/Ees0GFLiDwZLz
         jcZn/V5N9n8776veFXkpJDsdxbz5/6jVzNNRgCoJitOrGwsEwQ4mi6B28VUzVB1uTSq5
         P6sgKDqGeckcczMrYahoi4pCmZW75E5A815/hTXl5MPA/N6zYuAG1wnR3TC7phz+73fj
         IuonAC6i8JZsmIQrUDapUnnlxw7sWUK0htkLtRpd9vmHcnOaQ5t8kCvV5H2HyarTFwX/
         5L0TF+6Rw5IFcV6PhgaHyDEHvqaqlWIaahFw0vHBAvd/jyLgtI+XGjzxfUHIGEaYgIDB
         OC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957442; x=1690562242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCxlxCkDucjgqyJyU3Oue/fnEXKDKF8PNCPD5OQGcak=;
        b=Nan8+hv287M4t++fjkitvVo/FHsJuKNkmLMY6ftz4NubQsXfOM11YLSyhe/yfjrfY8
         He0gC34HpfhtNRoMkWSmtHqsyAwDIkD2Dr3u0h8iuZpsnOk7ucXRVxI5kIBq+VVlkdlJ
         vXPYOx4gwiHntb8XXs/H7M3E9B9PmUpc7SpsB5NNkdjHPv1IS3Cth+6KzCn4v2d23rAl
         i4OIheV80v/Z+yRaIYBKWIKEM+F/6Y+ALiDd9SRoe4YX9OeWM1NAdvjHNjyWncDyH3Uz
         QtghV4cGxsOb9sA6B5bovXXe1Cu0gJsBE3kuiZF1sTuYKDMLivtie69cR5mHCOyAjOw2
         TbxQ==
X-Gm-Message-State: ABy/qLYZNNmS8rY0e9zAbt4HaNFYk2+m67r0qE5gThMUem5cqjw2eyKR
        rwCCIPlaI4enusQpscHQbQ==
X-Google-Smtp-Source: APBJJlHgBiaBhLzzLKSQzU9vgX03UOlsab2e7R/fTJSNHBp76nl2F3xwc1GfSQ9hKOyTQtouaqaGFA==
X-Received: by 2002:a25:780e:0:b0:cfd:1ea:888e with SMTP id t14-20020a25780e000000b00cfd01ea888emr2116596ybc.60.1689957442377;
        Fri, 21 Jul 2023 09:37:22 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:37:22 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/4] cxl/mailbox: interface to add CCI commands to an existing CCI
Date:   Fri, 21 Jul 2023 12:35:06 -0400
Message-Id: <20230721163505.1910-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230721163505.1910-1-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++++
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ddee3f1718..cad0cd0adb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1383,6 +1383,25 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
     }
 }
 
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256], size_t payload_max)
+{
+    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmd_set[set][cmd].handler) {
+                const struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+                cci->cxl_cmd_set[set][cmd] = *c;
+                struct cel_log *log =
+                    &cci->cel_log[cci->cel_size];
+
+                log->opcode = (set << 8) | cmd;
+                log->effect = c->effect;
+                cci->cel_size++;
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
 {
     cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9a3c8b2dfa..abc8405cc5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
-- 
2.39.1

