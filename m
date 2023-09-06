Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABEEE14D0
	for <linux-cxl@archiver.kernel.org>; Wed,  6 Sep 2023 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbjIFXtH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIFXtG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Sep 2023 19:49:06 -0400
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E01739
        for <linux-cxl@vger.kernel.org>; Wed,  6 Sep 2023 16:49:02 -0700 (PDT)
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-58fc4eaa04fso4309197b3.0
        for <linux-cxl@vger.kernel.org>; Wed, 06 Sep 2023 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694044082; x=1694648882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgAxgcyqhu59qzleb8BoU1mSJXsud8avyAYb65wFNbg=;
        b=N1DoJ6oyN9R6yIk3DEC8jdr9h87/ubZJ9ISVAvV0uobWeFf3WSXBuR7YBfpjpwrucY
         D3GuDGNCMj16qSOtRRIQ+kxBsWT/cQCP/Td70UUiAwTkeKZhB+Ci2gbLLaqx8eKV6Xp2
         feKmajg2824fAE3kcFRoPGLMpoBtFA6nTV5I32XsMpyW/HGsji3GARIgReejels6Q1Ed
         6s7UGp/ltrvADNIdxthUPf4YMGPPtQH4P94YpLBRGHHXnQ/rOhKgUoeY8/lxmZTtltQj
         S/+ffSw/roYg8wyRKc+Za6jLic8CIys2mXw6NLM8YszSa/2uI+T43Nq16cO5h8zrcKXX
         d+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694044082; x=1694648882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgAxgcyqhu59qzleb8BoU1mSJXsud8avyAYb65wFNbg=;
        b=H3AIPtLdzQnP/UnzYdV1F03XGRkvL/sZ+pBRTGP3sb78OP1kQRIuPLmqvyQCMUg6ql
         2//DSbRbRD/LZIvHQDRQzfckUvHay2cG+UyQIeifazYlRg4/zvRd1hEvGv9wmdpuUOEd
         TQQc2uXFPQrhqifOU1nhMIjNB2crVxIm3bxGpyNWnKpxB8nw20ZgUa9oNXq5YvFmphfs
         9LYwk6zSwcsnJ9stkh2HD8AHdsvdeEzXgiC6iKnfqHVhOwYmGalg+2i3cCZX/Ejxu6ta
         GNKu4DhXhikSLBBdCxBhghYamF9JaaX10J3MaCSr1CffMS/IP2HQubxGmYK2SMbwM9eV
         EGMA==
X-Gm-Message-State: AOJu0YxGQpZQDnHLAl6WbZ9eiKy17Sm6euIqenS4BFYYqeLOAJbkHlL4
        JOG6bM5T875SO9ByA3lAQw==
X-Google-Smtp-Source: AGHT+IG7TM90ao+H0jLLHLoLY2F8QLdO3dNzNL314exMSR7c96TkW346HHyt7WL7ljuPYg3r1oEH6Q==
X-Received: by 2002:a81:8287:0:b0:57a:2e83:4daf with SMTP id s129-20020a818287000000b0057a2e834dafmr20616492ywf.32.1694044080372;
        Wed, 06 Sep 2023 16:48:00 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:48:00 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 1/6] cxl/mailbox: move mailbox effect definitions to a header
Date:   Tue,  5 Sep 2023 20:15:12 -0400
Message-Id: <20230906001517.324380-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Preparation for allowing devices to define their own CCI commands

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 30 +++++++++++++-----------------
 include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 17 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4e8651ebe2..b64bbdf45d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -12,6 +12,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "hw/cxl/cxl_mailbox.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
@@ -1561,28 +1562,21 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
-#define IMMEDIATE_DATA_CHANGE (1 << 2)
-#define IMMEDIATE_POLICY_CHANGE (1 << 3)
-#define IMMEDIATE_LOG_CHANGE (1 << 4)
-#define SECURITY_STATE_CHANGE (1 << 5)
-#define BACKGROUND_OPERATION (1 << 6)
-
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
-        cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
+        cmd_events_clear_records, ~0, CXL_MBOX_IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
                                       cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
                                       cmd_events_set_interrupt_policy,
-                                      ~0, IMMEDIATE_CONFIG_CHANGE },
+                                      ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
-                         IMMEDIATE_POLICY_CHANGE },
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
@@ -1591,9 +1585,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_ccls_get_partition_info, 0, 0 },
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
-        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
-        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_SECURITY_STATE_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -1612,10 +1608,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
         8, 0 },
     [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
         "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
     [DCD_CONFIG][RELEASE_DYN_CAP] = {
         "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
-        ~0, IMMEDIATE_DATA_CHANGE },
+        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
@@ -1628,7 +1624,7 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
      */
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
-                         IMMEDIATE_POLICY_CHANGE },
+                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -1670,7 +1666,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     /* Only one bg command at a time */
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         cci->bg.runtime > 0) {
         return CXL_MBOX_BUSY;
     }
@@ -1691,7 +1687,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     }
 
     ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
-    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
         ret == CXL_MBOX_BG_STARTED) {
         *bg_started = true;
     } else {
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
new file mode 100644
index 0000000000..beb048052e
--- /dev/null
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU CXL Mailbox
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_MAILBOX_H
+#define CXL_MAILBOX_H
+
+#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
+#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
+#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
+#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
+#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+
+#endif
-- 
2.39.1

