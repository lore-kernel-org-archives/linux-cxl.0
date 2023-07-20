Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9CAEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGTUAT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGTUAS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:00:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE62711
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:00:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d75a77b69052e-403e7472b28so10187881cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883214; x=1690488014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc7pj30bTxLw0j0LdD/dx5vc6B2y0c1dIX3RAge2zGQ=;
        b=MhPtZfspe98Z5FjY84L2agwJW4mLahG43rZSzUxq9/nWL6guqXbe+lmjw3DzxvkSwT
         561IcwXMqbDraxXSEyz/tP8bhN+8Q+YHHIFI6lB9+CVAabQ0Z0Q4RQ/H2SxFGxAZMSxR
         oLOjA9/O/8N9OU/PhxmRBAKaQKRJDPjy4RYfQcJLexMYQ2vyOTpLOdGUSp7PWz13lAVp
         jmX67SXx+qrK+tW6ry5FkNmdOyTKRwNzHe24X69jA+hIBqK34Jc+JjvS5MRMECZxD/Ht
         DDGsdTywzRno8IFRy76lgmMe/KyyC33Dmep6YlRkYRIZBSx6/7yoO5QKb1RKxCGbufLg
         1REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883214; x=1690488014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc7pj30bTxLw0j0LdD/dx5vc6B2y0c1dIX3RAge2zGQ=;
        b=aBql++oxJDVBUMwnpUmp9dPFzljj/ci/3GyqGQRoxOKoJR8BwnkLLq6FRpoZUmdMjs
         9Z0h4NGylPRsrP2hzAnsYhzJLPKdfDSmXb6OMwUGHa/jqpA6XyQBUF+53G7d5G/nTDqu
         +FoK7QXOJe+aqOO5J09nCmuoswpHNmTLdHXMD6NPRrrlGrKCuxiobtVYI4NFqpsiAPjQ
         R7DgXezWXt9mO6oZSkI0Reb9yeKFFs1tMsCrUIKnkOt45xLGA7rXRNn9O5z6E3avU4uW
         OfaqU5wbhsn5uZChiqcmVlV+bfTOGAn/BBgShJunRgIEcuVW+W9n3kFGt0DXbruMHm8w
         /A9A==
X-Gm-Message-State: ABy/qLZqcZqo3x3ogGR2V9myVVOwr7syfMSW9GFJnY8NBREYTzC6X7u+
        P99n0yMnAvljEUk21G5XU4WBCNUy3hQp
X-Google-Smtp-Source: APBJJlEa3Gz7M8cibwn+2MsRuW/pbHQd2K77Ts4q6iKe+7yiwi/XqBkvyUtMyBfV+Vx/5FlwsbuUcA==
X-Received: by 2002:ac8:59c6:0:b0:404:c430:650b with SMTP id f6-20020ac859c6000000b00404c430650bmr88133qtf.33.1689883214087;
        Thu, 20 Jul 2023 13:00:14 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.13.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:00:13 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC 2/2] cxl/mailbox: interface to add CCI commands to an existing CCI
Date:   Thu, 20 Jul 2023 15:58:22 -0400
Message-Id: <20230720195819.17905-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230720195819.17905-1-gregory.price@memverge.com>
References: <20230720195819.17905-1-gregory.price@memverge.com>
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
 hw/cxl/cxl-mailbox-utils.c         |  19 +++++++++++++++++++
 include/hw/cxl/cxl_device.h        |   2 ++
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

