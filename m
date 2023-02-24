Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8AAC7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBXTpE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBXTpD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:45:03 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3691EBF1
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:45:00 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0ECB7922134;
        Fri, 24 Feb 2023 19:45:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 80271921A4A;
        Fri, 24 Feb 2023 19:44:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677267899; a=rsa-sha256;
        cv=none;
        b=hQONZwvkUxJtdjQodN+KnM4smVkxumNOSrXf5ktgYOd0BPuFh4gaf4wN54Y2A4guLY+WCa
        p9Qg7umf7Pnj2rTAdTS0ZnRgAzWcL+YKVpJuWCrJaRRzNkteIGAcwGGvD5DlaIGQpQ9CMM
        KK1QD9+DgBMtWw4bxck+TVvrcdu4k7tAvzySv+MoclrQyNfAAuBX9eq/poZauabUnNQgTZ
        VVYGieKh5au3QmhXn8LpooktMzWJJTabg3T+ISfrnqvGnp56wcIrxG+nasAcXxOhszkE7A
        6Rlp8NF20z6pF352vU8tUwrH51WgMoCuFyi/Ap1+xFdm/374D6RQfK7qKnZ9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677267899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4jYSbd7KX24tHHYK5VIK7MYvqt3YDHpwXDgcJjgDjg8=;
        b=e87832d3qAMmhYgMziNP2+Jy4Uv4V/yUSeoYeTdsLmAdntaQqiBAByQVOVoqNVBM2V8Mbw
        3dxBRsIKkWNw/mLrpj6gT0WWr2fulkm0Q6XkfAdPqaIcnMwwvtof6ZYF4oJyavk7tdHQ4a
        AFFZc1JjpPPea0+ixJEM7bLQgzpEIwejVgV7TjMuGS4RshDRu+C8POvi8wTsXblYLm3XyR
        gbUyhHRrfrYdZ3+NxqKXMFReAw1dqcoVvyejVgPC8+UAwif1XdwMnVio6UbWHet7poP/tF
        uTGGVQMhWU7BJzTgok1V31LrNmvkI7sJq8NGW+OL0Ipd4qGZVqu9XAzEfYsAFA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-l9rxh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Interest: 328ddc1a593d27b2_1677267899893_1478116902
X-MC-Loop-Signature: 1677267899893:856376867
X-MC-Ingress-Time: 1677267899893
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.67 (trex/6.7.1);
        Fri, 24 Feb 2023 19:44:59 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgMt225MzMP;
        Fri, 24 Feb 2023 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677267899;
        bh=4jYSbd7KX24tHHYK5VIK7MYvqt3YDHpwXDgcJjgDjg8=;
        h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
        b=nkKIT0zb/PNTuyw/TzpfurjFKr4vG0vIakzrCDUULGI1QxH1fjcfaAOMUqdzJyzMb
         tBQgWi7Gzf7Hn69YZqe5De4qiONO/ZFcIRc/ogVLsWTuvmfXcPKLaIl2xotAvLwUaY
         ChywSSlXTv++T/87cQAcb/z6CJ9uTOxkXalYJvcZDeIMxRlmG92ciSYPHN++uNICa/
         pPA1juLmpd8xK9NzAuZv5nRAv1Slp48FQtQtz63NH/GB9oPgOyXh93OXM6G+fUdhTb
         qZx3cOjHDaWdLDyCxHhEAHgoKdxN10Eric0NEtojLspvgoFDhTPTQyru2ddE4z8QGP
         ICZfrO/v/bCEg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 3/3] cxl: Add support for device sanitation
Date:   Fri, 24 Feb 2023 11:44:43 -0800
Message-Id: <20230224194443.1990440-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194443.1990440-1-dave@stgolabs.net>
References: <20230224194443.1990440-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Make use of the background operations through the sanitize
command, per CXL 3.0 specs. Traditionally run times can be
rather long, depending on the size of the media.

Estimate times based on:
	 https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 139 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |   9 ++-
 include/hw/cxl/cxl_device.h |  17 +++++
 3 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 61f0b8d675bc..aa0641f786e2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
+#include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
@@ -71,6 +72,9 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -626,6 +630,109 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* Perform the actual device zeroing */
+static void __do_sanitization(CXLDeviceState *cxl_dstate)
+{
+    MemoryRegion *mr;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (mr) {
+            void *hostmem = memory_region_get_ram_ptr(mr);
+            memset(hostmem, 0, memory_region_size(mr));
+        }
+    }
+    if (ct3d->lsa) {
+        mr = host_memory_backend_get_memory(ct3d->lsa);
+        if (mr) {
+            void *lsa = memory_region_get_ram_ptr(mr);
+            memset(lsa, 0, memory_region_size(mr));
+        }
+    }
+}
+
+/*
+ * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len)
+{
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (cxl_dstate->vmem_size + cxl_dstate->pmem_size) >> 20;
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    /* EBUSY other bg cmds as of now */
+    cxl_dstate->bg.runtime = secs * 1000UL;
+    *len = 0;
+
+    qemu_log_mask(LOG_UNIMP,
+                  "Sanitize/overwrite command runtime for %ldMb media: %d seconds\n",
+                  total_mem, secs);
+
+    cxl_dev_disable_media(cxl_dstate);
+
+    if (secs > 2) {
+        /* sanitize when done */
+        return CXL_MBOX_BG_STARTED;
+    } else {
+        __do_sanitization(cxl_dstate);
+        cxl_dev_enable_media(cxl_dstate);
+
+        return CXL_MBOX_SUCCESS;
+    }
+}
+
 /*
  * This is very inefficient, but good enough for now!
  * Also the payload will always fit, so no need to handle the MORE flag and
@@ -843,6 +950,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite,
+        0, IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
@@ -898,6 +1007,21 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                     ret = CXL_MBOX_BUSY;
                     goto done;
             }
+            /* forbid any selected commands while overwriting */
+            if (sanitize_running(cxl_dstate)) {
+                if (h == cmd_events_get_records ||
+                    h == cmd_ccls_get_partition_info ||
+                    h == cmd_ccls_set_lsa ||
+                    h == cmd_ccls_get_lsa ||
+                    h == cmd_logs_get_log ||
+                    h == cmd_media_get_poison_list ||
+                    h == cmd_media_inject_poison ||
+                    h == cmd_media_clear_poison ||
+                    h == cmd_sanitize_overwrite) {
+                        ret = CXL_MBOX_MEDIA_DISABLED;
+                        goto done;
+                }
+            }
             ret = (*h)(cxl_cmd, cxl_dstate, &len);
             if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
                 ret == CXL_MBOX_BG_STARTED) {
@@ -970,8 +1094,19 @@ static void bg_timercb(void *opaque)
 
         bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
 
-        /* TODO add ad-hoc cmd succesful completion handling */
-
+        if (ret == CXL_MBOX_SUCCESS) {
+            switch (cxl_dstate->bg.opcode) {
+            case 0x4400: /* sanitize */
+                __do_sanitization(cxl_dstate);
+                cxl_dev_enable_media(cxl_dstate);
+                break;
+            case 0x4304: /* TODO: scan media */
+                break;
+            default:
+                __builtin_unreachable();
+                break;
+            }
+        }
         qemu_log("Background command %04xh finished: %s\n",
                  cxl_dstate->bg.opcode,
                  ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 334ce92f5e0f..2b483d3d8ea9 100644
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
@@ -988,6 +989,10 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (sanitize_running(&CXL_TYPE3(d)->cxl_dstate)) {
+        qemu_guest_getrandom_nofail(data, size);
+        return MEMTX_OK;
+    }
     return address_space_read(as, dpa_offset, attrs, data, size);
 }
 
@@ -1003,7 +1008,9 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
-
+    if (sanitize_running(&CXL_TYPE3(d)->cxl_dstate)) {
+        return MEMTX_OK;
+    }
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index f986651b6ead..e28536969397 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -346,6 +346,23 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
+{
+    uint64_t dev_status_reg;
+
+    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+}
+#define cxl_dev_disable_media(cxlds)                    \
+        do { __toggle_media((cxlds), 0x3); } while (0)
+#define cxl_dev_enable_media(cxlds)                     \
+        do { __toggle_media((cxlds), 0x1); } while (0)
+
+static inline bool sanitize_running(CXLDeviceState *cxl_dstate)
+{
+    return !!cxl_dstate->bg.runtime && cxl_dstate->bg.opcode == 0x4400;
+}
+
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
-- 
2.39.2

