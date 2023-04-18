Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D264C77B78
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjDRRzN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDRRzM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:55:12 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42175198E
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:55:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4E6C020299B;
        Tue, 18 Apr 2023 17:55:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CD937201326;
        Tue, 18 Apr 2023 17:55:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840506; a=rsa-sha256;
        cv=none;
        b=s45ZVf/zuVh57Pqh8+FmpLUkCteQ9VgBUdOAVmorThICx1L8UWSzbA+neo/7L/wRdp/IiK
        obok2GBcnSgkCuUo2QHRJyRpjAHsfGAsSpnm0eiqFjwib0k3D+08ye61LTY5sGMrjAV1UC
        K+3tfNntZedtvpAJcsz7+ltRr1I69WEZW5idOEwrvpw11hqg+w7V5awCbdXaXW9SZ2aaoe
        ApQY//qI2sfjMn+fRDKCPUZYhIqeXM/iv32+sq0Xe8jdDrt1pNCc3Uq9wfKyJdDZIm8Xjc
        wMuCsb+cCLBR1MjiNzFR4MMcUasErBFkrx1YXh+gDN1+45uUYNjmVP1jqMgSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=L5+BPO3KJybMlN+XQEIg8dSrDJJ0T5WcTPZcOOyBYug=;
        b=1vGA7tXP494xj/QzuJ7jxKH7v0KDpjw3dFrBJv1rCcBJcI62doH8XxGtzz3rE891PIivbE
        wzaM+LRawmqyRVbmUph9HpIKUiaOFFkh8wHTDUDP8GCHfW5C9bKl2qKq5JbPH2w2g66J0i
        O75p8t9P+zp1qrklhfTVY50T7gaGKBkIfdKMTSHNU7Ia+hZGxG5ZJR/PFWd97nNw1cJFwU
        J0eR+ghgoer56XubDiTJX8BqTAnoEpSudvmleOalevBbSLFK50uoPl7relpPrUcBQG8l4R
        wQF3ETrKFRYVHNjGVckHG93PIt8373l05KlG3NJgeVtBe18TaCLFr/L/GUZUTw==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-qlpbm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Callous: 6fba04ed06a60d82_1681840507143_3062619259
X-MC-Loop-Signature: 1681840507143:604960009
X-MC-Ingress-Time: 1681840507143
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.222 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQf1KRTzFG;
        Tue, 18 Apr 2023 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840506;
        bh=L5+BPO3KJybMlN+XQEIg8dSrDJJ0T5WcTPZcOOyBYug=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=OzBjm5jXr+eHsrl8qWeM16VLX6BJ0qEz58qAkVNbLaH7DWR6lWLrpqEBHQWn1aKHd
         eD5c9yYJUxaeaRWuMObJnXNylKbBBj++1Nz66Ym6mZQgJKdUEseIkjamup4kZHljP+
         iTOnjdbBdBQdKy8nef919q+4VjS6nRWjIuqGcrdcdtlNEvBPKujEFzTTCBfE75a6Mv
         9o7Nn+rPjKR7R6OreA8CLfWjfiXm4xP09p7+6ZFJJ8fTVLqTlAc3Oi56uzwy5kFqyT
         z3YXIgAQnD9G48vFVs7XxM3srVOMr9dID7vAbMtYqjCIfGldQR+F82ESuZZWI/PCbw
         gGRoDv9IHJHRQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/5] cxl/device: Handle Media Disabled state
Date:   Tue, 18 Apr 2023 10:23:35 -0700
Message-Id: <20230418172337.19207-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418172337.19207-1-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ensure that both memory device read/writes and mailbox commands
can deal with the device media being disabled - per CXL 3.0 specs
8.2.9.8.5.1 - Sanitize. Disabled semantics here are strictly 11b,
however noting that if the media is not in the ready state (01b),
user data is not accessible.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 15 +++++++++++++++
 hw/mem/cxl_type3.c          | 10 ++++++++++
 include/hw/cxl/cxl_device.h | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 224bfdb4bfca..e0e20bc3a2bb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -891,6 +891,21 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
             cxl_cmd->payload = cxl_dstate->mbox_reg_state +
                 A_CXL_DEV_CMD_PAYLOAD;
+
+            if (cxl_dev_media_disabled(cxl_dstate)) {
+                if (h == cmd_events_get_records ||
+                    h == cmd_logs_get_log ||
+                    h == cmd_ccls_get_partition_info ||
+                    h == cmd_ccls_get_lsa ||
+                    h == cmd_ccls_set_lsa ||
+                    h == cmd_media_get_poison_list ||
+                    h == cmd_media_inject_poison ||
+                    h == cmd_media_clear_poison) {
+                        ret = CXL_MBOX_MEDIA_DISABLED;
+                        goto done;
+                }
+            }
+
             /* Only one bg command at a time */
             if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
                 cxl_dstate->bg.runtime > 0) {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 801f72c5fcae..707bdc263f03 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -12,6 +12,7 @@
 #include "qemu/pmem.h"
 #include "qemu/range.h"
 #include "qemu/rcu.h"
+#include "qemu/guest-random.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "hw/cxl/cxl.h"
@@ -989,6 +990,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
     if (res) {
         return MEMTX_ERROR;
     }
+    /* all memory reads will return random values */
+    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
+        qemu_guest_getrandom_nofail(data, size);
+        return MEMTX_OK;
+    }
 
     return address_space_read(as, dpa_offset, attrs, data, size);
 }
@@ -1005,6 +1011,10 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+    /* memory writes to the device will have no effect */
+    if (cxl_dev_media_disabled(&CXL_TYPE3(d)->cxl_dstate)) {
+        return MEMTX_OK;
+    }
 
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index f986651b6ead..3ef7a7cded95 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -346,6 +346,39 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+static inline void cxl_dev_media_toggle(CXLDeviceState *cxl_dstate, int val)
+{
+    uint64_t reg;
+
+    reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
+    if (FIELD_EX64(reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == val) {
+        return;
+    }
+
+    reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    reg = FIELD_DP64(reg, CXL_MEM_DEV_STS, MBOX_READY, 0x1);
+
+    stq_le_p(&cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS, reg);
+}
+
+static inline void cxl_dev_media_enable(CXLDeviceState *cxl_dstate)
+{
+    cxl_dev_media_toggle(cxl_dstate, 0x1);
+}
+
+static inline void cxl_dev_media_disable(CXLDeviceState *cxl_dstate)
+{
+    cxl_dev_media_toggle(cxl_dstate, 0x3);
+}
+
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
+{
+    uint64_t reg;
+
+    reg = ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS);
+    return unlikely(FIELD_EX64(reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3);
+}
+
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
-- 
2.40.0

