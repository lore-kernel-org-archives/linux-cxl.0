Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8DEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Jul 2023 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjGUQjN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGUQil (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Jul 2023 12:38:41 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE449CE
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:10 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-57764a6bf8cso24480797b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jul 2023 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689957424; x=1690562224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijmrvsQ+xZzl5dG2FfioPPf11zWI2IrXAZmlY53iqe8=;
        b=kBBkXWLAIposs8Vvw5ryzVTR1Y5pX6ZV7oyHb+pESXSHL7AchAD9QYsuxt1mDozKhL
         BFPUJ8WyAY6FL8Ukz3Z+d6DeeOmlNwskzdHr5QvoAeeJK3/NPUwV8NSmE13y+EZ9Uegh
         qG+t/aMvbf11Yr39J9dHsfQDJZEUbguWsc0fthH9ETQ4zEj39HfUM+jk1dfqd9a8SrWc
         AQoX2CN+jlF8vQPhRnn0cIBB3d8zApUzIZ6sivbJai8cOMGPtKX+Pd9Pr8kGtY3dPUz1
         05D7CTIYt5e6k1UPG0DvFEimHNVwyhimoaD+EUj39D+lLDBxSw/iCBajmnMbGxcYGQbn
         b7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957424; x=1690562224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijmrvsQ+xZzl5dG2FfioPPf11zWI2IrXAZmlY53iqe8=;
        b=WLpUjVPlFMbryS2mYaX1y7aKu3UTYUktV+GW3WMThy0ouVOgHC0iB1C2lfBdQqOgfC
         PpJa1NdDgg/pdpcP8vuDh7Zes1WxinZkDYPjVxWlM6he5A6x3BQvxPl3ZydGYFm4iR6p
         uAnCoWYSByWXmDxHk1+9s3KuvIeOJiUUQ7lq0tUes6n/M0gD+QxMCKTJ/f0bU6MhyNRR
         RnJApEgJOdFIPtycpki88Cfg9/HLUph1Ggu5r3fDUJvjShttSZjMY1bKViYbsk9OK4CG
         NtAffoNQTl0SwjN3GKJgwSTkRV3NX08LjmQtotigfxYNaxK5y7pgzi4gSXH29nbNYlRO
         tiZA==
X-Gm-Message-State: ABy/qLYqm1VtU2oFB6C0/Jz/2dUFzwbwWAIi+/rIS9NmPTRyX1DacbP5
        Qgypz6g4qdvNIgNTk3hdh0OztsOGNf8B
X-Google-Smtp-Source: APBJJlH7vPrqdLJ+4kAEg7wrCo+qdg3fckTPJsNsGcsEVRnLliRkT0tHqhNEr0Ra/nP60EGHAvE9aA==
X-Received: by 2002:a25:d003:0:b0:cec:821a:e20b with SMTP id h3-20020a25d003000000b00cec821ae20bmr2141726ybg.2.1689957424576;
        Fri, 21 Jul 2023 09:37:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:37:04 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/4] cxl/mailbox: change CCI cmd set structure to be a member, not a refernce
Date:   Fri, 21 Jul 2023 12:35:04 -0400
Message-Id: <20230721163505.1910-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230721163505.1910-1-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This allows devices to have fully customized CCIs, along with complex
devices where wrapper devices can override or add additional CCI
commands without having to replicate full command structures or
pollute a base device with every command that might ever be used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 18 ++++++++++++++----
 include/hw/cxl/cxl_device.h |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2819914e8d..ddee3f1718 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1373,9 +1373,19 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
                                  bg_timercb, cci);
 }
 
+static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256]) {
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmds[set][cmd].handler) {
+                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1383,7 +1393,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
     cci->d = d;
  
     /* No separation for PCI MB as protocol handled in PCI device */
@@ -1398,7 +1408,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
 void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1414,7 +1424,7 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_usp_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c68981b618..9a3c8b2dfa 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -163,7 +163,7 @@ typedef struct CXLEventLog {
 } CXLEventLog;
 
 typedef struct CXLCCI {
-    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
         uint16_t opcode;
         uint16_t effect;
-- 
2.39.1

