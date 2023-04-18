Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08134C77B7E
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjDRRzO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjDRRzM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:55:12 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C5CC1B
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:55:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5AA5B3C0FAD;
        Tue, 18 Apr 2023 17:55:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DC3AF3C21F5;
        Tue, 18 Apr 2023 17:55:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840507; a=rsa-sha256;
        cv=none;
        b=Q/NIgeVVIZ+BRDJ6s+PqhEjfc/7ai+wUj8nA2q91FzhxiY0CaXncGpVM5kO0N7MavzcFZw
        78suI329t5JRhqfU6fJd8PjWGTVnw/uh12Dvl/1dxGXJf0NMjsCR5SbIMBJKZ3CVj1eikO
        N1+PKmzDNxY70ArF3IJVtpTNP9MyHLs8/XxUHE7lHAQqVNyPI/M+NbXXBJZHGob/VCWc0r
        Z0udfgnPtLpwqe/Orh+1BhcQ9+RWwaxR2griQUPiBy7b+Eszgrxbj452StzdM+JN+aU1G5
        rpSvwB1vuvXj5FypxvO1LnSS0O8d6srPohnRJAszXZl4NHq2/T6lujsMVmFZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=35KmwLYXlr2Dk0FAwKgQFfarggDjni7NtBBnP+Y5sSw=;
        b=DQEQO4zYnUKPkLirpL4kEl7zEBDPftGq5BNXrb9fyDekT5aBEJkcImZ/k6SOThbMcHcnQp
        SvOv8o8GKdrDL4dpMjZFxzmwx0WhoRmX7aXKANPgTAy6YdxlbZBFeYX9yJxk3KGNOf7T5h
        fr9Tx9ObK7f13IkwzN3KBe0/Uv8aelqzpCptdVnT5kzULwZgK2Vn28iW2AkSCO4L2WTm4h
        VwiD8OiygM7Vt9tmxWg3vNyI7jVEd0KJ0jVDzZCxOQP8RXnCrm5by19L1NeAdhIC8PDs4J
        W23c/ygcBtrxJicjGFQH6zKcKP5sMU/mgNKW7DVeYcdNLhxi3s/vq+c8nkU2Qg==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-xbcmw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Oafish: 7907daf4732ae619_1681840508179_1184193323
X-MC-Loop-Signature: 1681840508179:1813911708
X-MC-Ingress-Time: 1681840508179
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.193.179 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:08 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQf6fwZz2x;
        Tue, 18 Apr 2023 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840507;
        bh=35KmwLYXlr2Dk0FAwKgQFfarggDjni7NtBBnP+Y5sSw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=JzmSWpClOVxRLsYMQGvnzKYf7XRdC21vT/pZa++r9dIh7BweHnP164rObSxtrj0Kd
         iAure4Z0D7gxVN+EjXWjmLr0TDVAJIlNerpDRaVJyP6O5A2O7iWtRtbkH/xOsx4UoU
         3+fpZWFyC4dTP7/5ovT6pHmoQPqqwn7P2u1zqHpkRwdbMQosiMFekO7JdndYbAM7B0
         qj4LqsL+fGehYIpWf/kuSpnJKjhkCh/Aufox1n9U3Tvm3q58HSzoyepFzjpwk2e/pk
         2vDlYli6q3uBbggoBnZ6uoLx/qAENBIG/Z7rZtTDy60bSdMDYJTGx1HFyV5iCwoBLh
         gHW6OkooXlvDQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/5] hw/cxl: Add support for device sanitation
Date:   Tue, 18 Apr 2023 10:23:36 -0700
Message-Id: <20230418172337.19207-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418172337.19207-1-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Make use of the background operations through the sanitize
command, per CXL 3.0 specs. Traditionally run times can be
rather long, depending on the size of the media.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 125 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e0e20bc3a2bb..2808d0161a38 100644
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
+    SANITATION    = 0x44,
+        #define SANITIZE      0x0
+        #define SECURE_ERASE  0x1
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -819,6 +823,112 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 #define BACKGROUND_OPERATION (1 << 5)
 
+/* re-initialize the address space */
+static void __do_sanitization(CXLDeviceState *cxl_dstate)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    DeviceState *ds = DEVICE(ct3d);
+    char *name;
+    MemoryRegion *mr;
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!mr) {
+            return;
+        }
+        if (ds->id) {
+            name = g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->id);
+        } else {
+            name = g_strdup("cxl-type3-dpa-vmem-space");
+        }
+
+        address_space_destroy(&ct3d->hostvmem_as);
+        address_space_init(&ct3d->hostvmem_as, mr, name);
+        g_free(name);
+    }
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!mr) {
+            return;
+        }
+        if (ds->id) {
+            name = g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->id);
+        } else {
+            name = g_strdup("cxl-type3-dpa-pmem-space");
+        }
+
+        address_space_destroy(&ct3d->hostpmem_as);
+        address_space_init(&ct3d->hostpmem_as, mr, name);
+        g_free(name);
+    }
+}
+
+/*
+ * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
+ *
+ * Once the Sanitize command has started successfully, the device shall
+ * shall be placed in the media disabled state. If the command fails or
+ * is interrupted by a reset or power failure, it shall remain in the
+ * media disabled state until a successful Sanitize command has been
+ * completed.
+ */
+static CXLRetCode cmd_sanitation_sanitize(struct cxl_cmd *cmd,
+                                          CXLDeviceState *cxl_dstate,
+                                          uint16_t *len)
+{
+    unsigned int secs;
+    uint64_t total_mem; /* in Mb */
+    struct cxl_cmd *c;
+
+    *len = 0;
+
+    /* Reported in CEL */
+    c = &cxl_dstate->cxl_cmd_set[SANITATION][SANITIZE];
+    if (!(c->effect & BACKGROUND_OPERATION)) {
+        __do_sanitization(cxl_dstate);
+        return CXL_MBOX_SUCCESS;
+    }
+
+    /*
+     * Estimated times based on:
+     *     https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
+     */
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
+    /* sanitize when done */
+    cxl_dev_media_disable(cxl_dstate);
+    cxl_dstate->bg.runtime = secs * 1000UL;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
 static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
@@ -842,6 +952,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [SANITATION][SANITIZE] = { "SANITATION_SANITIZE", cmd_sanitation_sanitize,
+        0, IMMEDIATE_DATA_CHANGE | BACKGROUND_OPERATION },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
@@ -985,7 +1097,18 @@ static void bg_timercb(void *opaque)
 
         bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
 
-        /* TODO add ad-hoc cmd succesful completion handling */
+        /* ad-hoc cmd succesful completion handling */
+        if (ret == CXL_MBOX_SUCCESS) {
+            switch (cxl_dstate->bg.opcode) {
+            case 0x4400: /* sanitize */
+                __do_sanitization(cxl_dstate);
+                cxl_dev_media_enable(cxl_dstate);
+                break;
+            default:
+                __builtin_unreachable();
+                break;
+            }
+        }
     } else {
         /* estimate only */
         cxl_dstate->bg.complete_pct = 100 * now / total_time;
-- 
2.40.0

