Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCEEB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGTT7t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGTT7s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 15:59:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155D2118
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 12:59:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d75a77b69052e-40292285362so10173121cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883186; x=1690487986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVuZVz0OWzFFhOA5aHSeimJ6uxprk8dzRJn6x8ojC30=;
        b=llzTWYrPFpN+6xm9HTVBnQrzY6AAO1+67Fv7H7c5+2WeCzj6Ots4Du0JQh39i2yLMB
         B6dYQkGC67voHz1aOcDo/Ez0yYwwtLvxffCIRasYg/J2BFt9fFHz3Izjcwiq1ediCcbm
         kRBYwWJjWXal76fg9IYBhB9yhlbm8qGdjonknUY7B0J/hk0ihYxsyYekJL9fizfdttJW
         Ofl4cXBHdRzMNITUJ6sZEjJE2zuz/03Axr4uxxivMaOoEtCGg7s6017fHoLpLj31eRg9
         RXYq2NmSXj/57OhA2uUPUjiYkq2SzaEiMB1hZdkddvc8lubuWjPO1dlk03cLk40OFdKO
         9puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883186; x=1690487986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVuZVz0OWzFFhOA5aHSeimJ6uxprk8dzRJn6x8ojC30=;
        b=kbm9kssc2rxkNEWbX00R6yt9gdfMF6ageR/jfLVY96MWd5oRl59N5DJZr2/tQ1EYxO
         YnwzgmUQSz9+pojK9mtYh4J3BHhhWneR7rgqI5mzi63DlX1rtYVW9v+j1XZPM5VxfRta
         DBGEdYY3HPeOnjree3M9BDBoq/jRh1NVoWWY7DEOkXCzyVqVB/mndYZvk44U7HZCAcD8
         aZpu237fs3cgyjk3N2MMbXUO7Qp/p3/IXpga5m95iqpkSBYJC/6cj3pH5fI6yYHznuqR
         vWUSJJUFOVmFHIHx07deefuNjMWm+npdchIpCVxVmjaaG0WQBRvR/Rsg1sWPzgNcN4Ph
         9peg==
X-Gm-Message-State: ABy/qLbolFiyPlbwrpjBblkZUGMd6rj2huyXzb/Sm1bjBPv6QpHmJyvG
        Ps/b6LckyLQDe9yNCYpvFA==
X-Google-Smtp-Source: APBJJlFF7Fh7WwTG1b6+BcGwCCNZogSf0pEY/96T2g3/FqOSVWXBA+PH7/MyemFtT2z7W/3wO0VSnw==
X-Received: by 2002:a05:622a:7:b0:400:9896:b0fa with SMTP id x7-20020a05622a000700b004009896b0famr74617qtw.64.1689883186676;
        Thu, 20 Jul 2023 12:59:46 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:59:46 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC 1/2] cxl/mailbox: change CCI cmd set structure to be a member, not a refernce
Date:   Thu, 20 Jul 2023 15:58:20 -0400
Message-Id: <20230720195819.17905-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230720195819.17905-1-gregory.price@memverge.com>
References: <20230720195819.17905-1-gregory.price@memverge.com>
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
 hw/cxl/cxl-mailbox-utils.c         |  18 ++++++++++++++----
 include/hw/cxl/cxl_device.h        |   2 +-
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

