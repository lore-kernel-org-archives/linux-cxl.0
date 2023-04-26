Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE490C7EE22
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 02:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjDZCqO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 22:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjDZCqL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 22:46:11 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64831E4E
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 19:46:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AAC1214209B;
        Wed, 26 Apr 2023 02:46:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2484414210F;
        Wed, 26 Apr 2023 02:46:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682477168; a=rsa-sha256;
        cv=none;
        b=L+Yz/lqkY136DmXD1m4H+mgzGH93ujZS30k42QXSQPeRU6Y+b+q+v3vhXCIxqrl4clQy5r
        KjDwaF0SX2598ZCm4DWIcudl1ph3aG365Bq3TqqwdUVxZTS89ktWwUUWTgt3Xju+c1OzwT
        J2JF9EmNDQOL3/Z7jX4ta990Kl9EZWCqMqLTjxdhrb9vSGW6HN3dY78F5DptlMSSI8F/eO
        Adh8uDyVelpxyrLJ8urnxWn15tuF8XeuuIUzscfKrwomCDUaS9KDT4W0FYDt22y8Ojif1Y
        lHtePhf5JDJ1XV42x9ShQEMTeARf27S/0+KZPxgfOC2pwu9JJaU+RnCwcKeTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682477168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Mo5Jn/1gaGS61VTLzTNXj3Xkfua0BqkOYJZiyRfUnnU=;
        b=hdm1mx6S502LgalNehdQqeZggLsA5M9jfZcnDap8NV7MkHJhNzQzf4ZAjFdjTePsAhT9zh
        qSNNL7nmXtKGyNMj39NJ672mRCu/a7iTJ5Ir2HCOOB5jbaB7T+Ps4Std+ite1fYHnGNhEn
        ROfU1bInQFfK/Ic+Xlw9LnuqABrGdLynVxEn9G42xjVFIJWiTlT+rSGaB2rNsso7pPUpCg
        S5fHp1/9z6U5lsceYy8JmmddCqOciB1pVA1Fj3rLgu98aEkAKhZGMs0+ihZjW0wfGKiYPH
        MDnTqOcbJkcjHsXysL9vm4vnU7f9n0a4QfOCHn9swqBGjPQ+BpJSWDFj+UD7Mg==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-cprm2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Squirrel: 55846071328113bf_1682477168457_4066903198
X-MC-Loop-Signature: 1682477168457:11221307
X-MC-Ingress-Time: 1682477168456
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.20 (trex/6.7.2);
        Wed, 26 Apr 2023 02:46:08 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5jt72zcrz9s;
        Tue, 25 Apr 2023 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682477167;
        bh=Mo5Jn/1gaGS61VTLzTNXj3Xkfua0BqkOYJZiyRfUnnU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=F2JuKiT6P3Iad5qepODOqo4W/Df6gHQhDIVniGb0jSTCmaK69P4oWMYlI7fcUs1ix
         coeSly9wix9mYun2aKngHc/vS6xsZ7h1G474Nefcrn+PabW4Et7wIERcTpe7XSNMAv
         uvm5cqPFbYywIOEvoDESnelvK1bheehZ9CYnnfMPARSwjiNYNQQIC5zf/4Zw4NXCAh
         658Dq7gagYOD4DLRAZFVfSUSwlu/TlUOgS2RoqkTKU8oJcI3ZSzPSbTRlVTMgVB86j
         jUqOLgSFYWu3BsG7EkDBI1vysmDeUr72p8gQlvydIXji0mXvriIwY4aafgD5Hz98C/
         IyQ5aqYwzcZiQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     alison.schofield@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] hw/cxl: Add scan media mailbox command support
Date:   Tue, 25 Apr 2023 19:14:17 -0700
Message-Id: <20230426021418.10186-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426021418.10186-1-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Trigger the background command and when done go about adding
entries to the poison list, or not. Randonly decide how many
random addresses to generate.

Currently never udpate DRAM Event Log.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 127 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |   3 +
 include/hw/cxl/cxl_device.h |   8 +++
 3 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f346aa8ce3b2..7f29b840a2c9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -80,6 +80,7 @@ enum {
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -852,6 +853,9 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+    if (scan_media_running(cxl_dstate)) {
+        ct3d->poison_list_dirty = true;
+    }
 
     return CXL_MBOX_SUCCESS;
 }
@@ -932,6 +936,10 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     /* Any fragments have been added, free original entry */
     g_free(ent);
 
+    if (scan_media_running(cxl_dstate)) {
+        ct3d->poison_list_dirty = true;
+    }
+
     return CXL_MBOX_SUCCESS;
 }
 
@@ -974,6 +982,103 @@ cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void __do_scan_media(CXLDeviceState *cxl_dstate)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent, *p;
+    uint64_t dpa = 0;
+    int n_dpas;
+    GRand *rand;
+
+    rand = g_rand_new();
+
+    /* how many dpas to "detect" and add to the poison list */
+    n_dpas = g_random_int_range(0, CXL_MBOX_INJECT_POISON_LIMIT/4);
+
+    do {
+        /*
+         * TODO: limit it within the device dpa space (same for
+         * inject poison). For now generate some random address.
+         */
+    retry_dpa:
+        dpa = (uint64_t)g_rand_int(rand) << 32 |(uint64_t)g_rand_int(rand);
+        /* 64 byte alignment required */
+        if (dpa & 0x3f) {
+            goto retry_dpa;
+        }
+
+        QLIST_FOREACH(ent, poison_list, node) {
+            if (dpa >= ent->start &&
+                dpa + 64 <= ent->start + ent->length) {
+                goto retry_dpa;
+            }
+        }
+
+        p = g_new0(CXLPoison, 1);
+
+        p->length = 64;
+        p->start = dpa;
+        p->type = CXL_POISON_TYPE_SCANMEDIA;
+
+        QLIST_INSERT_HEAD(poison_list, p, node);
+        ct3d->poison_list_cnt++;
+    } while (--n_dpas);
+
+    g_rand_free(rand);
+}
+
+static CXLRetCode
+cmd_media_scan_media(struct cxl_cmd *cmd,
+                     CXLDeviceState *cxl_dstate, uint16_t *len)
+{
+    struct scan_media_pl {
+        uint64_t pa;
+        uint64_t length;
+        uint8_t flags;
+    } QEMU_PACKED;
+    struct scan_media_pl *in = (void *)cmd->payload;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    uint64_t query_start;
+    uint64_t query_length;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * 64;
+
+    /*
+     * TODO: Any previous Scan Media results are discarded by
+     * the device upon receiving a new Scan Media command.
+     */
+
+    /*
+     * The host should use this command only if the poison list
+     * has overflowed and is no longer a complete list of the
+     * memory errors that exist on the media.
+     */
+    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+        ct3d->poison_list_cnt = 0;
+    }
+
+    if (query_start + query_length > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (in->flags == 0) { /* TODO */
+        qemu_log_mask(LOG_UNIMP,
+                      "Scan Media Event Log is unsupported\n");
+    }
+
+    cxl_dstate->bg.runtime = MAX(1, query_length * (0.0005L/64));
+    ct3d->poison_list_dirty = false;
+
+    *len = 0;
+    return CXL_MBOX_BG_STARTED;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1014,7 +1119,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
-
+    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
+        cmd_media_scan_media, 17, 0 },
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
@@ -1048,7 +1154,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     opcode_handler h;
     uint8_t bg_started = 0;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
-
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
     uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
@@ -1064,6 +1170,20 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                     ret = CXL_MBOX_BUSY;
                     goto done;
             }
+
+            /*
+             * If the device updates its Poison List while the
+             * Scan Media operation is executing, the device
+             * shall indicate that a media scan is in progress
+             * if Get Poison List is called during the scan.
+             */
+            if (ct3d->poison_list_dirty) {
+                if (h == cmd_media_get_poison_list) {
+                    ret = CXL_MBOX_BUSY;
+                    goto done;
+                }
+            }
+
             /* forbid any selected commands while overwriting */
             if (sanitize_running(cxl_dstate)) {
                 if (h == cmd_events_get_records ||
@@ -1157,7 +1277,8 @@ static void bg_timercb(void *opaque)
                 __do_sanitization(cxl_dstate);
                 cxl_dev_enable_media(cxl_dstate);
                 break;
-            case 0x4304: /* TODO: scan media */
+            case 0x4304: /* scan media */
+                __do_scan_media(cxl_dstate);
                 break;
             default:
                 __builtin_unreachable();
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e63dbd83551..0bc017061f30 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1213,6 +1213,9 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
 
     QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
     ct3d->poison_list_cnt++;
+    if (scan_media_running(&ct3d->cxl_dstate)) {
+        ct3d->poison_list_dirty = true;
+    }
 }
 
 /* For uncorrectable errors include support for multiple header recording */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba884..8db63c1f7cd1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -376,12 +376,18 @@ typedef struct CXLPoison {
 #define CXL_POISON_TYPE_EXTERNAL 0x1
 #define CXL_POISON_TYPE_INTERNAL 0x2
 #define CXL_POISON_TYPE_INJECTED 0x3
+#define CXL_POISON_TYPE_SCANMEDIA 0x4
     QLIST_ENTRY(CXLPoison) node;
 } CXLPoison;
 
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+static inline bool scan_media_running(CXLDeviceState *cxl_dstate)
+{
+    return cxl_dstate->bg.runtime && cxl_dstate->bg.opcode == 0x4304;
+}
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -413,6 +419,8 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+    /* list modified while doing scan media */
+    bool poison_list_dirty;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.40.0

