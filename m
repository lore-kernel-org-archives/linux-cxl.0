Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1BC001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjG1RiU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjG1Rhw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 13:37:52 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3743C05
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 10:37:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1121B5426DF;
        Fri, 28 Jul 2023 17:35:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 62DD5542BB0;
        Fri, 28 Jul 2023 17:35:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690565712; a=rsa-sha256;
        cv=none;
        b=4gHLFq2rhx60L9rZgv+NVxRDmZxWsUrkF3l3O01Qv5sMEDABwrVJA60Aogprnf+2ZmCqYt
        u9ptfvWUA0nngKFErnSiAdQXYNlg9tFS18HU0QHGQEfAA0kXQVCBHAyJ7e5lyTfoR7eC55
        k32kTO77z3SApyzWeP3cj3Vpt+t1qv3t5NLTHDtSnPSauKhgoKbSZS27nA1rRXqz5Mdo2h
        NHMP/47oF0HgzGDHhKQ3GSPNoGlaCXI/FH+NHDRe0EUNd0gCsQ4v/4wQFfiYssFhoLIVhx
        AlsSXu4DmL0KJpfJqH2zkwenLdYGuZD87aVVKI9fcIYh2xJU4XjVHkndKZW/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690565712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=egUh/RzvqHlVsktcaIvKzc/8yy4mw5om3XCKMf4RGwc=;
        b=A8mCASMqLbF9wQ3EXqfIZrtuMdrNhTB3Fbepw7KZyuX1kW7s2Xha8kq7xYgXfBxdqNj3Jv
        /qjK7o1ftEwXbKOUi6uR7qizUCwU2nqzAAV0pvFrF2F+ysnWCYuQCSM7qJRYxdO/D4VUv3
        dRMdH1TSSmrF3wqBLIjpPXYAWPnrFjNXpa2+XJZBcGINevKXTmZaM58xiMby1boD7jKFvP
        ETw0AvpAaPDRFOrki/3V5cK1xP3sAkuNmJwYbIBj9wYtvtMr6C2/3A1bR4y2tg8jssMovj
        gDl4UBu8OTtIiTpgypYzyWEqL93/35gZ4xpAwqOhg7pEDbZEMzHQveeo4a2LRQ==
ARC-Authentication-Results: i=1;
        rspamd-649dfb7d6-n22q4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Wipe: 33731c7f022bef61_1690565712827_3170413761
X-MC-Loop-Signature: 1690565712826:4217481304
X-MC-Ingress-Time: 1690565712826
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.253.200 (trex/6.9.1);
        Fri, 28 Jul 2023 17:35:12 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RCFC36GMCz59;
        Fri, 28 Jul 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690565712;
        bh=egUh/RzvqHlVsktcaIvKzc/8yy4mw5om3XCKMf4RGwc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=UegO0sZHLEaPR3U9Ak8BfKNc0vYU8OXdK2RUOrZhO8LRNDBtPQFHEXB7dcqWSA5GZ
         2axeo2nxvdIX1YI/UFhM5nKXlJXdxwZEzXOyKBrvyzQ1CCZfAUhoX9Ljm2Iys51vos
         vKJpeWS1og+6kqbRGGsEwFWbkshGUcABguSSGdsSSV5iWzVnOfx9s0MZ6STPCmwXGQ
         2nM30kA36ymlKWrChyswkbW/y82ZnE5TI4kmIkvkiytLOpqsQYCl4zGQDP9vi+jA1a
         Ur7DItNkbQnzWqGR9/BVrbB2hi1bmLZsWzrFoFsjU5GQa0eOwlFSWVU0Ntru94UmtQ
         OMNh8PAaMAbOg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] hw/cxl: Add the Get Supported Logs Sub-List cmd
Date:   Fri, 28 Jul 2023 09:57:05 -0700
Message-ID: <20230728165705.5889-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728165705.5889-1-dave@stgolabs.net>
References: <20230728165705.5889-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The spec is quite clear that system software should try using
this instead of the traditional GSL - albeit both qemu and driver
only have CEL. In addition make the already existing commands a
bit more generic for any addition of future logs.

As noted in the code, the spec is also not explicit about all
input scan range errors - for which qemu can return 0 entries but
still set the total number of entries available.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 101 ++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5152a83c6fdd..0110797b7b52 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -64,6 +64,7 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+        #define GET_SUPPORTED_SUBLIST  0x5
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -602,6 +603,11 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+enum {
+    CXL_LOGS_CEL,
+    CXL_MAX_SUPPORTED_LOGS,
+};
+
 /* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
 static const QemuUUID cel_uuid = {
     .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
@@ -616,20 +622,28 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
                                          size_t *len_out,
                                          CXLCCI *cci)
 {
+    uint16_t i;
     struct {
         uint16_t entries;
         uint8_t rsvd[6];
         struct {
             QemuUUID uuid;
             uint32_t size;
-        } log_entries[1];
+        } log_entries[CXL_MAX_SUPPORTED_LOGS];
     } QEMU_PACKED *supported_logs = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
 
-    supported_logs->entries = 1;
-    supported_logs->log_entries[0].uuid = cel_uuid;
-    supported_logs->log_entries[0].size = 4 * cci->cel_size;
-
+    supported_logs->entries = CXL_MAX_SUPPORTED_LOGS;
+    for (i = 0; i < CXL_MAX_SUPPORTED_LOGS; i++) { /* all */
+        switch (i) {
+        case CXL_LOGS_CEL:
+            supported_logs->log_entries[i].uuid = cel_uuid;
+            supported_logs->log_entries[i].size = 4 * cci->cel_size;
+            break;
+        default:
+            break;
+        }
+    }
     *len_out = sizeof(*supported_logs);
     return CXL_MBOX_SUCCESS;
 }
@@ -642,6 +656,8 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
                                    size_t *len_out,
                                    CXLCCI *cci)
 {
+    uint8_t i;
+    bool found = false;
     struct {
         QemuUUID uuid;
         uint32_t offset;
@@ -661,8 +677,15 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
-        return CXL_MBOX_UNSUPPORTED;
+    for (i = 0; i < CXL_MAX_SUPPORTED_LOGS; i++) { /* all */
+        if (i == CXL_LOGS_CEL &&
+            qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
+                found = true;
+                break;
+        }
+    }
+    if (!found) {
+         return CXL_MBOX_UNSUPPORTED;
     }
 
     /* Store off everything to local variables so we can wipe out the payload */
@@ -673,6 +696,66 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 8.2.9.5.6 */
+static CXLRetCode cmd_logs_get_supported_sublist(const struct cxl_cmd *cmd,
+                                                 uint8_t *payload_in,
+                                                 size_t len_in,
+                                                 uint8_t *payload_out,
+                                                 size_t *len_out,
+                                                 CXLCCI *cci)
+{
+    uint8_t i, entries, start;
+    struct inject_poison_pl {
+        uint8_t max_entries;
+        uint8_t start_idx;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint8_t entries;
+        uint8_t rsvd1;
+        uint16_t total_entries;
+        uint8_t start_idx;
+        uint8_t rsvd2[3];
+        struct {
+            QemuUUID uuid;
+            uint32_t size;
+        } log_entries[CXL_MAX_SUPPORTED_LOGS];
+    } QEMU_PACKED *supported_logs = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
+
+    if (in->max_entries < 1) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    /*
+     * XXX: Handle other bogus input by returning zero entries but
+     * setting the total_entries such that software user can
+     * get it right next time(?) CXL spec mentions nothing about
+     * handling this.
+     */
+    if (in->start_idx > CXL_MAX_SUPPORTED_LOGS - 1) {
+        start = 0;
+        entries = 0;
+    } else {
+        start = in->start_idx;
+        entries = MIN(CXL_MAX_SUPPORTED_LOGS - start, in->max_entries);
+    }
+    supported_logs->entries = entries;
+    supported_logs->total_entries = CXL_MAX_SUPPORTED_LOGS;
+    supported_logs->start_idx = start;
+    for (i = start; i < entries; i++) {
+        switch (i) {
+        case CXL_LOGS_CEL:
+            supported_logs->log_entries[i].uuid = cel_uuid;
+            supported_logs->log_entries[i].size = 4 * cci->cel_size;
+            break;
+        default:
+            break;
+        }
+    }
+
+    *len_out = sizeof(*supported_logs);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.5.1.1 */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1172,6 +1255,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [LOGS][GET_SUPPORTED_SUBLIST] = { "LOGS_GET_SUPPORTED_SUBLIST",
+                                      cmd_logs_get_supported_sublist, 0x02, 0 },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
@@ -1203,6 +1288,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [LOGS][GET_SUPPORTED_SUBLIST] = { "LOGS_GET_SUPPORTED_SUBLIST",
+                                      cmd_logs_get_supported_sublist, 0x02, 0 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = {"IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0x49 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
-- 
2.41.0

