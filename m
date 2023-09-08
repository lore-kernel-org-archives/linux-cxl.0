Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC8EE57CA
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 07:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjIHHhp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjIHHho (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 03:37:44 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE84C1990
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 00:37:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E5D2D941EF0;
        Fri,  8 Sep 2023 07:32:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7D5E99416C0;
        Fri,  8 Sep 2023 07:32:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694158320; a=rsa-sha256;
        cv=none;
        b=g+N/CnwwYdg5F0O/p4Qhzs9bOnvTsgaaha9jNZcpa2qAa5sbcYkaBVjHwPcX1p+X9EP3ZX
        LQeymLmO7S+igGsKLJ+AqM95SntdXC+5K9CPV/gDyzT8pAMX6vy0e3i2p9/24yTRJsYsSD
        097m6HBu/GrZ1WsKwJ9s9Qbex8enHa1zbNlmGzIkdNHdq96njvLppcSL+ndlUgu/Qp339Q
        8hIy9aHbcAARg8YLWzRgAVdJgJeE4dAvIhKv/PjfYpEkXxxa180RLSTFVQmw0WQaxz29wF
        UKhi1b/C5cnDyctaLh0FziTozrooJY1hyfjxTtKleAsSGDA7ruII9FabfXEevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694158320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=c/scOcTZ1AGoEQ01c+GK4Bh7FukkswskFUyAe11gBeA=;
        b=l9Vg+Pyqjc2k08+6Ta2vgz53dGqbJ76cMq8xB3kRN15I2v4jogqSbLEqwKtkjiqzWDSDvi
        G4S1FbdqUy3S85ZCULMldV+ApBAy9OlcQaPjy9EM8stp4ZuCljitf6L7+WUSymkFI+8xY2
        /mqnicZ9Wuw8nmxjohsgxCGZuWWfFYinkpKDicbvlxgD1HYgs4sKmFuHQV5wRH1cV5v47G
        KHwR1KI/0roG43e1lh5zMv5wichVQw9y8vN7QjCkk95HZUSozIUJVmq5Mr55SPBO8mMTrg
        o2HnNVvVSExR7SyvXJeyjhtgg2ttsJ1bFCOvhuFVUcGNSYi5wLqEYD0+QkDbvQ==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-q4xhs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Arch: 7c5e95421bdd4263_1694158320817_903237386
X-MC-Loop-Signature: 1694158320817:4293051867
X-MC-Ingress-Time: 1694158320817
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.184.243 (trex/6.9.1);
        Fri, 08 Sep 2023 07:32:00 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rhnqg5tGfzM9;
        Fri,  8 Sep 2023 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694158320;
        bh=c/scOcTZ1AGoEQ01c+GK4Bh7FukkswskFUyAe11gBeA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=StpmIelDpgdMLhL99RdFeK0+LTMN5+F8RFODtjCcvkbvFIeVi7oB7+2Ti9InahjPc
         e+EdJEQzBMzPk3lmzofQovJD1iJRRYYozybqa8pshijavcaNsEwlurv1bc0hApc99X
         HRctM6e59u+oyoykQPj8asK/BlH8yhXMDBJr0HFukVKPC/KJA6jQbIPjV4bPCTJ4kT
         YZOI4wjxUlHPIUJbVJNAAJR5xD3brjVLX9tP2oEIQS0t+rUXNVrD6wj5yoc6NuRw9G
         DyChzXS3usyc/OsXsthA9qxbO6yP8JGaKTtYFWHsWf+Ai6NKnACDZY9UivQF/3vMqD
         SIQFEkZjY0fog==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/4] hw/cxl: Add scan media cmd support
Date:   Fri,  8 Sep 2023 00:31:51 -0700
Message-ID: <20230908073152.4386-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908073152.4386-1-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement the poison list backup functionality by extending the
qmp poison injection interface to add chunks beyond the poison
limit and use it to recreate the poison list upon overflow.

To this end two new lists are added, bkp and results, which are
drained by moving elements from the backup to the results, which
are consumed by the respective get scan media results cmd.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 161 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c          |  22 +++--
 include/hw/cxl/cxl_device.h |   9 ++
 3 files changed, 178 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3073222060ab..399ac03962db 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,7 @@ enum {
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1037,6 +1038,10 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         out->flags = (1 << 1);
         stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
     }
+    if (scan_media_running(cci)) {
+        out->flags |= (1 << 2);
+    }
+
     stw_le_p(&out->count, record_count);
     *len_out = out_pl_len;
     return CXL_MBOX_SUCCESS;
@@ -1065,6 +1070,16 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
             return CXL_MBOX_SUCCESS;
         }
     }
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not adding to the list?
+         */
+        goto success;
+    }
 
     if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
         return CXL_MBOX_INJECT_POISON_LIMIT;
@@ -1080,6 +1095,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
@@ -1123,6 +1139,17 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
 
+    /*
+     * Freeze the list if there is an on-going scan media operation.
+     */
+    if (scan_media_running(cci)) {
+        /*
+         * XXX: Spec is ambiguous - is this case considered
+         * a successful return despite not removing from the list?
+         */
+        goto success;
+    }
+
     QLIST_FOREACH(ent, poison_list, node) {
         /*
          * Test for contained in entry. Simpler than general case
@@ -1133,7 +1160,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
         }
     }
     if (!ent) {
-        return CXL_MBOX_SUCCESS;
+        goto success;
     }
 
     QLIST_REMOVE(ent, node);
@@ -1170,6 +1197,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     }
     /* Any fragments have been added, free original entry */
     g_free(ent);
+success:
     *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
@@ -1225,6 +1253,124 @@ cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void __do_scan_media(CXLType3Dev *ct3d)
+{
+    CXLPoison *ent;
+    unsigned int results_cnt = 0;
+
+    QLIST_FOREACH(ent, &ct3d->scan_media_results, node) {
+        results_cnt++;
+    }
+
+    /* only scan media may clear the overflow */
+    if (ct3d->poison_list_overflowed &&
+        ct3d->poison_list_cnt == results_cnt) {
+        cxl_clear_poison_list_overflowed(ct3d);
+    }
+}
+
+/*
+ * CXL r3.0 section 8.2.9.8.4.5: Scan Media
+ */
+static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct scan_media_pl {
+        uint64_t pa;
+        uint64_t length;
+        uint8_t flags;
+    } QEMU_PACKED;
+
+    struct scan_media_pl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    uint64_t query_start;
+    uint64_t query_length;
+    CXLPoison *ent, *next;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+    if (ct3d->dc.num_regions && query_start + query_length >=
+            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (in->flags == 0) { /* TODO */
+        qemu_log_mask(LOG_UNIMP,
+                      "Scan Media Event Log is unsupported\n");
+    }
+
+    /* any previous results are discarded upon a new Scan Media */
+    QLIST_FOREACH_SAFE(ent, &ct3d->scan_media_results, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    /* kill the poison list - it will be recreated */
+    if (ct3d->poison_list_overflowed) {
+        QLIST_FOREACH_SAFE(ent, &ct3d->poison_list, node, next) {
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
+            ct3d->poison_list_cnt--;
+        }
+    }
+
+    /*
+     * Scan the backup list and move corresponding entries
+     * into the results list, updating the poison list
+     * when possible.
+     */
+    QLIST_FOREACH_SAFE(ent, &ct3d->poison_list_bkp, node, next) {
+        CXLPoison *res;
+
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+
+        /*
+         * If a Get Poison List cmd comes in while this
+         * scan is being done, it will see the new complete
+         * list, while setting the respective flag.
+         */
+        if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+            CXLPoison *p = g_new0(CXLPoison, 1);
+
+            p->start = ent->start;
+            p->length = ent->length;
+            p->type = ent->type;
+            QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+            ct3d->poison_list_cnt++;
+        }
+
+        res = g_new0(CXLPoison, 1);
+        res->start = ent->start;
+        res->length = ent->length;
+        res->type = ent->type;
+        QLIST_INSERT_HEAD(&ct3d->scan_media_results, res, node);
+
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    cci->bg.runtime = MAX(1, query_length * (0.0005L/64));
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
 /*
  * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
  */
@@ -1655,6 +1801,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
+    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
+        cmd_media_scan_media, 17, BACKGROUND_OPERATION },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
@@ -1783,16 +1931,15 @@ static void bg_timercb(void *opaque)
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
         if (ret == CXL_MBOX_SUCCESS) {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
             switch (cci->bg.opcode) {
             case 0x4400: /* sanitize */
-            {
-                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-
                 __do_sanitization(ct3d);
                 cxl_dev_enable_media(&ct3d->cxl_dstate);
-            }
-            break;
-            case 0x4304: /* TODO: scan media */
+                break;
+            case 0x4304: /* scan media */
+                __do_scan_media(ct3d);
                 break;
             default:
                 __builtin_unreachable();
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b90a7397d62f..aa9fdde1436e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1435,6 +1435,12 @@ void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
             cxl_device_get_timestamp(&ct3d->cxl_dstate);
 }
 
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
+{
+    ct3d->poison_list_overflowed = false;
+    ct3d->poison_list_overflow_ts = 0;
+}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
@@ -1470,18 +1476,20 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
         }
     }
 
-    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
-        cxl_set_poison_list_overflowed(ct3d);
-        return;
-    }
-
     p = g_new0(CXLPoison, 1);
     p->length = length;
     p->start = start;
     p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
 
-    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
-    ct3d->poison_list_cnt++;
+    if (ct3d->poison_list_cnt < CXL_POISON_LIST_LIMIT) {
+        QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+        ct3d->poison_list_cnt++;
+    } else {
+        if (!ct3d->poison_list_overflowed) {
+            cxl_set_poison_list_overflowed(ct3d);
+        }
+        QLIST_INSERT_HEAD(&ct3d->poison_list_bkp, p, node);
+    }
 }
 
 /* For uncorrectable errors include support for multiple header recording */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e824c5ade8a1..eb5c5284fa9f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -385,6 +385,11 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
+static inline bool scan_media_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+}
+
 static inline bool sanitize_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
@@ -476,6 +481,9 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+    /* Poison Injection - backup */
+    CXLPoisonList poison_list_bkp;
+    CXLPoisonList scan_media_results;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
@@ -538,6 +546,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
+void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d);
 
 CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
-- 
2.42.0

